Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2C4CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm1M-000590-TY; Fri, 06 Sep 2024 23:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzU-0003SM-5r
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:03 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzR-0004ry-GA
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:19:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2068acc8b98so25335315ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679196; x=1726283996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YK5+2cSUNU+r/xq/RK6bCUAfpXhMWvxKXFMLLDunoQ=;
 b=H2hevY8INN8+/6+entI/UAdkRlp1spr5Hzc80qMqKLiElS8wUqT/q3ZrZvffi3kFDu
 LBOpY4lgG/B2e4SkhSxuZmeSdrf2Tkf+Wkl7ztaisKkPnCYT+MjJjSyg6gBumckKZXGB
 dBZHN0i4C8tHKKyiRG86tAIeU0FBSsEfcVbkgrlJiu72DCm3GlAllB4rTcqR6pCGzLwQ
 4486n1hljC9tHIxSIT5fH1r67/wAktPtrCeIEPnjbUTGLMIYg5bZ6CRIu+tTGvGZtDpJ
 /Zv2j5RtZJvu41K9n0L6Cxrj7g+cW5iHOteFsKxRuQhjp0d2so0u3lx2/652jJk35+/D
 ZhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679196; x=1726283996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YK5+2cSUNU+r/xq/RK6bCUAfpXhMWvxKXFMLLDunoQ=;
 b=YPALUcqVaL4KhQ39MD96vjQxPwsZ3GUXVY4aEH5G4fiDNQAZO5SHVAAmroGrbECWx4
 9baSB0u2pJczDixxEbzcp2rvoSNaXzq8aT/ZpLe7nZ02yp8BCeOQ3j+YtdAGqlvXpOKA
 nWGPMt7C8CN7wyCEgW7ps80cVOi+34yZOqznIEXcK/4A3vLdQuFPiT2P8/1AAgKCSuBd
 O7Tb141EpZY924ZN/b7CJOslaY4AQ7rTVx3i1IEDYlt73oLjFKcWozC0v+auufjOKMz4
 L+nvf11qK07w9gsfAtwSZlmVrtb6yd0yNVN6CB/CL2I4zNl15RD0fjdUMBzdtTYgCG6O
 Jbhg==
X-Gm-Message-State: AOJu0YwkmlwRNETv8TJXTRXBaoQbgZyuQySVtuahhUCXd7ouAz8RqJyZ
 LJAuHdaIcTTvWeEGjhdg3CD1ArrZazcmuRXuXLxOkNWG+AORfRW+McCAgg==
X-Google-Smtp-Source: AGHT+IF78gAFUphNEm0z48aKovg92vAfyhnJUehNSxc0uJjcTzN18X3f7uWIviHObxg0cG/TQlyvdA==
X-Received: by 2002:a17:902:c949:b0:206:ae0b:bfb6 with SMTP id
 d9443c01a7336-2070c1967d2mr14078465ad.40.1725679195743; 
 Fri, 06 Sep 2024 20:19:55 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:19:55 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 07/17] bsd-user: Add RISC-V signal trampoline setup function
Date: Sat,  7 Sep 2024 13:19:17 +1000
Message-Id: <20240907031927.1908-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Implemented the 'setup_sigtramp' function for setting up the signal
trampoline code in the RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_sigtramp.h | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h

diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
new file mode 100644
index 0000000000..83345f3961
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sigtramp.h
@@ -0,0 +1,42 @@
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
+    static const uint32_t sigtramp_code[] = {
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


