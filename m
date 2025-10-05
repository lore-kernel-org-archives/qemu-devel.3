Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F10CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGV-0006Ka-HW; Sun, 05 Oct 2025 15:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFs-0004pl-DT
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFq-0006g6-0o
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VxCiyHKYD9YBF6shEy7T0nbq5E2EJ5X5H7ThZ32/yVY=;
 b=bTcRG6qc7Dw5kruvysFY9myP7S+XBFhcSlx5KJq+LD9ie3txZGT/iKoZPI3U71Iyw3hzHx
 cY0JE0XXbWMYWKY7qkedqglpIPMonQu/NWN19PAZC6FC96Ny9XZKkBx0E0ItFmBwgW4ACK
 ViuGv9RYhF2nyR2Oci4ci31yXYhK9Xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-XmYMgiZVPZmKwPb_oKh32Q-1; Sun, 05 Oct 2025 15:18:43 -0400
X-MC-Unique: XmYMgiZVPZmKwPb_oKh32Q-1
X-Mimecast-MFC-AGG-ID: XmYMgiZVPZmKwPb_oKh32Q_1759691922
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e473e577eso21448925e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691922; x=1760296722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxCiyHKYD9YBF6shEy7T0nbq5E2EJ5X5H7ThZ32/yVY=;
 b=IeT3hvgngl8C387jiHsvAZp+ILH5ohFwAeLTQmh2leC3R82/pk0/RWqMpuxvbFl/M+
 HuWSth1f3ecqlj5pkBp2pGvVIoumGhFXWoTcTRk7TC09YFuJNCJc7HuD6ja7MOd7kVfL
 XqhKnYUuiO3Pz75pHv6bEq8hWm94jbY2FfVy+viu4uYwy9Gf87X3+VTLKeFQBTIhn5Ot
 +nUts+BsFvKmj9gEOzfUvEAdwSHAgPG973pZO2Ib0szo1hcgBKTPjRXF+HENo22gARfA
 +bS6gr9cFts+Qe52+uuXgDfEWklO83L28XiZV1QLu1DYUSib62+IgSClLLK/TNqGAYGE
 SvTg==
X-Gm-Message-State: AOJu0YyFG3/mPIyoc52Pgg6rnUo3Fz3dSBYqM7rcm1eP0mkGt8Q69OpM
 UD8GtohMETl2NNPFdbN6sZH1coxuOYeyJ+I9QShqBNcCLewuMHpwJOTZcva/BtgiRBgEmik27nx
 PHUYQG2LHRhe+phlo1dtjPpJVnKBXpCOsygD3mrQRSjtW+DqiQI76yqgiX2OubJx872NdzXEGam
 7zM+CUZRy0Grm2kK2PgE4saKWua9XQKw6QLQ==
X-Gm-Gg: ASbGncuX+gQRARk4+gcHXaxWxkWyM7jBA1loNGv/5tya48A6xeSfb5mjeac6cs5Tqny
 q0k/hhdEOlr0A4o+ViFvquqrgkFG9qaMfoWmXKB1ikEnXrxrP6lAnbx3SxOR0RUtUVrIsgqr8aG
 Z7Ga1/bX97cbQfdya6Oy0EyKKwObazP6hO7yZFFd3ZpfW2vGgH0Zxdg4CHJ0zT1k45wxPNshEfF
 Olzyx3A6VMND5gqLO2jjrxXSlP9wrruPMCuhSilM967udL75F0qB3F/8DOXmC7Q2Y8I38Vr3ywY
 tO6dejz+CF7v8d7l14HQWE/1odrYWW3YQ961hjA=
X-Received: by 2002:a05:6000:2f88:b0:425:7c14:e2e8 with SMTP id
 ffacd0b85a97d-4257c14e303mr945356f8f.37.1759691921737; 
 Sun, 05 Oct 2025 12:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG18Sjsh/St6MarFIFB7eEahBZg+EIzwimmYVYNVr0A5Sq9c+ET7pzNSNhkSFf+Q8qUAcB2jw==
X-Received: by 2002:a05:6000:2f88:b0:425:7c14:e2e8 with SMTP id
 ffacd0b85a97d-4257c14e303mr945329f8f.37.1759691921014; 
 Sun, 05 Oct 2025 12:18:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e960asm17345713f8f.37.2025.10.05.12.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:40 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 71/75] amd_iommu: HATDis/HATS=11 support
Message-ID: <51da445f5322952e6fb26b286e8aebe464c14176.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Joao Martins <joao.m.martins@oracle.com>

Add a way to disable DMA translation support in AMD IOMMU by
allowing to set IVHD HATDis to 1, and exposing HATS (Host Address
Translation Size) as Reserved value.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-23-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h  |  1 +
 hw/i386/acpi-build.c |  6 +++++-
 hw/i386/amd_iommu.c  | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e1354686b6..daf82fc85f 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -177,6 +177,7 @@
 /* AMDVI paging mode */
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
+#define AMDVI_HATS_MODE_RESERVED        (3ULL <<  10)
 
 /* Page Table format */
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 423c4959fe..9446a9f862 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1863,7 +1863,11 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IOMMU info */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU Attributes */
-    build_append_int_noprefix(table_data, 0, 4);
+    if (!s->iommu.dma_translation) {
+        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
+    } else {
+        build_append_int_noprefix(table_data, 0, 4);
+    }
     /* EFR Register Image */
     build_append_int_noprefix(table_data,
                               amdvi_extended_feature_register(s),
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index b6851784fb..378e0cb55e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -107,6 +107,9 @@ uint64_t amdvi_extended_feature_register(AMDVIState *s)
     if (s->xtsup) {
         feature |= AMDVI_FEATURE_XT;
     }
+    if (!s->iommu.dma_translation) {
+        feature |= AMDVI_HATS_MODE_RESERVED;
+    }
 
     return feature;
 }
@@ -472,6 +475,9 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
 static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
                                uint64_t *dte)
 {
+
+    uint64_t root;
+
     if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
         (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
         (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
@@ -482,6 +488,19 @@ static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
         return false;
     }
 
+    /*
+     * 1 = Host Address Translation is not supported. Value in MMIO Offset
+     * 0030h[HATS] is not meaningful. A non-zero host page table root pointer
+     * in the DTE would result in an ILLEGAL_DEV_TABLE_ENTRY event.
+     */
+    root = (dte[0] & AMDVI_DEV_PT_ROOT_MASK) >> 12;
+    if (root && !s->iommu.dma_translation) {
+        amdvi_log_illegaldevtab_error(s, devid,
+                                      s->devtab +
+                                      devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
+        return false;
+    }
+
     return true;
 }
 
-- 
MST


