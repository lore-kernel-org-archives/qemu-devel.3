Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B234C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 21:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPqQ8-00057B-0j; Fri, 05 Jul 2024 17:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sPqQ3-00056i-1N
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:24:39 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sPqQ1-00056B-1O
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 17:24:38 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-24c9f630e51so1242483fac.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720214675; x=1720819475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yww0imN73JEvc2ZP19yTQKRDD8C0ZKwbzciTAfC5Vvc=;
 b=cPN1RY3ZIaRbWcDUyYG8IeptsFNyYx9kvFSMboX1taeM+40OENqBlUdI1NXwiwD5si
 TzyGWhQqo+dtX/LxOFd6bSCXyrgUT504CXpBM8W+Jd3Uywx8B5RvHH/y7jPPSw+hkl+n
 kky631ZszIs7X4ZltrHTWLij1PdVgV6pQCybe6XMdtn8o61kFt67L8+fEzwFOOsHfDND
 FxHhpJSxvKEcTHn2IE5R2U0vpWQawaIGBwb5ppBOCaIG+D3qSA4DDDWmTLzH9Js7meVc
 Ay8Yw/sll6+Y4Fkhvrwi+qKJRD7VUSAdluUdJC3zsHR0oO7K8ReIWegWi4cLbRPMbQdv
 bxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720214675; x=1720819475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yww0imN73JEvc2ZP19yTQKRDD8C0ZKwbzciTAfC5Vvc=;
 b=OzQqxo+mYMkekttBT9xcQDNurY+2H7Zorv7jZKMPC/XNrI3CEVcKiRoelUmDPmgADa
 YL8mz9EdGDfDg+Hb4yUGQNs8DyotlabjGjn8eX8NJRyD2/Pq7cIQOtrxBJwON4iTMOmS
 SanCZ0/N5gQD/DZhA8t93dd4W0mmLunALJayqzWaw0jwWNm+lDFP1sUbCkGg0HsqgUnD
 pq7ntbJKVSHIjKAmVo4MMOe0lyX8nwqOyvuyYQUTwI7t4Bgfn3EBIbxV6NYhkKlMra0f
 Q/Q5kWkh0Ab2RVEwsAI+zdYkUTdhRl//UmSCD9aruZ3m53Gn2DUPZqBxwibxnwnBReom
 MUqg==
X-Gm-Message-State: AOJu0YxjGaL8PgcbthSiz6M1bbBLkYycgEu7s0WW13MAa7x5OeOHoatb
 6m4LWHPMnXLC14buGP99LODzKtDBeif7E5gcN4kCqZ8oK39q1n+JMmCJMNwFqK66HFMij+na8ki
 5
X-Google-Smtp-Source: AGHT+IEwU8xk1AokwXleU9ONOZld/PyaeSQWYGdLLD7jh2PUxJ/7CJQkPm6hqGUzhr7Qr2IqfK0vJw==
X-Received: by 2002:a05:6870:7251:b0:254:77f7:7bdd with SMTP id
 586e51a60fabf-25e2bf4c037mr5426248fac.50.1720214675230; 
 Fri, 05 Jul 2024 14:24:35 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b0067cf78sm3538339b3a.134.2024.07.05.14.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 14:24:34 -0700 (PDT)
Message-ID: <7a0f63e4-9634-4274-af00-93c4a4e34810@ventanamicro.com>
Date: Fri, 5 Jul 2024 18:24:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] riscv: QEMU RISC-V IOMMU Support
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2d.google.com
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

Hi,

Would it make it easier for review if we squash patch 3:

[PATCH v4 03/14] hw/riscv: add RISC-V IOMMU base emulation

and patch 8:

[PATCH v4 09/14] hw/riscv/riscv-iommu: add s-stage and g-stage support

In the same patch?

I'm asking because I've been noticing since the first versions that some reviews
on patch 3 seems to refer to context that are s-stage and g-stage related, i.e.
added later. Perhaps squashing them together makes it easier to review since
we'll have a more complete picture. Patch 3 will end up gaining +381 lines
though.



Thanks,

Daniel



