Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0950C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TF-0005fG-Hf; Fri, 16 Aug 2024 13:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T6-00052t-5H
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:29 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0Sz-0007NG-Sb
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:27 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7aa7703cf08so1729307a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828218; x=1724433018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QpyEkD5hCyf20bjl/PDPkzUK6GQYLJTPRQ87D7+i+w=;
 b=d/2kc3FTlUTUT3GlcNvPQxIqARcXt3/OhFNUiYbQpxtHAiKGUhAjBPJQ2c27ihHCt9
 OJXIJEkKB33cLJJbcyrZueAeG6cEf1Oh3+c76AqByomkNYGVGmHaGz6lZ4Sx3LCOAX+d
 TFAk9gUnzAm7UVlK1W+eK9A+gWidFpSGZ4y2ASvcdggR77jDlnKGDCOSr1gzdDAo/zEy
 z9TMdejeHQnbr+4bF61hRigjA/hMnrSb+lOzkholbzHR9lBjBkXoCmcLiB3t4cGQTEjN
 UrbJ4M78nfJXNtuN7yeQcBso2qmlskP9I85MRKxGlaLHk6RqHVrFkDuDA0zqs/DzTghe
 YDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828218; x=1724433018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QpyEkD5hCyf20bjl/PDPkzUK6GQYLJTPRQ87D7+i+w=;
 b=i/ehDtociJHTh7YA554lEodQRJozU/ePljunGffTGKl/zmh6hsaO7lWcpGQxTaBSVS
 aW6qEanzHLqMtwzGpxqStTVnCgWmq6Lj7k6iyY5+2gDU/50970WKu58SH+EI3RI7WQwY
 emyBOE7glJnxQgBvHlLL5soJMgQFVdbyPbd1FDzb8s7zgW8E9W3uIIdDAp0JyuIQILM+
 tDqJeMxxOdSNkiuZ5+MYVBXzq0nVsM7ypsf0yVS3Faojbp4rHi00c42w1WjkAkuqxlTn
 m2ZwTrZIcRyLq7d0pkY9TgsevGmdikUu7IxpLN5aOXtuNXKP0EysV9Xxodktxf+jZsQ8
 nz8Q==
X-Gm-Message-State: AOJu0Yx1ousZzOCZm9K2uYQgAmIcZ09s6/jxUObExkmjCiA3+ka8Xxpg
 7+uXUxeCQLqR8FsioP3PUGry6dFDG0cHhopEOw/Q/iyQmSr7Cyp6AEWRsfWB8kA=
X-Google-Smtp-Source: AGHT+IH97/l1YXdafw9Awg7EUD49r2KWO3/xqvQtwSnmXQHkZqKP4tGMb662y1+vDeNXn7BIb42hYw==
X-Received: by 2002:a17:90b:b07:b0:2d3:dcc1:f98f with SMTP id
 98e67ed59e1d1-2d3dffb5360mr4111319a91.10.1723828218023; 
 Fri, 16 Aug 2024 10:10:18 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:17 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 07/17] bsd-user: Add RISC-V signal trampoline setup function
Date: Sat, 17 Aug 2024 03:09:39 +1000
Message-Id: <20240816170949.238511-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=itachis6234@gmail.com; helo=mail-pg1-x533.google.com
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

Implemented the `setup_sigtramp` function for setting up the signal
trampoline code in the RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


