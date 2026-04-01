Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E541076370
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 05:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7oJ6-00011T-12; Wed, 01 Apr 2026 01:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7oJ3-00010i-Du
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:39:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w7oJ1-0003do-Lv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 01:39:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82ce2e2880cso871242b3a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 22:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775021994; x=1775626794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XqueuQwqQtL5mX0BN5SGNY61bqH8nYM8SRr+yt9YG+4=;
 b=vdY4tnB9qluH2xPM4AuTyyE564t1+GqyF5OhT9/H34TIs9/PM3YONuMEV2j+3Eofll
 X5UZMeFfnvQWUMgo1FbPzSuQGshNf+72sG+mX+6jAhTBNjYblCBACPg6Rfx4lZybnOy6
 vil1LcvqQGX0NsJGhAr2hqBm7oSuPiTxjfNseyoWPHc6RP5C9Iawv14b4dtinD9j9XTN
 wgVHi7N4BLp6pjc7efYhlWBhxD+McNFSO6mlztkeToHL0+v5K3iN0y6nrMfj9EwtuOv5
 DD/v9Og6i2pF2Iuy4j2vBLKy8HgZvYsJWb/W3DsRs3X3d/TaM4SVvpmS5LJY/eJH60rK
 7UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775021994; x=1775626794;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqueuQwqQtL5mX0BN5SGNY61bqH8nYM8SRr+yt9YG+4=;
 b=rQXZ12tfal5ZP/o688peC82SnnqmLnaOAvqmiXSwCrYVUizgccjNmrygRT2n74KlDJ
 Bj5aF4H8WasPDMdpHAO1Wo8tKASdoOHtyDIsiKFgQvBE8GNsKqaki2kaJF0YgA16/Jz2
 YoLvDuVQdO2urtkPyHSDIIn76a+sy/V8X/laIGTSvA/1Rlcx3Bm5mBTVbh9AyJf80Nvl
 wSMKn9SI7JCccQKZFA7JJHkdQtN5YouZLPRdJRF0LhUzlLhHxYF6a2jIBwBtlHLdsztT
 wG9MAF+zIHaVkgz5mTXpR4oJNh+mazVrGm47CB/p1FiB3vwpP9TdSPDSU1f9ztu4h8tz
 jZMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv/kHwy8vg/Uu7TGnahaQvV61Ot5RrDdzzD24YVO/sQaVzvG+k51djbKzXKL9tikyF3HF23lp9YrQF@nongnu.org
X-Gm-Message-State: AOJu0YwgvDnSojEUTO6CVR2CibZprUyEht3EaC8IvRR9Tk1NHIuaWbnI
 xeg4+xTSYxDeKd83LLzVHwxUQ48K91vElwF1gi/SIn+4tcqtB4KK41UYgVt5Wo08oc0=
X-Gm-Gg: ATEYQzwIYlJ8GjTAR355xz9nD1ijMKVCJhNZ7ioXvI9e+QkQ+j6ZL0G+0la79W8I78s
 /Nb61EaTob6yBpOP6ejlbB84i72kLr5W9TTGwVGSSgInabQo5Z0yW50IXPCksStrOoY1tjk5yAZ
 l9176/HpomYudrsiM3mf/2nBdVVPKfQdM8XVQxPRr13QmD83KWSvHpvejMT8Aawxw9RO5H0nR41
 Ug1dHq7MQzua/ihiZbncqLFexM/cIyKKTord7PMGQ7k7BN7TlDPpV7ixfJBVHW6fTZl1CklcFax
 xV1dp2L5NiuKIRGdsQ+OecqaFniBBwEJh+U59P4MN8jdki/Tsq8/o5u4/0YttZwEbmyjbFM64nL
 UYzIlRHKCuJx7mJ9RtcQUbzghTDLdZD9lMyCngHwZvq7DdSvxAosT3wJc8q4H3u9u/p757yKerW
 pw2Vq8frMP6RlMTTxLzy+BdCFhc4tHObgxHkjxvPKZE+8qlbj9ql7p6zxNI3eQacsi/5TzmYtWB
 qk=
X-Received: by 2002:a05:6a00:278a:b0:82c:68f6:a18 with SMTP id
 d2e1a72fcca58-82ce89b58cdmr2456807b3a.34.1775021993955; 
 Tue, 31 Mar 2026 22:39:53 -0700 (PDT)
Received: from [192.168.68.76] (122-150-206-208.dyn.ip.vocus.au.
 [122.150.206.208]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cec36da5fsm1537393b3a.2.2026.03.31.22.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 22:39:53 -0700 (PDT)
Message-ID: <ce24436b-ce06-4f15-bcb9-4c7a7ee10c94@linaro.org>
Date: Wed, 1 Apr 2026 15:39:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/35] target/arm: migrate system/cp trap syndromes to
 registerfields
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 3/20/26 23:05, Alex Bennée wrote:
>   static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
>                                           int crn, int crm, int rt, int isread,
>                                           bool is_16bit)
>   {
> -    return (EC_CP14RTTRAP << ARM_EL_EC_SHIFT)
> -        | (is_16bit ? 0 : ARM_EL_IL)
> -        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
> -        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
> +    uint32_t res = syn_set_ec(0, EC_CP14RTTRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);

!is_16bit.

> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
...
> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
...
> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);

Likewise.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

