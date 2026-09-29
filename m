Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6A9CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBeNL-00065x-Ei; Tue, 29 Sep 2026 16:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNI-00065G-TU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:28 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xBeNH-0005DR-D2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 16:24:28 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso8366535e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790713466; x=1791318266;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CtPMJ0Zxt303C2kK69S/7fzaBmsomCzrkQ4C6Jmecyo=;
 b=NsZcLSntDnzJqbqZL9aAWCpPK/cxjNX4oM+ZNZjbBvxyj4ASMH0LIes9yKnIu8gryr
 G1OyxQtZiUvjcmPLNKihHjC/XmfO5nNP/NZ624Xro3/7SYUSWkrhsBkLISutcHtP6656
 OAIsez3K42eZ2vGOcQHvRWfEahTljAFu0IzGO8GbGO7HLEE4so8XwGt7/SX9FFzumUq7
 S0uGuCNFgeJu4UuQ2rGJpbcpG9awMshluYOCE4qyWb2BiTF0gbMC8f9DTYCM8y2AeX6r
 2zcuK2PnhgTfy+YaKSdpf3kD5N/JVyzfFGoMznkd3HIlC+jGSy9odeglFHKlWOs0VR9N
 jS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790713466; x=1791318266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CtPMJ0Zxt303C2kK69S/7fzaBmsomCzrkQ4C6Jmecyo=;
 b=pDMB2wGQYmX9u6VXo+HgoFfh2/6VY0iatNRldJV9aDZcfdRJKc1MaRHSBbFq7jTil7
 GUi2pyAKf/YgLECSLb0P3Od+a+SqTMJao3zosDQksmyFWM+k0z6ecVcLYsfaygNoivbx
 aYK6gzPgrJcEq8LUJcY8MJNWwyassPdeNedZp4o5SI7sf3/LntK3pnDAM+aJycEhhRge
 e1jRMu8T/Wugx10DS2MpTLHfHvpuA53MaN/nn3QcN47sGuk1bepX44jMGVQZtIwlSQa9
 v+3Yw6wdgTxMP5nXGm+wLakae7DFGC+UgY+wnVkXQE0O35Ru0lLnJahjCwKQT2l1YCnn
 /gxQ==
X-Gm-Message-State: AFuF++lzT8rrfI0FUZlJBtPNy5FkAAUTuarJwZ/oNMmdFCypRqPTEspV
 pJluY1wOCEJabzsePntRu2kP7iRiGzmUZQ4n47Qk/kifgtlKOG+u2OdcrMyTf46hIoa1MwmxSv1
 wCJAe99A=
X-Gm-Gg: AYBFou3cMYZVHRRqu5yQnQZTLMPpa1lc72Gy0Vx78BbOPW1j7HT2r3dYTO+GSE8cf1N
 F1Yo0Ro/XwDNmYQvy6c3pGaeeXg/1wtvlRjxXUZVsuqziTzMoYet+1QMGMGKYjHyn6r81c5cPD3
 Lv/PmEX/1qUPi1Ly8wOoD5JzI9/+fSMTOOutVNR1cpAViV6vwptLj5nQdemoLVu4iI2DEeYcHtK
 uXbyUndgdrK6n5waXluxzVyyLP3+JoWK3s7Sa9DkDXHzqgr7eBPanYvx6dbPg2cFb/cIiWi8we/
 BVTJgHn/OnZnPL9mktmQ6226BNy+Z/hrJ5Nsh/nuxQvuyGcS0YaLptw9QeMtnxuyihtnBXi1wls
 dbGE0X4HU24Ndt7PZRqdOS/XE1eOJsw9eoI0VAEPdCMIcOBDT0x0GIMqcOe7Af/m7F9bvwlSuhh
 qnhY0k89EnYxMHzUsLCPOo41QMpHMW+lG7cEOSV1/6CW0Bi+lFa1QPck18j7kdxWCRuF+cmgn4z
 g/K2K2sVAmE4TqCE46GyGQnYk07wMI4PLLCKfxCZk2ISUZfrOn/lyp6xnwvMw+iv0jfepHHybVw
X-Received: by 2002:a05:600c:3114:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a015033c71mr4097925e9.21.1790713466001; 
 Tue, 29 Sep 2026 13:24:26 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a014f77aa3sm7021525e9.7.2026.09.29.13.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 13:24:25 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
Subject: [PATCH v3 4/6] pci: Add device ID for CnuasGPU
Date: Tue, 29 Sep 2026 20:23:55 +0000
Message-ID: <20260929202358.725310-5-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:31::11;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reserve device ID 0018 for the CnuasGPU virtual accelerator.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index dd7d62d8ac..74a35b8f09 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -102,6 +102,8 @@ PCI devices (other than virtio):
   PCI RISC-V IOMMU device
 1b36:0017
   Cnuas virtual RDMA network adapter (:doc:`cnuas-vnic`)
+1b36:0018
+  CnuasGPU virtual accelerator
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 99a31856d0..ab064a347f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -122,6 +122,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_CNUASNIC    0x0017
+#define PCI_DEVICE_ID_REDHAT_CNUASGPU    0x0018
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.43.0


