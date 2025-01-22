Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD9C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUbm-0005kB-PB; Wed, 22 Jan 2025 01:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1taUbh-0005js-IF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:52:57 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1taUbf-0003XD-Cu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 01:52:56 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso105367695ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 22:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737528772; x=1738133572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jMDlgPXr9XrtsrV0PcUhUkfQM6EnLM6H2YlHw8uZW+s=;
 b=z77mPoCu7dtNslZt3zPXRfzOa57uIKerdXIDBYeaonz/bYzZHoPlrePbBxphimpIA0
 MnOo8Ju30C1D5cTPPgQ6RDfxWKCrvIWoAeqT3xM1sN+jdmFwFk3dtuXH0En4zffH0zgh
 fFZKUGWaX5A4MaWYegnmvN07FYGsmHZmHtaZB2IyThPDirKFiqGO7zM/J6EEl4eeKVwy
 8TtZv73gn12vrsmHCYzlZ99YbxZ00X+cG2cazMRzI9mb8v7devBMSwfVKlymn30yicoH
 Ol+1Ksq36TbPPoEt222eQkwKmA8ftH1maec9Ej5xSJD+pcXGAI2kS80T7N3PR6GmxVKN
 Bumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737528772; x=1738133572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMDlgPXr9XrtsrV0PcUhUkfQM6EnLM6H2YlHw8uZW+s=;
 b=MM6AHojHCJeUWVaZr1XxvjopUUHB1lQBBJdlXtnMViA5c8l/WiPXEQj2GRwPRPY9tw
 tHi+Q1aUzyX/1P9pGjFXOzayBXejpLzxWZypx9lIkRqMV7qfajxq6XeRN3pV0SKcg0E/
 2y60a4qm8R87uGpfAhumOPzocWh9/nhhYrxRjeMty3bXaAsJLnPmuqCY2vdTZcL/Z1qJ
 3YKP57YNrIcTTid+Uzl3smA/Om6qWdBnWA3btRsiFXj4IgmdWhfqQ8f+gKZIhIFOc38c
 FIXv4M8CfQqGkzuBOOA8GHL/AkUJW/ImMs55GbVHjwklRS2qB22Xx1MnSE0IZ7Rqb91x
 Ju0g==
X-Gm-Message-State: AOJu0Yxe1neuFI75SlMO0caOb6W4xUovF7hj25i+kY+ZE+YbNhTf6YOT
 bGUhzHdktlf9Mjtn4MRit2c/6b9sMpMWNRGQj5xH47iUbmlU82W/aJZANiamgmJxakvyNSS1oci
 x
X-Gm-Gg: ASbGncsE3PoFMBz7hlX2okyj5Wqob7Xd2MJ44j+hggvyVNFw5BaFmGOTsr0j7rd55lw
 5ACbyAx8ke6TWIzhwbRoUfrJx7wpYrF8tphhn6K89Qq+ahTe6YIOJ3tZz6ssgqnQIs4KKdvx7Y9
 4DoZvcv+Wl2isi1+tCU+w6rBs75WBzAvs27E55pfiFYtXUV0W5o99N26nkD2bIYcs91jPn10uLd
 m53a5cbLvV/aUCNTly8HQKrssUxlT8WCb1WB5nLTiE425FR0eaStvNgdxrMKNk9FSkztgnBKGoq
X-Google-Smtp-Source: AGHT+IGDHwnu0kTC2IwCG/5P6nYsIiAr6rAJG53KJmKlyWfk0sP06yi80g2RIBxDx4SHqPsyDYYkSw==
X-Received: by 2002:a17:903:2b0f:b0:216:69ca:7707 with SMTP id
 d9443c01a7336-21c35586204mr313532405ad.30.1737528772359; 
 Tue, 21 Jan 2025 22:52:52 -0800 (PST)
Received: from gromero0.. ([191.205.214.27]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d42cb87sm87806635ad.254.2025.01.21.22.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 22:52:51 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	armbru@redhat.com
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH] MAINTAINERS: Add me as the maintainer for ivshmem-pci
Date: Wed, 22 Jan 2025 06:52:01 +0000
Message-Id: <20250122065201.629601-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
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

Add me as the maintainer for the ivshmem-pci device.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 846b81e3ec..c3e69ef3e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2789,11 +2789,14 @@ F: hw/hyperv/hv-balloon*.h
 F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
-ivshmem-flat
+ivshmem
 M: Gustavo Romero <gustavo.romero@linaro.org>
 S: Maintained
+F: hw/misc/ivshmem-pci.c
 F: hw/misc/ivshmem-flat.c
+F: include/hw/misc/ivshmem.h
 F: include/hw/misc/ivshmem-flat.h
+F: docs/system/devices/ivshmem.rst
 F: docs/system/devices/ivshmem-flat.rst
 
 Subsystems
-- 
2.34.1


