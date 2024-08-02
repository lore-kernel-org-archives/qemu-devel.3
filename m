Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BB4C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkU-0007sx-2L; Fri, 02 Aug 2024 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkS-0007o9-TD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:52 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkR-0006S1-AC
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:52 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7093f3a1af9so4748175a34.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587690; x=1723192490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6q+0lPGAHAs7rCnOgD6eUq4VRS7CW83rLTiEpszDko=;
 b=TDJTVhcFT4Gs7fhMogahOMcVLaUiOYd0biaBb5RVI6OBI1SClgp4FLYc5pglcjdg2P
 646UafCqcPxzA5WzvfsPV46I1bTrB/tktkEbU/8A8daeDBe+NDrSHtc2HuGRmQBRvqZc
 h0yM01USqlEhIA8NkgxTpCVi14kmdCCYj8Brex1XVUQdFlUntuBTfdAxx9aTVquHHmHk
 ZYDHV/lUZfBxJqn2LsdPLCsVc7boJtdPtmjTYLnJgxWv0A3PtEGxBMWL2/7RAYRMo8iY
 yCQdijnsRh3/ArHgcDbP6SpqAQ70CGB7PoZj1JQXRb6eyD3XsKtUoxWlCk20RAVIirsU
 SpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587690; x=1723192490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6q+0lPGAHAs7rCnOgD6eUq4VRS7CW83rLTiEpszDko=;
 b=lbEQxfWzB10jtxMOxXJd+47IFVtVwpxV/1Q+cyMofIedRhm3JQ9VMkEkl+a90K2scf
 4BSP9ASX3qSVECei2rmcJ+Vb4j1niOoz3zd2Q+vYD9VCLWTcNUl1DX+6CnUFuIIDRnp8
 T/i2Xp2NgmX6S7boVwYvEjDpNJNkxQ33tvJI+eQYsh1O/Q/IhX7kqTpnTVD2caAbmT6j
 /RqJBsuzgAwvyBFsXHoU7cdsXZTE/vfIBm9K99SdEkHnfVwLVgDhkz0d5N8JKZdQ7lCZ
 0U2pssbDbrgJagcsl4P7yZM0rnqILIv9pGNYiGjBElAxeb/xHLdxIbtG0HyJqAupOoDc
 3ygw==
X-Gm-Message-State: AOJu0YzILOIJXBcnYUMAXErpi72ddBjOHkLWw7nRiy/DlVqPrfLM/mA8
 PHtyGnS56WgL+GbggbEzaVJapts4m/fq7w/OehSTnZEMj8U6E50zU+Ggj3/tBDk=
X-Google-Smtp-Source: AGHT+IF3BnhgPFivw8S722iZKHAm0/QVDu8qUhUpZwbYzLTLhPh/NDR+3LDD9qs975mLQtVJa3rPKg==
X-Received: by 2002:a05:6830:6dcf:b0:709:49c5:fd99 with SMTP id
 46e09a7af769-709b31fc75cmr4133273a34.4.1722587689953; 
 Fri, 02 Aug 2024 01:34:49 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:49 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH 06/18] bsd-user: Add RISC-V ELF definitions and hardware
 capability detection
Date: Fri,  2 Aug 2024 18:34:11 +1000
Message-Id: <20240802083423.142365-7-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=itachis6234@gmail.com; helo=mail-ot1-x329.google.com
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

From: Mark Corbin <mark.corbin@embecsom.com>

Introduced RISC-V specific ELF definitions and hardware capability
detection.
Additionally, a function to retrieve hardware capabilities
('get_elf_hwcap') is implemented, which returns the common bits set in
each CPU's ISA strings.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/riscv/target_arch_elf.h | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_elf.h

diff --git a/bsd-user/riscv/target_arch_elf.h b/bsd-user/riscv/target_arch_elf.h
new file mode 100644
index 0000000000..dfb2a3e32e
--- /dev/null
+++ b/bsd-user/riscv/target_arch_elf.h
@@ -0,0 +1,48 @@
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
+/*
+ * Note: FreeBSD returns things a litle differently than this, but this is as
+ * close we have in the emulator. The FreeBSD/riscv64 kernel (in identcpu.c)
+ * returns the common bits set in each of the CPUs' ISA strings. Also, unlike
+ * linux, we don't mask out specific bits.
+ */
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


