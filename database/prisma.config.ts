import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient({
    log: ['query', 'info', 'warn', 'error'],
    // uncomment the following line in case you want to log all queries
    // log: ['query', { emit: 'event', level: 'info' }],
})


export default prisma