Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E8CC04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 04:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwa5O-0008FA-Ni; Tue, 16 Apr 2024 00:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5L-00086k-Vk
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwa5K-0007AS-1A
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 00:06:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e2c725e234so35216825ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 21:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713240375; x=1713845175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cliU8saQcbFVDKE5SoNvV+Ccq9QeWmSvOygbDeWVqyc=;
 b=luzu0gxgEWpKRlZGu5XpCFtm6bU5c27OYDieBqxPoxVX0KE77Z2oL5dTwpC10j14VQ
 WWvM/jur3wZh1f7J2IPhklnQeCjUp/MOpUNGb6T5zeBsAxFXBxaw3p43wZJW4JTl4zox
 HW0KBYDfkKuDwrxgxv3aI/M9Th+BtWSpVRhCoXcdmXuF2N8u1anHUr1azZyd3FXurdUR
 KhNnAYnkm4BQaqGvFrFguPqa+DxaENiX1t6IEdmfCGnHnZpkH19k6aj/53z0mz2hZy6v
 mVf7oElgr3QfszFtVlb9XytDuu/TPJghoI4+3GRXiwr6mtmtbFNC1aRJhwnlHYLi0A7W
 4kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713240375; x=1713845175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cliU8saQcbFVDKE5SoNvV+Ccq9QeWmSvOygbDeWVqyc=;
 b=P2bbQIvH1OGu1Pp00FIiipBpHLOq0bYkTfhxAWc/DR8wdYY+kslu0QFQdhXBQvUDW9
 5df8xP2NvXyMQd8WiIHAbLguJe2eK3VAjmKrqp41mJzsnaQD8BGN2AxaqmS/OwiLOW0M
 lmYSGNL3dNmvC1/OnUE35ISd7QyG/5ixByzc0gK83BHI4/1y5RAz0wN5Cu9FoevarFeI
 uVuXFezEDxVjQfesLG2/sTx745330U7lN9C8GgNxRE5t9DGVxpUDTJSFB2uPhlCdmQG+
 BgMtKpdRqHlNQk/68oh+oBhyptzE9fFGN5OboEq+Uc0N1kW+rifnacTWAAYbTI2+uN8g
 AKDg==
X-Gm-Message-State: AOJu0YzeqxsYX1aImKuM+uMG6Rsrald/Nuy5utfuZQJR5sTvjY6DXrsm
 EP+DZ12CD7sd9nyqzfQRp+44hQLxGHMCsaujRUwDdOp3HWWuFX6I+P73hK1dV40f6rm/3UnFJyG
 D
X-Google-Smtp-Source: AGHT+IEiDeSKLZ9mA/Wsyej7nfMsUEc8eLpN7DAO8H94fQez/TkMsWSx0JvpWbm0goWlwvUOglAMgw==
X-Received: by 2002:a17:902:e741:b0:1e5:5c69:fcda with SMTP id
 p1-20020a170902e74100b001e55c69fcdamr2235414plf.26.1713240375547; 
 Mon, 15 Apr 2024 21:06:15 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170902f68100b001e3e244e5c0sm8694439plg.78.2024.04.15.21.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 21:06:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
Subject: [PATCH 5/7] target/i386: Split out gdb-internal.h
Date: Mon, 15 Apr 2024 21:06:07 -0700
Message-Id: <20240416040609.1313605-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416040609.1313605-1-richard.henderson@linaro.org>
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/gdb-internal.h | 65 ++++++++++++++++++++++++++++++++++++++
 target/i386/gdbstub.c      |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 target/i386/gdb-internal.h

diff --git a/target/i386/gdb-internal.h b/target/i386/gdb-internal.h
new file mode 100644
index 0000000000..7cf4c1a656
--- /dev/null
+++ b/target/i386/gdb-internal.h
@@ -0,0 +1,65 @@
+/*
+ * x86 gdb server stub
+ *
+ * Copyright (c) 2003-2005 Fabrice Bellard
+ * Copyright (c) 2013 SUSE LINUX Products GmbH
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
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
+#ifndef I386_GDB_INTERNAL_H
+#define I386_GDB_INTERNAL_H
+
+/*
+ * Keep these in sync with assignment to
+ * gdb_num_core_regs in target/i386/cpu.c
+ * and with the machine description
+ */
+
+/*
+ * SEG: 6 segments, plus fs_base, gs_base, kernel_gs_base
+ */
+
+/*
+ * general regs ----->  8 or 16
+ */
+#define IDX_NB_IP       1
+#define IDX_NB_FLAGS    1
+#define IDX_NB_SEG      (6 + 3)
+#define IDX_NB_CTL      6
+#define IDX_NB_FP       16
+/*
+ * fpu regs ----------> 8 or 16
+ */
+#define IDX_NB_MXCSR    1
+/*
+ *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
+ */
+
+#define IDX_IP_REG      CPU_NB_REGS
+#define IDX_FLAGS_REG   (IDX_IP_REG + IDX_NB_IP)
+#define IDX_SEG_REGS    (IDX_FLAGS_REG + IDX_NB_FLAGS)
+#define IDX_CTL_REGS    (IDX_SEG_REGS + IDX_NB_SEG)
+#define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
+#define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
+#define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
+
+#define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
+#define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
+#define IDX_CTL_CR3_REG     (IDX_CTL_REGS + 2)
+#define IDX_CTL_CR4_REG     (IDX_CTL_REGS + 3)
+#define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
+#define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
+
+#endif
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index ebb000df6a..9662509b82 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "include/gdbstub/helpers.h"
+#include "gdb-internal.h"
 
 #ifdef TARGET_X86_64
 static const int gpr_map[16] = {
-- 
2.34.1


