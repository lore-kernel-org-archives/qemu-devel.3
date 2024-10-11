Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C683BD0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJGc-0006QC-Gs; Fri, 11 Oct 2024 13:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1szJ8Q-0000hu-BW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:09:04 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1szDyM-000101-S4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:38:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e453c7408so183968b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728646697; x=1729251497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IBYI+IlOshygn/DCYlqocmHohmGTTrYuX9aErNoE10=;
 b=gmCTbs1RnbP/JhyLvUnVynd2H1kRxKiV0zETBuaDLtlvUDSRE2dRtDz0AMUUpHu1tT
 qWigbgWIJ0ZpjG3ggb+MZtyqDHcUAIZV9ehgAfiZfkvMP8L1Ell9s5qztlpVv/VNEw4j
 TlqlWl3L5L3z8cfKl3yQmElw49tTj08d3vMSYjfsAV6RNGGksZoRiXhydMOLTbF4Km7U
 T4EdxoquSqBIi2DYhMMUZ1T8Q8c0J2QUD+nC0xhz8sSv3lTxCbVJ6CPYoxHJ/8lpBPHx
 4mEY6H0i6OASPtHeMmbI0KKYo8I5Smmz+jo4yOY2JktmNb/yEOTC52hEH8EAXqK+h5b4
 StKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728646697; x=1729251497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IBYI+IlOshygn/DCYlqocmHohmGTTrYuX9aErNoE10=;
 b=oq5gIl0QG9ABV3Z/xr9T6j8eOhcA31Gbz19WZQNPkMmCgp9/XIW+YBFYjoXldPQCeM
 EaqaSjFTJFuVDEI0EjnJFBVJYp8uBeO+KH3tnKHYWMCmBaffd1+obdiNYkp70TYW1R3V
 sgRE5QhRC1VoQtRb8KzM29HSUEyNY2/BV6nluD9M/Wd3Al9GF8PqJLn2ByImsbQguFPc
 DPLAqdlb5TBbBVncnihopHRoNCOeeiAVLGUaK31hgd/3AlEUAQhPs5kRKNrjqhRs5mxm
 NDr1w0gFqUPxHQ9H+AaB3orB+DD2ai61CThpQx3OaYkXXPREljyuw5bGzMg1RZDWHJu0
 ZNPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiY+ghUYS/B4o+Yqy2OfSAiYWZsRNmAN6dX9EI5dtYH4yU3/OsXo5kjMxY52eB+3iD8+DgCSsl6eyl@nongnu.org
X-Gm-Message-State: AOJu0YzYQy6tkG9Id0TwTIIg69RBBKYaXX4OdIDZZPm9YVy/9T6o3il8
 WzW4uzlcnyr30EdHzS/X6ai5gE2PbithhGzITr1GgMlTyIAbCChz3hAFxW2y9kc=
X-Google-Smtp-Source: AGHT+IF367/JJYOaYbdNVoyCLJ+fwCixypagwDTx2K+z1EtnpBzO5INTrdxxOgzMCZkNOK/nMMqX8w==
X-Received: by 2002:a05:6a00:181f:b0:71e:410:4764 with SMTP id
 d2e1a72fcca58-71e37e5076emr3978825b3a.8.1728646696992; 
 Fri, 11 Oct 2024 04:38:16 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-198.dsl.telesp.net.br.
 [201.68.240.198]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aab9b06sm2409557b3a.153.2024.10.11.04.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 04:38:16 -0700 (PDT)
Message-ID: <6e7a184f-3b47-480d-bd56-fef2e89beda6@ventanamicro.com>
Date: Fri, 11 Oct 2024 08:38:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] target/riscv: Add Smrnmi support.
To: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 ajones@ventanamicro.com, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <cleger@rivosinc.com>
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240902071358.1061693-1-tommy.wu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
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

Hi Tommy,


Do you plan to send a new version of this work soon? This series is a prerequisite
of "target/riscv: Add support for Smdbltrp and Ssdbltrp extensions" and we need
this series merged first. We have minor comments from Clément and Alistair so
hopefully it shouldn't be too much work.

