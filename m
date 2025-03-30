Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8366C28B20
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 21:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyzpI-0007l1-EU; Sun, 30 Mar 2025 17:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyzpF-0007kf-Q7
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 17:04:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyzpD-0007x2-Rc
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 17:04:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2239c066347so86197095ad.2
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 14:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743368649; x=1743973449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tc0G2fe3Apc2iu57z5O7bMO+u6/7C3oHyohMmueTa0g=;
 b=nhuQCrji2uKMY46AxidpTr50cMzvGVofxM3Z6Ntzq1joJfAunphnzA9MRQ5kh+5aDv
 1HBnlx/8eTC/1aNvNjuNm8MBgIa68Ps29tbopdMldJPwVkOTedmy4RKkyeHhBX0eXqAx
 /GXD/O9RVNxqTzt0iMXiWjRzGq3R9x/3OqetKl+6XGIe/hiWF+zYrz5/q2X/eLdPjKKN
 QWMdHXsWLeQT01trzUcvBLRBcL6LYFVanFFnJnBdjI0k/LnX5iptchukzyZy7WMH/JqO
 EE/rLR5XKsZLO5NugWbG8dQR7vfubOW+gVQ699B7z16XdR+hihO8ekvCqYPiGoUO+xPn
 Ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743368649; x=1743973449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tc0G2fe3Apc2iu57z5O7bMO+u6/7C3oHyohMmueTa0g=;
 b=BZybPMeAVM3CK6ExeAEW9Ql+6N20Up3bn1QCEu08OEH9NGLdUDfnvzjcnqXSxBP6M6
 rjom+gBdUMOCi2EWhFYm/x2op2EXXLqutwzF6FTFwQfYLk/0jsiWyOsbl/A20ProJ9us
 33Q4mjZbRnrBO7+2xMrKPxwY6dyo4zkyYCwcprPe4XRCSchge0ldnoom32S90/y7pG1q
 he4GB8oa6fwSS39vbXa2HQep9fNwq+ZTS9uKcKZvNdtF9kwpEaQ9+d1tvCaLDgCzNap7
 q6jng0Sjuwf0x5xRk2YK0i/vzaJq1jWVhckYY9cMSWIC/TfQN5vcqVO3D5e7SwJHvP2p
 +bfQ==
X-Gm-Message-State: AOJu0YwR7+RNHlLD+jbvJQjzxE5FtdjlC85X9zmeuQg1NBNw1Qw674/0
 eBDzGJ1jYznBMkvUVDoc12oNuNpKyCPR3egw/dEVBEene8CGTjmtcu2YpcdDT4o=
X-Gm-Gg: ASbGncuA12EHIrZDDgwKTZCrsqEjfrqSxQM9Tdla5ox7e84LrjIbngRS8ZKttZToew8
 eO6enCAEaexGsqZ1gemDA4sR05zWUgPqm32XIgHp+E+6B3tVo6Qekojhkyt2eLSMRXB8di0nfGx
 C7OdwMB5CvxlXzFG3hG6RM/xlYdma+McRy2G5q/+4ti+yFpTUJE4+V7CS+KO3dzvBt6NNQYEuz4
 4B/dsJhGET9YQCt0Kejp1PdhaZY/3p0ibYw2oGcSG8J4Sm1g5ytGuplvImYrFUYZEUYOglEHmhf
 RQYRRb9ms8KbHyNg/dK+rjQeENcA1aACY2RaFDge7Kjvx9TwWUI=
X-Google-Smtp-Source: AGHT+IGCFOwxG1dTyRrHsKiCkcxdhySXbPr7ReVV10w64AK4AnmXR/Iy179L6+dLLUsWtxhQpNEtiQ==
X-Received: by 2002:a05:6a20:d502:b0:1f5:8e33:c417 with SMTP id
 adf61e73a8af0-2009f5c4b71mr13916414637.2.1743368649348; 
 Sun, 30 Mar 2025 14:04:09 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:9e7e:5b0:1e97:7aae])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b6a08f7sm5218166a12.29.2025.03.30.14.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 14:04:08 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	thuth@redhat.com
Cc: pbonzini@redhat.com, balaton@eik.bme.hu, marcandre.lureau@redhat.com,
 rakeshjb010@gmail.com
Subject: [PATCH v3 2/2] hw/pci-host: Remove unused pci_host_data_be_ops
Date: Mon, 31 Mar 2025 02:31:55 +0530
Message-ID: <20250330210155.74295-3-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330210155.74295-1-rakeshjb010@gmail.com>
References: <20250330210155.74295-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

pci_host_data_be_ops became unused after endianness fixes

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
---
 hw/pci/pci_host.c          | 6 ------
 include/hw/pci-host/dino.h | 4 ----
 include/hw/pci/pci_host.h  | 1 -
 3 files changed, 11 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 80f91f409f..56f7f28a1a 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-const MemoryRegionOps pci_host_data_be_ops = {
-    .read = pci_host_data_read,
-    .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index fd7975c798..5dc8cdf610 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -109,10 +109,6 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
 struct DinoState {
     PCIHostState parent_obj;
 
-    /*
-     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
-     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
-     */
     uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index e52d8ec2cd..954dd446fa 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
-extern const MemoryRegionOps pci_host_data_be_ops;
 
 #endif /* PCI_HOST_H */
-- 
2.43.0


