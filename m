Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AC9D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb0-0001Ms-F0; Thu, 29 Jan 2026 11:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUat-0000ms-44
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaq-0006tm-Eh
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:06 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so1085748f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703003; x=1770307803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DUXXViwauWLkh3b067d+qkCc8ZKPqxtPhuKZgFQ3Zck=;
 b=wLRATYbCCU3cnYBik7NPC/wS4sEhdu26GdBCTycmXNsVlZmAbQoUpjPQRzp8SpP6zk
 Xhgu0X5PfI3HMVo4RPSPNTxgJAhdQfWB3OReb9tmeHFOUkXTVTD2sBVjNu350/2ROOFK
 Cb98xe9blK3rrx0eNAid82wvZ++znHg6yeeMJU78Gxe0OqlPL1yImNgdsPAV5yIHS9yk
 zzJW+uQ/poKweshP0gECsnlzrhO5SXB6myj8P6rVkeG95ZELAroLQv2Al4uGYc+oUXzx
 UQD3CJtsw66WlLnAUa2QAUCKwqdmQljLCIB+xUQZkRGdcR/NG4fVXqYA7nNLeK+cVwRr
 U6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703003; x=1770307803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DUXXViwauWLkh3b067d+qkCc8ZKPqxtPhuKZgFQ3Zck=;
 b=OsF1y60cEtxEXX2P4ELHWOVD2X9wg4MzuC5lsfLOCpFDwjhP6SaRFu01h0+2zLl94O
 7qwtD1HEMPl8ru5Wazee4tXiCR6/bmYJdNjxWpMyLCCiYQ+2TH74UjNPw3nB/uhIhV7b
 vu7ylCDrP54oE3c+TffXsvN0I+FeqYmKzNe93KSS04gf+J+DMkruG5oHgsVDBDtfO6mx
 30S6VCwAxdRM2yHjYQf7dpkdfCngiFaVim9Qu3Z9nm/rVe9HO5tt0LFmZXTHjnIXZzCh
 r9R+mkbpmJ2BvODYIvXzRoAXRyQESZV4UV7RRYANjBh6O2m0nsk2ACJTZQAVNRWoy7nj
 Kzsg==
X-Gm-Message-State: AOJu0Yyxhe138Cvn7leSWGBrMvwesExk4ukgZ9MXgCSzPYOTskpfPxKV
 DizL4TCRIiGT1TXbtQg0GwryhPSwt3Zs3/+an3yZcnAu3UwKFcsbPL6J/EhrNsggLwRAjbCr9mY
 zwoo/BNU=
X-Gm-Gg: AZuq6aJtWDfa3btKaqXqrLtT0GZy6yimo2ImLdbN0/XsrRZTugb8Fxislt3JfFMsMpg
 CwpzGR6qatoy4vwGqKYFXAFh4MUKiDTUxVRVY3FgVY4i7FcgOl23Rod+Am6HPq1DMA1mVzoHUn6
 NYxpH2TsXYWCb0T3ruoR3ebvnMjtprsnr6F3fv0ib4oydW820xfWEwGQ5rzeggxPqJJ7kZnte6L
 dVmB6jwCcazPmooaN3Heqs4nYcrGViIO+1V1VCJDP9cgix6cPymcByNF8DHo86cGEztHhycLN1W
 CU3L1r1P11av0miCpZxQXxdXi36SAMhhCQXCiOqxrtQMiVpuuBQ/hCPK+zS9ySiKmoJhxXDd+pP
 r3ZOid5U0gTmnmdxPulzQfGuwBbVhIRQkIyi/qF3zf8xk2MsgO06/f51v5eV0kk5sbiH9qKia3l
 gxepjmB2hhMzzI0TCCqVwg/6mZXAD5JA==
X-Received: by 2002:a05:6000:2004:b0:430:f9c2:8500 with SMTP id
 ffacd0b85a97d-435f3aae815mr144730f8f.43.1769703002868; 
 Thu, 29 Jan 2026 08:10:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/43] hw/arm/smmuv3-accel: Make SubstreamID support
 configurable