The code freeze for 9.2 will happen in the first/second week of November, so if you
could send a new version to be merged in the next PR that would be great.


Thanks,

Daniel



On 9/2/24 4:13 AM, Tommy Wu wrote:
> This patchset added support for Smrnmi Extension in RISC-V.
> 
> There are four new CSRs and one new instruction added to allow NMI to be
> resumable in RISC-V, which are:
> 
> =============================================================
>    * mnscratch (0x740)
>    * mnepc     (0x741)
>    * mncause   (0x742)
>    * mnstatus  (0x744)
> =============================================================
>    * mnret: To return from RNMI interrupt/exception handler.
> =============================================================
> 
> RNMI also has higher priority than any other interrupts or exceptions
> and cannot be disabled by software.
> 
> RNMI may be used to route to other devices such as Bus Error Unit or
> Watchdog Timer in the future.
> 
> The interrupt/exception trap handler addresses of RNMI are
> implementation defined.
> 
> If anyone wants to test the patches, we can use the customized OpenSBI[1],
> and the customized QEMU[2].
> 
> We implemented a PoC RNMI trap handler in the customized OpenSBI.
> In the customized QEMU, we use the Smrnmi patches and the patch from
> Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> the RNMI signal with the qmp command.
> 
> [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> [2] https://github.com/TommyWu-fdgkhdkgh/qemu/tree/dev/twu/master
> [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
> 
> Test commands :
> $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=true,
> rnmi-interrupt-vector={Offset of the RNMI handler in the customized
> OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> -qmp unix:/tmp/qmp-sock,server,wait=off
> 
> Use qmp command to inject the RNMI interrupt.
> $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> (QEMU)  gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi
> number=0 value=true
> 
> (QEMU)  gpio-set path=/machine/soc0/harts[0] gpio=riscv.cpu.rnmi
> number=0 value=false
> 
> Changelog:
> 
> v6
>    * Delete the redundant code in `riscv_cpu_do_interrupt`.
>    ( Thank Alvin for the suggestion. )
>    * Split the shared code in `helper_mret` and `helper_mnret` into a
>      helper function `check_ret_from_m_mode`.
>    ( Thank Alistair for the suggestion. )
> 
> v5
>    * Move the patch that adds the Smrnmi extension to the last patch.
>    ( Thank Alistair for the suggestion. )
>    * Implement an M-mode software PoC for this with implemented handlers.
>    ( Thank Andrew Jones for the suggestion. )
>    * Add a commit message to all patches of the series.
>    ( Thank Andrew Jones for the suggestion. )
> 
> v4
>    * Fix some coding style issues.
>    ( Thank Daniel for the suggestions. )
> 
> v3
>    * Update to the newest version of Smrnmi extension specification.
> 
> v2
>    * split up the series into more commits for convenience of review.
>    * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts.
> 
> Tommy Wu (5):
>    target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
>    target/riscv: Handle Smrnmi interrupt and exception.
>    target/riscv: Add Smrnmi CSRs.
>    target/riscv: Add Smrnmi mnret instruction.
>    target/riscv: Add Smrnmi cpu extension.
> 
>   hw/riscv/riscv_hart.c                         | 18 ++++
>   include/hw/riscv/riscv_hart.h                 |  4 +
>   target/riscv/cpu.c                            | 18 ++++
>   target/riscv/cpu.h                            | 10 +++
>   target/riscv/cpu_bits.h                       | 23 ++++++
>   target/riscv/cpu_cfg.h                        |  1 +
>   target/riscv/cpu_helper.c                     | 80 ++++++++++++++++--
>   target/riscv/csr.c                            | 82 +++++++++++++++++++
>   target/riscv/helper.h                         |  1 +
>   target/riscv/insn32.decode                    |  3 +
>   .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
>   target/riscv/op_helper.c                      | 49 +++++++++--
>   12 files changed, 291 insertions(+), 10 deletions(-)
> 

