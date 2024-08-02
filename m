Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D0C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7s-00039m-Kc; Fri, 02 Aug 2024 02:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7q-0002zk-WD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:55 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7p-0000zH-EX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso2176447b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581452; x=1723186252;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NlrY553tddcDoCWOe56+tRoCgkm3F8OvMmopjLbpLLI=;
 b=gjPPdih9PgHz+NkrQv4qScLsGHlPh+rPp4A33K9N9FaM8ziq3TZ5alQlNhnlzlIg/1
 60LiJ0PVLk3DEd5JXkJ/JuJOCJseTGV4aCFiqCG5QdRsTE79xLs/wIrSMpVLjuEjLUU6
 hzdgqYg6CejlLSQMv3w4hYWtFGWztYpaG63IeiYqwsg1eshFYKM/o3Wqr08UQSXl8sxp
 vmwEmv080hKWHg+AvXvqfTXP0008Kjw1DxaHWe6qARqnFAd6XxlC9bumyn7BknEX2rjQ
 JnwOU00gaQe4v0jvve3Pv49Oxl+5/A92ojBbf76VNfnr7vDLvEHuC2TkPSr0wB73ErgF
 JXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581452; x=1723186252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlrY553tddcDoCWOe56+tRoCgkm3F8OvMmopjLbpLLI=;
 b=gpfhJfaR34Dt+Z1vBODfmKYTFiUzHPj0x/USKwyzH1UR/2rkIJGojz78cwt8AeImgw
 pH4fi49c6Yo7z+gmb9KIkYt1bELLYZRrebPsqrpcTqmOThApFiHa23fhOvKELl1HjioN
 i4qXPGfNxQoLsO2qIqG7mNNTBSxYR7ryBDMelBc+wtPpMHh4Z5gHAk9X0vsMTMP3w2rB
 ewr6lnvEtOzVU3fjEF27GC886VgdW027mM+dtXRuPARK8JtH6t3r78KQulviVibPkekV
 4pW2yCCVPi2Dmc3UKway0gvva9lishVtWxMeXPqJWhdFw0tKXG3E4gD0I/vYuUHxaN+Q
 NySw==
X-Gm-Message-State: AOJu0Yxg7lB1wQA5UJfQJwHcuQlYJat1fx7zajdKAlYeUph3tdaux8oS
 6dEo7vvwq7ihluobwgQD7p2R9uzQa5s9QVZGmx7CY5kUMJBe74U68oLS3gnWAl+Vhqum+t/oKPx
 6SBA=
X-Google-Smtp-Source: AGHT+IHdgQU+Sh3GVRQA4Zt3b8Wt5BKHZHuODJcqt8s1p8QsHOAbIo0fV8g98rfCMhWdTl6hKB49Uw==
X-Received: by 2002:a05:6a21:9983:b0:1c4:6ac5:be17 with SMTP id
 adf61e73a8af0-1c6943c8608mr6097700637.21.1722581452014; 
 Thu, 01 Aug 2024 23:50:52 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7b763945c05sm648875a12.49.2024.08.01.23.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:51 +0900
Subject: [PATCH for-9.2 v6 7/9] virtio-net: Implement SR-IOV VF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-7-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
2.45.2


