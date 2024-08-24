Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922DCC52D6F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipv-00072j-V8; Sat, 24 Aug 2024 00:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipt-0006yI-Ux
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipo-0002G2-Q8
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7141b04e7a3so2177676b3a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475427; x=1725080227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQk2A/hTjmVjUN/uDmSNUdNIQXXqerO9SIB89nvt1XM=;
 b=Fa8TUqpeOWYkDLdslzQEW38B1wRWL/O+F83Bbo30muZIhe8uhuxEvN7hqqEy8IL2g0
 f76sJubxoekLcs2dkZTEyjeaf7SutmmWbOjkPxN7LcYLmCf783nV29DMoRPIUjeEFx/o
 S/E6JKtJwGrOgts37ZOMP6pFSDnPO06R6pS7NIC5R70tjPkND4zna9F4jK80tRf+mU2k
 3GsDhhL4mVjFXlDBe/vvhEf2oReVvp5W3TJj8tSCZLyaqZXwYpfDLtyD67qrvBZDXndl
 aqTQB20CvwTYc9JP/8+2TbEX4D6CyQuOaoVIIvJmxTC+JgiGvzG4QbnzRZpTE/GrOIEE
 Rf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475427; x=1725080227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQk2A/hTjmVjUN/uDmSNUdNIQXXqerO9SIB89nvt1XM=;
 b=daza2MDj+rhHkB9Ie5TikFcJdX83WtuIDQPFhXFcBLNraFT5WOCWWJtUQrQR0UJVR8
 XgRRR7Qfjj70SAyBVAxgIgSsdfPI+fU809WXNsZi0FAIuYKMNCfBt+GXcQutiSF3ar6M
 CAmeU9l7RJVy2DShukMTywlbdf64pmRjPydGhcXTyyd7nGydflP+o89iCsQO3jrEh2PB
 J4xort5AoKGJP1yuGlSOwccd6Xj6vYLsYBPVDSTXsDeHNJ0LS04c7KsOvSFCvgklo/5v
 D3LDPczYVz27DlSXp2lxAN4D8m1F3EVgK2kW8248zlr/g89AztrLSc/Mt1SaG4AFOTJX
 BReA==
X-Gm-Message-State: AOJu0YwP9vDuJv29wEf1xd7/0HQfBz2dEmI/Kuz2iQH08PviFF7S8EkE
 cdizS6NNdzzmR9t1o9trYQn/vhG9ze0vkdG9yR4pGKaA4QdMl2YRs4aNyYdyJLY=
X-Google-Smtp-Source: AGHT+IEmOTWxABknFe6oZKdoovk5E3S46arAmDl6ZB6OQiotsJmdKWO08HkTz7A0UFERX7d1RQGunQ==
X-Received: by 2002:a05:6a00:a13:b0:705:6a0a:de14 with SMTP id
 d2e1a72fcca58-7144573cd1fmr6115765b3a.1.1724475426984; 
 Fri, 23 Aug 2024 21:57:06 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:57:06 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 07/17] bsd-user: Add RISC-V signal trampoline setup function
Date: Sat, 24 Aug 2024 14:56:25 +1000
Message-Id: <20240824045635.8978-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 0000000000..fce673e65a
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
+    /* 1 */ const_le32(0x00010513),                         /* mv a0, sp */
+    /* 2 */ const_le32(0x00050513 + (sigf_uc << 20)),       /* addi a0, a0, sigf_uc */
+    /* 3 */ const_le32(0x00000293 + (sys_sigreturn << 20)), /* li t0, sys_sigreturn */
+    /* 4 */ const_le32(0x00000073),                         /* ecall */
+    /* 5 */ const_le32(0x00000293 + (sys_exit << 20)),      /* li t0, sys_exit */
+    /* 6 */ const_le32(0x00000073),                         /* ecall */
+    /* 7 */ const_le32(0xFF1FF06F)                          /* b -16 */
+    };
+    
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.34.1


