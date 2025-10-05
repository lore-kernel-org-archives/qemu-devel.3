Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8578CCD182
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFH-0001yb-9C; Sun, 05 Oct 2025 15:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEj-00005Q-De
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEe-0006WA-Sz
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OKnItQYBTrXiPTFJBSTJGUjxT2lE7EF9Yn/LDwcOwGM=;
 b=Tyuz/SLbHQcpJCJEkmVOFZ3OlO4ckM/0VkuCxytT2YhOGKXCVTRCFgKZtvZt0giVptDfdf
 frAzqeTGPbRualiTQ+UyXOeEpfuTw05AmVCcJ5IxHKBbdSjUFuENgncQI6t1zRecrB+t9M
 G0i3hBKx8EnhXMkXJ56HPYy8E45iUqg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-o6sV5EoXNGmpEI4kbzyHmQ-1; Sun, 05 Oct 2025 15:17:30 -0400
X-MC-Unique: o6sV5EoXNGmpEI4kbzyHmQ-1
X-Mimecast-MFC-AGG-ID: o6sV5EoXNGmpEI4kbzyHmQ_1759691849
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e35baddc1so22645465e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691849; x=1760296649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKnItQYBTrXiPTFJBSTJGUjxT2lE7EF9Yn/LDwcOwGM=;
 b=CaVYb5nmP2VMtvdVPYg6FFgMLSPFjNgQqndFuT3EHZ31GQUwbCj/B63pgDQgEhvsxI
 kfjlWTf9ny9c7atz1OvLV1ns3s+kGeZpNr+B2AIEsTAqAoIXkErOh40ztQyiWodeK/nt
 iHvt5mhsVKDugW+kKdB+H+s4uHAPmUXIFWQHMm1qPWDAudwfBSzuv5L2zDTGkmAmJT0z
 zTArQbodV11mwg7Dea3rmFW8r1RWobcnJJVchne385BXrYxvRNugCw+WeOwa5ol4L5w5
 A42ibZH1kLkVCaWicsyd/m8mDH83NW1CF/SZhpGuuC8MnuyjQxVaYdPsFTAOlGKFmZrY
 IsZg==
X-Gm-Message-State: AOJu0Ywbz9uQhHSxYbxjn1+g88vIXz3JsSaAEjmfHdFKfehcLeDWMy7U
 ZIS7aJC1gCrL2eb/e5qKlaZvvnPc1l8VkELuI0LsjtkPuEJxb//FSLt3Owhn3sZuevhG+c8vg/C
 TPZH3erJjDqiTjs6U4Fb3l7zxkrp88VJpAHu5iEqp4HbxJyT48XR6rO8hzBPSSn71xIq/807pYs
 RJtkUuy4bmh7USfhcuJ+LNwvpHfB8jctfbPw==
X-Gm-Gg: ASbGncvqxWllN2BiIQAdhzELbuMUwTWBDWPvt4Ivxda+mjE17kaH8qpOwkQ2T+591AG
 d6Gxuvwh7SpPMyHByseQvGWMogYs3+0dhP3NaNHE37Pxycw6cZSzP86u5+PGvkR/my1+VR50rYs
 6JLY5g1FG0MuFj38oDc9o6Te9iNaXU81Mi4iBipGKdE0rUh6k3COplQnyZbzof7X4OziScDZ0Qt
 wE//ml7JunbO/BYG0NufaSMy6tuajtJr98yKsHyfclq/bdJBz0Qn+WwDUd3J/qjzINeIqB2w5XM
 iHtwM8qJ05nV56LWNVoI6ILM4HOTqVwv/tpm0IU=
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-46e7114829cmr57999995e9.32.1759691849154; 
 Sun, 05 Oct 2025 12:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4zTTH+d2bFR3+JzNmfeNs4T4/TmnBfZKwwYWYRt/p7obGkXFfF7XAkN+1Ryi6fd+ey1+9jA==
X-Received: by 2002:a05:600c:3149:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-46e7114829cmr57999785e9.32.1759691848535; 
 Sun, 05 Oct 2025 12:17:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8ab8fdsm17343552f8f.15.2025.10.05.12.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:28 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 38/75] intel_iommu: Bypass barrier wait descriptor
Message-ID: <57ac646a2ecb2967c46febcfd0f40d396868b4dc.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

wait_desc with SW=0,IF=0,FN=1 must not be considered as an
invalid descriptor as it is used to implement section 7.10 of
the VT-d spec.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901111630.1018573-3-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 83c5e44413..4e7ad3a290 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2857,7 +2857,13 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
         vtd_generate_completion_event(s);
     }
 
-    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW))) {
+    /*
+     * SW=0, IF=0, FN=1 is also a valid descriptor (VT-d 7.10)
+     * Nothing to do as we process the descriptors in order
+     */
+
+    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW |
+                                                 VTD_INV_DESC_WAIT_FN))) {
         error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc->hi,
                           inv_desc->lo);
-- 
MST


