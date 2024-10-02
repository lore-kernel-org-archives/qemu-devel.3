Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE18ECF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsHk-0007dc-DW; Wed, 02 Oct 2024 01:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHa-0006s2-Jm
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:20 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsHY-0004vU-OP
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:52:18 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20b5affde14so29361665ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848335; x=1728453135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/YnVYWxCAS1mlVESueLk48lGzDFDmr8BoZ4qY9s2jk=;
 b=Gl/6JKPNJm6Thb/aExfL4Vi/Ndl/85x7I7UFIkgc52AslI1CQB6n7am21/ieeo1+DW
 eaF1sYoyeUpigSZValyt/Zap1dV4+BvaLJ1RAM52hdohA/FS0FfAhKyNjCgTiqAUTBOI
 AsMXg1eAjhqzWG8z4xbBTSjiOhR2kq+IKGSKMOO8Xc8PWjcIpb8R41+PkGKU/vPtFwpG
 68Woi6fZqjARcxV8m9aqz5nLSLUgMFHgpbnvrCRQb1YBbCiaUvF0qLkZ6j/H/In1F7VZ
 pUI+SN2K5q9Qd/3dER5bVvCr+pHUEIEN+aHppO4oubfuN2vu98rfMwTuD/COVnWtZH88
 T7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848335; x=1728453135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/YnVYWxCAS1mlVESueLk48lGzDFDmr8BoZ4qY9s2jk=;
 b=a31MoUuedgvSRl21Me6vu7IAmtwhohuLvBjArEzZsXuoN8Uc78SIcFZADw0MOvfDXO
 NRoDsP2vsd3ubmp8L2C8s61wCld6foIhbou4vAlGFxy5gWLzbzuBvXxUYYcw8fTvpded
 fCDMHzwlmWOSMqLH7l2ZLApnbIoj295SKIJURu16y8l5JEq129Wh4OZ/pl2FPC1wJI99
 YxntXUzdnqli4+N68KtIO4hv5IjLDTS7vo/kqQZ3G0SSbQKrwKYdbonD5ra+AZVrzYD/
 n1K8LUoBPQwrwiche7K9p6IBr7bIrFFewGVij6ORa1iF9N6CTPiKjPI+GIYMZhYPo1Ox
 gstg==
X-Gm-Message-State: AOJu0YyT9lGklWvhoyoXdOhp03PMJiUBXE2XALg9r9Fir7gEhWraUdee
 oESP52w/ISo+uGHORhvFdLg1ARSs3Ox+/yCWnCZZ3QGmOts5aNcE9hCs6diL
X-Google-Smtp-Source: AGHT+IGuVGyJnsCXIJpIvTqVW6w56ax0cp7PzlHZSBdGL6RX+3AU2tTeAzZxzbeGvKSwpCreL7vU5Q==
X-Received: by 2002:a17:902:c70a:b0:20b:af36:eb3 with SMTP id
 d9443c01a7336-20bc5a66215mr21760265ad.40.1727848335024; 
 Tue, 01 Oct 2024 22:52:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 25/35] bsd-user: Add RISC-V signal trampoline setup function
Date: Wed,  2 Oct 2024 15:50:38 +1000
Message-ID: <20241002055048.556083-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
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
Message-ID: <20240916155119.14610-8-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.2


