Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nW+vbFJ6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq8F-0007dg-Or; Mon, 19 Oct 2026 12:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq8D-0007cS-A1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq8B-000118-PK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso17968f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426954; x=1793031754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=01ic6QRfFli6nQ9qpb0kBun3L6TORr+h9ToLk/SJjI4=;
 b=nW+vbFJ6aYOTbY+6qTciQnRxoKUvHCjWgYPMMIeDHFm3nk6lESdjFiYQ2lmw+STVsI
 73J9Kd0om/K8gyZUGfA7zpKbyk0FuTVKYS8EHWRsaRTIbCfziAW3xR7OHeDC83V6uK9Z
 FrcDyRxVlPoQk3V4UPriMWAkjDx+2PXiMPdrBhzXGgDcdfKQZEbvVAs16mSJw4BvMq6R
 dQ1mCQRldRL6jK3hAPQ9bW+vUvt/scUKZr6+eR1KdGjcWbfPlJmbr4pkoZF3ubqsu47m
 riNp447ppVhl1tXcXDQEqJ5LFP6M9AUI4AyVcWEZTAcDzMNKZXIaR4XhsAJMTOAy87il
 2KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426954; x=1793031754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=01ic6QRfFli6nQ9qpb0kBun3L6TORr+h9ToLk/SJjI4=;
 b=Hk0jHBJrQbcF+Z+G214EzMYHUJJ5O5JRMXjoupuLLkX9Pd3hek3DEVmEx33zN9FmaT
 iiMQL7tONcUTWDM+yw/vSqW430i6vzHL0v6CfsuwHiaFRFVamws1xw4imiWLYazoitEq
 jPstUlfvbNbc+lagG+wdbMUZ5W3wkL9XIKsaz6r3ZSo85LmnIGpX/Unyj6X2gf5RCJPH
 vD8uvnXBZ63By2yavuXaZVQHfZ+SwJiXLH+t/SOa9kkHKS3E8PQOej5DF55UwRkOW/vA
 I/sQuHrXs6hC9vZCH8mh7JM4lLaMHqvayFIKF7FOhGsX8A6DLylgbnQYyn9O+QkbrOoQ
 GQGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbCkH9MjkfWkrNpkMh/NPsHYchsutUOdTRLu9PIXL1Cc/9OYZ4Pu523aM3T7zsm0+F8G6kgRonOTmA@nongnu.org
X-Gm-Message-State: AFq9FYJRVjp8gihjTRUJSO2TxIWVBPCNgO+5Ht1mKkP3FifnqFM4V2t6
 aPExMcaKYeZQoJQLPBYgCaP3S+eTzXqOqtszq5YUD+ZYgnwAM8qXfegLN2LKE6qNVAA=
X-Gm-Gg: AYBFou03vd1V2pTi7jlX85Zn2VMCXbgAbDswrqw/MI4k6duYE4za/w/pNMwCgDWesdK
 FHXm7B/aw2R6udG0dUnfAXTc57qCMKxGNRTJuo8tr1rqYvBcyYawWm3CWZiR6AokLolZOw3U4WG
 nQBPeWM4tW5BP0ExfQXZ9lwCwTKYpaviZi+2BMjKt9RpArkQ67Rg7z0NRLOi3puEKULLLvMn0YO
 38t2mFvqG1q0gZGKEKeq0jRqnutsma+DnBwNXLDowBMLzBnOCc7ZJvfPMGe7URv2mytUR1qfH5l
 0tMAytb/dO2HMS+3HFYd3cv6wOexYobCy8L1yvOPo7i9pKCq+6Ujx6aEHgdj/O3/8C32J9Da1kY
 cc1ow0QPJf/qCvkZrDNWQwCvXLozspQ2xxQJDjKQmVP/qioNiC8Q04OlRJ3N0KgE+kbcwIq0xdI
 K6cnbNwMZQplwlFWMfnM5LjXenZ1sAMrUGykOVOY42X2cmQL2yc3K36w7B0tPlOIIDX3KKq2SaA
 dc1Q8EGlZ2UsbZ4Mq/4FWBkJcOgh4Y+09/59r7iAHORXmR5ga0KFq7ORbuPycBTF23Y+rb+vcxJ
 jXnl7KWGdkzOag==
X-Received: by 2002:a05:600c:c090:b0:4a1:ac66:604b with SMTP id
 5b1f17b1804b1-4a1d75a470emr128193785e9.1.1792426954003; 
 Mon, 19 Oct 2026 09:22:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm3100095e9.13.2026.10.19.09.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:22:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/intc/exynos4210_combiner: write default case is
 unreachable, not guest error
Date: Mon, 19 Oct 2026 17:22:17 +0100
Message-ID: <20261019162217.3272337-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019162217.3272337-1-peter.maydell@linaro.org>
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In exynos4210_combiner_write(), we rule out "reg_n > 1" before we
start doing anything as being an invalid guest access.  The default
case in the later "switch (reg_n)" is therefore unreachable, because
it has explicit cases for 0 and 1.  Use g_assert_not_reached()
instead of a LOG_GUEST_ERROR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/exynos4210_combiner.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 2bdb9a0152c..80295ae6402 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -242,9 +242,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
         exynos4210_combiner_update(s, grp_quad_base_n + 3);
         break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "exynos4210.combiner: unallowed write access at offset 0x"
-                      HWADDR_FMT_plx "\n", offset);
+        g_assert_not_reached();
         break;
     }
 }
-- 
2.43.0


