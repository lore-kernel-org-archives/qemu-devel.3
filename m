Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF04CD1297
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtphc-0000PC-KQ; Mon, 08 Apr 2024 10:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3l_oTZggKChQC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1rtpgv-0007Fb-Nt
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:49 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3l_oTZggKChQC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com>)
 id 1rtpgh-0001Ox-44
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:45 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-3455cbdea2cso727365f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585367; x=1713190167; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0HFXPBczsaFzwM3/E8nUe7UI7cqODAn7zmH22JOuPig=;
 b=yTjpNFWDp7EDhfj/nHTOZLKFUfjwHNbDKpdp70+7wpzkRRM4XqWCa3+NE1AhUb/p+L
 /vJkP+WnwXqBpCl9bu2AWvTWAIdD/if6PGNj4yhXHbU606j3liZQj3OkHegp2nzmv4Cm
 BsmLiq2TS7wNpxEMuIXwvxdxxJV+rypSLtW1d8HLKF89YwIYFiwiX8vHxJAMJtnuqd95
 3Xg8GgXr5JkX86grFFLbQdaSPPn5TwDK/Ak9XAmUs+R5dIzVvQP7SyCrKo6O0KBLJQ5q
 m0iX6DcIbWR1i0qeuPzFQi90/h/yO9OctGEzIh7HhGce4rmkpp9YvvhwN8kHZJJSxmWy
 zvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585367; x=1713190167;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0HFXPBczsaFzwM3/E8nUe7UI7cqODAn7zmH22JOuPig=;
 b=rjEa32J2bq5JV49/6Yk/1QjTRvKxMhZCuiv/1vggqS3Fg+d0Rojb8ZuurLM+RxSRdz
 ffGLVFVpoHU09s8m1e1CNYzCWxwN4Mhl/KRmIC+uI/9be0955tZmcJwLiEHWKjWkMWH+
 iuUdAYFv9UZL/u/Yo9X7bJyDkOEXJvVWsvaw4m9aL7vSfr7koOlkTuwzJgGhq2RerU8o
 iDC9kJm/FARQUme4ix1Zyx+OBfyaDllc9CS5toC063sTFJyUBOTQagYZBkttPGhaI7tb
 KiIWDKnGvPU835KEJiEpEoGosV0HmmRguWzXxCZ8taKuG4BbLus7tPA3AHwLlx/2Pu+f
 AxOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ZdXkIAb8WBsC240mSp+EiP7juZdRgzHSGRoDWzIkePo2elSCPYgRPK7lPWFDCBrumjkB6GMqKEN/rMvQ+vLnzVvAwsY=
X-Gm-Message-State: AOJu0YzEnpW/bUBzNp/Q+fEZx1NHLL/K7BTdoE7RsN9o1eqmxDD/k1GG
 gqQ7ZbmBlIZHFkbuYCIuK8vEvd9B3l31Fcj7KQqZwznqR7mQO0HGqhjwFNOVrAfL5jMOKXwOcRE
 ZkPiIRyDRzw==
X-Google-Smtp-Source: AGHT+IE7kCfdgL08HfEqucyFWrSJbWPjvekE7QrePaAghtRgm0vvVoGNYz6lmTGoMFN28/lVMU0gfGcPCY6egg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a5d:6f0d:0:b0:343:ecac:5ffc with SMTP id
 ay13-20020a5d6f0d000000b00343ecac5ffcmr116195wrb.7.1712585367719; Mon, 08 Apr
 2024 07:09:27 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:17 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-13-smostafa@google.com>
Subject: [RFC PATCH v2 12/13] hw/arm/smmuv3: Add property for OAS
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3l_oTZggKChQC68CDuzu08805y.w86Ay6E-xyFy578707E.8B0@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add property that sets the OAS of the SMMU, this in not used in this
patch.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h |  3 ++-
 hw/arm/smmuv3.c          | 29 ++++++++++++++++++++++++++++-
 include/hw/arm/smmuv3.h  |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b0d7ad6da3..41612bb9ff 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -105,7 +105,8 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_IDR5_OAS_DEF 4 /* 44 bits. */
+#define SMMU_IDR5_OAS_MAX 5 /* 48 bits. */
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c377c05379..a9e35c41b7 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -299,7 +299,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
 
-    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
+    /* PTW doesn't support 52 bits. */
+    s->oas = MIN(s->oas, SMMU_IDR5_OAS_MAX);
+    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, s->oas);
     /* 4K, 16K and 64K granule support */
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
     s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
@@ -1878,11 +1880,34 @@ static const VMStateDescription vmstate_gbpa = {
     }
 };
 
+static const VMStateDescription vmstate_oas = {
+    .name = "smmuv3/oas",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(oas, SMMUv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static int smmuv3_preload(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    /*
+     * In case it wasn't migrated, use the value used
+     * by older QEMU.
+     */
+    s->oas = SMMU_IDR5_OAS_DEF;
+    return 0;
+}
+
 static const VMStateDescription vmstate_smmuv3 = {
     .name = "smmuv3",
     .version_id = 1,
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
+    .pre_load = smmuv3_preload,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(features, SMMUv3State),
         VMSTATE_UINT8(sid_size, SMMUv3State),
@@ -1910,6 +1935,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_oas,
         NULL
     }
 };
@@ -1922,6 +1948,7 @@ static Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    DEFINE_PROP_INT32("oas", SMMUv3State, oas, SMMU_IDR5_OAS_DEF),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index d183a62766..00a9eb4467 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    int32_t oas;
 };
 
 typedef enum {
-- 
2.44.0.478.gd926399ef9-goog


