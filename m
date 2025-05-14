Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC8C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAfU-0008CW-Ha; Wed, 14 May 2025 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAe2-0006dY-Dc
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdx-0006PC-Bn
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6kql+B2DpLK0zsY0c4B4L4VYmubyDfVRDOa+cEX4Mpg=;
 b=PCXlMyVJFYR9m2Cvha5Gr6XnWn6G0wQ3kzQU3+SG2Wtm5PqYHEm5bb2A2TAsPdoY84UCbB
 IXQcjTJRJx0E+peHyHrsA8joaahgjXzbztVjcYUx5s4VAPhf2JxgFz0txPzBZzPFMrwgII
 e1npvG+fLRAy/Y3LmkNJS6pInHy9drA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ZHT2iRFRP9CcF45g_grSIg-1; Wed, 14 May 2025 07:51:22 -0400
X-MC-Unique: ZHT2iRFRP9CcF45g_grSIg-1
X-Mimecast-MFC-AGG-ID: ZHT2iRFRP9CcF45g_grSIg_1747223481
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442dc6f0138so20151485e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223480; x=1747828280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kql+B2DpLK0zsY0c4B4L4VYmubyDfVRDOa+cEX4Mpg=;
 b=S4MDc6kYMTZKrcsts5fHqDRLj/bIDLncrKEWpry+FegvKScfLqnyyznODRt2U7n2cj
 kog1gVh3tst7Yo6JioCEBtv2khYjfsboHRaFRLabMbW5FvcGQC+Ev/hvDN1vi2A1//Jn
 q3WB1r9/HWaZm44HqIOONdk8INnFNyb8+LmVqGTHly1LNfCN2Xkm+22RwjkmhhXOHA6P
 lyympB6A4yRIAUAqNDolLTkYQ1bLS9DsN0wtZ5M8DIkW4bnkKdf4UJIzVwnWKoUoMWLj
 LZcFzElD9AHtjoKX+DCH+S0/Dd6VKBlsORIRBejtuTg1zHlgzx2CrrCRNUZB9Y9ykpsO
 fmYg==
X-Gm-Message-State: AOJu0Yx02s7g8m2hLCcol+MiUNt2c59q2MchpQSInAhPkESeDfJiaLye
 yW1aT0dqdspp3eu219fL7NL51s2m1gk/tZqH2hlOiQL+JA7zFp/5uxD3pyiLnfObkEGOYEuohgv
 L2Yhgv4ulHlkCU+kz977D2krIcppNO/UfF4+KFtq04+kdJ6DKKOxmu2bMFNgPP92oWLvr4LRj/G
 v48ZQc8NoSERzsE1yWVwI01XIVnqcu/w==
X-Gm-Gg: ASbGnctJ72o10/9Hu9CqF1WlRM1EQSvtFfp3J64itPNUsjXmbjRYi7MxKUzRpwXoLDc
 lHsISr4GVvO944QkI+BMngzuID6T+0lQtTIuvPsTtQGU4sx6QR1aFsEEeOZn/7Zc1MNvrz25zs7
 lc6c9B0Z63AkDtAOQT1EqlFf4mpSOSEyLmB6tJZUHAsdOPvlJF7NztwD7Pa6Y/z2x7f7255FqQx
 eybnlChVyNweUw6A5TisBp4wr5IY23tZjViBszEDAmPqTpHQvMEoQu8AgLUR18EYdWf5EGfKcVC
 +TdjsQ==
X-Received: by 2002:a05:600c:5118:b0:43d:526:e0ce with SMTP id
 5b1f17b1804b1-442f2169a50mr19098635e9.21.1747223480499; 
 Wed, 14 May 2025 04:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4KxtgrkwQ9kUmO92JnBaAM1wAVRJ5nIOI8b/rA26277TF2Lg4ZNlftbmMxa9MNl0OPu+dRQ==
X-Received: by 2002:a05:600c:5118:b0:43d:526:e0ce with SMTP id
 5b1f17b1804b1-442f2169a50mr19098285e9.21.1747223480079; 
 Wed, 14 May 2025 04:51:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3368fbasm27531985e9.2.2025.05.14.04.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:19 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 24/27] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Message-ID: <b1c84782bfddeaa0070f5ae57ac2e4e3992f9f19.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

vtd_switch_address_space needs to take the BQL if not already held.
Use BQL_LOCK_GUARD to make the iommu implementation more consistent.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250430124750.240412-2-clement.mathieu--drif@eviden.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f8ed1243d..b925e65b02 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1728,8 +1728,6 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
     bool use_iommu, pt;
-    /* Whether we need to take the BQL on our own */
-    bool take_bql = !bql_locked();
 
     assert(as);
 
@@ -1746,9 +1744,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
      * from vtd_pt_enable_fast_path(). However the memory APIs need
      * it. We'd better make sure we have had it already, or, take it.
      */
-    if (take_bql) {
-        bql_lock();
-    }
+    BQL_LOCK_GUARD();
 
     /* Turn off first then on the other */
     if (use_iommu) {
@@ -1801,10 +1797,6 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
         memory_region_set_enabled(&as->iommu_ir_fault, false);
     }
 
-    if (take_bql) {
-        bql_unlock();
-    }
-
     return use_iommu;
 }
 
-- 
MST


