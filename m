Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA9C2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZJ-0006iZ-GI; Mon, 17 Jun 2024 14:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZD-0005e2-JZ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZB-000521-PS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so4087160b3a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650736; x=1719255536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkBZ3A0IOrNIHfqd0dlYxwhWxjtHcw7wNSmdm0xN6gQ=;
 b=cTp8Btfbcur1h848cwzLEaybjGKyyO89tTlqzmjNSlourqZepHPZUaIbbQZgpBrFjB
 7PvvaP71hMdk29YTrq4Xf12wnvPRWc8ROsrXbIKYD3UAfhqq/ZzSRw5J00k+WFlrUQ9e
 0yEgl89ETmHEV8O4v8YXeg6+umqMIWojsYG75boKHCZUr7gL1Nu0c5Gy2pzImYW7QvBm
 XzB1AaIXBkGgbqY8jTkVgwsJUEAwU5KplLoG4SiysPHYquibOvZNChHM5fQL/BrKPVAh
 ZmPIbcl+E8Tii/ZFilm8TqMUVkpzUSVl5T1mTtVY9jE6sv3XhYxvrKU7RgI9T0jt7eYy
 op1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650736; x=1719255536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkBZ3A0IOrNIHfqd0dlYxwhWxjtHcw7wNSmdm0xN6gQ=;
 b=KDka+e0oaUTWcZOq6lL65z82zzyT63aXZzmv7ng8tDQ1P4ec2TH9XqC3tRWhRaYrgT
 P0nhaEDHAji954C0jMFn8ebG6xnqTPbxXflnkqpXi7xScFqRURWwOWOQoPh9ZoTuDDtm
 Qxzq53u/ONVOXgAOt/dQTtVrX21kG7/YXPXVcHri39WDxgjNkO7Afve9rXSbBYsRhXNg
 WJffpRhWegzqNXH3//UvjBLaBtLBBEixoWFurNOVDs7EecqbORBTWvsLihkiXXCkSYU9
 E1apDiMHAus7z7RwNTjMNzEFeUqLvGSrQpftnc2w7WL+gBCWkyb4+bix7+e1mrS/hOK3
 PEhQ==
X-Gm-Message-State: AOJu0YzAbVAKQiBpNBSoKeVnfZyrdg20FteeTxVZl8vv73kelGQdZAOU
 rvpW3bVDaKAqKmqWqN5FWiLPIrQRjP+/dgF4wWGFIRqHc2dOArWPUrxt5VCtDX4=
X-Google-Smtp-Source: AGHT+IFCBY+zQk7ULjw1BHIaSJPTmTVrjIahFmIUJ9jzz/tuCl+zghFOBOPnaxokWBroXRJCVSvYdA==
X-Received: by 2002:a62:e814:0:b0:705:c0a1:61de with SMTP id
 d2e1a72fcca58-705d71441a5mr10745870b3a.8.1718650736207; 
 Mon, 17 Jun 2024 11:58:56 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:56 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 17/23] Add ARM AArch64 sigcode setup function for bsd-user
Date: Tue, 18 Jun 2024 00:27:58 +0530
Message-Id: <20240617185804.25075-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

signal trampoline function initializes a sequence of instructions
to handle signal returns and exits, and copies this code to the target offset.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_sigtramp.h | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h

diff --git a/bsd-user/aarch64/target_arch_sigtramp.h b/bsd-user/aarch64/target_arch_sigtramp.h
new file mode 100644
index 0000000000..8cdd33b621
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_sigtramp.h
@@ -0,0 +1,48 @@
+/*
+ * ARM AArch64 sigcode for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
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
+/* Compare to ENTRY(sigcode) in arm64/arm64/locore.S */
+static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
+        unsigned sys_sigreturn)
+{
+    int i;
+    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
+
+    uint32_t sigtramp_code[] = {
+    /* 1 */ 0x910003e0,                 /* mov x0, sp */
+    /* 2 */ 0x91000000 + (sigf_uc << 10), /* add x0, x0, #SIGF_UC */
+    /* 3 */ 0xd2800000 + (sys_sigreturn << 5) + 0x8, /* mov x8, #SYS_sigreturn */
+    /* 4 */ 0xd4000001,                 /* svc #0 */
+    /* 5 */ 0xd2800028 + (sys_exit << 5) + 0x8, /* mov x8, #SYS_exit */
+    /* 6 */ 0xd4000001,                 /* svc #0 */
+    /* 7 */ 0x17fffffc,                 /* b -4 */
+    /* 8 */ sys_sigreturn,
+    /* 9 */ sys_exit
+    };
+
+    for (i = 0; i < 9; i++) {
+        tswap32s(&sigtramp_code[i]);
+    }
+
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.34.1


