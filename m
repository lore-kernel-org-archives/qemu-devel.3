Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE50C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HdA-0000HG-Re; Sun, 28 Apr 2024 23:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39BIvZggKCg871378pupv33v0t.r315t19-stAt0232v29.36v@flex--smostafa.bounces.google.com>)
 id 1s1HdA-0000H5-3l
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:40 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39BIvZggKCg871378pupv33v0t.r315t19-stAt0232v29.36v@flex--smostafa.bounces.google.com>)
 id 1s1Hd8-0003wH-Ga
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 23:24:39 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-de5823bd7eeso8614280276.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 20:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714361077; x=1714965877; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=ugfwhxHAsXX+l79VAWHM6i77oS3L6rsnMUucApsxZzg=;
 b=bdGVMcHgFLDN6K8Ns7XRiRCtHohgDOePVeFx56zNCMdCJcMTVmDLK4B8M3216bZ/I9
 YBsASJYPa2x0tYImQBHyQ9yEhcOva9Qd6AFl+SUatLxkuPjU0p9lX9jsbz9IjZSx6xbm
 jGNP3PieThb4vCVVDnBBfQmIA5feNfdlZ8/woXYTGTATaDV8oErarWsFx6wz3paZkaL0
 rBfNMrAwoCsRSXIftE7dY+l9KQ6x9qwLTWIbsguc/E+RrKUU1aqVTwxtz/7zn6c7A19V
 t45KvMQYonSVO5OGxxOyejPQe3RddX+q6/fbMG/8ytW2OT5HBmYCpkU5ybdpFl+pgZ0M
 U80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361077; x=1714965877;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ugfwhxHAsXX+l79VAWHM6i77oS3L6rsnMUucApsxZzg=;
 b=NpgQK8o8lVx56/bbWr6LRPYn6NYnmzc0afudcNWtRmmPXXLT1wqb/5MVUyb0f20lmP
 gEQL1CortbGPAjw+pvxIS9pkAFbrbzY/144Ez60aPbQe1pzMPNc8XKv8fDZ4XiT1JWsq
 RjVcmcDDFhHwstBgwJ0sIMvlnNN0iPh4a1Xwqjp214jFD6wT4UR+HBMGh4pqUAGrzAQM
 yPm8SVa2/OJXR6VXuRNqDJZdV/BPdFLghCh24gdcm7uyRhdO7sde88LX8f3b1q5PVkDq
 sIwZYvSdVMNDa3hQDED/BrE94ID0dRROrhMoC7fYQuGGRCYbVMstIvEULBrWpYdX57+q
 ZMRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWThWYMYMkyjY/Eh9QOmK5JpMJ+5MvmjyyU14TUOGkU906n16pAOoe1xMD7oXgemGGX62zUJ41Lml0zQp6uwV1fVgyVWcE=
X-Gm-Message-State: AOJu0Yy7I1hbIQO5pZdm/U/N6sNwyd3YCaQLtn98eeiqWywMbB46zvDD
 SnQTueMXIzSIgiz9a6cb5+Y4P9OFrgYNwfpcj+5mhAT/sKEia13iDHXeA/irB1q30dr+qMw0poC
 QxoU8VfkLrA==
X-Google-Smtp-Source: AGHT+IFT1m+wr9CErBEVDle49lV24xJJx2yoZ99l6OA47y92q4ouiYI0DmzSlqkA21/FF1Ru6Sx49cn5K2+I1w==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:2288:b0:de5:a77e:f9bd with SMTP
 id dn8-20020a056902228800b00de5a77ef9bdmr1632054ybb.6.1714361076658; Sun, 28
 Apr 2024 20:24:36 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:23:46 +0000
In-Reply-To: <20240429032403.74910-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240429032403.74910-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429032403.74910-3-smostafa@google.com>
Subject: [RFC PATCH v3 02/18] hw/arm/smmu: Fix IPA for stage-2 events
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=39BIvZggKCg871378pupv33v0t.r315t19-stAt0232v29.36v@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

For the following events (ARM IHI 0070 F.b - 7.3 Event records):
- F_TRANSLATION
- F_ACCESS
- F_PERMISSION
- F_ADDR_SIZE

If fault occurs at stage 2, S2 =3D=3D 1 and:
  - If translating an IPA for a transaction (whether by input to
    stage 2-only configuration, or after successful stage 1 translation),
    CLASS =3D=3D IN, and IPA is provided.

However, this was not implemented correctly, as for stage 2, we Qemu
only sets the  S2 bit but not the IPA.

This field has the same bits as FetchAddr in F_WALK_EABT which is
populated correctly, so we don=E2=80=99t change that.
The population of this field should be done from the walker as the IPA addr=
ess
wouldn't be known in case of nesting.

For stage 1, the spec says:
  If fault occurs at stage 1, S2 =3D=3D 0 and:
  CLASS =3D=3D IN, IPA is UNKNOWN.

So, no need to set it to for stage 1, as ptw_info is initialised by zero in
smmuv3_translate().

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmu-common.c | 10 ++++++----
 hw/arm/smmuv3.c      |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index eb2356bc35..8a8c718e6b 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -448,7 +448,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
      */
     if (ipa >=3D (1ULL << inputsize)) {
         info->type =3D SMMU_PTW_ERR_TRANSLATION;
-        goto error;
+        goto error_ipa;
     }
=20
     while (level < VMSA_LEVELS) {
@@ -494,13 +494,13 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
          */
         if (!PTE_AF(pte) && !cfg->s2cfg.affd) {
             info->type =3D SMMU_PTW_ERR_ACCESS;
-            goto error;
+            goto error_ipa;
         }
=20
         s2ap =3D PTE_AP(pte);
         if (is_permission_fault_s2(s2ap, perm)) {
             info->type =3D SMMU_PTW_ERR_PERMISSION;
-            goto error;
+            goto error_ipa;
         }
=20
         /*
@@ -509,7 +509,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
          */
         if (gpa >=3D (1ULL << cfg->s2cfg.eff_ps)) {
             info->type =3D SMMU_PTW_ERR_ADDR_SIZE;
-            goto error;
+            goto error_ipa;
         }
=20
         tlbe->entry.translated_addr =3D gpa;
@@ -522,6 +522,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
     }
     info->type =3D SMMU_PTW_ERR_TRANSLATION;
=20
+error_ipa:
+    info->addr =3D ipa;
 error:
     info->stage =3D 2;
     tlbe->entry.perm =3D IOMMU_NONE;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2d1e0d55ec..9dd3ea48e4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -949,6 +949,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type =3D SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr =3D addr;
+                event.u.f_translation.addr2 =3D ptw_info.addr;
                 event.u.f_translation.rnw =3D flag & 0x1;
             }
             break;
@@ -956,6 +957,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type =3D SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr =3D addr;
+                event.u.f_addr_size.addr2 =3D ptw_info.addr;
                 event.u.f_addr_size.rnw =3D flag & 0x1;
             }
             break;
@@ -963,6 +965,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type =3D SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr =3D addr;
+                event.u.f_access.addr2 =3D ptw_info.addr;
                 event.u.f_access.rnw =3D flag & 0x1;
             }
             break;
@@ -970,6 +973,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type =3D SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr =3D addr;
+                event.u.f_permission.addr2 =3D ptw_info.addr;
                 event.u.f_permission.rnw =3D flag & 0x1;
             }
             break;
--=20
2.44.0.769.g3c40516874-goog


