Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A855DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkg-0000QK-El; Fri, 02 Aug 2024 04:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkd-0000Et-Uk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:03 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkc-0006Tz-3f
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:03 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db35ec5688so3485552b6e.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587700; x=1723192500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1PoKK1KvQqOqMpcnJ72usaN63rv4asAXIIrjwlK4wk=;
 b=jNBpK244LpT0fRHAybjfYQj84rQ49a+XvXbJauOi6E3K0PJgk1EY+wzxUu4F0X6Lp6
 rUOxOGxBflQ5SDctgDlesFyU29nP/tUzUqX4xz6qCMsnDYi1bjnno1qVYNopJ12XN7VG
 iOsxkdgf/bdVf27WBHSbcROxmuxYb9w1JeUOyJqQRGuPJI7o2HLYhjw+FCywU1X9P0KE
 TSga5lBJCAnKofAZKEzspsyWCX2Os1sQ5rtz5ZanApi1IeWhn1LAnHb0+j06VafW1Dng
 H4AqXSfgAP/dIw3eWFwjt5rkhC5eRH3/rpGVBjyv9lsppjG+TvmrhS87OwvdPeauZ3rl
 CEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587700; x=1723192500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1PoKK1KvQqOqMpcnJ72usaN63rv4asAXIIrjwlK4wk=;
 b=ZBTom6fbBKVSiaov2VJKHBpBAw1Zm5nzAKrnMTo2Nv/HNubrm57uMwxAAWpyWG+m66
 08XjMj0AsxaTyXRXfcUmQv1FFW1mfcgJyPxcWhFlhYm16sQNy3cW75rwfzk8QfxYSt0q
 R4pLW0shXwGivUyfjghTHZKnDcbqRD5FTjbWcA/bWcvJOfvC7JDdKvTfpSohI/zZ0gdA
 N0/O8OJ9yQT7FCsfHB7JfQO9NQ26CBRe9mUrkwe0I2MwS4c9rwbFcQdtudnngX8139jr
 fSuwlsSTbPSpSQrH3VFxfKF2TBZvssjlyebO8ko6Ax/bRI7zxzkBglVjjS0WJLYS694f
 fyKg==
X-Gm-Message-State: AOJu0YyKguKK6iHkFhocc9hhChDul5Eevke+tyfplELWQaeSFYMc5wGP
 4teG/7JZt2neAAEdrI2mHhlv/d+FgRzDjTehoU4mutTy0PsEMtmyu3OLwADDr40=
X-Google-Smtp-Source: AGHT+IF+GV3LThP32it/10m6OeWMJN5p4Vx/OC2hGAYKFG1Gz1gvqMvPmbslSMdMC3dOXXusUH1eqg==
X-Received: by 2002:a05:6808:2014:b0:3da:a16e:1759 with SMTP id
 5614622812f47-3db558401famr2873155b6e.48.1722587699843; 
 Fri, 02 Aug 2024 01:34:59 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:59 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH 10/18] bsd-user: Add RISC-V thread setup and initialization
 support
Date: Fri,  2 Aug 2024 18:34:15 +1000
Message-Id: <20240802083423.142365-11-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=itachis6234@gmail.com; helo=mail-oi1-x236.google.com
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

Implemented functions for setting up and initializing threads in the
RISC-V architecture.
The 'target_thread_set_upcall' function sets up the stack pointer,
program counter, and function argument for new threads.
The 'target_thread_init' function initializes thread registers based on
the provided image information.

Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_thread.h

diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
new file mode 100644
index 0000000000..faabb9fb45
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
+    regs->regs[10] = infop->start_stack;               /* a0 */
+    regs->regs[xSP] = infop->start_stack & ~(16 - 1);
+}
+
+#endif /* TARGET_ARCH_THREAD_H */
-- 
2.34.1


