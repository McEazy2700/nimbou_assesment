// import type { HttpContext } from '@adonisjs/core/http'
import type { HttpContext } from '@adonisjs/core/http'
import hash from '@adonisjs/core/services/hash'
import User from '#models/user'
import vine from '@vinejs/vine'

export default class AuthController {
  public async register({ request, response }: HttpContext) {
    const validator = vine.compile(
      vine.object({
        username: vine.string(),
        email: vine.string().email(),
        password: vine.string().minLength(8),
      })
    )

    const validatedData = await validator.validate(request.body())

    const existingUser = await User.query()
      .where('email', validatedData.email)
      .orWhere('username', validatedData.username)
      .first()

    if (existingUser) {
      return response.conflict('Email or username already taken')
    }
    const user = await User.create(validatedData)

    return response.created(user)
  }

  public async login({ request, response }: HttpContext) {
    const { email, password } = request.only(['email', 'password'])

    try {
      const user = await User.findBy('email', email)

      if (!user) {
        return response.abort('Invalid credentials')
      }

      const passwordValid = await hash.verify(user.password, password)

      if (!passwordValid) {
        return response.abort('Invalid credentials')
      }

      const token = await User.accessTokens.create(user)

      return response.json({
        token: token.value,
        user: user?.username,
        walletAddress: user?.walletAddress,
      })
    } catch {
      return response.status(400).json({ message: 'Invalid credentials' })
    }
  }
}
