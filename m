Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAE7D6B088
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUax-0001Dn-Lr; Thu, 29 Jan 2026 11:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUal-0000UW-MZ
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUah-0006k0-Oz
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so10485195e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702994; x=1770307794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rUUn70ACpFYfs/QMQvOGgsBMv/EAn6IBhP2oNBQRff0=;
 b=sVykaeiCsihP/ChS7pJmT8n6EIjOy/4X8NxqUhXMWnEGWEmkR6qkr4tWH6lDF4k4y2
 qUQLTTGeURzRg8XGyGaw6y1ESXJbXWOeyHoKHFiOAvJYakMfUPd8869F0oSt6FvEONLU
 BtM5yBkxSacBeY+ZVctfg0R2B/DxlHPWfZf0yjPYeh0vB5pq6tbTyOhpBxU4tzvlQpC6
 DNf7tL129MDzjFETc4QtK/OJrdvqstjTX2v97dOeipc9OGTckPEHRg2HvA0/hDfnOnDl
 ePMLm0ib4D4retEqASniYKd7AM//qwd261cxiCn137yVmNKfv0onAqKN6ZcSPG+SvqDX
 kfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702994; x=1770307794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rUUn70ACpFYfs/QMQvOGgsBMv/EAn6IBhP2oNBQRff0=;
 b=wBOGb0DBGfpWtd3mga8kDxJY+hzoq8qBOYvOn0BDU8I27W2juZ3zADOMEvFqtgMcR7
 ra3WfS1wbIHmClVJxFyf3jG4TCgWYkDhK7k8LbM2xglcIytm5cFcMa5aNZnIv9FGkqos
 uBK1o36TxEqPiiN7g3Z+n02SKPXPjjvW0O0yezurMQ4EeOYBXQ/QdHsjL1GoHa2pkQQ7
 zGk3p1FHsQ2JI9QBMe5oRddvmVaXZ9Go8K4ZIRJdVCygcfSoIP9gxwzBtNRBEBrpJ8Vw
 rdoKbGfDLr0T6fEIBBAGPXkWMjKZefz0aEq7kzR8yvXDiY5HuuSslCMhvPuQZSWjCTpP
 hkLA==
X-Gm-Message-State: AOJu0Yy+GXCi4fb6Ra2earWHEMSCE3ZPQsBQSXXhprpNKrhI0aoGgBF2
 1fucJW3SOzjngQcuIZZiMOQcUdafctwcna3jJHblvZDGIHkzTc+spClw7avycRN/ZKUUrFOTcC8
 fX8quQx4=
X-Gm-Gg: AZuq6aIA1Ke0RV7oYfE2M+56lW7loFwwk711ZCOIJ75gLn7+7gaty2dHC9pK926AlP7
 bflkGWojdJN+BoR+gljeq9S0AeuLv6xqRIXO12LRlXtUV+0OcRuLsL881ZEy0HTZDhXAChSQ7KY
 n2VjH0+/8FAQ4kha9yF/cytQCedQJTybqM1DHLMbvI6QZll+ws4OR2peCCwuIfVvOeuwPzKTcmy
 bPvWLX3WIhZC7oiNSgMSUzGrPoEC4f9WrbSr/y/MK6q8bWtL3bdMpQydE+j6r3wHUdGZFhEbgBw
 fOzLpPX4gdzCPBBOfGBbYlY3shn43eJTZXbKhe/qLUu3tP4ZPEfVe6CQD9e/jz2u/Y0DzGtzZ73
 wGiLTf0FQHoyIo6TlatMUn4B08yb57Fsu4Ou8t5+q6B3aAsLF7x3HszA4qfIcx05EFFW058oaKv
 Z3kStNcnAkPu6Rnoxb2B1lUowUh8GUOg==
X-Received: by 2002:a05:600c:450b:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-48069c206c8mr113310115e9.9.1769702993930; 
 Thu, 29 Jan 2026 08:09:53 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/43] hw/arm/smmuv3-accel: Add a property to specify RIL
 support
Date: Thu, 29 Jan 2026 16:09:03 +0000
Message-ID: <20260129160917.1415092-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Currently QEMU SMMUv3 has RIL support by default. But if accelerated mode
is enabled, RIL has to be compatible with host SMMUv3 support.

Add a property so that the user can specify this.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-30-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c   | 14 ++++++++++++--
 hw/arm/smmuv3-accel.h   |  4 ++++
 hw/arm/smmuv3.c         |  9 +++++++++
 include/hw/arm/smmuv3.h |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 33011962e3..df82f1e32a 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,8 +68,8 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
-    /* QEMU SMMUv3 supports Range Invalidation by default */
-    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+    /* User can disable QEMU SMMUv3 Range Invalidation support */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) <
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
         error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
         return false;
@@ -646,6 +646,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
 };
 
+void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+    if (!s->accel) {
+        return;
+    }
+
+    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
+    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+}
+
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 41b37e3122..a8a64802ec 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -49,6 +49,7 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
+void smmuv3_accel_idr_override(SMMUv3State *s);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -76,6 +77,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
 {
     return true;
 }
+static inline void smmuv3_accel_idr_override(SMMUv3State *s)
+{
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8ca1d4ad35..cb619f19df 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -305,6 +305,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
     s->aidr = 0x1;
+    smmuv3_accel_idr_override(s);
 }
 
 static void smmuv3_reset(SMMUv3State *s)
@@ -1926,6 +1927,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 #endif
 
     if (!s->accel) {
+        if (!s->ril) {
+            error_setg(errp, "ril can only be disabled if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -2059,6 +2064,8 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /* RIL can be turned off for accel cases */
+    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2084,6 +2091,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
+    object_class_property_set_description(klass, "ril",
+        "Disable range invalidation support (for accel=on)");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 9c39acd5ca..533a2182e8 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,6 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
     Error *migration_blocker;
+    bool ril;
 };
 
 typedef enum {
-- 
2.43.0


