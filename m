Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B7AEE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socR9-00082M-8w; Thu, 12 Sep 2024 01:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQk-0005W2-Ag
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:51 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQi-00039A-BZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:45 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d82b0ebd51so249959a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119102; x=1726723902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3t80eNs9kvylNawc0Wkcda6DFCgx+hJ52Hiw8JLovs=;
 b=ZOUVuU5/ZZBiJinRmKznjzWXAHDkIZye6KgiVsjLdztPPac+wyX/wFtvb36eKf1XP6
 ZX8LwYeA4Ae1+A/sFB7yEKVxgzy06IC1lbH+VdDuiRw2kpKJFywLBWq3NUYbyeGHZi/4
 QOrN1qw2WDTO73/iUwjdn7u7EiUL2pZpbpFD2aJZEid2JKVur87jTWgLZkCAclduRqUc
 BdhcC6XBReB4WDvxordBG4Erw9dYigG34rGZLLRyXkvGXRsUrM4QNWx+3Py6J34Tw3oD
 OXWnIeN5hlxXvbxGMoVh5txpnNzfv27SZOnq7IBknmBNf9jCZrkflP2QO7j1UgWfu4Tb
 pKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119102; x=1726723902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3t80eNs9kvylNawc0Wkcda6DFCgx+hJ52Hiw8JLovs=;
 b=a7wtYu5wB4DY1HR7ATF92KutKMaATIPUBzAiKw1Ya2b9xWcnmtFdeBvgKVQFYnf8Cb
 XVIZrimSXVp+WVhGIwviX+qhCqJBiuIha6cxTjrWu22IIdLoh9dSJc7q89PyHcgh57lP
 ScFzbEdLAQKGDsJNoVC55Z9RsK83ECQbpHNCOp6AWmR8rGX/Teb06qXATJlJi9mmBJpf
 vgBgglIjzKskDGd+yG/Voz8U6Cq6OQiZ4N9dPsMCxGOZRNvnWzFc/0WCNioAe9dR1Eeu
 VzV2FVnus2rmzYhKpbhmQE8hR0m9+5xj96IsCTka60Utkb1imqUxfG7kQBHPNBpZb6/U
 6XpA==
X-Gm-Message-State: AOJu0YzH3VPbrlLJIxFMU0mGiC76o+m04BgFdGJJxzZcAPRPBFmmB7Fh
 5EnZ4j/ISIO3FEDDwnxtLwWkXE3bWLYikhAs1dwDGRjpbEEXC8lrG/5Mug==
X-Google-Smtp-Source: AGHT+IFD2eOMSa4x5uX3ITCPQT15QXVoxW/oxrdnJ5YHgBfq55Pzq+1iw2SJDqRJQ6qBpBuy1Me4/A==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:38cf:df92 with SMTP id
 adf61e73a8af0-1cf76067aa4mr2244108637.30.1726119101624; 
 Wed, 11 Sep 2024 22:31:41 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:41 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/47] bsd-user: Add RISC-V signal trampoline setup function
Date: Thu, 12 Sep 2024 15:29:37 +1000
Message-ID: <20240912052953.2552501-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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
Message-ID: <20240907031927.1908-8-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


