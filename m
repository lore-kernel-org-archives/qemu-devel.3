Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB173CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pg-0007Bk-Dx; Sun, 13 Oct 2024 18:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pX-00079u-AO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:52 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pU-0000v6-Rg
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:50 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so1117338a91.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857567; x=1729462367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6LoCevcYPwKGPsieGU+G82S8Cv4YZiZPQ3U7O/YR2o=;
 b=TJDEQQDgYv6ZUfEW9vKlPf9Oa4h55QPu1NcZP/GuQBD9CaXVhrAxOa45F5zNJD2ISZ
 9TsVCXEdD5Q7BNQVhPDkZfO4VQ4l2Usv1vycjZu4+44p7+XKCxodQeT7D9DiItZ0/3oT
 53kI9o89KeB9DUnn6/JJMOgjJwtXSFPFTX+ZFmwqyDY7fLY9cznJPrw3+gYD1nmWrWxf
 bZ6Wf2QO2ZS51LvkDJ0bEEQ2TSIRW+5FGn6hzT/9Xp8uxVqsoQ3Tnz52jEkENWGMgKbD
 JU7X1cGDTR6CBJg9IEyl6QQP8+hu0Y91J87aeK6+DScvcRETsK7uuxN86N1/yPgl1qUQ
 uGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857567; x=1729462367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6LoCevcYPwKGPsieGU+G82S8Cv4YZiZPQ3U7O/YR2o=;
 b=xHd0ze6OGZRPngftxGG5Kxb1vJkh0zQL8aDekEteTKxMR1Je+4K1U0i2xEEg4wale1
 cB7E98uDLV+gXhXpFAMGNd9csHIkz88XO6jh2dnLJroatqVoy888HE2L8I2YBsKngSSA
 SXpR4Fj7PZ8Ncr1i5s4bXUVj1isxX/pkkkgIAwb347vtacOwz7Qt597a+dAN8bMfb6Ng
 /vgy3cfZy9qDkpEgu3HIOSGfQZymvmBLP7iIsfsim/Iwh+kWkQSofmCPGd7A3AWoPqrM
 9cu7dSJqPDZeGOoW7qEBco45RMfMYaW2Dez1O9M+2MKH8NGMGPdXs7RZZRKrFgqSLAxa
 bpwg==
X-Gm-Message-State: AOJu0YzGYoRZNluRxK64s9iwgZqyJe3sgKY51HPQaB1ON8bZz5Wk4+W/
 OyqqlKdmRsj68GqIwRjCD0mTYQ4b3EfR+cCcsNVRuhw1L+s+tpMbZaSY6JsOetzetLfllLTuRiJ
 F
X-Google-Smtp-Source: AGHT+IFRwXQjbMEs2HpQZp3lgM9RpJ2g3mcFpaWb3rwdL4JCq9PacQviB8p0BKzR7ue2qZK+Ecrz5A==
X-Received: by 2002:a17:90a:bd8d:b0:2e2:ebab:792d with SMTP id
 98e67ed59e1d1-2e31538f0dbmr7407496a91.41.1728857567462; 
 Sun, 13 Oct 2024 15:12:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/27] include/exec/memop: Introduce memop_atomicity_bits
Date: Sun, 13 Oct 2024 15:12:19 -0700
Message-ID: <20241013221235.1585193-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Split out of mmu_lookup.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index a975fe5f89..35cda1e2b0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1767,20 +1767,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
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


