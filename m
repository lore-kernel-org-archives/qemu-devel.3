Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE2C48297
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCO7-000434-HY; Sat, 03 Feb 2024 04:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCO4-00042C-SW
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:36 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCO2-0005jS-Sr
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:36 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d7881b1843so25181315ad.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706952753; x=1707557553;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=VD+uFFDYNXi9z2nmw/tuvv6npDUM+6WIXlSQEfikUB1evrhrI2RvYaR99IagIaEtBC
 xMROuo/IXBROZNl6mMp9nb/xq2lfBsQ3qxerOt9aX6/DD4KlGoNWQhWkSiyyykuXNQao
 f2BhA2zQeoBgd5D9ESsPU3hgfMqLSBpET0uoH8O1vpLqEoD0quza6LxLzcSZeNG8Xpvc
 Wwe5Sm8/9VVQDuTs+ppxMyi5Yf7RflCBZ8s74DWQHjvWP9aieYuJd99u1Rj8ul419kmn
 vlPStUig84FjdsFYjdEkggD04e9xrWtclmMmlKL/MO49kW14hyY63RSEnC/UlaI/JVAT
 TpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706952753; x=1707557553;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=oqY9KxEvuSZI4fk/qy83mreMgag2XHtqXZkuXymlAECxg6P81B2YVc4BI24T0BbaR5
 GLv/JIrOynLkC4YHp5GUV8mFnbREUwYs6FyGry+BqSeSuICz7ShjEbUHUQDdBeLfw1XT
 BgmzO6ziuoI7DITPMiAT+SX1hyGjXQVeTMVoX9IqcqB45Hmnlv2NbYqg4WiN+9QPehCH
 N5V/OoWhk/IExSDNO5Yvw4cXVLY/729bCPyXGVyCd8mDUjF8fy1Ahn3Xs/WTN1obZnnv
 UNmqjbNsvtHNcuwUteulUdFGYa59GEqBEyGBFFs0qQwwWdIRETsZ3jXw9m3C3Jor/Ee0
 Y/Jw==
X-Gm-Message-State: AOJu0YypVyh6n71re0++CIVgEFD+AdjEMXqFTtO+H3gxZ8G87cR2YbKf
 HAZ0kab35mzZVG5LZgnnPhY5q93IhX6weifYJNkJ9yJY53MUKnYZ25qQgPiv92o=
X-Google-Smtp-Source: AGHT+IGPl9Z0OOt/hQqn596JPYaEEXEA7VV5j9GioSiECfI7AwWnM7L6AwPIJ8/q2flNtdojmSzxdg==
X-Received: by 2002:a17:903:987:b0:1d9:4282:4be8 with SMTP id
 mb7-20020a170903098700b001d942824be8mr5724116plb.25.1706952753543; 
 Sat, 03 Feb 2024 01:32:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXSpNiJntVrtkq+zRDdsb2A3POy0ilLtfSN8t4jSKTt07fsbCNkiyDB6RQcYxy7K5Z20eZyPR+W/usV0MaYRK+FaW1nGZb5xL/PrnCl3+ZKE4uEmjUF+s4PXT8bgB/vM3gBu8YZlSKcBCjev8SJHy9VvGiDa/lPkloEAaKNSdPX1/9zgetBCsqS0cYUSM+HRydNB73XUuuzkJK4lhAcaOVIAw/rRt0kCoP1LXjCeW0tsWbDylgNJeZqaCXLeXgGLfVrHDDW+15fPd1jIyn9lCLp0fgUfLxpEO18aaV1t1XCx8iGrErDVTvhzfsYDUluKdDChEOdgjM2mztIeKZ50e8MBgVt5kA1I9p3OSUEUk2TErrRA9zX9oScZR/PI77Mjlsa9o/rXhf690eBL77eD9hxUIvR/ZpHOgp/eQg/uQ==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 ju3-20020a170903428300b001d91b6175afsm2942612plb.18.2024.02.03.01.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 01:32:33 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 18:31:58 +0900
Subject: [PATCH 4/6] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-reuse-v1-4-5be8c5ce6338@daynix.com>
References: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
In-Reply-To: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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
2.43.0


