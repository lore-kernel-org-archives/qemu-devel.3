Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C603D1CDB6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AON-0001f4-Bo; Tue, 22 Oct 2024 04:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOE-0001Qx-PQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOD-0001Tw-9i
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:18 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-208cf673b8dso51982655ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586236; x=1730191036;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gEfac4mtNaZvgozcAQ25/IZsgf8tGhGnh3wtGi7jnbk=;
 b=OWeTonHIYC1nsFR2DqFSlaO2eHWqvEqWtWeSoiJKnMvoP8FEljZmocUNCMbqkJWwzj
 dUaQnBjMX4flP/kXNbPzyTIcMhjFbvlTi3LpR9evBNCBfDxVfYP00FDyIzWDiaPvBSeK
 Y27ox8plVOvWH1AjMB2Hqy05DqaG/QskOEmOKuyH0UwJCzM3RbKUpRz2oepOfDtQzBNr
 WOPnHrUI2VNDzeAo2BqLkCBWK45Ngshtbr0HZUoIIuEgwFqTfDINRT7DaM4IAvYVkd8q
 ZctZvZmXi0c3Cdbgw4j+coBc/tPWed7JYlH36CmY5Fkg6lfeJA8Yc5D9vdcdlNCRocLl
 /JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586236; x=1730191036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gEfac4mtNaZvgozcAQ25/IZsgf8tGhGnh3wtGi7jnbk=;
 b=ciZimC4YcLvnCxCCmO2cELaAPNNI6wXQueiN1TNwJgZ0SX31EEa40GvRrlzi25n3EV
 9/+E5j/zAuhXiBZBjjSFs7FVTRuUhxK1dwhWKs2ePbmk1HCOo4CbmT1bXQfaJBYAPt9O
 va5tiXc/JGEsnkneK2TrN1Se5aAPewFB6/sgo8eJ/MFYAo4nv8HwT8dOoGe45IDoROgF
 dnbHVR/01V/mqUJaqzHjHvGJ24gJMy+yYrb0gTWV/qY6mv0x4WPtLnYUU8BaG+8dhBSa
 mkRsctALPSZM6wjq5p1CRyJ5rmDx9p9SPoA2cAjHSmAllNUVnVdVXTahB5Hdbk2+lUjO
 5h9w==
X-Gm-Message-State: AOJu0YwkICqMAzbe9s8Uj0Z2dQvCtVTRtIMlzXUVwla7sNuP00UenWlH
 ld4yOiRsqTmBWMEEulTUNZ0XHxPGJ7WJQ3rBnlA9k/FALZ9cHz70u9zWt9Pj/bc=
X-Google-Smtp-Source: AGHT+IFkSzclRvDLqPCDqmZav5HPKvqBmiSCMjA3sf+b6RG7E/oldAIFAE4b8UMU5ebuTOJNCPRaZw==
X-Received: by 2002:a17:902:f644:b0:20c:d1ec:aeb with SMTP id
 d9443c01a7336-20e5a76124cmr201175595ad.21.1729586236094; 
 Tue, 22 Oct 2024 01:37:16 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7eee6521sm37907505ad.31.2024.10.22.01.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:40 +0900
Subject: [PATCH v17 03/14] hw/ppc/spapr_pci: Do not reject VFs created
 after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-3-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 679a22fe4e79..31ffe8ba4340 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1568,7 +1568,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
      * hotplug, we do not allow functions to be hotplugged to a
      * slot that already has function 0 present
      */
-    if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
+    if (plugged_dev->hotplugged &&
+        !pci_is_vf(pdev) &&
+        bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " additional functions can no longer be exposed to guest.",

-- 
2.47.0


