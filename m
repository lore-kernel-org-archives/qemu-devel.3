Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608A3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1rml-0005w5-GF; Tue, 30 Apr 2024 14:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s1rmj-0005vw-KM
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:00:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s1rmf-0005lK-O9
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:00:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso53648235ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714500050; x=1715104850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KIrs7j4YMFww+dcXVrYn4lShSCWiAn2OjEdShWaBO+E=;
 b=afqRcZMa3G9QTLfyAS05Dx5yT7E58/PQ39PcvTziTzpze/bKGM+mX0zL+Q5QHoZ3GS
 cZaoc7migiE20+XpnnsuLQOVnyYrMthlfxVtISLmfLZeJLCE76/XdVSkTCcFBDRyI0Nd
 dO0tI/uBdjQGzpvjETjruA5qoZ/0noMNRCwqU1+meotiiAAeX0LC4kxyvqCwapTK6mgB
 11bWCIeZVh0U1UDp3aVgWFz5r7erG/kEC9J73A14VS1wsLuuE4m3YcZDgboSicj3soGk
 k48OhBl0OSAFDvVLE4LqF/hkLrZvVyPAJV4R7T6So2aw0x6soBYCTGgcgWnJOvExO0aG
 AVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714500050; x=1715104850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KIrs7j4YMFww+dcXVrYn4lShSCWiAn2OjEdShWaBO+E=;
 b=MPecs+DWjHKSeeDuaoUdrBTmnP9gABN8fTvb5vLtfYRKg1q5COGJGMjfg+N3nKetnN
 aF1MK+sCLjaoktjQL4/iWPjfcRLGCYMiMJEnklBZGGVhea9uSekMkgiBkVi6y42NmRU6
 wrlgwTj5QqXtbDXJIeBsGMNBwfyh4w7atnhh5YEaqH54I6TgcFfKrINSJFilMqGznp84
 IpK0LlC3RmTmY3+S4Q91bVG81phK5umfNtYEWKg2ftrwXXhim3aeKckq2sNm/DV+/o70
 oudidUsoL8qGi/FIi+qbP+T5fTcvR162l2UHCf0geS8V6XqNGoUDZaK95VEpA5yFbhXc
 rWSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/KoTaU+zQraH5zE4qjJUomb3xNVv1SDWfVuGOcKx5lJOd8jd4CQTOzBb68dt9MoavOwVZbhDxxG1BaoOD3YVwhRKNTpY=
X-Gm-Message-State: AOJu0YzT4ylNhWUrMYI2ILMJCl5DvNBfFIeMCtN3JycyUrTQHmgVCq4F
 4k1koCcJVzka6MJiTqE475t5XwJdZ7gFAMBwFSptNzawMI5m7ebZ8J6i7F63kvU=
X-Google-Smtp-Source: AGHT+IHPt9s5I3RNterSAWM5NQ2/6YSGDk88/zZQ/BZ0n4TxKKtKrb1nU/7QsSL6+5Mr663Z5WiUYw==
X-Received: by 2002:a17:902:b948:b0:1e5:4f5:7fa7 with SMTP id
 h8-20020a170902b94800b001e504f57fa7mr158459pls.21.1714500050318; 
 Tue, 30 Apr 2024 11:00:50 -0700 (PDT)
Received: from [192.168.68.110] ([187.11.154.208])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm22695768plg.156.2024.04.30.11.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 11:00:49 -0700 (PDT)
Message-ID: <d672ec9d-eaa0-48c1-9f99-d94cf06e7aac@ventanamicro.com>
Date: Tue, 30 Apr 2024 15:00:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: Save counter values during countinhibit
 update
Content-Language: en-US
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 bin.meng@windriver.com, alistair.francis@wdc.com,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62d.google.com
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



On 4/29/24 16:28, Atish Patra wrote:
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
>   target/riscv/cpu.h     |  1 -
>   target/riscv/csr.c     | 32 ++++++++++++++++++++------------
>   target/riscv/machine.c |  1 -
>   3 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b9449a..09bbf7ce9880 100644
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
> index 726096444fae..68ca31aff47d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -929,17 +929,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
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
> @@ -1973,9 +1967,23 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>   
>       /* Check if any other counter is also monitoring cycles/instructions */
>       for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
>               counter = &env->pmu_ctrs[cidx];
> -            counter->started = true;
> +        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
> +	    /*
> +             * Update the counter value for cycle/instret as we can't stop the
> +             * host ticks. But we should show the current value at this moment.
> +             */
> +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> +                counter->mhpmcounter_val = get_ticks(false) -
> +                                           counter->mhpmcounter_prev +
> +                                           counter->mhpmcounter_val;
> +                if (riscv_cpu_mxl(env) == MXL_RV32) {
> +                    counter->mhpmcounterh_val = get_ticks(false) -
> +                                                counter->mhpmcounterh_prev +
> +                                                counter->mhpmcounterh_val;
> +		}
> +            }
>           }
>       }
>   
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 76f2150f78b5..3e0f2dd2ce2a 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -328,7 +328,6 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
>           VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
>           VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
>           VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> -        VMSTATE_BOOL(started, PMUCTRState),

Unfortunately we can't remove fields from the VMStateDescription without breaking
migration backward compatibility. Older QEMUs will attempt to read a field that
doesn't exist and migration will fail.

I'm assuming that we care about backward compat. If we're not up to this point yet
then we can just bump the version_id of vmstate_pmu_ctr_state and be done with it.
This is fine to do unless someone jumps in and complains that we broke a migration
case for the 'virt' board. Granted, we don't have versioned boards yet so I'm unsure
if someone would actually have a base to complain. Alistair, Drew, care to comment?


Now, if we care about backward migration compat, we'll need to do as described in
devel/migration/main.rst, section "Not sending existing elements". An example on
how we need to proceed can also be seen in commit 6cc88d6bf9. But in short we
would need to:

- add a dummy property, e.g. a 'mig_started' bool

- use a slightly different macro in vmstate:

> -        VMSTATE_BOOL(started, PMUCTRState),
> +        VMSTATE_BOOL_TEST(mig_started, PMUCTRState),

- add hooks in pre_load()/post_load() to load the 'started' field



Thanks,

Daniel

>           VMSTATE_END_OF_LIST()
>       }
>   };
> 

