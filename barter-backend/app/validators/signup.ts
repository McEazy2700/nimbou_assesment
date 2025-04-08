import vine from '@vinejs/vine'

/**
 * Validates user signup
 */
export const signUpValidator = vine.compile(
  vine.object({
    username: vine.string().trim(),
    email: vine.string().trim(),
    walletAddress: vine.string().trim(),
  })
)
