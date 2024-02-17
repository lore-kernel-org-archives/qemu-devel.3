Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D149C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb89Q-0003LI-Nj; Fri, 16 Feb 2024 19:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89M-0003K1-KM
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:01:48 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rb89K-0007uj-ON
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:01:48 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-364f791a428so8029455ab.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708128104; x=1708732904;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RmJP/XsKmdBCkZjvOUwE5P+Vu/3VBxfi41f/YMPCv3k=;
 b=cXsq7+Arz3+BVbCRjr4rJxDwtx1ljdkgsxQFDEJmJdFkUcD+INEiDbRXaRt6Hnq3yE
 MOTo4oVozozubAXjoefiPWr/ZuCgt7HdmJCm+Mx+lIz+hxmwKVvB9VQrlTWAWRniQEUi
 FuAwkk/2+xuOTywXEFiAhRYmz1aZ+GISRR1i/pcWmktkfR1a4Dy8fVB2+HSrPfyhgihv
 asLe1xVC5fFmrG3J+ptJhg7nNPhcL1LApxGSOvv4suVsPkcI/D+8JI978MEUV5RBh+S2
 0nXR3H0WkdeYnuXND67xSg5JnvAd4oKlhtbQ6O48l7cPX9PeOyamNpVcp3BwJ4t6UQze
 NTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708128104; x=1708732904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RmJP/XsKmdBCkZjvOUwE5P+Vu/3VBxfi41f/YMPCv3k=;
 b=mpmY+93MU0NeW7ThFXqS8fHIYacujXkeazDwmqxg5Vy093elT8tDj0ObcamwnwSJJk
 CLPzv9+bslMWwY7M3vEV9NUEnMsFkUFq1pEITcu6JaqrHPSFuMGyAQGhoN1nc0iUb0Nh
 KgN4XUqbq3VxpoxFp/F6SzXsG7w9cG+qm+a3jneENbZ6z0tBG3AKq0mE/wrJ6G5jxLM8
 rgoGNbZW/zQPA2VTym+kJKokaC37GYv2CNYgCRDtyBROHC0xC185UI5hdidOFBwZJEgf
 wfAlDjvRtJqbcZbKOZmJOtzhh+M6G0QI/RJ3LWC9Y7ZX3Nujb/4tpkVokyx+O9eyj1pP
 he3w==
X-Gm-Message-State: AOJu0YwH+SzxZwZKOw1sEVd/VJXsC6VZF5VSFyDjicsjAlLKyalGTBsN
 NwZm+dE6E4P3cn8ugCodLSJMUXj4rS70kAEUqkSbE/LFZ/eGbytYDuT/rRzpa9FMFfNTFVB95LO
 z
X-Google-Smtp-Source: AGHT+IFpDVPqtLOzLzaW0v+WcbEo8qx69oThBxtXGiDdQ6GxUTUzdgMfzhCs9X8OX/MYi3AqJzBanA==
X-Received: by 2002:a92:c006:0:b0:363:b1e7:ed18 with SMTP id
 q6-20020a92c006000000b00363b1e7ed18mr6199987ild.16.1708128104288; 
 Fri, 16 Feb 2024 16:01:44 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a635b0d000000b005d66caee3d0sm464015pgb.22.2024.02.16.16.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:01:43 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
Subject: [PATCH RFC 0/8] Add Counter delegation ISA extension support 
Date: Fri, 16 Feb 2024 16:01:26 -0800
Message-Id: <20240217000134.3634191-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=atishp@rivosinc.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series adds the counter delegation extension support. The counter
delegation ISA extension(Smcdeleg/Ssccfg) actually depends on multiple ISA
extensions.

1. S[m|s]csrind : The indirect CSR extension[1] which defines additional
   5 ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
   RISC-V CSR address space.
2. Smstateen: The stateen bit[60] controls the access to the registers
   indirectly via the above indirect registers.
3. Smcdeleg/Ssccfg: The counter delegation extensions[2]

The counter delegation extension allows Supervisor mode to program the
hpmevent and hpmcounters directly without needing the assistance from the
M-mode via SBI calls. This results in a faster perf profiling and very
few traps. This extension also introduces a scountinhibit CSR which allows
to stop/start any counter directly from the S-mode. As the counter
delegation extension potentially can have more than 100 CSRs, the specificaiton
leverages the indirect CSR extension to save the precious CSR address range.

Due to the dependancy of these extensions, the following extensions must be
enabled to use the counter delegation feature in S-mode.

"smstateen=true,sscofpmf=true,ssccfg=true,smcdeleg=true,smcsrind=true,sscsrind=true"

This makes the qemu command line quite tedious. In stead of that, I think we
can enable these features by default if there is no objection.

The first 2 patches decouple the indirect CSR usage from AIA implementation
while patch3 adds stateen bits validation for AIA.
The PATCH4 implements indirect CSR extensions while remaining patches
implement the counter delegation extensions.

The Qemu patches can be found here:
https://github.com/atishp04/qemu/tree/counter_delegation_rfc

The opensbi patch can be found here:
https://github.com/atishp04/opensbi/tree/counter_delegation_v1

The Linux kernel patches can be found here:
https://github.com/atishp04/linux/tree/counter_delegation_rfc

[1] https://github.com/riscv/riscv-indirect-csr-access
[2] https://github.com/riscv/riscv-smcdeleg-ssccfg

Atish Patra (1):
target/riscv: Enable S*stateen bits for AIA

Kaiwen Xue (7):
target/riscv: Add properties for Indirect CSR Access extension
target/riscv: Decouple AIA processing from xiselect and xireg
target/riscv: Support generic CSR indirect access
target/riscv: Add smcdeleg/ssccfg properties
target/riscv: Add counter delegation definitions
target/riscv: Add select value range check for counter delegation
target/riscv: Add counter delegation/configuration support

target/riscv/cpu.c      |   8 +
target/riscv/cpu.h      |   1 +
target/riscv/cpu_bits.h |  34 +-
target/riscv/cpu_cfg.h  |   4 +
target/riscv/csr.c      | 713 +++++++++++++++++++++++++++++++++++++---
target/riscv/machine.c  |   1 +
6 files changed, 722 insertions(+), 39 deletions(-)

--
2.34.1


