Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A1AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbn-0002Nk-9v; Tue, 12 Mar 2024 18:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbV-0001Tq-0i
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbT-0004W8-As
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rnobKvRBI1kxmZ+zEo4/9xYhnFk0DiLD2cKoeuPWbew=;
 b=GRhNtTjemHO9+X/1YAUmBla9XknTzx9Zg7h+1MkP/kjdr3g/0Y4fnse+0jL1iDi5H4NYK0
 MPCj/g3x4aP8bYoQ14ItP06kyc7lSpzd0yn7ZeLNnBem2TPmkCOpM0rZzXVCR5MZ6jMeiU
 j57V9P8QKZZpKBX4dplc3FFAzEGU2hA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-UULgOr5OOMSnecr7gP9Qiw-1; Tue, 12 Mar 2024 18:28:09 -0400
X-MC-Unique: UULgOr5OOMSnecr7gP9Qiw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a448cfe2266so494039266b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282487; x=1710887287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnobKvRBI1kxmZ+zEo4/9xYhnFk0DiLD2cKoeuPWbew=;
 b=wQVIOocvuG6sHrDSZnT6LnyKC+ZLhdeQjXQ4hqWWVqzk+Oq+l8ab2Y+sFep+mns+hF
 HCMx4W5lmyS+hW0gs/dlVNfJfM9kssA5WkcJHdJH7Vnc7UpNCNKS9MNrVukWNNcO1tk7
 wFzb/K7LZi9DxM3pZh41qo3h+cC1tT16YVNjExKcggGP59PcVaLE/22TKnnqss2lsewG
 8WD/OsgTVOLzAfsHd1Z7ArErFa97HlkHHfh/GAmxsMicumLLjsTYi1TG4YFVbz8abmE5
 aNiQktMiRqHvAADvJH6Ps1fLZ6my6JlZrzCKRszsZSAZkJEABE1TWt3FKl3c9jxoPpC0
 UBZA==
X-Gm-Message-State: AOJu0YxBbWg14f8aXJw/icvmEdgOYAAp+zlBJr8paPL5oP7wQRHnqdhA
 2NSeeCDPB5wHME1B2MioZiVqHAyRRT2xKru00GQ898fSrsbmwq77p9Ej3qqzH4twQ4EEfaPmFQW
 WIHQaglqX54p3Pzn1wuG+USd/ZA8r20Zoc6kmheXWflooEA4s9q3oyko7Ei7WcDcFfjrT2swi2O
 oR7ZJqyWKxH29ySOf4VmRgVBFd5NY7KAod
X-Received: by 2002:a17:906:58d:b0:a43:e63b:2ecc with SMTP id
 13-20020a170906058d00b00a43e63b2eccmr6034334ejn.67.1710282487337; 
 Tue, 12 Mar 2024 15:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTrLNq7Dbg6AfyrLulJW5b8yqFhP3W0+WDTcknfkVMZI8z6z/xvHj6UMDaeEFZbP0lSHu6eQ==
X-Received: by 2002:a17:906:58d:b0:a43:e63b:2ecc with SMTP id
 13-20020a170906058d00b00a43e63b2eccmr6034316ejn.67.1710282486817; 
 Tue, 12 Mar 2024 15:28:06 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 bx21-20020a170906a1d500b00a45ff890df0sm4116271ejb.35.2024.03.12.15.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:06 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 48/68] Revert "hw/i386/pc_sysfw: Inline
 pc_system_flash_create() and remove it"
Message-ID: <0fbe8d7c4c7e44fc86986217dc3ab65ec4e6a302.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Commit 6f6ad2b24582 "hw/i386/pc: Confine system flash handling to pc_sysfw"
causes a regression when specifying the property `-M pflash0` in the PCI PC
machines:
  qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found
In order to revert the commit, the commit below must be reverted first.

This reverts commit cb05cc16029bb0a61ac5279ab7b3b90dcf2aa69f.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240226215909.30884-2-shentey@gmail.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_sysfw.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b02e285579..b9c1eb352d 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,6 +91,18 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
+static void pc_system_flash_create(PCMachineState *pcms)
+{
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+
+    if (pcmc->pci_enabled) {
+        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
+                                          "pflash0");
+        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
+                                          "pflash1");
+    }
+}
+
 static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
@@ -198,8 +210,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
-    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
-    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
+    pc_system_flash_create(pcms);
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-- 
MST


