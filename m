Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE833CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDti-0007bn-FV; Tue, 24 Sep 2024 18:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtP-0005f3-2a
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:24 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtL-0001z0-3N
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso4891736b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216417; x=1727821217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6dIdxWzKr6scmFFBElSzgfuT1kenMy2VdRp0WzdMPg=;
 b=V5b0NTVPhXbsEDFJYxKlSodfL2kDGIKfZdeb4/on4iukjL7xkkC0YagPTEG/LM6Xe5
 y6HHzyCAAU370b3ik8VYQ6am9EGGBUuu2g3UXyFEuxrf16znoBze2D/lktZuNNJM7jOV
 6A0nEtk4GTC+MzWoQIBIaStEUivb3/0+lC4IhKdRlIzA/AStqM+llNFXwum6dcnGTcdI
 CmnkUhRQ5iXTRE5DbN2+65bF3MeOg+GcgGQg/CPZKsmRw0pVod688Tckm2d3vHhJtzzI
 NK6U/PnkVbq2up3tdsu2+tXZkT2yXoPEMksWdmytHnrmSzsQ/POZMUZIPE3TWjNqsnL4
 x90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216417; x=1727821217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6dIdxWzKr6scmFFBElSzgfuT1kenMy2VdRp0WzdMPg=;
 b=YsM7GCHCyMs5jQkiZqwJyTvhXqDjxue1fAqjQdmZo4JOa/bQ6LRy/3kUrgO1POyhqG
 wSL+MHIKvN6BAu/utfWZ0TlBnk1SOcbQRzIGIRf7kCOGpQyVsmWAKi0euXGzt+ik3uzZ
 w4RhFc9Zvb7CAEV729qijOtU1WeDF+wulIoBekdCIUFnrs+tdCtVGZs7cnoavmNmxouA
 N3KZQMSzL6/3WpayCcja0w+ZLczDepNwaO9VAfVnm2R5Om5nc5UvihlTkmhi4Ab9NWYc
 I3UmupwKK51RZ3Fm8oBOpsr4VjEumYLRcspgBXn86GBnz3fmGADvHrN5wS5snMgIhOPT
 H0SA==
X-Gm-Message-State: AOJu0YwGH4KG9zOTOmys4AqhBkK6SVbvPvhtb3Fmd7VOv/wpW9zBGnHb
 lE258KRKIehn/bNcVeCzDVY1ZVtQ6Agx+k/224lrX2MlWANz7snu12NdPA==
X-Google-Smtp-Source: AGHT+IHqrrNx+8jKKkud3bNZwOIkwrlIPhWmAE7JH5tlEFuUt+6xjyy+2gW9rjCI4W66d+V/CLOIKA==
X-Received: by 2002:a05:6a00:812:b0:718:cabe:aa8 with SMTP id
 d2e1a72fcca58-71b0ac53f8dmr980227b3a.18.1727216417235; 
 Tue, 24 Sep 2024 15:20:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 41/47] bsd-user: Define RISC-V system call structures and
 constants
Date: Wed, 25 Sep 2024 08:17:42 +1000
Message-ID: <20240924221751.2688389-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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
Message-ID: <20240916155119.14610-12-itachis@FreeBSD.org>
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
2.46.1


