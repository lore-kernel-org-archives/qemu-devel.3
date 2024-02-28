Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFCDC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfP22-0000lo-RW; Wed, 28 Feb 2024 13:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP21-0000kn-9t
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:53 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1rfP1y-0006ts-Ob
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:51:53 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e4f5e84abeso2585304b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709146309; x=1709751109;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wWd0V1EtOEhJfLeyDpChVNppiwn+uZf8rQF0n8RmV5E=;
 b=Miumsc7BV5dfX4sRTM1vPB/+mEFuz2Prc3qSrZwtUHA+DavmfSSkhHIfKNB3eJWgpc
 GELnf7qKVGor1Q7f0W6HMqJCcm0gvmwHxutVNCPEqbgcH8OLdK0XVFZTtGtSZHSCvncu
 0fCqsO9R7x4278nBrM7v8YReegeg9QRuOMnhPdubIcGI8SG1OHl8mtev4wTTPSM2dNYK
 HdCpH9WFSatjV6exe/f1GuB7tLIYZmC5dEqPgwhEtEvsnsiBRUfZCIVLaiBrZALhuwVv
 tCwmm+Y2wu9U+rZURRTVFl8k220Qz+4qp+Q//HXI8+vrpHO/vvlppLamX6FzZHZ89hXJ
 Gstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709146309; x=1709751109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWd0V1EtOEhJfLeyDpChVNppiwn+uZf8rQF0n8RmV5E=;
 b=Gt1Hfvx41NtFcWFoHG3ZzP3cDQS6Xxra+/8cLzfKseFmoMdHRVFxfn+zRHCO2TIBZo
 37auZUqw0Q3uli+5IudzwaMnrY4u9TFZoFIzIoz2EFQ2+lIaNrpnw4/K6W5MtyF6Tv0W
 BLXgT6n9aIYoVnBinG/qRo91dKj8sMJ9n4CAn5oKvXJ3u+qYk/3pb9bA5iMhuGP9KaVn
 GQw7ek9gC6XiPhDMrCCs5zRqnLGNuCw6I//f6KzMrmEhWemyPLaJReYeJd35r3+ZqLDw
 ASSKYNTyZmDUfquDr2HTGFr+w1QhdjNwAsb4Hmm12tD7lC7nvpD/Xqj+ZLgTJkfZvKPF
 NKyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeGTfVJcR46Qpk4WMftDbviQs4dIa51AFLWigHZXDeZtY2s7QCw4CDkfvJWkcB++2eVJUyWQpB5FOuQ/vEd5ybWlmVNZg=
X-Gm-Message-State: AOJu0Yz7TTWi6HUkxwgxttdiNyhGTB+Dlhxtmt7f1jJMN0aisJlw8Dq6
 LFjiQQ0lQrkVLBHGbFbqWv+tTdedmnXiZ5hux8ITMaE9HJqcKmrNtHC1ZDKPb1rg+FKK7kBXrEA
 5
X-Google-Smtp-Source: AGHT+IFqoUutv1bXbDm4uJjWMlfsLwY7Tow/SsZ3UbfyzmqLO7xZ1e8VV8xDfBUthAwlAMre59XizQ==
X-Received: by 2002:a05:6a00:997:b0:6e5:32ee:216b with SMTP id
 u23-20020a056a00099700b006e532ee216bmr1782pfg.27.1709146307977; 
 Wed, 28 Feb 2024 10:51:47 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a635d54000000b005dbed0ffb10sm49562pgm.83.2024.02.28.10.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 10:51:47 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: 
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 kaiwenxue1@gmail.com
Subject: [PATCH v5 0/5] Add ISA extension smcntrpmf support 
Date: Wed, 28 Feb 2024 10:51:11 -0800
Message-Id: <20240228185116.1321730-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x430.google.com
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

This patch series adds the support for RISC-V ISA extension smcntrpmf (cycle and
privilege mode filtering) [1]. It is based on Kevin's earlier work but improves
it by actually implement privilege mode filtering by tracking the privilege
mode switches. This enables the privilege mode filtering for mhpmcounters as
well. However, Smcntrpmf/Sscofpmf must be enabled to leverage this. This series
also modified to report the raw instruction count instead of virtual cpu time
based on the instruction count when icount is enabled. The former seems to be
the preferred approach for instruction count for other architectures as well.

Please let me know if anybody thinks that's incorrect.

The series is also available at

Changes from v4->v5:
1. Rebased on top of master(158a054c4d1a).
2. Fixed a bug for VS<->HS transition.

Changes from v3->v4:
1. Fixed the ordering of the ISA extension names in isa_edata_arr.
2. Added RB tags.

Changes from v2->v3:
1. Fixed the rebasing error in PATCH2.
2. Added RB tags.
3. Addressed other review comments. 

Changes from v1->v2:
1. Implemented actual mode filtering for both icount and host ticks mode.
1. Addressed comments in v1.
2. Added Kevin's personal email address.

[1] https://github.com/riscv/riscv-smcntrpmf
[2] https://github.com/atishp04/qemu/tree/smcntrpmf_v5

Atish Patra (2):
target/riscv: Fix the predicate functions for mhpmeventhX CSRs
target/riscv: Implement privilege mode filtering for cycle/instret

Kaiwen Xue (3):
target/riscv: Add cycle & instret privilege mode filtering properties
target/riscv: Add cycle & instret privilege mode filtering definitions
target/riscv: Add cycle & instret privilege mode filtering support

target/riscv/cpu.c        |   2 +
target/riscv/cpu.h        |  17 +++
target/riscv/cpu_bits.h   |  34 ++++++
target/riscv/cpu_cfg.h    |   1 +
target/riscv/cpu_helper.c |  17 ++-
target/riscv/csr.c        | 251 ++++++++++++++++++++++++++++++--------
target/riscv/pmu.c        |  64 ++++++++++
target/riscv/pmu.h        |   2 +
8 files changed, 335 insertions(+), 53 deletions(-)

--
2.34.1


