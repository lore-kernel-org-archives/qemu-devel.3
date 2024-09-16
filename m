Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A41C3ABD1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE0y-0006qG-Sf; Mon, 16 Sep 2024 11:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0w-0006ib-9i; Mon, 16 Sep 2024 11:51:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE0u-0000Tw-Ro; Mon, 16 Sep 2024 11:51:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20688fbaeafso38581975ad.0; 
 Mon, 16 Sep 2024 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501903; x=1727106703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzTEKW6pHdxoRGI49+9LGYc/ShJcZ5J3INnhKg7mgr4=;
 b=SIFAFtxiZE7FPtfx1A4KDmv0cuk2RH6n2JCmtuZ5fwWNhdRsSTCsHI92fm3kDxUwlw
 zLnv+oX8FVEq1kia5c+SmivQHE/71sr/jpbXhVpM3fHQEHxB+nv1ndSUiM+QRtGbO+Dn
 5F0Zm4I+pX3LEBGNnFcCz/NYwNfUYaeoCeEGQdCimeLYg3OEnMMg7UqW1cfwnvkChPKo
 zq/XzcfLXxt5Ninc5JKBrezqJ4iKbG2+35JbxqOTQngUmMbVepNu2EppEnZp+/Pv+M2x
 /zS8Zv6uITDNoHkCl+gDAdvNzCbafSH86fGLWFiWZO/FMNNhwHwNuKEmbjBkuX+8wBZc
 8UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501903; x=1727106703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzTEKW6pHdxoRGI49+9LGYc/ShJcZ5J3INnhKg7mgr4=;
 b=NsLZ9YVu3IaLDxts0wq4FFgpxQQMvm6sB1pC9epW8l8xUO+LsCRCNd26OAhg/IBqxz
 A6VMDcvmQZssfzrW/P2whZSxkAE+C43EmpO2n/XaOFUFTlFLvBspOoTl8J0ZP34pw1r+
 DzRF0iEcV8PFE1BzImEewlrLpi3dhoTY/Uc+/dGupKW0wJsG3jGj5MiAy0Ag59pkFwOO
 J2hQWYAhneMQmZViP0SmEDHRfpeP8i1pRaYZKgc5rJ/ZLU94W33J9Mz+RJftW8tuXkkj
 OQqAnOKI7ctwl0z5m0zw+K8CpAkEspFJsEqhtSphUhTgiy2usSBYu4FBbXMNKcFyjv8o
 bqoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK4WgBz3Pv+GHmgU8oNPkZoSM0t4/cjAm4HYoOcK3cGlcJo11PTS1dfGQg2EUyfpqrX9O/nJ3dIB8t@nongnu.org
X-Gm-Message-State: AOJu0YwLkNwbcv+u+fxCW5O8ibaWYJQ7SBLVWHxziadBm9B0SX18DdTC
 0k6DHnJCTCj9+oZCBq3R0gRhrhMXdglevbioullkEbT6Hvd/WGg4InCNBvwJ
X-Google-Smtp-Source: AGHT+IEzLVh4y6h4BPx8ubX+yoEwt3/ui7DPbs0P69uyDSkcvJOu4hZ19A2QXfs+e25q1xtZdWUbsQ==
X-Received: by 2002:a17:903:18b:b0:205:6c5f:e3ca with SMTP id
 d9443c01a7336-20782b7f000mr165276525ad.53.1726501902537; 
 Mon, 16 Sep 2024 08:51:42 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:42 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 03/17] bsd-user: Implement RISC-V CPU register cloning and
 reset functions
Date: Tue, 17 Sep 2024 01:51:05 +1000
Message-Id: <20240916155119.14610-4-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x631.google.com
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
2.34.1


