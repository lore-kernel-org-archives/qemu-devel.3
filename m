Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C48BCE8D44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvhX-0003Gn-7d; Fri, 14 Nov 2025 10:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbz-0006AQ-0s
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:19 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvbx-0003ta-Fi
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:18 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso1752937f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133676; x=1763738476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tdfi5LI6TPYP/XfUeot6eWievRI2maOs6BUT45BTCb4=;
 b=e6UukxNROphcqa+teF/2aOMRWMmMa2E1exUOO3Ge9BhoRUNIbrNWHgit1sW0Od8R6X
 pE8J/qBnbfJ2KicZ+ifvHOONiuMGHxdkEvphVYkKoRENtUWM+FK+hayRnPJkMKMDJf7M
 N5Z0sOCEBvdA67iqiiT/SI0Q7MXzI9IsxLz0zp8y3IMUjzAU66LGLB7NYyC7HsBAvBRk
 GNCmldrRbnAaj4vjB5iXNnXpBI1ADHMNiKZBoVD+3Ig+lxV4US6rScHmGYI6tIaj8lMp
 98z0CwrVV5oVL62Jml/ucsFcBvZMXlqq5O7scuTM/+DJ5MAUcF/Ivz5Q8s2YBhzcl2qH
 +1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133676; x=1763738476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tdfi5LI6TPYP/XfUeot6eWievRI2maOs6BUT45BTCb4=;
 b=N5AwHCQVa+tySn0UV4fD/6htYAvp/xn/jywOdVFjbG1yXuny7s6KpfqieIoBUYMVWZ
 6sIsQSJhRdPiy8ajyip2AlkXyT/3fzx9YZg6gSAboEf3LC3BsxjkYWWbrluNupDOOCZC
 HLS2Z0XrBgdwLDjcqZhPmLCvvOX4FO64jodSNd/w9hK8vgwPb3nfL8lZhx+8qQC1HbvN
 lM6mPp7vQeqjB+rZdiA0BqeLcs9AjaTnlp0jPUOOWXy9QMbhh3u7f/Xfi8h0NYomhZX6
 W0HG25/4nCNN0j4FmnKkAKlUkQVijbz+EIZy6udGTn+0j066hS+jTlEK2NfgnxCznQlZ
 gHBw==
X-Gm-Message-State: AOJu0YyUCxv4TtTWDsBbFo8gvJ+eP6kLpe0PVYxfqe2A3P1OOffoBG9z
 Aodt+VPmV8k244Dskd9qEdmIl6+oLMpFWkzGhCBZHgU3JfbL+LMQuJvSnhCb6I7WL87cq7ROQk4
 CNi6x
X-Gm-Gg: ASbGncskiXrZDKYTUSWCJAQCCHmRzxOC7q4IiqMu3b+0ly0cGAlXTlO+/nX7uK0mS/g
 UfRzP47e8sZoUemNUoVdEF96l8pgM0qCA85ChVVQ9HJ9HnDBgdVNl8smJ0OVyHj8mmYSB49rgnP
 GECjnPQmSdObTxbZLjDL5PGBDf004JpwQwKwayiS0tO+u1/ckrqd02QCbkfqZEvLHuSlvJ1pSiA
 fDQDwmjCwfONBj2BVFmIAcO1vLJXUcSEJbcjE3dHTkFt8n/NBcuyzbThQhN5wltGuWt6TyWpiEW
 AzbNZcD8lEcypfg8axsKCPtdG1xDbK1RM0NEu3YgGGBIuK6Cvh0xUm72fdNHWrhnwszgaNk7PVF
 edyir6o5DmN0lQ2FmQ/DTFiI9Sji1P8mv5EyCiK2Krz+Qjl7SH2fG5rb/HWthuxLLikaLWv5Ayf
 vPaMAHnsSWhDL8qy96
X-Google-Smtp-Source: AGHT+IEkDMmgX31UpvSkalsbDjOQ7oWk4AWjLidRTrFCpP0rPhGylw9hLSk4tPlKJ6YtkLSqtVVj3A==
X-Received: by 2002:a5d:64e3:0:b0:42b:4061:241d with SMTP id
 ffacd0b85a97d-42b59394a57mr3086140f8f.59.1763133675653; 
 Fri, 14 Nov 2025 07:21:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] target/arm/cpu64: remove duplicate include
Date: Fri, 14 Nov 2025 15:21:03 +0000
Message-ID: <20251114152110.2547285-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

cpregs.h is included twice.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20251110161552.700333-1-osama.abdelkader@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index f81cfd0113c..ae84d8e4205 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -34,7 +34,6 @@
 #include "hw/qdev-properties.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "cpregs.h"
 
 /* convert between <register>_IDX and SYS_<register> */
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
-- 
2.43.0


