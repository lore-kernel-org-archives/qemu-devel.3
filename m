Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFACC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAO-0003FS-AT; Thu, 01 Aug 2024 06:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAM-00038t-NN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAL-0001at-B3
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5yE0T538LAywgJeaqQWByKrae3CNG6FSWZ0iMKoVa98=;
 b=i7HhaFRtYQHeDL/87qB/pMzcjA5AlROYSkMJBI9Pq5J2MKH69fpsVaj5ihBs3pzGMZlldu
 uebgSVqwWcCILkTA4Up06KrATXZbo+2mwGt1ELnqr4COnOPzXuIHW3wS1k5OV5coGZixXr
 +GM1XTMTWcBgluo6Kt1Z09mf28CLw7E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-eZHGvQOdM-y7S-Wzf0wvsw-1; Thu, 01 Aug 2024 06:36:11 -0400
X-MC-Unique: eZHGvQOdM-y7S-Wzf0wvsw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52f0258b020so7474807e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508569; x=1723113369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yE0T538LAywgJeaqQWByKrae3CNG6FSWZ0iMKoVa98=;
 b=FcOn4AbIpfhXwLnugJOTLhrp2JxOo2BTtNeKERRGTK0xQKjDMQv4a1NdLED6AnePt3
 q4yhMwUhiMWSaT4qEkF1lRRWP6ZzQ2gBuscFciZYUfQL9peVKJUJvg8AlYCyyvWnoxia
 FBQGjBLDiiPa+Aeowdhq52Qtw9qpyprQo2Wo9cqJRjGz2Sgliik8GHk5J9QQOOQlLOz7
 ZBUs0fZqSQZuJJxNXfyOKxqyjR9qrgT6s7jdGyGNfybRYvzrpk/AY9eCLHel4A6bV0BM
 gnVhU407qGndILhj+mu0gWt3Uj6EdWXr8FH0G8Dk2y/LAQqZgmA3awgs8U0DLYMG7TmX
 hZNg==
X-Gm-Message-State: AOJu0YwURkvwbKf9CfMmB/QKFoWccvdumprC2d4exHQnGqUKud8Q8xQV
 QQglXibaOG2qYRGtaAC9MHLgTwBqzF1L1q2Ypzf+UsVTZRGwyM1f48nwjnmjsHqzXMTq56Yx0vu
 m8PmkM4HCb8UN6teQT6QJzERXD6zjBIB83l+J/Kd/wQz3PmQHDUJna/hhKEJhPlMHQPaGYScpSD
 AreVryZxaKnSNakREuCszV4G7Rk9dzyg==
X-Received: by 2002:ac2:5bdb:0:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-530b61b6fe6mr1076261e87.24.1722508569227; 
 Thu, 01 Aug 2024 03:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpL/fqjx6iYHpOBD/jhIyORDYu3W5yanEx6LCg0v9tuYX7eWAkL90fVACaDn97UN05LQLQwQ==
X-Received: by 2002:ac2:5bdb:0:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-530b61b6fe6mr1076240e87.24.1722508568442; 
 Thu, 01 Aug 2024 03:36:08 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63b59ca1sm10032032a12.52.2024.08.01.03.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:06 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 06/19] Revert "pcie_sriov: Check PCI Express for SR-IOV PF"
Message-ID: <c8597d3e1c79a27cbf8ec3bed1a58a426f29ae21.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 47cc753e50076c25334091783738be9f716253b1.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 15a4aac1f4..6c79658b4c 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,11 +42,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
-    if (!pci_is_express(dev)) {
-        error_setg(errp, "PCI Express is required for SR-IOV PF");
-        return false;
-    }
-
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be both an SR-IOV PF and a VF");
         return false;
-- 
MST


