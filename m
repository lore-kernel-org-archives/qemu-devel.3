Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD4CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7re-0003W7-DM; Wed, 15 Jan 2025 13:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7px-00074I-EE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pv-0006gp-UB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jraWayqR6S0TF4m7yuNwt/0UGk8nDQ+cyMTXQFXBV8=;
 b=LbFv8hrVQ05IUnsEp3oUFt6zOPkuYdECdHVCG8NTHm099n+zQehqFDIxJAQVEnTOelvpSV
 RBkyzOKCHUnhziT1vHDLJOsql6r7HoQqe4lfPf3mY0Io7PyVjCVXfYqv/k3ZHfqZZLcY9J
 dE0DQpA+cvvTvHeMi23oE0SV9ReCPHM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-1Xzz5eM4PiCnCvL4UM0pRA-1; Wed, 15 Jan 2025 13:09:48 -0500
X-MC-Unique: 1Xzz5eM4PiCnCvL4UM0pRA-1
X-Mimecast-MFC-AGG-ID: 1Xzz5eM4PiCnCvL4UM0pRA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43628594d34so39267705e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964586; x=1737569386;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jraWayqR6S0TF4m7yuNwt/0UGk8nDQ+cyMTXQFXBV8=;
 b=A8bpdy7RVmruy4VmihymiYQQs9mZDC5Jxlasv6btud8wRDoiPxVunrQRBe2VPxFTJj
 2Zk9+qklb90BOM2o196+J1ihHEvq/wDjkuL7jXukSOzxGzUkEuhqCwLUtp+v+tIG1YeT
 ivAQxRWmBbinv6QuD/mZ6INK6DX5LKI2R3hu2ZJDeBSaOarg1t0HLzpRUNEraZwX5XUq
 iGexKKi991hb+vAkLafb+FqV3B4qJFUVFTHP3o0TSN3FZn9NLh7uLuFcpYl4b1GiA5b2
 NcJ1V4TuLjg51Ofwa9KIAiQWNkNe3ykkUnG1pttOp+9dBdAXVM6jAgs5G6fY9PXGYI7G
 dmRw==
X-Gm-Message-State: AOJu0Yyi0rYCUf22YnEFP+9gznbabHUnQBdyJ+3UCKSNJ+LAdP49rujm
 7Rye2o1yJeVKhBX0JU69r6XggVYjlw59+ORFH53o4KTgtnX7cC2VJ7eYpe40At/JJIGkjKXyInp
 06clLVCgXyIG1hTb4nBONxvmJE/73k1/xZAIW78CsRJTbOc6WhzwiG69n31XTik5uDCLje/42Ea
 7qohq+rRytMHNXHl647oQ9cusMo+t+Pw==
X-Gm-Gg: ASbGncuFxBikJ6qiLv4b7tvZuN1lA9UbuUN/WQK6qjq4PuTcKA0usKDexRBeNeDqp3g
 1IeclZGzG9xuH+G2J52PaPYAd9vLN8qC0MOc3+uSIFeCEuWvdMpqGOiqQjR6KP+svAqMOefFVIh
 ZTxQJZ4baHi4yiRYOcT+nvwv0l03vcosBJnUz7WymqYHvi7+BWZkrtWP4/Oqj0Hrr1B4KkMnfRL
 Ehu55YxKS/S4XBbLS45fp71+x3/FTTlbFJBqAvZCCBiaeelMgue
X-Received: by 2002:a05:600c:1d96:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-436e26d9477mr239161825e9.24.1736964586413; 
 Wed, 15 Jan 2025 10:09:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeia6cob8To7qK8qMsr72Dx38m0WozvozxqB69X5RHH0cHm8nleanwVrYFqs/Qu25xxqGoEA==
X-Received: by 2002:a05:600c:1d96:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-436e26d9477mr239161435e9.24.1736964585973; 
 Wed, 15 Jan 2025 10:09:45 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499884sm32110985e9.5.2025.01.15.10.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:45 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 24/48] intel_iommu: Introduce a property to control FS1GP cap
 bit setting
Message-ID: <d9d32478ed4543539322761c19a73edf5d0be059.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This gives user flexibility to turn off FS1GP for debug purpose.

It is also useful for future nesting feature. When host IOMMU doesn't
support FS1GP but vIOMMU does, nested page table on host side works
after turning FS1GP off in vIOMMU.

This property has no effect when vIOMMU is in legacy mode or x-flts=off
in scalable modme.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-20-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h | 1 +
 hw/i386/intel_iommu.c         | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 72428fefa4..9e92bffd5a 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -307,6 +307,7 @@ struct IntelIOMMUState {
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
+    bool fs1gp;                     /* First Stage 1-GByte Page Support */
 
     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
     bool stale_tm;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0111186f7a..f366c223d0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3834,6 +3834,7 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
+    DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
 };
 
 /* Read IRTE entry with specific index */
@@ -4561,7 +4562,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
     if (s->flts) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
-        s->cap |= VTD_CAP_FS1GP;
+        if (s->fs1gp) {
+            s->cap |= VTD_CAP_FS1GP;
+        }
     } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
-- 
MST


