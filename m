Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE0606BD35
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=z5Mfaf3w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueY-0003sC-Mi; Mon, 16 Nov 2026 06:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueE-0003ou-Ju
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00027s-Jl
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1790958f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827589; x=1795432389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RNd36oaJ1HdGT+rhZlENz1yPtG0nBRRajHzmEN2ptno=;
 b=z5Mfaf3wiFPnWoDT9dbmKjfZFPAeU4xRCXOtKVhqdv1q33+BUEC+Rd5yOwjaZTowbq
 xV9jL4Jhc6R3hYcZokVo10xBChiYGvaRz0w11cMVBSjna09dDCi7RbMS/V8QDyVdx+RO
 fPs+mVAdSUnDqw6KTZBLECR3fBvSsKF0W2QiRzK/IgdocmyUtmLjj4gOxwupcFOFXlps
 eOi1m5Huo10oRj37UuJu79aVO9lGXTngLiMmuzuk6aBJWEUldI/QfDPDP+vmXiS7rqTr
 i0ZkeRrGO3+TMcDCX2cYHmOtZkWCOUNBpckxepMzh0yaU7ukzFHskfnbyNi5A2YIh3Fb
 tixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827589; x=1795432389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RNd36oaJ1HdGT+rhZlENz1yPtG0nBRRajHzmEN2ptno=;
 b=mtM+EZFcZsd3sdoZwlE9gkVeNPAaTbONGJxmifra91geBQu7jtFpboylCf8AeUQ03H
 MfR/OWBimIeE6jPOj3OMFsYW1tw0+UHgIFQSEqSlOQ1MHWFbH+g3LKojjfuldWMemakF
 N62UsG/QK0RZ6Aqoer4MLQLwZ78hRl997u47wwf38b5rQyNDY+HgS2Z56ryI7u9FwyTM
 MY2N7iMd4TYuBlf79+qO4Gbq+sz2sSjkf+gsAfPRxAwdwKpazpSowFjTKnh6LHXEiRwP
 fW0S6yuHcNnO4ZFhW+QtKnGCcfdLPOFThvrnBUHtkC16I1dCTh/LDy7ZOgARDMA+kErJ
 dt8A==
X-Gm-Message-State: APuU4Z/BKlgXtoKWj5R/OjaScTu6Mwb6YtlF7q4xPu8mocQqzKA1dynD
 H1sX1ol5dHUOVpGXS2WREkFocMpw8C07UzpHRjxEDQ/CLYHCsmevsiVqs4vBdZAKZ8mxByJQaUi
 NNrGAnSg=
X-Gm-Gg: AZFdTZdBuiJLz70IT5q2rzQ9lsUUSP3YLTcivj4WCxI/H/HrRibBrHybXIMfzkr2a+q
 +19loT44GH/BrYbxumT6DTO3Z3rDvL+rpn0yEg9aRmQywJjG1GjEAboExR7bHvNv9eTJebA1C0F
 Usz46+wRPQpHe1AoeF781WgmiFR3UoSeVICdWLxwxlnsLZi02ucE2lkYRa+HVX3E89nM2nok3BR
 XO3CCbA3jILifU663k/IbgEW2Y1tuv/d+3THZQZ2le2jW9+//kncstHHm4X+gYRzcG2jK4cvtV/
 RIEJzpS9PE9Y2PycGxSmIh+Je8gFJexlXwGUeqUEr+62mylo+UU4gJ2ZcyTQBimwWXpKWQsVav3
 bT8OEjNKLHkEBe5Zex0+hglo0QkXzjS0s6Z62CjMDVmZxALfmOfB7+a0F0Calo7N3/gWivDVJTd
 v791jFm48IeU0nEEv0zyPw+0/XqDJKKiC969DELWDWULKcDAlCdEoL1k5xhP/XFZ6zEGWPhCJuQ
 1TDCAppWVxEvdPs/YsWsES9Yuc0zhorPe6lHiANShczMx9P2HzlDCJTRvSp3GHW8oTpzwDioUiH
 xeshM9ANKvPePRDC3vDJmPNOBkg+ungdng9nkoosQyZYDGYP3KpyXNSBDPxCYGEam53LNXUblsG
 BieJBvnaZJ+kLJF4NaMHneeCAX0MCSSE5uytgCAHyuDn0H8qUojs49Sg=
X-Received: by 2002:a05:6000:22c1:b0:488:83f7:6352 with SMTP id
 ffacd0b85a97d-49c6fc9e5bemr22822140f8f.4.1794827589562; 
 Mon, 16 Nov 2026 03:13:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/33] hw/intc/arm_gicv5: Free memory in finalize
Date: Mon, 16 Nov 2026 11:12:34 +0000
Message-ID: <20261116111303.1692832-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GICv5 allocates memory and creates hashtables during realize and
as part of its operation.  Free those resources in finalize.

Since the GICv5 is created at QEMU startup and remains in existence
for the lifetime of the process, this isn't an in-practice leak,
only a theoretical one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20261103172616.2400758-3-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c        | 11 +++++++++++
 hw/intc/arm_gicv5_common.c |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d0a8574916b..fd6456cd8aa 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1970,6 +1970,17 @@ static void gicv5_init(Object *obj)
 
 static void gicv5_finalize(Object *obj)
 {
+    GICv5 *s = ARM_GICV5(obj);
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        GHashTable *ht = s->phys_lpi_config[i].lpi_cache;
+
+        if (ht) {
+            g_hash_table_destroy(ht);
+        }
+
+        g_free(s->hppi[i]);
+    }
 }
 
 static void gicv5_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 2920b11cc39..cfadfee4f05 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -112,6 +112,9 @@ static void gicv5_common_init(Object *obj)
 
 static void gicv5_common_finalize(Object *obj)
 {
+    GICv5Common *cs = ARM_GICV5_COMMON(obj);
+
+    g_free(cs->spi);
 }
 
 static void gicv5_common_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


