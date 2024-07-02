Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F4C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjvj-0006z7-GO; Tue, 02 Jul 2024 16:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjv3-0005rJ-En
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjv0-0008Ac-93
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=Rpi5gpX6amnm1cFMNEHaGV9/8DTBfvUyldPl8pWiJq/ELjGjO/07eIVo4WSCwZ/WW6hXAJ
 pTXWvK42eFPct6CbtHcWY/bA32g8MowVdlRUcqzcWheSBhx6Wx1SYa6kWdw7g3fzxW3apU
 bEG4MsZ8y0qxmjG3y5s6qg2KjSrNwLw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-SppjbDLDNLaEYXUJ0FICFQ-1; Tue, 02 Jul 2024 16:15:59 -0400
X-MC-Unique: SppjbDLDNLaEYXUJ0FICFQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3634a634f8aso2622996f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951358; x=1720556158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=IQe6LhSQ7VK2Fsm8ppUwTTKNRa8G2TMhmGuomDLvoYOoVklQZV6tNplwblTn+on0E7
 V5jwqBri6EfXKheqvoN5zNmQaRa2mQ2CvMvA8vQPVNU93rPPF1vgavVh2oNtNiKQ5xFl
 ZARpozqV+LLLqtpbegRj777D14WwFekh3j1PqFAlaOfskyEL+7QbYhZMQs4mbdxUXjTj
 XQ6xdGXJ562ciz4mJKUDySWwoe235bkkoW8QYa5PMWNC4BoJERz/J3yQlFZS6eC8089v
 sLWnp3zMOQ9yov4qJIWPzQb2E1zk6EcMx6YQAz9a3jyUB4JxhehBekQ1WG3iyLhGUbTQ
 MZGA==
X-Gm-Message-State: AOJu0YyjNDbpDaidW8vqpazqLYsCnh9KD9tnijDcXePESpshzR/+hWdB
 YOdFAjyaP4AJQkiS8hEgTMXiNSqQB1uEXxX3kw1ou6j0M2mGlDtpfUpTmKHVikWPejI7DT6mnAT
 ouuNhkRWd9fWY2HU+ps6eJ4EogAwSaWVGTG6CsbAGxVrg+AY3K7VB5dUCmy5jFwzNBEDMqaAh8r
 bdVZ0XnI3wFaiTcPEMwDXzvGnX1Bse6w==
X-Received: by 2002:a05:6000:1fab:b0:367:4e05:bb7b with SMTP id
 ffacd0b85a97d-36775721674mr7550001f8f.53.1719951358071; 
 Tue, 02 Jul 2024 13:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSSEToziFIBuKUpPUwh8bMTLGOpiOk8oLog55IQkWMUGS9uG+en9DkEgSDNZGtG/KtjsmlQg==
X-Received: by 2002:a05:6000:1fab:b0:367:4e05:bb7b with SMTP id
 ffacd0b85a97d-36775721674mr7549957f8f.53.1719951357061; 
 Tue, 02 Jul 2024 13:15:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1030c8sm14075123f8f.98.2024.07.02.13.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:15:56 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:15:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PULL v2 12/88] virtio-pci: only reset pm state during resetting
Message-ID: <84b58169e40f5c7428db6f0b229e01213068aa21.1719951168.git.mst@redhat.com>
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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


