Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E8CC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuR-0003WR-7t; Tue, 21 May 2024 23:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuP-0003VY-5s
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:57 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuK-0004C7-3t
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f44b390d5fso907460b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349490; x=1716954290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbgTPq0sjha5eVItxW9gUyB/eZqIzKak4Z6cwH63+pw=;
 b=Y9cx/qhNCxcJ2OdrsX//4YNIxBHMI5fRX33AfuezSFSSSvrfeji2va/b2/3xEQG+P3
 Z9cBy09jcP0Wn3lk/eiuscNPZNHqt4pIBhVMn+Sg3KIykL9zVEFEyqKZnjkr3omVlUY7
 IZnkb6DYMuM276Yl61bq6xyNiHe0FGhYVw/MrYU66g8BYuIQXXl7sXpa7pDIzSLkg33M
 /4OBTJbJ+8QDq4qh6RLrxTk/1dL0EZP02anwl4TiQk6/k2+XTWEATlVkD/w/i5a03P64
 ikK+65Hj9bViMC2qQKeunhbrKrSK2HZPxcwOAPC7fr0CO7CmA8UmrcdcVAQgps75rLLm
 DDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349490; x=1716954290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbgTPq0sjha5eVItxW9gUyB/eZqIzKak4Z6cwH63+pw=;
 b=nx3UKWEX4TmKdmYjZ3TnPT9pRz5gLeQZUlVK0Tfj/vaK9b3IDMW7i4KqlXwKW61MBl
 j6PWEdwsXmNlFMwVWHo68XOsBTMe75VDVY4330JBfn/hMir/MRb+3tLREM3Wmhr6V1wB
 SQATnVrkwyMmLyAhg3Eh66CiUj/9zyEMntb3cWamM2QUk4i05LBYf9zct46r5X8R9Hs8
 AT16JDmCcMnL8jtZ1xr7vwj2fu7MdSYAWZj5NhDzVB+YCfR66+MMqinlKPZwC+tcb3Aw
 eCcAx9lXM3BY0WV3qHJmEJOvXFZKTy4kXlx9VZ0SH1jW4+mA6M07nYp3WIvHR95zDYAh
 ofOw==
X-Gm-Message-State: AOJu0YzCT/169ICu6qc4GRxQYdw2MTBrybtlJ1CnGILXK7MuMXTL2wGm
 ePZr8rqXxEwxhzjRbTRlC2RBzN+UyjyUzcUB5K5pHIwle+oAKhdN0QCKtlz9mpjMzETgi3ab5fa
 l
X-Google-Smtp-Source: AGHT+IF095tKl2Bo4pekHlqRU4F7h3KkkLI7DsjCB8447MzlaniHp1jWTlXZqz+R9kcjfEPfk7FH0A==
X-Received: by 2002:a05:6a00:2396:b0:6ec:fa34:34b6 with SMTP id
 d2e1a72fcca58-6f6d6054bf1mr817025b3a.13.1716349490112; 
 Tue, 21 May 2024 20:44:50 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 7/8] sparc64: Add a few logical insns
Date: Tue, 21 May 2024 20:44:41 -0700
Message-Id: <20240522034442.140293-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Just a token to verify the script is working.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 sparc64.risu | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 sparc64.risu

diff --git a/sparc64.risu b/sparc64.risu
new file mode 100644
index 0000000..b45ea86
--- /dev/null
+++ b/sparc64.risu
@@ -0,0 +1,30 @@
+###############################################################################
+# Copyright (c) 2024 Linaro Limited
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+###############################################################################
+
+# Input file for risugen defining Sparc64 instructions
+.mode sparc64
+
+ADD_r           SPARC 10 rd:5 0 cc:1 ci:1 000 rs1:5 0 00000000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+ADD_i           SPARC 10 rd:5 0 cc:1 ci:1 000 rs1:5 1 imm:13 \
+    !constraints { reg_ok($rd) && reg_ok($rs1); }
+
+AND_r           SPARC 10 rd:5 0 cc:1 0001 rs1:5 0 00000000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+AND_i           SPARC 10 rd:5 0 cc:1 0001 rs1:5 1 imm:13 \
+    !constraints { reg_ok($rd) && reg_ok($rs1); }
+
+OR_r           SPARC 10 rd:5 0 cc:1 0010 rs1:5 0 00000000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+OR_i           SPARC 10 rd:5 0 cc:1 0010 rs1:5 1 imm:13 \
+    !constraints { reg_ok($rd) && reg_ok($rs1); }
+
+XOR_r           SPARC 10 rd:5 0 cc:1 0011 rs1:5 0 00000000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+XOR_i           SPARC 10 rd:5 0 cc:1 0011 rs1:5 1 imm:13 \
+    !constraints { reg_ok($rd) && reg_ok($rs1); }
-- 
2.34.1


