Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA834D46607
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgRQI-0000Zn-Ik; Thu, 15 Jan 2026 12:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgRPR-000070-UP
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vgRPP-0007D3-8B
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768499121;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwuuURJOphYbKG+K5Cg50gwJY5ISiq0Af9cSrz+ssII=;
 b=T7aGKkaygW1//TcY6PQFgYu7IIjWhLCVHoqP+6cJNnD56PwlmOx8cH0KmcOWyo+CdoKIFs
 Ypctoat+DVY80XSKIof2eV2tEDGsF0bRRJlX+LiivdSWadnr7PVn0s9yLevKfGYoUUr6y8
 YYcU1H1c8BST4/zowPhleIdnx1uXm6Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-rOn8HcCjNKCxPVbXNMkM8w-1; Thu, 15 Jan 2026 12:45:20 -0500
X-MC-Unique: rOn8HcCjNKCxPVbXNMkM8w-1
X-Mimecast-MFC-AGG-ID: rOn8HcCjNKCxPVbXNMkM8w_1768499119
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso997337f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768499119; x=1769103919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwuuURJOphYbKG+K5Cg50gwJY5ISiq0Af9cSrz+ssII=;
 b=adS60XS130IiTttNpL9RIDvqGQNjYexM1YVESgcRoOiLHSMAgj8O9KsNIjkOMYDQLm
 kv62QE0okX+H38FfphlHri5gPhLlgWAodAmfsOwxb9SFkH4CajkY2PkJn1UOxbiuouQ+
 6vqO9kp7PC2RdkU71b6sNugn4dOUQRaXdU+i07hZ41WDI8FUjApewqOsHJyaD/gVs91T
 jX271V1RQmz0UujgLpBJql0UNrDRtXyPrn7yzheXHYvuxd4ADiYuSWJDudTxkTvdKQ5L
 c+3eqxKWYuqOi18ORjuE2xzAMnt5M4W+sBkgvnZQoS4TYxbO1Ys/hjuHS65+6UaYruv3
 VuJQ==
X-Gm-Message-State: AOJu0YzmC/DKf5LUBOxGq4rt/Z7RNnSRMeUOgiW7lUXPCMnYFzPaTsGL
 ZPAh42G6to1jRIT2iJmBJq7JAn8i7trn9pDNNSatV/TQg3Z8SWTjFyEsnvy4OaqtkJuQCrKwlT3
 WsxIrpiBmDiW9TcAOjRYG8J2ABCxzDu6v+HLQOfw8cNqnuAKYk+r2i1U7
X-Gm-Gg: AY/fxX5sk5t/jRv+q6L5PzWpXkVSQry2WoS0EKoqYOmVguwTwgjK+6aHuyTt1RGPYeD
 dgZr8z9pJEpXDNzBcr5fQ95lGTlYQYx8FG0FVSH60A9pULWtmVSfT3avM31v5a4ssK6Q3VDThn0
 fAz2e+4IQ75maFpLtJbvuxzE1xEMZSvMr9EabUn+gTCaQx6xHL0hmF7Z0ccHkqf85ACCZeqXDLg
 /83O+aDb2qu4EiRVlQ6pzFQpT/mM7IusK3C/HdOgKpxtWV/t1z9t5qnKlXPGxSpDfaH51KfPhAn
 QB4MIy6aL5LSMNr2waBvOCewgCEkFEE0Hw9IXZY9LIbIItEXM/2buOt+8ZA0/x8dFzp8RJACYSB
 QE9QwrC0oe9LdoUhO0z8vLlkF/xXg/5iiXDrh1Tc8NIjyQHaLhv8WLYX9Qw==
X-Received: by 2002:a05:6000:24c6:b0:432:bc90:2cfa with SMTP id
 ffacd0b85a97d-43569bbd3e8mr230593f8f.33.1768499118996; 
 Thu, 15 Jan 2026 09:45:18 -0800 (PST)
X-Received: by 2002:a05:6000:24c6:b0:432:bc90:2cfa with SMTP id
 ffacd0b85a97d-43569bbd3e8mr230563f8f.33.1768499118565; 
 Thu, 15 Jan 2026 09:45:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dedsm295479f8f.9.2026.01.15.09.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 09:45:18 -0800 (PST)
