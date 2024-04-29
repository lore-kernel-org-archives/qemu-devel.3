Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE92EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hdy-000175-Pi; Sun, 28 Apr 2024 23:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3GBMvZggKCjMhbdhiPUPVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--smostafa.bounces.google.com>)
 id 1s1Hdv-0000yY-9V
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:27 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3GBMvZggKCjMhbdhiPUPVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--smostafa.bounces.google.com>)
 id 1s1Hdp-0004FO-80
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:25:27 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc743cc50a6so5826939276.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361112; x=1714965912; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=/BTFGfZ1d0gsjHHzEN1EL1O2w8u4ar4XUJHJI2pzbXc=;
 b=WayQ60qSEW9WqAAejZ9LkvBxOWEm603YWIxqkkJSfHNuPDfyL4Q2fCjPAUg0Z2F9xu
 9jYKH2QSx5KmHaXCZKtsoPv+OvB9jmMZgQYwUMiJ49dexpdFsht+LqLs+Jv2NiDdoMfA
 sczf+loYAhWNC8o5ckObEbn+tOo+tFGfk0nwidmE+LxTwJri0gr7zXS/ufvAoC5EqaE3
 6xYAoC/eua0f9BgAALIjqG/Msqa1V0PrfhozV2M7+tlX42Y7wYI9aWYwzPxuEvExXo9P
 Wcruo6J5kWbBCwTIQs0MQyJGFldQtwRFklSuCrsiIDYYhOGIVFSgqN8W/2IoFMRs8ecG
 T1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361112; x=1714965912;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/BTFGfZ1d0gsjHHzEN1EL1O2w8u4ar4XUJHJI2pzbXc=;
 b=TX8v7ndujmq6F9IeSC5k2GvXDXHlZL3jmVVD2HnqYmMP+7igMHvATeaEp0o44O+iK1
 HsWKNCsfpXT20rK3rqCgbRSKC22qrgX/yHXH9ZwOH1Fx3R9Pe00PYzE/MDZV/elFhjmf
 fV/XUDjXa0ogN1jAMzIaI6LTNMdKdR8yaBBN7D3YaTBKVJvqDnqDN42hrAZ+Yjz57CSR
 N4IL/BIRXsvTgQFLI0OTkrQZKR1Zl3wkcgiz/lK9foNU1UUzeKlhNkzOECbViQBoVLUL
 Owd85SEW7QtuFhptx+M2yAlacuaS/Gy8/iaSkK5eXEcvTbSvg56QNJ8ThFYuFbFBSrLs
 kGiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsjmLlm1eFPhJxI+xVfNWZAy3/BjGIwsj3SEvJ6hJ2j4WlnNP6zx4TUGlqwv8WG9y4TEufRLbiF5s+xd/hfVGurFnjAWc=
X-Gm-Message-State: AOJu0Yy8EfjGy57EjikGzH1oPsusr4/fLcFfh5XVknQOr479CwQPNh2H
 n8Wfbx6azr5H6ml2+n3nHTD+Je7Ptie7r0bPwEx7j8nqWvMpZTbxkRbNSqnitlh5a7z6u5rYUpc
 7RYTpviv8hQ==
X-Google-Smtp-Source: AGHT+IFFo+jlYuYjHxKJhkRV7lC/G2aM9qqbB4pNsc3sRMEJ+F0x5yqamojV8kbwertJTfE3LteXYx8IvBJ4lQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:2b0b:b0:de5:2ce1:b638 with SMTP
 id fi11-20020a0569022b0b00b00de52ce1b638mr1035935ybb.0.1714361112365; Sun, 28
 Apr 2024 20:25:12 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:24:01 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-18-smostafa@google.com>
Subject: [RFC PATCH v3 17/18] hw/arm/smmuv3: Add property for OAS
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3GBMvZggKCjMhbdhiPUPVddVaT.RdbfTbj-STkTacdcVcj.dgV@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
index 0ebf2eebcf..dd91807624 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_IDR5_OAS 4
+#define SMMU_IDR5_OAS_DEF 4 /* 44 bits. */
+#define SMMU_IDR5_OAS_MAX 5 /* 48 bits. */
 
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4ac818cf7a..39d03e7e24 100644
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
@@ -1901,11 +1903,34 @@ static const VMStateDescription vmstate_gbpa = {
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
@@ -1933,6 +1958,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_oas,
         NULL
     }
 };
@@ -1945,6 +1971,7 @@ static Property smmuv3_properties[] = {
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
2.44.0.769.g3c40516874-goog


