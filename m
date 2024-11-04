Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867D9D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84JJ-0004a2-0H; Mon, 04 Nov 2024 16:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Ix-0002yS-Gi
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Iv-0005Rx-Pq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=37jtMIq9rcanrOImpOzg8HMHUHIFbVSYLgdcwzoI8+c=;
 b=gRTVRudplq4r01yyrON7sBNFkfoHK6aMA9SIFEvAmyIQUKGa0bUdIuhvkwPj45hQuZj9MH
 3gGTKJEUFLdGiTQQxxAZQSqyJq1ObKJY+RGWrxpMNuF/hIEfrWkyOhGlSkzPliNpgbOsfo
 lOO+0sR3L30hlbt04W7pnF/8AsNlVLs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-7y-9oOzGOJaysatCyG-fdQ-1; Mon, 04 Nov 2024 16:08:03 -0500
X-MC-Unique: 7y-9oOzGOJaysatCyG-fdQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4957393e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754482; x=1731359282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37jtMIq9rcanrOImpOzg8HMHUHIFbVSYLgdcwzoI8+c=;
 b=njERyIYMbNBM2fNaIofYpeU0Lx46ONTDL5WjSPggW820KfjjIBojxbYtp9SQDKRsLl
 WUlridL1+8jI57zSoqd1CM1o6W8DEOlaXTb844rrMpQ7mlon+9YGzIwxQh5Uzji9ty48
 IiISuVGjF1BACJFTEl4BpoTZAt9dye/TIzmV6Mzm2HbGRFEkjvdsLTk9o5mCNipfvFvF
 StIYp0Lfl1PncBXLgAs6PmGCJtobAkSy37AnGFOZ8sz0AVU4S5LBluykDVZ7dPVC+JZR
 SEDqnBtUVLmacX56r00NBZBWYQfzP1Ix63dL3tSrHpm81Z1lJCG/Dph2ne6ki2NNgND6
 vs2w==
X-Gm-Message-State: AOJu0Yx7/yTsG+aUwjuxU16O7+JQ+GoJSObxkQ2kFYxiacqKfj5GrMVW
 YaNJJTdDC7haf1pk0demafovc9hDwN4i10MjkxwN6DI9jE1uSUkp4xgchIH+OSqqSPaD+ov35W8
 ob4/4EluCvUMzktOGAIPrDlI0Pem3MRZdj+R2t3pMLEHHbCvC1h4mxFLM481eJg2EbQ/Y+RE7pU
 NYQ5gLWAF0ks5hDDpWybzTSWJ98Ik4cQ==
X-Received: by 2002:a05:6512:318c:b0:53b:1f14:e11a with SMTP id
 2adb3069b0e04-53b348d0d32mr16962586e87.15.1730754481925; 
 Mon, 04 Nov 2024 13:08:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFll0SJdlhEH4BTrqg/ABdbN18+A/2NbktGTlZ/PmzeOpvhX3RhoWcDsy8iNsIIys5CS+NshQ==
X-Received: by 2002:a05:6512:318c:b0:53b:1f14:e11a with SMTP id
 2adb3069b0e04-53b348d0d32mr16962567e87.15.1730754481361; 
 Mon, 04 Nov 2024 13:08:01 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5abfefsm164801235e9.4.2024.11.04.13.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:00 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ajay Joshi <ajayjoshi@micron.com>, Ajay Joshi <ajay.opensrc@micron.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 36/65] hw/cxl: Fix background completion percentage calculation
Message-ID: <8352756ffa72668773d6904bc76dfc0bf2619e5a.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ajay Joshi <ajayjoshi@micron.com>

The current completion percentage calculation does not account for the
relative time since the start of the background activity, this leads to
showing incorrect start percentage vs what has actually been completed.

This patch calculates the percentage based on the actual elapsed time since
the start of the operation.

Fixes: 221d2cfbdb53 ("hw/cxl/mbox: Add support for background operations")
Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20240729102338.22337-1-ajay.opensrc@micron.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241014121902.2146424-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9f794e4655..3a93966e77 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2879,7 +2879,8 @@ static void bg_timercb(void *opaque)
         }
     } else {
         /* estimate only */
-        cci->bg.complete_pct = 100 * now / total_time;
+        cci->bg.complete_pct =
+            100 * (now - cci->bg.starttime) / cci->bg.runtime;
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
-- 
MST


