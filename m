Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B55FD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb1-0001UE-VP; Thu, 29 Jan 2026 11:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUad-0000Fi-FK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaW-0006dm-3f
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:45 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so823295f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702983; x=1770307783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Skn1NkK+rIcRVPm41pJgvKglu9iuy67JyQUMi7ziwg=;
 b=af9db/WfNHVNJ3A+dWQxRTmhkaTs0Kyg8Xm/rtuCAK8IbiIQ6QaxRrk4MoWDBCk/Yt
 FD97itt/Yfu7CTRQQw1jrDKLsqvnvezUn/L/JzQRcuaYaiBDMW814kGSqpussudepxq6
 8lnpDv/tJ7kptG45WBT01e72x5v3oDumnMKWbW57z8bEU/FJBNi5146+k4EsiMk/WWO4
 CtPBeJXpjQCdwUm2nMUFJtd/XhWR7PSF+a6CntNNWWUIIHxALTraG6b2jTWiVE9Sf4Zg
 5V2nNQ1LtO/IkeXThmIX0CR0r6Ys1ciPeUQc9pQhCbcmNy0CiW3L7zyrXEgiSrO+XRAW
 8fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702983; x=1770307783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Skn1NkK+rIcRVPm41pJgvKglu9iuy67JyQUMi7ziwg=;
 b=e+iaJO/TqI62ba5OSpf/WyWCLnzHJ6JTLyKFMEdGAdlkGflybmCnTntbJqt4wah6aE
 xAkDalQLD+gMmq8qX+8lfmxJMvcUggCjektI69PidPZLIYVEr6k4SwLNuBIIknPUhBsh
 0OHXX0aLarRIFBUFL2W6Ai1cckVCrd5R4hGMPEJDZAfWIJAeDXaxepNYST9rJin4NIjC
 BOAo2CuAIVxzJuDBrj61uPTSTaggbIrL/OZ1jgxq3l9Jvah7QD2SObC/+BFG6ymzabQk
 Y7FU1yN4nZkuW1ER6IlizYWgU1AGZGq1PmxpRA6z8FxAWA7waxq+o+JxYz5rEyVH3ax8
 YQsw==
X-Gm-Message-State: AOJu0Yz294PYola5MilatUPkpfRg4ME4FFzOx+wsTX5Ian93Le5z3Lyt
 2zgL1qipaKKubwH6M0bD3cuVQfFJktHyNo6uRBvwT0K/mG5DS/prMuc41PZRDsnWPz6vPO9tAd3
 +k9mid/0=
X-Gm-Gg: AZuq6aKbVQOS3ipkev8m5RuNpphXMxTN+b6ick9CxOedia+gpkdvQcgG+tmoAigvd4g
 yUZ/lSdn3xZCGDGc1CWkJZ2CAQCZuGF/hDx50hDvPxVozs0iGgg0r89k6s3TynAwQmnrMIGOtn2
 mSiJSS0Z7qWiCZH+W+GDjtNy0oV2M02VuLNcdEgiEXUcEiZFNlEJ5K0Oq4ILDT3fqPzSxAPynHw
 Ckn3x4Dr5w70ZBDBERyzHmQz3Hap6Dr7l+bvgG5SCI14oigqNlMpmKTdU77sM/21N76sy4+aMh+
 rS7w3u+6M9gZ5TlGq0M8cVNJDnNySeoRBYpSOuiXfTUlsWPSv1vX2VQsDxRdb6JzX7mKMnTeMpB
 WyTaN5ZQi5ix7lntcAJ4LfTmwcFm31zOQrXFffzlvzambU6Fixx+vrkq6N5w4J+FpZUsAZrOQgz
 FRxorQiiC2XPAKi51Za9vsX48V/JVe0sYFGKGSHLHK
X-Received: by 2002:a05:6000:4308:b0:435:a370:2d71 with SMTP id
 ffacd0b85a97d-435f3aaa9b8mr148089f8f.33.1769702982475; 
 Thu, 29 Jan 2026 08:09:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/43] hw/arm/smmuv3-accel: Add support to issue invalidation
 cmd to host
Date: Thu, 29 Jan 2026 16:08:53 +0000
Message-ID: <20260129160917.1415092-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
We only issue one cmd at a time for now.

Support for batching of commands will be added later after analysing the
impact.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-20-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  8 ++++++++
 hw/arm/smmuv3.c       | 16 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c6ee123cdf..89dc6f991c 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -233,6 +233,42 @@ bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
     return all_ok;
 }
 
+/*
+ * This issues the invalidation cmd to the host SMMUv3.
+ *
+ * sdev is non-NULL for SID based invalidations (e.g. CFGI_CD), and NULL for
+ * non SID invalidations such as SMMU_CMD_TLBI_NH_ASID and SMMU_CMD_TLBI_NH_VA.
+ */
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
+                                Error **errp)
+{
+    SMMUv3State *s = ARM_SMMUV3(bs);
+    SMMUv3AccelState *accel = s->s_accel;
+    uint32_t entry_num = 1;
+
+    /*
+     * No accel or viommu means no VFIO/IOMMUFD devices, nothing to
+     * invalidate.
+     */
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    /*
+     * SID based invalidations (e.g. CFGI_CD) apply only to vfio-pci endpoints
+     * with a valid vIOMMU vdev.
+     */
+    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
+        return true;
+    }
+
+    /* Single command (entry_num = 1); no need to check returned entry_num */
+    return iommufd_backend_invalidate_cache(
+                   accel->viommu->iommufd, accel->viommu->viommu_id,
+                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
+                   sizeof(Cmd), &entry_num, cmd, errp);
+}
+
 static bool
 smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                           Error **errp)
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index c7ed4dce3a..41b37e3122 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -47,6 +47,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
 bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                                Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
@@ -68,6 +70,12 @@ static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
 {
     return true;
 }
+static inline bool
+smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
+                           Error **errp)
+{
+    return true;
+}
 static inline void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 6ed9914b1e..4efef73373 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1388,6 +1388,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
             smmuv3_flush_config(sdev);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ASID:
@@ -1411,6 +1415,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
@@ -1438,6 +1446,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
             trace_smmuv3_cmdq_tlbi_nsnh();
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_all(bs);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
@@ -1446,6 +1458,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
                 break;
             }
             smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, errp)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
-- 
2.43.0


