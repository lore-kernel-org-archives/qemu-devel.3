Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D70C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjte-0002RV-84; Tue, 02 Jul 2024 16:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtc-0002Cc-JQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjtb-0007bm-0t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=KuqoQOd1lPhEL56Bqe5uLZ9VNWUKg5i8BRklNb+HR+NfPCyPd8EshPomreXdZ5Z2DCQPXY
 Fm1prAl4ct09kXroQfOqvMImk7koXvarYQXuhkvElLdTTJmIpw7cCqM+5ML5HvQiu/c7Nc
 iFlQWobmJsjIREZCM1808HCk2LF27E8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-5b1mqgrtMiOB70NQtx1_OA-1; Tue, 02 Jul 2024 16:14:33 -0400
X-MC-Unique: 5b1mqgrtMiOB70NQtx1_OA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257f95ffc6so19690965e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951271; x=1720556071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=VrRTmKjFB36GV5u53VrBoCt6+PZoi6ddKODoNmS3xIqDw/hYLbOlsjue/nfGblFda8
 JS+sP5pLP/c/hbuiKR9UXEdnfAf+8Fkmu4PcesBH0viYK/gYG92DO7Vmw5YMydFvUiBV
 m3swvYqcTlRuCVZW+55nzH4wa/+6dovg5ehYlzNUELZMBFjWQOpdAGowmbLVyzmHeYM5
 Hm1DkWK4k1TsYR26tN/BDWVeoCFCUnOzzCwIk1PHA0M9l1bKbQsetSVv3Nb97VNLmPWy
 Z2tzGPqZ0ktzGPWcn3gyxG1TqEQ58IyJLngfAKnFB8BqnrpEn7TlZ5F8tXJjbvEsZy6J
 vZPw==
X-Gm-Message-State: AOJu0Yx9owTMo1q06Vs1sI/w5lm9YrxoAhzmNnDGcynVX08R8IUxqB2o
 Rp+Z2YoS3t0n0NOc7yaZBbCp+K37KIG07/xIECs1W52WlPf9YNlCXIqWHSdEzkSgVOlt2ssdB4l
 GFzhbUC3wh9ZKHT7w+PPW2+QFQBqyq+eHSCMoG171AevWkdnYcGcMRQVWAXd2SBDxmfYOVAqqBn
 a3+1fgUd7/WIl0TOrp9hdPb9WTpvLyyQ==
X-Received: by 2002:a05:600c:3b09:b0:424:a721:1d0f with SMTP id
 5b1f17b1804b1-4257a020eeemr62966035e9.29.1719951271367; 
 Tue, 02 Jul 2024 13:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF5NifnjEM7pOIcbG0FbD0SBlaYpfCpFm068A60biJnDoZCAPxzefvX60afDOkcxl8CwJTPQ==
X-Received: by 2002:a05:600c:3b09:b0:424:a721:1d0f with SMTP id
 5b1f17b1804b1-4257a020eeemr62965865e9.29.1719951270768; 
 Tue, 02 Jul 2024 13:14:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f26sm207952565e9.39.2024.07.02.13.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:14:30 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:14:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PULL v2 12/91] virtio-pci: only reset pm state during resetting
Message-ID: <84b58169e40f5c7428db6f0b229e01213068aa21.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
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