Date: Thu, 29 Jan 2026 16:09:11 +0000
Message-ID: <20260129160917.1415092-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

QEMU SMMUv3 currently reports no SubstreamID support, forcing SSID to
zero. This prevents accelerated use cases such as Shared Virtual
Addressing (SVA), which require multiple Stage-1 context descriptors
indexed by SubstreamID.

Add a new "ssidsize" property to explicitly configure the number of bits
used for SubstreamIDs. A value greater than zero enables SubstreamID
support and advertises PASID capability to the vIOMMU.

The requested SSIDSIZE is validated against host SMMUv3 capabilities and
is only supported when accel=on.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-38-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c          | 25 ++++++++++++++++++++++++-
 hw/arm/smmuv3.c                | 22 ++++++++++++++++++++--
 include/hw/arm/smmuv3-common.h |  1 +
 include/hw/arm/smmuv3.h        |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 342944da23..f5cd4df336 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -76,6 +76,16 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
         return false;
     }
 
+    /* Check SSIDSIZE value opted-in is compatible with Host SMMUv3 SSIDSIZE */
+    if (FIELD_EX32(info->idr[1], IDR1, SSIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SSIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SSIDSIZE not compatible "
+                   "(host=%u, QEMU=%u)",
+                   FIELD_EX32(info->idr[1], IDR1, SSIDSIZE),
+                   FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+        return false;
+    }
+
     /* User can disable QEMU SMMUv3 Range Invalidation support */
     if (FIELD_EX32(info->idr[3], IDR3, RIL) <
                 FIELD_EX32(s->idr[3], IDR3, RIL)) {
@@ -652,7 +662,14 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
      * The real HW nested support should be reported from host SMMUv3 and if
      * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
      */
-    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+    uint64_t flags = VIOMMU_FLAG_WANT_NESTING_PARENT;
+    SMMUState *bs = opaque;
+    SMMUv3State *s = ARM_SMMUV3(bs);
+
+    if (s->ssidsize) {
+        flags |= VIOMMU_FLAG_PASID_SUPPORTED;
+    }
+    return flags;
 }
 
 static const PCIIOMMUOps smmuv3_accel_ops = {
@@ -680,6 +697,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     if (s->oas == SMMU_OAS_48BIT) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
+
+    /*
+     * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
+     * has enabled it.
+     */
+    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
 }
 
 /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index cb02184d2d..c08d58c579 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -611,9 +611,11 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         }
     }
 
-    if (STE_S1CDMAX(ste) != 0) {
+    /* Multiple context descriptors require SubstreamID support */
+    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
-                      "SMMUv3 does not support multiple context descriptors yet\n");
+                "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
+                "Configure ssidsize > 0 (requires accel=on)\n");
         goto bad_ste;
     }
 
@@ -1954,6 +1956,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
+        if (s->ssidsize) {
+            error_setg(errp, "ssidsize can only be set if accel=on");
+            return false;
+        }
         return true;
     }
 
@@ -1968,6 +1974,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
+    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
+        error_setg(errp, "ssidsize must be in the range 0 to %d",
+                   SMMU_SSID_MAX_BITS);
+        return false;
+    }
 
     return true;
 }
@@ -2096,6 +2107,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
     DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2129,6 +2141,12 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits");
+    object_class_property_set_description(klass, "ssidsize",
+        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
+        "Valid range is 0-20, where 0 disables SubstreamID support. "
+        "Defaults to 0. A value greater than 0 is required to enable "
+        "PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index abe3565357..67a23fbeaa 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -311,6 +311,7 @@ REG32(IDR1,                0x4)
     FIELD(IDR1, TABLES_PRESET, 30, 1)
     FIELD(IDR1, ECMDQ,        31, 1)
 
+#define SMMU_SSID_MAX_BITS 20
 #define SMMU_IDR1_SIDSIZE 16
 #define SMMU_CMDQS   19
 #define SMMU_EVENTQS 19
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d488a39cd0..26b2fc42fd 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,6 +72,7 @@ struct SMMUv3State {
     bool ril;
     bool ats;
     uint8_t oas;
+    uint8_t ssidsize;
 };
 
 typedef enum {
-- 
2.43.0


