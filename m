Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB37D10F37
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEqJ-0002kF-UW; Wed, 26 Nov 2025 07:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpq-0001q0-3u
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:29 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpo-0003OA-3y
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:25 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3108f41fso4051623f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764160881; x=1764765681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mn1h9ya9N+o+rWO96EM7+0sskwR9RqKMkNCUOJ59t/M=;
 b=KmpDhMSvbcXypS+naH3JRVF+OHJjkzFa+QbW216v1u6Xdu0/75bDYclTowr0/aInN3
 qtR69pGKHS154WJnaABtNwAImxdKrAaZARIvzn+f7M1LtdQaXJj+YDNcw4ey+c5u3cpp
 vOKaZrIAR/kIIWe00G20P8cTRkn6S5qP4jcDEHPE/MSFPOL5pRu3LwTI6AXyroTvMvxz
 18CqYT7UEhfvKk5uDszVbm091z0/dKkYcz+DGl2dIZIeAyHmu3OuWRCxwc43/AgYA0pe
 Qfz+B2jCLtTHNpqBdohfEcMiCDqCJ0ABhzfAYugNe1p1ZYYWb6zCkduCs3Af5HRGALJt
 p97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764160881; x=1764765681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mn1h9ya9N+o+rWO96EM7+0sskwR9RqKMkNCUOJ59t/M=;
 b=TPlspmWDFwsn7tI7K8MclYQfVAVjJUEltlyEmQU/waV+BzyWByCz710s34AnXvRlVO
 YCw4hMt+zyhDpLnddrjz7RB7hN0hRf6E/KLIn7CsXl5ENga6YWIyG0Crzl83FvNSKQBi
 zG/ujKeM/tju1v8iEmrFUmH7cm6WLxPN2YaJQklashbIBtIW8AEIYO3U6V9fIOdZOkHD
 sDYDxIffb3jxSfCI0yfWTiytIwySq0tXVLfqdOsH3GSoNLY/x/V0jY/07G9DhXnr7xRH
 58Pz/W+GNm3pBESj6bdXJZvLP6fQKUkTeUumQtHvF8tdQShxs1xpJpryQ4oDonpS6tfk
 hyhg==
X-Gm-Message-State: AOJu0YxV5wb4vX2O1F/2Nr7TofUkCQIQUPlh1asZ6bZ++2E2fuUKKbBi
 6Z/h1gpK0qVQ1ErBDgiRSK+Kymrfrf/a7CLNncjkVgkXliOUGpmSD+IYNk04nioSzyEUxsgqqdH
 Qxlwz
X-Gm-Gg: ASbGncsogLeFy5q/DkmFdiJBu9O1vsHss+fboPR2BWq6NJxkpXK6dxPstXD12/kf34f
 w+7sDUM39aR3r345d16ZCGZoxi2gl9jF4iHB62uKZs9GQS5sku887tVK8OAgItI+YpY8EtpzT6W
 7ZyBv+VNYUxBHALJbpVYhTgh4s4OYWTszRN4jARxHyggcLwi5/K8mXoPFV6jc2wdX+kUGCTH0yy
 vOOOfXbQiJ5Un9fFF2aOfyhN5eNnxJYbJE3tucYBidBlMKE1ksJX5P0YRKnYu9gos44nEik1DbY
 P07WTk+OYt9pTJYJgBBQg0w2lwELcjypWAqpjH4LeJBWPJ/LBVmDbsMNvvgQ/OL0jdZzJ/QvQ5L
 oP6wGLxq8C9RhDUleXrra21Ao6JoG3+AMCGrZdTWdAFj5FX+hpV7ae51qyDhTBOymKIRRKbx0Nt
 bS7d/AAUDXRe8=
X-Google-Smtp-Source: AGHT+IFbJpxLXx528Xay5Hl9bL7GoCjhZoJUuZ8UTH5gdJJKwOG/2hwIeMnNH9GNboYI5yhMlNbP9g==
X-Received: by 2002:a05:6000:288c:b0:42b:31a5:f065 with SMTP id
 ffacd0b85a97d-42cc1cf4492mr21570479f8f.28.1764160881636; 
 Wed, 26 Nov 2025 04:41:21 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:a692:d4e2:eaed:fc4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm40044246f8f.5.2025.11.26.04.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 04:41:21 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V3 3/4] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
Date: Wed, 26 Nov 2025 12:36:49 +0000
Message-ID: <20251126124116.351685-4-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126124116.351685-1-jim.macarthur@linaro.org>
References: <20251126124116.351685-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..ef4c0c8d73 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.43.0


