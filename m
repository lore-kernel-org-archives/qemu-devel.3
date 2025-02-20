Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0B9C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9B5-0008LF-7j; Thu, 20 Feb 2025 11:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9B3-0008Kh-Rz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:29 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tl9Az-0007Gr-3M
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:13:29 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220d601886fso17655185ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740068003; x=1740672803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6hKjm1PNeQza0PKd959xqXDq72ucY0kQWVFSTPldi8=;
 b=acfTUL+ahD7wdDwNu/yID027a5J4Nl9xfnLt8gyhRlT+yOKSnYbeR7mGnEGYo+QHt8
 FecvjMiD6vilS4p7oshBae8sWJkx/j4ZYhKWlUNUyiP9U2uBRW7PBra+o9N2fLPECmng
 IuOqqC8W02PKNsccO7HSxECHrlXobfdzO9F5AUfFJQN9QeJExFqsw4w7WVQgivt4KMAm
 VVsMPxj4fpyFfgHF4erTOR0REThcXXDPakRd8xLqJ8+8IrbHsuJZvuGO7iUogFIrRM5N
 WQwHVy/lDmiuLbLeQnZDn7IP9MUHu4dlJA5dAiKcmy+GzsJwXqwVGR3yIvoTOjous3oC
 o1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068003; x=1740672803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6hKjm1PNeQza0PKd959xqXDq72ucY0kQWVFSTPldi8=;
 b=opQGDdIxFEvs6Leb3MTvtQ1TeJCXFrnHQ77qXSrtGsN95wWzVSP4PdzLQ9hTZCH1a9
 bFEgvzm1G/Yja9m+tjHnVE0zK6gScSrCK6JL3uC3S+78qZeBV6Sy+JKDWPSQAHdgpXz9
 A20oWmty7mluAXvlu19Gbv4wuECQUNryn4AxWX+JLtsGFvmdNGCkw7BX6Y3NP2IqPQTq
 LdfzXHNHIXPWrzk3ZcWCHSGwAILMxoameS/e+bW0awCzs7qoY+EztFl+GzOMZD6g0jgF
 wx+y1Uy67Trv1h/nOXuTQf177GItvFotCwnpQ2NKr6Yoyv/9m91NHSsG1Ubw0EnUc3e4
 07mg==
X-Gm-Message-State: AOJu0Yx1HiSN9+aQK/PAozOLIFnQtitVDCTsBluPYcDh91rOl4P4l9b3
 zsx2+P0yEee8BpdvLCdQ/fyXKe1pCm9o8KrUcdOuIpGtkGqIDN15hn98WuOgR1j0Lr+azrXWDnc
 W
X-Gm-Gg: ASbGncslW0lrHzOdNGSlKR/BxnEzVz6MRu6hVDY7ss7lyL5KDldMqXhiHbxrJIKiFmu
 uvtu1QMXvBI8QaMXBI9ZNL4UWTm3TZjDhu8AMU8uN0GlnGw8PEKGaUoGchIAyo69aMlUTYuLe7t
 al2DXrO1phFl0lUyCi43YHndHd9QoC9eerdUTyqpjItSxEjyIY8XXj+/k0ucRm6evWEdLRRDZ15
 ywbiBCpjUN1PoEHC2nYvDOuQ7a8hnRO+bHUQvMs3ORpk0qorrzDrr1Gw+FQvMI+D7LozPfAuvZQ
 swvBJX0wUUhykf6A5g==
X-Google-Smtp-Source: AGHT+IH9nnmLwB722yY0ER4TU1940DB85PnQdq1rKn7khu8sEUt1a7TFfJUT+JnR7OwzrN+eu7EaDQ==
X-Received: by 2002:a05:6a00:99a:b0:72d:710d:611c with SMTP id
 d2e1a72fcca58-732618fb538mr36899182b3a.20.1740068003153; 
 Thu, 20 Feb 2025 08:13:23 -0800 (PST)
Received: from grind.. ([187.11.154.120]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254618dsm14074072b3a.26.2025.02.20.08.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:13:22 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/3] target/riscv/cpu: ignore TCG init for KVM CPUs in
 reset_hold
Date: Thu, 20 Feb 2025 13:13:11 -0300
Message-ID: <20250220161313.127376-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220161313.127376-1-dbarboza@ventanamicro.com>
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

riscv_cpu_reset_hold() does a lot of TCG-related initializations that
aren't relevant for KVM, but nevertheless are impacting the reset state
of KVM vcpus.

When running a KVM guest, kvm_riscv_reset_vcpu() is called at the end of
reset_hold(). At that point env->mstatus is initialized to a non-zero
value, and it will be use to write 'sstatus' in the vcpu
(kvm_arch_put_registers() then kvm_riscv_put_regs_csr()).

Do an early exit in riscv_cpu_reset_hold() if we're running KVM. All the
KVM reset procedure will be centered in kvm_riscv_reset_vcpu().

While we're at it, remove the kvm_enabled() check in
kvm_riscv_reset_vcpu() since it's already being gated in
riscv_cpu_reset_hold().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 9 +++++----
 target/riscv/kvm/kvm-cpu.c | 3 ---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 522d6584e4..8e6e629ec4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1050,6 +1050,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
+    if (kvm_enabled()) {
+        kvm_riscv_reset_vcpu(cpu);
+        return;
+    }
+
     env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
@@ -1146,10 +1151,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         env->rnmip = 0;
         env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
     }
-
-    if (kvm_enabled()) {
-        kvm_riscv_reset_vcpu(cpu);
-    }
 #endif
 }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..484b6afe7c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1603,9 +1603,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     CPURISCVState *env = &cpu->env;
     int i;
 
-    if (!kvm_enabled()) {
-        return;
-    }
     for (i = 0; i < 32; i++) {
         env->gpr[i] = 0;
     }
-- 
2.48.1


