Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0EC3ABA3
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr9G-0007KZ-Ri; Sun, 15 Sep 2024 11:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9F-0007GM-4x
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9D-0008En-Mt
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:26:48 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-205659dc63aso35935205ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726414005; x=1727018805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=Up/sHYXXN51jrnzAA2oGbk/2udMxWp/qAVuwrpFmQuKZ2PaA2aePpbAaxUS2qH8Wyh
 ZxH3P6Gyw/WBjZ7mrmcH3qnmNLB5As2CxAqLHOAwoc4GaAAzpyMz9r/cDrqLx3L1hvZg
 H+z78mpsThYZUtApiHSimz+4+FWAXzpJxe3niCJk92ryHs3xf4Rx+jHIcO3rLlMx9y73
 X50ufafE0LPHyksxIqbQEWAorRQ8/AiQC3pmA/rwGtM8q475XOlN5oG2pOeoQSBHNwWY
 xZlZ8Qi3U1IUwbtv5Ea0JTWjtmbeYAsoypDSa8eCT3hm57YrsC1prwCyQjYcD9KaRZjU
 NlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726414005; x=1727018805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=p7TBjg9OIhTyxPfk31WZo3whLBGJV25sp1ASnzulwqZGOzEDwlOpqBB2AjgS4yzZyW
 67p1PGmeOE1Xei79sDm3ZeP0/NAaoSi8npqUl0i1czHCKVxYa7w4hZZ0wndje/DDjUUm
 fkGrmCVp7hYNbMcblkSQreXNpWtfylay3FKzxn3Y21Hri48xk/UCqcIuQV9arCkvgC0c
 gQc+K7zCPIwweoGQfcH3A967aRmewOHOb5m+rHhgeM1ewHrpMbJWSjpBo6kP7FoE3aii
 Lkvuf52oNU/6bucB+yHRQGCqJTAg85/1bgA/9kRzehpVfMG9lKCZ1mVyEw5g2AJwEj4G
 77KQ==
X-Gm-Message-State: AOJu0YxseKb6SHMb0bLVMQd3J6ZCBXuwNqqQqf5uYlgE5DbnzgXZNK8t
 jI/v7zxH+WHhG65x4kWBf6GUihxgpIx0iiSOe4e1Dox1bSg03Vrg7OL5Ww==
X-Google-Smtp-Source: AGHT+IFfA4Aqhhu6ndVCU6n2DhhlEt1AmjZTB0uure7sKUPWYv3PrjXSsKbounroFMwm+RND4uWBpA==
X-Received: by 2002:a17:902:f683:b0:207:816:6b7c with SMTP id
 d9443c01a7336-2076e399437mr193556575ad.13.1726414005385; 
 Sun, 15 Sep 2024 08:26:45 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:26:44 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 12/17] bsd-user: Add generic RISC-V64 target definitions
Date: Mon, 16 Sep 2024 01:25:49 +1000
Message-Id: <20240915152554.8394-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x632.google.com
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

From: Warner Losh <imp@bsdimp.com>

Added a generic definition for RISC-V64 target-specific details.
Implemented the 'regpairs_aligned' function,which returns 'false'
to indicate that register pairs are not aligned in the RISC-V64 ABI.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 bsd-user/riscv/target.h

diff --git a/bsd-user/riscv/target.h b/bsd-user/riscv/target.h
new file mode 100644
index 0000000000..036ddd185e
--- /dev/null
+++ b/bsd-user/riscv/target.h
@@ -0,0 +1,20 @@
+/*
+ * Riscv64 general target stuff that's common to all aarch details
+ *
+ * Copyright (c) 2022 M. Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_H
+#define TARGET_H
+
+/*
+ * riscv64 ABI does not 'lump' the registers for 64-bit args.
+ */
+static inline bool regpairs_aligned(void *cpu_env)
+{
+    return false;
+}
+
+#endif /* TARGET_H */
-- 
2.34.1


