Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9F6C5479A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMa-0002OE-Dt; Wed, 28 Aug 2024 05:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMY-0002HJ-Rx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:14 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMX-0001p3-1E
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:14 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2704d461058so4490188fac.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838791; x=1725443591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQk2A/hTjmVjUN/uDmSNUdNIQXXqerO9SIB89nvt1XM=;
 b=K7FX7Gt2n7Yao//0xJXu/zTrGHvJswwg3G+JgBNpN1F8S3zh/Iwefyf4xAtYFA7dpe
 4GAx1wWy0ltm4Lmq15VYpasbRA3pj3AaMVqPpfXxYypWYO46jT4zZPW/B+LGeoU7+kjD
 pzErsSgsxtw4HjSJF79t7BYL0E6/din7FAnWrOAfmICOgdgMnWXV2To9X1QoZ8Q7xqWn
 upKKxio2ZJoHiIRu2XvGLDJtmPmTD6wF5ZkNHB48GOEF9igcn1Lz7j+fPqOFxfdD8cGh
 CZwosXKLp7+ubKUhhQX67J14W73FJ+aDL0lbv0DPYI1y2PgIEiTVSp6rkE+exlVXV3aB
 Q41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838791; x=1725443591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQk2A/hTjmVjUN/uDmSNUdNIQXXqerO9SIB89nvt1XM=;
 b=XpF02S9W4fwP9UmLynjf6OFBDICx9AcPPk0tXBsLo7hPgpOqkbW69F6966kvxpASav
 yrJjqEwnyHpYED+qz77LI3IFNmmUk3wF2PYwbdS0EeDMBgI0U7scVDsajE3A1p788GLN
 oq2xN4HdBisket7IS+h0UmS0/5osgtOXfpIeKDBESrEWix7zkHc07g/XD1m+gA/HV3v4
 Nkjrky0CK+llKZzfdVdAyuYXqbSV9roiW7aVtaSOcBJx0tBEhPuv/eE7+UylO3UR5UaG
 OfiK7SdOfknUEhbSEtdZ2c3ml1POyysOHoop3WV4RfEUnR3wJZHKFNnHlJ07P7hKEIFl
 Xq4w==
X-Gm-Message-State: AOJu0Yx19l4OxwcYLiGMzZ44nh0BHOyaP/Pnw2JS2+UZAiuDn40XV7L2
 EGxPZexfySJbo6P0ph6bFO3XvjCgS9YgQyqL2sbCYXf/tCr+QwN71rgi9Ylf
X-Google-Smtp-Source: AGHT+IEBYdz0kwr9sC/X0GP0Yi1PlyHTXTgcSqIleC5qpHghXH4OkPjles+onTsrHFn601Q/h5mmTQ==
X-Received: by 2002:a05:6870:8286:b0:270:130f:cee0 with SMTP id
 586e51a60fabf-273e661aeadmr17559877fac.39.1724838791525; 
 Wed, 28 Aug 2024 02:53:11 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:11 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 07/17] bsd-user: Add RISC-V signal trampoline setup function
Date: Wed, 28 Aug 2024 19:52:33 +1000
Message-Id: <20240828095243.90491-8-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=itachis6234@gmail.com; helo=mail-oa1-x36.google.com
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

Implemented the 'setup_sigtramp' function for setting up the signal
trampoline code in the RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_sigtramp.h | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h

diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
new file mode 100644
index 0000000000..fce673e65a
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sigtramp.h
@@ -0,0 +1,42 @@
+/*
+ * RISC-V sigcode
+ *
+ * Copyright (c) 2019 Mark Corbin
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_SIGTRAMP_H
+#define TARGET_ARCH_SIGTRAMP_H
+
+/* Compare with sigcode() in riscv/riscv/locore.S */
+static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
+        unsigned sys_sigreturn)
+{
+    int i;
+    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
+
+    static const uint32_t sigtramp_code[] = {
+    /* 1 */ const_le32(0x00010513),                         /* mv a0, sp */
+    /* 2 */ const_le32(0x00050513 + (sigf_uc << 20)),       /* addi a0, a0, sigf_uc */
+    /* 3 */ const_le32(0x00000293 + (sys_sigreturn << 20)), /* li t0, sys_sigreturn */
+    /* 4 */ const_le32(0x00000073),                         /* ecall */
+    /* 5 */ const_le32(0x00000293 + (sys_exit << 20)),      /* li t0, sys_exit */
+    /* 6 */ const_le32(0x00000073),                         /* ecall */
+    /* 7 */ const_le32(0xFF1FF06F)                          /* b -16 */
+    };
+    
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.34.1


