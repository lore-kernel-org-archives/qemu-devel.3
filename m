Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC71C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCfOp-0003in-MF; Wed, 07 May 2025 10:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uCfOo-0003i6-AZ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:05:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uCfOm-0008Lo-8Q
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:05:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f861d16622so12081111a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746626722; x=1747231522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGSdUkCxEXbIB9do3YlB8SKdemuH1onJk+9dW7t5Cek=;
 b=cdFK2xyp0vzzqaOTH2WLdi8/CavQPgm0/07sPr+KAEt34qIgWRb3I8Z57OtpgNHaHL
 CF6VNUkhOTb5c6kWQGFqHCbo9Cb1n5Vz9TeX58xhUGsYWjjUXv3GWLliYBJ4fDvHU3yi
 bGhwpuKeAKbjwa1IAio4ZeLVB13Ol91z8cxwQXSwoOII7hDCmJCUJC9nWj0B8u6mEmLE
 ApwyYCqxNxRBHcVlqvAzqo7/r1v/kVLn0hxvEIjjf0ImE0jreo73tTA0y2bH5TGYmB3Q
 oUI8kGqv0zn81BjDDa+6dTlaHrABuI2vA/JvdipGzjICKNN//BT7jjqz1LpdKDMAlDLB
 C9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746626722; x=1747231522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGSdUkCxEXbIB9do3YlB8SKdemuH1onJk+9dW7t5Cek=;
 b=poRsAt3sENBx/WQBJp8BFXwvdOuOeC2bVa0ToPMkMh8Lzp6YPm6ZS/WXpDgNai6/Jj
 v/+HFhCKNHR7/7OFXn7qgbarol9aHD7leyo1BZM3RtW1OyQwuqAW9gX+/R/T2be8rLhT
 PiaT08TmNn5FHte1HoNTSaP1M4nZHA5rJhG1ZFF9C08DXs8DM9JV18/QcfO3oHz2nJb9
 zJqVMJotSHV/xhF0jsJaVhaH1SqO8zslHWIMZQqO4PFV/JhUOVJf9sQM08tbC8qv7rsP
 7AhoVZKEb/uPB91dotckvmLJeyflGbGZ7LAOyubD6I4IaLBh/kKgYHvEj+2hRVODyjHj
 Fb5w==
X-Gm-Message-State: AOJu0YzpbDVmggxi9tAd8ugYXmfCMDvlzPTYq8Rhm2ii8qMZsK0Sx9cJ
 sQutF95ov5i1pIjBm+gPMgW9mojC0dx9SMCL9iFvCb5ROQNARi6YPVdInZ/BPjXb68moc5TzKt/
 fwpP6XNAq3TCsrtgF41vkmyIcHBY=
X-Gm-Gg: ASbGncv7ZVmWAEnwy5jZiByl6c+9ka4SdCpK50aBsK/fuXn1bGQG/UH+MQAh3eu962l
 1jVKGfc+KykEmZUBC0RM1/XsT5EadFITPdQPv8VEBRCoS0baTcAVPCZQc1xxuKLMjfi0LGuVaD0
 j1IIdW7leby7c1ZRVBMWAp
X-Google-Smtp-Source: AGHT+IHzLBcetvEPNzRIgV1K3CZVaRY98JC41be8Oeq2SS6z1FicCJQv4Hh85MEEHL5wuZPl/7LGX5i7yk5hEEP2RnU=
X-Received: by 2002:a05:6402:1ed5:b0:5fa:82a4:4879 with SMTP id
 4fb4d7f45d1cf-5fbe9e5467cmr3071524a12.16.1746626721458; Wed, 07 May 2025
 07:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 May 2025 10:05:09 -0400
