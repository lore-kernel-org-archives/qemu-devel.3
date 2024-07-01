Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC5FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMmx-00069p-TH; Mon, 01 Jul 2024 15:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMmw-00067U-0d
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:34:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMmu-0007o5-3L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:34:09 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70671ecd334so2621603b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719862446; x=1720467246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=953zac8YzEaZx2Fy/uqMEP9JDN5KWwrfpGzdyur+3hk=;
 b=fwgFYWeR9b8fpIeSrgpnZ4YfPOTQ+pwVySdNRfAEbUFGaJUtNZocn4C4AwW6mklns4
 dv+x5CzloLJIYehT48a1WlrFktXFu8Ggmok8Mxt0GR0HlU4luef5Opjs1hXYCGZzCfqs
 tSsxfhNMT6wk0+xpjA5veXZWlzRoV234JTiKcnXg+fxafhwF2Wu9n4LeP4uU0DZfDPWx
 1aLoUJSFofhSTzyAufX8wBh219v+EuMFg8BxMLH/LW4/XTMbMUwzZyj6qTte05T560Sb
 pxnjhjLFruRbhai3UYQal8BS+4aNmD/9tWeh78T0R+wyarA3Z6NOk1YJevOG52ZhmnBt
 j2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719862446; x=1720467246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=953zac8YzEaZx2Fy/uqMEP9JDN5KWwrfpGzdyur+3hk=;
 b=jxRHjy63T703xnsOsxm5zzoaeyNqZb/ZoEoC9WZLFTQ0lZxYFaCAqlTZRa//LFG88H
 YtoxPtd2DBkJxg48H40vi508jL3JsmKJFPnpWzdN6b1CqBK8R2qRZIDJdsfwWjqtAnQB
 jsmGMGfAP2qTj32UvTs/zl3folzguw7saydl8e82dbIrE0RxKoMLtUidI1gD1qk+rfMZ
 7dWUn1SY38wTQPIFwN0hHGQkzAx7wQVfp0T6I/rhLGMeZmzF0g0DNFdki2Tk0OQcEDxs
 oqsdrKwU7+PpaXNM7izJRyzu2PqOxsCPFSay5bniMYCzEYdlBSNxWEOMRiEG40fgMPps
 P9cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS7nJTUZsvljgBTikrme3VNCk7+cwCUscqX/F+VxSaJXl/kgRHvZ20PyjxSsqsd2HdOlBs63h5a5HmiItLUU/VjsM9kIk=
X-Gm-Message-State: AOJu0Yxu7LU5JoabHXH+OCWK9yvWoyJ0PSrZeMYSG5eK66Q69ckaYyZK
 K2XLT48b/sEZcj03O96vWQXSrt58Y/qMTt8gkYz3x2QlvQPTP4RzY+2+9cewr30=
X-Google-Smtp-Source: AGHT+IFAM9nByRtU41bdSPNcQlZXsYADK+r3tuKUGiwF9ZEdWs3ujA27vx3iHgy6a2glsSvpIpUjDA==
X-Received: by 2002:a05:6a00:3c8e:b0:705:c0a1:61d8 with SMTP id
 d2e1a72fcca58-70aaad2af71mr8677726b3a.4.1719862446576; 
 Mon, 01 Jul 2024 12:34:06 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54?
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246c8ffsm6936516b3a.62.2024.07.01.12.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:34:06 -0700 (PDT)
Message-ID: <04078f2e-288e-477f-9b22-41f3bedc7f81@ventanamicro.com>
Date: Mon, 1 Jul 2024 16:34:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] target/riscv: Save counter values during
 countinhibit update
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-7-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-7-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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



On 6/26/24 8:57 PM, Atish Patra wrote:
> Currently, if a counter monitoring cycle/instret is stopped via
> mcountinhibit we just update the state while the value is saved
> during the next read. This is not accurate as the read may happen
> many cycles after the counter is stopped. Ideally, the read should
> return the value saved when the counter is stopped.
> 
> Thus, save the value of the counter during the inhibit update
> operation and return that value during the read if corresponding bit
> in mcountihibit is set.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.h     |  1 -
>   target/riscv/csr.c     | 34 ++++++++++++++++++++++------------
>   target/riscv/machine.c |  5 ++---
>   3 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d56d640b06be..91fe2a46ba35 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -153,7 +153,6 @@ typedef struct PMUCTRState {
>       target_ulong mhpmcounter_prev;
>       /* Snapshort value of a counter in RV32 */
>       target_ulong mhpmcounterh_prev;
> -    bool started;
>       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
>       target_ulong irq_overflow_left;
>   } PMUCTRState;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c292d036bcb2..e4adfa324efe 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1062,17 +1062,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>   
>       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
>           /*
> -         * Counter should not increment if inhibit bit is set. We can't really
> -         * stop the icount counting. Just return the counter value written by
> -         * the supervisor to indicate that counter was not incremented.
> +         * Counter should not increment if inhibit bit is set. Just return the
> +         * current counter value.
>            */
> -        if (!counter->started) {
> -            *val = ctr_val;
> -            return RISCV_EXCP_NONE;
> -        } else {
> -            /* Mark that the counter has been stopped */
> -            counter->started = false;
> -        }
> +         *val = ctr_val;
> +         return RISCV_EXCP_NONE;
>       }
>   
>       /*
> @@ -2114,9 +2108,25 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>   
>       /* Check if any other counter is also monitoring cycles/instructions */
>       for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
>               counter = &env->pmu_ctrs[cidx];
> -            counter->started = true;
> +        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
> +            /*
> +             * Update the counter value for cycle/instret as we can't stop the
> +             * host ticks. But we should show the current value at this moment.
> +             */
> +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> +                counter->mhpmcounter_val =
> +                    riscv_pmu_ctr_get_fixed_counters_val(env, cidx, false) -
> +                                           counter->mhpmcounter_prev +
> +                                           counter->mhpmcounter_val;
> +                if (riscv_cpu_mxl(env) == MXL_RV32) {
> +                    counter->mhpmcounterh_val =
> +                        riscv_pmu_ctr_get_fixed_counters_val(env, cidx, true) -
> +                                                counter->mhpmcounterh_prev +
> +                                                counter->mhpmcounterh_val;
> +                }
> +            }
>           }
>       }
>   
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 76f2150f78b5..492c2c6d9d79 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -320,15 +320,14 @@ static bool pmu_needed(void *opaque)
>   
>   static const VMStateDescription vmstate_pmu_ctr_state = {
>       .name = "cpu/pmu",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .needed = pmu_needed,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL(mhpmcounter_val, PMUCTRState),
>           VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
>           VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
>           VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> -        VMSTATE_BOOL(started, PMUCTRState),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> 

