Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518A0E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHff-0002ee-8R; Fri, 10 Jan 2025 11:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHfd-0002du-0O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:15:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHfZ-0006Et-Ny
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:15:35 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso16658235e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736525731; x=1737130531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ayjs8jJUz/NmmKiVuC1bDQqzXApBfKYvxn2OrHQKlRg=;
 b=dd/RRI01Sb0NDvc1DnIKXclhhK2uoK0uiIL2c434RQuyh86OmsU/r7my8xAFTAendA
 ddnt+EYhgWW/pG8ATYYTM8NU0hJdrei5s1md54jWYIHCiuohttQ9b4thENmp6KpEGtMl
 tVJhpFZYv7ZuVBg4SYWMy+Bw27Yk26wgpDar+idWCHlJS7beykn9wEw1trsmtiBOKY4i
 Jnr6F/UmNilQ7ZacESkOSiKjAP7kieMsjWU2O08LaVkZtk36mdToQj8GiKVgiNZFA7jt
 vh1gJ0L6tspIF5jSyQlqKN/344QHNeXmLAmLbf1t6tI611RR7waOW8Jj73zxygcX7Rgr
 1SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525731; x=1737130531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ayjs8jJUz/NmmKiVuC1bDQqzXApBfKYvxn2OrHQKlRg=;
 b=AvPlGjPvs2SsvMuftMk567IkZkimcJsIlIkzIg02z3i58ikQF1IHj83GhEJszG7xPE
 CfGazJ2a373OLl1Wzcau5WgKGjJR8mGNfZvY6qZJ0e4XhcIZqorp96Mt2SwBITen8XRH
 E0WRruCWIVrHHpOczcjQ6vrMCXPiIg6laqAS/HY6VYawZY2ZO9FrMAZpaBXtKOU9FNFL
 jWNRBsKKQG0BJKNZZckc0FKrQD2/ySJA7Csf8gjbR/6E7s8YHylIopthz3OORw6uKGwv
 jvo+VjwTA4nP6mcA+McOnjUFWk3LMjsd1grK8WzUFmFz9o+b7FhRLG8oMMMFXlUp66Qc
 IpOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUygOsp/ftxGQFzcF8XvYa2bI1ORqhYBCZpyN9SzyfLbzsz0RIjq4ejogNkHKVUcgevL+kIoies5eIb@nongnu.org
X-Gm-Message-State: AOJu0YzjzcfqlpCNM+HNz3VHP40GwuBioz+F+Nfbv2kVG5Mu5n3dFoO7
 D6PWW550MlF0nn3b8NnvSni/zMwVufOXc0KhWI3Ps5FWqVG2r6Tk39CcUKiS94Y=
X-Gm-Gg: ASbGncvDSaWC2GjcuNCtwEkC3tXhoYjjx72u5LC4/X8gXxLgAa2/tKFZIlvBE6QC324
 mbYEsUmriCKgI/D65736A1LSbJejKQL2SGHF4iAF2kv22Kkz5ykR2widyMi0tU9BXUdROzZSQuH
 VRGwd6q/E/wrGOF6bP69vQsRAd9ACtgBVj7PGCFx72LoHgrcWj8etn8gFTUZv1/sg369EW+i2bD
 UXIhjScvSCdEM0JqMM6AUhr2f6wA+plVFf7YRwPWQV9rfKwwomW5pSiWsAZLZ/p4C6i+4c/hL2j
 bnsu4fifi6c+X8wmGxvB+bz+
X-Google-Smtp-Source: AGHT+IEIuJeE1FptyIovqgGw3yG296sCG8Dq52aysR7li2yhUUVzl2bhR/TdlyZmXufalAwlBx3Euw==
X-Received: by 2002:a05:600c:3c9e:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-436e26a6727mr105026975e9.8.1736525731000; 
 Fri, 10 Jan 2025 08:15:31 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcc8f8dfsm85099305e9.0.2025.01.10.08.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:15:30 -0800 (PST)
Message-ID: <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
Date: Fri, 10 Jan 2025 17:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110141800.1587589-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Cédric,

