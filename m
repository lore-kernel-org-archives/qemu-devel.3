Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762ACC27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0B7-00067x-0d; Wed, 05 Jun 2024 19:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0B5-0005tI-0z
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0Az-0005kC-RF
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0HOmEGBKVd19MvX+tjutWxLYb9ToOXOEpHWAIoWqrE=;
 b=Oao/dyYb8ndGRMBAnNFgXsQVNn5+ZV5HPBBlxeUtmAFzWEHdnkL+vijjwIexh2qMJzr6ND
 3tyw42LK6cD9zLdqdL+ZgvHyFVl6HBDlOyl1iIrqSqgbfx/HMAGF/rq3OIDZQzpNRivFe0
 GU5jUtSPh6BiNBbcEntk/pp9l+lDpU8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-D9grAe2tMWqsaLh1J-Md3w-1; Wed, 05 Jun 2024 19:35:29 -0400
X-MC-Unique: D9grAe2tMWqsaLh1J-Md3w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68ccd15540so12868166b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630528; x=1718235328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0HOmEGBKVd19MvX+tjutWxLYb9ToOXOEpHWAIoWqrE=;
 b=tc1CFb2WaZsAKTMws+h3tHs1eOJHaII5VU8rFjJfJYAqMkNYqqwzL1xy1RpRNJrV+3
 AQu/6frSD14MKpksBjIa4rofvfKLOaGU/iK9ev8jcih15F7ja4pImyyStSj2b+HPx4C1
 ITStz8Q7g5j9jBLBIjfu+G9xeve68zzZWTdqUWY9yVzC3pLXZNkAJbBugvcKVWuZ73rD
 f83GlhhtmLZnH/7nwFmaH++sON57xHvIFcQa2bQc1z2UpQGuXOSuEd+5Xijem7/E7qm9
 TY28/OFIdwTfS8q68J633vMKPOlQEBo6YGLUDeMN+FMnfOhBH7myfGiODghPbOBSQ3o8
 hVrQ==
X-Gm-Message-State: AOJu0Yy+ILH378YIb4AALpNiJTKb9jZ0u9GiJnk7US2hD/7ETfO1Teq1
 IdMl5ZJARq6KS/jdwCR8Y52G61eThYV36yM9m91OIyxx2ofcckvenIAVh/Bb6HWmw6XfPhD+O8M
 E+4ZNEG8BeFtVJo2z4p2BQ+/EcWtOE9fDJ9lgceJteQjhifWrzfoNTqQZZo5t+OQFf18XfMao3+
 fDyYYhr6RlsT6LYsxxWMYNbEVb+WIsnA==
X-Received: by 2002:a50:8716:0:b0:57a:1e0a:379f with SMTP id
 4fb4d7f45d1cf-57a8b6a7140mr2317180a12.16.1717630527956; 
 Wed, 05 Jun 2024 16:35:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGJyjFyW6H/Q3W0BkX/oMTwdJK4eQgNH4e/EUTA9DQD+ofKAnk9ESGcTZvMWZAgOwZksdIZQ==
X-Received: by 2002:a50:8716:0:b0:57a:1e0a:379f with SMTP id
 4fb4d7f45d1cf-57a8b6a7140mr2317174a12.16.1717630527458; 
 Wed, 05 Jun 2024 16:35:27 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13faccsm98396a12.54.2024.06.05.16.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:35:26 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:35:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PULL v3 12/41] virtio-pci: only reset pm state during resetting
Message-ID: <e4cb9f8957337403b67a4ca22b1fa95290286ff2.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
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

From: Jiqian Chen <Jiqian.Chen@amd.com>

Fix bug imported by 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
After this change, observe that QEMU may erroneously clear the power status of the device,
or may erroneously clear non writable registers, such as NO_SOFT_RESET, etc.

Only state of PM_CTRL is writable.
Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.

Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Message-Id: <20240515073526.17297-2-Jiqian.Chen@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cffc7efcae..7d62e92365 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2306,10 +2306,16 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
     virtio_pci_reset(qdev);
 
     if (pci_is_express(dev)) {
+        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+
         pcie_cap_deverr_reset(dev);
         pcie_cap_lnkctl_reset(dev);
 
-        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
+        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
+            pci_word_test_and_clear_mask(
+                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
+                PCI_PM_CTRL_STATE_MASK);
+        }
     }
 }
 
-- 
MST


