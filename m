Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C914EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1QQc-0007P6-Ek; Mon, 29 Apr 2024 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QQa-0007O4-Eb
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:48:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1QQY-00066a-2R
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:48:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6eddff25e4eso3711449b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714394892; x=1714999692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yHyOpxLaTTslfFmdqs3vaVKM3sjpWOpWqZfgMA2oLPM=;
 b=XogAXpSOJ5i6MS/jOeNgFJwRe+HWrw+jlo+4cvOfhpJzUnpkIzjMHDgHD1pFwaJvT5
 +ebS9qyu+qOBRFzi2IPw8XSwdbRL5rgfTi/7KmcelAVnJ1A5idvpE0PGPiGCXwQZ/xRI
 JXCNTpqjTBrxDQVd4Rj9OcyNQ41cghSqQKD1/23nc6xe/WyBonmLwMq14rvVCl4DznuI
 VMSSooU9O2FjlN82o/6l+cCDafPeZQn9QNpv+YUNhhsOedKNmjnkgTMehxZRIyW2Kz1C
 HQ28xwPDpbDRczQFQl8FG02QBUH4/xyU8Zmv1mVBEhum172RF+/txXmfYkMF72U9wyxl
 F1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714394892; x=1714999692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yHyOpxLaTTslfFmdqs3vaVKM3sjpWOpWqZfgMA2oLPM=;
 b=K4pGHzlysw0uNqvjdkxoBjgvNqPAV5bhwXpHTebuo4a7YEmin7QgYu/hEFp3yfulXr
 rqlY7e/y/HGQw6QKnMy6ETfHeztwD3pbeHWSdX5SRNLB5nDxQzExVU7+AEcMaYsxA1V5
 So/U2Eyc21g/noPUnHBTqFlZJUCqHRNO5jhVovowpQDiRclOph0uAUqmLKmIeKdeNOZM
 SCzWfJvGCAFD3KpGF1zaYiJUxoBR+grwJKGOipau5ixbWNPWGxMbiZKnVjx7+yKKBYc5
 VFuodNW+LXy6urQZfwuHnWHPX59UbrQsjZcVQ+PLy1IclKmhtX0F3QtKYQuXutHRb6Dw
 Aoeg==
X-Gm-Message-State: AOJu0YzrR+4og0ArTiM3aKTJCFZTvrArz1yaUYNE0/QDNZZipYUROJ4b
 sjtTr+yD5YGN5l9J36g620Qv7frc8zqHCTT/I3w6dgXAD6e+MNkhq81QUSC8EZM=
X-Google-Smtp-Source: AGHT+IHlBJaJT7/L8KpQDkcZSuVRA9fhxR/UpvxzhD0g6boeA8+54emfex1T676hW4HWAvt6OjbzTA==
X-Received: by 2002:a05:6a00:2e02:b0:6f0:f54a:4e7a with SMTP id
 fc2-20020a056a002e0200b006f0f54a4e7amr11643774pfb.2.1714394892324; 
 Mon, 29 Apr 2024 05:48:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a056a000b9500b006e6b2ba1577sm19106885pfj.138.2024.04.29.05.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:48:11 -0700 (PDT)
Message-ID: <0e33df55-9feb-403f-be87-952efdbaccd5@linaro.org>
Date: Mon, 29 Apr 2024 05:48:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/ppc: Move VMX storage access instructions to
 decodetree
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240429051317.289426-1-rathc@linux.ibm.com>
 <20240429051317.289426-2-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429051317.289426-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/28/24 22:13, Chinmay Rath wrote:
> +static bool trans_LVX(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +    TCGv_i64 avr;
> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
> +    REQUIRE_VECTOR(ctx);
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    avr = tcg_temp_new_i64();
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    tcg_gen_andi_tl(EA, EA, ~0xf);
> +    /*
> +     * We only need to swap high and low halves. gen_qemu_ld64_i64
> +     * does necessary 64-bit byteswap already.
> +     */
> +    gen_qemu_ld64_i64(ctx, avr, EA);
> +    set_avr64(a->rt, avr, !ctx->le_mode);
> +    tcg_gen_addi_tl(EA, EA, 8);
> +    gen_qemu_ld64_i64(ctx, avr, EA);
> +    set_avr64(a->rt, avr, ctx->le_mode);
> +    return true;
> +}

This is an accurate transcription of the current code, so,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

but at some point this should use tcg_gen_qemu_ld_i128, with the proper atomicity flags.


r~

