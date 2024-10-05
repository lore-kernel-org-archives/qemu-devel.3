Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95660CFB42D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2Z-0006Ib-Ek; Sat, 05 Oct 2024 16:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2Y-0006HZ-1V
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2W-0001j2-HI
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20bcae5e482so28618625ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158766; x=1728763566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMIQXnxelIQ86qxYbOA8sg/WFq9fqYpMUetqZ1DDKfA=;
 b=PGghxLTt2ynfVDocQ4D+KSHzuhMQ0qVlz0psDELCA8gLqiC+FCLCUzlLQu44sPtQht
 ytLS/5S4bu3wlr3cF093Kjh7LiNYP8dgjzPtsu9JkNVvi7Im+DhRZkEhitGusUMqSQIR
 AkRprgZaiHHZXLcrs4Bq7UYp2Uev7H0n1LRQh9XUmiKj5+2cWKDZy1+S5bonyzXyN6Jg
 /blAXFcVcE48xmUmXCJorOooh+pYnscnAeTPwgy2v8PHsQP4hrEQ4eYTvLPWIDS2vnQH
 +W1aTMlxxxrI2ITsS2KQNAN9sTbQIc9dA5RPE82DPagKoDe4LrQJyYsrMQZrUWDd1+YR
 JpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158766; x=1728763566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rMIQXnxelIQ86qxYbOA8sg/WFq9fqYpMUetqZ1DDKfA=;
 b=waRF1jZs+A8u53rMlMiYVGze4Bm7zGIhLRgkV3ekI1O7/xdeydwxl97OB54bq081Kx
 ou3EjSjqmmvM6xXjwgxSJM4VaDfJmV98rgeBgWcNs9bxye2avb9dUaClTWlpokBo02h9
 W0IZIhNQexVsj2TwbI2jF24hYQ1HIQgc796vfPVpi6iGKkzd0Rhq8PYEGE1kyWLailGj
 ciTfDY6VKLBHAiCoidAG5817NsxTLVPj6rP5VxlLRQX5t1rBxUxZqYSGazhd3QDvUDx8
 ToPwY9CIieJYatO+rM5vjJY0T4i12pA/L7tIkPHQwpoUdavFZTMIu/rLvFQSDvwzv6NZ
 lEGw==
X-Gm-Message-State: AOJu0YxO9f80Ko+k5F+1aLYfPdk4kk3rKAJvnVFUDhKF7bxA5TPkjXRr
 GMdCeKTi5kP4DCbsNfga4nI6PRr3t6lC8MDCZ0xDeSc+rm9zuGgpXkBm/xHVOqrbHi8601WpneK
 U
X-Google-Smtp-Source: AGHT+IHH1UPbilIVxeQbQP7YVJkO3rAkayOpruqAQpJ8VTJH0ulhL8QO7zYfsZKakqfCs3+vPIEAIw==
X-Received: by 2002:a17:902:f545:b0:20b:a576:1896 with SMTP id
 d9443c01a7336-20bff190668mr89400615ad.43.1728158766201; 
 Sat, 05 Oct 2024 13:06:06 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 05/21] include/exec/memop: Introduce memop_atomicity_bits
Date: Sat,  5 Oct 2024 13:05:44 -0700
Message-ID: <20241005200600.493604-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005200600.493604-1-richard.henderson@linaro.org>
References: <20241005200600.493604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Split out of mmu_lookup.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 24 ++++++++++++++++++++++++
 accel/tcg/cputlb.c   | 16 ++--------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f53bf618c6..b699bf7688 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -193,4 +193,28 @@ static inline unsigned memop_alignment_bits(MemOp memop)
     return a;
 }
 
+/*
+ * memop_atomicity_bits:
+ * @memop: MemOp value
+ *
+ * Extract the atomicity size from the memop.
+ */
+static inline unsigned memop_atomicity_bits(MemOp memop)
+{
+    unsigned size = memop & MO_SIZE;
+
+    switch (memop & MO_ATOM_MASK) {
+    case MO_ATOM_NONE:
+        size = MO_8;
+        break;
+    case MO_ATOM_IFALIGN_PAIR:
+    case MO_ATOM_WITHIN16_PAIR:
+        size = size ? size - 1 : 0;
+        break;
+    default:
+        break;
+    }
+    return size;
+}
+
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b5bff220a3..f5fca5a118 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1751,20 +1751,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * Device memory type require alignment.
      */
     if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-        MemOp size = l->memop & MO_SIZE;
-
-        switch (l->memop & MO_ATOM_MASK) {
-        case MO_ATOM_NONE:
-            size = MO_8;
-            break;
-        case MO_ATOM_IFALIGN_PAIR:
-        case MO_ATOM_WITHIN16_PAIR:
-            size = size ? size - 1 : 0;
-            break;
-        default:
-            break;
-        }
-        if (addr & ((1 << size) - 1)) {
+        a_bits = memop_atomicity_bits(l->memop);
+        if (addr & ((1 << a_bits) - 1)) {
             cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
         }
     }
-- 
2.43.0


