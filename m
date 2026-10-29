Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15001606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oeMLHESS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRh8-0000f3-Ol; Thu, 29 Oct 2026 11:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgt-0000UJ-3H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xMRgr-0001wq-6G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:05:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so1734446f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793286315; x=1793891115; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d1SA0JPlAdLNkBQvS9ifeD/hIkFRCerT9UfASm4315E=;
 b=oeMLHESSzPYJeBT9LWJHjdXRR10AcOwr7t1jGqk9g2heVa99uz32sROmf0eZObfngf
 z9U3FSTNI9PmH3AFOHOV08Ulc0CBtw2Yd5Gc/GIX7sgiKUggTGZXIhyEZWqHQHJyMXdA
 vtajzthZQZuHkMZE6iIoIBZfPn6UiS8MeSUu9hPNUYgufKfGmL0hTx6lfHP9ZHwyjWAS
 J6OhOuOien9IlXc5bFPAdLGE4MiXHhRo4Jypnx9kTdIv8HcQL8d83x4dv5BDmDvC8XrY
 WDqXKHZfILpYsoshgnCKQnkhQsi7tIiue67bFCi2fk0YkSWOzZ2StqdkRVsGHsMKds/1
 mMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286315; x=1793891115;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d1SA0JPlAdLNkBQvS9ifeD/hIkFRCerT9UfASm4315E=;
 b=JwHz9STJQGN605FBW3aWaAgnFExbIn+PRTe4QHJxQjrIG284tLXIMXLDkBY7O+bWRl
 A9yRSaa3Mj7IfUPMvc6TqzicLiDPhflsW8VuxpHJjyx9znnoC7j4K3vJxW7kc2SV3xKl
 yI01q/MLQLEBFUD4+ZTw8HRbAu5EHH1XVmY15qZeIgtQARgOazbOPfqBX44GWICX9FWc
 QNx3tponDcJF88thXEjnzIxzdYtQ+UAdow6/JNgmXG/Nj1b0t7gR95eUytMCUxOx/O6M
 sMmpcDflmXAmlgiIc7dpmJPuwiSj6MLk+9APlxEc7fBb48rrr5nO2zC9Emhay0Rp5GSp
 FI3A==
X-Gm-Message-State: AFq9FYJurv1bft7vXvwfO1kNngZQdIdRcF5+Q40UTLVNgj3DMemw3r/t
 eNqllYumNmoby7dPTpIMsnALXPaP6/iRJSJbo3MmNH2HlbVewdOQZr/nUHYuA3K6AYW3zj0KgZ9
 CzWnnwKo=
X-Gm-Gg: AYBFou18dRqwxNw2uxD2k0gEGz37Nyv1Z6n3GOr90EVL8AEVtyZd790gBgTKDI7LyEs
 QLIixLZWIENzeru0etkSANsodn7JWMqJ1IT9aRjD8sN6b5+VVHMBW5u/I7EOM6FXL6U1C3ai08X
 T/jRvUYM4TMKUnAw0ZV2n1dgF2maa93UROi6Q4LHrASiqvnFqFzofBPscRGOnMnacPqthSMM7nO
 LMAdAofYZ4Pj055MVTzBocCF1LRWUJmNZs0dlSmwoPoPK0/ML4TjQk4bdxQUgte3gWjDcsYcTYL
 +/53FrLn7zfYpb+66P1bmUQd8IAiqiiX43lz/fq1xYL6x0Ln6q2Qrb7QQk9wv+N8JysjTNUHVjc
 U/8UTEgC9si73fDGhPZlnD2RC5umeQhwrrlnpxtMx9Y1hGVSLkdZ7YVhPGshXiYbTowD2QQ57HO
 VtJU3L9gnt0bgPNI6xKiroKQ38G2QAgaZlzYoLgUJFlAnjexbDc+R71x/Zfh4Ag8XoxGxrNNIkO
 nH4Ar9jne+TRpJo4VdP/Eb9tlD89tNQHh5nnHKftQctm4LlwK5ppmfxn26zvsDsHgJ616g0Xf51
 xLCdk+hP9ENLyZ4TOlHHHyDb3kXQXYe5bw==
X-Received: by 2002:a05:600c:1987:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4a965dd31e3mr124164935e9.7.1793286315026; 
 Thu, 29 Oct 2026 08:05:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:6ea5:6074:196c:9c53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7ee57589sm80999075e9.2.2026.10.29.08.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:05:14 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 29 Oct 2026 15:05:10 +0000
Subject: [PATCH 1/4] hw/pci-bridge: Add pcie_add_dvsec_capability helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jmac-pcie-rme-extensions-v1-1-212d2409563e@linaro.org>
References: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
In-Reply-To: <20261029-jmac-pcie-rme-extensions-v1-0-212d2409563e@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/pci/pcie.c         | 16 ++++++++++++++++
 include/hw/pci/pcie.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 42bcb9206d..42c4997b42 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1157,6 +1157,22 @@ void pcie_add_capability(PCIDevice *dev,
     memset(dev->cmask + offset, 0xFF, size);
 }
 
+/*
+ * Add a DVSEC capability. As per pcie_add_capability, the caller must
+ * ensure (offset, size) does not overlap any other capability or extend
+ * past the extended configuration space.
+ */
+void pcie_add_dvsec_capability(PCIDevice *device, uint16_t capability_id,
+                               uint8_t version, uint32_t offset,
+                               uint16_t size_bytes, uint16_t vendor_id,
+                               uint8_t dvsec_version, uint16_t dvsec_id)
+{
+    const uint32_t header1 = size_bytes << 20 | version << 16 | vendor_id;
+    pcie_add_capability(device, capability_id, version, offset, size_bytes);
+    pci_set_long(device->config + offset + 0x4, header1);
+    pci_set_word(device->config + offset + 0x8, dvsec_id);
+}
+
 /*
  * Sync the PCIe Link Status negotiated speed and width of a bridge with the
  * downstream device.  If downstream device is not present, re-write with the
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index ec25e7a7de..86c29f7d8b 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -133,6 +133,10 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
 void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size);
+void pcie_add_dvsec_capability(PCIDevice *device, uint16_t capability_id,
+                               uint8_t version, uint32_t offset,
+                               uint16_t size_bytes, uint16_t vendor_id,
+                               uint8_t dvsec_version, uint16_t dvsec_id);
 bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
                             uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);

-- 
2.43.0


