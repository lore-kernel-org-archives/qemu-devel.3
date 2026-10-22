Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED807606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=tzulJy+z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzMg-0001P0-Mu; Thu, 22 Oct 2026 16:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzMK-0001NA-UZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:26:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzMI-0007Kc-Vd
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lmvsMlj+GhLnjUOh4qqIDYHZZ0e4PRJp7/3WZUpYjXo=; b=tzulJy+zH4pB3P84HQaj7TkQbS
 dnIEzvSmYN/ldPD9T28eP/ON7FbWuJoIUy8ZegSUZIZJ8iX1GYH2bXo087AQ9T3NoAGpQlYmKImHB
 ax2WMpm/Ex7RsSEVzTGW6GTqIRasDAz3SamVuYrieN7Q5s/TIJixkMvSqc+9HN8vO8Mvn/Q9CKTym
 EQ7TGOS3F7w/9FWIJD7xSWU2KHAJuc6N3gMqjW43DAXquD3wQgEJI4YJZR2GSH7yxeTX+KwlPnxcu
 aNVlDar9x79vC/xLqGhdT/8s8RvoW2Z47tKLajoVhn7UqygG7s5NAs6PCnO226//9etcXh1cnCdEv
 wUCQmlRtGSWzbIzTE3Rh6jge78aVLDYHJjb2pKp9XYI9seqNoaYEbPrw81FpED1i0bO2+hlriztDX
 b8LvF6hJ1JVdM8PAVCHlaDLzQmxR/bRG0qHmqrwp/94CsOko5cctFc7XUAo4YBb8c8ceN2paG0nYB
 /KtxRGuskC9+uVQKRhc0VQNB5IREElqlxHOhQCSKtlMuH+BMVIIxa3dkVgxB0FrMznE0m6yZfHVoS
 SySHVERIFOxd2RDpRqOS4m8W7AHTdtqcgxi25QT6BMVb6u/igCqRra+hSaU5mfhO/3VARaJ92bC0e
 TodeKnLnsARSljDVhU8EEmZVwDTE4f/51vybVc74s=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzLZ-003FLM-IY; Thu, 22 Oct 2026 21:25:09 +0100
Message-ID: <fc5ae17e-58bf-416a-817b-781d0a3de551@ilande.co.uk>
Date: Thu, 22 Oct 2026 21:25:50 +0100
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
 <20261022070059.3861291-2-stian@itx.no>
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
In-Reply-To: <20261022070059.3861291-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 1/8] target/sparc: Add crypto feature
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

> Add a "crypto" feature bit gating the OSA 2011 cryptographic
> instructions (AES, SHA-1/256/512, CRC32C, CFR in ASR 26).
> Off by default; no CPU model enables it yet; can be set
> explicitly with "-cpu ...,+crypto". SPARC64 only.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/cpu-feature.h.inc | 1 +
>   target/sparc/cpu.c             | 3 +++
>   target/sparc/translate.c       | 2 ++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
> index be81005237..4a32f49de4 100644
> --- a/target/sparc/cpu-feature.h.inc
> +++ b/target/sparc/cpu-feature.h.inc
> @@ -16,3 +16,4 @@ FEATURE(FMAF)
>   FEATURE(VIS3)
>   FEATURE(IMA)
>   FEATURE(VIS4)
> +FEATURE(CRYPTO)
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index ae9bdca9df..528a9d2bd8 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -560,6 +560,7 @@ static const char * const feature_name[] = {
>       [CPU_FEATURE_BIT_VIS3] = "vis3",
>       [CPU_FEATURE_BIT_IMA] = "ima",
>       [CPU_FEATURE_BIT_VIS4] = "vis4",
> +    [CPU_FEATURE_BIT_CRYPTO] = "crypto",
>   #else
>       [CPU_FEATURE_BIT_MUL] = "mul",
>       [CPU_FEATURE_BIT_DIV] = "div",
> @@ -977,6 +978,8 @@ static const Property sparc_cpu_properties[] = {
>                       CPU_FEATURE_BIT_IMA, false),
>       DEFINE_PROP_BIT("vis4",     SPARCCPU, env.def.features,
>                       CPU_FEATURE_BIT_VIS4, false),
> +    DEFINE_PROP_BIT("crypto",   SPARCCPU, env.def.features,
> +                    CPU_FEATURE_BIT_CRYPTO, false),
>   #else
>       DEFINE_PROP_BIT("mul",      SPARCCPU, env.def.features,
>                       CPU_FEATURE_BIT_MUL, false),
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 3156be6a94..b93feb074b 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -2507,6 +2507,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
>   # define avail_VIS3(C)    ((C)->def->features & CPU_FEATURE_VIS3)
>   # define avail_VIS3B(C)   avail_VIS3(C)
>   # define avail_VIS4(C)    ((C)->def->features & CPU_FEATURE_VIS4)
> +# define avail_CRYPTO(C)  ((C)->def->features & CPU_FEATURE_CRYPTO)
>   #else
>   # define avail_32(C)      true
>   # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
> @@ -2524,6 +2525,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
>   # define avail_VIS3(C)    false
>   # define avail_VIS3B(C)   false
>   # define avail_VIS4(C)    false
> +# define avail_CRYPTO(C)  false
>   #endif
>   
>   /*

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


