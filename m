Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A8C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUJG-0006mb-VM; Wed, 13 Mar 2024 15:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkUJE-0006mI-QL
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:30:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkUJA-0002Mz-QC
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:30:40 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so1326745ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710358234; x=1710963034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gRwwGWz9KP/1WQutJ1UhzyGPLs3PXgcwcBdlN0sW2XM=;
 b=eiNh2clegnGAI+Vjn67Qobr6YYUzIx55Nepd97M4IKR08H8PisWt5RwZQqCOBrA6a7
 no2NIOl8Ag1GJ+iPEtVtutN+uw8hckV4TRyDO0VxiaEAD+kUCberVf7L38HaoDyiyMKU
 Z0gi67eGwni1MVdommrxwIHfLI7u4mXbPGoEtKwvAuXc79PIVTMRYUDMXXYPp6Xn2V/x
 fBOIVyo4DpxywmrNmYyMhWLB8pL9iUBvNHa2Jmy3gE27JKLNPesicX8My+mbE24iypK5
 a+qR/sCuscrg9Jn8XqnGiLoxT99Z9VtzwMiGC9aBMJfIVQuKhCJlkuC7a6XfKtfnBm0M
 Cxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358234; x=1710963034;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gRwwGWz9KP/1WQutJ1UhzyGPLs3PXgcwcBdlN0sW2XM=;
 b=inKQmfMYKQbe/FQUbyrC/kA3a/3N5uR+0ktUllWbnWexHFt5hXQhOWIS2k3UYvG2ua
 nWNGnLWHJpwQZyxglZjUUNKFd4bezsSOb1I5URLU9mjicjeRLVV2pT3AAK6JDCA7L7pR
 MC2JOJYfIeim4A+IiTox4LrWaEaJnD7aqrgxlHmrTntIS0LBlv747edwCqxOws063aI1
 EktfX2SrvRkDbxeodRXhLFd3Q0z3IpIEUnjbUlELlXZoGMSrLkJL26O5/cVAidl5aAFy
 7Gr73IBrn+skw853yTkwUi+E1F25s/V40KtqgrMuWNzENmlTBKm/CdJB/su8KIgy2bmr
 ceAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoHdsHUUPYq6Ng7NnXKtiEUctc2fMUPjlT05OhZhkczCOr6CBWMCSC+vJZxH1GMoeMMqif0CDr12NwYVxM5vDCcIv5I9M=
X-Gm-Message-State: AOJu0YyDlSYxYm+n6uiM2M+Q3n9LZ9EjXrKLZ3Q2GtjOn/iH0ICnx/kN
 558U3EQFVQHNWFPap77EeNURa7AsX4951cjjZS8SA+xi1XzSMOTCmY2iJPTsOtA=
X-Google-Smtp-Source: AGHT+IFAli8TX3sct3p0xmJS4kp7/pOpDPNvGWD8d3dwIfIASW+VMZb1bOI+EogDU19YPv0TN/JnMA==
X-Received: by 2002:a17:902:dac2:b0:1dd:bdf6:3744 with SMTP id
 q2-20020a170902dac200b001ddbdf63744mr5857921plx.17.1710358234656; 
 Wed, 13 Mar 2024 12:30:34 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ky14-20020a170902f98e00b001dd61bc14f2sm9100329plb.8.2024.03.13.12.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 12:30:34 -0700 (PDT)
Message-ID: <731fa1ad-5831-4b94-bea4-c57bce01a260@linaro.org>
Date: Wed, 13 Mar 2024 09:30:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/i386: Enable page walking from MMIO memory
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, linuxarm@huawei.com
References: <20240307155304.31241-1-Jonathan.Cameron@huawei.com>
 <20240307155304.31241-2-Jonathan.Cameron@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307155304.31241-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 3/7/24 05:53, Jonathan Cameron wrote:
> From: Gregory Price <gregory.price@memverge.com>
> 
> CXL emulation of interleave requires read and write hooks due to
> requirement for subpage granularity. The Linux kernel stack now enables
> using this memory as conventional memory in a separate NUMA node. If a
> process is deliberately forced to run from that node
> $ numactl --membind=1 ls
> the page table walk on i386 fails.
> 
> Useful part of backtrace:
> 
>      (cpu=cpu@entry=0x555556fd9000, fmt=fmt@entry=0x555555fe3378 "cpu_io_recompile: could not find TB for pc=%p")
>      at ../../cpu-target.c:359
>      (retaddr=0, addr=19595792376, attrs=..., xlat=<optimized out>, cpu=0x555556fd9000, out_offset=<synthetic pointer>)
>      at ../../accel/tcg/cputlb.c:1339
>      (cpu=0x555556fd9000, full=0x7fffee0d96e0, ret_be=ret_be@entry=0, addr=19595792376, size=size@entry=8, mmu_idx=4, type=MMU_DATA_LOAD, ra=0) at ../../accel/tcg/cputlb.c:2030
>      (cpu=cpu@entry=0x555556fd9000, p=p@entry=0x7ffff56fddc0, mmu_idx=<optimized out>, type=type@entry=MMU_DATA_LOAD, memop=<optimized out>, ra=ra@entry=0) at ../../accel/tcg/cputlb.c:2356
>      (cpu=cpu@entry=0x555556fd9000, addr=addr@entry=19595792376, oi=oi@entry=52, ra=ra@entry=0, access_type=access_type@entry=MMU_DATA_LOAD) at ../../accel/tcg/cputlb.c:2439
>      at ../../accel/tcg/ldst_common.c.inc:301
>      at ../../target/i386/tcg/sysemu/excp_helper.c:173
>      (err=0x7ffff56fdf80, out=0x7ffff56fdf70, mmu_idx=0, access_type=MMU_INST_FETCH, addr=18446744072116178925, env=0x555556fdb7c0)
>      at ../../target/i386/tcg/sysemu/excp_helper.c:578
>      (cs=0x555556fd9000, addr=18446744072116178925, size=<optimized out>, access_type=MMU_INST_FETCH, mmu_idx=0, probe=<optimized out>, retaddr=0) at ../../target/i386/tcg/sysemu/excp_helper.c:604
> 
> Avoid this by plumbing the address all the way down from
> x86_cpu_tlb_fill() where is available as retaddr to the actual accessors
> which provide it to probe_access_full() which already handles MMIO accesses.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: No change.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2180
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2220


r~

