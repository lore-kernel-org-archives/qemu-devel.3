Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD823606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Xlyci+7P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3W-0003Yl-MH; Fri, 23 Oct 2026 10:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3T-0003Y3-Nt
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3R-0006oj-Uy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so9783135e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764932; x=1793369732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pbY7jpGacYCdIJDtDEhCiCEAguIOoPsfCSBqScFiK74=;
 b=Xlyci+7Psi4O6ozROsd8Ykv/+pPXNMUItifyEF/QN5TsbbSCHCaWuZf+4QoKZilYtu
 MUe7K5R8ctOsWxnw3LT/nPfQXTvlXS6AASmJSvVo7iYewe470xxG2ZGvj+6ai3zMgvOo
 kL5dSYKEea7dtK7dF45hOXmvAGfsumQ/GFGeRC+lt0U3rwtUcjejNRM7Fc2yj37T3t6t
 MJDm3Fjn0av9uHDMOA2Zu/fMVc63FuUMjVrZmrMFW7zTya6KpbZuXYYNjuo/tAkONa2T
 JD5G8cnId/8X6wWBqSXvSsNf9eE/93JkjkwqXa9Y3wQMfJBHAFSLaBkyb9ftvI4f/T4l
 3MuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764932; x=1793369732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pbY7jpGacYCdIJDtDEhCiCEAguIOoPsfCSBqScFiK74=;
 b=DV1MkUirPKJYgrgZMA/GHTgZH5J0PPUOUS3Ls/Z/9tBNZjsm/gP1o7w9bq2bLlmAMN
 dV1aE5p411iKiZbw/0yrGKkpgm3QnwHD4p+vKlAF84CuVLiGkVOiN/i7sLO96ed+lHND
 FhkyGTcnzpbggCG9tncEmiofDm4zgso1gjqY+o2k54FIvjdbcn4cIw14Ge5wQ2uT/UAI
 lDhI8WpDr8UeH9sJDiY1Cx4YbE2i2KPrwJe/0P0Q3qTMPfy3jiChvpH/A+InkSmhq6T/
 YGNQJkgooqJeNkwNRW5C9cf1NTXh7Dx3U9by/Px57Coear/mKuJlBl2nNEXFfSJaC8a9
 xzyQ==
X-Gm-Message-State: AFq9FYKqh1M/+l82NFjCbz76o0OAkUMZh6VXf+IPoxVAe3WqyAys9+NC
 bxh/DXAfIzPjUay5wX6GMxITzaTPc/I3lti2KYcokck+zdpm/qTq5uF8Ftpwml3FNlQxcxjfKIT
 nUTowhg4=
X-Gm-Gg: AYBFou38OWZZYtsB1jaiAL3siDvOyM009TS+zrNgXBqgVrkCcC/qLVIdBBUZmBccJkQ
 amgyZ0IFSEh00hDisA5VlNuf6PESvA2qnQ+rWFQhwLWaX29mrRSigssxl6gXUUnOj4NolA/MVNu
 87L7tet/awRK5OBrZ2caYqs1Hb8R2Zpb07usRTpp35UkLpwT4PZFfvRBCH9/xVtHeJAFZBXFN3I
 xCBQVNTV1vTI5QpY78Zm0mDPcyUywHw0z64OOILctsOEe0SSyTOa+i+sTN+uRUxQAXFoTEKkrVq
 YaKUm65EGWarYCDlShn8+V26bjYggzmtyvTyRw3013nB48goD3fkDMv/HPg5cAJSjqhtSNLf2po
 O/OeYvnwH5NCVLf8chBuvQVoQgIIY2XeR7t3SlkZoWyJ/8aIvbIkRYCV3Jt2xm/VOtOm9nytYes
 EPBSLgGCUET0Jcuk2bLfJwUBNPFj9fDj39Yk2vzUFitovVK13xZKydvMiwm0hoqx5sLTbLiVzXU
 22j60AO7854Oy/KpaAkuYGCvuBYE5N/tYgFgpnlFu7tf5dapHC0BZpISS9NEsjBpyehQf4v1yMS
 97HOm7DdHOQhjuW+NxcMRbB19EyB9JeNJyzFG5+xv7d2K+YNERe5CtxX2boqUA==
X-Received: by 2002:a05:600c:c0d5:b0:4a2:150f:15fc with SMTP id
 5b1f17b1804b1-4a2150f1778mr30576755e9.5.1792764929588; 
 Fri, 23 Oct 2026 07:15:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] hw/intc/exynos4210_combiner: write default case is
 unreachable, not guest error
Date: Fri, 23 Oct 2026 15:15:02 +0100
Message-ID: <20261023141503.1397009-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In exynos4210_combiner_write(), we rule out "reg_n > 1" before we
start doing anything as being an invalid guest access.  The default
case in the later "switch (reg_n)" is therefore unreachable, because
it has explicit cases for 0 and 1.  Use g_assert_not_reached()
instead of a LOG_GUEST_ERROR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261019162217.3272337-5-peter.maydell@linaro.org
---
 hw/intc/exynos4210_combiner.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 2bdb9a0152c..8d1ed4a4bd2 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -242,10 +242,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
         exynos4210_combiner_update(s, grp_quad_base_n + 3);
         break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "exynos4210.combiner: unallowed write access at offset 0x"
-                      HWADDR_FMT_plx "\n", offset);
-        break;
+        g_assert_not_reached();
     }
 }
 
-- 
2.43.0


