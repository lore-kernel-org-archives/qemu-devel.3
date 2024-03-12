Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36BAC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2dd-0006Ay-A6; Tue, 12 Mar 2024 09:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk2dX-0006A9-On
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:57:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk2dW-0006il-9h
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:57:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd796a6af3so24686265ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710251865; x=1710856665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BO6i2ZpokBqDmieHzG06yAaOGAeHAu5NfaKROpAZiE0=;
 b=FqQSr63FeFiD76lgaVcFSua/0oKejNE1QPu5Ff4jVeYJN4Xd6JbYbSfs88kys9abhw
 dqLZMJknntM78JTG22HBBK1HSKKiIak58IjJrGR/sx5v3f2gsiyjveTYbJVIIn1C8yGE
 Z9w3B8Pl9A8YcDnX+uyD+7C+shKhdLHuk4Lxk5aIuFSe01AgXd0W16IlCDnHcfYCxDp6
 Ps9RB3jbdr25VE3x01cvh8q+w/3n8GUxvbnHRvjKyUB9IsUe4q3gYizjynK+Ets3ctoN
 R/BVEXhwhYkZfaIt8AyckclqUhui+ZTFuBGSMyqIgF3XMMIyuQ38eVYUzEflBnpu+r0q
 9iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710251865; x=1710856665;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BO6i2ZpokBqDmieHzG06yAaOGAeHAu5NfaKROpAZiE0=;
 b=Qf5NXCtxf34w88kLnqUjUwVc5ZujwMZ2XR0JWDzzTVgKaOguBHwrgMXHsmC4h//qYB
 Cvf9h1aLPLQxFt/iEUeoZ5PFrB8ZpihEuURjjK6QMQtimmH2dZuJpzlV/uRSfOQsKrhc
 QXdDoMnDM9UPiT0u76pZxImDnO4KZfbMvJhYXCUVGtSo/6fyvXU4zn9kRF/AD2sNA1T3
 C1plFyG67J+8zAM1MdbeE1LCc6p4f7ruC0BpuPPzXoucfxhwmzSo6BDU2WT9vD/I8kzM
 PnjkCcccBG6YqyHw5paHQiT47WHctJKNOwXoOb4R8q98FqyridNaPXOI5G3CNqFO3Nhk
 MGEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWLyDTgGeueOlQy3bC3EEu/VWCpmyILq3LqbRvfbqcf8oBL9XsXel35t8xM+gojAM5l3fKPpOcbYuaGKefEMGPlP+7/4Q=
X-Gm-Message-State: AOJu0Yxn3lYtL2XX8soWDPqObKfToJM1n0cbR9LbGRg8KxLp6M2TkAo6
 XlVz3eiumjLOwjU5dCDc3sfwMdBzy0ctWTcFtVcf4SpOJwvQKruIKZh7TnJ6aw0=
X-Google-Smtp-Source: AGHT+IEUgFEAq8UU5Zkm06k3EFhnjU+RaFFCNJoBkxeYuofmox/Nm/T6QXk/LIx3opM0MjQ941JP8Q==
X-Received: by 2002:a17:902:ecc6:b0:1dd:a02f:c2d1 with SMTP id
 a6-20020a170902ecc600b001dda02fc2d1mr523866plh.19.1710251864702; 
 Tue, 12 Mar 2024 06:57:44 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ku14-20020a170903288e00b001dd69aca213sm6699334plb.270.2024.03.12.06.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 06:57:44 -0700 (PDT)
Message-ID: <8f23924f-af5c-4bc1-94f1-143bc5c8184d@linaro.org>
Date: Tue, 12 Mar 2024 03:57:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Implement dynamic establishment of
 custom decoder
Content-Language: en-US
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240312054553.11811-1-eric.huang@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312054553.11811-1-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/11/24 19:45, Huang Tao wrote:
> +static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
> +{
> +    decode_fn *dynamic_decoders;
> +    dynamic_decoders = g_new0(decode_fn, decoder_table_size);

Allocating ARRAY_SIZE(decoder_table)...

> +    int j = 0;
> +    for (size_t i = 0; i < decoder_table_size; ++i) {
> +        if (decoder_table[i].guard_func &&
> +            decoder_table[i].guard_func(&cpu->cfg)) {
> +            dynamic_decoders[j] = decoder_table[i].decode_fn;
> +            j++;
> +        }

Potentially enabling all elements...

> +        for (size_t i = 0; ctx->decoders[i]; ++i) {

Reading past the end of the array expecting an extra NULL entry.


r~

