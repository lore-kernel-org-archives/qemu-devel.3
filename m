Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120CEC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE15-0007Ja-NS; Mon, 16 Sep 2024 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE14-0007Dh-7x; Mon, 16 Sep 2024 11:51:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE12-0000Uf-Hj; Mon, 16 Sep 2024 11:51:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-205909afad3so47642075ad.2; 
 Mon, 16 Sep 2024 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501910; x=1727106710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4MfaAoEg0D4PG1s02DK0HI+nWn0NbjMokYUO+miRKs=;
 b=UMTtIHWtK1dsKpHWDYMxdmQYPZUm9ssP6Q25Fci5QG5DLg1Fovbg99mQWdZQ0uWbrr
 HgvCyB/hdxQ/ppkNyiFvHPO3GRJptPiAEF588ZwVyTunRH8IQGvkypMQ9Dl1ogjfQIfR
 8La/jnz+23QxnMRLHj/Q0+uEi48abOzBNYnfnYFiPPWzECKQSmpPPtNXxmXneCzPPd6C
 m+Tgpjk5B+84SNixsQbKiKjiTxgNhpwx0cky3uJ+cYPPI+ZNIAu+BlINL70djuoF64a5
 OwPQWHOSOkJYJaRulNrEvlTVjTDeMmgR29fba2QfqCEMjxLXL3YemRFB/2ssOt8UMQZf
 nzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501910; x=1727106710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4MfaAoEg0D4PG1s02DK0HI+nWn0NbjMokYUO+miRKs=;
 b=l9aCIWGvsiCDLe/QxM06t1sPBqlUA4RoXIqsyO/ZNnZiCwNyMCoD7BYKLRQr0HdDjy
 I2uKXcao1tByjE5511+c0JADTIEhDqZVQe4tehyF/iUAE9gvu5GPLyhR7iDoLzAyV/oQ
 dkFCB9H7QcqApNU3/0adGvkw25vtCU3GRUZKT4hodgme0DHAiNP75rdtZ78tMi3lnHRH
 VaFqLPbtdPZSOATzXG9D/W/7EKvqk1+ruFBMKPDgj71hciwwJUAlt8OSErz00zwqKMEy
 bjZEPJYqk3aB1FyeDgby93/XMxZP4NB7So/azPL1vY11joHK0i+8wo2G8aEqzI4RoWlr
 VPFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWkUHi+hqkyAgMR4C/w7lL+OjJlAeNhaHJUzawLueeE8IwIIC1LNvhZjUutHb3dmqrcZZ8M1SI3isl@nongnu.org
X-Gm-Message-State: AOJu0Yw6pLZUplo9Ij5lxUVLC2ub5cqvSMOgHZlacQC6iMTUwf5IkF9I
 XHR7SgY0GmBKu5v5n1n82AsNF4qe+acVTv3Gn1gU+MzcH9sdZ4zfEX4NcjqT
X-Google-Smtp-Source: AGHT+IEVXHvOwF2bRlk50iIDHG4QDwiJtFvyuoa2VzV94BHzd2G6KvXm1mKbo17dcDMocBVIVFE1pw==
X-Received: by 2002:a17:902:c40e:b0:206:add9:624 with SMTP id
 d9443c01a7336-2076e39fc33mr272727285ad.36.1726501910270; 
 Mon, 16 Sep 2024 08:51:50 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:49 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 05/17] bsd-user: Add RISC-V ELF definitions and hardware
 capability detection
Date: Tue, 17 Sep 2024 01:51:07 +1000
Message-Id: <20240916155119.14610-6-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
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


