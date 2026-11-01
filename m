Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63718606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QHmgzJ9E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNYJY-0004at-90; Sun, 01 Nov 2026 11:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJQ-0004Wx-JZ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:40 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJO-0008MR-OC
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a599e9110eso10696205e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793550097; x=1794154897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DK90sqm1ryXJrmhR0aD7lirEgNJpvXNkoK0C5mHitLY=;
 b=QHmgzJ9E4ZW+RXCwjCFUiyeiHOH7kCPSMuzzNm57lCi4w75/4xsH+BMmIYLHZWsQxa
 wTlILN79p1DliuY+1Ey69UHkW46DHIMRlP9d4r2JQaDvjo/baRxFHrSr9n8C2vCVE/OX
 ZY8+IeF2JEWchfA2s/9HEPDmk1w/FU6d/ySOAxk90uR9/T6nALJEVBsSAp/NAOh8ryv/
 RMnLhrpp1G9pRIIgu5v0ayI+DORDgENtd6wKEUFJIzkt2gcpC/2/ZeeLydf8LjNlnrFn
 mWgcmsYjI6xzmOdtUmyr5xpveuZeXVy2oLpQ1R/8GMX80q+eXX9YWy+gF0NONsEW0mAF
 ksIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793550097; x=1794154897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DK90sqm1ryXJrmhR0aD7lirEgNJpvXNkoK0C5mHitLY=;
 b=GprA7IESLrWN8Op4YOR79G+YIfpZe9ObKvyRfQapAZa0cccmiy16HMlF1kJby0tdMN
 8zWowQjoanMZ6n6AlqTrXVaH71Tkv4drmPFZo2P8ntXnVXWCWFJOiViTaTevV2aCGCF1
 37AERLGgtB16Uitrbv96SJ1xAIJfCwZN9eujPIcyDEWGKXFjyTCOC3sjlkWxyqjJZO8Q
 3eDa2F40rcD26m0/BDiUzq1xv3WRLpJcQElFjApGkWl/dsnGoUjL5BhECistcTW8k1iv
 I+7AtzHBf4OPMLX7Zr1txd53BbfCcs3V4pWcXZuMZBMDkLgJ4lz7zd2fG1fRzoKpeQOu
 j/lg==
X-Forwarded-Encrypted: i=1;
 AKwUvByX3QB/12rwupF3GMoWiYci9PaeThAjPzWhEA+wqFrAgConN7xwd8L6KZVi45Ni8ruLuqWic76Ishfk@nongnu.org
X-Gm-Message-State: AFq9FYKp5lT92pbL6laWAGBOOUmDU4PA9Ob9oP4dK/UE913e2ksN+Y31
 mLm4YOq0G1vnulOSWumlhHkKXZORCNFUqNCT6vZ6vbL170+V9RIazB9k
X-Gm-Gg: AYBFou23yK+r0bwcOoD7W0ti/C4IAt6TQ3tk86qvj5AKUs34LQ5rh7OTP8y/oVNUOuR
 1GGrlx9B9Cubmk/z9PMcPiv2MykASEr5r4nlwyGyGRr2g/ITgtf6uHZfE5K/yu2HjNUJlQbMOJA
 oNPU3XPx7Jl0mbXCBMG+DI9ARLvShJjGi8ctWetSrbQ4SXK8HrZgeVXIzbc+0fsk7OcnoiFmH0C
 dOAKluW0PakEBQBqOJYFuYvrlhJve+xO2afK8B9nubKssEtvFP5eyn2WqGeBr2bi+Sgn4jauuUZ
 0jMUv3G8Nx8GSxmnMRdZaHhQRBgJTuM0B6XoSHjS/As9Q/cTxxoyLd1NcO3ggMFMncj4q300knz
 CE26CLP58nLd7wXAzeMaUOARo0nZi0hVjpNhF1ITUh51hB55vq6md6H5Umc0V5mGH4uzaEbHrRZ
 xNHYKUGiZdvrxzeG6+c/avDgBmA6VKaeXMl3M8HgjgnFugsENr/Qxmen0uZdUNHyj7aAUBbv9Mu
 1T7fknv7rr2rVfIhREGaSpvX935qnJYb7btemIB02I30fF+ckVZ4vEtV9i5QMXVLtdliHxMcBEx
 46BHTzokX73CXE+nn6BvotiexEKFuEofrx84qwvbaX7fJM0H0juv/ZzDcmGPhh7+Ag==
X-Received: by 2002:a05:600c:34c5:b0:4a0:13d8:cd0c with SMTP id
 5b1f17b1804b1-4ac16acdfe0mr174629045e9.2.1793550097311; 
 Sun, 01 Nov 2026 08:21:37 -0800 (PST)
Received: from AtiePC ([2a0c:5a87:5006:4800:78cf:63bd:d449:f7bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm283897765e9.4.2026.11.01.08.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 08:21:36 -0800 (PST)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/3] pci: fix null pointer dereference on pci device
 registration failure
Date: Sun,  1 Nov 2026 17:21:29 +0100
Message-ID: <20261101162132.147838-2-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101162132.147838-1-danielpaziyski@gmail.com>
References: <20261101162132.147838-1-danielpaziyski@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a PCI device fails to be registered using do_pci_register_device, which
takes the PCI device as one of its arguments, and returns the PCI device itself
on success or null on failure, the acpi index is forcefully released using
pci_unregister_acpi_index.

However, this causes a null pointer to be passed always on failure to
pci_unregister_acpi_index. Instead, do not reassign pci_dev from the return
value of do_pci_register_device, just check it.

Cc: qemu-stable@nongnu.org
Resolves: Coverity CID 1689947
Fixes: 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/pci/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2d2fe02c68..1ea388be37 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2327,10 +2327,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         pci_dev->cap_present |= QEMU_PCIE_CAP_CXL;
     }
 
-    pci_dev = do_pci_register_device(pci_dev,
-                                     object_get_typename(OBJECT(qdev)),
-                                     pci_dev->devfn, errp);
-    if (pci_dev == NULL) {
+    if (!do_pci_register_device(pci_dev, object_get_typename(OBJECT(qdev)),
+                                pci_dev->devfn, errp)) {
         pci_unregister_acpi_index(pci_dev);
         return;
     }
-- 
2.56.0


