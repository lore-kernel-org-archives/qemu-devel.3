Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC0C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc8S-0007cd-Pk; Fri, 04 Jul 2025 04:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXc8I-0007Mh-Ig
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:51:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXc8E-0003xB-CP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:50:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so308873f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751619052; x=1752223852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YNocy2E2dhCsi506OeGp2hXY5Vxma9BXb9HS1RRlbco=;
 b=crqAn9jWlJw8eahfRrjVnyzqK2rmBkh0xWGuQ6GMAnPj60kY3NfawTtScRDC6ETkq0
 a+unyGte8Ez7F5pRQUBKt3ee7b5YtV3AUSa9yzB64G3D1fJHpHAUJ4UzedEksaD4xcTY
 okIK+G4ADq7DgxTKV2cj8S87BOiEgxoqpxGBODvmPYtfvk7KomJkaloY3CBbQv8OLyaC
 USTeu8VXSPEfFLb/SmWMTqSyu+yvU9AEfgtC7aCfRmv58ABCGyOK/lXH0YZpvcx36zTx
 x/WZnSvwX+3aSmC8gYWk8LD6N2CiPdA+i1ekrAtY5hTLsh4riIWWK2lEwoJLv1pNjy8g
 tvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751619052; x=1752223852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YNocy2E2dhCsi506OeGp2hXY5Vxma9BXb9HS1RRlbco=;
 b=CJmdF1a7E0Ikucwcu0yRrDNRuam9sJl+SJO1PxxpB29CiDqy4lBD7Xgg6intfL4znG
 P8dTGNWsBkduI1vXmLD+ae40UxKpzXaUsF67o24FWVDEq70d5xATKqDzK0vNwoaKlB+B
 yY/6SM2xUv4/OpwGaKwUbDGOFhawrmN0Ktjo6V+JEfWAwpoelAO5Pjmo02Ai6EqLgWnp
 yLG+XTX/Bbhn3dLnQbxP6EbHMbFbK+S6AsscGAaH7DfCovk6kcx+s8lRlTnglLewVKg2
 Wl8nWQMJFFovW030EdRdT0gCqQBkvMircx0sOyznx6Am7Fkq6qcg85lj73DlkP2N3RgC
 crXg==
X-Gm-Message-State: AOJu0YzwJop8X/5jBpq9jwdos9YH/qlYqGXwIjer8yDpzdeJipBoLJJW
 2k8LJdgh8tozSsKAH3HFqBgHTwU0NqU/zc3QWsgPgwT3LDBgofWug+X8N0tilj8K9a25VjquSwI
 hUfl/n+I=
X-Gm-Gg: ASbGnct43nuKv4RxCgRMOwIHFaveN2cPJz9G6pMNHJmTs0hZ02AtEJaKzMcLePDDXJG
 vhPCu+VCENNJmsVWJ2W+C60T4roEZEgr+dol5PjYNcS5zHj3h3xE0mMBMD2turWZvOuxee9JNHm
 ZpCbuYB4R2VMK5/BxWm3mUAHJa+eNgGwIkFMNo6bP/yPZ8JEjE6u5Xh85T6d93IutjlxH9z7BIA
 1LRcP8Iqi7f+bheemOIbDcrPRkjUh+tpQQP7VtdW6cshDIgKAQ6oWCeQffGkseK50L9lvR3ql9a
 JorYrLaAR86M+oZAIxr1E2kr250Qa+x8duR5MzpbQ05mTJMR4VUlQ5EdB+ZxeGCSnuQpyeT02eS
 C8MSQ1BE78h0hHhpOMkgF4tXPLQQ1rb6ksIanb/Wx
X-Google-Smtp-Source: AGHT+IEgvtfFT1LLCLlak3qDg5T2cYQnoemQi7HOV9Wp2edcJa8imErupzONEgp5FU98nmgZiSWknA==
X-Received: by 2002:a05:6000:38a:b0:3a4:f5f6:b4ab with SMTP id
 ffacd0b85a97d-3b4970391abmr895738f8f.30.1751619051468; 
 Fri, 04 Jul 2025 01:50:51 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b966c0sm1940136f8f.52.2025.07.04.01.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:50:50 -0700 (PDT)
Message-ID: <5bd77f3f-745e-450d-9e6d-657da6195c1e@linaro.org>
Date: Fri, 4 Jul 2025 10:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/39] accel: Preparatory cleanups for split-accel
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/7/25 19:32, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (39):
>    hw/core/machine: Display CPU model name in 'info cpus' command
>    system/memory: Restrict eventfd dispatch_write() to emulators
>    system/runstate: Document qemu_add_vm_change_state_handler()
>    system/cpus: Assert interrupt handling is done with BQL locked
>    accel/kvm: Remove kvm_init_cpu_signals() stub
>    accel/kvm: Reduce kvm_create_vcpu() declaration scope
>    accel/tcg: Remove 'info opcount' and @x-query-opcount
>    accel/tcg: Remove profiler leftover
>    accel/tcg: Factor tcg_dump_flush_info() out
>    accel/tcg: Factor tcg_dump_stats() out for re-use
>    accel/tcg: Extract statistic related code to tcg-stats.c
>    accel: Move supports_guest_debug() declaration to AccelClass
>    accel: Move cpus_are_resettable() declaration to AccelClass
>    accel/hvf: Restrict internal declarations
>    accel/hvf: Move per-cpu method declarations to hvf-accel-ops.c
>    accel/hvf: Move generic method declarations to hvf-all.c
>    cpus: Document CPUState::vcpu_dirty field
>    accel/hvf: Replace @dirty field by generic CPUState::vcpu_dirty field
>    accel/nvmm: Replace @dirty field by generic CPUState::vcpu_dirty field
>    accel/whpx: Replace @dirty field by generic CPUState::vcpu_dirty field
>    accel/kvm: Remove kvm_cpu_synchronize_state() stub
>    accel/system: Document cpu_synchronize_state()
>    accel/system: Document cpu_synchronize_state_post_init/reset()
>    accel/nvmm: Expose nvmm_enabled() to common code
>    accel/whpx: Expose whpx_enabled() to common code
>    accel/dummy: Extract 'dummy-cpus.h' header from 'system/cpus.h'
>    accel: Pass old/new interrupt mask to handle_interrupt() handler
>    accel: Expose and register generic_handle_interrupt()
>    accel: Keep reference to AccelOpsClass in AccelClass
>    accel: Propagate AccelState to AccelClass::init_machine()
>    accel/kvm: Prefer local AccelState over global MachineState::accel
>    accel/tcg: Prefer local AccelState over global current_accel()
>    accel: Directly pass AccelState argument to AccelClass::has_memory()
>    accel/kvm: Directly pass KVMState argument to do_kvm_create_vm()
>    accel: Remove unused MachineState argument of AccelClass::setup_post()
>    accel: Pass AccelState argument to gdbstub_supported_sstep_flags()
>    accel: Rename 'system/accel-ops.h' -> 'accel/accel-cpu-ops.h'
>    accel: Extract AccelClass definition to 'accel/accel-ops.h'
>    MAINTAINERS: Add me as reviewer of overall accelerators section

Non-controversial patches queued to accel-next, thanks.

