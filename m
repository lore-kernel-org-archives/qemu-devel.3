Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEC9C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEW-00086s-BT; Tue, 02 Jul 2024 10:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEN-0006pI-DI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeED-0000UH-11
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMkazJvXlCFuPVFo5zwsqgTLcz0EAKKfqUw3BcILaOs=;
 b=TMgR6j9ZiVL5cCpFe+m3zetmMe87J/RuelLOxoXxjgk/+bI5/57RmVzE3CqWLnpFVZWXUM
 bhw1ML+66KtaJpd8Cmwwm7+EKYODheU4qB382OTD2hLtlyQjDZ9VtEbBzJjNO+cFnrtrR9
 ++CfNJ4MWbCfliLTv0OrR1eLZYkwcBA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-xryIpZtAOsCAo4wgJVp4wg-1; Tue, 02 Jul 2024 10:11:23 -0400
X-MC-Unique: xryIpZtAOsCAo4wgJVp4wg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-425739141c2so27428985e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929481; x=1720534281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMkazJvXlCFuPVFo5zwsqgTLcz0EAKKfqUw3BcILaOs=;
 b=BzF6p/Mp529MeKyduDcsiUzkQ395e0y7vBCSgZNFNYFYLpEaHqu+IllGiOcOCJ65Fi
 4EywgLpXDCHvIyaH/XiI1wccv+zOYOpmvGVqzGv9HAdyOvlb16V4g/Q5jAVR1WJfgreF
 dcKIiYxIzTCr2J0OmmbJ1oIh7sM4UfWBlTHorxuWqr+ir7Q9RCCS4na+p+5wknAhmp1Y
 L8cb3O7O4VYcIvhK1XgI4zRHya8QFONiaRP/HRIrML5+XxT9oXKcESgzMA66luuF0O5Y
 SZ7GDKb743thAHSMCuSBbQIfi5Gscl35Z40KEM8nUkg5+QSNjKiJ6JgB1kL0o+YR8Wcy
 haCA==
X-Gm-Message-State: AOJu0YzLcmwRVlTdUAykbvmoH1fb2rJXGRRg0lUmo2G90GcKr0OtpPhf
 fKuSoxrBDp1Yhzc/mjERyUTUCvowy7Azh8jMVcewQz+lQJNCBKgTc57/QBXIspctVLgD9H27LDy
 8VsvmCvDE8Mp46fSaImCG3VQXQsJzxvJbWlLJZqj+yxdy5IlwtSwo69OjLnFsTgHe6XPwn2Mvn0
 pdKx7MTJkG+b9nL25xg9yEPXv8wGJBTQ==
X-Received: by 2002:a5d:69c8:0:b0:367:8a72:b8b4 with SMTP id
 ffacd0b85a97d-3678a72ba4emr886275f8f.33.1719929481763; 
 Tue, 02 Jul 2024 07:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYxAuttfnTxopd9weeQrALkLr81tt4e5N16qWnGw/1xYosbp5grhiwDHHcZaOVB4BMH40KMA==
X-Received: by 2002:a5d:69c8:0:b0:367:8a72:b8b4 with SMTP id
 ffacd0b85a97d-3678a72ba4emr886250f8f.33.1719929481221; 
 Tue, 02 Jul 2024 07:11:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12e2sm13316329f8f.50.2024.07.02.07.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:20 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL 84/91] hw/ppc/spapr_pci: Do not reject VFs created after a PF
Message-ID: <b11da42aa0c5c3fb5f071116fb50ad2847f2a1d9.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-3-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c..ed4454bbf7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",
-- 
MST


