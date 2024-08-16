Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB78C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TL-0006dA-QX; Fri, 16 Aug 2024 13:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T7-00058r-Mz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:31 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0T4-0007Nu-6d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20203988f37so11051025ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828224; x=1724433024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ltx3coYvH4EqEQjQYY11IM0VCXZXqxusmpe5jU7Dxo0=;
 b=mbXIW9X81Nk7T9nvo4e0w4OrGPIH0XOcQdBnIglFenYoN0HS8pxHo7Q4LS/I/zlLFY
 ZD6jQvg7pBkCCdbGmIdI5IPgQ61R4TvZzvd1iKN+cuQDJDEb2SUe8nerx/xBAz4sPlrx
 1FeyPomPPg9yhn82m9+VXbWFvorAp25Zk5PCmXMybVqQgeLL0oD40dI3dWVC5UgeNvGl
 QIS2ZtfkrhzqR1pCwVZ2SzhIysFh5+xJaeXq4cdPWnUDrsKuY4J7u1r1Wle0PghUDzCD
 FHQLUA3iMLGpdKZNa+uT45A0JQ7srzjkOCgrVQZ0+GXbjsppQCJzoIPxt7p7EWWiEfwH
 V37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828224; x=1724433024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ltx3coYvH4EqEQjQYY11IM0VCXZXqxusmpe5jU7Dxo0=;
 b=dMD1NRLxvsbH5XuSWniCcAdtUAb1Q6Lw2+W/C0O4kqO4dGFLhUsPDHdsGI4wIZqWtl
 PtJIdWK9mEMB5dRCCxqFRozTFJ8ZHkheykETRKiy0vnWQzQIZuPIFTKU2qboZ4cmkB+Q
 ICejuGwvpBuhetQ8Xepn/Ooyhmjp3dTwK5IRO508g49OLtNwsJicyagNfWH6c9h0KSGe
 56MUrAzDplu1V8yTTrUg3wh2GJHWs3XXroAjHC4Bg0SjuET3Aa0fy+uac0wOCLzGqhTe
 gjDkzvxUMY5ITfypeUMDwspKpHeSvJvHhORcFbTEsocuuznj2mAsq4pDhcwISdQsZ7ok
 IuMA==
X-Gm-Message-State: AOJu0YzXLLnxiNCIfTayd0BcKcAwmZD3b3aKSkWdhCh+N/DEfIi1sY1l
 VgQ6bBGBuc+DrQ7lxfhGnfWfYB2/2g/ORsfkgEwlVMC/ZRgSeaWtVSnnR7xrDCQ=
X-Google-Smtp-Source: AGHT+IE8gsZBF1y9p4hZ1aOmfpozfo3gl0F++DiGOokbc3ArL7gseqNXSkxtlsyQxRHp1s646qAjLA==
X-Received: by 2002:a17:90a:fa06:b0:2d3:da99:b41b with SMTP id
 98e67ed59e1d1-2d3dffc6078mr3607095a91.17.1723828223315; 
 Fri, 16 Aug 2024 10:10:23 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:23 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH v2 09/17] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Sat, 17 Aug 2024 03:09:41 +1000
Message-Id: <20240816170949.238511-10-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62c.google.com
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

Implemented functions for setting up and initializing threads in the
RISC-V architecture.
The 'target_thread_set_upcall' function sets up the stack pointer,
program counter, and function argument for new threads.
The 'target_thread_init' function initializes thread registers based on
the provided image information.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_thread.h

diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
new file mode 100644
index 0000000000..4596d3d51f
--- /dev/null
+++ b/bsd-user/riscv/target_arch_thread.h
@@ -0,0 +1,47 @@
+/*
+ *  RISC-V thread support
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
+#ifndef TARGET_ARCH_THREAD_H
+#define TARGET_ARCH_THREAD_H
+
+/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */
+static inline void target_thread_set_upcall(CPURISCVState *regs,
+    abi_ulong entry, abi_ulong arg, abi_ulong stack_base,
+    abi_ulong stack_size)
+{
+    abi_ulong sp;
+
+    sp = (abi_ulong)(stack_base + stack_size) & ~(16 - 1);
+
+    regs->gpr[xSP] = sp;
+    regs->pc = entry;
+    regs->gpr[xA0] = arg;
+}
+
+/* Compare with exec_setregs() in riscv/riscv/machdep.c */
+static inline void target_thread_init(struct target_pt_regs *regs,
+    struct image_info *infop)
+{
+    regs->sepc = infop->entry;
+    regs->regs[xRA] = infop->entry;
+    regs->regs[xA0] = infop->start_stack;               
+    regs->regs[xSP] = ROUND_DOWN(infop->start_stack,16);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


