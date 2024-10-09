Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC344CF042B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCM-0004Cm-Pv; Tue, 08 Oct 2024 20:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCK-0004Ay-QH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCI-0002dy-Oj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b86298710so53278845ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432297; x=1729037097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9DVukvxY0Nz2lbOkkF1UGxIJ0HiyrlwFe+DiEN47Z4=;
 b=HlZTf1MwHzSnBNjJ8f++lS5BBrVXyYw6+YKEWJSbB3YURcVLpjWueYhAT3Ihz0g2a4
 w7zJ48GaD1b4akJhQlWwayw+D134lR2t1OFEn3tnNslKh3hWFyA/UuVAVpzTTNMOUY/s
 NXt9HXr9GQc8jQ4wDfTfVx3Ns+71wVMcjN2GeE2deYLWNzxrgZlsegAdBpeNJ5+BKPEH
 GkXJHHxyqWi8XuBknoaJZDHKtGNoOAWNIkzrF5xMzmzALeVJB90Q5VHuBgD7xq9GcbTF
 PJ0us3nr0kyCdAM6AznB+D9oC7yHqRGS5V1y9iDRuksCJ/jNTdgjFAH8AluxFhrh1FKB
 KLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432297; x=1729037097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O9DVukvxY0Nz2lbOkkF1UGxIJ0HiyrlwFe+DiEN47Z4=;
 b=HMnEni/f1Dbg7s6BtEkCqM3LE+UIQXZKzDzi3sSM4X8T8lr/MWg4rqRBF/RYWAG4os
 0+y8FWEZs+XhkLu8l/T/U3Ek5R58grLNxomPtW3e99/Sf+p0YqJWftOXlugpzYMo4E9E
 w9bdWoEgThSlQW0rWTphhKJBg0ikMUKMvIcf0wGNmxNpTuMjTlEOFt+OgJjIFHglgbep
 sH1fh7dyMf7yae22JgKo3MsPjfgwN99PwMYF1BXFdwrzkcFUfgOO+4Prkzvywuq0KRCs
 GwN5yICHpSHItuLCMKocWSYtNfjkCgl+vQvIEnpgXr5OS8Osr4EWJ0fIlj+taIUMA8C9
 aTOg==
X-Gm-Message-State: AOJu0YwzK9ni7pZqQWvpxpXK8Lf7nqevQWNOsDcRdU3UFMhkjenlYIiO
 CCNnpHqzzHG5Ss/rxYhBQTUH/ZeoojFPrPHrA2vDYsgWGNRs6z4SzVWb9RSpS0WNiXWd+4AihSY
 W
X-Google-Smtp-Source: AGHT+IELfN0bakgT3mk/GTecwW46dkwTT2ygCiT/BAX/1818Ov/crY2+v9Y6lIuiJxQlQfEPFhy1uA==
X-Received: by 2002:a17:902:c40b:b0:20b:bf17:e497 with SMTP id
 d9443c01a7336-20c63780107mr10371935ad.46.1728432297083; 
 Tue, 08 Oct 2024 17:04:57 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:04:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/20] include/exec/memop: Move get_alignment_bits from
 tcg.h
Date: Tue,  8 Oct 2024 17:04:35 -0700
Message-ID: <20241009000453.315652-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This function is specific to MemOp, not TCG in general.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 23 +++++++++++++++++++++++
 include/tcg/tcg.h    | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f881fe7af4..97720a8ee7 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -170,4 +170,27 @@ static inline bool memop_big_endian(MemOp op)
     return (op & MO_BSWAP) == MO_BE;
 }
 
+/**
+ * get_alignment_bits
+ * @memop: MemOp value
+ *
+ * Extract the alignment size from the memop.
+ */
+static inline unsigned get_alignment_bits(MemOp memop)
+{
+    unsigned a = memop & MO_AMASK;
+
+    if (a == MO_UNALN) {
+        /* No alignment required.  */
+        a = 0;
+    } else if (a == MO_ALIGN) {
+        /* A natural alignment requirement.  */
+        a = memop & MO_SIZE;
+    } else {
+        /* A specific alignment requirement.  */
+        a = a >> MO_ASHIFT;
+    }
+    return a;
+}
+
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..824fb3560d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -281,29 +281,6 @@ static inline int tcg_type_size(TCGType t)
     return 4 << i;
 }
 
-/**
- * get_alignment_bits
- * @memop: MemOp value
- *
- * Extract the alignment size from the memop.
- */
-static inline unsigned get_alignment_bits(MemOp memop)
-{
-    unsigned a = memop & MO_AMASK;
-
-    if (a == MO_UNALN) {
-        /* No alignment required.  */
-        a = 0;
-    } else if (a == MO_ALIGN) {
-        /* A natural alignment requirement.  */
-        a = memop & MO_SIZE;
-    } else {
-        /* A specific alignment requirement.  */
-        a = a >> MO_ASHIFT;
-    }
-    return a;
-}
-
 typedef tcg_target_ulong TCGArg;
 
 /* Define type and accessor macros for TCG variables.
-- 
2.43.0


