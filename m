Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7C2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGT-0006Bv-5d; Sun, 05 Oct 2025 15:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFv-0004qQ-Kq
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFu-0006gr-2b
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obTUsxxrjlh7aQvvij2ziCsIh2EBRs8F88q8/z1GRt4=;
 b=GrUDUa4MCGRRS7T+8lfDpcS6lpVyWy5j9nuRiUgAbnA+v+RVy77tmNScIrKeSSB5ej+bB7
 nwEABCtkRqJPEWe5PqRB0H+iUBEHxisGL0jJWNr0jVRvw+M+yXldTCG6PEOAkf8Lfr5usX
 hM8gh5MPofDAtErfPUiFCFKWkYi4oUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-b_JwMbsFN3OZvfxgeaO6Yw-1; Sun, 05 Oct 2025 15:18:47 -0400
X-MC-Unique: b_JwMbsFN3OZvfxgeaO6Yw-1
X-Mimecast-MFC-AGG-ID: b_JwMbsFN3OZvfxgeaO6Yw_1759691926
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e39567579so18717225e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691926; x=1760296726;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=obTUsxxrjlh7aQvvij2ziCsIh2EBRs8F88q8/z1GRt4=;
 b=VrFm4amiGW1nPVd2U8VaClD/YPuEehO1dRbcJ3J/UW3Qc0TWhjAvgWUk5Z+BjNfhX7
 E+UYZd3fzGIw13rBICaTWbjfBvWydFR8D6KLoBznd/URZOeyKGKg0wZeeVjaqOnXJ6dw
 +Mi+yVwnLC7KpVJMVGO4q96AyX4xBKB0GhmH7qcx659zPUiNHATdMi2LccsqteoXxBZ0
 lNbIP0tDe4UaLuN0QkZ3OPakZ5Upuenqyvn+d9vD109zTZ7m17jgZNMfFKaGzkq6UMR0
 4gZPYViiw4qs0Ak4YERE2ccwqOPi+MPPlrT6vAAjg2YaNebAhYC5TNlM6XXRQ/pcCr4L
 LpNQ==
X-Gm-Message-State: AOJu0YymkHUqXeaiw7fF6LQbnnstxP6PT6c1qgvO9Xg3gyahrDuRyyd3
 ovu2VW0PQWos6hiwP383fBzuI1buu92rd0QMk92KubWluvOGh679UKu/Px98W9T/LLLQC/V5HJu
 q722yokJBeOQMkT1qfZ3yoBCBgFyl8sj45bYH2x22lK7CvCLVGMovpEmdZtoV/pUTGi57XzO+yG
 WvUU7TXQOBtnYnskqRzRGG5mMcpnxryq9O9Q==
X-Gm-Gg: ASbGncui32gTA0o3g6jEGQQPaSu5dwFnLeab0vp40yJxUHyZLTNKdFgH7UQJvug9ggr
 59GVWOu194QcVBJa3kN8ObWP5x/K2i8srR3K1ipDMJBFR6pKr3vcJmNCXxlCYWdLvYshJFd3Z1+
 Gpl8ClnDwpga4pTuLqjFbfz//yQ2uvjHyk0oVEH2UCkT3tKY04nrPjnTAj1u5ZmQDHcCuUCzh/V
 3iFQJwLR/NDfFWpD+V6LEBitXZeEtEJERTlwih2LQr0IaAkPGLFBYdfC+/DUfPbtJ89HnVqU3Iv
 fia3HXIxN86nnIWJS82Lm0TDp+yxM/IFn7VBYLE=
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46e74cc4609mr51037755e9.17.1759691925547; 
 Sun, 05 Oct 2025 12:18:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3b8UNRIUlz/l7Hjal07dfYT6s313t1JItGYWTgsWam82yO9GgutgfMoSPHevyfoVSOvDjJA==
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id
 5b1f17b1804b1-46e74cc4609mr51037595e9.17.1759691925080; 
 Sun, 05 Oct 2025 12:18:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46f9c8873f1sm22294475e9.8.2025.10.05.12.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:44 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 73/75] intel_iommu: Enable Enhanced Set Root Table Pointer
 Support (ESRTPS)
Message-ID: <3dfe95622ad5bf9dc6fb9bb0f74605aa07d2d3f7.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

According to VTD spec rev 4.1 section 6.6:
"For implementations reporting the Enhanced Set Root Table Pointer Support
(ESRTPS) field as Clear, on a 'Set Root Table Pointer' operation, software
must perform a global invalidate of the context cache, PASID-cache (if
applicable), and IOTLB, in that order. This is required to ensure hardware
references only the remapping structures referenced by the new root table
pointer and not stale cached entries.

For implementations reporting the Enhanced Set Root Table Pointer Support
(ESRTPS) field as Set, as part of 'Set Root Table Pointer' operation,
hardware performs global invalidation on all DMA remapping translation
caches and hence software is not required to perform additional
invalidations"

We already implemented ESRTPS capability in vtd_handle_gcmd_srtp() by
calling vtd_reset_caches(), just set ESRTPS in DMAR_CAP_REG to avoid
unnecessary global invalidation requests of context, PASID-cache and
IOTLB from guest.

This change doesn't impact migration as the content of DMAR_CAP_REG is
migrated too.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250929034206.439266-2-zhenzhong.duan@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 0d0069a612..0f6a1237e4 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -215,6 +215,7 @@
 #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
 #define VTD_CAP_FS1GP               (1ULL << 56)
+#define VTD_CAP_ESRTPS              (1ULL << 63)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 #define VTD_PASID_ID_SHIFT          20
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fa2ad9c2eb..0378551038 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4660,7 +4660,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
-             VTD_CAP_MGAW(s->aw_bits);
+             VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (s->dma_drain) {
         s->cap |= VTD_CAP_DRAIN;
     }
-- 
MST


