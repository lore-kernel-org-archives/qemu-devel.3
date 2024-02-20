Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C45C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVPC-0004pQ-6A; Tue, 20 Feb 2024 14:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVP1-0004gD-0s
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:03:39 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVOy-00027i-5L
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:03:38 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e471f5f1a5so1235251b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708455811; x=1709060611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+g+GZVafJ1oguRWp2Kg/YwMwzgEJPqO2nFWJGRm1jow=;
 b=mFxjAyVvUFq1KqalSnmEBoYZYJy04eTUfRLkSrGNaJS7x6jRqjI7vJkP/L6s+x3+gr
 qy+Ri9Oj7XxZwgoc8dbXmG5i+/WKiT6i4hqCYgQIjCQnDJ/WJmkWAn/qwQBVLsBhxEPN
 SxYH4Seu3tr0CqFmvlC97CK5G9Ak0idiHKvArcOSGkANvapoaQFioQG2quJjOsri2z8i
 NsY5GbeQbKuD7cmAPmZk8LrYvMjeSCmZcfOGDHcP8hJz7tV3TQOYQqqsKjq88iZHhDyW
 DtqmOyoHDLok54Rquro28QcGXgNrQGE0JZsqovDCrIpUKh8qE7xfuI7uBFPsR1T3K8Rf
 nCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708455811; x=1709060611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+g+GZVafJ1oguRWp2Kg/YwMwzgEJPqO2nFWJGRm1jow=;
 b=Z97N7wbqMbkdksV0Qr4EEnGBOeEuKyUltrsPdAEAB2N5URUwdEsZ+v+X2192Yz2Man
 38WGMI3bCW66AeF5mfovGN0sSONaoyDuR93/WmZipfcAjSptRPiuSyHu4fVuayb8O7Sb
 f/57JOy2ik4Y53ZFeJcknq5r5h6TgilBz/r6yNCaEduxp/gQQs2CWHYFozGFmiMuAm35
 8+ospoqphVaWmEM8aSmtgUncGnTxhH0PQUDkAio8f04DQimZpqOiWCJQj7eDixMYAbdT
 vBNTq+Mq8NwwOYJWq5RsP7Tol7rmwYcs+DI66PWHw4lqlFWjyWhtKZlcEsJYLgQeDnF6
 45dQ==
X-Gm-Message-State: AOJu0YxK0mL4liz9Ejhz2QpAcssGU8R3hlZU6a4pL1Bqy4lCYJ9vJ9wj
 9px4OpgM1Obn1vd/IpV0kHrhooRT7xlZafcAVuQVHohpLwBthHn6Voko98bG27Q=
X-Google-Smtp-Source: AGHT+IH7VKiSpvM9ogj93SoBUPkaZOZu8v6BqchMhHprVzb80g/KmBQkFEVotgT7/ns1iXotUmPoIQ==
X-Received: by 2002:a05:6a00:2196:b0:6e4:5dc0:233c with SMTP id
 h22-20020a056a00219600b006e45dc0233cmr8594776pfi.6.1708455811038; 
 Tue, 20 Feb 2024 11:03:31 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 f10-20020a056a000b0a00b006e02f4bb4e4sm7457346pfu.18.2024.02.20.11.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 11:03:30 -0800 (PST)
Message-ID: <0aa2515e-55ef-4472-a567-1545c7e5f1ed@linaro.org>
Date: Tue, 20 Feb 2024 09:03:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] target/ppc: Implement reservation protection for
 larx/stcx
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240220041922.373029-1-npiggin@gmail.com>
 <20240220041922.373029-4-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220041922.373029-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 2/19/24 18:19, Nicholas Piggin wrote:
> +    env->access_type = ACCESS_RES;
> +    host = probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, raddr);
> +    if (host) {
> +        cpu_set_llsc_prot(cs, qemu_ram_addr_from_host_nofail(host));
> +    } else {
> +        /* XXX: fault? */
> +        g_assert_not_reached();
> +    }

probe_access will not return a host address for lots of reasons, including watchpoints, 
plugins, etc.

> +
> +    if (unlikely(size == 16)) {
> +        Int128 val16;
> +        val16 = cpu_ld16_mmu(env, addr,
> +                     make_memop_idx(DEF_MEMOP(env, MO_128 | MO_ALIGN), mmu_idx),
> +                     raddr);
> +        env->gpr[reg] = int128_gethi(val16);
> +        env->gpr[reg + 1] = int128_getlo(val16);
> +        return;
> +    }
> +
> +    switch (size) {
> +    case 1:
> +        val = ldub_p(host);
> +        break;
> +    case 2:
> +        val = FIELD_EX64(env->msr, MSR, LE) ? lduw_le_p(host) : lduw_be_p(host);
> +        break;
> +    case 4:
> +        val = FIELD_EX64(env->msr, MSR, LE) ? ldl_le_p(host) : ldl_be_p(host);
> +        break;
> +    case 8:
> +        val = FIELD_EX64(env->msr, MSR, LE) ? ldq_le_p(host) : ldq_be_p(host);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    env->gpr[reg] = val;

Passing in size and performing a switch on it is not the best organization.
You should use multiple helper functions with a common subroutine to handle the llsc 
setup.  You should pass in the whole MemOpIdx.

> +#define MEMOP_GET_SIZE(x)  (1 << ((x) & MO_SIZE))

This is memop_size().


r~

