Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F52C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE1E-0007ki-65; Mon, 16 Sep 2024 11:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1C-0007ie-7z; Mon, 16 Sep 2024 11:52:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1A-0000VY-98; Mon, 16 Sep 2024 11:52:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fee6435a34so39969605ad.0; 
 Mon, 16 Sep 2024 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501918; x=1727106718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eptwr1B6TaRaZQ7aEdRCfkv5ZrQAsR2zaI7/YwKtIOQ=;
 b=ItV7tQpZWSE6upn7bgVz/LT4cu8yvNOJmWB4P5VcBoJ6moVLrO1qAP7Gy7WN9fPEvS
 Wi9gNI7BHNFmJY0xDj+BNvnmRW21zc9lSpfIvEvCzmcRU/vyT2lhr89xN20flnXAQcak
 iDyezBMXij4lH/BkIqY58VCgJ3vfvJinpQ1S3CkEXjQ2bhdNFWvuHieOfZRcqP9N0xsf
 uApy+kywus9zN67XqGomFMNG2wu7x2YI0uIAq6VRms3QZYAX4dZVyQE1Rtd2hMgn3YMp
 EaAXV1893OYJUjplgkOMQ0kpVv6Few/Z83lMxB9m5CDRbq/kQ2fnqPLFJ1vr2IJGStzf
 wUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501918; x=1727106718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eptwr1B6TaRaZQ7aEdRCfkv5ZrQAsR2zaI7/YwKtIOQ=;
 b=A4gGa/aecOLhHi7Oa4ICZm51kPtCesj/kltnSHVnPECt6zsag80DaOrbpRW+pyVMr/
 a0YQBFmMnmVnBNNZdO5/FHfelX4zjkFqZap3jsUYYnxoCK6WwHuEAhgFogYNYa3vUteH
 LCSi+R8NU+gdZFRC5Q5u3rj6ETjge9nShE0qY0nIG+vLeCIt0SPx4GqMQkXiNRL4ycGd
 tAhjy3hcS9yBVz6+JsO28luai/12PgVOdNUqyKMDzQu8cqibS34lT6jnQdH3hoaHfMec
 IaPTdHF7ZvMOdTmDB4JcLcM0K/22EejBoBRI5Jg3sXccwNWvUrXfZrsNPugRL2dFo68v
 cpJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRtYzMvq8L4mVMI/4UjFZsxco6UoZ5Gjb1FIeWyYq55vw2wKObYApalgySUeRObud+0L7pdc8FHU9K@nongnu.org
X-Gm-Message-State: AOJu0Yy6EA7g2SSJ8kJoCi6eUYcknw65jXr7ULwAwExtb4N4i80B811P
 LrpszWhrb1r200bZrlpXaArDWynwa1UdsU8xxs90+G9onmIH+vPlouRdD0pY
X-Google-Smtp-Source: AGHT+IHM2bnnYQCF1nvsBijdOog5wWRv0VGbUVTOu9qowXHr8vp50ttw4J5IBeIdHIK5mLDZYypyww==
X-Received: by 2002:a17:902:f684:b0:207:1828:82fd with SMTP id
 d9443c01a7336-2076e37abf5mr219771225ad.28.1726501917792; 
 Mon, 16 Sep 2024 08:51:57 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:51:57 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 07/17] bsd-user: Add RISC-V signal trampoline setup function
Date: Tue, 17 Sep 2024 01:51:09 +1000
Message-Id: <20240916155119.14610-8-itachis@FreeBSD.org>
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

Implemented the 'setup_sigtramp' function for setting up the signal
trampoline code in the RISC-V architecture.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_arch_sigtramp.h | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h

diff --git a/bsd-user/riscv/target_arch_sigtramp.h b/bsd-user/riscv/target_arch_sigtramp.h
new file mode 100644
index 0000000000..dfe5076739
--- /dev/null
+++ b/bsd-user/riscv/target_arch_sigtramp.h
@@ -0,0 +1,41 @@
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
+    uint32_t sys_exit = TARGET_FREEBSD_NR_exit;
+
+    uint32_t sigtramp_code[] = {
+    /*1*/ const_le32(0x00010513),                        /*mv a0, sp*/
+    /*2*/ const_le32(0x00050513 + (sigf_uc << 20)),      /*addi a0,a0,sigf_uc*/
+    /*3*/ const_le32(0x00000293 + (sys_sigreturn << 20)),/*li t0,sys_sigreturn*/
+    /*4*/ const_le32(0x00000073),                        /*ecall*/
+    /*5*/ const_le32(0x00000293 + (sys_exit << 20)),     /*li t0,sys_exit*/
+    /*6*/ const_le32(0x00000073),                        /*ecall*/
+    /*7*/ const_le32(0xFF1FF06F)                         /*b -16*/
+    };
+
+    return memcpy_to_target(offset, sigtramp_code, TARGET_SZSIGCODE);
+}
+#endif /* TARGET_ARCH_SIGTRAMP_H */
-- 
2.34.1


