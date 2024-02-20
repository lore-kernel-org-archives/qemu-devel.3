Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBB4C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPBt-0004t5-DF; Tue, 20 Feb 2024 07:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBL-0004iP-LZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:09 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcPBG-0005rV-TO
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:25:07 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so4414148a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708431901; x=1709036701;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oEGv7dA87enISvNwWKVp+KmYZzRr7ttxpncFC9B4Uog=;
 b=qkiG+hbyP9rAOwRXIVyARGGwTivMwoiyS8JUSSMKzXC9RYw6GlHKNTEWjs6MeklYSh
 QAAIjEZFg3IPPYgyTOoGp2sB4qg9RONkmEybQLbsn7WP7L7tuE9ycReRXO0fjM0CZkBG
 a6U7c/5PWoJVVAM0UK9cXxaHodnPvQWEAcyFsdI3VNLt7MsymRsm+RDv71tsiOzM9Oqx
 Uu0vOOEqtctcuL8/uRF1i4tr/4lQmUtgyRUg5qJ7JA48F11hKEpLMrrfTlvITiVddMi5
 UmhNHdj0VvOmqDcHm9UpHKvYUiqh3Y6vE2gy6MpuwirzgD/rtUtSlIHeAwm9y4X+ahoH
 uN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431901; x=1709036701;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEGv7dA87enISvNwWKVp+KmYZzRr7ttxpncFC9B4Uog=;
 b=adsS1+d+PeDDHq28zdtNSCqvNXyqpCa5hFXaaVwHHng+XvJmZOhONsIr1nqFo5wBfN
 muYJuheWRDIxeuOmZ5XRM5kKzr59x2WjKjRmB4PA9nhHUUloVAzJHmk/vD74OLoyBCgX
 l66RbSsn26lqJnQXr8raNgR9lxGpfMpJ0iWhDlaGZpE3lDfXfM2O0CzEBN3P6YYkAs/m
 cse7ABAICAad/YoTVA2OFMxhvE1n5hGphfCa1k9fvlFcyXzk4fOESUI+CK7D4WRtc5k7
 G2W5CCKFy/J5sBEVx0zuQRmpfMlmX3uUS1duzAiv5ZxM29nwqGGOTpVQX4lqIMFO67Vp
 zHgQ==
X-Gm-Message-State: AOJu0Yz2Iu2+5P+7G3obDbCWzbrGG2sDYqSLm6ynt41oIKFcGj/BtLNB
 3sfC0F7/QHB1B5wRFXQtnJjSLpcIztJVJgPn947PC8bGoVydJbZfzZdBOHFqiho=
X-Google-Smtp-Source: AGHT+IHCa/KbTDKBpUcdL9a7h6N0etVKaFhUSO19iq5vA0cGz7TaoPt7s2y0FqYLQJ4wToa2LUOBFA==
X-Received: by 2002:a05:6a21:918b:b0:1a0:60b2:451 with SMTP id
 tp11-20020a056a21918b00b001a060b20451mr17993223pzb.7.1708431901031; 
 Tue, 20 Feb 2024 04:25:01 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 z11-20020aa7888b000000b006e0465879b2sm6658366pfe.70.2024.02.20.04.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:25:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 20 Feb 2024 21:24:39 +0900
Subject: [PATCH v6 04/15] pcie_sriov: Do not reset NumVFs after disabling VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-reuse-v6-4-2e42a28b0cf2@daynix.com>
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
In-Reply-To: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The spec does not NumVFs is reset after disabling VFs except when
resetting the PF. Clearing it is guest visible and out of spec, even
though Linux doesn't rely on this value being preserved, so we never
noticed.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 51b66d1bb342..e9b23221d713 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -215,7 +215,6 @@ static void unregister_vfs(PCIDevice *dev)
     g_free(dev->exp.sriov_pf.vf);
     dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
-    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -260,6 +259,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_CTRL, 0);
     unregister_vfs(dev);
 
+    pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+
     /*
      * Default is to use 4K pages, software can modify it
      * to any of the supported bits

-- 
2.43.1


