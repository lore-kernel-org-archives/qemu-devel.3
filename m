Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB345F013FA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Fi9-00050s-Nt; Mon, 16 Mar 2026 17:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1w2Fi6-0004zK-3v; Mon, 16 Mar 2026 17:42:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1w2Fi3-0000qo-Ev; Mon, 16 Mar 2026 17:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XkhjjJIn8U15IzwcTLSzaqOrsFVk+OUsh7z49bkZtKc=; b=q2dK4H8igOYb0n8KaG15Dsz02g
 mT+m9l/cNh4sp4NdVWZdtXBScHJc/C1fru+jHVXP7k/WZ1oEVUrgjYY1ZZfkaetm7HMV3Y2CBKBjU
 fVrZwiOP+ATH612/7pnXCJ9eSQYkdyYbJWNs94a73AQSeN2s2hDkkqcGbsEvbx3BO9J2EqHn324CS
 FXwBSDvJ2Pi508RygcaRVcR8HSVBdAhrx2T6afr+U9Nunm/kt17FlX+cHNDfxh86kO6mQ3Q31vhtR
 ZYx75OjoC9uo8qDZ9p+WkvzMsIlFJJXR9zANpnpO6FFvL7Yyz3OzXWrVIPatlcP1hZUfBfgPPMcCX
 bKyfYw31sx+D7EeYqTIfNjdgYaCzMDEe30dbSBLe3RjJrjRB+GnohqrLhXsTiPqS/EYhg5l5S9+vs
 JFB0uITX5HzrccfMZEO9goGG1GjDrr890etcdR20/Fb0bw2dfoUtYGdsGc/K27hBSBwPgFaUcnLct
 qlcpEeFcsDgYyANXzf+rhGtdbLN7UIUua5Xj1LE5EMHb7xz6upaZA8SpbAfZ7Ohr63eUceazA1/GE
 9myRO6/vs0BV9lTy5EpP9x0DoRGkU+RsxPcv4wU6BeG0fh98VFkvTrcC66BODsz1xIGSVcSZ5Kx1F
 Vtkqip710GDSXY/mCQZj65SEGINWOjCjlefLtfl78=;
Received: from [2a02:8012:2f01:0:2257:6c08:3a5:8e25]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1w2Ff2-00046z-0H; Mon, 16 Mar 2026 21:39:40 +0000
Message-ID: <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
Date: Mon, 16 Mar 2026 21:42:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-stable@nongnu.org
References: <20260313170938.449538-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260313170938.449538-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:2257:6c08:3a5:8e25
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/03/2026 17:09, Peter Maydell wrote:

> In the SPARC CPU state, env->regwptr points into the env->regbase
> array at wherever the architectural CWP (current window pointer) says
> we are in the register windows.  We don't migrate this directly,
> since it's a host pointer, so we must ensure it is set up again
> after migration load.
> 
> We also have to deal with a special case when CWP is (nwindows - 1).
> In this case, while running we keep the "in" register data for this
> window in a temporary location at the end of the regbase[] array, so
> that generated code doesn't have to special case this "wrap around"
> case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> wrapped data from its temporary location into the architectural
> location in window 0's "out" registers.  We then migrate only
> (nwindows * 16) entries in the regbase[] array.  So on the
> destination we need to copy the "in" register data back to its
> temporary location again.
> 
> For 32-bit SPARC we get this right, because the CWP is in the PSR.
> The get_psr() function does:
>      env->cwp = 0;
>      cpu_put_psr_raw(env, val);
> which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> sets up both regwptr and the wrapped-register data.
> 
> However, for 64-bit SPARC the CWP is not in the PSR, and
> cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> register state in a corrupted state, and the guest will likely crash
> on the destination if it didn't happen to be executing with CWP == 0.
> 
> Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
> for the 64-bit case, and enough commentary to explain what is going
> on.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I ran into this because the "sparc64-migration" functional test seems
> to hit this reliably when built with the address sanitizer.  This is
> probably a timing thing, because it doesn't trip any ASAN failures,
> the guest just crashes on the destination side most of the time
> because it returns from a subroutine to a corrupt %o7 return address.
> 
> As far as I can tell this is what the problem is, but I'm a bit
> surprised that we have never hit this, given how likely you are to
> hit it on a vmsave/vmload or migration.  So am I missing something?
> ---
>   target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 4dd75aff74..b935c31630 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
>       SPARCCPU *cpu = opaque;
>       CPUSPARCState *env = &cpu->env;
>   
> -    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
> -     * window as the outs of the first window
> +    /*
> +     * If env->cwp == env->nwindows - 1, this will set the ins of the last
> +     * window as the outs of the first window. We do this because we only
> +     * transfer the (nwindows * 16) entries of regbase[] that correspond
> +     * to the "proper" locations of the registers; this call has the
> +     * effect of copying the wrap register values from their temporary
> +     * location down to their proper location ready for migration.
>        */
>       cpu_set_cwp(env, env->cwp);
>   
>       return 0;
>   }
>   
> +static int cpu_post_load(void *opaque, int version_id)
> +{
> +    /*
> +     * For 32-bit SPARC we set the register window data structures
> +     * up again correctly when get_psr() called cpu_put_psr_raw(),
> +     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
> +     * part of the PSR, so we need to handle it here.
> +     *
> +     * There are two things we need to have happen:
> +     * 1. regwptr points into regbase[] at the location determined by CWP.
> +     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
> +     *    in a copy at a temporary location at the end of the regbase[]
> +     *    array. For migration we only transferred the (nwindows * 16)
> +     *    entries of regbase[] that correspond to the "proper" locations
> +     *    of the registers, so now we must copy the wrap registers back to
> +     *    their temporary location.
> +     *
> +     * We achieve both of these by setting env->cwp to 0 and then calling
> +     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
> +     */
> +#if defined(TARGET_SPARC64)
> +    SPARCCPU *cpu = opaque;
> +    CPUSPARCState *env = &cpu->env;
> +    uint32_t cwp = env->cwp;
> +
> +    env->cwp = 0;
> +    cpu_set_cwp(env, cwp);
> +#endif
> +    return 0;
> +}
> +
>   /* 32-bit SPARC retains migration compatibility with older versions
>    * of QEMU; 64-bit SPARC has had a migration break since then, so the
>    * versions are different.
> @@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
>       .version_id = SPARC_VMSTATE_VER,
>       .minimum_version_id = SPARC_VMSTATE_VER,
>       .pre_save = cpu_pre_save,
> +    .post_load = cpu_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
>           VMSTATE_UINT32(env.nwindows, SPARCCPU),

Nice analysis! I suspect the reason this doesn't always show up is because any 
context switch (e.g. OpenBIOS, kernel to user, 32-bit to 64-bit etc.) will flush the 
entire register window set to the stack, and hence reset env->cwp back to 0.

It does instinctively feel odd that 32-bit and 64-bit aren't handled in the same way 
- I wonder if this implicit behaviour on 32-bit somehow needs to be more explicit?


ATB,

Mark.


