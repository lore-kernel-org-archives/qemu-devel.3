Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A295FC3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr91-0006XK-Hj; Sun, 15 Sep 2024 11:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8z-0006Un-As
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:33 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8x-0008CH-KQ
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2053525bd90so20690005ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413989; x=1727018789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eptwr1B6TaRaZQ7aEdRCfkv5ZrQAsR2zaI7/YwKtIOQ=;
 b=dqpDFI6+0CEq0RuQhi/+SSKcNL+6TGOarU1Lh+vBTJN+3qVpc8TuRQyRAQLbz1wn65
 /Y7+udDxKqr/wJkOe2i3ocYgUBMw0ysj+DlV9JtfFFPvQwhWDkjXFWJeFvNUbmRigL2C
 V0Dhff+7mCdF1VW0wCMqtMc3rVvPud+H7a2uCQy/X6ntG69l3jS1SxqXmfj7OzAXXpIc
 5p1GqHqwGZ74LVRW3vFUrfISOjHAhMdeWW5/Iwt3OBaAQyG0RiU1L5aA0EcFL2rQt4rI
 kyIQ4YildwQtaVTEwv06GfB+wpxnQgWbAp1Dg7Z2teBjG2NQVY32EPsWeibF9fYEXW2I
 kPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413989; x=1727018789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eptwr1B6TaRaZQ7aEdRCfkv5ZrQAsR2zaI7/YwKtIOQ=;
 b=V/FzT/LxU4cpjc+vkoJ8Hx23mEP4rpQRM/hpbcTbJWImblmvt9z4TbZC6YFz3TDmH2
 Q6iCiooY0qB5sbX3/K2cQLFg6AKyy2/RMYs6kfr+ts4QJEF/fBqUKf1yj4503ald2LzE
 gK6uQKwkaJet2IA8tqZTcure8rnhOElZoVFUlFvdWCD73cfm+3I0hY7ns3oYjKHGqLL7
 EM3NrlZQuYpDI9UIdUHXw3w5O+pj3mXoLOGngJBQHm/KWzNr6iVVsypegSosZLiKZejn
 e3EubtuEgMC5iJBD9zOOcU/zEJ+5VLSAA3RBGKAfs5E9Ae6hxYWB6dezXyk/zNkBJHt4
 lGBg==
X-Gm-Message-State: AOJu0YyDkLH02gmGS9pGBr+aiApcqCkLtUIHnOV6Wicnvd6KZ6F0JXMU
 ZMqexU08e14a8FCN5KWNJLlInRjfApbnhWXYFxJNI1BSoNdlXWqFQHuzLQ==
X-Google-Smtp-Source: AGHT+IHTvBrfYTMnDuHIkf1lR1yQKX5cqnkHFRzGOpIhvzalmPJ39md9DpUM4ixAzLr96Tc2VEZc+w==
X-Received: by 2002:a17:902:d4d2:b0:202:2b3e:28d0 with SMTP id
 d9443c01a7336-20781b425d5mr120388025ad.8.1726413989040; 
 Sun, 15 Sep 2024 08:26:29 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:27 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 07/17] bsd-user: Add RISC-V signal trampoline setup function
Date: Mon, 16 Sep 2024 01:25:44 +1000
Message-Id: <20240915152554.8394-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62b.google.com
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

Implemented the 'setup_sigtramp' function for setting up the signal
trampoline code in the RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_sigtramp.h | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h

diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
new file mode 100644
index 0000000000..dfe5076739
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sigtramp.h
@@ -0,0 +1,41 @@
+/*
+ * RISC-V sigcode
+ *
+ * Copyright (c) 2019 Mark Corbin
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_SIGTRAMP_H
+#define TARGET_ARCH_SIGTRAMP_H
+
+/* Compare with sigcode() in riscv/riscv/locore.S */
+static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
+        unsigned sys_sigreturn)
+{
+    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
+
+    uint32_t sigtramp_code[] = {
+    /*1*/ const_le32(0x00010513),                        /*mv a0, sp*/
+    /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi a0,a0,sigf_uc*/
+    /*3*/ const_le32(0x00000293 + (sys_sigreturn << 20)),/*li t0,sys_sigreturn*/
+    /*4*/ const_le32(0x00000073),                        /*ecall*/
+    /*5*/ const_le32(0x00000293 + (sys_exit << 20)),     /*li t0,sys_exit*/
+    /*6*/ const_le32(0x00000073),                        /*ecall*/
+    /*7*/ const_le32(0xFF1FF06F)                         /*b -16*/
+    };
+
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.34.1


