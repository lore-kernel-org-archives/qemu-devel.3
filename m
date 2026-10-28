Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7C606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pl2aVHsj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1FQ-0003zH-3C; Wed, 28 Oct 2026 06:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1FP-0003z4-07
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:51:11 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1FN-0007kf-6M
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:51:10 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so143175b6e.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793184667; x=1793789467; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DURus9nOPrIyp4NXlohdR7ufW/aaAJVsyQMWCfrDoBw=;
 b=pl2aVHsjzqtPiN2DhY/qa8e8nBY7evLIPKJL9ifaSZAN0clwGHHjWgHZGIfbv2P0Kl
 Jdlc5HyilbL96fKX5FP+hC2FxM8NwqEBuBsnypjugt4eFWnI6dLsh+gx3EPuPGGoNtuj
 59eoDRAMPRW2gP21jbuY3U/sRZIwVxFsIvXc3ySDHR6prvsPLZy2IVbKTTUoT7alJq3a
 7Fl2lOyWpD+IFh9PU7vbb6+WyQjDJygoMjCI7pLmjkj1vBKOGlIn3HVs88WzNmtXAKip
 PvNwFaeYzufmpXUs4I5torAiNXERgQxJBkFmMThfBIGvbN3RvQlbcKhOyPdYmb75DVY4
 meUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793184667; x=1793789467;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DURus9nOPrIyp4NXlohdR7ufW/aaAJVsyQMWCfrDoBw=;
 b=H09vLiu6S6PIr3Na9/X8293RWinE8XhcMTw6LdfL7gVpS9iqT8kwiQfaz1kN373IJi
 2zNik95eeMbOrb2EVjGCyYXZYz6cU41amhzGSFqSvLICboyPnuohn5Bmidur6CfjXR+N
 jxbNeRNK92JpWB72NPqkgzyei71/wC4GdcEutwafvDvUSRltT52ljjkoVSetCo3jnQxd
 7xWUgEA/3uR7SGAcSjjdMX04tD8uUOm/p9/jtJVq6R4WzDGN833VS1ePkdsuszOXahi6
 J8X3SEZOaMQIsEue+xRZ4wrqDvdmr9ByQErZb/AUcwwVzRrKeQwWw1jgRAnZKUkgPCqn
 PVEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYqd0hP4r3pojC+gMS3jtNeX74nRJgWo28KJULgp0Aus/KYeu6YCMjqwT54G4M4bNYYt/v0+jmphW+@nongnu.org
X-Gm-Message-State: AFq9FYLYUhOFdtN8jSMpTRsTrcDsQa00mdaZ7zxOFmm0suNimh8fCm96
 DtsVSJWi4YBgKOSWUrLHTsmKW2P3s36eR3444/8uDA3fxlnCA9Ca+ps82JrA0KmJhtM=
X-Gm-Gg: AYBFou3KBfxcvK1liCeLTK2BvbMZc2EExT27Ltq9U/l5hnuPE69STNHz6T32xRl+DTq
 RfCuLKNcdBVPk5hP0wXz7yd+vBOi8r3jUCHlRegAUS8WWMju98aIsk5s5D8hmu9c1ZIP4YmAmby
 fLH76kQXm+rFZB7H8EZeV9GydlfpR33YcavhmcG0xsIZgjG4y7/L98bBxrTC6ket1aYFb5i5mdT
 60joj1OIYZnfevkWCY8LPDNVWawxCMih9z7zbzmfvYoktTrZjuTCF10GBJ6fCgnY3qmSOAh/tyk
 Naa8wZRFPS5/7DLotqcEVK/zYnN90WlL263bBwgrmMPLnMbx7e8Fiw3aSH3ThIRmBMk5IhdA3Bi
 rV9EtgeMI3geJL+4ERZi+oflsx0WiMWGq27ABrSG2493mw99AZDmj+qsDGaG1EH1Wi6hQwJ488L
 Lmb2OovpzrVARbQ+hHkqM7/Cg9OhOavNfk1FiFVbEdmjyE2ZN8zXvUlp/MFv2aMOGlRk2rllaCL
 bilzCmqqdFMK+2k7036JghAlZFJsai0XtXg7qyRHzRYnMqLAULC3VGtAp8FoKW3/a08tYWI6rhC
 bbuC3AvsKultdx6Qz203XN7Uz+pB4bi0xFoIV+5jBOQe
X-Received: by 2002:a05:6808:c12d:b0:4ea:1854:b949 with SMTP id
 5614622812f47-56383e8f47emr1191970b6e.33.1793184667406; 
 Wed, 28 Oct 2026 03:51:07 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c5437cfcsm1003719b6e.4.2026.10.28.03.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 03:51:07 -0700 (PDT)
Message-ID: <c7703ab2-55c0-4279-81a5-961752f1ab94@linaro.org>
Date: Wed, 28 Oct 2026 05:51:05 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/sparc: Model block-initializing stores
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261023114303.576319-1-stian@itx.no>
 <20261023114303.576319-2-stian@itx.no>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023114303.576319-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 06:43, Stian Halseth wrote:
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
>   target/sparc/translate.c | 42 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 1fc8439a47..009340a3bb 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1853,6 +1853,26 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
>       }
>   }
>   
> +/*
> + * On T4 and later, a block-initializing store to the first doubleword of
> + * a 32-byte block zeroes the rest of the block. glibc and Linux memset
> + * rely on this and store only one doubleword per block when zeroing.
> + */
> +static void gen_blkinit_zero(DisasContext *dc, DisasASI *da, TCGv addr)
> +{
> +    TCGLabel *skip = gen_new_label();
> +    TCGv t = tcg_temp_new();
> +    TCGv_i64 zero = tcg_constant_i64(0);
> +
> +    tcg_gen_andi_tl(t, addr, 31);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, t, 0, skip);

tcg_gen_brcondi_tl(TCG_COND_TSTNE, addr, 31, skip);

> +    for (int i = 0; i < 32; i += 8) {
> +        tcg_gen_addi_tl(t, addr, i);
> +        tcg_gen_qemu_st_i64(zero, t, da->mem_idx, MO_UQ);
> +    }

You don't need to store to offset 0, because...

> +    case GET_ASI_DTWINX:
> +        /* stdfa with a block-initializing ASI, T4 and later */
> +        if (orig_size == MO_64 && (dc->def->features & CPU_FEATURE_CRYPTO)) {
> +            gen_blkinit_zero(dc, da, addr);
> +            d64 = gen_load_fpr_D(dc, rd);
> +            tcg_gen_qemu_st_i64(d64, addr, da->mem_idx, memop | MO_ALIGN);

... that's done here.


r~

