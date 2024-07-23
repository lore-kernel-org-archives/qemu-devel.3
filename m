Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C3BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDDf-0007yR-Sp; Tue, 23 Jul 2024 06:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDZ-0007TD-KE
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDX-0001xG-W6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YsjbOlvo43JAEesCygimaYMAVGDqCDgHnftdBHHCG1k=;
 b=BOJoRTYNaDI863daH82J/tD+rOJ2ad/Jp9S/pgjKVuXzOQwssykdLLU0RGeiq3amNSDQBN
 vJzvSZHI/uMqXIK0jd4E6iLuJLYFdTQI112PbyHiKv/ebAkREhslgxPWjFH4vSVpA2DDsE
 0wRB9Hu74G1dMuj1nhc9w/bGJxWkkUY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-kEyWMpaXMlyHO6Dc9JRysg-1; Tue, 23 Jul 2024 06:58:02 -0400
X-MC-Unique: kEyWMpaXMlyHO6Dc9JRysg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52efe4c2261so3546393e87.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732280; x=1722337080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsjbOlvo43JAEesCygimaYMAVGDqCDgHnftdBHHCG1k=;
 b=Qblzu4N0aMl4y/zAuwtHbv+aFi+1GgZkY/8e2I/vwSMiuIZTmtUzf0nIAvIzYuujSy
 p3C8mROc4X3JBOxlpvEjkWtodwU/yfUlkksGYl8qZJQ16pxIioiRcFzLm6wnda3ySjXK
 aIYGAS0U96YgqF/HsWH7SG8cBZR3coFvbW2a3XY6bQjSgefM//dubQTmxvVuSwOBt2Xf
 3Vsl0WYp41m6K8jAeGpMxT2b+TaPx299y9JEuxIbP0xjW85TlPJMRgjiilDarzoTwC2I
 q2yqOssbWJlBobcBej4xohEfk4d+1ycG/uKIoN00A7+SsZvmBnwFY7jLxBkuZR0KPnnH
 dz5w==
X-Gm-Message-State: AOJu0Yx5YN5ECYPMsSm9DH859+w0xKRRTXgqYMt1vk5co4u0Ov5Tk6tE
 ga9y99IGTe3CS6hVAYyY6UvIH7NXcaAw0bvbWCSaisWiaJUJN2xmclb0xMXnwQmssMI+T0UGvWx
 fS4DX8Tkg36RCdBJfngRJJHwPpbizaEDTXy5FgkhAr4CGH0SLJ8/b5R+CytMycv7eiqPPKX4Uat
 LROJ9G+PxDcKygJ6maSAB5rkMDB+Jq+A==
X-Received: by 2002:a05:6512:3d88:b0:52c:df74:1577 with SMTP id
 2adb3069b0e04-52efb7ae98cmr8776440e87.45.1721732279960; 
 Tue, 23 Jul 2024 03:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnwwWZ8y4aMbR9vd5lfu1BOH1yEITGJhHGuW6LFJgXfv2rdnEtuCLM0mY6V3IPYaiGIhZPDg==
X-Received: by 2002:a05:6512:3d88:b0:52c:df74:1577 with SMTP id
 2adb3069b0e04-52efb7ae98cmr8776396e87.45.1721732279135; 
 Tue, 23 Jul 2024 03:57:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aa08b6f18sm35935766b.46.2024.07.23.03.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:57:58 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 30/61] pcie_sriov: Ensure PF and VF are mutually exclusive
Message-ID: <78f9d7fd1989311040beff54979bcb2a1ba0aff2.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-3-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 56523ab4e8..6c79658b4c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be both an SR-IOV PF and a VF");
+        return false;
+    }
+
     if (total_vfs) {
         uint16_t ari_cap = pcie_find_capability(dev, PCI_EXT_CAP_ID_ARI);
         uint16_t first_vf_devfn = dev->devfn + vf_offset;
-- 
MST


