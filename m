Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3091C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKv-0008BF-Dk; Mon, 14 Jul 2025 19:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIa-0004R8-Ky
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIY-0005sG-U6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nWTgx9OOmQrzNpl+Eee6xG0XRq2aOUUPbQTx1jMMcO4=;
 b=i/8aXuZiK3K6Aa9WURxKo56QYQG/hmAH1r6AeSgkMkGV+pZmuQdES7hW9loXvXoUOnZUAm
 e75aTVgXO7Twn5tfU4xpkxwrhoc577BGuwNeHXEFi6jc9Vh7ESnOXF2zAlbjEyo8tRAepv
 rVJOTSeHxljQeGsNtKo+fa1irbflulQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-BKABEcG_MJqv_qQ0C6ikaA-1; Mon, 14 Jul 2025 19:09:23 -0400
X-MC-Unique: BKABEcG_MJqv_qQ0C6ikaA-1
X-Mimecast-MFC-AGG-ID: BKABEcG_MJqv_qQ0C6ikaA_1752534561
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so25170285e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534561; x=1753139361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWTgx9OOmQrzNpl+Eee6xG0XRq2aOUUPbQTx1jMMcO4=;
 b=AP5zeV3aD7Xn+DqewXI0LqlamcmtcGpbJiZ81LGQm5fwM8jKNqCSIHuH9FOI2KdvUP
 nns3wGuBs9mUvZce2d/rdApBtEaumYM+AB2w7pjR1PVns2ABrwjfGqmXjb4/+Eq9geWw
 x664HSOXL5lKOgTffuFZ6gCjpCWWeguitc8skUsst/d746zY6Mq/qcGX2AIdbTgvj0JT
 L8rflCQLh7iLpRkaCXuzM7tSvbemiT1wQ7Mvgac2r2UKioYBc1nt0FExWEcMaR/cM1bk
 wzz4iIHuAvXWEwYB1kMRN6E8Gy9h1w94UeLYUOr7t4vTUr/qgfo5+DMmAau+VDUAIArT
 xnPA==
X-Gm-Message-State: AOJu0Yy2ifw/+VJil+15LV+WglG4SnpK6CKdvUu+m8gn81Ml7SfpvkLA
 iD82h3EXfTIAoGRR+OLFsdFC73xQzCWogc3FYt2WNg435XzPYpCxw+q09m7adDUtRl9h3f9pRks
 YeURr/ZGiJlHAq24AAQ8JT93GioLx/cRnyIbtZfn4uaXzBYFOZfeHi+JlfthF2PJcQtzjaVGSIf
 bkubqAE87gcVrKKUjwt7+GQqVfng67FLzYhA==
X-Gm-Gg: ASbGncufSh4bkowfq+Cw0J8NE2Iog+OcV4X1Iy5unA8J4T+dqEV1KXnaMGktU49gVAX
 PU98UNgOToLkTauTmrv54lg2lJip7nmlatzXaq1SV2WoTIBXU3YAE86L3UglFfpw+tjb12ZyWcU
 tQk9xNI9z4CfO8bfI7SAlQvw9jVy7L3v4qo/VfBtvsL4K7ga07BCxV1N3ksOwmcaxwgiJGEZTif
 24B9t4dmvHaksrPbBrpviJG61LZdD3cK5kKl2S0AqxFEFwhMTx4J6SbYncOfnIYcY1uM2IrVJjs
 n/HdHYliGug7YV6WDJSiGCyh+gSS7oHu
X-Received: by 2002:a05:600c:4ecf:b0:456:24aa:958e with SMTP id
 5b1f17b1804b1-45624aa9786mr19627175e9.0.1752534561343; 
 Mon, 14 Jul 2025 16:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa/OVUbHxTW5QCZ8VAm3s4vhGBi/pvLBF02n0N6fAUc1zCjvIlOrw1NmHrzTAiGoovUfsBBw==
X-Received: by 2002:a05:600c:4ecf:b0:456:24aa:958e with SMTP id
 5b1f17b1804b1-45624aa9786mr19626955e9.0.1752534560887; 
 Mon, 14 Jul 2025 16:09:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560ceb1337sm81503405e9.13.2025.07.14.16.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:20 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL 71/97] hw/arm/virt: Pass the bus on the ged creation
Message-ID: <c919cff502f6c149d7cf38576ccbf8a7e044ad44.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

The bus will be needed on ged realize for acpi pci hp setup.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-26-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 817adedb31..41b5086b55 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -701,6 +701,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
     dev = qdev_new(TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
-- 
MST


