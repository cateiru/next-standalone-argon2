import argon2 from 'argon2'
import type { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<string>
) {
  const hashed = await argon2.hash("password")

  res.send(hashed)
}
