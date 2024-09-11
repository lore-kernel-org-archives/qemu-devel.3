Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8F0EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOnZ-00066F-Ke; Wed, 11 Sep 2024 10:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhn-0007Kz-Sc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhi-0007EO-4A
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Zv+AcVES8CQaHrznfI8esSyWVUaPQBotZar40Wzxw0=;
 b=K5Xwx0VyTDzfewXyWrnj+5dPpjk0I8w65d4moWpE3UW8Vz31QxrxdfNGzdKege/393IQ/7
 K9Apx9h/+VKfyzRNioBd48LJShneBouA2jSiznmD4EXsUYV+KZyaKFNINtkrTVPFKVNG/S
 LEGcb61N6B8hCoIuzfNFNkfsLoAJaNk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-L2d2ENr7OYmhmroUZu_fjw-1; Wed, 11 Sep 2024 09:51:56 -0400
X-MC-Unique: L2d2ENr7OYmhmroUZu_fjw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a868b6d6882so96312266b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062715; x=1726667515;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Zv+AcVES8CQaHrznfI8esSyWVUaPQBotZar40Wzxw0=;
 b=xQfMshW0+XC+exFHH4UuMgmDJ1G+xZUNj6iTKHFK2AM5GNMV4g/B00mPma9GeXLZkx
 yW/1xaYkXKO3kMOjZ4cYkUb+YLM8oUNek54LyhVGnrTO9rRu9tkY/22PR1tBTvv3TZO8
 wLYs/fr/0usNEHx8MjO+ovIapVSkdRqehlO4nVGy/rnX09UIWEEA0YqfJ74ILmEXUwm9
 GEGRt913ZNjyq5CP6KRIDQobo/mbZW4/HeGyML7Psb0LJUMc4PgtF0EedJKyUJFzcEGc
 4r/0BETJ7fs42B/lFCWcUNG2grQHAHHF/zNPppL0lhx6y/J/PQoBe4F6Pt1NhAW/iOzx
 DpGA==
X-Gm-Message-State: AOJu0Yysixc2YAmn+DPr6VPnLldPG5qTpwJMNmsG44w8ezxZb2y6zP67
 OVDioBr3Bz6y/PSunsl7rwqflAv4Gblvm+npn8/84gFDd1wKx7BQmWLQdmyJjgp3Xdy3nJNfirc
 g39lZsPTJUUe5ld2jyf7cNyBkmMbaPjZEQBnmAVjKQklhaVRswphv1g0YwqfNcN+sxa2lZs1n1O
 phVxwYx7HUg7A8wBI705KfT8GRvUZI1w==
X-Received: by 2002:a17:907:7f16:b0:a8a:6db7:6659 with SMTP id
 a640c23a62f3a-a8ffab6cbbfmr442551866b.9.1726062715335; 
 Wed, 11 Sep 2024 06:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ563Z43scq9UThhGmH4KPDKOFBk+Lb1vsH7g6KkuYMmRsuy+k/OUdBc9E6TCx/appZJrk3Q==
X-Received: by 2002:a17:907:7f16:b0:a8a:6db7:6659 with SMTP id
 a640c23a62f3a-a8ffab6cbbfmr442545666b.9.1726062714737; 
 Wed, 11 Sep 2024 06:51:54 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c82eaesm619003566b.118.2024.09.11.06.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:54 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/18] intel_iommu: Make PASID-cache and PIOTLB type invalid
 in legacy mode
Message-ID: <3b52cea829d873706ff86913ae99b4bd621c20e6.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In vtd_process_inv_desc(), VTD_INV_DESC_PC and VTD_INV_DESC_PIOTLB are
bypassed without scalable mode check. These two types are not valid
in legacy mode and we should report error.

Fixes: 4a4f219e8a10 ("intel_iommu: add scalable-mode option to make scalable mode work")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20240814071321.2621384-3-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 68cb72a481..90cd4e5044 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2763,17 +2763,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
-    /*
-     * TODO: the entity of below two cases will be implemented in future series.
-     * To make guest (which integrates scalable mode support patch set in
-     * iommu driver) work, just return true is enough so far.
-     */
-    case VTD_INV_DESC_PC:
-        break;
-
-    case VTD_INV_DESC_PIOTLB:
-        break;
-
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
@@ -2795,6 +2784,17 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    /*
+     * TODO: the entity of below two cases will be implemented in future series.
+     * To make guest (which integrates scalable mode support patch set in
+     * iommu driver) work, just return true is enough so far.
+     */
+    case VTD_INV_DESC_PC:
+    case VTD_INV_DESC_PIOTLB:
+        if (s->scalable_mode) {
+            break;
+        }
+    /* fallthrough */
     default:
         error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
                           " (unknown type)", __func__, inv_desc.hi,
-- 
MST


