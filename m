Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C491ACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXM0E-0001Lm-8U; Wed, 10 Jun 2026 12:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXM0B-0001L9-BU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:42:03 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXM09-0007oj-EZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:42:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-842848fd613so5924882b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781109719; x=1781714519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vyw7zIyJf9SkknED0JnLpcttvibpiEiM5iVKY51g/w8=;
 b=mjNAWn6DSeBToKXNlannKoQgV9PEHga7NhL2IMw8Cmd3fOr1JJ7DKuOYeDoz+VCuAK
 9IPDqihxjEFcN/Yz/OmuhLOlMzQAya3Ef5SnaGL0YP6wE8U0/IgLvxE7Put0vBkDhW8v
 eqTSOXEpG+/SABpCAsi2OzOIdDiEevE0jJs0gZyUC5Z/WGJ0iXtewIGjqZOxLn0ok58O
 0LzsP6BQHpbmYZJtAYmYIgEHss/xA/mAkbiiYuHen7Xc9jD5gRKMxIdk4tDb1UcN6nhX
 G1/NLJgbamwi+7lz8mU4BfoyG6/cBdhNkwkWLnSV7ezW6R8GK7Ka8CtX7xsgCA+MfGZ8
 4uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781109719; x=1781714519;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vyw7zIyJf9SkknED0JnLpcttvibpiEiM5iVKY51g/w8=;
 b=KLTEYH2IazZpxDbCji7NHQKfl4NV0GdnGVL/I4eHDQKD/GNy6lZDr6i4A3dnKN5CAS
 ujd+WHhXmy5QcXljmnbHbr8X2/xcpvtWBCm8/AfGwB5uwcMGTAqU49ir3NDAYw27YhF9
 jYXTbhjktd/fxJJZNTOugeAtizWTQU8J6jph6c2GhPsKYoB5XvMoukXQ3eGTOZ5rFBZS
 dNct0Ynunu2MZyCKwstCKXi8U//02CBmU9y9KwcpvuSzNumMmmMo1vspsIx2MuJnFhg/
 WkYg2i1iZZw7SDWy83QHov+LALfJIKcCLLVyuPqvC5Rk+QnLSr0SPuPbnQQSASXFd9/c
 A5HA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xdc8pyB6o0BToXl2yV0ZHHJpgOECdZewpyv6CO/U6pk3NUfZn6QCuEGx2Vd0E9SbknT4VDq0+aQ+g@nongnu.org
X-Gm-Message-State: AOJu0Yz2lTQmm+L6I6MT1UVGWn/oV9DXD1JcXAt++KuGtKoT50yP2xmU
 GekuKdEERXBvQ/tUxnH44mCFBUv7jCA7lIFlz8onwfZ6/dBAzDKC+NZNVePv+Q8nyDNEhCeno1K
 4AZfIRwo=
X-Gm-Gg: Acq92OHpOgdtx/izv7xS1IoChrcDRgp/1Y84YNPUCQxk9ZJ/U51MZWAF5rAZMUj/Sr3
 8Ss9yXVnqB2oOxSJZqKr+QPNC7NQ+iQLV0E5jqx/5xmIZ1dn6h4R3FuWang4IFlcAu/1Gq+ovAT
 GKQ/Qo3s1o6YxRh/QbmJrgDlvii0D60GSlwkaIbNWZj0r7CaPvoqp+JNyLsvzAKHGU6B0unq7vM
 QqyyQcI1AEV3gb99o+8ootHAGdR6b100irAT7c7aB50OxU0GtTEkute/xSSBUIRGDeq14BPRjLG
 0kucnbWF2B6T+Emr7b2vf7d2Urht7ItAGRHWruw48mPshmWBZ577Nukwp6IPpiQuu7aEhtLjVVT
 BtuvNqH2EFQUGIkUSemlluGA5Jf7wYhwQOT9N/eLS+vfx0ji4p0CIc6KlNMHm3MraNXKhsdJlnv
 rm3LxthBE3kXZGqx6Yzzqr1kpGKtW+0zUxNQSdBAqRa5uEs1I=
X-Received: by 2002:a05:6a00:391d:b0:842:2f09:fde9 with SMTP id
 d2e1a72fcca58-8430a62fa44mr9226125b3a.8.1781109718551; 
 Wed, 10 Jun 2026 09:41:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828cb2bdsm25640656b3a.41.2026.06.10.09.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 09:41:58 -0700 (PDT)
Message-ID: <7615fda1-4052-4696-b477-6eacc057c4a5@linaro.org>
Date: Wed, 10 Jun 2026 09:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm/ptw.c: Add Granule Bypass Windows
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
 <20260603-jmac-gpc3b-v2-3-115c51936962@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603-jmac-gpc3b-v2-3-115c51936962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/3/26 11:26, Jim MacArthur wrote:
> +    const uint64_t BW_STRIDE_SHIFT = 40;
...
> +        switch (bw_stride_field) {
> +        case 0b00000:
> +        case 0b00010:
> +        case 0b00100:
> +        case 0b00110:
> +        case 0b00111:
> +        case 0b01000:
> +        case 0b01001:
> +        case 0b01010:
> +        case 0b10000:
> +            bw_stride = 1ULL << (bw_stride_field + BW_STRIDE_SHIFT);

BW_STRIDE_SHIFT should be 39 not 40.

Everything else is correct.

However, we can simplify:

     bw_mask = bw_stride - bw_size;

contains the bits [gpcbwu:gpcbwl].  Then...

> +        /*
> +         * GPCBW is invalid if the base address is:
> +         * not aligned to the size programmed in BWSIZE, or
> +         * greater than or equal to the stride value configured by BWSTRIDE.
> +         */

     if (bw_addr & ~bw_mask)

tests both conditions and...


> +        uint64_t bw_size_mask = MAKE_64BIT_MASK(0, bw_size_field +
> +                                                BW_SIZE_SHIFT);
> +
> +        if (bw_addr & bw_size_mask) {
> +            goto fault_walk;
> +        }
> +
> +        if (bw_addr >= bw_stride) {
> +            goto fault_walk;
> +        }
> +    }
> +
>       /* Note this field is read-only and fixed at reset. */
>       l0gptsz = 30 + FIELD_EX64(gpccr, GPCCR, L0GPTSZ);
>   
> @@ -431,6 +494,23 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
>           goto fault_fail;
>       }
>   
> +    /*
> +     * Bypass window check.
> +     * I_JJLRM: Granule Protection Table (GPT) lookups can be skipped
> +     * in portions of the memory map by using GPC bypass windows.
> +     * I_XNHTX: The GPC bypass window check (...) is performed
> +     * immediately after priority 3.
> +     */
> +    if (FIELD_EX64(gpccr, GPCCR, GPCBW)) {
> +        uint64_t bw_stride_mask = MAKE_64BIT_MASK(0, bw_stride);
> +        uint64_t effective_address = paddress & bw_stride_mask;
> +
> +        if (effective_address >= bw_addr &&
> +            effective_address < bw_addr + bw_size) {
> +            return true;
> +        }

     if ((paddress & bw_mask) == bw_addr) {
         return true;
     }

is exactly the check in PAWithinGPCBypassWindow.


r~