Cc'ing Laurent & Richard for user emulation.

On 10/1/25 15:17, Cédric Le Goater wrote:
> Remove the 405 CPU family and all SPR definitions that don't have
> specific read/write handlers.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   target/ppc/cpu-models.h |  30 -----
>   target/ppc/cpu.h        |   9 --
>   target/ppc/cpu-models.c |  57 ----------
>   target/ppc/cpu_init.c   | 246 ----------------------------------------
>   4 files changed, 342 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 72ad31ba50d7..f23cb383d683 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -39,36 +39,6 @@ extern PowerPCCPUAlias ppc_cpu_aliases[];
>   /* PVR definitions for most known PowerPC                                    */
>   enum {
>       /* IBM Processor for Network Resources */
> -    CPU_POWERPC_COBRA              = 0x10100000, /* XXX: 405 ? */
> -    /* PowerPC 405 family */
> -    /* PowerPC 405 cores */
> -    CPU_POWERPC_405D2              = 0x20010000,
> -    CPU_POWERPC_405D4              = 0x41810000,
> -    /* PowerPC 405 microcontrollers */
> -    /* XXX: missing 0x200108a0 */
> -    CPU_POWERPC_405CRa             = 0x40110041,
> -    CPU_POWERPC_405CRb             = 0x401100C5,
> -    CPU_POWERPC_405CRc             = 0x40110145,
> -    CPU_POWERPC_405EP              = 0x51210950,
> -    CPU_POWERPC_405EZ              = 0x41511460, /* 0x51210950 ? */
> -    CPU_POWERPC_405GPa             = 0x40110000,
> -    CPU_POWERPC_405GPb             = 0x40110040,
> -    CPU_POWERPC_405GPc             = 0x40110082,
> -    CPU_POWERPC_405GPd             = 0x401100C4,
> -    CPU_POWERPC_405GPR             = 0x50910951,
> -    CPU_POWERPC_405LP              = 0x41F10000,
> -    /* IBM network processors */
> -    CPU_POWERPC_NPE405H            = 0x414100C0,
> -    CPU_POWERPC_NPE405H2           = 0x41410140,
> -    CPU_POWERPC_NPE405L            = 0x416100C0,
> -    CPU_POWERPC_NPE4GS3            = 0x40B10000,
> -    /* IBM STBxxx (PowerPC 401/403/405 core based microcontrollers) */
> -    CPU_POWERPC_STB03              = 0x40310000, /* 0x40130000 ? */
> -    CPU_POWERPC_STB04              = 0x41810000,
> -    CPU_POWERPC_STB25              = 0x51510950,
> -    /* Xilinx cores */
> -    CPU_POWERPC_X2VP4              = 0x20010820,
> -    CPU_POWERPC_X2VP20             = 0x20010860,
>       /* PowerPC 440 family */


> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index ece348178188..9d8f479fae70 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -67,56 +67,6 @@
>       POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
>   
>       /* Embedded PowerPC                                                      */
> -    /* PowerPC 405 family                                                    */
> -    /* PowerPC 405 cores                                                     */
> -    POWERPC_DEF("405d2",         CPU_POWERPC_405D2,                  405,
> -                "PowerPC 405 D2")
> -    POWERPC_DEF("405d4",         CPU_POWERPC_405D4,                  405,
> -                "PowerPC 405 D4")
> -    /* PowerPC 405 microcontrollers                                          */
> -    POWERPC_DEF("405cra",        CPU_POWERPC_405CRa,                 405,
> -                "PowerPC 405 CRa")
> -    POWERPC_DEF("405crb",        CPU_POWERPC_405CRb,                 405,
> -                "PowerPC 405 CRb")
> -    POWERPC_DEF("405crc",        CPU_POWERPC_405CRc,                 405,
> -                "PowerPC 405 CRc")
> -    POWERPC_DEF("405ep",         CPU_POWERPC_405EP,                  405,
> -                "PowerPC 405 EP")
> -    POWERPC_DEF("405ez",         CPU_POWERPC_405EZ,                  405,
> -                "PowerPC 405 EZ")
> -    POWERPC_DEF("405gpa",        CPU_POWERPC_405GPa,                 405,
> -                "PowerPC 405 GPa")
> -    POWERPC_DEF("405gpb",        CPU_POWERPC_405GPb,                 405,
> -                "PowerPC 405 GPb")
> -    POWERPC_DEF("405gpc",        CPU_POWERPC_405GPc,                 405,
> -                "PowerPC 405 GPc")
> -    POWERPC_DEF("405gpd",        CPU_POWERPC_405GPd,                 405,
> -                "PowerPC 405 GPd")
> -    POWERPC_DEF("405gpr",        CPU_POWERPC_405GPR,                 405,
> -                "PowerPC 405 GPR")
> -    POWERPC_DEF("405lp",         CPU_POWERPC_405LP,                  405,
> -                "PowerPC 405 LP")
> -    POWERPC_DEF("npe405h",       CPU_POWERPC_NPE405H,                405,
> -                "Npe405 H")
> -    POWERPC_DEF("npe405h2",      CPU_POWERPC_NPE405H2,               405,
> -                "Npe405 H2")
> -    POWERPC_DEF("npe405l",       CPU_POWERPC_NPE405L,                405,
> -                "Npe405 L")
> -    POWERPC_DEF("npe4gs3",       CPU_POWERPC_NPE4GS3,                405,
> -                "Npe4GS3")
> -    /* PowerPC 401/403/405 based set-top-box microcontrollers                */
> -    POWERPC_DEF("stb03",         CPU_POWERPC_STB03,                  405,
> -                "STB03xx")
> -    POWERPC_DEF("stb04",         CPU_POWERPC_STB04,                  405,
> -                "STB04xx")
> -    POWERPC_DEF("stb25",         CPU_POWERPC_STB25,                  405,
> -                "STB25xx")
> -    /* Xilinx PowerPC 405 cores                                              */
> -    POWERPC_DEF("x2vp4",         CPU_POWERPC_X2VP4,                  405,
> -                NULL)
> -    POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
> -                NULL)
> -    /* PowerPC 440 family                                                    */
>   #if defined(TODO_USER_ONLY)
>       POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
>                   "Generic PowerPC 440")
> @@ -742,13 +692,6 @@
>   /* PowerPC CPU aliases                                                     */
>   
>   PowerPCCPUAlias ppc_cpu_aliases[] = {
> -    { "405", "405d4" },
> -    { "405cr", "405crc" },
> -    { "405gp", "405gpd" },
> -    { "405gpe", "405crc" },
> -    { "x2vp7", "x2vp4" },
> -    { "x2vp50", "x2vp20" },

>   /*****************************************************************************/
>   /* Exception vectors models                                                  */
> -static void init_excp_4xx(CPUPPCState *env)
> -{
> -#if !defined(CONFIG_USER_ONLY)
> -    env->excp_vectors[POWERPC_EXCP_CRITICAL] = 0x00000100;
> -    env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000200;
> -    env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000300;
> -    env->excp_vectors[POWERPC_EXCP_ISI]      = 0x00000400;
> -    env->excp_vectors[POWERPC_EXCP_EXTERNAL] = 0x00000500;
> -    env->excp_vectors[POWERPC_EXCP_ALIGN]    = 0x00000600;
> -    env->excp_vectors[POWERPC_EXCP_PROGRAM]  = 0x00000700;
> -    env->excp_vectors[POWERPC_EXCP_SYSCALL]  = 0x00000C00;
> -    env->excp_vectors[POWERPC_EXCP_PIT]      = 0x00001000;
> -    env->excp_vectors[POWERPC_EXCP_FIT]      = 0x00001010;
> -    env->excp_vectors[POWERPC_EXCP_WDT]      = 0x00001020;
> -    env->excp_vectors[POWERPC_EXCP_DTLB]     = 0x00001100;
> -    env->excp_vectors[POWERPC_EXCP_ITLB]     = 0x00001200;
> -    env->excp_vectors[POWERPC_EXCP_DEBUG]    = 0x00002000;
> -    env->ivor_mask = 0x0000FFF0UL;
> -    env->ivpr_mask = 0xFFFF0000UL;
> -    /* Hardware reset vector */
> -    env->hreset_vector = 0xFFFFFFFCUL;
> -#endif
> -}
> -
>   static void init_excp_MPC5xx(CPUPPCState *env)
>   {
>   #if !defined(CONFIG_USER_ONLY)
> @@ -2138,57 +1943,6 @@ static void init_tlbs_emb(CPUPPCState *env)
>   #endif
>   }
>   
> -static void init_proc_405(CPUPPCState *env)
> -{
> -    register_40x_sprs(env);
> -    register_405_sprs(env);
> -    register_usprgh_sprs(env);
> -
> -    init_tlbs_emb(env);
> -    init_excp_4xx(env);
> -    env->dcache_line_size = 32;
> -    env->icache_line_size = 32;
> -    /* Allocate hardware IRQ controller */
> -    ppc40x_irq_init(env_archcpu(env));
> -
> -    SET_FIT_PERIOD(8, 12, 16, 20);
> -    SET_WDT_PERIOD(16, 20, 24, 28);
> -}
> -
> -POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
> -
> -    dc->desc = "PowerPC 405";
> -    pcc->init_proc = init_proc_405;
> -    pcc->check_pow = check_pow_nocheck;
> -    pcc->check_attn = check_attn_none;
> -    pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING | PPC_MFTB |
> -                       PPC_DCR | PPC_WRTEE |
> -                       PPC_CACHE | PPC_CACHE_ICBI | PPC_40x_ICBT |
> -                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
> -                       PPC_MEM_SYNC | PPC_MEM_EIEIO |
> -                       PPC_40x_TLB | PPC_MEM_TLBIA | PPC_MEM_TLBSYNC |
> -                       PPC_4xx_COMMON | PPC_405_MAC | PPC_40x_EXCP;
> -    pcc->msr_mask = (1ull << MSR_WE) |
> -                    (1ull << MSR_CE) |
> -                    (1ull << MSR_EE) |
> -                    (1ull << MSR_PR) |
> -                    (1ull << MSR_FP) |
> -                    (1ull << MSR_ME) |
> -                    (1ull << MSR_DWE) |
> -                    (1ull << MSR_DE) |
> -                    (1ull << MSR_IR) |
> -                    (1ull << MSR_DR);
> -    pcc->mmu_model = POWERPC_MMU_SOFT_4xx;
> -    pcc->excp_model = POWERPC_EXCP_40x;
> -    pcc->bus_model = PPC_FLAGS_INPUT_405;
> -    pcc->bfd_mach = bfd_mach_ppc_403;
> -    pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
> -                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
> -}

The deprecation message (see previous patch) was about the
"ppc ``ref405ep`` machine". Is that OK we remove these CPUs
for user emulation?

$ qemu-ppc -cpu help|fgrep 405
PowerPC 405d2            PVR 20010000
PowerPC 405gpa           PVR 40110000
PowerPC 405gpb           PVR 40110040
PowerPC 405cra           PVR 40110041
PowerPC 405gpc           PVR 40110082
PowerPC 405gpd           PVR 401100c4
PowerPC 405gp            (alias for 405gpd)
PowerPC 405crb           PVR 401100c5
PowerPC 405crc           PVR 40110145
PowerPC 405cr            (alias for 405crc)
PowerPC 405gpe           (alias for 405crc)
PowerPC npe405h          PVR 414100c0
PowerPC npe405h2         PVR 41410140
PowerPC 405ez            PVR 41511460
PowerPC npe405l          PVR 416100c0
PowerPC 405d4            PVR 41810000
PowerPC 405              (alias for 405d4)
PowerPC 405lp            PVR 41f10000
PowerPC 405gpr           PVR 50910951
PowerPC 405ep            PVR 51210950

Regards,

Phil.

