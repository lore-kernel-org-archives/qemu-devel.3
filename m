Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D0AC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5rb-0005gF-0x; Mon, 03 Jun 2024 07:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5rX-0005f0-4u
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:28:29 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5rV-0000iI-Gg
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:28:26 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4eacd4c1c93so1331763e0c.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717414103; x=1718018903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PV0NIx7Msfph2Sw7+O4LVA2pjGlK/npIVQHcru0BTpM=;
 b=uEU+53enuNKY81o7vPE7uHiAAZPWAdlTYx4NvjEcxWkxw/dbgobKBtKexFzWkq2/6Q
 0Uwqk+oTVHoqA9gWeXwwvDejcIBiSrzZcuXbyLUecMJlBCBPiGvOFhJeA6D6FBivFPvf
 ZirO74BH0wiF+6EOWoJBkjUJyjeVLZ06Mo7Yp6s1xhwxn20nLt+Mj9R8r/cE0vpoDf64
 lkWQeoDVlyS+wt1H8yRTAJNzkSURKDg30f5KQNldA2Nf1ENVXmgp63x+2vPcWsbB8J+Z
 Pa8XYoEu4WqUPh8AtstxzfCvsN3hgd8cU3/eZneIJekcmRJxT1b9iud2HBUcSWMs/D3y
 izSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414103; x=1718018903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PV0NIx7Msfph2Sw7+O4LVA2pjGlK/npIVQHcru0BTpM=;
 b=AP0tvhp2ZPA0aB/fN9BwHAkPoPXzCO6RmDG0VS79Aig7b4OmXF8Bi2qm5wtGlxdTNM
 URDFbkn9Hl5Q9lOssH1m0sjXztoPNfGUFVDNMv5QNZF1C26gqH4B9iqAKOI2BKrEDlaR
 4SHStZHe8nym9RqrIx9ym65QajKGaekHlvsK7UPcqPLKaavOIhflEimRyIwH/4Sf9yzq
 PpSehJ57HnxViZIDKjn4qn3dJVtyWJQKQ5zY3dikLxTBUge+hNiCGbn9IVGaZ5l31aG0
 z3qRGEnJ8KxBw4rMNhVVHVVwgFeyRClPPCDSuhs6yaeoDstWVgtZ9R5D9lHeCHKypLEU
 VMhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsBv6/C1uabA264A/Zi8aov+vXTu9J87k9QPMOStZdexeTt3fikQ1t+DV3ECdCFAWOw7bEQWuhB4N4CXeOt+yKuUIkc2I=
X-Gm-Message-State: AOJu0YxKAvIxwEgF/Bq3M+lUXEhOHouL0Gx3VquqmCKsBhnsIVcMsUl2
 isMifvm+IQumU7IUqlvKskmXWuP96818OJWOUJ0ADwoj/ladSPWmnMI07wzFLEU=
X-Google-Smtp-Source: AGHT+IH3UzMfTEg5uALlw06eeywZZ8pnfUgmvRVvZ7WisLDIs1Ne/ayWwQ/nY/MTIqQlgI+qTALHjw==
X-Received: by 2002:a1f:f8ce:0:b0:4df:1d06:eeb7 with SMTP id
 71dfb90a1353d-4eb02d9aef7mr8189394e0c.1.1717414102707; 
 Mon, 03 Jun 2024 04:28:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f901a818sm235096785a.80.2024.06.03.04.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:28:21 -0700 (PDT)
Message-ID: <a13883da-fa6a-4ada-b75d-42ffa0bcb20b@linaro.org>
Date: Mon, 3 Jun 2024 13:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cpu: move Qemu[Thread|Cond] setup into common code
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-3-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530194250.1801701-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=philmd@linaro.org; helo=mail-vk1-xa32.google.com
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

On 30/5/24 21:42, Alex Bennée wrote:
> Aside from the round robin threads this is all common code. By
> moving the halt_cond setup we also no longer need hacks to work around
> the race between QOM object creation and thread creation.
> 
> It is a little ugly to free stuff up for the round robin thread but
> better it deal with its own specialises than making the other
> accelerators jump through hoops.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/hw/core/cpu.h             |  4 ++++
>   accel/dummy-cpus.c                |  3 ---
>   accel/hvf/hvf-accel-ops.c         |  4 ----
>   accel/kvm/kvm-accel-ops.c         |  3 ---
>   accel/tcg/tcg-accel-ops-mttcg.c   |  4 ----
>   accel/tcg/tcg-accel-ops-rr.c      | 14 +++++++-------
>   hw/core/cpu-common.c              |  5 +++++
>   target/i386/nvmm/nvmm-accel-ops.c |  3 ---
>   target/i386/whpx/whpx-accel-ops.c |  3 ---
>   9 files changed, 16 insertions(+), 27 deletions(-)


> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 894e73e52c..84c36c1450 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -317,22 +317,22 @@ void rr_start_vcpu_thread(CPUState *cpu)
>       tcg_cpu_init_cflags(cpu, false);
>   
>       if (!single_tcg_cpu_thread) {
> -        cpu->thread = g_new0(QemuThread, 1);
> -        cpu->halt_cond = g_new0(QemuCond, 1);
> -        qemu_cond_init(cpu->halt_cond);
> +        single_tcg_halt_cond = cpu->halt_cond;
> +        single_tcg_cpu_thread = cpu->thread;
>   
>           /* share a single thread for all cpus with TCG */
>           snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
>           qemu_thread_create(cpu->thread, thread_name,
>                              rr_cpu_thread_fn,
>                              cpu, QEMU_THREAD_JOINABLE);
> -
> -        single_tcg_halt_cond = cpu->halt_cond;
> -        single_tcg_cpu_thread = cpu->thread;
>       } else {
> -        /* we share the thread */
> +        /* we share the thread, dump spare data */

/* we share the thread, release allocations from cpu_common_initfn() */

> +        g_free(cpu->thread);
> +        qemu_cond_destroy(cpu->halt_cond);
>           cpu->thread = single_tcg_cpu_thread;
>           cpu->halt_cond = single_tcg_halt_cond;
> +
> +        /* copy the stuff done at start of rr_cpu_thread_fn */
>           cpu->thread_id = first_cpu->thread_id;
>           cpu->neg.can_do_io = 1;
>           cpu->created = true;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


