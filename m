Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B7B606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=D52Fqpqa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzrg-0001FJ-50; Thu, 22 Oct 2026 16:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzre-0001Ej-5z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:58:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzrb-00021V-Ep
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eWLqqL9Q8P5V4tZd+haHb1Kg9VfHl4SSckNqqPJDx28=; b=D52Fqpqaqg8251lujhFmch+qVY
 /zDmg5VO79FMzKxLXUvW+WBOOeiQWZk1d3qDq/qBF8qWDzldVqZ0D6vCbXmicB119+8rvox9ZCowd
 Qy1fsIPQLt+buChB/+YSDqKP74kyLTlWrmF08ytLEkkV3QF00YJK4RAw1Z0WkrJ186ILr524H98jC
 dPN0eB8KAfAk49t/B9KrP3EtFDyVhD1dEy+pMFtm+/iMjl7Jn/r8HpkCdtDIelu3ZgwOjmcHGuZFl
 54xZQ2LLE0B8LoZfALcdoHAhL2VhdsiD73lGxXMJS1Fc/qlPvmFTxNv60QpSH4NgWI0Q182EW93dE
 mjfVXmrdGZmxgFVp94NjLJTpiz7zQfABfBX4+v2WNdH2UUpbBZWUtZhXgYCJdsz2O/AXTrPqwK/Y/
 6ll2KryO9E7RU/Ggc35P9mXrvSFYJx1TuEAucV2UUjgaG96UjDytkjEKN6t5mDW+nXMM5Qrdw/39h
 HW2DrkxwuKyLxkifHIBUy97/cAg4ioTj944IzZ0XlwIgPffXEMQV0QpD0H5sf4LlR61LboKrJ8CRb
 TEAlP0WNLTZCuKHBTMAu/YOl23YOm8HfjNCBV59eyRuLloDqIFP/oLEELGucZ0rV4t7x1Mb4sJTKB
 ozmbjpPz4ZHMH6Bg7nEgM3CdkK+Jrh2dIJ2NE2pWo=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzqp-003FZI-TX; Thu, 22 Oct 2026 21:57:28 +0100
Message-ID: <31719eb4-deff-4217-93c0-e205dd7b170b@ilande.co.uk>
Date: Thu, 22 Oct 2026 21:58:09 +0100
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
 <20261022070059.3861291-7-stian@itx.no>
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
In-Reply-To: <20261022070059.3861291-7-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 6/8] target/sparc: Add the SHA instructions
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

