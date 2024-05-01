Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2ADC25B10
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6N-00038Y-KZ; Wed, 01 May 2024 10:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5x-0002ja-Kj
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5w-0002D8-2t
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e50a04c317so37749165ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574283; x=1715179083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdYcjDwLN/xr8PQzvEnfgv6lYJ6ezf5kr9JF5Mk0QDo=;
 b=BprKGdB7b9NZil8ImgEMzUk1wSkPlY2rjadiv2XcVGC/WRHeiu3Z0rTvBKsdeEL034
 UNMNohEzVLJEr/IPmb3RoeopMBZ+mkh8HLK0mH4QOh+skPMulncaqvlvq8g5KjmUG65/
 XiUYCqf1MW2QLKGdWi3CXNOhdCDOaTunOY2XuXYR0kaLc/bHUVMRhSPe/KPlIJxp6duT
 c+7HtRIrSqyDcs63sNThEoWLAsZ+8saIZxe7bg1FZb2t1fpYMLjpAnV+NVCi2ITA7Pph
 6CUsAXdGKWnbLcMxs20VKg2RYvTrpXWOEAPfXDK4MWVL/XSqP47YePFyuNFUxC0o/0lM
 a1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574283; x=1715179083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdYcjDwLN/xr8PQzvEnfgv6lYJ6ezf5kr9JF5Mk0QDo=;
 b=AhVVyWyHQ9XKxJ+y/VG1yu7diQ9D+1cVKIT20gI/9B1jLNnOExZAY3ksqkvbmGNv6k
 UYfoIwGhy7O67wQ8P8pcHXkN/Gcp5n/bLS2UgsBHCXRpN4XgykFbXn6AzdH5O+eDEx2l
 HhQUCrK6kf56jC1mv6j4YyL7EhA8yAEsy07VGiLVGROLPqkCjVaxVEont2GtblK+jaYv
 bYhs5H8GDXrZu82B4SkB77ggix6UVg3H/kiyrjRd9gHvNhY/m3qwER0HpTdORHMzwt3Q
 7hqutOuLYD+6xrDw0mbN4xp4ZZ0GoidKIwGVbNHQMoKQPbzDVV7P9tTbRVTVunQWMXFy
 nFXA==
X-Gm-Message-State: AOJu0YzFfuTkztYpZD3ogqz7wyl3QMvgeA6OW+/o4cFLuB7ZJt8hSajY
 1bH3kLB2we3vcb2w5/rE9OW6lVbeUKavpPi5vhpW4QO6+6hoakKuZKyFyGK2l7WN8VB0wNuucoh
 +
X-Google-Smtp-Source: AGHT+IEBbd9bh4IAw0TvBLUqE76Ggryq9JHHmr7afNkw4ixqSlfUr4WPrCGbHPBIkLO273Ey8NaJZw==
X-Received: by 2002:a17:902:e892:b0:1eb:c3d4:349c with SMTP id
 w18-20020a170902e89200b001ebc3d4349cmr2786402plg.30.1714574282800; 
 Wed, 01 May 2024 07:38:02 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:38:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 20/20] plugins: Update the documentation block for plugin-gen.c
Date: Wed,  1 May 2024 07:37:39 -0700
Message-Id: <20240501143739.10541-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d914d64de0..3db74ae9bf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -14,33 +14,10 @@
  * Injecting the desired instrumentation could be done with a second
  * translation pass that combined the instrumentation requests, but that
  * would be ugly and inefficient since we would decode the guest code twice.
- * Instead, during TB translation we add "empty" instrumentation calls for all
- * possible instrumentation events, and then once we collect the instrumentation
- * requests from plugins, we either "fill in" those empty events or remove them
- * if they have no requests.
- *
- * When "filling in" an event we first copy the empty callback's TCG ops. This
- * might seem unnecessary, but it is done to support an arbitrary number
- * of callbacks per event. Take for example a regular instruction callback.
- * We first generate a callback to an empty helper function. Then, if two
- * plugins register one callback each for this instruction, we make two copies
- * of the TCG ops generated for the empty callback, substituting the function
- * pointer that points to the empty helper function with the plugins' desired
- * callback functions. After that we remove the empty callback's ops.
- *
- * Note that the location in TCGOp.args[] of the pointer to a helper function
- * varies across different guest and host architectures. Instead of duplicating
- * the logic that figures this out, we rely on the fact that the empty
- * callbacks point to empty functions that are unique pointers in the program.
- * Thus, to find the right location we just have to look for a match in
- * TCGOp.args[]. This is the main reason why we first copy an empty callback's
- * TCG ops and then fill them in; regardless of whether we have one or many
- * callbacks for that event, the logic to add all of them is the same.
- *
- * When generating more than one callback per event, we make a small
- * optimization to avoid generating redundant operations. For instance, for the
- * second and all subsequent callbacks of an event, we do not need to reload the
- * CPU's index into a TCG temp, since the first callback did it already.
+ * Instead, during TB translation we add "plugin_cb" marker opcodes
+ * for all possible instrumentation events, and then once we collect the
+ * instrumentation requests from plugins, we generate code for those markers
+ * or remove them if they have no requests.
  */
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
-- 
2.34.1


