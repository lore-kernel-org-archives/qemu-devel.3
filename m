Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F03C369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPa-0006fs-DD; Tue, 22 Apr 2025 15:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLm-0000px-37
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLh-0006eb-9l
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:09 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-225477548e1so56981595ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350324; x=1745955124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qcu//0jyv2Qr1qgAsqv3VCUMABiA/lbrLzTg9MZVJM8=;
 b=J9jIEFZLGUE05wOPugN/O+RcLybABgTewAFHojtpbze+lBOaGBcAni7jGV/Im5Q9Ea
 0f68hPyOm+Bfy4rFL2ljUgG6mfjMAtoJJuvrmx/1jqBB+ms2faWZ5sTFb+MYW/piPw/a
 6TNcj5jfltU0kQvF/AUM95Dll4VHaw7e4MyyQK9X33ctB2PXF27gV5ty5Idrq2yjTF5q
 uXUhtnW/k0PGJ2kras8R1QqDAWwrvqIqJ/cAK9M/KPCdxta7KVbQuPcAd2TDhWJYlL2h
 nJdYgrLZSVJl7saWjZ42sXZdlC0S5esVzB3Zp5xcesIQk7o7yawAdGYtirMGBUBR4q8r
 1wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350324; x=1745955124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qcu//0jyv2Qr1qgAsqv3VCUMABiA/lbrLzTg9MZVJM8=;
 b=XEPtux623av8x5V32N0DeXfX8X0yrefoxrgQUy86Q7zfkmJyIMN5Dk6loUk+NUOa+O
 /ZunV8hfA1Pn41uKJ7mdFDLdlq12CFkPbaQJG775a2IB8Dn3yjB+NjwUzD9BFNuQ9zje
 JyHqRGUHVKWJS8zCbz2WGX8WVI/AbCPEPOtTIbTx+1atmO4XHYiDu1ZcmEIroUCXnOFm
 ZGPEsB37dvVhApD9iejPPZ31ci17eeHxZG/6q1SKwhitzmHN9DK0mkCz+dNfdJnNI4sk
 hK7mFHhCueBOUfGpLNMF+1Ekkd8zZOughqrjeMInn33WYWCiKd+MtEiLe/IXDZKOr4tT
 27BQ==
X-Gm-Message-State: AOJu0Yw4VTh7EVj1nwf8E0aFc5nXHD82oMNNSek5aOxteutQEHT0MhdA
 hQzvHpfqf0cz0wWfTZDDFq7tusAGtkw5dX4O8WANS/cF7+k6ixlWuWqahaHkCLVv5Gv0dgQBqt7
 z
X-Gm-Gg: ASbGncuj6l9oVdpIthwR5yvVsNEsQt2ESqEbmh03rLr1Xgcr2BDmk401ZzUj1sonQyM
 2OWsetLBCsA4rr+uVUtbOEgSnmhigb+M1u29cdrGRJ3on0RSu0a8bOhmbTCwdX+P+vmTcJCbocN
 ZuqaNURiSLSihXGHx4yZMaaBCjWz2lXhFrCpyAgoZFmNKchp9fsGm7ypvWp9Zzs+YFT+ScULppJ
 gyGdJKeq9A4Ri+3IS9oWpl2qDVt/hVUqPbrFT7MybC2Id/dNaF9c8knDskHcvfEIQXMEgescmd8
 Ez3RR1LssRIF+iNJjJ6nbS/xYwjD7P9XgzhNN8ji6p5wzyT4x1EW0LXpKKItYT/5ljrHtIAFSyY
 =
X-Google-Smtp-Source: AGHT+IHlH0OsaiT6N+otkf5NVhKPfosNhoHWqhsvLNMUobIIfYLUrWUi7DO2HvmZ+aoNCObZI7r66Q==
X-Received: by 2002:a17:902:d58e:b0:223:2aab:462c with SMTP id
 d9443c01a7336-22c53580c26mr251616435ad.15.1745350323972; 
 Tue, 22 Apr 2025 12:32:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 066/147] include/exec: Move TLB_MMIO,
 TLB_DISCARD_WRITE to slow flags
Date: Tue, 22 Apr 2025 12:26:55 -0700
Message-ID: <20250422192819.302784-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Recover two bits from the inline flags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index a0e51a4b37..54a6bae768 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -53,20 +53,15 @@
  * contain the page physical address.
  */
 #define TLB_NOTDIRTY        (1 << (TARGET_PAGE_BITS_MIN - 2))
-/* Set if TLB entry is an IO callback.  */
-#define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
-/* Set if TLB entry writes ignored.  */
-#define TLB_DISCARD_WRITE   (1 << (TARGET_PAGE_BITS_MIN - 4))
 /* Set if the slow path must be used; more flags in CPUTLBEntryFull. */
-#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 5))
+#define TLB_FORCE_SLOW      (1 << (TARGET_PAGE_BITS_MIN - 3))
 
 /*
  * Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
 #define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO \
-    | TLB_FORCE_SLOW | TLB_DISCARD_WRITE)
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_FORCE_SLOW)
 
 /*
  * Flags stored in CPUTLBEntryFull.slow_flags[x].
@@ -78,8 +73,14 @@
 #define TLB_WATCHPOINT       (1 << 1)
 /* Set if TLB entry requires aligned accesses.  */
 #define TLB_CHECK_ALIGNED    (1 << 2)
+/* Set if TLB entry writes ignored.  */
+#define TLB_DISCARD_WRITE    (1 << 3)
+/* Set if TLB entry is an IO callback.  */
+#define TLB_MMIO             (1 << 4)
 
-#define TLB_SLOW_FLAGS_MASK  (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED)
+#define TLB_SLOW_FLAGS_MASK \
+    (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
+     TLB_DISCARD_WRITE | TLB_MMIO)
 
 /* The two sets of flags must not overlap. */
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
-- 
2.43.0


