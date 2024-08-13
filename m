Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF78C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlAE-0007WM-JQ; Tue, 13 Aug 2024 02:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlAA-0007Jc-Md
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdlA9-0006UL-7B
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:37:46 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cb64529a36so3440522a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723531063; x=1724135863;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K5bDA3kbj4aI3tc5UHvikrRJGrmEJbDMhb9LbvuEW9c=;
 b=jr8pjMyD3Vj0Jkn311TfKWayGumdk+E4PigLJy+lXdpEhQoMxhHh9wJ2ABCkeXnsqq
 GOaQgwPGaroxr9moLNFqmhkAwRDCub+rpucLOpGlF1PIOsg+9cnaj+4NsBx3mPDmh48s
 XnB4eHHS3q+n1vwMOOOxneGZbDphQaRGbMKp+DXEfSgfl2d97jLauw8ZI36WUXELx23I
 2s6A5HXGh9+UqTfbSpDI2bZmFb33Nnh0rc9fFxbUZOyVCtssximk/aWvObkl/ePu9vQo
 w/I9eBkEGV3aHQ6q6LKEpnO60kz9Fk8+wH5jdlYDCchSSlN19lI5faadpX76FSkuexbY
 ZcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723531063; x=1724135863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5bDA3kbj4aI3tc5UHvikrRJGrmEJbDMhb9LbvuEW9c=;
 b=G8xIEnMG/kKeHbQ8ZR3gMg5foIEqSCbY/ojpsLpuNZeg9JMMovhUwoSc/QY6hMg2/G
 NvfQ91waNgRuUNxOKX154QPCm3aoTobEwAmexcvrdPyNIrJAAlKCscyR9I9BNpOSGV39
 9fyhhoGoyIX3Q9nOF8Xc+W9PRdxaC9JMNU8/ysngHsdHAbVvbnIjY5OgX1KSHAWZyor3
 EIjxK48G+laBONBNq8uikuli7j/QGW7T7nRULtDptrjgTleqeZXdNoOnPMH1DgKFO1KM
 DVUnuWnAvFtXd7nJZiEkYWI/CB1X1vTTV0ccsZAfVFLJasNGDPFYRHevrWKwKphrcLuI
 r9IQ==
X-Gm-Message-State: AOJu0YyAQM6gy46F7T9sAUv1uC6yLokl9dxyEJbJ8qzKlMFGGhnKU9/p
 nP1ZOKObpaqmvfEQRpc5p85N04KpobAYi7jFsq0MqbyOmfAIqNTggoJt24sotmg=
X-Google-Smtp-Source: AGHT+IGIR+HsQ/34qPixsQzlLTmVMPhJg/+aX+bdh8S0OqdiasWISKkxO58UIeI0GJV0zikat+1HYA==
X-Received: by 2002:a17:90a:dd82:b0:2c9:8a4b:b4d3 with SMTP id
 98e67ed59e1d1-2d39265f681mr2449417a91.43.1723531062587; 
 Mon, 12 Aug 2024 23:37:42 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d39882bc89sm343126a91.1.2024.08.12.23.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:37:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:37:06 +0900
Subject: [PATCH for-9.2 v7 7/9] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-sriov-v7-7-8515e3774df7@daynix.com>
References: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
In-Reply-To: <20240813-sriov-v7-0-8515e3774df7@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A virtio-net device can be added as a SR-IOV VF to another virtio-pci
device that will be the PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e03543a70a75..dba4987d6e04 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -75,6 +75,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     k->device_id = PCI_DEVICE_ID_VIRTIO_NET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
+    k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;

-- 
2.46.0


