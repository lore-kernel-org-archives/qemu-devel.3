Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514F8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTHL3-0004DM-Cr; Mon, 15 Jul 2024 04:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ruGUZggKCgEtnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com>)
 id 1sTHL1-00045Q-GF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:39 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ruGUZggKCgEtnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com>)
 id 1sTHKz-00041y-Rn
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:45:39 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e03a434e33cso7257998276.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1721033135; x=1721637935; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=efuWH9iEl5hVtqwexwkMil4Lcb9Um4BJHv2cntoMT6E=;
 b=15pod+oaVPLB41UUH0ZIQlShYVZuCpZOh0poKx/oU8wDGkolIz4OIKKk/neItkUcga
 t3Ta5L7UPFLOcQvI/JE559xrPiGXQAvq9slrsSVaegYynVAZTBPuTi8RyeGNHj6NCmt7
 nNvOmixdh3gpZl7J4LqcBkolhYdujlwjpx5s1q/j+6tfbbaskYlU1Nq5IsJTvGRsQpsC
 2GkomXo4+U6UJGO0FZ6mK6WP0dGynNVDOd9N2ZDRRE0lFM5Jhg5CT0zeNtzLVw+DTy7l
 o40g0/cRPWzrp21v85Ea5Czyg3MZqrU8uke6GArGfDg/gp3naLHi9qfGbfakPsOHuQ4c
 4kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033135; x=1721637935;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=efuWH9iEl5hVtqwexwkMil4Lcb9Um4BJHv2cntoMT6E=;
 b=Y1HI4mZ+5m52NVwzm+s6PSqebKjtFF4NhGC0tSIYLBIZ8A83m4szxEqN7PpgPHUj49
 shW3wOCY6vHXVfqNquKatZbj601crpKija8PI+cCtUPwRx6UNqAwCH+xXVUCpPbG9O1V
 70cV2bvE/aIXBQw6phd4IMMep2mS40z6Z5J4Cw6ugZPrmIPtqXxhDkJeZXpl16g2ItQl
 rRbxCRwvdvAYvC/x0hQqDnigUnE+NRehKiJnK78o54K5OISC6Sxdd2BX9WbVjKJ+Qfh3
 VBU3dKDDKhmb6LC0KejuZCbhFFhOFzpIpcT3sv4X/bKkTcHqdX9scdVWdFWiKcQkw3A0
 l1Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCXaBZM2EO6+5Bg0duxkodDrcXLg2ThTRSKr/i2TCq8m+R1qlIWKuAvAx+fTLn/FYoXIcKdcsR2dA7TzrZdWb3Q0mbu/g=
X-Gm-Message-State: AOJu0YwCm5VV+kl9ZffSLncEs+c0VQdm9yqFW5XCT8T9iLsq0o1omYwW
 BnnbgHp7J/r9asW4MjABU4hlG9vT5YAJtO10vRrnBgc2ydZL+9hxDOfig48EketxG4MRwLCsz1M
 fCJ3vr/E8ug==
X-Google-Smtp-Source: AGHT+IECRNkDx3NAXrgUapXDLG6Uc0kQFBcXu+5LQvWLlm3BdoPhQmW6DGCjCxaUucD//bKKbJZhqppR5xC6tQ==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:6902:1887:b0:e02:5b08:d3a with SMTP
 id 3f1490d57ef6-e041af3e444mr46942276.0.1721033134922; Mon, 15 Jul 2024
 01:45:34 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:45:03 +0000
In-Reply-To: <20240715084519.1189624-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240715084519.1189624-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240715084519.1189624-4-smostafa@google.com>
Subject: [PATCH v5 03/18] hw/arm/smmuv3: Fix encoding of CLASS in events
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3ruGUZggKCgEtnptubgbhpphmf.dpnrfnv-efwfmopohov.psh@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
class of events faults as:

CLASS: The class of the operation that caused the fault:
- 0b00: CD, CD fetch.
- 0b01: TTD, Stage 1 translation table fetch.
- 0b10: IN, Input address

However, this value was not set and left as 0 which means CD and not
IN (0b10).

Another problem was that stage-2 class is considered IN not TT for
EABT, according to the spec:
    Translation of an IPA after successful stage 1 translation (or,
    in stage 2-only configuration, an input IPA)
    - S2 =3D=3D 1 (stage 2), CLASS =3D=3D IN (Input to stage)

This would change soon when nested translations are supported.

While at it, add an enum for class as it would be used for nesting.
However, at the moment stage-1 and stage-2 use the same class values,
except for EABT.

Fixes: 9bde7f0674 =E2=80=9Chw/arm/smmuv3: Implement translate callback=E2=
=80=9D
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h | 6 ++++++
 hw/arm/smmuv3.c          | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e4dd11e1e6..0f3ecec804 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -32,6 +32,12 @@ typedef enum SMMUTranslationStatus {
     SMMU_TRANS_SUCCESS,
 } SMMUTranslationStatus;
=20
+typedef enum SMMUTranslationClass {
+    SMMU_CLASS_CD,
+    SMMU_CLASS_TT,
+    SMMU_CLASS_IN,
+} SMMUTranslationClass;
+
 /* MMIO Registers */
=20
 REG32(IDR0,                0x0)
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 9dd3ea48e4..3d214c9f57 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -942,7 +942,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             event.type =3D SMMU_EVT_F_WALK_EABT;
             event.u.f_walk_eabt.addr =3D addr;
             event.u.f_walk_eabt.rnw =3D flag & 0x1;
-            event.u.f_walk_eabt.class =3D 0x1;
+            /* Stage-2 (only) is class IN while stage-1 is class TT */
+            event.u.f_walk_eabt.class =3D (ptw_info.stage =3D=3D 2) ?
+                                         SMMU_CLASS_IN : SMMU_CLASS_TT;
             event.u.f_walk_eabt.addr2 =3D ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
@@ -950,6 +952,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr =3D addr;
                 event.u.f_translation.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_translation.rnw =3D flag & 0x1;
             }
             break;
@@ -958,6 +961,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr =3D addr;
                 event.u.f_addr_size.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_addr_size.rnw =3D flag & 0x1;
             }
             break;
@@ -966,6 +970,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr =3D addr;
                 event.u.f_access.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_access.rnw =3D flag & 0x1;
             }
             break;
@@ -974,6 +979,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr =3D addr;
                 event.u.f_permission.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_permission.rnw =3D flag & 0x1;
             }
             break;
--=20
2.45.2.993.g49e7a77208-goog


