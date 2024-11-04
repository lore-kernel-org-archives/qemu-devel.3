Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C38ED1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Ja-00071b-C1; Mon, 04 Nov 2024 16:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JX-0006ri-MM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84JW-0005U0-8e
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2USYzZLIHQIzWKoyt995uWr9ICCZOVYtkrr3QOPenyA=;
 b=Udf5VWHp6RIhgLWosGU1K3cVtlU/wajSN1MCY2AXzts+n/zlBkqtdiYlk6ahJTOLJbFS+R
 m77731yWM5GYFGQLFnfkldhT8zO4tkdCTTe8ytDw6XEAPc7mRgnwkMmkWsFd3qLblIGfRy
 KPX9/ZD0mAAzEwO+sKSWS48Tjb2Qi/g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-QCQiwaDDPV-CbojRqd2iYg-1; Mon, 04 Nov 2024 16:08:39 -0500
X-MC-Unique: QCQiwaDDPV-CbojRqd2iYg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539eb3416cdso4957842e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754517; x=1731359317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2USYzZLIHQIzWKoyt995uWr9ICCZOVYtkrr3QOPenyA=;
 b=PC1Sbt47/GkZZfCLFHbcGr2vy9Cv8G/l9cz0uc315JxmObSB0bDEB2pdZcEqthljFM
 9aiz4nXb6Mg5xrbj9UTclArYDMreewl9PWQuU2r8uv+aCchPgc4vPFc1A0dc8URSML+/
 8B27IaEZQCtpVSVtaja0D1yRkdMWW4I06JslnrNW07d9u4H8PtjXHWRgn0D70IxauVLq
 tzG7Z+SHwWleMePgoZPikXyrJ3CNxu1TGchjsFLZ8qjz/IAgEwg5NlgFlhy2IVwe6ZOq
 6ACe+d1AhwczxNlvZfopkvMSExd5wN0Nw1/9vcUI2lA/BqQNmOdReMjlCRHef5jzYTzH
 55/g==
X-Gm-Message-State: AOJu0Yz8Hbr+BNTcm8pcQVv24N0Re9fscExwUAp85oSu8gZ2J5WPYbc3
 ijMErQMz859yyrSFVjo+N6YW5RzeX753UYSQIGiDv5ztNgtUFJSHdsgJTtB3Ahp3jfErPZ31LGE
 duasS/A1hZAXSmhv2aw8LqmMyeum+WpNfxn0nHqGHEyUQCrnUosk7l4cDxtVDncAlzClTkkrieY
 XeLGNJHIzFvrFA4f1swW+NTMf73FD+aQ==
X-Received: by 2002:a05:6512:ac5:b0:539:fda6:fa0a with SMTP id
 2adb3069b0e04-53b348c382bmr16259263e87.9.1730754517099; 
 Mon, 04 Nov 2024 13:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ6ig/RTupJ5PVAb3ZQ4qG5p3//jKxQ/JhZYTkZ5CajGeMpi+3tsxQPgTzG1i4jRUCU/j+FA==
X-Received: by 2002:a05:6512:ac5:b0:539:fda6:fa0a with SMTP id
 2adb3069b0e04-53b348c382bmr16259243e87.9.1730754516584; 
 Mon, 04 Nov 2024 13:08:36 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e7f33sm194173955e9.6.2024.11.04.13.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:08:35 -0800 (PST)
Date: Mon, 4 Nov 2024 16:08:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 45/65] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <0564019bf1d9dd76ee7d212c26cf40e73eb3a00c.1730754238.git.mst@redhat.com>
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

In the function cmd_firmware_update_get_info for handling Get FW info
command (0x0200h), the vmem, pmem and DC capacity size check were
incorrect. The size should be aligned to 256MiB, not smaller than
256MiB.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241101132005.26633-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5f63099724..8bb0d2dd29 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
 
-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
+    if (!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER) ||
+        !QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER) ||
+        !QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-- 
MST


