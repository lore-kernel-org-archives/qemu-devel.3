Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D9C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdF-0005rB-Mk; Wed, 14 May 2025 07:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdC-0005qb-Ns
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAd7-00063r-68
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uZ0822VM1X6UTnEEl31BG7SIVJs/Pp/+b+HwS+jAx3g=;
 b=Z6RkTlj6J1nvTWA7yS97tUweXX22OFuEt+i2Q8whlFH0kxezAdsU3JiSJML8cOGLUyGUJY
 tNGELaUBJvm6B1Zkl8Hzi0dH+gNeyfMihNnaadWFadDVECeoVyB3/iNBb27McRs4IujuoY
 h880qRHUEsYyHnKsgtY1uzm8Qw13JNM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-XSd4CspNOiW5o5VQWzC0Jg-1; Wed, 14 May 2025 07:50:29 -0400
X-MC-Unique: XSd4CspNOiW5o5VQWzC0Jg-1
X-Mimecast-MFC-AGG-ID: XSd4CspNOiW5o5VQWzC0Jg_1747223428
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b5d18cb7so2600385f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223428; x=1747828228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZ0822VM1X6UTnEEl31BG7SIVJs/Pp/+b+HwS+jAx3g=;
 b=qfqRNmfozJYdceoYE5m0zxSrTNr7ofBcCBDjecXx6NOBGTnHILsYfGY1ceKZaqu5Ax
 QevibHAxK2WWNu278ljFHrIPMKPL/gvByu5DMwILWoUdVgfJhXHK1IuKpF/nmYULJ/35
 e+DXc2hEJAPHtpCk8kBFYdRBsFzARE4DgV5BP8kgd8mjKmq+QIIxwQAXX6B3HXs9/zpQ
 EO9zX+dR7sZGujlErLUxAlcYtpH48w302OryTB+jj06EF1gamxWyqSVOiB7JslbNoiyd
 i+XuRPAbkxchd9nBj8QxmxyqH32wP1XvYdtSjRgjpVmB3Y/iS/yjQQZj/iUdScrzXEa7
 rY8g==
X-Gm-Message-State: AOJu0Yyec4PSN+oH+1VGXoQrGM8tDrdAcu4BAQMNMmKXzkVgtmo7J+bu
 GJgl66uhjVjFigQP0x2L/oyFsMrDFfh1W5ttkw185qytvUsamBmYOe/tkvDQR7h3xuxAhbn45ax
 HS2FIPap4opJG4VjCzjqj5/e1lXLwNT4L+A4TuowAyGYm24kOyh5qEMt+u8u6ZcMSdvDyRPTcl+
 ce9GSdz0OhBC+a3QC0dz7WRPHmdK+JaQ==
X-Gm-Gg: ASbGncuKhiX2V9AMV8owDvNMonefR2IGZutdP3ZPp2soCo/898yhPpAV9kCaye/xSkh
 QDhFtyef1j2xKJ3L2d/tnOLwEPVmafLhwydlGZa3+fQYRAh7Dv/ui5LpHjZHH3z3P1ui+wdDW7B
 XhliIhEdDAGoAKf/Cpqu/l5XWRD3LoKBxeQmHgmcNYa7nwXuGFTspDKapA9CC8W5NL8+UmgLZvA
 0wmlWhm0WttvUpH+GfbolRn+Z6zg7glHxM8DC1iodPcyjfmbmL1Prd0HGTHOlxxjhNqS7/k6ppE
 AolKpw==
X-Received: by 2002:a05:6000:1ac7:b0:3a2:5c7:7a84 with SMTP id
 ffacd0b85a97d-3a34991e1e4mr2647413f8f.40.1747223428016; 
 Wed, 14 May 2025 04:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8UTwYb34YLWWbIyIk5vDhtAzOStlpkHmBllXNB0mfyMNAfcaK2rAHjgqwRgOXiRuLR3QXgQ==
X-Received: by 2002:a05:6000:1ac7:b0:3a2:5c7:7a84 with SMTP id
 ffacd0b85a97d-3a34991e1e4mr2647383f8f.40.1747223427599; 
 Wed, 14 May 2025 04:50:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ecccbsm19610607f8f.32.2025.05.14.04.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:26 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vinayak Holikatti <vinayak.kh@samsung.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 04/27] hw/cxl: factor out calculation of sanitize duration
 from cmd_santize_overwrite
Message-ID: <484df0704ea592ebd5993c15d63ea38f309ec6e0.1747223385.git.mst@redhat.com>
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

From: Vinayak Holikatti <vinayak.kh@samsung.com>

Move the code of calculation of sanitize duration into function
for usability by other sanitize routines

Estimate times based on:
             https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250305092501.191929-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 63 ++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 79b35d1405..9f9d475678 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1640,6 +1640,41 @@ static void __do_sanitization(CXLType3Dev *ct3d)
     cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
+static int get_sanitize_duration(uint64_t total_mem)
+{
+    int secs = 0;
+
+    if (total_mem <= 512) {
+        secs = 4;
+    } else if (total_mem <= 1024) {
+        secs = 8;
+    } else if (total_mem <= 2 * 1024) {
+        secs = 15;
+    } else if (total_mem <= 4 * 1024) {
+        secs = 30;
+    } else if (total_mem <= 8 * 1024) {
+        secs = 60;
+    } else if (total_mem <= 16 * 1024) {
+        secs = 2 * 60;
+    } else if (total_mem <= 32 * 1024) {
+        secs = 4 * 60;
+    } else if (total_mem <= 64 * 1024) {
+        secs = 8 * 60;
+    } else if (total_mem <= 128 * 1024) {
+        secs = 15 * 60;
+    } else if (total_mem <= 256 * 1024) {
+        secs = 30 * 60;
+    } else if (total_mem <= 512 * 1024) {
+        secs = 60 * 60;
+    } else if (total_mem <= 1024 * 1024) {
+        secs = 120 * 60;
+    } else {
+        secs = 240 * 60; /* max 4 hrs */
+    }
+
+    return secs;
+}
+
 /*
  * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
  *
@@ -1668,33 +1703,7 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     int secs;
 
     total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
-    if (total_mem <= 512) {
-        secs = 4;
-    } else if (total_mem <= 1024) {
-        secs = 8;
-    } else if (total_mem <= 2 * 1024) {
-        secs = 15;
-    } else if (total_mem <= 4 * 1024) {
-        secs = 30;
-    } else if (total_mem <= 8 * 1024) {
-        secs = 60;
-    } else if (total_mem <= 16 * 1024) {
-        secs = 2 * 60;
-    } else if (total_mem <= 32 * 1024) {
-        secs = 4 * 60;
-    } else if (total_mem <= 64 * 1024) {
-        secs = 8 * 60;
-    } else if (total_mem <= 128 * 1024) {
-        secs = 15 * 60;
-    } else if (total_mem <= 256 * 1024) {
-        secs = 30 * 60;
-    } else if (total_mem <= 512 * 1024) {
-        secs = 60 * 60;
-    } else if (total_mem <= 1024 * 1024) {
-        secs = 120 * 60;
-    } else {
-        secs = 240 * 60; /* max 4 hrs */
-    }
+    secs = get_sanitize_duration(total_mem);
 
     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
-- 
MST


