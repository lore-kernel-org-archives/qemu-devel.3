Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCFC531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TK-0006Sg-EM; Fri, 16 Aug 2024 13:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T7-00058s-NG
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:31 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T1-0007Na-HK
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:29 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7a1843b4cdbso1673660a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828221; x=1724433021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=NeMg7fnG7dFLhDdV3JzwiRYzIsILEtnTrIkLA20ievOapY2FExwiSfCHZ1yeYhJbtI
 mibOFyXmzPbdy3F4bTZAzx2o7C7UI0uR5qS1MTkKy01ifkEh9CAh0R8MM5d/HbpmoMZc
 xOG8tJNrzbzIGMdaA15/cs3azgTRA3SmAcR9QR2YjQS4HXZnT1XSJjnEw6UCznXyi/8q
 CAcXx6Jlj/d2DQS0qKi17X+Yuub2WVOsWiFUhA9EU3TI8d4JZnpnTkt3omSvMenZ8XCg
 M2gYy8wPcwtzAEirQB55K/wTaudRjIo82KuTea32bEwDoglhbNo1WKg/LQx7HFV7BdiT
 AFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828221; x=1724433021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=CXNr2LZIkfdeR7hLV1RwEy5vDtZAOjFqiLP/48MgOjHlUZ8JIfZLLxBIhQHymEGqUf
 AOTJFJI6P4aAWCdX7xddT+6PtCCHLb+1iiOx18IlcBElarLoQHl6QbuW3st7v375Cuhi
 E03UxOACrWM1jSLQ7H11RHBD2ZEssSfhqb+Kc/5TdA9+syVdK1pnDgqsTMidMxS9SzhS
 0f0LP8oriojlmlsTIUMo12y7wPuAbb5EXwMgTMYRTBjpiDxkdT6PJICUCVUnzMSBXitV
 /6+7DxdpFk2Ga/2HUfeSI5e5mQqjnCMkyLMhXt79s1+5M3Ke2/8EUrg6lyRzuGGlI+bU
 n/9Q==
X-Gm-Message-State: AOJu0YwXVsxU+ULJfokJtn64Es1mgQ5ISIruWnI+PAD/9oD4zGph+4oh
 yEqFk6txpnhwneNIrDshLIVN0rIoR6+LW7AAq+4rN3G+tMi+fliCyuiKzhG7C/4=
X-Google-Smtp-Source: AGHT+IHrukgL00U/0e/iKJODEncnQSTgnnnmZj/L7RhTrnqD0S0O5GbHzkGfPZrbBaxDETV92bUcCQ==
X-Received: by 2002:a17:90b:1e03:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2d40533a66emr152704a91.3.1723828220562; 
 Fri, 16 Aug 2024 10:10:20 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:20 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 08/17] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Sat, 17 Aug 2024 03:09:40 +1000
Message-Id: <20240816170949.238511-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x52e.google.com
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

Added the 'do_freebsd_arch_sysarch' function to emulate the 'sysarch'
system call for the RISC-V architecture.
Currently, this function returns '-TARGET_EOPNOTSUPP' to indicate that
the operation is not supported.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_sysarch.h | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sysarch.h

diff --git a/bsd-user/riscv/target_arch_sysarch.h b/bsd-user/riscv/target_arch_sysarch.h
new file mode 100644
index 0000000000..9af42331b4
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sysarch.h
@@ -0,0 +1,41 @@
+/*
+ *  RISC-V sysarch() system call emulation
+ *
+ *  Copyright (c) 2019 Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_SYSARCH_H
+#define TARGET_ARCH_SYSARCH_H
+
+#include "target_syscall.h"
+#include "target_arch.h"
+
+static inline abi_long do_freebsd_arch_sysarch(CPURISCVState *env, int op,
+        abi_ulong parms)
+{
+
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline void do_freebsd_arch_print_sysarch(
+        const struct syscallname *name, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5, abi_long arg6)
+{
+
+    gemu_log("UNKNOWN OP: %d, " TARGET_ABI_FMT_lx ")", (int)arg1, arg2);
+}
+
+#endif /* TARGET_ARCH_SYSARCH_H */
-- 
2.34.1


