Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CEDC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHL0-0003zH-15; Mon, 15 Jul 2024 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rOGUZggKCv0xrtxyfkflttlqj.htrvjrz-ij0jqstslsz.twl@flex--smostafa.bounces.google.com>)
 id 1sTHKy-0003vP-Lu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:36 -0400
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rOGUZggKCv0xrtxyfkflttlqj.htrvjrz-ij0jqstslsz.twl@flex--smostafa.bounces.google.com>)
 id 1sTHKw-00041c-TR
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:36 -0400
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-42668796626so29155845e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033132; x=1721637932; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=HauqpspRGzaWiC+Y5wBwhzngUip4YeSIv/BXthOH49g=;
 b=NBI99Vc3vGk1FbVBEA0Kzi31GR0Ir/zxFsJLNZCxraMHreqYilqujBPsA3LID3fSQA
 ZmkStK6f8EH62ym0ktXqBgzsNqPhXwcsJjGfrE04eKfWNhZiCd43BDahPZKVo3J4q2hV
 g3EA1unOo9tn5xBtMEROH70+6boxZoCnrx/Q5hFoC0e5eG6ulk0VLYL2z3K1S+AlX6dL
 eEgrR1jDZPhmyzsl0UCfkDZGusIgAehyiYyKt8l6mJ5tLvHfGh49gM+HHSSsLiOJ8h7Y
 UNxwl/hG5TBpM2OD8FsmUDc/E17ZDvLQHIrDFE8UDBJD8IEim0OXavH/mxzrPJbqgpaw
 /y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033132; x=1721637932;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HauqpspRGzaWiC+Y5wBwhzngUip4YeSIv/BXthOH49g=;
 b=Pu5T9zO9yvTU1M/1VaresDjq5C1wIhN7QiZM1OlaRdpnGmXYqyWCffkP7Ocv3sajcu
 Dbn2C6rL1MQuhHazXphu9SR/qkzgEQtVGzsIKufLCOL1UIk+Z3xqz4m9r+J3DzC2ubp5
 QS0OyAa8qHswQs6SSWBt8rfkFOe7E9SaVNiuFuNgVze1pJwf0DCZKLlZmvmVU/1UcIYs
 bS5LrYhoIP9lFnLWYjYwbtT1LZ9SC2UIeD/oYpo2MvSfteLrfZxKvC3C22nmmkw4haps
 vAArImxJBkkhTN19MeHB2VgrDP6mvWroW+MWoPsXLE7mClbzubEWsecNlGT8KqkZIXqV
 lnzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGubfzTJwqXDZOUobBBYoSW3rRef80GLuZ81sMf/CCEXpwwW0sDwf8i1CL8bcYaTNWIqdB/dmPVo1yOzBw4gm+rMN0a4I=
X-Gm-Message-State: AOJu0YxvfOh4vnRdmBjAoPc9dj6TkyQ9/OPaFjrJ1NuU3A15YKhaic1u
 8PaK1OzaYkyDbkkj1PZmLqgffl0weqznwWFp53n7YFEeY3Utwaf/SdvvSiJsl/SV2eW58bytvO/
 6EWB8C5KnKA==
X-Google-Smtp-Source: AGHT+IEVZI0lwci5jXrZC/bDA9IrqvrdR79+qlyLo6LTG4FAUay3uxlwg0Akz+mtF5A6NOiyImgFlj35MpWwEg==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:3b8a:b0:426:6668:d45 with SMTP
 id 5b1f17b1804b1-426708ef826mr932405e9.3.1721033132428; Mon, 15 Jul 2024
 01:45:32 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:02 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-3-smostafa@google.com>
Subject: [PATCH v5 02/18] hw/arm/smmu: Fix IPA for stage-2 events
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3rOGUZggKCv0xrtxyfkflttlqj.htrvjrz-ij0jqstslsz.twl@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For the following events (ARM IHI 0070 F.b - 7.3 Event records):
- F_TRANSLATION
- F_ACCESS
- F_PERMISSION
- F_ADDR_SIZE

If fault occurs at stage 2, S2 =3D=3D 1 and:
  - If translating an IPA for a transaction (whether by input to
    stage 2-only configuration, or after successful stage 1 translation),
    CLASS =3D=3D IN, and IPA is provided.

At the moment only CLASS =3D=3D IN is used which indicates input
translation.

However, this was not implemented correctly, as for stage 2, the code
only sets the  S2 bit but not the IPA.

This field has the same bits as FetchAddr in F_WALK_EABT which is
populated correctly, so we don=E2=80=99t change that.
The setting of this field should be done from the walker as the IPA address
wouldn't be known in case of nesting.

For stage 1, the spec says:
  If fault occurs at stage 1, S2 =3D=3D 0 and:
  CLASS =3D=3D IN, IPA is UNKNOWN.

So, no need to set it to for stage 1, as ptw_info is initialised by zero in
smmuv3_translate().

Fixes: e703f7076a =E2=80=9Chw/arm/smmuv3: Add page table walk for stage-2=
=E2=80=9D
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
2.45.2.993.g49e7a77208-goog