X-Gm-Features: ATxdqUG5ITu4U2Gm4tMszDkI9SQaYd1_80acNK0hqZe6IMQy8TcHFyeP7GmYgRg
Message-ID: <CAJSP0QXi1eGdbi5=2EGWuHdL2JX6h513wwVMi167xYZKHjbFSw@mail.gmail.com>
Subject: Re: [PULL 00/32] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, May 6, 2025 at 10:52=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Now I'm back from holiday, here's a target-arm pullreq :-)
>
> thanks
> -- PMM
>
> The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2ea=
b8:
>
>   Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu in=
to staging (2025-05-05 11:26:59 -0400)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-ar=
m-20250506
>
> for you to fetch changes up to 607e1208b53ac713a76d158f4abc4cd2e8870051:
>
>   hw/arm/virt: Remove deprecated virt-4.0 machine (2025-05-06 15:02:35 +0=
100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX SoC
>  * arm/hvf: fix crashes when using gdbstub
>  * target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
>  * hw/arm/virt: Remove deprecated old versions of 'virt' machine
>  * tests/functional: Add test for imx8mp-evk board with USDHC coverage
>  * hw/arm: Attach PSPI module to NPCM8XX SoC
>  * target/arm: Don't assert() for ISB/SB inside IT block
>  * docs: Don't define duplicate label in qemu-block-drivers.rst.inc
>  * target/arm/kvm: Drop support for kernels without KVM_ARM_PREFERRED_TAR=
GET
>  * hw/pci-host/designware: Fix viewport configuration
>  * hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
>
> ----------------------------------------------------------------
> Bernhard Beschow (4):
>       tests/functional: Add test for imx8mp-evk board with USDHC coverage
>       hw/pci-host/designware: Remove unused include
>       hw/pci-host/designware: Fix viewport configuration
>       hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
>
> Mads Ynddal (2):
>       hvf: avoid repeatedly setting trap debug for each cpu
>       hvf: only update sysreg from owning thread

Please take a look at the following aarch64 macOS CI failure:

../accel/hvf/hvf-all.c:61:54: error: unknown type name 'run_on_cpu_data'
61 | static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data a=
rg)
| ^
../accel/hvf/hvf-all.c:68:5: error: call to undeclared function
'run_on_cpu'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
68 | run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
| ^
../accel/hvf/hvf-all.c:68:48: error: use of undeclared identifier
'RUN_ON_CPU_NULL'
68 | run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
| ^
3 errors generated.

https://gitlab.com/qemu-project/qemu/-/jobs/9962088576

>
> Peter Maydell (3):
>       target/arm: Don't assert() for ISB/SB inside IT block
>       docs: Don't define duplicate label in qemu-block-drivers.rst.inc
>       target/arm/kvm: Drop support for kernels without KVM_ARM_PREFERRED_=
TARGET
>
> Philippe Mathieu-Daud=C3=A9 (17):
>       hw/arm/virt: Remove deprecated virt-2.6 machine
>       hw/arm/virt: Remove VirtMachineClass::no_pmu field
>       hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
>       hw/arm/virt: Remove deprecated virt-2.7 machine
>       hw/arm/virt: Remove VirtMachineClass::no_its field
>       hw/arm/virt: Remove deprecated virt-2.8 machine
>       hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers f=
ield
>       hw/arm/virt: Remove deprecated virt-2.9 machine
>       hw/arm/virt: Remove deprecated virt-2.10 machine
>       hw/arm/virt: Remove deprecated virt-2.11 machine
>       hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
>       hw/arm/virt: Remove deprecated virt-2.12 machine
>       hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field
>       hw/arm/virt: Update comment about Multiprocessor Affinity Register
>       hw/arm/virt: Remove deprecated virt-3.0 machine
>       hw/arm/virt: Remove deprecated virt-3.1 machine
>       hw/arm/virt: Remove deprecated virt-4.0 machine
>
> Pierrick Bouvier (4):
>       target/arm/ptw: extract arm_mmu_idx_to_security_space
>       target/arm/ptw: get current security_space for current mmu_idx
>       target/arm/ptw: extract arm_cpu_get_phys_page
>       target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
>
> Tim Lee (2):
>       hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX S=
oC
>       hw/arm: Attach PSPI module to NPCM8XX SoC
>
>  MAINTAINERS                                 |   1 +
>  docs/devel/codebase.rst                     |   2 +-
>  docs/system/qemu-block-drivers.rst.inc      |   2 -
>  include/hw/arm/npcm8xx.h                    |   2 +
>  include/hw/arm/virt.h                       |   6 --
>  target/arm/kvm_arm.h                        |   7 +-
>  accel/hvf/hvf-all.c                         |   7 +-
>  hw/arm/npcm8xx.c                            |  11 +-
>  hw/arm/npcm8xx_boards.c                     |   2 +-
>  hw/arm/virt-acpi-build.c                    |  10 +-
>  hw/arm/virt.c                               | 153 ++++------------------=
------
>  hw/gpio/imx_gpio.c                          |   2 +-
>  hw/pci-host/designware.c                    |   5 +-
>  target/arm/arm-qmp-cmds.c                   |   2 +-
>  target/arm/hvf/hvf.c                        |  27 ++---
>  target/arm/kvm.c                            |  55 ++--------
>  target/arm/ptw.c                            |  71 +++++++++----
>  target/arm/tcg/translate.c                  |   3 +-
>  tests/functional/meson.build                |   2 +
>  tests/functional/test_aarch64_imx8mp_evk.py |  67 ++++++++++++
>  20 files changed, 188 insertions(+), 249 deletions(-)
>  create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py
>

