Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7C2D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JA-0003Se-BO; Mon, 04 Nov 2024 16:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84J4-00034h-Bc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84J2-0005SR-Sd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LphtSZRM9Hmq0/3hV/+VD4mIq6AHbSOEG0NTeD+XVjw=;
 b=Ag9LrUE/guM/U5RaK5ROVL6j+zSXIq+jjZTj0TjAAs8d+mDgEjVrHD9owaVqKYoZgfdCKp
 eu8Le+UHc+N2P2jnY1iRA5auj1oto/pJW9Ybzf+xk1tnOLg4IkNJwbW1Pnr3Z4bNjZQYh/
 uqWiZxBsAT/F7n/Xadbxnjx/z9dIvxg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-mJaWzp0qNsmanZB452TOvg-1; Mon, 04 Nov 2024 16:08:10 -0500
X-MC-Unique: mJaWzp0qNsmanZB452TOvg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so34460275e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754489; x=1731359289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LphtSZRM9Hmq0/3hV/+VD4mIq6AHbSOEG0NTeD+XVjw=;
 b=Q1G+FR6wl+kY7WIWJNnwTvowD7hXEp3sE+Mckp/up9eKVItawv1vMltKN08SlQr+SP
 Gqb6kdKKfeNWXFRnOJkI/o3aFw/8pBDr85U3zj47bY4T8uym8hbQW7ZHQVHN72cqfqxr
 HbtJtlsjf+aeLib5p3S9720mLK+P+xigEIbJ/ojORD5Fff9LaYxXF+J9eNbvtsLrcYQV
 glPBz1s5a+k/ZVVehDTEk+w/xdEYzbunzVXJhUEt30zUUE4FubJddBzujz/OPQP/veKa
 SHVaonUVjZ4nzp2BsJw8HinU0tZlXMamzyZlQS6QLGWJdw89PuKY3j2JeIWe9ULklSWr
 D1SQ==
X-Gm-Message-State: AOJu0Yz+1U0JSwM9YVtgV/rNYMUSSYgbr0LcQVNW7WlFOcaUUGxKuiIs
 UEjYoPPayBdoiW/KVLYr3B7XCAY5jGj85RYBRaC9gTWgSxe5J8L/88ji4dIRcyIV8RYutaJcMe/
 luxDxPpa8SQh+PDbp9iW9yEBpItZMvSmEGZp38GQw7HH0JdY2+skEmRlV0qvNET8hWFArnLfCWm
 PmgaV2FLTM9m6Chk7VPKlxPRjqsRui4w==
X-Received: by 2002:a5d:5988:0:b0:37d:30e7:3865 with SMTP id
 ffacd0b85a97d-381be7d63e0mr13752497f8f.34.1730754489001; 
 Mon, 04 Nov 2024 13:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHse1DTdtj6DQWEZkiG7Juxs1RZjnkGxjXTOl9gxl2FH1oBeQKwEbrS3o8Qe1YD7Wly7WnjLA==
X-Received: by 2002:a5d:5988:0:b0:37d:30e7:3865 with SMTP id
 ffacd0b85a97d-381be7d63e0mr13752459f8f.34.1730754488530; 
 Mon, 04 Nov 2024 13:08:08 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d42adsm14083391f8f.40.2024.11.04.13.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:07 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 38/65] hw/mem/cxl_type3: Fix More flag setting for dynamic
 capacity event records
Message-ID: <80ee960f8d646505385bce8ed143a9bb8ea36d1d.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Fan Ni <fan.ni@samsung.com>

Per cxl spec r3.1, for multiple dynamic capacity event records grouped via
the More flag, the last record in the sequence should clear the More flag.

Before the change, the More flag of the event record is cleared before
the loop of inserting records into the event log, which will leave the flag
always set once it is set in the loop.

Fixes: d0b9b28a5b9f ("hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/20240827164304.88876-2-nifan.cxl@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 16c60b9b0d..6911d13fe6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2064,11 +2064,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     stw_le_p(&dCap.host_id, hid);
     /* only valid for DC_REGION_CONFIG_UPDATED event */
     dCap.updated_region_id = 0;
-    dCap.flags = 0;
     for (i = 0; i < num_extents; i++) {
         memcpy(&dCap.dynamic_capacity_extent, &extents[i],
                sizeof(CXLDCExtentRaw));
 
+        dCap.flags = 0;
         if (i < num_extents - 1) {
             /* Set "More" flag */
             dCap.flags |= BIT(0);
-- 
MST


