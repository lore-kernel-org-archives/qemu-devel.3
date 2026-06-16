Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB35DCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZBQ-0000z4-Rz; Tue, 16 Jun 2026 15:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7b-0004Tb-BH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:52 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7X-0000rx-91
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso2909612f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636805; x=1782241605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pm4M0R4Q7tuMhA/6UlAOFIFLqaw2nq+zNN4VlqUo1LY=;
 b=fnW4DXBA40/K4sjhh7b/zS7H+6b7nD2GnfzZL3S1kEAy61vSJZ1gWvzRwjXRjhyU9z
 QURqJGOV7tLhNZXJQsGe0T1T1K2Ht2wQHBXmCQMfCj99K38JrsvnilfzhKOjcTo6lPWA
 MsMlOEMeAglRTxTtGWXGj8N6QMjkK5/X8Q/CYL1mV5MyF8ilJkRsg/DKbzzR/IYAv2B2
 tIQbW9tVamILa4kUVm0PSbNSTr+BjSSVRr+fA3QDe6O19sZ7c5Yww+cek5B3iJd6A/JC
 siXceQSqE25FC8J/Cof/eGMXKcuEzzkZYd2cB5YfjsQlL34iv6SBhnaxHLQLYoGaf9u/
 gN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636805; x=1782241605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pm4M0R4Q7tuMhA/6UlAOFIFLqaw2nq+zNN4VlqUo1LY=;
 b=A16MGLSwi+yWITLThjhaIT1bDtOsgdmnfl6K14DtW1NoWunIo0iS+qSaoHbUqREQMC
 cE239EqmS5va82UWK83DBP1Zay7QM/FfI533r7HsG49+k+yvbkpUWz1xl1dGREW71bt1
 UE7SB/rADuwKvzm079D1hy3WUyNfyjhPAR0apWtU6a/eiorBmzyonlCnrNvRA54srQXH
 hqhEzKmYICCfJdo3SAhHrchDXsKewy58JSVc1K71Llvev7Xe7W3wHcETCAaDLAFxGE9E
 J6NxR8jktLSixrQf4Ov5jQO54OlTaxM9H0SED8cRg5sU2Q1zNc6bhQOhUOkGff4vPZ4L
 XggA==
X-Gm-Message-State: AOJu0YyUL9+SPkN64in18ipGMN7BHaVN374bX5cMdJztbjaSu4kF2iPH
 vZZoRogROVAsZzsCsuh2Gi11v5WBuUWpR7vOfZiyQRaYNtEMsZxq+/IHO+2WYCa5a2wpKnsuLQx
 w1Stv
X-Gm-Gg: Acq92OEBVcghvacjYmyhpVinDA7ytEz+ZOaGbcqrt8Id5zIeSGMfrrx3PdYpX9UJ+XB
 SH15O8XuHE6d1HgmZnokn9oEWjDST4+3tEzDEc9psGSeySal94NwhOynVm3GphAJIFHlr+SSLZj
 LtRWCuVaQLvVa8BfpWennQzmxTBV0HyQoUVemcaNGPnVzgR1cAJ8XjpzILwhODtA7PuCiJ5s15U
 K0ycwW/KLFi1OOzwC4yG6KzWGkI/epJS4y9pWgi6VgoZnC+IVgcsATmCIeqSiMAPCC9dgJ97ISE
 pro0c/248tVDAtSwLV49DLaj1LHeQFOkVIalFE3QczBEGOV2iE4gXmddPV3cEj1yMcypb32K1+b
 2BjJejPUZjpAhhUXyDidy64ZLDBqpW+gDIfkCdlccIKGyL2ccbf9kT4u86yp7yqlc/sCYLkfpPs
 jo+d0BGustW99rfcZ8FJhH0fQcqTdMFABv9hD3uW4ZT6bL/AHSwief7x1DUGgpW7Ibv+a/LW3Dz
 ZmrR+19322Op9gqLi5u4P3R1UKJVuba
X-Received: by 2002:a05:6000:43c6:20b0:452:75ca:3fab with SMTP id
 ffacd0b85a97d-4623955b609mr997776f8f.38.1781636804949; 
 Tue, 16 Jun 2026 12:06:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/61] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Tue, 16 Jun 2026 20:05:41 +0100
Message-ID: <20260616190639.3462006-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Allow accelerated SMMUv3 Address Translation Services support property
to be derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260608174900.2227340-5-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c |  9 +++++++++
 hw/arm/smmuv3.c       | 11 ++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fa0a97cece..4c2acbbedf 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -53,6 +53,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
         return;
     }
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
+                               FIELD_EX32(info->idr[0], IDR0, ATS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -961,6 +966,10 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
+
     if (s->s_accel->auto_mode) {
         s->machine_done.notify = smmuv3_accel_machine_done;
         qemu_add_machine_init_done_notifier(&s->machine_done);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6b5035e11f..436155d883 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ats == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ats auto mode is not supported");
-        return false;
-    }
     if (s->ril == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ril auto mode is not supported");
         return false;
@@ -2172,9 +2168,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
     object_class_property_set_description(klass, "ats",
-        "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this. ats=auto is not "
-        "supported.");
+        "Enable/disable ATS support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to off. "
+        "Please ensure host platform supports ATS before setting it "
+        "to on.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-- 
2.43.0


