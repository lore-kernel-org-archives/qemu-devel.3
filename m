Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68069C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHn-0008J8-IX; Mon, 14 Jul 2025 19:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGu-0005El-7i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGs-0005aE-Mj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/e0EHOrB7ZCBA2nwdmyUuJgNrg4LS48+Pg1+NbLqEN8=;
 b=BseU2w+Uv0FkoGl2zNqPYDRhHbnJHQkJB4144k3/3pvlJmYt+gDK1buIb+UTpxdNBUlg92
 tArNMiC9mLgM9rgjHLkLx8xRLoWqz1jgEkK3zBWuOSSgbiYMrGRzNx91l3JUgT6E91k/y4
 pAtiJ+5KLbtxoGyNl4qyV1lYpL3PodE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-4Mr7tG7pNhyc-3YyRAb0Dw-1; Mon, 14 Jul 2025 19:07:40 -0400
X-MC-Unique: 4Mr7tG7pNhyc-3YyRAb0Dw-1
X-Mimecast-MFC-AGG-ID: 4Mr7tG7pNhyc-3YyRAb0Dw_1752534460
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561611dc2aso14152445e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534459; x=1753139259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/e0EHOrB7ZCBA2nwdmyUuJgNrg4LS48+Pg1+NbLqEN8=;
 b=qMoz16UCQlM0fjZaD7WIUod9OVa0tws/C5Lx2SFLuERrsR6mMyI5L1ZpIDKEEy8DoH
 210OaDIzVPUK3p8b+YOVJSTVU4+codhyoexMzsI+tBfcQfLfAAco0CD1s5sht8jbsiwz
 ZVWztmKTQPZgNaZ42emU3FVhC2iWK+nT0EHJwlmjl/fOcXPB+12+22RsNGUDapKiVnKE
 cy+wWoWOxaw04qPaJgCfERbinWw7IqW0H2CT6FtXKcxTZcw6IikGQMVmBApEZKhc8rgO
 C4awN/gq4AaPs5HGVO12OZBdws2L500Qhg0tPcFSbHRsPMv4x1HB+cuxh0whLyDWne3t
 cTeQ==
X-Gm-Message-State: AOJu0Yx34DI1CyEPghE2i2k+KhgzCm1BMnhri+Pdil7Bir0SZJJdj73P
 F+lAZmkm8uOlYcKgdlh06KBNDFMw43mrgJCXmTObWtYGgt+dW35wVwfYaQzSkNS7NKxygU/Ae3J
 VBiregXziEHggT1+OTaMNKnlbH+hI8jxw0WDoYaXZpjvERTwpyqiZzGJ35+yN4KkiJmeF5j1bHv
 b23bam5iKOje3l75xNuJynuQJ1V/tjwQmVSw==
X-Gm-Gg: ASbGncuWrtwI3xQSasGXagol90+MUzubOj1LXOSPl4vO/YferKxI5ieh5iTiBadrhSh
 EKZWkCpmJjaw23ZbZTHXBd99WfMeNFRI9e31ZnFESrjmagThV9Fot2AmcsXKMJG8WO+0YWEYEKT
 5KkN+tEgruxZgtCwTkHGq9NvmcB/GW4O0Oi4hYvThtbOZOYI5Et6x2cpXDEX1xs0e9BpJxhQocv
 DpofkdkqPzzslw+r4khG9cBEtY5ruQfujnE3vUoLxiJnxlTyF7rz57QOkGAqVF5WoWF9m+/VC7E
 B9kRgF3AIS8IjvcsAdkK8cU/oqg7m/1F
X-Received: by 2002:a05:6000:bcc:b0:3a5:1222:ac64 with SMTP id
 ffacd0b85a97d-3b60a195aaemr190736f8f.38.1752534459401; 
 Mon, 14 Jul 2025 16:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcHhHVFLiZUb8hcieSC3bxuB3oIa+/Rf9chOWSeUD8xSlPXFGzD9eKwWBCXhGW1HPKy/uIhQ==
X-Received: by 2002:a05:6000:bcc:b0:3a5:1222:ac64 with SMTP id
 ffacd0b85a97d-3b60a195aaemr190721f8f.38.1752534458966; 
 Mon, 14 Jul 2025 16:07:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e285e0sm13239143f8f.101.2025.07.14.16.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:38 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 33/97] intel_iommu: Declare supported PASID size
Message-ID: <f4326d5089b52e581d8c5404ceac85324cf1772d.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

the PSS field of the extended capabilities stores the supported PASID
size minus 1. This commit adds support for 8bits PASIDs (limited by
MemTxAttrs::pid).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-6-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e8b211e8b0..360e937989 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0fb4350d48..71497f1936 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4590,7 +4590,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     if (s->pasid) {
-        s->ecap |= VTD_ECAP_PASID;
+        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
     }
 }
 
-- 
MST


