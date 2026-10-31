Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6B606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=OAgXhCKK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4vL-0002iL-P5; Sat, 31 Oct 2026 04:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xN4vJ-0002i5-K6
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:58:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xN4vH-0004Cu-PZ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gg/I+x8OE54SZtJ9NGxEhXmGUzydAQgMH1kdRC41Mwc=; b=OAgXhCKKx9Ic1IU/0cDzzWfDql
 D7Od3GVneGi662qxNxPaeT8bxUlm0L1rX7e3xboTqre16cFtOvRGLIW7IbxuWww6dEdEZ1IGLzlSU
 u62FiVOhhANY3MycL+VP7Mh3iLz+fRHI1PdZD/NCpTv20cTRsgsxZHl0kmeCNguA029l+pkca0rrF
 AXaxJ1GkT3Qrex+h/PSiaqgPUQtA3GRBZzxOUKtdDC62JTVGV3T32EOJ47zxd5KfJfzoMaSCX4DZh
 F7Bg/haDuKoJMUn8hp8Fz6ipk62Uzsu5DY6c60aojnXVT1TOGDgWlsaN6/Tn3PfP/aCTIkPxPetM8
 3LvXdD2VTno/gFTnb1Ay+3va5f2Fx5RvMsr5Yf76pYPLeQIrFDUEXuQLrM9z/Cn3y71Jg9zx/9aNN
 5iiZSBzbaXbMEr/6VRjUledxkUB3KwY/QvaV/NMjNDLoCJbU2JqAX/Hg9naAxa1CibT2Zgdv/tcxX
 qe4ZDUODmEPjMMXEWjH9vTUeKC1x3wcEhdsQKxOHaIlSJIHHh9qNvDEvETTwaxgUMYjYfZ8Fyra7E
 4qCNY3JybK7mGcL7JGfuNgEtx4AGCWQIM9b8OeHuoJN33ZP8+D2MMv0kfb3rY56el9BuUik476+8Z
 1iIKO+ZUsKCGh6HJDNiA8RBsq844X2rgjJVbDrVY4=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xN4uT-004tLj-SY; Sat, 31 Oct 2026 08:57:58 +0000
Message-ID: <ddf69aa4-d601-4f18-a530-b71354b21160@ilande.co.uk>
Date: Sat, 31 Oct 2026 08:58:38 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261028113816.1651212-1-stian@itx.no>
 <20261028113816.1651212-2-stian@itx.no>
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
In-Reply-To: <20261028113816.1651212-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 1/2] target/sparc: Model block-initializing stores
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 11:38, Stian Halseth wrote:

> On T4 and later, a block-initializing store to the first doubleword of
> a 32-byte block zeroes the rest of the block (measured on a T4).
> glibc's niagara4 memset and Linux's NG4memset rely on this, and
> OpenSSL's T4 AES code uses the FP form, stdfa.
> 
> QEMU only accepted the integer form, on HYPV CPUs, as a plain store, so
> with the crypto hwcap a multiarch glibc memset leaves stale data. Accept
> both forms when the CPU has the crypto feature, which implies T4 or
> later, and zero the 32-byte block as T4 does.
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/translate.c | 43 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 1fc8439a47..416625c6dc 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1853,6 +1853,27 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
>       }
>   }
>   
> +/*
> + * On T4 and later, a block-initializing store to the first doubleword of
> + * a 32-byte block zeroes the rest of the block. glibc and Linux memset
> + * rely on this and store only one doubleword per block when zeroing.
> + */
> +static void gen_blkinit_zero(DisasContext *dc, DisasASI *da, TCGv addr,
> +                             MemOp size)
> +{
> +    TCGLabel *skip = gen_new_label();
> +    TCGv t = tcg_temp_new();
> +    TCGv_i64 zero = tcg_constant_i64(0);
> +
> +    tcg_gen_brcondi_tl(TCG_COND_TSTNE, addr, 31, skip);
> +    /* A narrower store also zeroes the rest of the first doubleword. */
> +    for (int i = size == MO_64 ? 8 : 0; i < 32; i += 8) {
> +        tcg_gen_addi_tl(t, addr, i);
> +        tcg_gen_qemu_st_i64(zero, t, da->mem_idx, MO_UQ);
> +    }
> +    gen_set_label(skip);
> +}
> +
>   static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
>   {
>       switch (da->type) {
> @@ -1863,12 +1884,19 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
>           if (TARGET_LONG_BITS == 32) {
>               gen_exception(dc, TT_ILL_INSN);
>               break;
> -        } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
> -            /* Pre OpenSPARC CPUs don't have these */
> +        } else if (!(dc->def->features &
> +                    (CPU_FEATURE_HYPV | CPU_FEATURE_CRYPTO))) {
> +            /*
> +             * Pre-OpenSPARC CPUs lack block-init stores. Crypto
> +             * instructions imply T4 or later, which has them.
> +             */
>               gen_exception(dc, TT_ILL_INSN);
>               break;
>           }
>           /* In OpenSPARC T1+ CPUs TWINX ASIs in store are ST_BLKINIT_ ASIs */
> +        if (dc->def->features & CPU_FEATURE_CRYPTO) {
> +            gen_blkinit_zero(dc, da, addr, da->memop & MO_SIZE);
> +        }
>           /* fall through */
>   
>       case GET_ASI_DIRECT:
> @@ -2169,6 +2197,17 @@ static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
>           }
>           break;
>   
> +    case GET_ASI_DTWINX:
> +        /* stdfa with a block-initializing ASI, T4 and later */
> +        if (orig_size == MO_64 && (dc->def->features & CPU_FEATURE_CRYPTO)) {
> +            gen_blkinit_zero(dc, da, addr, MO_64);
> +            d64 = gen_load_fpr_D(dc, rd);
> +            tcg_gen_qemu_st_i64(d64, addr, da->mem_idx, memop | MO_ALIGN);
> +        } else {
> +            gen_exception(dc, TT_ILL_INSN);
> +        }
> +        break;
> +
>       case GET_ASI_BLOCK:
>           /* Valid for stdfa on aligned registers only.  */
>           if (orig_size == MO_64 && (rd & 7) == 0) {

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


