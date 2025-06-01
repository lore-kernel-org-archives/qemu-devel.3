Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8AC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYt-00022C-2f; Sun, 01 Jun 2025 11:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYh-0001rc-LM
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYZ-0004P1-NY
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K3hh+nsreMps0mGehLZKh8JmUU9TDLRDwrt24jOn5dk=;
 b=KSxlqFXnaK9WpOVdL9ITiyKeSxusrjph4Z0cwhKA2Cb6ILrfw9Aa6cMZYgwjwZshpZfHCO
 ByCkTEnQurQ1MFEUOWCP4AP3b3EjL5XPbTzGaJlunCbNA2UsOp6gTFAmidXLZhbny6xx/Y
 cMxn54Li/RHfmMDuXOr8F7U+ekwi3iM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-HCpmHa7KOcSxqaPH9EFg5A-1; Sun, 01 Jun 2025 11:25:01 -0400
X-MC-Unique: HCpmHa7KOcSxqaPH9EFg5A-1
X-Mimecast-MFC-AGG-ID: HCpmHa7KOcSxqaPH9EFg5A_1748791500
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d6768d4dso15953155e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791499; x=1749396299;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3hh+nsreMps0mGehLZKh8JmUU9TDLRDwrt24jOn5dk=;
 b=IjJeriwc8/qMNehq332QfQ+56aX777pRg4i/8p+jOYQ2D4jhPAZjQ1+gaCFod8gFHS
 aglGRG0T3gygf/jNAwTi8TPycTbpzKJvqktkZKLI0NhcRcTWGo0Wzb1RdiculB3676OK
 VmyE5DQgTKd89rFHMORy0YnuHDnOopmuSEkvvTR5ALO9I0XMtHMrmjnTWE5o8uAA//oq
 WI4xCWe4VObwsAWfEmHZFTm7rqgArTVJUg7ah1LVZBlB7mpB/X841+/8uAbnm23kxfoo
 L7BJFLmhxiIom7CMVDNzW9pWin/ZWMBHAAj2b0zmGYNphkttNq6J1gaM2CL5oJR4GYFH
 +B4g==
X-Gm-Message-State: AOJu0Yy8bLcszucU4WbVgtv7RGMRq9vEjQOWxTduwJJim0Y0JewR4jVl
 wEaYK9ioV3E9nLhdUl9YkT8+BqAeOZjns3uNoM5xRp5zz/CjjOX0bOFfxTs8GeBxCf5AYD0h2CA
 wrED6qhgUH/7rtQTSjcttxJJup/5EXreoV/EAydDG8iw/JzepNSvE1sLryhOwiPppP9/6xY//QS
 KPwUckTyowUcXp+wMr6e/73wHDN80Ai9NK2w==
X-Gm-Gg: ASbGncsALE5wNX212eeHXc8U3v3pwtYvvIH3JSQaHZZvWoEXTaKSgD2FyI4yxPBx/cS
 LEHgXAbJA6mMd+j09DaNqfNVHvzhJeR+wjxmhoyBfUNfQ7Qbnm1MyzsbTnOif0JZ1W+VwH22jXD
 nsWJp2RXCXkbyQl/aUqR8A/PmIrmYbopArq4b8Z4Y4ZJQO79WU31625VXV9Fcv8x51Y9KfbQaJn
 1zpf61hze0QerpFXl+2K0jd5vBo5UlThow024gJgC++nHfHbEcCJbSVDJ2MZtG/oo3dme0ScQ0y
 hQywDQ==
X-Received: by 2002:a05:6000:2586:b0:3a4:ef0d:e614 with SMTP id
 ffacd0b85a97d-3a4f89d30d8mr7536985f8f.33.1748791499428; 
 Sun, 01 Jun 2025 08:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFYcQF/339ewniPmbtp+gM8KQO5fTU849NVHyrDzN/N3VoKh69PSUz2qgEZPNagOTR16hDgA==
X-Received: by 2002:a05:6000:2586:b0:3a4:ef0d:e614 with SMTP id
 ffacd0b85a97d-3a4f89d30d8mr7536963f8f.33.1748791499035; 
 Sun, 01 Jun 2025 08:24:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fc24d7sm89368775e9.36.2025.06.01.08.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:24:58 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 05/31] pcie: Helper functions to check if PASID is enabled
Message-ID: <1e82e8a828cf18a8abfeca7295322db91879de04.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

pasid_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-3-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h | 2 ++
 hw/pci/pcie.c         | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index fe82e0a915..dff98ff2c6 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -154,4 +154,6 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
 
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+
+bool pcie_pasid_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4f935ff420..db9756d861 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1239,3 +1239,12 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
 
     dev->exp.pasid_cap = offset;
 }
+
+bool pcie_pasid_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL) &
+                PCI_PASID_CTRL_ENABLE) != 0;
+}
-- 
MST


