Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1588EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRc-0000dk-TY; Thu, 12 Sep 2024 01:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQx-0006bC-HN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socQv-00039y-LQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:31:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718d704704aso420809b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119115; x=1726723915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgbEkrj6Ne3TXHG2dEG6b1QuSqV5+ef92+ftslfdewQ=;
 b=PI0NrjXm5PsBUiAUFTKJJWRajhDVH4tfkb5Cr1247zyJsswZ2LP9wbNI7cgrPVBOCY
 O8o9UEHVJshoVHURiaq1Pdmv0FLRszP6Y0FTOqDN2+KAggI2mUCbYrEhudT1qCiDTagd
 z12cVYtV/fE79Kcw3pTBd3PABL88Nk6UjAd0T1uUz7g6O0jVgxbAz/r48NXVykYzPzBN
 Ck3Q8dQd0kE82K/347r1sFj/pHRqQg+cIUtx0kci7DDkqyfpZIv9LOi2m7VzKiIPAjHo
 L1l/PFvx9ym2K/Eu2lkxBqC+clu++FPkB976f1VEOR2PQW3t9T6A8uvyXBqO47RAe38H
 +SnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119115; x=1726723915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgbEkrj6Ne3TXHG2dEG6b1QuSqV5+ef92+ftslfdewQ=;
 b=ar+kFpJ2hieDbuvXuyCM6wW7S/jyrnB29/yAyVxBjha3RzNpwDtWuPrjN7oPuno1+G
 szrhUosE6Rn+l6DvpOBnlzuTZkunlDYlaVhEiLMCj760VIvzIjM6b8bzlgppjmdk+jnO
 GIJgURfTwL4XrYA9TXMnOuuUUmWaQXI9KAMfQ6dbiM4o12Ui/Y7aOXfA7KROBJzFJPCn
 I0JK9MJxxUt8v+w92n87rJJSqVXRLMF/DJbgAk+UPQAxejqtuXYsb/eXpErvCmOq/Y59
 Igd3BThmosZyIxmMoJ4juJWNNBXY59h84DAZuMmE5duqkRztDl4SRjUeSQ5aoHSsBplw
 SiNA==
X-Gm-Message-State: AOJu0YydMAberVJhhfWYXvDYyO3Rf8vJLBnkyLSULMtN7NJRq1poteqM
 tmJgl9SrAw0EYymJV27LKLatGC0B4g/t06JUb2FfK83KwHjIK6eYEQgqyA==
X-Google-Smtp-Source: AGHT+IGPP/yjpq6tkLlCO0h5UMbvAOoUSzJmiafR8/0JqhruSZFdyJ+eNk760Rl0zWFzTQpc3qizHA==
X-Received: by 2002:a05:6a00:2302:b0:718:d7de:3be2 with SMTP id
 d2e1a72fcca58-71926091b7dmr2783115b3a.14.1726119115349; 
 Wed, 11 Sep 2024 22:31:55 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:31:54 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 36/47] bsd-user: Define RISC-V system call structures and
 constants
Date: Thu, 12 Sep 2024 15:29:41 +1000
Message-ID: <20240912052953.2552501-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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

Introduced definitions for the RISC-V system call interface, including
the 'target_pt_regs' structure that outlines the register storage
layout during a system call.
Added constants for hardware machine identifiers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-12-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.46.0