On 6/24/24 5:18 PM, Daniel Henrique Barboza wrote:
> Hi,
> 
> This new version contains changes based on suggestions made during the
> v3 review [1]. Most notable changes:
> 
> - read/write locks were added in both ctx_lock and iot_lock. This code
>    was picked from Tomasz branch;
> - a new riscv_iommu_validate_process_ctx() helper was added to make
>    process-context validations. Suggested by Jason Chien;
> - a new doc patch was added to document how the IOMMU can be used by the
>    'virt' RISC-V board. Suggested by Alistair.
> 
> Patches based on alistair/riscv-to-apply.next. It's also applicable on
> master.
> 
> Patches missing reviews/acks: 3, 9, 14
> 
> * How it was tested *
> 
> This series was tested using an emulated QEMU RISC-V host booting a QEMU
> KVM guest, passing through an emulated e1000 network card from the host
> to the guest.
> 
> The Linux kernel used for tests can be found here:
> 
> https://github.com/tjeznach/linux/tree/riscv_iommu_v6-rc3
> 
> 
> Changes from v3:
> - patch 3:
>    - added FCTL_BE and FCTL_WSI bits to regs_ro[] mask
>    - renamed 'ctx->pasid' to 'ctx->process_id'
>    - added device translation cache update lock ctx_lock
>    - DC.tc.V == 0 is now checked before riscv_iommu_validate_device_ctx()
>    - PC.ta.V == 0 now issues a "PDT entry not valid" error in the end of
>      riscv_iommu_validate_device_ctx()
>    - added a new riscv_iommu_validate_process_ctx() helper to validate PC
>      as section 2.2.4 dictates
> - patch 5:
>    - added RISCV_PCI_CLASS_SYSTEM_IOMMU macro and use it in k->class_id
> - patch 8:
>    - added update lock iot_lock
> - patch 9:
>    - added FSC related checks to riscv_iommu_validate_process_ctx()
>    - moved 'if (mode == bare)' check to happen after ctx->process_id ==
>      noprocid check
> - patch 14 (new):
>    - add riscv-iommu docs for more information on how to use the
>      riscv-iommu-pci device
> - v3 link: https://lore.kernel.org/qemu-riscv/20240523173955.1940072-1-dbarboza@ventanamicro.com/
> 
> [1] https://lore.kernel.org/qemu-riscv/20240523173955.1940072-1-dbarboza@ventanamicro.com/
> 
> 
> Andrew Jones (1):
>    hw/riscv/riscv-iommu: Add another irq for mrif notifications
> 
> Daniel Henrique Barboza (4):
>    pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
>    test/qtest: add riscv-iommu-pci tests
>    qtest/riscv-iommu-test: add init queues test
>    docs/specs: add riscv-iommu
> 
> Tomasz Jeznach (9):
>    exec/memtxattr: add process identifier to the transaction attributes
>    hw/riscv: add riscv-iommu-bits.h
>    hw/riscv: add RISC-V IOMMU base emulation
>    hw/riscv: add riscv-iommu-pci reference device
>    hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
>    hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>    hw/riscv/riscv-iommu: add s-stage and g-stage support
>    hw/riscv/riscv-iommu: add ATS support
>    hw/riscv/riscv-iommu: add DBG support
> 
>   docs/specs/index.rst             |    1 +
>   docs/specs/pci-ids.rst           |    2 +
>   docs/specs/riscv-iommu.rst       |   55 +
>   docs/system/riscv/virt.rst       |   13 +
>   hw/riscv/Kconfig                 |    4 +
>   hw/riscv/meson.build             |    1 +
>   hw/riscv/riscv-iommu-bits.h      |  419 ++++++
>   hw/riscv/riscv-iommu-pci.c       |  178 +++
>   hw/riscv/riscv-iommu.c           | 2372 ++++++++++++++++++++++++++++++
>   hw/riscv/riscv-iommu.h           |  148 ++
>   hw/riscv/trace-events            |   15 +
>   hw/riscv/trace.h                 |    1 +
>   hw/riscv/virt.c                  |   33 +-
>   include/exec/memattrs.h          |    5 +
>   include/hw/pci/pci.h             |    1 +
>   include/hw/riscv/iommu.h         |   36 +
>   meson.build                      |    1 +
>   tests/qtest/libqos/meson.build   |    4 +
>   tests/qtest/libqos/riscv-iommu.c |   76 +
>   tests/qtest/libqos/riscv-iommu.h |  100 ++
>   tests/qtest/meson.build          |    1 +
>   tests/qtest/riscv-iommu-test.c   |  234 +++
>   22 files changed, 3699 insertions(+), 1 deletion(-)
>   create mode 100644 docs/specs/riscv-iommu.rst
>   create mode 100644 hw/riscv/riscv-iommu-bits.h
>   create mode 100644 hw/riscv/riscv-iommu-pci.c
>   create mode 100644 hw/riscv/riscv-iommu.c
>   create mode 100644 hw/riscv/riscv-iommu.h
>   create mode 100644 hw/riscv/trace-events
>   create mode 100644 hw/riscv/trace.h
>   create mode 100644 include/hw/riscv/iommu.h
>   create mode 100644 tests/qtest/libqos/riscv-iommu.c
>   create mode 100644 tests/qtest/libqos/riscv-iommu.h
>   create mode 100644 tests/qtest/riscv-iommu-test.c
> 

