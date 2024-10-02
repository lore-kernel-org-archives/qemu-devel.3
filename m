Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7D1CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHd-0006uv-8L; Wed, 02 Oct 2024 01:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHO-0006We-9g
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:07 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHM-0004uZ-Qt
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:06 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso33002295ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848322; x=1728453122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJkzELxTn3OW7/j+RZmm2zMtuXmWXrkq8K/BFWuNwEw=;
 b=HeBni1ztO3iM6qiqYChm8XFfQnqtCwRHQ/55OxVBuBB13shIfPoC+tf5zd/0gW3q6a
 5cKa2G601r7BuDWKohxlJnb5mirDlgm7A8CsfwpVNVNUUz6bkMfouPu0Fu5AURtM3FxJ
 WX+6W1xcX2GM8R/3G7K7xSVLlc7GVFaKciohmFMHSC/2o20ijNZZqd1HDWT/sQbutc8T
 sWxZGZtONBQnbrwp8Hy5n10sEWqf5IqDPTIrUOCEko68RTc+FkN8bOM6CkIINe0enBzl
 xdP4h7xzfa+7114p9T+yZYYXpdA65V4LYjy+F470T+1ITFxEmaSVvnUq2ok0dWbKbst5
 nbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848322; x=1728453122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJkzELxTn3OW7/j+RZmm2zMtuXmWXrkq8K/BFWuNwEw=;
 b=GAAvbViS2tT9O5/bkLusp2KOuIp8c8/hnUgs1HVxcLv54D/Zo/5bqYW6UXqBtVfC7N
 U4oV0sgjjviKrV3pqkUAn51bNPl3e4lREXiZtAOjq4OYXEf7FNCEQ4gH0Mo88G+BPX3q
 ESuntEVBNISR85pgV107CosPP481XGGB+b0T+uteEe1Ty2BERhOAG9+SwWRk40xDLFh3
 WRZdCQOiCNX08JoWPv+LSkDyoFN2x4rTP4hXsaqa3Q+JLQuB8e8lqmfFTfzHefHeS7af
 XFwKp7jAg+gGQyVhpUB3Qqq8MOeCOyXkTsr5+s6QaP0Z3wVWP9MfnH7M+6V9dxHUuvXL
 0F4A==
X-Gm-Message-State: AOJu0YzGNasP2H3rgi5JXU2vqzDsFo34nAby6lxKF6jUtEOXeeF3ZTsC
 fVUbCb0Ti5fqTADVGvuVXiefkVe5E0C4maU4RQeHN1g0ktCywdyS7XnQOAg3
X-Google-Smtp-Source: AGHT+IFzOjUcK8kTOO+DPkc1sgu6QjSrRXtWJ9RKd/dRcOuz5jbkcgtfUqwqwi7gh0uE1WMAgE50gQ==
X-Received: by 2002:a17:903:41cd:b0:20b:7be8:8eb9 with SMTP id
 d9443c01a7336-20bc5a791d3mr29461095ad.54.1727848321694; 
 Tue, 01 Oct 2024 22:52:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:01 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 21/35] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Wed,  2 Oct 2024 15:50:34 +1000
Message-ID: <20241002055048.556083-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Mark Corbin <mark@dibsco.co.uk>

Added functions for cloning CPU registers and resetting the CPU state
for RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-4-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 bsd-user/riscv/target_arch_cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index 9c31d9dc4c..a93ea3915a 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -131,4 +131,18 @@ static inline void target_cpu_loop(CPURISCVState *env)
     }
 }
 
+static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gpr[xSP] = newsp;
+    }
+
+    env->gpr[xA0] = 0;
+    env->gpr[xT0] = 0;
+}
+
+static inline void target_cpu_reset(CPUArchState *env)
+{
+}
+
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.46.2


