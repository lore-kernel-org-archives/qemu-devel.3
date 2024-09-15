Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B699AC3ABA0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr8t-00067e-JP; Sun, 15 Sep 2024 11:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8s-00061z-3o
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:26 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr8q-0008BP-Id
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fee6435a34so31555085ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726413983; x=1727018783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4MfaAoEg0D4PG1s02DK0HI+nWn0NbjMokYUO+miRKs=;
 b=FxA82bdT6Q/sMEsJHwkXGEJq4pKbcx8i7bjbBH9Dcmn5aYqlwQH9G1RAfrEra73OhT
 SctJMfzMvZJUsq7EmesDKDz1tojF2rJRGNm+f4IccZSxApJkbNVVec2YkGCK75jCA+HM
 WrUnD3vjOqPkgTgllvy3klT/ZM3WYG0ENb6+YgHGSFenAOETHHvt3H9xsBH9ODDUHRn4
 4wh50Uikty7aKbxQit+oHyCy0YDbyNknNSnhy+jHzduCUy6pyWpHjl60BwoReazQtC4j
 fIKFRDAFbwSeNAm7tjd5xO+iSGfjvaTPg0O/BgEm3wSW8ovfKfIRkBulEAWASh+MoizV
 HMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726413983; x=1727018783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4MfaAoEg0D4PG1s02DK0HI+nWn0NbjMokYUO+miRKs=;
 b=QXLHyM2XnF2IkhhnExu/SEnez5cLqTAIwWiYFmEMj+Bq7XgmydrP9+JR77OsEQTn9V
 Tl1fhpYwMKpzSYms3n1m18tW+2Ce/fGmWNWyBJ/sxxPRC2z6e7n4pLIGm5kIxKSs+59I
 xT6lxq9HepESK3DntCkGziF3eovJixNuieDgOFZicWuQxgGZPWMCResIiR6XzLtesW6y
 n/XKqWUO94LbrRquO+foayDKAUWdO2YBII2VC26KmlhUGZJRDLnFPDX8Xswed36YNERM
 letjuoH+tl56AgOBRJY6xDAHu0WWHPdPmXk68zG8PR4j/xm9KvfJQOo6Kqttlz5moevE
 Tv/A==
X-Gm-Message-State: AOJu0YxoZrygRl0FXvu+7Nqa3uu+iBq+3r75uWmZMgUyUCnLIb2v3cXk
 XXMHLOigxfQxt0F3LU8gL32Spl/+8/BLMjIi+3USYe/wLyM6N1a0/61WrA==
X-Google-Smtp-Source: AGHT+IH7jFDHCHIfeMzEvq0EA5rk8OZia+XmpGutGTb2dCKjvDGp+YO0XrdipjtvcxJeLOqoxZToDw==
X-Received: by 2002:a17:902:e5c5:b0:1fc:6cf5:df4b with SMTP id
 d9443c01a7336-2076e428114mr224121225ad.49.1726413982474; 
 Sun, 15 Sep 2024 08:26:22 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:21 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 05/17] bsd-user: Add RISC-V ELF definitions and hardware
 capability detection
Date: Mon, 16 Sep 2024 01:25:42 +1000
Message-Id: <20240915152554.8394-6-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x630.google.com
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

Introduced RISC-V specific ELF definitions and hardware capability
detection.
Additionally, a function to retrieve hardware capabilities
('get_elf_hwcap') is implemented, which returns the common bits set in
each CPU's ISA strings.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_elf.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_elf.h

diff --git a/bsd-user/riscv/target_arch_elf.h b/bsd-user/riscv/target_arch_elf.h
new file mode 100644
index 0000000000..4eb915e61e
--- /dev/null
+++ b/bsd-user/riscv/target_arch_elf.h
@@ -0,0 +1,42 @@
+/*
+ *  RISC-V ELF definitions
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
+#ifndef TARGET_ARCH_ELF_H
+#define TARGET_ARCH_ELF_H
+
+#define elf_check_arch(x) ((x) == EM_RISCV)
+#define ELF_START_MMAP 0x80000000
+#define ELF_ET_DYN_LOAD_ADDR    0x100000
+#define ELF_CLASS   ELFCLASS64
+
+#define ELF_DATA    ELFDATA2LSB
+#define ELF_ARCH    EM_RISCV
+
+#define ELF_HWCAP get_elf_hwcap()
+static uint32_t get_elf_hwcap(void)
+{
+    RISCVCPU *cpu = RISCV_CPU(thread_cpu);
+
+    return cpu->env.misa_ext_mask;
+}
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE        4096
+
+#endif /* TARGET_ARCH_ELF_H */
-- 
2.34.1


