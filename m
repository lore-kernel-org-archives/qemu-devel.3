Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759D2C48BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFH-0005Oe-TH; Wed, 14 Feb 2024 06:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEV-00045B-DR
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDET-0007Ct-8V
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0q+66FHFgz+QEw9GXtnbF95xt1ZFxqJmwC/w0RAaIs=;
 b=JJKLqEH7SzhDzkHqqMwMs89/meTiK6iguHSOIPYTi2Mg2EqpUpzNvmVU7RcN+pqco0AaPQ
 5SUYf6z91T49Lj2eRJVAzs1U2snAa0MHtO7A5dewz1zgk2Nnyxkyk7efyaL9Wc/RriXKJ3
 +QTTh+ClU/BFxEbe+29aj08x0+XwU9I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-UgnnJRSPMeyfEa5qzf8fjw-1; Wed, 14 Feb 2024 06:15:14 -0500
X-MC-Unique: UgnnJRSPMeyfEa5qzf8fjw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5628953d2d8so381928a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909313; x=1708514113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0q+66FHFgz+QEw9GXtnbF95xt1ZFxqJmwC/w0RAaIs=;
 b=kYIXfBWuOEz7vqdZ2DazJnUjhiZ+0Zub9hW1wD8egxlxVMDR8+Qc0RYH8E3ZWvrxXJ
 wdx+iJ9IAnJNmKl2LYlTm/PIKqYjrgRScUyLd5thCupsLVPRy2FF51iwSqEgaIkBoPH+
 07uTWJoKcQGAI989HFVZHTbJ2DzyxE7oJtP2MfkEO5GAxy5Q1g362YweGH/gseELnGO5
 wkA4vSuubfhCJ+E+F8Sh5i9jb4xYCxr4sX4mC86V66Z+jpJgfxAJ/JLShroTgC6dStLl
 Htdhr9mP+PO3ngq54fhsaHeslQSh3mrb9VgkVh8z0DSm6mJqHf2kXqkh8Njje+GAH1Wb
 D7vA==
X-Gm-Message-State: AOJu0YyZa8P3zaN9RTSCQqyFpKl8TSLttA4rS/03N4tKyBYZUYsYyibR
 +NdOyglA5cl00n/ddz0o/pJ5RIJEy7GSG3Uj9yi31+kugNmBPKT7M3lrHNkLQxtmv8KE3DmXDp4
 iqjXMl0MpPTs9ATolXxUGc1ZdNi5XtRXpB1poP+Cc4io0mXaYy1SDDHa0om5r+HBZ8haidZy7Eh
 YoJNwCzOop8QTpTHTYZI8o7VRcrDQsiQ==
X-Received: by 2002:aa7:c58f:0:b0:561:b28:e61 with SMTP id
 g15-20020aa7c58f000000b005610b280e61mr1786042edq.31.1707909313095; 
 Wed, 14 Feb 2024 03:15:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqzxXCXR241gJUj2BY4RTnBbjI5s921dqL7Tz8OSN10EFdJ6l6JCmDYFxoVRUQnkD5adtryA==
X-Received: by 2002:aa7:c58f:0:b0:561:b28:e61 with SMTP id
 g15-20020aa7c58f000000b005610b280e61mr1786029edq.31.1707909312884; 
 Wed, 14 Feb 2024 03:15:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXfzL+TzVONdYLKSlGm4tQCq6dNIMqdaljQjLdP5YSdeMoclRZQ7K2l98+htbRpyykZmLFxO0rPzRMgW6VFrECC1i94r4DRnzEPy/HNAH1IE7I+/88b4d4vOuZE1Kof69ZAPygFsL4ofElsJ4P/jJDMLR6VkHGZrnEqoawsEB+CCZWjsQ/Kp8FPSLUUtLBzTKmHdlFBL/GmNuzulX4UafrjrUXrv38y
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 d6-20020aa7d5c6000000b00563819d224esm346330eds.21.2024.02.14.03.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:12 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ira Weiny <ira.weiny@intel.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 37/60] cxl/cdat: Handle cdat table build errors
Message-ID: <c62926f730d08450502d36548e28dd727c998ace.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ira Weiny <ira.weiny@intel.com>

The callback for building CDAT tables may return negative error codes.
This was previously unhandled and will result in potentially huge
allocations later on in ct3_build_cdat()

Detect the negative error code and defer cdat building.

Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126120132.24248-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-cdat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 639a2db3e1..24829cf242 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
     cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
                                                  cdat->private);
 
-    if (!cdat->built_buf_len) {
+    if (cdat->built_buf_len <= 0) {
         /* Build later as not all data available yet */
         cdat->to_update = true;
         return;
-- 
MST


