Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432D6C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9B0-0008JN-Ht; Thu, 20 Feb 2025 11:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9Ay-0008Io-9A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:24 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9Aw-0007GV-Cl
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:24 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso31010445ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740068000; x=1740672800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Ck7MJOclZqyIS84CjNJrs3Sgsjto5PQUBo0xY8ziJc=;
 b=Go85vb28q9UCIX6pg7MeHqBv0Rq3ZXDyGJsszU7piTnIlt3csUK6IjL9SzpHOwHGMR
 vD/Rzi7lqZUDkvhAQngyMxjNYEofM0h8E+N4NKidmcyFO5+jsYAxQy4mC9Q6xtV5/bwR
 KlnXwYe6fSmZHwr+xqnOWtZVg4EFdXdRuWrzuYixlObBOiSLT1nS2+IQ4PAYP3Kd1oft
 Lt23z/eNCYFd2KvzoX4HNsRHs0URjGWhN2UbZXsl1d2lkC5ju8bG0FN+VT5lIeJtqqOg
 8OAcEPHGWOcKTtA5d/nUKkA5wC2V09G4LJ2IVSRj/nbfbC39AjtS6dt0s+3SCt3xZA3U
 fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068000; x=1740672800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Ck7MJOclZqyIS84CjNJrs3Sgsjto5PQUBo0xY8ziJc=;
 b=Wid0FtZ6u6WUtrcpWudQvgEx5+KoshNg9ZSjM5XKZDK4JkwwWofZAtrce2M2vshLLu
 J942OyPJwIALPKXxF2i7yMNvXTFIqmmzrRO1Anq1JRQi/PMthFA5vBtK+ld2KbQpPMdh
 /qMGm/SmBfvQobSN7zC9TRO0PfkfWuhckMYX295uj1sB/3Uv8ahohkPv1P/EecrW80Fx
 cJZgLoimLgeJ+yvXGT6ZvO7axZ6pGa77Q1KGcWCX2KYZaieTlnmJrmKnM0zSAnPSZc7Q
 iDnrOLlt0b+lDbfNAUfgdQhYY4tEMX64Hf/9yuEfSpk0SOeSo7DQl45tt9urXK4h6o5V
 PUIw==
X-Gm-Message-State: AOJu0YyBz9Nwkph1lagJyPgE+yuiehXZ4OCGB1e+GpTIpu+McBK1fwxZ
 VX6/dcgkHcnLj6RXiTeFiT2RmyZOn3s02FR2JYjFjVQkPcIVrwn13Qk50pnCyckUQgpDri6hKnr
 +
X-Gm-Gg: ASbGncvO2zfgKPKVWnsHpE0LWr8e0UeHx/mCL5esu2gRB0jiEYsMiRPf2XfU5+EC0hj
 m36huIsNR1e3fn7h6O54xYikKJV8eat/9glFz5SGPA+WsGoB0CDYqYgikfT3Me+zgGoCBPgF7Ed
 GPbvBTLc1V+bDthgE19kWAA64G5ryAmZdunQnBnywe0p9dyyw3xFpIexVaLaCuU+SaygEsN9p2W
 4/oqANZCo31TaPjs17+ZmF3/Zoqz/Pfm3WjPsKbFV/ehZDlBAYXcGpudFiNj0hjg5rDEgG8A9cf
 C63o1GuMOmsVVrSknw==
X-Google-Smtp-Source: AGHT+IGWzi9DNMtGAayI0jz+aQP5i71EE7FqN8pNCdywt0kWtOATv25G6oSzKh0i8bHefdVpQNJ7VQ==
X-Received: by 2002:a05:6a00:cd4:b0:725:9d70:6ace with SMTP id
 d2e1a72fcca58-73261798a0amr36651902b3a.6.1740067999826; 
 Thu, 20 Feb 2025 08:13:19 -0800 (PST)
Received: from grind.. ([187.11.154.120]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254618dsm14074072b3a.26.2025.02.20.08.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:13:18 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 0/3] target/riscv/kvm: reset time changes
Date: Thu, 20 Feb 2025 13:13:10 -0300
Message-ID: <20250220161313.127376-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

These patches were done in the context of gitlab #2573 [1]. The gitlab
entry per se will probably be closed as a guest software bug, but while
working on it I noticed that we're writing a TCG-initialized
env->mstatus in KVM.

This is happening because riscv_cpu_reset_hold() is doing all TCG
related initialization first, and then calling kvm_riscv_reset_vcpu() in
the end. For example, we're writing '0xa0000000' in 'sstatus' because
TCG is setting env->mstatus = 0xa0000000.

First patch separates KVM vcpu initialization from TCG, centering all
KVM reset procedure into kvm_riscv_reset_vcpu(). Patches 2 and 3 are
small improvements made around get/put KVM csr regs. 

[1] https://gitlab.com/qemu-project/qemu/-/issues/2573

Daniel Henrique Barboza (3):
  target/riscv/cpu: ignore TCG init for KVM CPUs in reset_hold
  target/riscv/kvm: use env->sie to read/write 'sie' CSR
  target/riscv/kvm: reset all available KVM CSRs in kvm_reset()

 target/riscv/cpu.c         |  9 +++++----
 target/riscv/kvm/kvm-cpu.c | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.48.1


