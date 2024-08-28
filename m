Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4075C54E62
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMm-00039M-46; Wed, 28 Aug 2024 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMk-000355-VY
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:27 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMj-0001q4-8T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:26 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d5f9d68805so4552044eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838804; x=1725443604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=Gz66pF9/+2vxWohpdiXkaP38CaKmbvX2kpWAuF9znhbesCp8/RL7b+AsbTfdoWIxGQ
 fHnTChb15sJTY7//h5R31v8UJNJr4TTCuw0ujUQFXWf5alaS9iSTRwsvaMBIYoCb8DW2
 4hbyB1AZheoRqnnEeyP7VZWmy/wLEccIw4LigryOqKM6vkl5DgNJbaYJXdvgCRUwJzj7
 QFRAsbSFs2iJsmv5Vyw0gHBB8NA5xv1zyBvOaT+7aV0l3tiDrvJBz/+8iv+HDTmaxaeR
 i08CE48KlRIulj/a4lG3o6BM3ddsSDRQNyk90RqrHO1XcHzGGGjw0mPNs6uoed10eYJv
 GXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838804; x=1725443604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=TyJKrDK2G/mWz+JOrPWruy9Zm36Cj8qwhLpnbzGjOXfm1PS3p6ojQEKe1e8/H0Wfdb
 P7UXl9JZzaxlGazqp8HykYxPT0Ya2/iuS6rtf/r+4OMwJnfLpD+CZfPCiHh6Ah+ZpYuy
 ntz83QFlNMbCYt1/4zPpT/t7QJvtvDssMnBfRljgvnC70OWoDDIORoxM86KVV8ppgDhH
 XN5p8qD7Q5lmGPgX/g1NSIzRVw5LN59DifXsewC9D8UfT7v+XssOrR41IpVDtDjIEEHw
 p9k/aXAWiyl8e2xzUhvG1vSzunZ42NPy6HiOPdns2f4txOM5k8NoSt/rdeTPJvwznFvV
 OkMA==
X-Gm-Message-State: AOJu0Yzy3TZLg5hmkCUlAexU2Ljp2xh/5GE/NiteTWPoYSlCAjGtBKHR
 v5E/DUAFN68Z5kaYDQgxw0HhzdhF8lqV2PYSgIZrrs0rPLzWe9G4W2lee6bb
X-Google-Smtp-Source: AGHT+IGQ/XJ80Lf93JxE0kRt3TnA67ZSEepVtk1q49ndXJ937X+G3WiwquUu3FmLUy3JkIIT/CcV4A==
X-Received: by 2002:a05:6358:9494:b0:1b1:a8b7:2d03 with SMTP id
 e5c5f4694b2df-1b5facdab69mr185350755d.13.1724838803786; 
 Wed, 28 Aug 2024 02:53:23 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:23 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 11/17] bsd-user: Define RISC-V system call structures and
 constants
Date: Wed, 28 Aug 2024 19:52:37 +1000
Message-Id: <20240828095243.90491-12-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc2b.google.com
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

Introduced definitions for the RISC-V system call interface, including
the 'target_pt_regs' structure that outlines the register storage
layout during a system call.
Added constants for hardware machine identifiers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_syscall.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/riscv/target_syscall.h

diff --git a/bsd-user/riscv/target_syscall.h b/bsd-user/riscv/target_syscall.h
new file mode 100644
index 0000000000..e7e5231309
--- /dev/null
+++ b/bsd-user/riscv/target_syscall.h
@@ -0,0 +1,38 @@
+/*
+ *  RISC-V system call definitions
+ *
+ *  Copyright (c) Mark Corbin
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
+#ifndef BSD_USER_RISCV_TARGET_SYSCALL_H
+#define BSD_USER_RISCV_TARGET_SYSCALL_H
+
+/*
+ * struct target_pt_regs defines the way the registers are stored on the stack
+ * during a system call.
+ */
+
+struct target_pt_regs {
+    abi_ulong regs[32];
+    abi_ulong sepc;
+};
+
+#define UNAME_MACHINE "riscv64"
+
+#define TARGET_HW_MACHINE       "riscv"
+#define TARGET_HW_MACHINE_ARCH  UNAME_MACHINE
+
+#endif /* BSD_USER_RISCV_TARGET_SYSCALL_H */
-- 
2.34.1


