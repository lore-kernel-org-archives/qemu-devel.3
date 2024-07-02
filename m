Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B52C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeAe-000259-O8; Tue, 02 Jul 2024 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAb-00023i-ST
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeAZ-0007xO-3T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=SRqRxE+INEdBxpLankakr1IyxEwS5O06Rfm6STMRlQkU/obBw0BWPQFdVr9FbHecAZHU/g
 E5b6WJL4fXmsqxLS2qHkrfO79guWqfPn0YtyokdRXH4+6xCyjPNLB0NhwasHPy25bPnuio
 2o9/X+0EnQ4SMaW2KwbqEP+5PAOzfFQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-EUon15auNiavX2KnKmrBsQ-1; Tue, 02 Jul 2024 10:07:39 -0400
X-MC-Unique: EUon15auNiavX2KnKmrBsQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52cda76173dso3716467e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929256; x=1720534056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq1ZdMUpXgQO0jHpQkHjtkURKxmq/FjBLx45BW2ity0=;
 b=fdkZzH/HeETIEQ5B+/UT3yoFQbCpVvBQtVLJDzwFNspWYDo0Acluk9T6BBHnmQSqaH
 e/0lvXfeMAFv7CVYfTJ1LdF+9ASBlHunwQerK0/riCg85kGSwQHZzW6mTg4dnhj72Qvn
 aeCPZBCzfVJWt9Jxc0fg/1msPDqI9/Mw55PoddzRfu6B4t77aVYKWCv4kbCv/P3nx7l9
 MlV+OVMyCGg/s7Pi5bL/c9kb+GqMOvAMCshK2MS3ABod2w8o/Eu6sRba9SBjHr4e24ct
 Mln7/HxVAtyjulqiQ6eVt7+ZHNmRwfQGxjANNucVAZsMuSuaVy9bSqCN0vN5ZZlN51st
 p+pA==
X-Gm-Message-State: AOJu0YzfzxqjIhW74jjpdTGuOfbM4ma3BxZ+dNwOgYqoHTQ+oQVa75IB
 yFZgVA8uuJYiYw928qOzqvj8VWWHsQXUIdadUG+JnwuU8Ht1P6JaZd2dSa/TsKmEsnWgEF+QiWn
 1PKL8u/ua9zPpdHKal1R1uk2mpSZ+a/ue2+byIW/6asPSBLTj6Jf3gqYlq+aBCDzVknvpJamh5L
 OnVkVbW2+5S2hXSWY6NPEZIWVeeglVAQ==
X-Received: by 2002:a05:6512:6cf:b0:52d:582e:410f with SMTP id
 2adb3069b0e04-52e826fc39amr5980456e87.46.1719929256677; 
 Tue, 02 Jul 2024 07:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGymzmVHfBVpTtWSvIQDNsJDYacuIfyb5B3q5fYg+P0JgvBQl2JH1qR8VUY9x9SfW7OPt3h9Q==
X-Received: by 2002:a05:6512:6cf:b0:52d:582e:410f with SMTP id
 2adb3069b0e04-52e826fc39amr5980431e87.46.1719929256024; 
 Tue, 02 Jul 2024 07:07:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103371sm13371783f8f.101.2024.07.02.07.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:07:35 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PULL 12/91] virtio-pci: only reset pm state during resetting
Message-ID: <84b58169e40f5c7428db6f0b229e01213068aa21.1719929191.git.mst@redhat.com>
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


