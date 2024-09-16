Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC69C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE1n-0000hA-4U; Mon, 16 Sep 2024 11:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1W-0008Gw-I3; Mon, 16 Sep 2024 11:52:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1U-0000Wj-L0; Mon, 16 Sep 2024 11:52:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2053616fa36so55437505ad.0; 
 Mon, 16 Sep 2024 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501937; x=1727106737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=DRdcJhw7RaFlYI7hygQRin4no+ltcalPWZwPoA0sWOwdCBr7dM9xE1JEl0lMG0l50P
 SPKc3DoDMgPG3v9TMhlit8rJ9cwwag8sDH6qyHKvtYsn/iZtw2ZIIj+6KbJ0cj8LBMhN
 bDKUz0qV8W4PMed1V4ceIbsl8v1y7q4LPKvSOG1cFJJ9nZwW3LrEhTl7+CI5LRIejZrV
 lmwqGRihMVPnrPbpqy7yRCkthgmIitSpbYOkiJY70RRMVAEe9UX2KcE+FXSX0oFt/XwE
 ZJn3JquKHn3dXXaPta/8nV87USTDLOT9Nq3uL/KEfCi621KlLs2PZlPOSrlAEygxnvGl
 ASOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501937; x=1727106737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjm2NL6Wgqty15f3ap7G8BavBfHkA8e5dbFy1QdhwG4=;
 b=k/u5S6+rfrwiMJlPO6wimujtE0Qoczs6C2/Zp3SoOFq/JuPOXkTkmeDw2JA5M/k1VC
 LgVASbwq8Gvd75isKK1Cc8RdPj1cr5LIfQSkLs8oA2oEYpAjx57sGKVDf8p7H1QpsGyj
 8JtxvqHpn0R6OTxYhFFXZvCXRY3JMjoxCURPZSTR1c+ApOP/tp+jCX27Mq/0Vi0MV+el
 p263J492BNVkfyiu5YRw62sVL+hxxcblwoa5Xk5+bfIWQWMx8OIztoaih5CIBm3mCI0y
 GO56FhymVEugpL3muzbg7GY/A9Qj2qposQC/6y9JYTDgtucbjHx3QgKeaRSzv7lT6NYg
 C/XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiFgP4TdejlWbBHWXXuwTMyRzAsA0xFuWTwIbombK0KQ3G2BABWpLWnBnaxTofVF3UzEWosztJYHPH@nongnu.org
X-Gm-Message-State: AOJu0YxKv3YTERPGUnGpVnMntumbHa1nquVLCoCm4t2q9QFCg1mGkJx3
 fuVarZZNn8XZWkZbmTTg+5G3wX/uzsx6UHBBKStUtZNEZMxEJ4WYSA6IGPBw
X-Google-Smtp-Source: AGHT+IHvp6xWy5Uj8koC3hOZr5IcF3pdbi7HmnxV4rlFL/mIqQiq3pzEa1wJCUp5LrklBR/rsn3UIg==
X-Received: by 2002:a17:903:2452:b0:207:5d33:a1b8 with SMTP id
 d9443c01a7336-2076e3eab23mr226920575ad.38.1726501937573; 
 Mon, 16 Sep 2024 08:52:17 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:52:17 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 12/17] bsd-user: Add generic RISC-V64 target definitions
Date: Tue, 17 Sep 2024 01:51:14 +1000
Message-Id: <20240916155119.14610-13-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x629.google.com
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


