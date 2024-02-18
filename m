Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2254FC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZEL-0001KM-Uf; Sat, 17 Feb 2024 23:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEK-0001Jy-Hq
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZEJ-00040P-6V
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:56:44 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1db5212e2f6so24000775ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232202; x=1708837002;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uPDCa/8BciEuyUw+U03/RaoojU4wDhAm6Ya631m6yG4=;
 b=jsCsGQTrr+pcwcsUpakS7dIeHnlBJi2SPim053Li4NP63wagipOmgG0MwvVsS/JaEc
 FLubcIKzxRwT+F85p6XdpeSCo2sII6fhjg1YZ4VkY39MvBo2JqnmdMHToSULFucqMYmb
 GG8ozmeZo1A+WgvhPCZ9OkjCGF0QT5e5ojJMp4KsfMXhRY9zE12md4B+JAdVZ6xEY4Ca
 aX/G3SOPWhMkhtKt/sHSg23GS/EuXY+iZUlhNbO7B6pHL8e9bGPJlBR8LOvy2v6F1G3g
 Wbi1Zc18Jhm0p/YZh63QfmEeO9j0Nh/xJm8LimEgDl9HKdcU8oWG3AxAp0adVYV8hhrw
 on0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232202; x=1708837002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPDCa/8BciEuyUw+U03/RaoojU4wDhAm6Ya631m6yG4=;
 b=TQbCtyyoiAjotp0n5x396N4tXZE91b9wkpW/EfMzdHjyGpcEB1W/NXJWCSnGRdLnOe
 0H8c3UlzwwZUKM0L6L9RNdv0Oj8I51UgA/DbLTqb4Q8CScgQxyYveD/q1QclEIKKwHHO
 A1yDP77QPaEbQ0qdTJ5+3JGf24x3BdYcEf7rhL3P1l1A+0EZERFXeGgxrr17bTumIG8H
 in2CDogjrtOhIHbQrMewLzf2GiOQUY7BBSrPDKEJ/5JFLZkoaI6qHGqU+OuBz9FX0Y+2
 ByAHOVS8JvNMt3Ju/OByPfTAo6+4YO6WxJKigYdl0Q4kmpzxBmI1uhB9O9+uwj8AobQI
 IPmw==
X-Gm-Message-State: AOJu0YxEBLaH6w7S0DDrlZUWxxjBEFRLxQDtNUL1Aw/jW6ExWDX2FktM
 ngQR0cWnYvyzOA10ifeGqelOZR5eH3lvI3MwbtZ/cpjYIb8BySpFOOmlHecaAxQ=
X-Google-Smtp-Source: AGHT+IGsAvgtZd8rEkv4R1pP1pRp31NKRZ3Mq8LeLF9MymshddwSC9LC9NUTG0ZYeb5QtnQFP6blDg==
X-Received: by 2002:a17:902:ec8f:b0:1db:cc11:8530 with SMTP id
 x15-20020a170902ec8f00b001dbcc118530mr3288132plg.25.1708232201950; 
 Sat, 17 Feb 2024 20:56:41 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 u2-20020a17090282c200b001dbcf653017sm1533250plz.289.2024.02.17.20.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:56:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:07 +0900
Subject: [PATCH v5 02/11] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-2-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
2.43.1


