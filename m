Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97D1CFC5F7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyRx-0005zG-6A; Thu, 10 Oct 2024 15:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyRv-0005yw-BS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:47 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyRt-0004hr-LL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71df2b0a2f7so1179438b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587023; x=1729191823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IFDUPAg7+Ha1HbltQ+giarNdx3k1AVCHB/9UGZf3J68=;
 b=ml5DpcQYO5RLOZgu0CeNbVIEeOUoml3enYa1QWmPyKFWntIIB7PFZml57pljVVJQx+
 2Xlcymsu4MHFQgYA2XPL0av6I+IPH8rOp3HLUiC0uP1hwuvQ8eqDpAVvfBpdkSoaTKdF
 cgABettZE7MTAbem9+KNUqSgl7pqpDbB6Icyz/w9dRbyPHh2dkiF/ZHFxB5ggsEvog/9
 5vsmfiwwxvf1qO/XlB/UPjQEhxYQZTps7nXczQYyPzMYGLnWCw73EgFGnOYXzD/ZYaxr
 Hb0RBZwYjTZxzwWyYctAWdNX37y2bGXYVv2nQlNL7zRUOQofbv4CW0os3/RZumNiEfMP
 RgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587023; x=1729191823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFDUPAg7+Ha1HbltQ+giarNdx3k1AVCHB/9UGZf3J68=;
 b=sd2Zekx2FvhixLr3Js+lH/6DAdBk6lWvXqsFAPPG1FGVsVfCyWvisGeiZUapmGRLCd
 xwZKuU9MakcdtZ0fS1vZnywdZSx9fPdRa8JJlDrng3gO27eMCCBx6R1yz4fJw5tUtvbq
 zXtyt4dMgOMkxeBdAWzsFX1I4bs9Tn/Hm/dbOfU69P88dOiTgjHA5VxTvFiz8K7Ruq9c
 6GwsE/e+Fr7o0sOVx8NSg2qwl4RpjJQOhn27pevP6WBfrd1/Nj0xN9wvs4DqUw7i402W
 fM2OHivCFsCMFaLJxs+/HdHzStbu5zYFajHOYMBVo7oAF4oVqcYdVYPLc7Uv9S+9fKIh
 Lz0Q==
X-Gm-Message-State: AOJu0YzvuE5asj6AiKIQgdmJLTXJaMtUsTiwpPHNqT17/Bkr2cJgSFfn
 JETaGXKIoOa0aYo1RHgd2qLKMe9Q/dXQx3cuNWWd4d73ADkXAswCg//0KacvpYpW137KCRXjBWQ
 t
X-Google-Smtp-Source: AGHT+IFdR7RIHRmG9tLI3GLZ5umz+ubiobAvQLb4Y2NTC5khIHEc38JYIxLFaqqTn5zOSaXG2gfC0Q==
X-Received: by 2002:a05:6a00:1252:b0:714:1bce:913a with SMTP id
 d2e1a72fcca58-71e37f56a3bmr65347b3a.21.1728587023088; 
 Thu, 10 Oct 2024 12:03:43 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:03:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/8] riscv: AIA userspace irqchip_split support
Date: Thu, 10 Oct 2024 16:03:29 -0300
Message-ID: <20241010190337.376987-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

This series adds AIA irqchip_split support, effective when using AIA
with aia=aplic-imsic and -accel kvm,kernel-irqchip=split. 

The main difference between what we currently have and irqchip_split()
mode is that, when using split mode, QEMU will emulate the APLIC
controller instead of using the in-kernel APLIC controller provided by
KVM.

After this series this is the matrix of which interrupt controllers
we're emulating based on 'virt' machine configuration and accelerator
properties:

Accel Accel props   AIA type    APLIC-m IMSIC-m APLIC-s   IMSIC-s
tcg      ----       aplic       emul    n/a     emul      n/a
tcg      ----       aplic-imsic emul    emul    emul      emul
kvm      ----       aplic       n/a     n/a     emul      n/a
kvm      none       aplic-imsic n/a     n/a     in-kernel in-kernel
kvm   irqchip=split aplic-imsic n/a     n/a     emul      in-kernel


Patches based on alistair/riscv-to-apply.next.

Daniel Henrique Barboza (8):
  hw/intc/riscv_aplic: rename is_kvm_aia()
  hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
  hw/riscv/virt.c: rename helper to virt_use_kvm_aia_aplic_imsic()
  target/riscv/kvm: consider irqchip_split() in aia_create()
  hw/riscv/virt.c, riscv_aplic.c: add 'emulated_aplic' helpers
  hw/intc/riscv_aplic: add kvm_msicfgaddr for split mode aplic-imsic
  target/riscv/kvm: remove irqchip_split() restriction
  docs: update riscv/virt.rst with kernel-irqchip=split support

 docs/specs/index.rst          |  1 +
 docs/specs/riscv-aia.rst      | 83 +++++++++++++++++++++++++++++++++++
 docs/system/riscv/virt.rst    |  7 +++
 hw/intc/riscv_aplic.c         | 68 ++++++++++++++++++++++------
 hw/riscv/virt.c               | 38 +++++++++++-----
 include/hw/intc/riscv_aplic.h |  8 ++++
 target/riscv/kvm/kvm-cpu.c    | 41 +++++++++--------
 7 files changed, 202 insertions(+), 44 deletions(-)
 create mode 100644 docs/specs/riscv-aia.rst

-- 
2.45.2


