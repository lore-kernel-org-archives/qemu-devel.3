Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0455FC54E62
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMc-0002YB-VF; Wed, 28 Aug 2024 05:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMb-0002TZ-Pc
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMZ-0001pR-VV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:17 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-714263cb074so4582625b3a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838794; x=1725443594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=llhVpMTwyi5fIKhoIWso8dS0jOShUQiF1/J6k/Qc4zRWdlrrEfRiZI6oY8UZfnI6Kp
 qYkIUSIMwFoprj0OrJGkR0ORgVxMk4b0MWx8zrWsQKw8ioYPCp3ZAiESy1FTWnFhG5QW
 aRNl6WhPRlh7WktJWTqDL2jh8Z7uVV7ljWwN2B4j++lxRPJbsGSfSKdQ69yNaDu1hGWU
 ia5GBxxcdMmqjoTH1LvqM4AEEYORvWOREbg/5HEalRFz1BwnOdObSo2GCY94EwwgwxSF
 FQK97Zl0sfuih6SKx/ECrxMSW69pJz4Ut7gXUQMlEiOGJQ2C5hnnnj8Cqgsy76QkbtEy
 YAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838794; x=1725443594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfzjBG7+9yzLMDJFHDoCCaXekwfn4Gr8dayPzH/NfvM=;
 b=l3BJp5FJxLQAz10EyoPrpkO0i85rt/K08GJvxG9qx5tFTepkSDgViLJ0MpoMvb1MDM
 LraCtSpVcg74IaFFL+K7bOcQPWRoQgUOKRPgOY6W3zC1ki8wm6/qu7+AFShiaKWLZXs1
 8WogBaup1bxNG0e79YWqaaqUFIbSI+JwPlc3jV3aNPcv4ABXBLoS2yXehXQ3zuO7JyfA
 6TJa3rtU003/vlhNZhMUcWY6NjgfO0KDSNKMIH+JD6DZRJiY6mNkB80SCx8OOo6LChaC
 2ea0ts6XoENrzuHR80g29Td//WBH3SHtTXWTthsEv8sIQAXXMRpVqrlDShfvwkBGfKYz
 3Ejw==
X-Gm-Message-State: AOJu0YzXo9NSigzG6G4M3fi2MGefm+AZwIQKdspXwo5PZ4lzidNE6cLu
 4ooqsIYiiywcrG82LZu+XrjexiwXFZR1asffH4IHux1fmsw/fiTnoUtoVf16
X-Google-Smtp-Source: AGHT+IFVjTkPABRcen2vD9SFbYT8xn3QHxTxCXUnNlNVkvIR0zaWzJ9pAJPb6lkYsyT1L4glcIi9jg==
X-Received: by 2002:a05:6a00:841:b0:70d:7547:90f7 with SMTP id
 d2e1a72fcca58-71445d4eec6mr17327240b3a.12.1724838794031; 
 Wed, 28 Aug 2024 02:53:14 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:13 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 08/17] bsd-user: Implement RISC-V sysarch system call
 emulation
Date: Wed, 28 Aug 2024 19:52:34 +1000
Message-Id: <20240828095243.90491-9-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x42b.google.com
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


