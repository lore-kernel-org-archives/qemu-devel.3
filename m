Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2313C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfv-00082P-8M; Sun, 26 May 2024 15:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfq-0007zh-OR
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:54 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006UW-V7
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:54 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2be94c9e230so2227044a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752206; x=1717357006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbgTPq0sjha5eVItxW9gUyB/eZqIzKak4Z6cwH63+pw=;
 b=CDmNd3eLHa2+TijA4EEfQmAojIK0GbRvfSGUiOkHCnS8ex/DG16/SYYmGaC/W3Xhah
 VHLlKTnRsR4Pkx6UhTMesHmKgAernjO/i/yDPa0awrRmZIg1+VPtXaGXOS5keedtYEAO
 EKa1flcfUb4jS4l2X8ZRbKsm0yB0mrxM6WFar/Vfe/ZX03cN9dweLciKAzsyXgVot9yy
 QFRofslbrn4uf0eQvyI6pgOhMm1HH+10+7y8N4OKOc6ZjaLZTRTKfULiUq5XK+6MBa5T
 ZAHBCQcp8+MqRJ0v72Vo2h+jw6sDUKdC1hzXenP4YHB9Ljom2h2NjOXloObLOO1wzyko
 g1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752206; x=1717357006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbgTPq0sjha5eVItxW9gUyB/eZqIzKak4Z6cwH63+pw=;
 b=G6OJfZTZRtTct5ix0dWjkfee722iAqUOzZu9ZIwJ/C3x1ci/LwICug1GEKepBNjRt9
 4qHVWBYP+DIDivKo60U6hwPk4R1UR1fUz/HX6TpanwBAKOyB0qodMmP92YGng7Fmnlio
 JpZhYXNXNj6hkkfHZzm21hKrtLeLJrQZeuJnhuXKF1mOXtm39CvCATBDJ/AVtdFojYJa
 qy+NvmKqyDB3fqBz25R9wgLv5n+B8EmYBj8wg1XIZESTotna+Aa5OIOWn6h+jY9eVh/w
 pdkYqoq2drf4frDAHWKIcwDHGHyvASffsD3ZsHoqYfX5GLiclNPWz2w2aIG94N4CfOPH
 H8+g==
X-Gm-Message-State: AOJu0YyRTj1lZ2bxTvwydkT4lV2FGRCK5yb3KvbE7kJfT51CkN6N0JjZ
 S2zb0O0ZQgNaxtAVpuCOAYNY3BILfGhFvOovdsC4tlPN7sCtq5nb80vFPm1I5jMf6iqXr/RLnu+
 j
X-Google-Smtp-Source: AGHT+IGFbSR4lgoyvmp0/4lT8k2ki5I5szZBW/TeD58iHFhg5RGAsgOveQw8GPNTVUguqAcLu2J/kQ==
X-Received: by 2002:a17:90b:30c1:b0:2bd:d2f9:e71a with SMTP id
 98e67ed59e1d1-2bf5e169ea5mr6952392a91.29.1716752205644; 
 Sun, 26 May 2024 12:36:45 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 08/13] sparc64: Add a few logical insns
Date: Sun, 26 May 2024 12:36:32 -0700
Message-Id: <20240526193637.459064-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


