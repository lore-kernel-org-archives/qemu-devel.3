Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E08C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOk0W-0006kT-IL; Tue, 02 Jul 2024 16:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzc-000534-Qn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjzW-0001gp-Hv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMkazJvXlCFuPVFo5zwsqgTLcz0EAKKfqUw3BcILaOs=;
 b=IS7G4fmEOyDxjyvngXeMTZu1s7pMhIe1ZYb2UvNhVqhDs/BydNmPJTg4PcCZkvbTZN/bGV
 61z2VaZeaREkTDyEtFuLMGxtIfoFZIgkBlwfP+Qx8O6HxybIhCaFTGnbU5bspmfiav2GlM
 P31dpiwm8wJfeXCvTQ9ef/3fTcHalOc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-3ck2n6byOgCMvhG8q5dZ0Q-1; Tue, 02 Jul 2024 16:20:40 -0400
X-MC-Unique: 3ck2n6byOgCMvhG8q5dZ0Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257f95fe85so18823315e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951639; x=1720556439;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMkazJvXlCFuPVFo5zwsqgTLcz0EAKKfqUw3BcILaOs=;
 b=BqsI3M44DQGv6QbqPSo6tbvNCcriETMMBhdv3lPt8kFtPoCN3F93Wg1y3Bx8C4rhZq
 jKm0HlgPCm9KkIYhBILXPNd4ncCgEnflPcNESbS8Na5ajYUhNTXHzOJtmurRIKtv+yhx
 K/IUBRktXZiiIcMVzbZk4xVy7HfUFntqw6UTsxFwBBaA2eG4iLgQRotqCgXfmj211PiX
 6W1feWUa8tfnmlvxtAhMZGpRFma4jIeuxNISZwfMvzHRRc1jLJOGYeku4D7VINgu6aAO
 eqWvTjO4svjnl05IK1qvgBXOA19lTOURiqmq7nPmmtOspd6M23QFcyx9z8ME9wIF8BLM
 il5A==
X-Gm-Message-State: AOJu0YzdSNH/54RiLEE1OqHwKMxASlEvQhcmv+QT+59dYnq9REiHr8Dt
 V8R1BVta9f/K+kfNHgIum6Av+LmpX4jZJj1KszvMIMo00pbDGtwIYs8DpQwZUQSbE8i7FTpBUjk
 IDGpLG/uzg7qNUn8+baFgY3dsIsoDrYOxrTmhfWrZOe+Gm80gaZjBUASrX83pck1XLy/mHXThgY
 BZziupGBAH94/v7Bhft52AW9B/Q6tiGg==
X-Received: by 2002:adf:ef4a:0:b0:367:92b3:f6b0 with SMTP id
 ffacd0b85a97d-36792b3fb91mr26195f8f.21.1719951638981; 
 Tue, 02 Jul 2024 13:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAF+SlkAFzGwtURNvVdFbF9BNL5XgDH8lttnUMErgQlryZynmCV6YMMTleK4DTI+VRjSbS1A==
X-Received: by 2002:adf:ef4a:0:b0:367:92b3:f6b0 with SMTP id
 ffacd0b85a97d-36792b3fb91mr26178f8f.21.1719951638424; 
 Tue, 02 Jul 2024 13:20:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12d7sm14135571f8f.51.2024.07.02.13.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:20:37 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:20:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PULL v2 81/88] hw/ppc/spapr_pci: Do not reject VFs created after a PF
Message-ID: <620ed810335bb71279404d1c197d5a15c7201b79.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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


