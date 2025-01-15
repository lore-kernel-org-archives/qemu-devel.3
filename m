Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8563C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7p6-0006PE-LI; Wed, 15 Jan 2025 13:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7p2-0006OP-63
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7p0-0006Wn-NL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8FUzP/ipOTW2ewlNfL+QvXOqY/FnUZooNamJ6cM0LY=;
 b=e9zMirwDLCHyuICV+ZjrCZ4fEUa2sxZYEEC0th4MvvJXCfLWESC3hRN977Eh3/8eZZPP0N
 ef/6LjXgfI4Rs2bH2lL9dBiBz5+jbb8aDErc+wBvJWVgA3WfDgzDrK2O9AWswsP8EB5bTX
 hmdj9HdZh7sxcm7FYLpDP4iNZ0ecbtY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-YuYkSA2DOHC4RkaqQfvfbw-1; Wed, 15 Jan 2025 13:08:52 -0500
X-MC-Unique: YuYkSA2DOHC4RkaqQfvfbw-1
X-Mimecast-MFC-AGG-ID: YuYkSA2DOHC4RkaqQfvfbw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436289a570eso32466685e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964530; x=1737569330;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o8FUzP/ipOTW2ewlNfL+QvXOqY/FnUZooNamJ6cM0LY=;
 b=BkuYBWFEaU0eAUZ6dw1BjSlOwjcFEP2vFB3r8LvLVK1xagZvT46H1yl/l+1qsWMyhW
 3YDkhkpzyMBxrkpMhnuS6Z40qOHP4LTmQ3XM13ie+ntYbMk8FhMrBhk6MN/xBEjB5/Pr
 qercIw3LzEE08ZbbSEcplrZtldhwUFb+C3Q+58LYVPLUg83RT5OMnYtiUL+SmZesYaFL
 pWZMlo/l7meysp7yj4hExPlwAc0V+MPPHtAJfRKmJsEFiK6Q3FRKAy8FGXtYbW7iTHgZ
 /N5i3wWSg7EEK2VWsasEiSA3iI+Q02jB/ZuKVfTq8c9+WW/lkec+GWpZrs3HDO/vb7R9
 mBpw==
X-Gm-Message-State: AOJu0YyJaTz9fUZkjdZDjiBEKvNsLhY4EVXDAZkXc9ha2LQme329j5fM
 lXFawpSeAWnB5cMiEEyNv8aUec6s4wFhZ+j+YpZG2gJez4g0XKaxOXObq7cZiOsNr2t3MqnCFLT
 0MxkOdJZOEXRUnyNGjUz+0BI6uE98yse9qzPtCGzj1IzQmnT2r2tk+QIXG6XN4ertbuQ1LJOLRB
 urH3Hzlooj+9xewnum4hWp2FIk6knIvA==
X-Gm-Gg: ASbGncu9mHgrE7t6sDuP1XeZuuIIddygxUWdUO9NQ70LHiXY5eljZgBO7Xl24enf6WS
 Zv0PlaK+xKROkUd+06E9cN0ZcM7rB5bcItKAOMrsR5FS4sCyxZXJJSv4G0gsC7avQZwpMFy+kyn
 FVtM2xiTaTtW4oNLsvsR5Ot913QYsW97dxdUvjNIiaJ2eB+J2WZxmddEfhSpZOkIxBDnB9UUSyS
 LSmHHBrQtqaQf5PFF/zr5gfIbK9gEEdWjHfcLJ1fBxKI2RDhuBZ
X-Received: by 2002:a05:600c:450d:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-436e26a8927mr346818355e9.16.1736964530607; 
 Wed, 15 Jan 2025 10:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6sxC7X2XFgof1z74pcowgq7OTwbb8OZI96cM+j+2HZdcu6GORvYhO6QKL/FZ81UUNvDkRGw==
X-Received: by 2002:a05:600c:450d:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-436e26a8927mr346818005e9.16.1736964530188; 
 Wed, 15 Jan 2025 10:08:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e59fasm32071025e9.34.2025.01.15.10.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:49 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 07/48] intel_iommu: Make pasid entry type check accurate
Message-ID: <b291dae33d1dab48670b86807a71cb1cbadf39aa.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When guest configures Nested Translation(011b) or First-stage Translation only
(001b), type check passed unaccurately.

Fails the type check in those cases as their simulation isn't supported yet.

Fixes: fb43cf739e1 ("intel_iommu: scalable mode emulation")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-3-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0ab1676d5f..bd639b7ff7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -759,20 +759,16 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
                                      VTDPASIDEntry *pe)
 {
     switch (VTD_PE_GET_TYPE(pe)) {
-    case VTD_SM_PASID_ENTRY_FLT:
     case VTD_SM_PASID_ENTRY_SLT:
-    case VTD_SM_PASID_ENTRY_NESTED:
-        break;
+        return true;
     case VTD_SM_PASID_ENTRY_PT:
-        if (!x86_iommu->pt_supported) {
-            return false;
-        }
-        break;
+        return x86_iommu->pt_supported;
+    case VTD_SM_PASID_ENTRY_FLT:
+    case VTD_SM_PASID_ENTRY_NESTED:
     default:
         /* Unknown type */
         return false;
     }
-    return true;
 }
 
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
-- 
MST