Message-ID: <eb30eab5-40b4-4635-aeab-6e7b62c233fe@redhat.com>
Date: Thu, 15 Jan 2026 18:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 5/7] hw/arm/smmuv3-common: Add STE/CD set helpers for
 repeated field setup
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-6-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251224034647.2596434-6-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/24/25 4:46 AM, Tao Tang wrote:
> This change introduces STE_SET_* and CD_SET_* helpers to centralize and
> simplify repeated field setting logic.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/arm/smmuv3-common.h | 79 ++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 7f7dd02221..0c6c162288 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -100,6 +100,37 @@ REG32(STE_7, 28)
>  #define STE_CFG_ABORT(config)      (!(config & 0x4))
>  #define STE_CFG_BYPASS(config)     (config == 0x4)
>  
> +/* Update STE fields */
> +#define STE_SET_VALID(ste, v)                                                 \
> +    ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, VALID, (v)))
> +#define STE_SET_CONFIG(ste, v)                                                \
> +    ((ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, CONFIG, (v)))
> +
> +#define STE_SET_CTXPTR(ste, v) do {                                           \
> +    (ste)->word[0] = FIELD_DP32((ste)->word[0], STE_0, CTXPTR_LO, (v) >> 6);  \
> +    (ste)->word[1] = FIELD_DP32((ste)->word[1], STE_1, CTXPTR_HI, (v) >> 32); \
> +} while (0)
> +#define STE_SET_S2T0SZ(ste, v)                                                \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2T0SZ, (v)))
> +#define STE_SET_S2SL0(ste, v)                                                 \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2SL0, (v)))
> +#define STE_SET_S2TG(ste, v)                                                  \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2TG, (v)))
> +#define STE_SET_S2PS(ste, v)                                                  \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2PS, (v)))
> +#define STE_SET_S2AA64(ste, v)                                                \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2AA64, (v)))
> +#define STE_SET_S2ENDI(ste, v)                                                \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2ENDI, (v)))
> +#define STE_SET_S2AFFD(ste, v)                                                \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2AFFD, (v)))
> +#define STE_SET_S2S(ste, v)                                                   \
> +    ((ste)->word[5] = FIELD_DP32((ste)->word[5], STE_5, S2S, (v)))
> +#define STE_SET_S2TTB(ste, v) do {                                            \
> +    (ste)->word[6] = FIELD_DP32((ste)->word[6], STE_6, S2TTB_LO, (v) >> 4);   \
> +    (ste)->word[7] = FIELD_DP32((ste)->word[7], STE_7, S2TTB_HI, (v) >> 32);  \
> +} while (0)
> +
>  /* CD fields */
>  
>  REG32(CD_0, 0)
> @@ -169,6 +200,54 @@ REG32(CD_5, 20)
>               (((uint64_t)FIELD_EX32((x)->word[3], CD_3, TTB0_HI) << 32) | \
>                ((uint64_t)FIELD_EX32((x)->word[2], CD_2, TTB0_LO) << 4)))
>  
> +/* Update CD fields */
> +#define CD_SET_VALID(cd, v)                                                   \
> +    ((cd)->word[0] = FIELD_DP32((cd)->word[0], CD_0, VALID, (v)))
> +#define CD_SET_ASID(cd, v)                                                    \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, ASID, (v)))
> +#define CD_SET_TTB(cd, sel, v) do {                                           \
> +    if (sel) {                                                                \
> +        (cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, TTB1_LO, (v) >> 4);   \
> +        (cd)->word[5] = FIELD_DP32((cd)->word[5], CD_5, TTB1_HI, (v) >> 32);  \
> +    } else {                                                                  \
> +        (cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, TTB0_LO, (v) >> 4);   \
> +        (cd)->word[3] = FIELD_DP32((cd)->word[3], CD_3, TTB0_HI, (v) >> 32);  \
> +    }                                                                         \
> +} while (0)
> +
> +#define CD_SET_TSZ(cd, sel, v)                                                \
> +    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, TSZ1, (v)) :     \
> +                             FIELD_DP32((cd)->word[0], CD_0, TSZ0, (v)))
> +#define CD_SET_TG(cd, sel, v)                                                 \
> +    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, TG1, (v)) :      \
> +                             FIELD_DP32((cd)->word[0], CD_0, TG0, (v)))
> +#define CD_SET_EPD(cd, sel, v)                                                \
> +    ((cd)->word[0] = (sel) ? FIELD_DP32((cd)->word[0], CD_0, EPD1, (v)) :     \
> +                             FIELD_DP32((cd)->word[0], CD_0, EPD0, (v)))
> +#define CD_SET_ENDI(cd, v)                                                    \
> +    ((cd)->word[0] = FIELD_DP32((cd)->word[0], CD_0, ENDI, (v)))
> +#define CD_SET_IPS(cd, v)                                                     \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, IPS, (v)))
> +#define CD_SET_AFFD(cd, v)                                                    \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, AFFD, (v)))
> +#define CD_SET_TBI(cd, v)                                                     \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, TBI, (v)))
> +#define CD_SET_HD(cd, v)                                                      \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, HD, (v)))
> +#define CD_SET_HA(cd, v)                                                      \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, HA, (v)))
> +#define CD_SET_S(cd, v)                                                       \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, S, (v)))
> +#define CD_SET_R(cd, v)                                                       \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, R, (v)))
> +#define CD_SET_A(cd, v)                                                       \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, A, (v)))
> +#define CD_SET_AARCH64(cd, v)                                                 \
> +    ((cd)->word[1] = FIELD_DP32((cd)->word[1], CD_1, AARCH64, (v)))
> +#define CD_SET_NSCFG(cd, sel, v)                                              \
> +    ((sel) ? ((cd)->word[4] = FIELD_DP32((cd)->word[4], CD_4, NSCFG1, (v))) : \
> +             ((cd)->word[2] = FIELD_DP32((cd)->word[2], CD_2, NSCFG0, (v))))
> +
>  /* MMIO Registers */
>  
>  REG32(IDR0,                0x0)


