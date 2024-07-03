Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0685AC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8nu-0003Xr-Ph; Wed, 03 Jul 2024 18:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nr-0003FT-RI
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nq-0007Rl-8z
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=actUboiQ+IrTgCsdz18KhXUIoDAvYkrEhXUsAIxh/Nc=;
 b=ZOMPW1bNqKYYfm1AP1dYJiw1I9FLoK0ZLYehz+Fx4+SQd4zbg+/vLSrG8thyw0yKJQzrtT
 gKVHJ7YRn+A75K3ZbyxMFD18VHYCXj9LplI0LAexcwLx/vR8jQFbHO12K3WjbErKlsSUt2
 v/3PGBaxejrJPoawPF78DUdZHZ0ImQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-YLK5RpOCOCaZOGW5uBkhmQ-1; Wed, 03 Jul 2024 18:50:14 -0400
X-MC-Unique: YLK5RpOCOCaZOGW5uBkhmQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4263fff5eaeso105725e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047013; x=1720651813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=actUboiQ+IrTgCsdz18KhXUIoDAvYkrEhXUsAIxh/Nc=;
 b=ZXmG2Za2GEhoy/fgjbGcIEx9IRUjDAjw8yZRfQdqQg9rngm5pHvREpUkC8ipm/VhTB
 93zJ7CXcg5l6mNUW4OVQLzSxfsnmvB5OOIXsBIrl+g6QtnT565J8OXtS4WTL7LHLIHwS
 ycB7rLVK3FTFeZLtQZnOCdmx0S1eWSo3LzmxX8Mm3CyEXStfXlFtddiloJByAK+G2/Do
 +dnFed8OAzEhEk359u60UkSuUceCNrAvTKAZeBM9IRUyZLvV9wCro4ZsurycQBdaxKdl
 z7UJYoL9wAB1vtfQl/nC4/9QfG0pPtuftYGTyF3ZbgsonD7QL05n8D2u1yK+NH304q8F
 49dA==
X-Gm-Message-State: AOJu0YxPi0C+knJlavaJAlCyD5UPDtEdprRl7hJGoWX5XWvYUnhcrLdK
 mm3kDI3ENb3fnJrHtyHdujohPLMy5W5EnXSNucesmVMuESGln9f6aJT6klVPwwS5iU3YM/yJMRr
 ldUkDW1GFKWNNxVbpMsoHPbIoUA6tluMZmzYWJgvXlDXrCTvvF8SzKzDouONXZbPyMpu45MOJb5
 mjT8szZAPEuD8EQtUolBVkvjMhN5NK0g==
X-Received: by 2002:a05:600c:63ce:b0:424:aa83:ef01 with SMTP id
 5b1f17b1804b1-4264a3d1e2emr357115e9.10.1720047012991; 
 Wed, 03 Jul 2024 15:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXo/zzTggwe17jzj0Xhk3SPjb+uH2NxGoezo62WozFu8slXIycgNJSg2oK2kTztQNBOV4Mfg==
X-Received: by 2002:a05:600c:63ce:b0:424:aa83:ef01 with SMTP id
 5b1f17b1804b1-4264a3d1e2emr356935e9.10.1720047012419; 
 Wed, 03 Jul 2024 15:50:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cbb7sm1204725e9.26.2024.07.03.15.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:11 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL v3 77/85] hw/ppc/spapr_pci: Do not create DT for disabled PCI
 device
Message-ID: <723c5b4628d047e43825a046c6ee517b82b88117.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Disabled means it is a disabled SR-IOV VF or it is powered off, and
hidden from the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-2-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7cf9904c35..f63182a03c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1296,6 +1296,10 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
         return;
     }
 
+    if (!pdev->enabled) {
+        return;
+    }
+
     err = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->offset);
     if (err < 0) {
         p->err = err;
-- 
MST


