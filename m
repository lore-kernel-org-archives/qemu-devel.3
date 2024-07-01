Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8978C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEoe-00025S-N7; Mon, 01 Jul 2024 07:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38YyCZggKClAA46ABsxsy66y3w.u648w4C-vwDw3565y5C.69y@flex--smostafa.bounces.google.com>)
 id 1sOEob-00024d-0m
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:22 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38YyCZggKClAA46ABsxsy66y3w.u648w4C-vwDw3565y5C.69y@flex--smostafa.bounces.google.com>)
 id 1sOEoV-0005Fk-09
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:03:19 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e034f972e8bso4906937276.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719831793; x=1720436593; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=wqwMFjuNcPNQgfmtUIfkUcIllMEdFf4XaEpH+L83rCQ=;
 b=zkMFpZT53BIUWHd1230ZyO7PHSqNuVL04YjqWqgG+ea33ZHJkgSo28jKaskv8n1DVc
 lkkvH28+rWO058zXs5RFz9NogtmqUefaIr0ltVPcBcBm0ecTW1Fl2IJMROXLAeed4J4k
 DTEhRI48Vm8HfYspTGGBn0u2iMc+IFMQtITdf0NXfkSw8eptNKfLdmI6xRFQYE5JfUiH
 opu4IAUCUSoIEMdOsIeLy0CbPJsHoMHeYZ5RplZPx2UY5H18Ast50i47EMsUuxq2M2wE
 5WhJBoQiDqH5Wmlvn1rjAtrb9r4TDx/Zn6D8Mh/Idw0YNXnBZobDKiWLEUvAZdSxXkWq
 bAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719831793; x=1720436593;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wqwMFjuNcPNQgfmtUIfkUcIllMEdFf4XaEpH+L83rCQ=;
 b=pKrkK/eC7XbtpubHl6I+Sm3sTcUUNQxTIJGsdrJeKg9kLK/Q5LkzzzzdSXrOiPgcWt
 lVGp9M3MTbrmgmJhA78QosheT+6lDmHGNGEKCCPMHLirarvATRUF1lU5gZ9vqpp/6t30
 82D86FVa09yF9pUCYOBYvTFTImnTC21qthas++XuXnHcSh4t0zoBtRVfr3Z/6lSApR3m
 qrBakPA6chD/8tWDnteSS9kgYCCVM3czI/CiBhJxGSwJcgdXdsgdC7+Z3F6klmUjbNJC
 7nbaTE7KthY3/FMgHTttH/0NQXTtK20EfRwkhT2WmykbnXhfodTXR5f7iCj6kG6dh7mB
 if7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMXTd9ncrdDOkTNe0poSgal32ifk/PQd+qvcuQh5PLf8y6tpX60BPPyNFXLDs6Yk9ucmDA5RuQBm8dQdKdd2pMrUeygL0=
X-Gm-Message-State: AOJu0Yxl0BthSVQnnU2H6xC6DLrIyNbfUy9o2MU3O44qbvIX3d7kxVqo
 aTqJDpmEkZkZHKBJAtVS3fiivLMznY0TwwPaowTP399/4PDSyj9a3QTT5SY8zQ5BqWmV3PhKdl1
 7fSX4e00yFw==
X-Google-Smtp-Source: AGHT+IFA6H4WgylxWuZ+vt+/5n12yS4Zs2Xmd4MvpuDIDP+VuDP/DcgmBSLwr15ZoAgCBmR3gJWgFhmpdDH53g==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:c802:0:b0:e03:62dc:63de with SMTP id
 3f1490d57ef6-e036eb27486mr333339276.6.1719831793563; Mon, 01 Jul 2024
 04:03:13 -0700 (PDT)
Date: Mon,  1 Jul 2024 11:02:25 +0000
In-Reply-To: <20240701110241.2005222-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240701110241.2005222-1-smostafa@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701110241.2005222-4-smostafa@google.com>
Subject: [PATCH v4 03/19] hw/arm/smmuv3: Fix encoding of CLASS in events
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=38YyCZggKClAA46ABsxsy66y3w.u648w4C-vwDw3565y5C.69y@flex--smostafa.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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

The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
class of events faults as:

CLASS: The class of the operation that caused the fault:
- 0b00: CD, CD fetch.
- 0b01: TTD, Stage 1 translation table fetch.
- 0b10: IN, Input address

However, this value was not set and left as 0 which means CD and not
IN (0b10).
While at it, add an enum for class as it would be used for nesting.
However, at the moment stage-1 and stage-2 use the same class values.

Fixes: 9bde7f0674 =E2=80=9Chw/arm/smmuv3: Implement translate callback=E2=
=80=9D
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 hw/arm/smmuv3-internal.h | 6 ++++++
 hw/arm/smmuv3.c          | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 9dd3ea48e4..1eb5b160d2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -942,7 +942,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
             event.type =3D SMMU_EVT_F_WALK_EABT;
             event.u.f_walk_eabt.addr =3D addr;
             event.u.f_walk_eabt.rnw =3D flag & 0x1;
-            event.u.f_walk_eabt.class =3D 0x1;
+            event.u.f_walk_eabt.class =3D SMMU_CLASS_TT;
             event.u.f_walk_eabt.addr2 =3D ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
@@ -950,6 +950,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr =3D addr;
                 event.u.f_translation.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_translation.rnw =3D flag & 0x1;
             }
             break;
@@ -958,6 +959,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr =3D addr;
                 event.u.f_addr_size.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_addr_size.rnw =3D flag & 0x1;
             }
             break;
@@ -966,6 +968,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr =3D addr;
                 event.u.f_access.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_access.rnw =3D flag & 0x1;
             }
             break;
@@ -974,6 +977,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion=
 *mr, hwaddr addr,
                 event.type =3D SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr =3D addr;
                 event.u.f_permission.addr2 =3D ptw_info.addr;
+                event.u.f_translation.class =3D SMMU_CLASS_IN;
                 event.u.f_permission.rnw =3D flag & 0x1;
             }
             break;
--=20
2.45.2.803.g4e1b14247a-goog


