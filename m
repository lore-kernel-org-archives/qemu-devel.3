Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC96C3DA63
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkf-00075M-Ma; Sun, 21 Jul 2024 20:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkd-0006wf-Nb
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkc-0005pb-AY
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+eij6Bxq47w2bciZE/Rv+DzW/akdlQrWlADFCMstsmc=;
 b=R2rOPGcDnMvlQE4m6kpIPBQMVCtNFZFbHv61HpLwIFSJeZ53sj39CgvFj0FnBzJWyIzIDs
 SvKbWP0bAquMm/3EN2BhOOGscKbchSKM2Hkf2UbfzHkyadFja6V3MGBYDprlC9P4paNImK
 KJvJDQxKk/i+r06SIIKMpTgv2yx29EY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-UPG4eHjlMLegMQ8l1PYRUQ-1; Sun, 21 Jul 2024 20:18:00 -0400
X-MC-Unique: UPG4eHjlMLegMQ8l1PYRUQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42668857c38so27734975e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607478; x=1722212278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eij6Bxq47w2bciZE/Rv+DzW/akdlQrWlADFCMstsmc=;
 b=xMcYrEYf+tvs/anh4l9PnLcZHAu2lwQyMVzfbEHs4LFEBAGUzdDl2srYiecOfiPRf8
 uIyZFF4L+gR6RnSEWx2wRSKGz2AECUvLy+bfxq9vfjZjwCETtyMfYtNMZVubTz/V+NEU
 OGLsG5QyifaQM/01vJkFXj4g1y7FrOvhmWRbCoCOpA0gcKO06o9dakDfOtcI5Cns7LZe
 pm7yPY+OoxRMYlFpwEKHsvIpeTfhl2EHJAsY03mpLV9GNjRnw3YHu90bN7g/DXycjmpk
 20HUOVgqBh3b/k1CVeRkxvPbcc7Ixs+pQ8E/C7jwqDdZNL6aaDcnhCGIbfybzIBE61AR
 gdnQ==
X-Gm-Message-State: AOJu0Yy4UyCK6dHfwzINr6hp9Nk9W/f+juEwgaPyFdPcuSA4D0XK8La7
 9EawFTyedHKXr2VrLfXgWcM41M79t52+SIyEdFg0UeTKqT74F5pbG+hfcJwUcIRpIX2N7LOpZgK
 QfuVi73rePH7R0rh16vgBaYjcMKMEaG+MBuSh5iQRT4CyIOODtuzNV30zKF2dymbuDzDF9U3UXy
 pNTCQ22N+gnCbn8crL4D5HzkkeZ5+ASg==
X-Received: by 2002:a05:600c:3ba9:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-427dc5584d8mr28430685e9.30.1721607478733; 
 Sun, 21 Jul 2024 17:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfAToW3g7nzJrtU6eFvr3vVXZ/4lypIFreDDV7ozbONpqf31axrZlekR03YbUNNpmKEmaeMA==
X-Received: by 2002:a05:600c:3ba9:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-427dc5584d8mr28430535e9.30.1721607478233; 
 Sun, 21 Jul 2024 17:17:58 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d692998csm106210135e9.32.2024.07.21.17.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:57 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 32/63] pcie_sriov: Check PCI Express for SR-IOV PF
Message-ID: <fe70e4c53e4513ee5a536a84f7ccdfe64a72fef4.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-4-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 6c79658b4c..15a4aac1f4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be both an SR-IOV PF and a VF");
         return false;
-- 
MST


