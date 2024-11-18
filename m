Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF7D10F3B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO5-000163-15; Sun, 17 Nov 2024 20:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNy-00011F-80
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:03 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNs-0006OO-5r
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:00 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-720d01caa66so2183716b3a.2
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892612; x=1732497412;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qtC+Z51Zq21nRKfohAzom85rxFqBvO9BQzqq/TjpM8M=;
 b=WqStpT3S+6R9c3R4mnTWNXMthXdvG/VHpyERtN940LvhcbIBsWmbk//dOGiNfmsilA
 awCMVimZcoqymq7EqDq4gW8tni6JQQq2Vyh5LngW170AP0GhrtJjmJzo0l8Mqfml9x6z
 bYnCTp4hbkvuUHs2yrP7yo5rgo4/974G5gCc4FZgX7s/eaCXckKhCtEG0l13gHjG31Dy
 F3ZaVfwuGRse0X5rzw+GxoP4FPZk+O0W7I2B1KT02+eWgS6/UccayT/hZTfXlZbPVGRn
 aiBCmzWJ1pGMo8dDcngP06by1+HhdoOgs7Cl0+/J+66rDdQ+V4DVKtTatOzv69yfcrFL
 wNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892612; x=1732497412;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtC+Z51Zq21nRKfohAzom85rxFqBvO9BQzqq/TjpM8M=;
 b=rHVcqWumF3TUyWt5cGCHTZhzYwS8toHCtjwv4jxTI4zkTDSz8Il5imOZ7A5igM92Kw
 hVd/PD+38T601c+kTnd0FqCWeBO8YJ3nG2JD4CIG/Di2RsgsE+Dn5TDZ21VJmMt/jVF/
 9fdqTanbVLNPkP1GGLPrmgu/+K/bNy9LqhNBilW6BbFX3dOuetJO6Jn+Okd8xBVaQNic
 URQJWw3sJhews+hLC+SrCX5u9Xi80yvOoBW5HKzBDvwosbXqwHZ89AzgDU301K78h7uB
 3k6FeU92MTbOJ7N4G0YvwzR4RTDEuC+TC/dUFQSCw56l7BKJGS1zCuqk6yR2NZCLkX86
 ef1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaCxwnQpSeu5mtHPa7CSrWhROVhXsE7f6omPfqyNOzPyMYiG0owOUe05KGi9nhRAJQbmHdhCV7yNlC@nongnu.org
X-Gm-Message-State: AOJu0YyoBp+of/763scjqA52KZZ8VvhIebaAWXweCam/M/mAEZbVdwsg
 uRz536/liRi4B6/VOS1H8SBf7qwQ3uN+QRLIPw3Y6XrPEaiTbJhTQ5Fgr/W7MGHfrsjZTE8yJ4s
 4
X-Google-Smtp-Source: AGHT+IFUHRKJ2dA9OBVT+RkpKluCai6QIfBxIJf9DQU9RJPjo2OuGG4pwV7R+/Re9HAqvbs36BizQg==
X-Received: by 2002:a05:6a00:1887:b0:71e:594:f1ef with SMTP id
 d2e1a72fcca58-72476c4c7a4mr12310875b3a.16.1731892612274; 
 Sun, 17 Nov 2024 17:16:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:16:51 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v3 00/11] Add RISC-V Counter delegation ISA extension support
Date: Sun, 17 Nov 2024 17:15:48 -0800
Message-Id: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESVOmcC/22NwQrCMBBEf6Xs2UiapFQ8+R9SJG7WdkGTksSgl
 P67sXj0+IaZNwskikwJjs0CkQonDr6C3jWAk/UjCXaVQUllZN92AsPTZ4oXR3caba510Up7NQZ
 7p1BCHc6RbvzapOeh8sQph/jePor6pj+d0v90RQkp0LS9tJ02B7SnyCUk9rjH8IBhXdcPDpciM
 LcAAAA=
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This makes the qemu command line quite tedious. The previous version, I tried
to introduce a preferred rule to enable all but it was decided that an user
should opt to use max cpu if they don't want to enable all the dependant ISA
extensions by hand. This series got rid of the preferred rule and added 2 
patches for specifiying the mandatory ISA extensions via implied rule. 

The first 2 patches decouple the indirect CSR usage from AIA implementation
while patch3 adds stateen bits validation for AIA.
The PATCH4 implements indirect CSR extensions while remaining patches
implement the counter delegation extensions.

The Qemu patches can be found here:
https://github.com/atishp04/qemu/tree/b4/counter_delegation_v3
The Linux kernel patches can be found here (WIP version due to onging upstream
dependant patches):
https://github.com/atishp04/linux/tree/b4/counter_delegation_v2

[1] https://github.com/riscv/riscv-indirect-csr-access
[2] https://github.com/riscv/riscv-smcdeleg-ssccfg

Cc: kaiwenxue1@gmail.com

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes in v3:
1. Updated the priv version in extensions
2. Fixed minor issues pointed out in v2.
3. Dropped preferred rule and added an implied rule for AIA and counter
   delegation.
- Link to v2: https://lore.kernel.org/r/20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com

Changes from previous RFC version:

1. Renamed sxcsrind to csrind to align with other function names.
2. Enable sscofpmf by default for virt machine.
3. Introduced a preferred extension enabling rule strategy for generic
mult-extension dependencies.
4. Enables all PMU related extensions if ssccfg extension is set.

RFC Link:
https://lore.kernel.org/all/35a4d40c-9d0d-4a0a-a2c9-5d5f7def9b9c@ventanamicro.com/T/

---
Atish Patra (5):
      target/riscv: Enable S*stateen bits for AIA
      target/riscv: Add properties for counter delegation ISA extensions
      target/riscv: Invoke pmu init after feature enable
      target/riscv: Add implied rule for counter delegation extensions
      target/riscv: Add configuration for S[m|s]csrind, Smcdeleg/Ssccfg

Kaiwen Xue (6):
      target/riscv: Add properties for Indirect CSR Access extension
      target/riscv: Decouple AIA processing from xiselect and xireg
      target/riscv: Support generic CSR indirect access
      target/riscv: Add counter delegation definitions
      target/riscv: Add select value range check for counter delegation
      target/riscv: Add counter delegation/configuration support

 target/riscv/cpu.c         |  20 +-
 target/riscv/cpu.h         |   1 +
 target/riscv/cpu_bits.h    |  34 ++-
 target/riscv/cpu_cfg.h     |   4 +
 target/riscv/csr.c         | 721 ++++++++++++++++++++++++++++++++++++++++++---
 target/riscv/machine.c     |   1 +
 target/riscv/tcg/tcg-cpu.c |  28 +-
 7 files changed, 756 insertions(+), 53 deletions(-)
---
base-commit: 27652f9ca9d831c67dd447346c6ee953669255f0
change-id: 20240715-counter_delegation-10ab44c7d2c0
--
Regards,
Atish patra


