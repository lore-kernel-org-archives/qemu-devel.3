Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6F6C5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 05:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipu-0006ym-Jm; Sat, 24 Aug 2024 00:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1ships-0006xj-RP
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:12 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipr-0002GB-3z
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:12 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7094468d392so2088291a34.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475430; x=1725080230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=N8yCVZkEseS6QNSBHW8iMr1DmfFN9+gxdbpdkja2bGPpLxEL6zCyrDYMZo7bf+7e/s
 iTEOMECGSW+DZVqZxdCGnIbUSLQBQGFsZTohX8L1h/LtL8y4huIbZMWS3Ckwy16gqj6c
 Ke8tbEBVG3oJikLyj6robdBU7VrKD3cvHSU58TxQz+I/dkQ8PZCekHYX82NmINkvz3Pa
 H8rz/SgC7bMBTMjfAylDwh4HbOBWQx+ztVFse7bhiWAF+IKFD/PY77JPNl1ddO8MJ3LF
 wNVkNoB96scHcSxAFmFv+9fZWFJOuEOj2/LipgbFQlR2VeHvD+v1u+RgBdeHnhyxx1+B
 c5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475430; x=1725080230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=bNSv1/Hxjdtgvxp99G5NjsY4pW1uhiN8UK5xyBYOGPYZ8ozTbqzIVbgUu+PNPiqHYZ
 udZNqfGv2ZXUM+HMVB0iqHcJoXD7y7hy9Z24n+2fPzGfQBO+m77B3tsHfIoprdtw0Xbz
 LnY/i8aOENWct1juKime4CBnodKgfrzw/+5a0u3K4Vf2Sd4MUYAYwW0MfnTgpADOk+PY
 NKE+UMLg1bQPcaslrdZnKZ5K82HhByOcWfs852p7LXm8fcYBsfGjB1bEAT1H9f+ZKbGz
 m6wK8g0w5dQv657UhSDZt2S+aKYHBwC8dmPiJ1v4xRvsjN270IR40cisAp4Pvo13XgW6
 USHQ==
X-Gm-Message-State: AOJu0Yzw0xbtfwaYiHzwXDxscvW78TwN/PI+GP/N7w7Ts6dV3HcRXp28
 /YZD6puYbNwL82enrBZeZ6rlCgfB8kL1BEyGeCVHPiH5suNiUSk0wxTxFOcEUys=
X-Google-Smtp-Source: AGHT+IExXbXm8FMEONRLKtS9EAe9eVMQlhuo6t51Og0h3F2ogSQ5CDRYSnBY8jl9rT0/y+qlAJXS9w==
X-Received: by 2002:a05:6830:348f:b0:701:f6c9:f607 with SMTP id
 46e09a7af769-70e0eae5d09mr5205724a34.5.1724475429665; 
 Fri, 23 Aug 2024 21:57:09 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:57:09 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 08/17] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Sat, 24 Aug 2024 14:56:26 +1000
Message-Id: <20240824045635.8978-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=itachis6234@gmail.com; helo=mail-ot1-x32a.google.com
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


