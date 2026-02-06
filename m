Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA9EEE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAd-00064D-Pw; Fri, 06 Feb 2026 17:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAc-00063B-B1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:22 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAa-00079f-G7
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:22 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c61343f82d7so418685a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416359; x=1771021159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiECesYJ3egJUoiGbW69hBkBfEtGoUsIdKpeOrRz1rs=;
 b=F5cf2y5JxyliUI0spKeAp3ItlpoeXmRmB2bWK3m5USGhc3ZVFO1iZ0vljBkN6lXXYv
 Nt8CCPQPvw3EuiPiljKtjuyWwN9dJrgYcPhZFTHsOAVEYk6JXbPnRSlbpvdWxxweodNl
 jry+4PWKXvK+VJ5YrhzA0D0xbkgnyr3ES0X4RpW8jPOCCTxsB8A9lLyNd6q8HuXkfAV4
 WvTrgar8422zx244UTE3cra/ypSIAcTwJ6rXINe3lkhKJWsTTLmkPACH8JSVNLNhwIUp
 01Gjzrgo66sl/m+hVVNlwnP6+38fUfMCRRqnz2xHCQvqOazfz/yHIBPOQxdGlPhsOWht
 KC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416359; x=1771021159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YiECesYJ3egJUoiGbW69hBkBfEtGoUsIdKpeOrRz1rs=;
 b=GtXk7pPOHTFLB/SK3q/H8/5fFUza+7wIDzw+5WjNz90x7/R1FmcpOtpL3I1uMKy+fw
 A0STKbV4imvhhYnzwNhn0CJ/OEqFcWmxyFfw60qHECfE3JXfh42FBZRp1TZDqKsqLdNe
 l3jpQXy7WQaPSO/eBVoMGio0rmODE4pdwbk3OKMB/7jrzBDe+0epY1z/9CUxQ39eTKn9
 gU4OY4m5tOjqOqQuaRlkvuCmJFL/A6xSEftTNfLZWmdqVbtZcCShy0vwuHeMlxOEbF/U
 E9CeACN8T5TAg74UkwwPaA09f+n5FMQzAlGNe7rXkbfoML8GmGsTzK9LEMwUoQl35KKb
 +/Tg==
X-Gm-Message-State: AOJu0YzVm1T9pQdQugmOsQp/4uer/ioybAPy2KnGxzzqtWMF3lAY0rck
 lHMKfKz0CfsAblOG8JgEwqmy4uxQCezv/MtOGgfpN1TTPdavrDJCiNIvlZU0GR8yg6MqX/pacYO
 cifrd
X-Gm-Gg: AZuq6aKpcWNTTktcf5TR0PD0BzuucQSotmInUfp8A1qc8x3LDqfJDR0NxJGVkcCF19s
 0eENOaI5hQZHuNLGvPKtrz1JJYycNO29CArL90OeDxoIeRkhLkmhTkhFsxoZG5LMy034r6r1vIf
 rM1ljCON8ONSGhJuwtHwyAer3vFXAUA9sIvSBwrxttjXDeowbPsH/siJAdyz205uRCn1Hey4rZB
 rU+bIjvvME22qFtAKx+zg5vESfv9QrhXLkqvZXMAn2DsWFtCtKVqIPhE7TAUmv/cz6wDSLgUCTU
 bsTzqRI4ZTHlSNNZuBfJ7FFbGN+b0obY9Lcm0WMnnpmQej/9N+Bzs6LtGS7+exKV8IzT4fOPfgs
 VzfJUVgZNJAtATCAcoEbVe4dLqWQOP3FcZ9c1m/yZ9CRHSt1vKJPiZ2+BTrYt8qvvaPNtUCdUOZ
 qZ5o3Cw/q81e6TIH1LfnFtl7Hzs94p8InP0wBkmLO6loKgcvqHEgs7OFFdBJJJHKOMEclEYtVYk
 X8=
X-Received: by 2002:a17:902:e842:b0:2a7:7e00:6a96 with SMTP id
 d9443c01a7336-2a95165b8c5mr50467675ad.25.1770416358967; 
 Fri, 06 Feb 2026 14:19:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 4/9] include/hw/virtio/virtio-access.h: remove target
 specifics define
Date: Fri,  6 Feb 2026 14:19:03 -0800
Message-ID: <20260206221908.1451528-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index f3b4d0075b5..1bea3445979 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,27 +17,27 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "exec/hwaddr.h"
+#include "qemu/target-info.h"
 #include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
+    if (target_ppc64() || target_base_arm()) {
+        return virtio_is_big_endian(vdev);
     }
-    return true;
-#else
+
+    if (target_big_endian()) {
+        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+            return false;
+        } else {
+            return true;
+        }
+    }
+
     return false;
-#endif
 }
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
-- 
2.47.3


