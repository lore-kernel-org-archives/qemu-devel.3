Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A28CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtF-0004Mc-5h; Tue, 24 Sep 2024 18:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDt1-0003s4-US
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDsx-0001kk-Rr
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:19:58 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71970655611so5393008b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216393; x=1727821193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXscy2d/VrjAyvG14+9cedJX+vNjOcuClykgW+OR82k=;
 b=LN9p7kvPhwkh/VbXwL5/jv8BVUdJkh349SudG3JHm0mkds6V1I1VzIzareG4eAJ/K5
 wQDckboI7/wSJo/nglHHUY/HWgfzhPXuF+C1x/H7GDSmxeK/bLcS+6wZ+TTPP37DOD8i
 wFqz3b1r4qkRH/XvmWYAi/Vh5+PZzh4WdXa80zIDzqNdI+fzizr1YOGigC2H7qwz67kk
 HoLfBu8E27IZDSyu3Y0/quQyY7stY/z9Y2LX8SLtflUgs0cjuimYE756Uq90ypSkslaE
 jJGweYKkcMItrEdTNQDTdLcEwYcOfkBu2tLsZxjFumnLa5oAtTtoYprkOZC08/jBybVG
 ByFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216393; x=1727821193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXscy2d/VrjAyvG14+9cedJX+vNjOcuClykgW+OR82k=;
 b=IFcaLexEGKz0pDZjb2+4w025yDIEKVNN+jmLO6ZIaS6uMs4+W0ehhmDig2dpprg11p
 SkfWD2qWdgyEjEJ4Kq6vIxOeStRo8lOxD/ZfI4GMrmT6O5cmnc8ZYHkS8I1vjpb57STI
 6LPRSXFLFSxFhzPbljih5eS79pgr88wMHcmDa+zAx4Fz+APCRBPPqTRKAgzYPoLKLgtE
 Yc149t/o0ObzLVxgw9WPd10/7iuypXnfC4NkNOMsR7E1arXpOkEiUhNUYBE49xn2WgK+
 8HXbjW7iSHDU3jxhuzM4uQoWXfUzqKQT1TTtcHO6/N0Y1SDcVZoHbFxqdqzneQQ9eQ++
 9i9Q==
X-Gm-Message-State: AOJu0YzE3kq9x55a8rcsmCF5YKVIjS9KTWf6184aTD+iHrpLTNvUY1is
 qnN7ojIrYzR5s2X+z4YYiZsYkYJDoEwJPtI6TaBvv1W7iqCNbwrc4HHZuQ==
X-Google-Smtp-Source: AGHT+IE1XqGn9hDjSlCtB/SC4saMux/qsEMuMalS+nP9OLZfM/KUJsYMeIueivskuaQRUT+Bb9Nbdw==
X-Received: by 2002:a05:6a21:3514:b0:1d2:d001:5677 with SMTP id
 adf61e73a8af0-1d4d4aaf114mr983519637.17.1727216393008; 
 Tue, 24 Sep 2024 15:19:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:19:52 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 35/47] bsd-user: Add RISC-V ELF definitions and hardware
 capability detection
Date: Wed, 25 Sep 2024 08:17:36 +1000
Message-ID: <20240924221751.2688389-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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
Message-ID: <20240916155119.14610-6-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.1


