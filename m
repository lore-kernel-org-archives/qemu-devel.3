Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95986C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnka-0008Nh-0u; Fri, 02 Aug 2024 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkX-0008FN-TB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkW-0006Sm-9j
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:57 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so2060114b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587695; x=1723192495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NW5Vf8ctLM3k+PwXCXDOXjwI/0K8umnSkecfcCvyd0=;
 b=HC5cAhEiREV/xGNsRM/914/5KqO+vpTls5gzqo2WZYmUQECPq1Kw2UAknvUtuQKhxO
 EVgPaNssyBhWyDKHEfX1ETx+HjkEnF4Jp0+gs7ctmNom12KG2e0t6PZwy0DCPR349xQu
 1x57+1Lv1cBHyTa9VG7FhPqQZPOUkfjcSkATXkPkKRE2yZsCQFoLyRirvOnViYb/h4Ew
 3+PKE9cd6d65QCfNTmrSP/Rtszeliint6MnltMKNas8zElaK+B1s+LCnULSdZ0gmlN1T
 yYfmizQYQhIseCsPEDm1tPxX+MWyo4LGa9UhTiofqLZrw6vvrx/KAuwzx+5nRnUSqBKZ
 h8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587695; x=1723192495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NW5Vf8ctLM3k+PwXCXDOXjwI/0K8umnSkecfcCvyd0=;
 b=maCALBCyRlRY66588kB1EHNE9cF47dxu3V4KgHGpfR5KCzNz30dsKmMKC6oD6dgxID
 2XYgOsMLKznRfmydxIpxDbf6/RWSrUZl1/uUpGjIEoiRM5C8SGT4Tdy5ZQ4UzL+JIHvx
 9T1YtwwleiLTyLq+C1XKXtKUuQF7K/LeeaaLYQof9aXhMyMvgrV54WQ5Z8MafZ3Fterx
 R0zM/XIxfsJTBMlX0qdHr+zPyvJMHrerAuWbAeNCTfn/cTQeQSDFWlDb31r93SmEHWJE
 a+EVExfOyzQ7zhDVJBm1EpDyfIUunb34KRGBOyqqazRTrcm5np0OXHU3mfLND9kKMyMm
 Hx+Q==
X-Gm-Message-State: AOJu0YyWlPuWFfsQKoCyYaATd9b1ArH7B/2i9vbKFFAbUB7gxUkQTlKM
 Jg3suFGvM9wtOBCOja4+GxMdhU+3Ajk7PDyJHjTiF5uoWaABAHAB1QwRUoR3DNQ=
X-Google-Smtp-Source: AGHT+IFvAJu05tNTzClhqDKz/gQOsEIDDYrTD+8KcxoWB1Vh0tQ30ZNd/7VToU10F2DxS9rtgYZHog==
X-Received: by 2002:a05:6a00:66e7:b0:70d:2208:c98e with SMTP id
 d2e1a72fcca58-7106d8d6efcmr4361867b3a.0.1722587694611; 
 Fri, 02 Aug 2024 01:34:54 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:54 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 08/18] bsd-user: Add RISC-V signal trampoline setup function
Date: Fri,  2 Aug 2024 18:34:13 +1000
Message-Id: <20240802083423.142365-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x434.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Implemented the `setup_sigtramp` function for setting up the signal
trampoline code in the RISC-V architecture.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
---
 bsd-user/riscv/target_arch_sigtramp.h | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h

diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
new file mode 100644
index 0000000000..39c878db22
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sigtramp.h
@@ -0,0 +1,46 @@
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
+    int i;
+    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
+
+    uint32_t sigtramp_code[] = {
+    /* 1 */ 0x00010513,                         /* mv a0, sp */
+    /* 2 */ 0x00050513 + (sigf_uc << 20),       /* addi a0, a0, sigf_uc */
+    /* 3 */ 0x00000293 + (sys_sigreturn << 20), /* li t0, sys_sigreturn */
+    /* 4 */ 0x00000073,                         /* ecall */
+    /* 5 */ 0x00000293 + (sys_exit << 20),      /* li t0, sys_exit */
+    /* 6 */ 0x00000073,                         /* ecall */
+    /* 7 */ 0xFF1FF06F                          /* b -16 */
+    };
+
+    for (i = 0; i < 7; i++) {
+        tswap32s(&sigtramp_code[i]);
+    }
+
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.34.1


