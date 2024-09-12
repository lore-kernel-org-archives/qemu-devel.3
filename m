Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE9EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socDJ-00062k-Qj; Thu, 12 Sep 2024 01:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1socDC-00061r-IZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:17:46 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1socD9-0001hU-IL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:17:45 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2da55ea8163so388683a91.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726118260; x=1726723060; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aijQxr7Ge2hZ58EmONkflCCjak9k0oktLgzSSHNPzh8=;
 b=JgjPeTX65qM/S+3UDnsYuq2dwesjOToAkljk5Xc90U+jWbx7X9Nn7t1AOUP6bUeaN8
 ndDyG1aY8gMn0SlEsKhY1yIBGCn6K+jwv4X/0Q/KniMCagF/Yd48X52rBahFblEY/FI0
 QUf7+KiIVUUDxnybUwO29KfAWppTgpyu2zuwljDMS1hfZSNYdNIFzSYFD2j0HPVNK/RU
 tPuocDYGBAlcSoSfpcoDG7o0Lw7KbD7uW3mUB60advN2gVy/HMvy6iRaYHNYxexvXlp2
 D26DJcP49Z5WLIKgCSt4R71u1hiH68BSMsu2WNgPsCNIEIxb8mU/SNYxQLswXe6IJMg/
 vCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726118260; x=1726723060;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aijQxr7Ge2hZ58EmONkflCCjak9k0oktLgzSSHNPzh8=;
 b=MZ2ALoAo2d2vFXzY9Az2lPJkoB3JEqnG5Q1XT8/sPr8bRLU2DLRuEOl+4vrzZ4wW2P
 6D+7tgFx9NnayHVCRQM0ynYEQOJxyM7yzHwnKzl4LubcpMHH/NDtm6zczaLqBedH+Alm
 JgAI5fVKo0CsBOU9smE113uS+HYwIdscG+thcwVuTMi4XBh4Jjala73st7ZTdHJMbedF
 7wQwsPTAcQaoOUbsWODhlgE2rTN4lVJSVyG2QmRNOQ1hIzNeGD64lBvc8D0ob+tzWziO
 C3Vf6iQYWeB6klWG2lG9g6jQq97MaFfIYyegjLYFBOa8YIJuxTDLwxy7ARFSqNvDzF8o
 j/qw==
X-Gm-Message-State: AOJu0YzJb63+iFjKmw2qB9X/B7Ug3WfDrFrFTm5+c1meXazs0bo10Nfa
 dhCUEkE+pgf1nKyGZg0ui0bfRm7i5vXEGFxMVpDu1r7iU/Zhs+64eDyLF8IQHhyTtxpYeV9LwCr
 tA7T8eApyVzsqTUID6k8V8I46nDaVpR6tSgVWzjKzpa4CeB2C4vAGJO8zduqdMlImqYC9cbvFRU
 5VXU4C/UPRuotGMmD3hdYN17ZLUgNXAbKrrg==
X-Google-Smtp-Source: AGHT+IHaktDKId+1qqO8wUF2VuL73OprXZG+imHQ9urlYMVAzhMunTEtwrZ9mgVIaGm9QsaHjuW/Fg==
X-Received: by 2002:a17:90a:114f:b0:2c8:64a:5f77 with SMTP id
 98e67ed59e1d1-2dba0084dabmr1924928a91.37.1726118259769; 
 Wed, 11 Sep 2024 22:17:39 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db04966d3asm9452185a91.38.2024.09.11.22.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:17:39 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH] vfio/pci: Fix null pointer deference from error API
Date: Thu, 12 Sep 2024 13:17:34 +0800
Message-Id: <20240912051734.5298-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1033.google.com
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

pci_dev_realize() use the local error variable, which requires
`error_setg()` API to allocate the error object at first.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0a99e55247..d994ad8bb9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3117,7 +3117,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!vbasedev->mdev &&
         !pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
-        error_prepend(errp, "Failed to set iommu_device: ");
+        error_setg(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
 
-- 
2.17.1


