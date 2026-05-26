Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129D5CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpay-0006iK-3g; Tue, 26 May 2026 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpax-0006eD-29
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:11 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpav-0007y4-FT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:10 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so9245039c88.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779793508; x=1780398308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LNTrsDW4vwaM7sTeKBcMHIN/LyHr74i/KHeH1OCs0M=;
 b=m2d9pJIfA8tVSR8usmJpX+GONsiD7SfprCAg5e82YBGV6/JGtDQXjwA93ROzNqH9st
 GJlSHjSomndt/djCTJFi6Daeyl5RcLtqHZRqvMCNxGj6Jn8/bOZ15or0Eemmm+NrnH/j
 7dRes0rYXa8FOuSj49cJNHOUKA2WoUP5dMo1y183lZkUVIYYNF6j5XlJJCSJTYNOxMvp
 rrjBQ8Mnx5ZMT4joTqP/J3oXNb5or4zxTvxzvaOKZZlB+OTZPKs8pBoWuaV9ZtDMYdc5
 y9l2jpiqrXJ1r/GbCNjmNJIvNEEKOYZcuZ8eE7aNeCQbDulDbmIVjbCYGUmJjgi2MBpy
 vR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793508; x=1780398308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LNTrsDW4vwaM7sTeKBcMHIN/LyHr74i/KHeH1OCs0M=;
 b=PLyHzLaChqdliW0LYPc/cfwJo/5QR6T+NxCrITth0cD2Di1UAPvBBKAx4ceH6mfWib
 rXopfxw8zNJylygyC++/P9qW2e2UXY/uO7PV2v2XJLMLhO2F7XWhxmaZtGJb2DXOupQ5
 tBNFJO3KtfW8M8H3xeMYlqbmEjKZspCQnENk2Ax3w0RonmefUBdbuqE1dZqSxCv9LrNs
 C2FexGa1mhPcSxATsKQFSB9G0JmiZLnoSbRed6sOVySrbhyFUHH2ZipvEBy4CsgjeyZC
 Nz8z+4pnSbkCHKNxetnnU8f/JfKZiWHrjwTIAqKdapG7y7FVNGmcRTTZW96vgaYWS2Ys
 sDrg==
X-Gm-Message-State: AOJu0Yz4gRXhgdXagt2I3sNUnK98/FUV3A06DQqbz9dr4DnKsEhqX94E
 KJX3jIQ2sQTfmgJzTUpetgqxbKktSQDVceYRBFnxZZ8PToMAfQ481rmQiQDxChTc5drIOA==
X-Gm-Gg: Acq92OEbFZ26mNEtOmXZ+rgnt48Sp3fuUF3LZvtANsmeZIXmANpLgFBtUr/+AttWq+S
 QVAhSvdXPwLpBgDvQXQv9uQ9u2bkEoDWV4zp+Em+MIA1IMxAWdXb9R4l+UkNy60xyJBZSGKvOFq
 JWwF+j6GesExpA9WSWney4Dil1pVKaByn/Ra/SAdda7t+QngWRW1d1FoAJKBi0l/x9jXBQCYyYd
 Hxyt4YBjehwN3Tw++o/ZKbiUr9oBz1cPmPXYZPAu9EviBYdzp14/ij5ZuLatI1r1+7v411DckpR
 VpRmMihK/R4/7OqdAoKsio4ghttIP8JQqAuA0yglHRC6jqU+hMgVeATkzGV6WTAIYq1aVrqE1+K
 hk6Po8w8gQxQKx2h22ob1VR6Wez9u507UUgv24WS2IHUPu2Xp6Ou7KG3/0OJpBFTJc35RzFTWQ8
 F9d7jZTH4B6EeahPiYyVVTKYcEYeGg/embPutRkqQudiRTvf9mQ3w/RdHgRf8WDFTUPhX1uEnef
 IN5uBB4fDXNY6sPCNj+NQ==
X-Received: by 2002:a05:7022:1b17:b0:136:e4f:d2b2 with SMTP id
 a92af1059eb24-1365fc6927bmr6837874c88.29.1779793507421; 
 Tue, 26 May 2026 04:05:07 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm9250276c88.2.2026.05.26.04.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:05:06 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2 0/5] target/riscv: Fix no-TCG build
Date: Tue, 26 May 2026 19:04:45 +0800
Message-ID: <cover.1779792111.git.fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526024454.2013810-1-fritchleybohrer@gmail.com>
References: <20260526024454.2013810-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1241.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series fixes the riscv64-softmmu --disable-tcg build by keeping
TCG-only files and code out of no-TCG builds, while keeping common
helpers available for non-TCG configurations.

The first patches move common helpers out of TCG-only helper files. The
later patches reject x-misa-w when TCG is unavailable, provide a no-TCG
stub for riscv_cpu_validate_set_extensions(), and build RISC-V TCG-only
sources only when TCG is enabled.

Changes in v2:
- Split the original patch into smaller logical patches.
- Drop the unused tcg/tcg.h include.
- Add a no-TCG stub for riscv_cpu_validate_set_extensions().
- Keep x-misa-w rejected during CPU realize when TCG is unavailable.

Testing:
- riscv64-softmmu --enable-kvm --disable-tcg --enable-debug builds
  successfully.
- riscv64-softmmu --enable-debug builds successfully.
- qemu-system-riscv64 -M virt,accel=qtest -cpu rv64,x-misa-w=true \
  -S -nographic reports "x-misa-w requires TCG".

Zephyr Li (5):
  target/riscv: Remove unused tcg/tcg.h include
  target/riscv: Move fflags helpers to common code
  target/riscv: Move riscv_raise_exception() to common code
  target/riscv: Reject x-misa-w without TCG
  target/riscv: Build TCG-only code only with TCG

 target/riscv/cpu.c         |  8 +++++-
 target/riscv/cpu_helper.c  | 53 ++++++++++++++++++++++++++++++++++++++
 target/riscv/csr.c         | 11 ++++++--
 target/riscv/fpu_helper.c  | 27 -------------------
 target/riscv/meson.build   |  9 ++++---
 target/riscv/op_helper.c   | 15 -----------
 target/riscv/tcg/tcg-cpu.h | 10 +++++++
 7 files changed, 85 insertions(+), 48 deletions(-)

-- 
2.43.0


