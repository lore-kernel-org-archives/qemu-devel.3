Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0654CEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAi-0001XZ-Ky; Wed, 04 Feb 2026 14:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAg-0001NM-WC
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAf-00084M-As
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+1WFKTjVp47HncRnSj6FI8Ibq6JozGOfoaaqKU3fvk=;
 b=MKb/smesD+bSiaR0dN9r2zAU0cb2iSlsdIxz34P//L+1cVM00Jn8c6S36GuPrHSQSrETPW
 +0IeFvB8huFxh7phHdYrZG2dkwcJLgwKkbcQcNNVZwUD5HLIsOELAa3Ja38xMhizIQhsTb
 oexlQLyHXAw/hvXRrVm0dvGTOnaiiEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-qVHctL9YPIGtEQ5wgsW0eg-1; Wed, 04 Feb 2026 14:04:11 -0500
X-MC-Unique: qVHctL9YPIGtEQ5wgsW0eg-1
X-Mimecast-MFC-AGG-ID: qVHctL9YPIGtEQ5wgsW0eg_1770231850
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so1014095e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231850; x=1770836650; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7+1WFKTjVp47HncRnSj6FI8Ibq6JozGOfoaaqKU3fvk=;
 b=HR6VGbG0DCbXXd9zc3rIqabt/LViUDQzk+Txl2gy5FU3KWcvlP3/+kYrPcLKzSLWvN
 kE4b2RVOF1KVV+numo5BoWY3FGtx4R7CQ5wW9ri0PRqg0maVtmPF8Q8Qzk43VGb2dWa/
 2Ko7P8qJjcs3HtKBUFIEHm1/TGRd6jBKhukGwGoFxudz+udimpp2GRkqSVUmvA79gs1M
 +wWFRwOBjCcjeiZvSGATduXku2+BcHKIanuZbejO6mt0vKQVYAckb6qM9KwmACAIUIAS
 zhJH8KHFgfXDuzSD3Eo+mK5dLFBVJKzysVr0LiIh6OFVuJL/vun/0xcTg9Ln4MrqWQUx
 M0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231850; x=1770836650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+1WFKTjVp47HncRnSj6FI8Ibq6JozGOfoaaqKU3fvk=;
 b=NuJmxj7JdQXJgPQC9qbNh7mt6sLOgIAQuWk+76lrxOxLu2WxAS5rN50FNNILZlZEpT
 LTQs+dSAzX3HL1IjQrOmwPrGsJBWBiQqu/AVfxD0HrMjqfKveHwVLuJj4NtRvpIoItSd
 134q3Z5wJcEdpnZkR+7TNwEGUY9BU8cD98rkOCCOKOqRbPmonHVcBbMKDNK0kNma4iUM
 06UsY6yPdJl20j8Yb96RLFh622V0ylc4oJgJXAHwH0ZJCl5oLtN6a0kyA7l/7W1GBqsY
 dLxvtwiMYMZaSW7yRLjKgAuVJmCfGDJ0qBA3MkXfbNR/HJeIWX0NOKgwd2tHp67pC5P5
 n7ow==
X-Gm-Message-State: AOJu0YzG4JZB7WPdkDdE0tfI7a7fYH3W5O2nwdbZ8Ry7DilzchEccorZ
 f3iwpxkvaKApMO+mfJ5cw0gAD2QetOMvWJcXKN7p/5KmSFbLBGIMgvLx67lqWovmUiF5Dcc13PM
 4WQn23bVnC+UPxh2nCxNM9rQunZF9WBwSwddI1K05C1LuQzCHIZLXHCPGKKaXVFw/BC+E8kkSuh
 8LbgUaa7wSqAXArsbk6XXeE/qJtsW7Pi/wmg==
X-Gm-Gg: AZuq6aKLQRVBctP1VD/YzVvmwf6ZeRb5Rmc8yJ+9cEMAOFvWSOjFFPh0deHSDCVl33j
 C5CVYVEyyyp15+gt+exu0Puclnkaj7RqtmqfMqmLYQ869WQr3NdCKEYTG20XxJbeBY9zKcgRBwx
 b+Z+dBWQ6UvAJjsMxDazoJTsIFwJzLcpppWAKcWFFBCTg7YBQkha6DD2/HFJuYAludKeBVDFgVL
 NaSyRWy/8rltrMPcSgoP+4PEHwObDMKFSeiiSGxBQUMGl53IzLyfn300x3BvehC/p1Fwoq3A2fy
 zpq/hT5RfzjJry12CyWclKDP0q8r/MtRmfGR4PFBl8l1PoZDRsvX4HEFEErhFDlohNWhNKIvt/L
 2Bldm1tMWBggfZEHInWDdwsw9xoB/of964A==
X-Received: by 2002:a05:600c:8b38:b0:47e:d943:ec08 with SMTP id
 5b1f17b1804b1-4830e98aa59mr47502015e9.28.1770231849912; 
 Wed, 04 Feb 2026 11:04:09 -0800 (PST)
X-Received: by 2002:a05:600c:8b38:b0:47e:d943:ec08 with SMTP id
 5b1f17b1804b1-4830e98aa59mr47501615e9.28.1770231849384; 
 Wed, 04 Feb 2026 11:04:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830fc0a3bbsm50103375e9.1.2026.02.04.11.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:08 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 34/51] pcie_sriov: Fix PCI_SRIOV_* accesses in
 pcie_sriov_pf_exit()
Message-ID: <0321a3a48cf54ee091726cd61fcb774693431a47.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kevin Wolf <kwolf@redhat.com>

PCI_SRIOV_* are offsets into the SR-IOV capability, not into the PCI
config space. pcie_sriov_pf_exit() erroneously takes them as the latter,
which makes it read PCI_HEADER_TYPE and PCI_BIST when it tries to read
PCI_SRIOV_TOTAL_VF.

In many cases we're lucky enough that the PCI config space will be 0
there, so we just skip the whole for loop, but this isn't guaranteed.
For example, setting the multifunction bit on the PF and then doing a
'device_del' on it will get a larger number and cause a segfault.

Fix this and access the real PCI_SRIOV_* fields in the capability.

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ('pcie_sriov: Allow user to create SR-IOV device')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251205145718.55136-1-kwolf@redhat.com>
---
 hw/pci/pcie_sriov.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 34e0875d21..c41ac95bee 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -195,14 +195,17 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
+    uint8_t *cfg;
+
     if (dev->exp.sriov_cap == 0) {
         return;
     }
+    cfg = dev->config + dev->exp.sriov_cap;
 
     if (dev->exp.sriov_pf.vf_user_created) {
         uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
-        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
-        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
+        uint16_t total_vfs = pci_get_word(cfg + PCI_SRIOV_TOTAL_VF);
+        uint16_t vf_dev_id = pci_get_word(cfg + PCI_SRIOV_VF_DID);
 
         unregister_vfs(dev);
 
@@ -213,8 +216,6 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
             pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
         }
     } else {
-        uint8_t *cfg = dev->config + dev->exp.sriov_cap;
-
         unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
     }
 }
-- 
MST


