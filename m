Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1D5CD98EF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAR-0006Ud-B1; Tue, 16 Jun 2026 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8B-0004Ys-Fm
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ85-0000yS-UT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so111972f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636825; x=1782241625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U36QTOj3+WS8UfS+I/MVEAMSNS5LcHohAWyCMHmrQIo=;
 b=uKGPzVvlagJ6Q5lPLIRUIqFGsBC0odeRQMMVWbWM8OTWnSlwS9U/exBOqQaRdAuTCr
 96KoIO5vYN11HdA3t4O5bHnPmoIO8JUsqSBWVRmSwZECVCjGQ4kunTPBsNE2yKvZhwqB
 DbQjtcKmiviDqNQJ+uWJIHb+KRLGNru1Byo8lqlUCbC/d56FNimMVlnCnSs6U8OhReCp
 hacHCGi9iWK2Gd6y+SBv+oHSn9XTdhObS5pL+sU8OUjJYtVbaxgbJdUIeObTb0jwv6Xk
 jfx7aBmQFJUmgbmmX6EGsg0uXy2UKu+PTLtoCjsXBn6Z0aoeyWKxx4utMg77hBvBx4eN
 LnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636825; x=1782241625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U36QTOj3+WS8UfS+I/MVEAMSNS5LcHohAWyCMHmrQIo=;
 b=RFMVAn1Tqy4WewGN+4TSCeszXB0w4/d9y0LbWBcnS2/zQixz520yI2ctCuhgXeFVmD
 XSQY48cCmzSBunmdEmwppr4buQbpQj5XQ8i8caSbSJ2HuaBZNjGQ6FcKQcN9VFp/01w/
 6LYmkdnP/0neMl5sNrkTyAMzy+eym4eK/1NQAMoYcdXbpUdnYtM/g+NUvi1ftPLvRjo6
 FoMqQTa4QD6g3OnkVOCMfBmzuutwnL1dwoT/zcQ+UVvEdpxwzLqZYdyKGh2GwIIybPhj
 kLlp6BoCiet3/qCZ903VaLPbBK3xAl6kPVBqq4M4xxWg4wx8XSl1HsZjookFmeyMFFyx
 z/ug==
X-Gm-Message-State: AOJu0Yx7d6qAtz5elRHmghVtL4EwPSiLXA58iGIh2mfQ3Vc+XxINyQ1M
 a8IJOLu7nd8SLfALKzpKBbw9ibXYcW5V1GtpmigDB8W+54WyZ/IkUxYaimRBC/CjvwxJiKOrJ1s
 LRCKx
X-Gm-Gg: AfdE7ckyqfhyBw94qaHK/3SENPgOrihSvZZLnLh7gtUcLPSWEsae1OW7SEOu252TmBj
 QQyEOtk0FPg4T0cXnDj9gdlbVf+ab0zxv23sH+bjMPbzziztvicO3DBNsikNQfdVvIfdEdb84OO
 2O4NXu7qDVGfr8tItZFpoM+Cz2h8Ci37WYpspZ7fpSAKGvp0AbrOkVVXn2408GSsqFWFxc20fza
 JwNHnnpyG0cTqIRP08K9EsXtJeUNzt19/az8maa6m2wITXKt94OgamnljqOV39Fm5wgrNfWjIM8
 N8E+cTgTc3HsQUTuqkh8gZB6yl3X7q169brWgxCXav/9dp/Xn94krU34hykKrsUGBgrf8oqGzqy
 I1gUWTMcTuZUdDxXyfgwCbZCS4Uxb9g0552kZOa3uOll9pBhGm6jLlmf43Y5S/i4DvB8m+diNAz
 4Hdgn900ayRcDDIeLZLEYckVJ0hIhMzL6z0k8rhZsvjzp6LRMxyKPvUgC1cZ0P/efmueiwgRXvc
 gzwUR5YNV/juhH8VQhoO34Qb0CZx3Kq
X-Received: by 2002:a5d:5d05:0:b0:45e:e936:5e30 with SMTP id
 ffacd0b85a97d-462692f8590mr43249f8f.6.1781636825069; 
 Tue, 16 Jun 2026 12:07:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/61] hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV support
Date: Tue, 16 Jun 2026 20:05:57 +0100
Message-ID: <20260616190639.3462006-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Use IOMMU_GET_HW_INFO to query host support for Tegra241 CMDQV.

Validate the returned data type, version, and minimum number of vCMDQs and
SIDs per Tegra241 CMDQ Virtual Interface(VI). Fail the probe if the host
does not meet these requirements.

The QEMU model supports one Virtual Interface(VI) per VM with 2 vCMDQs and
16 SIDs per VI, so the probe ensures the host implementation is compatible
with these limits.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-11-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 32 ++++++++++++++++++++++++++++++--
 hw/arm/tegra241-cmdqv.h |  4 ++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ad5a0d4611..3a19a1af56 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -38,8 +38,36 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    uint32_t data_type = IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV;
+    struct iommu_hw_info_tegra241_cmdqv cmdqv_info;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &cmdqv_info, sizeof(cmdqv_info), &caps,
+                                         NULL, errp)) {
+        return false;
+    }
+    if (data_type != IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV) {
+        error_setg(errp, "Host CMDQV: unexpected data type %u (expected %u)",
+                   data_type, IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV);
+        return false;
+    }
+    if (cmdqv_info.version != CMDQV_VER) {
+        error_setg(errp, "Host CMDQV: unsupported version %u (expected %u)",
+                   cmdqv_info.version, CMDQV_VER);
+        return false;
+    }
+    if (cmdqv_info.log2vcmdqs < CMDQV_NUM_CMDQ_LOG2) {
+        error_setg(errp, "Host CMDQV: insufficient vCMDQs log2=%u (need >= %u)",
+                   cmdqv_info.log2vcmdqs, CMDQV_NUM_CMDQ_LOG2);
+        return false;
+    }
+    if (cmdqv_info.log2vsids < CMDQV_NUM_SID_PER_VI_LOG2) {
+        error_setg(errp, "Host CMDQV: insufficient SIDs log2=%u (need >= %u)",
+                   cmdqv_info.log2vsids, CMDQV_NUM_SID_PER_VI_LOG2);
+        return false;
+    }
+    return true;
 }
 
 static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 74a6954017..38c8b27b4d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,6 +10,10 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#define CMDQV_VER                 1
+#define CMDQV_NUM_CMDQ_LOG2       1
+#define CMDQV_NUM_SID_PER_VI_LOG2 4
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
-- 
2.43.0


