Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097CAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg82z-0005Hm-LF; Fri, 01 Mar 2024 13:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1rg82v-0005HS-2P; Fri, 01 Mar 2024 13:55:49 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <freddy77@gmail.com>)
 id 1rg82t-0003l6-PO; Fri, 01 Mar 2024 13:55:48 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dcc84ae94c1so2416672276.1; 
 Fri, 01 Mar 2024 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709319346; x=1709924146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=T5POIChyahJc+CzAF7f5jZcebWJKRIFLJlnNHD44KNI=;
 b=lBr1tnNunGsiO6YrP3pragMA4yfg7aeyqZYk2B8Ydiv/4WtfGJ+1lkWFkEXFdX/G5a
 0jzD3OItxBE8Bv2Bp+D5Qan6acCsp/35qslMqfVL4hfnjjt1HTH6UKau/DnOsjp7IdEn
 xRIhLC82H2pRkgfTZzTYC4/VFIBQmbHFZZ1i/zuX30HerImme1XUGFkIyjiSexjzvOwS
 OArQ8vjVDL3b3SYzqp5+ePC6MyRkti7SqPVouFiHjVZXWZEJnUJweWB/TXU2xl3+cLQo
 Z6HklYji+zHKaX7/Zf7aC3GhTul54BTouhaG38Rc1jMRzbCpZQkd/Pgd2UOx/cP19acH
 VqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319346; x=1709924146;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5POIChyahJc+CzAF7f5jZcebWJKRIFLJlnNHD44KNI=;
 b=ViHyeCr8gwFRAM22C9+ch8xKRBKv9D/IrAD7B7WTj0d5bO0yDs8IGAIwocGQbAzPN+
 1D5DbokntPCbQLu6rIwVkaA85DtkhAnwD1hx4JwAjw1DlJ2VdIDADtQ2cJccvutGh9DU
 Aox00DOFk9BVj0Ma1zJ2eYKIOq7SFssblL8F7B+0WACSlJ1s1E2XozmYkzrjcxnhoMSp
 4nQ+Nkm52M1d1BVus9cTjaZyt5gN/n3Ds1mg413k0rFUlZBPzzdb43e7dU8WVAf+vgkF
 5SB1m12bF1BCnM4ENQVCF2rzTeLrsKE7ylEtPStTajfdaQnsYOoEJ2ikKeGzmXlrEMTp
 xtvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiP7qcVgbQQq4cWF001yZ59rs5Wb9osMBD7PovZ8bTovML53lhl8zm2FHIlh+t5a4kRUizfZvpYQhgw0Ne1d+nUSNVAQpgfA==
X-Gm-Message-State: AOJu0YycpEx2/mALNdTbSJmiqkwR4V4Ve7OegSX98qCLMR2ACBHNuJ1z
 Ab2VuelqMBFAUUsov5Q6Ct6eC0RYSVTNMOD+BJr2faPtZ3in8cTkP3YccCS1uCF/N0zdbfaDzTv
 nrlkiZToqQTTrBKFvkwm+12Sl39j3QXttl14=
X-Google-Smtp-Source: AGHT+IFVrukZoiuJWjLHo/RVStiDIizRu873vHcxTChV2RmwIKR7A4pCUTSkCKvzyeR/85oQExU7dGWqoh0UFVtXYag=
X-Received: by 2002:a25:8148:0:b0:dc7:497e:cddf with SMTP id
 j8-20020a258148000000b00dc7497ecddfmr2160440ybm.33.1709319346028; Fri, 01 Mar
 2024 10:55:46 -0800 (PST)
MIME-Version: 1.0
From: Frediano Ziglio <freddy77@gmail.com>
Date: Fri, 1 Mar 2024 18:55:35 +0000
Message-ID: <CAHt6W4fiLh+bBOX1qwvm-1qJVG=j9SrT5rMJnEaMSWPjwwZr1g@mail.gmail.com>
Subject: [PATCH] Fix typo in comment (uin32_t -> uint32_t)
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=freddy77@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 hw/vfio/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 6e64a2654e..4bb7d7d257 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -181,7 +181,7 @@ struct VFIOPCIDevice {
     Notifier irqchip_change_notifier;
 };

-/* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
+/* Use uint32_t for vendor & device so PCI_ANY_ID expands and cannot
match hw */
 static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor,
uint32_t device)
 {
     return (vendor == PCI_ANY_ID || vendor == vdev->vendor_id) &&
-- 
2.34.1

