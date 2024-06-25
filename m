Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0256C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 23:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMFuW-0005mM-Jy; Tue, 25 Jun 2024 19:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMFuK-0005a3-E8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 19:49:05 -0400
Received: from [2607:f8b0:4864:20::230] (helo=mail-oi1-x230.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMFtO-0006dt-5t
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 19:48:43 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d552600917so1248230b6e.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719359191; x=1719963991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fSSKCItYz8+su55zaCeDfZqGcLGOvzO1zgA32uDbBb8=;
 b=bFOvCvJGlvhaMTXGW7EA8/zrQqn161UdjBk+b3SuN/xgU8fhPEIPuPbSN6oLEPxedL
 oRV8FwKgFwpz6VG3K36NzsgCvdxxoswrCFhUGMIM/yPOa109JxxiJ1gcEiAzr8OZfoAR
 ztNcH6BajJto4V2Rvy0skBa8J5lo5F72IHlfY+gm4eDMVuxTMk3dzH5k0svv0APREGVC
 P4zKZje+uVjai5iltV9uKdJGS2+b6vzDUaWnR7P9CAvL0Id5kQwupuDcxg6OkcmoyNT8
 93cc2Zd98Q9De7nd9p0Q+eADLQRDwQ63FPx2qhGxjVB+VyC/FXzL258P4LiDf7X/Iz4Y
 FUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359191; x=1719963991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fSSKCItYz8+su55zaCeDfZqGcLGOvzO1zgA32uDbBb8=;
 b=c8T1fFvqzZ+qWlMgGuotFPPC6GrQBNInsv9bhfJ94V2Yi04Rg7O1WzIooNkW2A1i4s
 grC/5Y/glzt4al2/1Ruo8xoLvEu+18Y6VU3WoRiPv2Ra+0QfoiKsHXOrCdg2TKz/nis1
 8UjzQE6lmV1DLYexz7+mhp166aYYIlgJPneT4mMc2UNc2tsm6sBCYcxRbdTO61vJ56cc
 kPwotsb8x4Ux5wUR5z55ZZUsjy/p9GF22N1klOAyHB9A5b5wQPwIuXJJKJtql+8hJtjE
 9g7lqL3QP6jegrBislApQ39tvyz/91jUPoiwq8eWfou4dj7pCSHc4sn8svg+Hl0qxYct
 01+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWRPvDPQnbf7+dyDNHPOZhJpyr6QbkcEw2VfkXt1c1UPpfVHHk85adj+KzRkBJ9qLtIFvCB9xBfBFCUy1M/EtJYjYkhkY=
X-Gm-Message-State: AOJu0YxlFo/x0r2gCyfm0VPs0Fd10X7PJDd0nHuOg28Rz+HfYbYDOJ2d
 qU4XL0Sp6Xus8PEkiLAyJBBJQAfQsuhMtlAsutpIFQ0NPCYHPRH1+qAwlMpwxMUzz9GMvXUYC70
 e
X-Google-Smtp-Source: AGHT+IFvVr28JLQAg9NoI+p/5/VRlo4mG2mg4ER6rd3Lc8iRdJTjdFIgre4+/paZJnIEh2MiCiBcsQ==
X-Received: by 2002:a05:6a20:3944:b0:1b5:cf26:ecfd with SMTP id
 adf61e73a8af0-1bcee6f0162mr11027723637.24.1719339511426; 
 Tue, 25 Jun 2024 11:18:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716bb22d45fsm7482622a12.86.2024.06.25.11.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 11:18:31 -0700 (PDT)
Message-ID: <2cb94b34-1a5f-4dc9-bec4-78c7008cd79d@linaro.org>
Date: Tue, 25 Jun 2024 11:18:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Add support for machine specific pmu's
 events
To: Alexei Filippov <alexei.filippov@syntacore.com>, palmer@dabbelt.com
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20240625144643.34733-1-alexei.filippov@syntacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240625144643.34733-1-alexei.filippov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::230
 (deferred)
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_HP_HELO_NORDNS=0.001, RDNS_NONE=0.793,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 6/25/24 07:46, Alexei Filippov wrote:
> Was added call backs for machine specific pmu events.
> Simplify monitor functions by adding new hash table, which going to map
> counter number and event index.
> Was added read/write callbacks which going to simplify support for events,
> which expected to have different behavior.
> 
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> ---
> Changes since v2:
> 		-rebased to latest master
>   target/riscv/cpu.h |   9 +++
>   target/riscv/csr.c |  43 +++++++++-----
>   target/riscv/pmu.c | 139 ++++++++++++++++++++++-----------------------
>   target/riscv/pmu.h |  11 ++--
>   4 files changed, 115 insertions(+), 87 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6fe0d712b4..fbf82b050b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -374,6 +374,13 @@ struct CPUArchState {
>       uint64_t (*rdtime_fn)(void *);
>       void *rdtime_fn_arg;
>   
> +    /*machine specific pmu callback */
> +    void (*pmu_ctr_write)(PMUCTRState *counter, uint32_t event_idx,
> +                          target_ulong val, bool high_half);
> +    target_ulong (*pmu_ctr_read)(PMUCTRState *counter, uint32_t event_idx,
> +                                 bool high_half);
> +    bool (*pmu_vendor_support)(uint32_t event_idx);

Do these really belong in CPUArchState, rather than RISCVCPUClass?

Surely there's more to this series, since these fields are never set...


r~

