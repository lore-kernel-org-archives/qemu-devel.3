Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BC606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=iwwoKsy4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzfZ-00081t-Ll; Thu, 22 Oct 2026 16:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzfO-00080H-C4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:45:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzfM-00017P-KR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4uer/QWCAtM2knbPWdea/YO3Rz2kCJ1JyB65w3E7lQs=; b=iwwoKsy4+RqoYHPS+A4QSzhOQN
 LWtt7kpdZnRSSYgz/f8yhHa2yRtsywdWMikpk5ZnFb1fH/WXUNW4MsQJvSbAtbJYhHl6eyfAbaZg6
 uaHRkNEIIjUzUmIW2zF2+9J8zxQ+oZpm/ZaOzxQrGJSKkR5f86qafXGAt6qWbqMx3maS+0X6by+30
 qKEijyiabbYC7UVqxuxQowZKGhWXWrc/Fv4X7WBllVI6WepQLL5Heiy36TyolXVJHJCiFSS3iD5F4
 8v/XfEh92LPJn3pahJX0qzKid/ExQW5g6bpbbvs/EykeE0G1qQQkfT564NCqanICQDJkSj6GVdAy/
 z75S/1NGtJiExtEPp7cd5vmCynZrDePAyrnqPSDQ0hdVsA6iOhxAdwe+rsLPFXUXwVzqoYvZt0876
 n4t/IGNoeeIu7Ofn4mgVKuUa5z4vAQj6SgtUxsECumT2IFmiyT4YR8I1SMP9SYUK9sxgX29GRRI+b
 zVj1aijpxrH01OnauRKlD6RNs2pvqRY7+0DTOCwYOyd9OlzzkgylszpcYZ5Iilw/dsuADNzacrnXF
 RrP37I/gQI5ir8CNEta++Vgi8KHgPcEMKbi9y4ZuXXV4vxFKSPC0TYtwfVhZhFMC9/ceRsrbk9MLX
 YBYFJDqXUJzJUZxAaze7ml9LD6WA3h7b4QPjhyXyw=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzeb-003FUm-Oa; Thu, 22 Oct 2026 21:44:50 +0100
Message-ID: <e9ec88fb-c206-47c5-9684-f27041d39391@ilande.co.uk>
Date: Thu, 22 Oct 2026 21:45:31 +0100
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
References: <20261022070059.3861291-1-stian@itx.no>
 <20261022070059.3861291-6-stian@itx.no>
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
In-Reply-To: <20261022070059.3861291-6-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 5/8] target/sparc: Add the CRC32C instruction
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

On 22/10/2026 08:00, Stian Halseth wrote:

> Implement the CRC32C instruction according to OSA
> (Oracle SPARC Architecture) 2011 section 7.19 and
> set the CRC32C bit in the CFR.
> 
> Using QEMU's crc32c.h and bswap.h.
> Gated behind the crypto CPU feature and disabled for sparc32.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 21 +++++++++++++++++++++
>   target/sparc/helper.h        |  1 +
>   target/sparc/insns.decode    |  1 +
>   target/sparc/translate.c     |  4 +++-
>   4 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
> index f04bd3569d..7189814b75 100644
> --- a/target/sparc/crypto_helper.c
> +++ b/target/sparc/crypto_helper.c
> @@ -10,6 +10,8 @@
>   #include "exec/helper-proto.h"
>   #include "crypto/aes-round.h"
>   #include "crypto/aes.h"
> +#include "qemu/bswap.h"
> +#include "qemu/crc32c.h"
>   
>   /*
>    * SPARC four-operand AES round (Section 7.3).
> @@ -145,3 +147,22 @@ uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
>   {
>       return aes_kexpand(rs1, (uint32_t)rs2);
>   }
> +
> +/*
> + * CRC32C Operation 3-operand (Section 7.19)
> + * Accumulate CRC32C over the eight bytes of rs2, most significant first.
> + */
> +uint64_t helper_crc32c(uint64_t rs1, uint64_t rs2)
> +{
> +    uint8_t buf[8];
> +    /* IV and result are byte-swapped in the register. */
> +    uint32_t crc = bswap32((uint32_t)rs1);
> +
> +    stq_be_p(buf, rs2);
> +
> +    /* Undo crc32c()'s final inversion for the instruction's raw result. */
> +    crc = crc32c(crc, buf, sizeof(buf)) ^ UINT32_MAX;
> +
> +    /* Result lives in the low 32 bits; upper half reads as zero. */
> +    return (uint64_t)bswap32(crc);
> +}
> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index 685b89d9c5..1320f5ebba 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -133,6 +133,7 @@ DEF_HELPER_FLAGS_3(aes_dround23_l, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
>   DEF_HELPER_FLAGS_2(aes_kexpand0, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
>   DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> +DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   #define VIS_CMPHELPER(name)                                  \
>       DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
>                          i64, i64, i64)                        \
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 96791c7658..05c1e73d7f 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -577,6 +577,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
>       FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
>       AES_KEXPAND0 10 ..... 110110 ..... 1 0011 0000 .....   @d_d_d
>       AES_KEXPAND2 10 ..... 110110 ..... 1 0011 0001 .....   @d_d_d
> +    CRC32C       10 ..... 110110 ..... 1 0100 0111 .....   @d_d_d
>   
>       FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
>       FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index ad32b53cc3..562bfb506b 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -111,6 +111,7 @@
>   # define gen_helper_aes_dround23_l       ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_aes_kexpand0         ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_aes_kexpand2         ({ qemu_build_not_reached(); NULL; })
> +# define gen_helper_crc32c               ({ qemu_build_not_reached(); NULL; })
>   #endif
>   
>   #define DISAS_EXIT  DISAS_TARGET_0
> @@ -3041,7 +3042,7 @@ TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
>   
>   static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
>   {
> -    return tcg_constant_tl(CFR_AES);
> +    return tcg_constant_tl(CFR_AES | CFR_CRC32C);
>   }
>   
>   TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
> @@ -5438,6 +5439,7 @@ TRANS(AES_DROUND01_L, CRYPTO, do_dddd, a, gen_helper_aes_dround01_l)
>   TRANS(AES_DROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_dround23_l)
>   TRANS(AES_KEXPAND0, CRYPTO, do_ddd, a, gen_helper_aes_kexpand0)
>   TRANS(AES_KEXPAND2, CRYPTO, do_ddd, a, gen_helper_aes_kexpand2)
> +TRANS(CRC32C, CRYPTO, do_ddd, a, gen_helper_crc32c)
>   
>   /* AES key expansion with RCON selected by the 5-bit immediate in imm */
>   static bool trans_AES_KEXPAND1(DisasContext *dc, arg_r_r_i_r *a)

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


