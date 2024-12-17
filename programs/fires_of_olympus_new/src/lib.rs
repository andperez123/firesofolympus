use anchor_lang::prelude::*;

declare_id!("7qf1x9SLLgeD9pHwkR7tnLNMD7zPmhESR3jAzTFKN7um");

#[program]
pub mod fires_of_olympus {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        msg!("Greetings from: {:?}", ctx.program_id);
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
