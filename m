Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862BDC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguZQ-0007dT-Sa; Tue, 29 Jul 2025 20:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIw-0004Za-7x
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:22 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIu-0004cG-Ek
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-748d982e97cso5675116b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833859; x=1754438659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T2BtxqsWGW2NTc98A4IhQh0OFPgPTkWNRqLN4IH0P9I=;
 b=Z9KouzLb2uOOv48h6uCvZoOcluS3Z49fLQoTnICYaZJ3EaS2dhbULi3ai8BYCBCVvW
 isPFyhBkB2z9ORm8DE7gZWyqTCOxazrfg3UC1s/eqvwAuBOLdBKjcBTZ/IeyKel4sfjI
 nZMdiVmCU/yeMpSshR412Qsyf0nyo5PI0/QREH4feQCUtCHzE/cJxn37/2oROnzPZ+i/
 bmBLYLdkUcOQt8XP35f9BrAx3SS684CafoUrwbLbvs9BZ3Olk0bSEO98Q8h92qC01MFm
 NbjV+s+Km8H+Ytq4QPJY3DAFY5wsWejLazk80M+M82ZJzkuG1c7Dwl9REFRJivr68/9s
 oDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833859; x=1754438659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2BtxqsWGW2NTc98A4IhQh0OFPgPTkWNRqLN4IH0P9I=;
 b=uNWXIo6LXH6NMkIfVOqps4ai6g6e8/R6mQ8ObzIBGm7F94fkmY6h2PaQpUDQeLU8Mx
 gLE961hOTtNkoTQqYo16YgmExNmeH9xStU8mM6kxZupnwSIRNNOeEhLdsp8s/XFUclfr
 7b2iX+UP8h2kGwO+0TeHR3XtaJNy3QJiBc0ZCQQ2FPe0/4t1o20/pG1fzJVSL3SuM97o
 zoN+CIVxvF7X7cp6UgyapImPLrkZZBM8X/k3lGa2eHxMeV/LG5uXJSq95WaXCzMNnsSs
 COXL/Llp0LNyPM5soUndnyXmhOreyUpMu5Jdeq3QjfqtfcbeqPXBgv+E7Hn40FxahY8R
 vqFQ==
X-Gm-Message-State: AOJu0YzvdiEajlEanxSVPXsZYYD7IZKP9zodVRgucLUULrFv5wiCLBZY
 rMNkp2z5KJqpZRf7B1U0FDZCBFjdCJdgitdvv1CJuOMNVmaOtTYFLu/vw1ZMKIS9Sccl5wEz808
 nirQi
X-Gm-Gg: ASbGncuI+x1Ckcgk/aQeZyKlniOzAtmlgQsSaQBtaKQChru2B6KD04Pb6Z0jK4VAAI6
 tn5NsOxC+qOtcXkP9DceKVpT+RGjd+nAoheiuD3eeVwJW7Hz4uSbHEbGNh/0zjffqKXTh69BJHz
 uhTaJKm4zS0xRxBkndwsGCte0WgFZwrwe45K40SmSj1qCz0KbDM+2XAKmaOdk7mdkM81Lfx5M/w
 Y+JW9vagQQ/iu79HGyIGCnisTO/qrRjDd0AhCqDQFD0wV+JkAU2kWEyqHuz/+pUTO/0LeqcWqUn
 5Hg3NZe68I5g4g/Px3pnFSZlDa1f4McVbxLo5hif2h1+A42oj19IuJqdL28Tdyk+AlAV3r3YPXS
 R3kOlHjw+gpDcfs2d9FuH04Z8c2UUp8GSOr/TaBWyd6zWi8B6CuILNT5KN0z/6SM0jThZt9SYB9
 75kutiUtTRUQ==
X-Google-Smtp-Source: AGHT+IGVanw3TBoIOa4oNzzToESWIYfZfbQPKzVnoypFoxCLd7FdrJOo+CBFsGR+nWxaDM9CCeMGRw==
X-Received: by 2002:a05:6a20:938c:b0:231:acae:1983 with SMTP id
 adf61e73a8af0-23dc0d59618mr2086521637.3.1753833858763; 
 Tue, 29 Jul 2025 17:04:18 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/89] target/openrisc: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:22 -1000
Message-ID: <20250730000003.599084-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c                      | 17 +----------------
 linux-user/openrisc/target_coredump.c.inc | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)
 create mode 100644 linux-user/openrisc/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59d179092b..051e9b72cf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -447,25 +447,10 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS ELFCLASS32
 #define ELF_DATA  ELFDATA2MSB
 
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 8192
 
-/* See linux kernel arch/openrisc/include/asm/elf.h.  */
-#define ELF_NREG 34 /* gprs and pc, sr */
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUOpenRISCState *env)
-{
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(cpu_get_gpr(env, i));
-    }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(cpu_get_sr(env));
-}
-
 #endif /* TARGET_OPENRISC */
 
 #ifdef TARGET_SH4
diff --git a/linux-user/openrisc/target_coredump.c.inc b/linux-user/openrisc/target_coredump.c.inc
new file mode 100644
index 0000000000..fe6c17f199
--- /dev/null
+++ b/linux-user/openrisc/target_coredump.c.inc
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* See linux kernel arch/openrisc/include/asm/elf.h.  */
+#define ELF_NREG 34 /* gprs and pc, sr */
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUOpenRISCState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        (*regs)[i] = tswapreg(cpu_get_gpr(env, i));
+    }
+    (*regs)[32] = tswapreg(env->pc);
+    (*regs)[33] = tswapreg(cpu_get_sr(env));
+}
-- 
2.43.0