> Implement the SHA1, SHA256 and SHA512 instructions according
> to OSA (Oracle SPARC Architecture) 2011 section 7.115,
> using the algorithms defined in FIPS 180-4, and set the
> SHA1/SHA256/SHA512 bits in the CFR.
> 
> Read and update the fixed floating-point registers and mark the
> lower FPR bank dirty. Share the SHA-2 Boolean functions between
> the SHA256 and SHA512 helpers.
> 
> Gated behind the crypto CPU feature and disabled for sparc32.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 274 +++++++++++++++++++++++++++++++++++
>   target/sparc/helper.h        |   4 +
>   target/sparc/insns.decode    |   4 +
>   target/sparc/translate.c     |  21 ++-
>   4 files changed, 302 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
> index 7189814b75..6b6c843b3d 100644
> --- a/target/sparc/crypto_helper.c
> +++ b/target/sparc/crypto_helper.c
> @@ -12,6 +12,7 @@
>   #include "crypto/aes.h"
>   #include "qemu/bswap.h"
>   #include "qemu/crc32c.h"
> +#include "cpu.h"
>   
>   /*
>    * SPARC four-operand AES round (Section 7.3).
> @@ -166,3 +167,276 @@ uint64_t helper_crc32c(uint64_t rs1, uint64_t rs2)
>       /* Result lives in the low 32 bits; upper half reads as zero. */
>       return (uint64_t)bswap32(crc);
>   }
> +
> +/*
> + * Compress one SHA-1 block from f8-f23 into f0-f4.
> + * Clear f5 to match SPARC M7 behavior.
> + */
> +void helper_sha1(CPUSPARCState *env)
> +{
> +    uint32_t a = env->fpr[0].l.upper;
> +    uint32_t b = env->fpr[0].l.lower;
> +    uint32_t c = env->fpr[1].l.upper;
> +    uint32_t d = env->fpr[1].l.lower;
> +    uint32_t e = env->fpr[2].l.upper;
> +    uint32_t w[80];
> +
> +    /* Load 16 message words; each fpr[] entry holds two words. */
> +    for (int i = 0; i < 8; i++) {
> +        w[2 * i] = env->fpr[4 + i].l.upper;
> +        w[2 * i + 1] = env->fpr[4 + i].l.lower;
> +    }
> +
> +    /* Expand the message into the 80-word round schedule. */
> +    for (int i = 16; i < 80; i++) {
> +        w[i] = rol32(w[i - 3] ^ w[i - 8] ^
> +                     w[i - 14] ^ w[i - 16], 1);
> +    }
> +
> +    /* Each group of 20 rounds uses its own function and constant. */
> +    for (int i = 0; i < 80; i++) {
> +        uint32_t f, k, t;
> +
> +        if (i < 20) {
> +            f = (b & c) | (~b & d);          /* Choose */
> +            k = 0x5a827999;
> +        } else if (i < 40) {
> +            f = b ^ c ^ d;                  /* Parity */
> +            k = 0x6ed9eba1;
> +        } else if (i < 60) {
> +            f = (b & c) | (b & d) | (c & d); /* Majority */
> +            k = 0x8f1bbcdc;
> +        } else {
> +            f = b ^ c ^ d;                  /* Parity */
> +            k = 0xca62c1d6;
> +        }
> +
> +        /* Advance the five working words, with arithmetic modulo 2^32. */
> +        t = rol32(a, 5) + f + e + k + w[i];
> +        e = d;
> +        d = c;
> +        c = rol32(b, 30);
> +        b = a;
> +        a = t;
> +    }
> +
> +    /* Accumulate the hash in f0-f4 and clear the unused f5 word. */
> +    env->fpr[0].l.upper += a;
> +    env->fpr[0].l.lower += b;
> +    env->fpr[1].l.upper += c;
> +    env->fpr[1].l.lower += d;
> +    env->fpr[2].l.upper += e;
> +    env->fpr[2].l.lower = 0;
> +}
> +
> +/* SHA-2 Boolean functions. */
> +static inline uint64_t sha_ch(uint64_t x, uint64_t y, uint64_t z)
> +{
> +    return (x & y) ^ (~x & z);
> +}
> +
> +static inline uint64_t sha_maj(uint64_t x, uint64_t y, uint64_t z)
> +{
> +    return (x & y) ^ (x & z) ^ (y & z);
> +}
> +
> +static const uint32_t sha256_k[64] = {
> +    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
> +    0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
> +    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
> +    0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
> +    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
> +    0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
> +    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
> +    0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
> +    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
> +    0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
> +    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
> +    0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
> +    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
> +    0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
> +    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
> +    0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
> +};
> +
> +static const uint64_t sha512_k[80] = {
> +    UINT64_C(0x428a2f98d728ae22), UINT64_C(0x7137449123ef65cd),
> +    UINT64_C(0xb5c0fbcfec4d3b2f), UINT64_C(0xe9b5dba58189dbbc),
> +    UINT64_C(0x3956c25bf348b538), UINT64_C(0x59f111f1b605d019),
> +    UINT64_C(0x923f82a4af194f9b), UINT64_C(0xab1c5ed5da6d8118),
> +    UINT64_C(0xd807aa98a3030242), UINT64_C(0x12835b0145706fbe),
> +    UINT64_C(0x243185be4ee4b28c), UINT64_C(0x550c7dc3d5ffb4e2),
> +    UINT64_C(0x72be5d74f27b896f), UINT64_C(0x80deb1fe3b1696b1),
> +    UINT64_C(0x9bdc06a725c71235), UINT64_C(0xc19bf174cf692694),
> +    UINT64_C(0xe49b69c19ef14ad2), UINT64_C(0xefbe4786384f25e3),
> +    UINT64_C(0x0fc19dc68b8cd5b5), UINT64_C(0x240ca1cc77ac9c65),
> +    UINT64_C(0x2de92c6f592b0275), UINT64_C(0x4a7484aa6ea6e483),
> +    UINT64_C(0x5cb0a9dcbd41fbd4), UINT64_C(0x76f988da831153b5),
> +    UINT64_C(0x983e5152ee66dfab), UINT64_C(0xa831c66d2db43210),
> +    UINT64_C(0xb00327c898fb213f), UINT64_C(0xbf597fc7beef0ee4),
> +    UINT64_C(0xc6e00bf33da88fc2), UINT64_C(0xd5a79147930aa725),
> +    UINT64_C(0x06ca6351e003826f), UINT64_C(0x142929670a0e6e70),
> +    UINT64_C(0x27b70a8546d22ffc), UINT64_C(0x2e1b21385c26c926),
> +    UINT64_C(0x4d2c6dfc5ac42aed), UINT64_C(0x53380d139d95b3df),
> +    UINT64_C(0x650a73548baf63de), UINT64_C(0x766a0abb3c77b2a8),
> +    UINT64_C(0x81c2c92e47edaee6), UINT64_C(0x92722c851482353b),
> +    UINT64_C(0xa2bfe8a14cf10364), UINT64_C(0xa81a664bbc423001),
> +    UINT64_C(0xc24b8b70d0f89791), UINT64_C(0xc76c51a30654be30),
> +    UINT64_C(0xd192e819d6ef5218), UINT64_C(0xd69906245565a910),
> +    UINT64_C(0xf40e35855771202a), UINT64_C(0x106aa07032bbd1b8),
> +    UINT64_C(0x19a4c116b8d2d0c8), UINT64_C(0x1e376c085141ab53),
> +    UINT64_C(0x2748774cdf8eeb99), UINT64_C(0x34b0bcb5e19b48a8),
> +    UINT64_C(0x391c0cb3c5c95a63), UINT64_C(0x4ed8aa4ae3418acb),
> +    UINT64_C(0x5b9cca4f7763e373), UINT64_C(0x682e6ff3d6b2b8a3),
> +    UINT64_C(0x748f82ee5defb2fc), UINT64_C(0x78a5636f43172f60),
> +    UINT64_C(0x84c87814a1f0ab72), UINT64_C(0x8cc702081a6439ec),
> +    UINT64_C(0x90befffa23631e28), UINT64_C(0xa4506cebde82bde9),
> +    UINT64_C(0xbef9a3f7b2c67915), UINT64_C(0xc67178f2e372532b),
> +    UINT64_C(0xca273eceea26619c), UINT64_C(0xd186b8c721c0c207),
> +    UINT64_C(0xeada7dd6cde0eb1e), UINT64_C(0xf57d4f7fee6ed178),
> +    UINT64_C(0x06f067aa72176fba), UINT64_C(0x0a637dc5a2c898a6),
> +    UINT64_C(0x113f9804bef90dae), UINT64_C(0x1b710b35131c471b),
> +    UINT64_C(0x28db77f523047d84), UINT64_C(0x32caab7b40c72493),
> +    UINT64_C(0x3c9ebe0a15c9bebc), UINT64_C(0x431d67c49c100d4c),
> +    UINT64_C(0x4cc5d4becb3e42b6), UINT64_C(0x597f299cfc657e2a),
> +    UINT64_C(0x5fcb6fab3ad6faec), UINT64_C(0x6c44198c4a475817),
> +};
> +
> +/* Compress 16 numeric message words into the supplied SHA-256 state. */
> +static void sha256_compress(uint32_t state[8], const uint32_t block[16])
> +{
> +    uint32_t a = state[0], b = state[1], c = state[2], d = state[3];
> +    uint32_t e = state[4], f = state[5], g = state[6], h = state[7];
> +    uint32_t w[64];
> +
> +    /* Expand the message into the 64-word round schedule. */
> +    memcpy(w, block, 16 * sizeof(*w));
> +    for (int i = 16; i < 64; i++) {
> +        uint32_t x = w[i - 15], y = w[i - 2];
> +        uint32_t s0 = ror32(x, 7) ^ ror32(x, 18) ^ (x >> 3);
> +        uint32_t s1 = ror32(y, 17) ^ ror32(y, 19) ^ (y >> 10);
> +
> +        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
> +    }
> +
> +    /* Perform 64 rounds with arithmetic modulo 2^32. */
> +    for (int i = 0; i < 64; i++) {
> +        uint32_t s0 = ror32(a, 2) ^ ror32(a, 13) ^ ror32(a, 22);
> +        uint32_t s1 = ror32(e, 6) ^ ror32(e, 11) ^ ror32(e, 25);
> +
> +        /* sha_ch/sha_maj are shared with SHA-512; narrow to 32 bits. */
> +        uint32_t t1 = h + s1 + (uint32_t)sha_ch(e, f, g) +
> +                      sha256_k[i] + w[i];
> +        uint32_t t2 = s0 + (uint32_t)sha_maj(a, b, c);
> +
> +        h = g;
> +        g = f;
> +        f = e;
> +        e = d + t1;
> +        d = c;
> +        c = b;
> +        b = a;
> +        a = t1 + t2;
> +    }
> +
> +    /* Add the working words to the original state. */
> +    state[0] += a;
> +    state[1] += b;
> +    state[2] += c;
> +    state[3] += d;
> +    state[4] += e;
> +    state[5] += f;
> +    state[6] += g;
> +    state[7] += h;
> +}
> +
> +/* Compress 16 numeric message words into the supplied SHA-512 state. */
> +static void sha512_compress(uint64_t state[8], const uint64_t block[16])
> +{
> +    uint64_t a = state[0], b = state[1], c = state[2], d = state[3];
> +    uint64_t e = state[4], f = state[5], g = state[6], h = state[7];
> +    uint64_t w[80];
> +
> +    /* Expand the message into the 80-word round schedule. */
> +    memcpy(w, block, 16 * sizeof(*w));
> +    for (int i = 16; i < 80; i++) {
> +        uint64_t x = w[i - 15], y = w[i - 2];
> +        uint64_t s0 = ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7);
> +        uint64_t s1 = ror64(y, 19) ^ ror64(y, 61) ^ (y >> 6);
> +
> +        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
> +    }
> +
> +    /* Perform 80 rounds with arithmetic modulo 2^64. */
> +    for (int i = 0; i < 80; i++) {
> +        uint64_t s0 = ror64(a, 28) ^ ror64(a, 34) ^ ror64(a, 39);
> +        uint64_t s1 = ror64(e, 14) ^ ror64(e, 18) ^ ror64(e, 41);
> +        uint64_t t1 = h + s1 + sha_ch(e, f, g) + sha512_k[i] + w[i];
> +        uint64_t t2 = s0 + sha_maj(a, b, c);
> +
> +        h = g;
> +        g = f;
> +        f = e;
> +        e = d + t1;
> +        d = c;
> +        c = b;
> +        b = a;
> +        a = t1 + t2;
> +    }
> +
> +    /* Add the working words to the original state. */
> +    state[0] += a;
> +    state[1] += b;
> +    state[2] += c;
> +    state[3] += d;
> +    state[4] += e;
> +    state[5] += f;
> +    state[6] += g;
> +    state[7] += h;
> +}
> +
> +/* Compress one SHA-256 block from f8-f23 into f0-f7. */
> +void helper_sha256(CPUSPARCState *env)
> +{
> +    uint32_t state[8], block[16];
> +
> +    /* Each fpr[] entry holds two architectural 32-bit registers. */
> +    for (int i = 0; i < 4; i++) {
> +        state[2 * i] = env->fpr[i].l.upper;
> +        state[2 * i + 1] = env->fpr[i].l.lower;
> +    }
> +    for (int i = 0; i < 8; i++) {
> +        block[2 * i] = env->fpr[4 + i].l.upper;
> +        block[2 * i + 1] = env->fpr[4 + i].l.lower;
> +    }
> +
> +    sha256_compress(state, block);
> +
> +    for (int i = 0; i < 4; i++) {
> +        env->fpr[i].l.upper = state[2 * i];
> +        env->fpr[i].l.lower = state[2 * i + 1];
> +    }
> +}
> +
> +/*
> + * Compress one SHA-512 block from FD16, FD18, ..., FD46
> + * into FD0, FD2, ..., FD14.
> + */
> +void helper_sha512(CPUSPARCState *env)
> +{
> +    uint64_t state[8], block[16];
> +
> +    /* Each fpr[] entry holds one architectural 64-bit register. */
> +    for (int i = 0; i < 8; i++) {
> +        state[i] = env->fpr[i].ll;
> +    }
> +    for (int i = 0; i < 16; i++) {
> +        block[i] = env->fpr[8 + i].ll;
> +    }
> +
> +    sha512_compress(state, block);
> +
> +    for (int i = 0; i < 8; i++) {
> +        env->fpr[i].ll = state[i];
> +    }
> +}
> diff --git a/target/sparc/helper.h b/target/sparc/helper.h
> index 1320f5ebba..fd280c426f 100644
> --- a/target/sparc/helper.h
> +++ b/target/sparc/helper.h
> @@ -134,6 +134,10 @@ DEF_HELPER_FLAGS_2(aes_kexpand0, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_3(aes_kexpand1, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
>   DEF_HELPER_FLAGS_2(aes_kexpand2, TCG_CALL_NO_RWG_SE, i64, i64, i64)
>   DEF_HELPER_FLAGS_2(crc32c, TCG_CALL_NO_RWG_SE, i64, i64, i64)
> +DEF_HELPER_FLAGS_1(sha1, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(sha256, TCG_CALL_NO_RWG, void, env)
> +DEF_HELPER_FLAGS_1(sha512, TCG_CALL_NO_RWG, void, env)
> +
>   #define VIS_CMPHELPER(name)                                  \
>       DEF_HELPER_FLAGS_2(f##name##8, TCG_CALL_NO_RWG_SE,       \
>                          i64, i64, i64)                        \
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 05c1e73d7f..edb82a492e 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -575,9 +575,13 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
>       FPMAXU8     10 ..... 110110 ..... 1 0101 1101 .....    @d_d_d
>       FPMAXU16    10 ..... 110110 ..... 1 0101 1110 .....    @d_d_d
>       FPMAXU32    10 ..... 110110 ..... 1 0101 1111 .....    @d_d_d
> +
>       AES_KEXPAND0 10 ..... 110110 ..... 1 0011 0000 .....   @d_d_d
>       AES_KEXPAND2 10 ..... 110110 ..... 1 0011 0001 .....   @d_d_d
>       CRC32C       10 ..... 110110 ..... 1 0100 0111 .....   @d_d_d
> +    SHA1         10 00000 110110 00000 1 0100 0001 00000
> +    SHA256       10 00000 110110 00000 1 0100 0010 00000
> +    SHA512       10 00000 110110 00000 1 0100 0011 00000
>   
>       FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
>       FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 562bfb506b..921ffd2d1b 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -112,6 +112,9 @@
>   # define gen_helper_aes_kexpand0         ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_aes_kexpand2         ({ qemu_build_not_reached(); NULL; })
>   # define gen_helper_crc32c               ({ qemu_build_not_reached(); NULL; })
> +# define gen_helper_sha1                 ({ qemu_build_not_reached(); NULL; })
> +# define gen_helper_sha256               ({ qemu_build_not_reached(); NULL; })
> +# define gen_helper_sha512               ({ qemu_build_not_reached(); NULL; })
>   #endif
>   
>   #define DISAS_EXIT  DISAS_TARGET_0
> @@ -3042,7 +3045,8 @@ TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
>   
>   static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
>   {
> -    return tcg_constant_tl(CFR_AES | CFR_CRC32C);
> +    return tcg_constant_tl(CFR_AES | CFR_CRC32C | CFR_SHA1 |
> +                           CFR_SHA256 | CFR_SHA512);
>   }
>   
>   TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
> @@ -5422,6 +5426,18 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r_r *a,
>       return advance_pc(dc);
>   }
>   
> +/* SHA helpers update fixed registers in the lower FPR bank. */
> +static bool do_sha(DisasContext *dc, void (*func)(TCGv_env))
> +{
> +    if (gen_trap_ifnofpu(dc)) {
> +        return true;
> +    }

Same question here about presence of FPU.

> +    func(tcg_env);
> +    gen_update_fprs_dirty(dc, 0);
> +    return advance_pc(dc);
> +}
> +
>   TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
>   TRANS(FMADDd, FMAF, do_dddd, a, gen_op_fmaddd)
>   TRANS(FMSUBd, FMAF, do_dddd, a, gen_op_fmsubd)
> @@ -5440,6 +5456,9 @@ TRANS(AES_DROUND23_L, CRYPTO, do_dddd, a, gen_helper_aes_dround23_l)
>   TRANS(AES_KEXPAND0, CRYPTO, do_ddd, a, gen_helper_aes_kexpand0)
>   TRANS(AES_KEXPAND2, CRYPTO, do_ddd, a, gen_helper_aes_kexpand2)
>   TRANS(CRC32C, CRYPTO, do_ddd, a, gen_helper_crc32c)
> +TRANS(SHA1, CRYPTO, do_sha, gen_helper_sha1)
> +TRANS(SHA256, CRYPTO, do_sha, gen_helper_sha256)
> +TRANS(SHA512, CRYPTO, do_sha, gen_helper_sha512)
>   
>   /* AES key expansion with RCON selected by the 5-bit immediate in imm */
>   static bool trans_AES_KEXPAND1(DisasContext *dc, arg_r_r_i_r *a)

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


