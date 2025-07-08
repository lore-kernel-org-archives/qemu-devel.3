Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1C9C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFKf-0004GC-EX; Tue, 08 Jul 2025 16:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZETv-00013l-44
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:00:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZETr-00035g-9p
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:59:57 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-553dceb342fso4583115e87.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752004793; x=1752609593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHvIfEToA34AUrJx/MLc8GOT8YL8A2v7KBo+787ye5o=;
 b=qFiHFrQ1widGsfPhAXm+DLkMs75WW19/ihPMhrXjg/4jHcQkFDaOozUEwGMXdRooCP
 t5RI05J5A2QUfAMs3cvbECENtMcqNXWTgcEkfPI2MHzsQV3ms4goOc8jWEu5HUV0Qmrd
 KJhdFAlsdnVpVlL79OXcYRArGd3BaJ4tWis2D5J4C0w1cf7onCpXapRMbY66pj96V73t
 gSDhDStcDl7aVB1zkfFPbUGtK3ab087bF121Nl2+RXnzdgCfXV715C5m/RH3SD5mMoJU
 Wcqplo7XFQythZRIUZyCEMLfTa0zdutw+uBCA8CtA8vdfXf8n+3kkT7X+5h5f6eAe9XM
 2jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752004793; x=1752609593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHvIfEToA34AUrJx/MLc8GOT8YL8A2v7KBo+787ye5o=;
 b=OQvMc5g+EecgWYTP0IpHZgPcaybXMqRFi1FTVUGQP0W2Gz2NFVKToYXP0uIfVhYydP
 ZQn0OwirTxHB1lzooOCXL7/MebEsKkpuhwRggfbjFqxxp5UZyikfPZCXjOjt0f79+jGr
 qDzQ7aiV+/lZdQGNH5u9SN4fxRMY6FhcmdNhOpLhtOZvA5YJ6Y9ep9xtDm/LS5dlHek/
 HyXtv7PvucO7+9f9DaQp/8aEIxIBT4T6tTv6i8mW+6a2+mwnmNsIe6hJ5eS3Zm7/QO14
 73BdMNzaBx4NU6tgQBqjM25FGvgvXuDQ5FhBkhqCfqgUAXdXfS3R00gLT75R0I3U8hjV
 MNfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1arLvOTr9Vek4VRqMfDlcN6GutTSb9BVMMcbKCw2m1dpni1UKY+djAb1FwuCfUAcbUoSQfhPASA94@nongnu.org
X-Gm-Message-State: AOJu0Yz0wdiWHzcLd1eEKfoL0R0eyt0VcPdBAsnhnql0onRQshXwxpZR
 5hFbxFdXsE8BA5mvW3h1hjWNta51BrbaeW2Bwmc9adOBBUrxStDbTf/zGtr/rRHryCzwROFaVGV
 WrTEx
X-Gm-Gg: ASbGncu4C++hgy5mALmy0a6PH5tlMgYlGhmfbhnX328Sc3gcVRTfyKSdrPiTKUKDcCr
 IYBrM62LFzh1JOW5pk5U3AwL8P8/rWyYB1JPdF56mKUdgN2woazPneK6rphPd3/wWMvK52Akahp
 OTqeDPs9lsAcxIlXeS8hIxNpp9yC9dF8Yms1dE9zJdhxSjZKQVr8jO8hOILTvYAt9ANE9aj8NZQ
 drX/HV79EjYYCV3gtcgkVW6I22/V2w2dvlfiyI8wxB+MXbSKF2dj9X7ys2VNen4zLepEn/Avo5I
 DPZ/yDD3ezkrHWWNvuDpN7yrLsLE0aKDvJOE5N7e1pKeA0kbUS+QpL/4pbA5W1INbV/P
X-Google-Smtp-Source: AGHT+IG+A4X0nnNLJ5sc21KLUiKDswTMHI3fl5bj3zzRZZnPwB57X4e5Jvn63jQmNfRazRUKGQKb1Q==
X-Received: by 2002:a05:6000:400b:b0:3a4:e8c4:7a78 with SMTP id
 ffacd0b85a97d-3b5ddf02cc6mr1893228f8f.52.1751975562263; 
 Tue, 08 Jul 2025 04:52:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd4a68ebsm19731255e9.39.2025.07.08.04.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:52:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 1/3] hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
Date: Tue,  8 Jul 2025 12:52:36 +0100
Message-ID: <20250708115238.667050-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708115238.667050-1-peter.maydell@linaro.org>
References: <20250708115238.667050-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

The GIC distributor registers GICD_TYPER2 is present when the
GICv4.1 is implemented, and RES0 otherwise. QEMU's TCG implementation
is only GICv4.0, so this register is RES0. However, since it's
reasonable for GICv4.1-aware software to read the register, expecting
the zero for GICv3 and GICv4.0, implement the case to avoid it being
logged as an invalid guest read.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/gicv3_internal.h | 1 +
 hw/intc/arm_gicv3_dist.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index bc9f518fe86..fc586524f56 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -31,6 +31,7 @@
 #define GICD_CTLR            0x0000
 #define GICD_TYPER           0x0004
 #define GICD_IIDR            0x0008
+#define GICD_TYPER2          0x000C
 #define GICD_STATUSR         0x0010
 #define GICD_SETSPI_NSR      0x0040
 #define GICD_CLRSPI_NSR      0x0048
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index d8207acb22c..a7d10ed9493 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -431,6 +431,15 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
             (0xf << 19) | itlinesnumber;
         return true;
     }
+    case GICD_TYPER2:
+        /*
+         * This register only exists for GICv4.1, which QEMU doesn't
+         * currently emulate. On GICv3 and GICv4 it's defined to be RES0.
+         * We implement as read-zero here to avoid tracing a bad-register-read
+         * if GICv4.1-aware software reads this ID register.
+         */
+        *data = 0;
+        return true;
     case GICD_IIDR:
         /* We claim to be an ARM r0p0 with a zero ProductID.
          * This is the same as an r0p0 GIC-500.
-- 
2.43.0


