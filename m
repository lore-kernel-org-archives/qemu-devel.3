Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E799EC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoar-0001e8-Df; Tue, 30 Jul 2024 11:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sYoaq-0001ZT-FE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:16:52 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1sYoan-00068N-V8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:16:52 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so2888518b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722352608; x=1722957408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=37Fb13BCjBRvvlkCYxRKMLZNMBM8CohbE2jyNZ9/PWI=;
 b=TISaLY0ILyGSSUAnHdYWVdjcK93cugviIiQoEG0iBj63gQpx7yymDACIvokY2dtROO
 2rsnpt2UTaSSojU3tHBQv7DqkpAQxuNCs9zAsPYxtOURVwI284Q2GYwNgmviM0aZS/3c
 eCQlqWrPW1iAU07mMSA2Q1FF3Pk29akF+GusSgN5dErQGdn07Cls6O5GWii31bueecTU
 lj635uQrM0D2J5O6NQPqEKmTAJ2S8yXIVfdyNqR5PfyOgXCcn0dD/H2aLqW6B1TpEvgN
 JYeb69PIvxNDUIHZhEcHyX8g59hh/z3V24VVkMgheeC2MIxCPzjRZE6dk6v6PI2kp5H+
 nMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722352608; x=1722957408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=37Fb13BCjBRvvlkCYxRKMLZNMBM8CohbE2jyNZ9/PWI=;
 b=IwJoyq+Q4krt2qlTBIscTFHSgkzFGTIF++0uOMijxFKwmClfMtBwIlDVDPwlPHOCJ2
 l3iylg3NpvfM356OPEIQWh5IC6Ku/hkrKD5Bh7dBKGTe2/Xdw3l0ariJLtEZtS5GD6dS
 MztMndHwUjkM9e2pyUs+k6JP78/SYdbTcK1AI3uDVdIw2Qbiu/cwdVlP3PJzW32/Oj4s
 UGCgJnbU8anbjrfrA9WVrckWYFA46C37dseLXGW3K98twdJdjuy1/qd0o3YSRBR4WpPz
 iAN0eEuQj+l0BoO7PjjDtAA6jJkkhjMUyu6ptFULa7IUxV1dnVXyHAWwG0Vf262gDj6a
 SGSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyBmiB8HhOtBKMAnt3gQbmPjINBrk14EqZGvhrMPCpGUC5RbAE91UxfEmkLLAxSR8oF4I+g9UdGL34Qe8YirOnkP7K55w=
X-Gm-Message-State: AOJu0YzU776Whx1Ww77ZtII3v2qEC8vtm6Tkm2WWZOKrIiQme6AmwM7y
 ZyGn3yGi69dvlB+hvA7jMTpNfQJapEZDpOz5IWBm3K6BYCeqpdGFlNhJxxi71ek=
X-Google-Smtp-Source: AGHT+IEq4gm/qiF9FbwngCVh8zsFQCMPMxat9DRUY1H7xqM0l8SsCCvMJJCIpCtZzQxs2n1PNBk/lQ==
X-Received: by 2002:aa7:888a:0:b0:70e:cee8:264a with SMTP id
 d2e1a72fcca58-70efe400da0mr4453608b3a.1.1722352608352; 
 Tue, 30 Jul 2024 08:16:48 -0700 (PDT)
Received: from [100.64.0.1] (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead712f25sm8520670b3a.81.2024.07.30.08.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 08:16:48 -0700 (PDT)
Message-ID: <679899fa-af2a-4863-93cf-f17fffd57cac@sifive.com>
Date: Tue, 30 Jul 2024 23:16:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 4/5] target/riscv: rvv: Provide group continuous
 ld/st flow for unit-stride ld/st instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240717133936.713642-1-max.chou@sifive.com>
 <20240717133936.713642-5-max.chou@sifive.com>
 <17b9f3cc-1ad7-4e79-8693-1f327f9bd5a6@linaro.org>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <17b9f3cc-1ad7-4e79-8693-1f327f9bd5a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x429.google.com
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

On 2024/7/25 2:04 PM, Richard Henderson wrote:
> On 7/17/24 23:39, Max Chou wrote:
>> +static inline QEMU_ALWAYS_INLINE void
>> +vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host 
>> *ldst_host,
>> +                        void *vd, uint32_t evl, uint32_t reg_start, 
>> void *host,
>> +                        uint32_t esz, bool is_load)
>> +{
>> +#if TARGET_BIG_ENDIAN != HOST_BIG_ENDIAN
>> +    for (; reg_start < evl; reg_start++, host += esz) {
>> +        uint32_t byte_off = reg_start * esz;
>> +        ldst_host(vd, byte_off, host);
>> +    }
>> +#else
>> +    uint32_t byte_offset = reg_start * esz;
>> +    uint32_t size = (evl - reg_start) * esz;
>> +
>> +    if (is_load) {
>> +        memcpy(vd + byte_offset, host, size);
>> +    } else {
>> +        memcpy(host, vd + byte_offset, size);
>> +    }
>> +#endif
>
> First, TARGET_BIG_ENDIAN is always false, so this reduces to 
> HOST_BIG_ENDIAN.
>
> Second, even if TARGET_BIG_ENDIAN were true, this optimization would 
> be wrong, because of the element ordering given in vector_internals.h 
> (i.e. H1 etc).
Thanks for the suggestions.
I missed the element ordering here.
I'll fix this at v6.

>
> Third, this can be done with C if, instead of cpp ifdef, so that you 
> always compile-test both sides.
>
> Fourth... what are the atomicity guarantees of RVV?  I didn't 
> immediately see anything in the RVV manual, which suggests that the 
> atomicity is the same as individual integer loads of the same size.  
> Because there are no atomicity guarantees for memcpy, you can only use 
> this for byte load/store.
>
> For big-endian bytes, you can optimize this to 64-bit little-endian 
> operations.
> Compare arm gen_sve_ldr.
Thanks for the suggestion.
I'll check arm gen_sve_ldr.

>
>
> r~


