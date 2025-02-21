Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11C7C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlV6Q-00069d-2e; Fri, 21 Feb 2025 10:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlV6O-00069F-PH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:38:08 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tlV6N-0001UW-6V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:38:08 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so4559455a91.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740152285; x=1740757085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yMAi4wNnnxwC+8z3Dgpqeq0wKNVZkgl25zc7VptcZp0=;
 b=Tqd9pI1B2BkcV1iUSH81P1DY4nwjoE7zYXeZssIhLpeX8b7qx9CsYG1ThFG6AgzaId
 2eQsHQSpUs540AChDV8VNZ4+WHH1MAQJCiCKXISqH4OgK4kymSHyiWdTzvBYx9+kUzt0
 3CP5sLWyIgKIW3EIb4pwW1dIhXataBKK3HE/jjzhd2hQuna50B5rsrOz05TaJPoAorFL
 2O2F4r5MzjsfED3uobIYiLsDQdY56fpo6Asq95ELZHEbx948003BvJBUS3RTWy7W6xa8
 BjqpFseDSbyW7C7p1tOj0rxeVFaQtPLdxceXXE3KD6qJaFSd5Tnf7RA0rhP+pdeotFaY
 z7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740152285; x=1740757085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yMAi4wNnnxwC+8z3Dgpqeq0wKNVZkgl25zc7VptcZp0=;
 b=nSRqtO0fxFqo9rwvU80zoYU6zChPpezSszKIIEC2LkA/J0u6R9AeNNo9wRfdIQ/vPQ
 76QK3Kdzj89LKl2pktzx6cZYU1e0URs02DNZOf6SjonSe1LYiRUy1BkTsX97kFfcx1cn
 yJCfoIy+T+Q13pDjlVgEnC6dTrQJkgUA5rG3ddCCaYBU25mD6C/pLW5FdNPThYXJKapo
 Xvenh1jpULfXF8H+RGL9ZQ3RkHEUmkMAl/oO6fk3u4SQM3mzYOoxsoFwB0EjocQhPvzd
 NFPWHbV0xwPuidR6iW8+fc66IAIAA/NoLCjiqmuoxdx27lyxWp7Phr6SO5uDm/xhWBQU
 yySA==
X-Gm-Message-State: AOJu0Yy6wNL4FKpYS6WJ7p2hUBdKKgwt/pBZ4s0i1dosxnVV2uDM/ROr
 q3vess0EPhfB1LZypJsJWDF9gYgF4D7q0vckH0zMUstQyUT6Z4fWyCnWeVu7FlEQkf78fA1xqnd
 m
X-Gm-Gg: ASbGncusOD2LyVr+ho+8p2aPbOeCsy1tPDxHTdwwQVz8o2+tBc3OX5J4bdGHRLjnn6n
 Qz7sujF591ALjUEsg7dvdBCFlcAObSXunp7CX7soV3BFhgloXaTvPAxA0vT3hVSY99un3HL5f0X
 tUrL2UawDY2n9xHoK6RlYJUH3YuNBuKlqC7WPHbGkt+9wEElFNGA8RxZRLUyIjaQvYH6qwdZ2mZ
 rj3uq5nX6oIN0Cd/xU6Nh/1sDnlp9bJAoczf+gbjEbUvBMEKmY/WzMw6Kyb1SQasu87QUhy2QYm
 MvlEhfnUOj0Bovqrdm4EfZ7ZCFSMSTp9KM+ay+ku8rEvvnTpU8zomA==
X-Google-Smtp-Source: AGHT+IFPzk0mV1m51BdJ1Pgojtak96Uz7LBVtg462kp+zixPvK7CNzf821UOEv39OM2VKz1AflO7GQ==
X-Received: by 2002:a17:90b:3b83:b0:2f6:d266:f45c with SMTP id
 98e67ed59e1d1-2fce868c637mr5649127a91.2.1740152285269; 
 Fri, 21 Feb 2025 07:38:05 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.11.154.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb04bedbsm1538081a91.18.2025.02.21.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 07:38:04 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 0/3] target/riscv/kvm: update to Linux 6.14-rc3
Date: Fri, 21 Feb 2025 12:37:55 -0300
Message-ID: <20250221153758.652078-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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

Hi,

In this series we made changes in the commit msg in patch 2 to make it
less ambiguious what the KVM driver will do with ziccrse. 

No other changes made. Patches based on alistair/riscv_to_apply.next.

Changes from v2:
- patch 2:
  - reworded commit message
- v2 link: https://lore.kernel.org/qemu-riscv/20250221141834.626722-1-dbarboza@ventanamicro.com/


Daniel Henrique Barboza (3):
  linux-headers: Update to Linux v6.14-rc3
  target/riscv/cpu.c: create flag for ziccrse
  target/riscv/kvm: add extensions after 6.14-rc3 update

 include/standard-headers/linux/ethtool.h      |  4 +
 include/standard-headers/linux/fuse.h         | 76 ++++++++++++++++++-
 .../linux/input-event-codes.h                 |  1 +
 include/standard-headers/linux/pci_regs.h     | 16 ++--
 include/standard-headers/linux/virtio_pci.h   | 14 ++++
 linux-headers/asm-arm64/kvm.h                 |  3 -
 linux-headers/asm-loongarch/kvm_para.h        |  1 +
 linux-headers/asm-riscv/kvm.h                 |  7 +-
 linux-headers/asm-x86/kvm.h                   |  1 +
 linux-headers/linux/iommufd.h                 | 35 ++++++---
 linux-headers/linux/kvm.h                     |  8 +-
 linux-headers/linux/stddef.h                  | 13 +++-
 linux-headers/linux/vduse.h                   |  2 +-
 target/riscv/cpu.c                            |  3 +-
 target/riscv/cpu_cfg.h                        |  3 +
 target/riscv/kvm/kvm-cpu.c                    |  3 +
 target/riscv/tcg/tcg-cpu.c                    |  2 +
 17 files changed, 156 insertions(+), 36 deletions(-)

-- 
2.48.1


