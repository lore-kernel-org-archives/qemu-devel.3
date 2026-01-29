Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BA5D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaf-0000IE-Mt; Thu, 29 Jan 2026 11:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaT-000080-6v
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaR-0006cf-ES
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso12127845e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702978; x=1770307778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3eIGgWv4cE1JjqWBb1edXamLBSm2sY55mhL4n7UNd+Q=;
 b=muEFbrZuemUhBfJXcxvxF6OLgZsPIDRH2rybAIWzkhFD0734HCBXK/GF//vu22Mh/2
 WG1oxRbxb3+S6jN8guRWIl9cAHQmz32SLBEoVM5NSOsGhJbIMCZG96GyEVTDquOPkWz4
 nOF+k3hdmAWOrmU1CYgkTb37jMK3lw7rGOxXx63zR2w0iMKHhTlC6ndqHamW3s7stiAe
 8WOwyVJxIC+kmxKY3pD4QPQ4sqnpkS0irf/kpwGI3GhB7rdBp4n4stgPMCl0VfjfxqKd
 5VZs9nw/60Sk+gpTOSZK2J4vefJhk2M92k3MERKjYeQNa04DIh1B+u+e44cgV75QNGXH
 hO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702978; x=1770307778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3eIGgWv4cE1JjqWBb1edXamLBSm2sY55mhL4n7UNd+Q=;
 b=F7m7R6+QOFwhMJTmx1925C9yN6HmhCI4ryhIeC4wYzIXuD8Ckjxy4tViH+ixr5l4Cb
 4B+jOkbq4sQz6m/NTncgF2T/FW3S7LW/I9lKJSR9oeTz1ZWmBjtU2sAQFE+QsenIQRMd
 i8Zn5A41MkuHrVXYWJ3J5jqaLD4lT0Wn5EqKWkcwzLy+2+oHCiLgb/aPw7BMLJCXKuiq
 KrQzIcVHCuKbh1IRFmCtqnuTs1TXTa2MG3mwBfswPMV38cXNO8kovn7d8j+8tVOpN6ya
 rHSspooXkRH+889wqavr0Bq0MW3YDIMZ8/V6aoEe/4a2L0YkBgceB8j8a5PG+Ca4Z2ep
 +cSQ==
X-Gm-Message-State: AOJu0YzFEesR2CcJsbuLKrvQVkDkiTCvOrQbw9/0qkSZc5lrAkbVVvYZ
 51LYN4b3dvbOmc05tfhzbughrkYPs6W5D5Vs4fCm0/wgiB0P8JQso2ZhoEpH3DFfppoMk42OyRA
 lVe9hQdc=
X-Gm-Gg: AZuq6aJefxRNpB1jV9JHQw8dqEtJEZO6tFI/gvsrgEBhFSrDoD0kbJIoTIcwyznxmhQ
 MDquE/1YIExB8S7px6zNh3hgyvWuXtCc+5uFfAYdsGxT3HNNal98IeBbd025CeBx0++4t4ViWFW
 DXhOEZnhoJEe2PIPYDMa6mgmblcwyQSaxIl9F6m9lyO4O3iGys5JkrE7ypC6IbWC1H5IDtKUo2l
 CUO/QGsEaJ3A3eQ2Cy+hQiU7f/KqaMAjhB/UsyMQM3Ng9jdmB+iLsVEG2RC2jtSehhgnUvUF642
 QfRr1ckjO47rs1jX7QjSvpjcE8rSscW57VQuhziLyHoE7CFPYi9ZRkMS9tWjy3LHNl/xe3IHrwO
 B6CI5icbk7UomcqSG0cycW9cSqW4I0iq2I+ObDKj/StgUfvStps19jPdvhH7v5BYb6JV9xEkZhg
 R/U9EC+yMWedEn1qb0INt1YkFViblLDQ==
X-Received: by 2002:a05:600c:3e08:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-48069bfac67mr110659635e9.4.1769702977877; 
 Thu, 29 Jan 2026 08:09:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/43] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
Date: Thu, 29 Jan 2026 16:08:49 +0000
Message-ID: <20260129160917.1415092-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

On guest reboot or on GBPA update, attach a nested HWPT based on the
GPBA.ABORT bit which either aborts all incoming transactions or bypasses
them.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-16-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  9 +++++++++
 hw/arm/smmuv3.c       |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 877b7e0e17..c125974d12 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -499,6 +499,42 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
+/* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+    uint32_t hwpt_id;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
+                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
+            error_report_err(local_err);
+            local_err = NULL;
+            all_ok = false;
+        }
+    }
+    if (!all_ok) {
+        error_setg(errp, "Failed to attach all GBPA based HWPTs properly");
+    }
+    return all_ok;
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+     /* Attach a HWPT based on GBPA reset value */
+     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+}
+
 static void smmuv3_accel_as_init(SMMUv3State *s)
 {
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 4e20b646dc..c7ed4dce3a 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -46,6 +46,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -62,6 +64,13 @@ smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+static inline void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7e29284267..7a32afd800 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1600,6 +1600,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1887,6 +1888,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    smmuv3_accel_reset(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


