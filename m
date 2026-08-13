Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE13C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuJea-0000dY-Mq; Wed, 12 Aug 2026 20:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeY-0000cR-89
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:38 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeV-000400-C4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:37 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so244853a91.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786582234; x=1787187034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SCXkWU/s60xpywRTk/5Sry/P+FxBjxNAN7j/OIwaN8c=;
 b=AXOJ7ClcUMZqXyjx3RXkCCiZ/ahh+5ZgU/rhzNvwatpAIWWUL/e84UwJ1UnDqWNxGo
 OLBaiAOTVu79W7rZT1OjHpcspTL7w1AZGbb1XsdZWD0iz/UfOsycb2TzjATlc87IvKFk
 eJjmaeRknnKsf02Jayz0FDvuznsePnCpDQHHQugtb+OqKo4ojufVk/OPAbNhuO25iHYx
 +q3P8uYn0aMLs5Vw0B7lz7cmBSp/LFILdlTFtmqyodxWcp1L7bMSn4IaQ9tBhzGI8wwl
 JnokVUue8OSNUs66CHPaiDvEvIk/W0iyPGrZY6D+De2a4HQiIfuCpmhvKMcc4sNPPJfW
 ynqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786582234; x=1787187034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SCXkWU/s60xpywRTk/5Sry/P+FxBjxNAN7j/OIwaN8c=;
 b=JokuT0zPaTYC8jOsV9Mrr3P2IxAHHBpwRtsLg821BIy6EEc4d0cdhDfp1rmFNGLOrK
 OKDJUE+v2GGe98Iziv17wExlrO8pYC8EZjQk58UfKPXu2Ch7jY2I5X5JHCTG3xX2iBDz
 ZXYjsVdGXOHxnw+XcgoqIAn/L9euGGtIwqSadru0mECbFLyzV2AaKDsGp3OCoxGXUZnk
 cEjg3YQhTuZL0e7jtGnn7rvNaUCvmRn6OcCJwuVaAR0/1vJzN7tZGsj6hL/mzSutro9G
 XBK31aCzZ+Q3v4tEcjCmJYRrhNo8D9qzpq2wPqp+oV1aTKXUI0XqzUk0kkfAYQxZBQ0a
 1Wrw==
X-Gm-Message-State: AOJu0Ywa9oOZ14edQRclHJpYs8KhTw7QDThzObr8IYud+wzI94a68JZR
 jLF+263Z2RgnyqSFOYZeEKJTFV7ujmyC3MFmajMXwCgi8yw8hRRuu7wPiK586pig1fl2XW3rQGo
 FJSYF
X-Gm-Gg: AR+sD12t/JgXZ3RtGrlOC0pj5sg4Qee4Cl4KSkEEtssXKG/fPUyjubD5fMoKpbpq6S7
 x51k50Ly0yDsqk/62E/Qnrqox5VK/2zG3obF7A1ksf3M+jRT0FatqUkrXV4/u3iQKaJeNAH8zPs
 6+XfZnXsiRQ7LZXyZq/ptRwUG/KOQVhIIYkpQdyTp3b5Sbpn6wtfMuZcXzH35u2dQk0yprcWmT3
 EwpAxqHlZqpGFaply0GLzuOoXGmxBJ5PofF1j/13Eby7KkwEgkW8tzzfBZ2nQgdkWRsiUB8jL+T
 Z4aNDxsS96Tp72Qp17JyAz8kCVleOEUmRmRXR2hP+75rCY/Jmgw4U8cpCj94PzEyILIWTvHqyUK
 guBlfK4rAlUUDAKh3Lz8xtOUl+GGWlHDUoNjkeF2FPAOF1jUYzzfmuBVhmdA5w0XQDV4Y1JMjS8
 GgKIRWHN6sGe0hQ4pYuUG/22dNfhxYeM/HspN7iGME3TJLdmI+/2lY0cjTtwTIDJjxxg5PBVFDY
 kXY1JOy5eaGdf8VzjZN8p1i7pi/YTk=
X-Received: by 2002:a17:90b:2750:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-3931e25efacmr2574172a91.11.1786582233621; 
 Wed, 12 Aug 2026 17:50:33 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931ca612e7sm1259918a91.0.2026.08.12.17.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 17:50:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Subject: [PATCH v2 1/3] tcg: Return success from tcg_region_alloc__locked
Date: Wed, 12 Aug 2026 17:50:29 -0700
Message-ID: <20260813005031.518387-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813005031.518387-1-richard.henderson@linaro.org>
References: <20260813005031.518387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Invert the sense of the boolean result from 'error' to 'success'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 5d4be1453b..2161d961d9 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -360,11 +360,11 @@ static void tcg_region_assign(TCGContext *s, size_t curr_region)
 static bool tcg_region_alloc__locked(TCGContext *s)
 {
     if (region.current == region.n) {
-        return true;
+        return false;
     }
     tcg_region_assign(s, region.current);
     region.current++;
-    return false;
+    return true;
 }
 
 /*
@@ -373,17 +373,17 @@ static bool tcg_region_alloc__locked(TCGContext *s)
  */
 bool tcg_region_alloc(TCGContext *s)
 {
-    bool err;
+    bool ok;
     /* read the region size now; alloc__locked will overwrite it on success */
     size_t size_full = s->code_gen_buffer_size;
 
     qemu_mutex_lock(&region.lock);
-    err = tcg_region_alloc__locked(s);
-    if (!err) {
+    ok = tcg_region_alloc__locked(s);
+    if (ok) {
         region.agg_size_full += size_full - TCG_HIGHWATER;
     }
     qemu_mutex_unlock(&region.lock);
-    return err;
+    return !ok;
 }
 
 /*
@@ -392,8 +392,8 @@ bool tcg_region_alloc(TCGContext *s)
  */
 static void tcg_region_initial_alloc__locked(TCGContext *s)
 {
-    bool err = tcg_region_alloc__locked(s);
-    g_assert(!err);
+    bool ok = tcg_region_alloc__locked(s);
+    g_assert(ok);
 }
 
 void tcg_region_initial_alloc(TCGContext *s)
-- 
2.43.0


