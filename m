Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523E0CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 01:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKoF2-0002tX-0U; Sun, 16 Nov 2025 20:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEa-0002VR-2R
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:49 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEY-0005xa-Ay
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:47 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ee0ce50b95so10940781cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 17:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763343645; x=1763948445; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YZPS9rJuRYJQhQMaUWtzxXr08fJQQ2IjJz7xMKY7qDM=;
 b=b8LRRln4EUZiUykSgQf7JKoUC0a60cbBfkvTbrRvQpQfgowfICEy5L4pILe5xpF1lV
 Hua4hqz3tbmPlaFJ47KIM20dEd62KVOwK93/l2HNXMJf+YzRVq/pZugF5KixzrCcnGZg
 hY+l6WiVlm6rLKSmUpz29Dg3aG2mw3XotEqp9T0ZToTEnWTvSo07BopJ0KS+BJIrj4pL
 3EW06xNP2V3zy375ZJwvL8Wr6x4GKnDU/56A3QYMEn20NIpvS3Y2HBspvR5nLJazctia
 56MfqEhwhyI02H5MTuasN6Vm+YtzInpx0y8yaG+FYE7sH/uR6kha7WfEC5ejIsdtYUrx
 if6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763343645; x=1763948445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YZPS9rJuRYJQhQMaUWtzxXr08fJQQ2IjJz7xMKY7qDM=;
 b=saqNbs80kk1okIh6356DgXYWs1w0cT5s5XWx5DEJ39kRXyqj6MINofRmwcqAZBChQD
 FAmkKAR2mzkXJj9NiMwixOpdFTDYd9q3A1slZsSxx2yseeM8SUpOzF+ZRMTV4ygkHelL
 /i3Cn+djC6YdAxNtisMynm8kQZf30onxBpdpPPIvyFc/3ID8zJWCwQRnN+meU0XjMAem
 p7OtqcDDOHyvKfEUqC4uoeCJX+4XGJCViZai7szkOTa90QuVnTslUha83LerRNas4Kk1
 daHCXYUUkmqMViV62tPbMlBz62AZ0r9FzLwy1hmzMhr0ehZWApa78fOwP2ggAhuCTNdj
 w3TQ==
X-Gm-Message-State: AOJu0YwWWrHdWhbujgOHyszjtAhrx5l9XKNbXqdbOslkLrvvc6AOYnUv
 BHxen9mCNe+nqg+tG0y9H5q6+Lr8P+7T2kXBPn9xVEuIxSn6DgMW0nGk
X-Gm-Gg: ASbGncsUY7SpBpxVSL96eiiv1nAhMzmg0vRSs+fBcm2+AqZ0kJI+SBN3HnHGX+351JB
 cFQ/C+Esfz/9+7ErngiQrS5o2OwQ9NCvi7xw4vQyXhb9cPUP79A+AOgCo3ze3/quJ+q18HXn/Mx
 rQa0+G5wbrB7d5FNBZ2EZsEWGdibvBoEwjIyzRnaZAZ6SdDNtp+2HmC40vZLE4TuYgq2xYb7MHM
 HI/eWO0Ox77f/jAAcvrfqP9YSrbD6Qpz3n73psv/KUXJH7YOUy2QgUEnCEn+bWE0C+0PdAJEE+F
 1tSAY0GtAXRBvPDFrdTfn8wrxrw4QszcwgK1rlaMbJQWBEyZ7oKbciWgnNSsuDJT+MTJmZ1VcVV
 xw2kmqQtycHuS3LE/dZ+rZRV4ZpEGuS9zKAk5XVZkLZZ3ZYSVxctpYwnhny4wH2vR7dh3t466vn
 aHUd1BQYWqGv/ABKtxhOM=
X-Google-Smtp-Source: AGHT+IHgvieHxSRUO9TsHKNvJgshRAHk/5Gv34QSSGE6MsBMKM1XUkjD3wkxJ7wnGGvD6rkSbLrljg==
X-Received: by 2002:ac8:5996:0:b0:4ed:2715:6130 with SMTP id
 d75a77b69052e-4edf216e10cmr143023481cf.36.1763343645435; 
 Sun, 16 Nov 2025 17:40:45 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm18246551cf.30.2025.11.16.17.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 17:40:44 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Sun, 16 Nov 2025 20:40:21 -0500
Subject: [PATCH RFC v2 04/10] target/arm: add FEAT_MTE_STORE_ONLY logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-feat-mte4-v2-4-9a7122b7fa76@gmail.com>
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
In-Reply-To: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763343639; l=1520;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=68ZM+10B9YHoYASDZcGdBy4XhZSBVkzEJDAZb1ZURqE=;
 b=wC980mUNguhEfrIR5Nq6/5CttN9iRGDU71qsPwjgXzgFeylMIbfREmburYaJ/twikPUTvdsb6
 ShAT0Y1fbGWCJNRkdc2aY45uYXLfHK1h5D7T3C5IycYmjf0IwtGBCQM
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This feature automatically succeeds tag checks on load instructions when
the appropriate SCTLR_TCSO register for the current exception level is
set. Find information on this feature in the "Tag Checking" section of
the ARM ARM, Memory Tagging Extension chapter.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/mte_helper.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b..f9fd6fd408 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -865,8 +865,30 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     return 0;
 }
 
+static bool mte_store_only_active(CPUARMState *env)
+{
+    int el = arm_current_el(env);
+    if (el) {
+        if (SCTLR_TCSO & env->cp15.sctlr_el[el]) {
+            return true;
+        }
+    } else {
+        if ((HCR_E2H & env->cp15.hcr_el2) &&
+            (SCTLR_TCSO0 & env->cp15.sctlr_el[2])) {
+            return true;
+        } else if (SCTLR_TCSO0 & env->cp15.sctlr_el[1]) {
+            return true;
+        }
+    }
+    return false;
+}
+
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
 {
+    if (!FIELD_EX32(desc, MTEDESC, WRITE) && mte_store_only_active(env)) {
+        return useronly_clean_ptr(ptr);
+    }
+
     uint64_t fault;
     int ret = mte_probe_int(env, desc, ptr, ra, &fault);
 

-- 
2.51.2


