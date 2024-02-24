Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BA3C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHC-0006Ob-LZ; Sat, 24 Feb 2024 04:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHA-0006O6-Pb
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:24:57 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoH9-0002PR-En
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:24:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7881b1843so13215495ad.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766693; x=1709371493;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XAlWXKGj/Qs8kksBVXE9dWWgaRg5MiFxbRpTNiPgudE=;
 b=ozPO0iJomh2e8W3GZsXF4FcL5wHqPbgWJpoi04kakJBiKB6LGqe+0NudiL21gbzIOE
 Pzf/Pnjk+u/XZIQFxGPYaLb2D94XzvOQi47VILb+Te+NibBl2+zPwvVXFWpQl/SwMTR+
 Vqv3DO0WQZpjlVa4pz9mJmpUL32vhJrp7Td02YoOf3C0YzDnYIkHnzZrarikndXBocms
 DfHrD+P3NRoG6eYoo26kyZVmIYj2n8+tBkFBYyPyDLA7/tz7V0tEk/R2SFnYcSrexU88
 mojQA9MW7tF2UWfcqMKeil7pfeW2+mRtGka8v+brI8RshQcDvtbyqpDqJ8gXGusv9voz
 k1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766693; x=1709371493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAlWXKGj/Qs8kksBVXE9dWWgaRg5MiFxbRpTNiPgudE=;
 b=nNgYY/vuek4+L1pk6BHWG4jMLGZ3RmvPuQotDQPEmNoZLFtRavSJw32cfINKEmKT0L
 5pO4T5NL0+8I2q4FZ296BQgy7iXtF1NqkIwgLIUPqya3peEDYZ5hnpKfpFbVEt9eGb7S
 mH3PnA0pjUCFIrFkqP8dFd1fVdvS5P2ttAODJZMq2glPfPKQIpSYCkSAGZx7DhstsL+C
 AZxflTbcYZ1V6GApg4MAwdtExYMFtNaeF3Nj21lG5rLFUw/83aTcGT39dLnOh0jtp9G7
 k3xAJ+hLdPdEnMeomNqstVyzU4WrNr/ZMwPfGNnHziNrOIMezO/Abdg+waU7eNc/H2N6
 IGQw==
X-Gm-Message-State: AOJu0YwadBSrLF5TmIGjpqwf4gDTNL2CxV+nHdYceQYSflTELcegdNKy
 NFdEOjem/qv3zyHIuJkLGUqdtf6UpbE6B4s2mb1L1vU5iCFWGraqKxsIf/rcDtc=
X-Google-Smtp-Source: AGHT+IGbRtdYYQG2GEF/VDgDfeiO1qHT4p/K4DIg34O/4elLXo34dw2jYOWxcaNRTfgMOOuDSgtBMg==
X-Received: by 2002:a17:902:bb16:b0:1dc:688e:188a with SMTP id
 im22-20020a170902bb1600b001dc688e188amr1926990plb.21.1708766693653; 
 Sat, 24 Feb 2024 01:24:53 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 w19-20020a170902d3d300b001d911dd145esm658040plb.219.2024.02.24.01.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:24:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:34 +0900
Subject: [PATCH v7 02/16] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-2-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

The guest may write NumVFs greater than TotalVFs and that can lead
to buffer overflow in VF implementations.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2024-26327
Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a1fe65f5d801..da209b7f47fd 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        return;
+    }
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
 

-- 
2.43.2


