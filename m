Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8766C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiJJ-00043t-8b; Thu, 27 Jun 2024 02:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJC-00040V-Um
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:39 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMiJB-0003d6-DB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:08:38 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dfb05bcc50dso6633611276.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719468516; x=1720073316;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=vWFzAReEqxJ2m39tuTNUvgHRzemSQaZjCwiy6uWsnAYghiGYX7DhXIz1UeUAyiMlOm
 dhON+mWpSCAsFxp8S9nvXRRkWJYtXk2nw1jN2lWY2iQ4EXnoLPuQvWsTb/HM4B/QYERZ
 LSh/RHG2osTV3Be0BW71W4LhEAmxL/Fghght901z/LELUcTqO6uDgVnAv0jQ5mboMVZM
 qZbD452zV2FzY9wAt4+JXHJysX0Bag2ItdL1qGlstirnF+xRi+5UYAE86EClP00z5iwE
 ouNrnISqxZ9HyaFB7avnCK4pYKpEDBCLUdeVlM+Q2nB8GrZOsmTrS+qgJajoP1yNaodm
 ZFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468516; x=1720073316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja+2Rln8Aybt08irPb0En7wqcDpJy8xF+oHU5uY2BGc=;
 b=QPohUPK3kG4n5ZRY0sbEfuXjAfCh3xigXNfLWrK9vYoQ0vS2tsk7xDxSD+A/JKegVP
 RchTQGv6eo7Jm0mlRQTH0PK4PIirP/g5kvy/AVrQz4Hf1Ne1+XrIUig3S2UG869xRPeQ
 LM0COuyTQ2/6WB7+p1ZPZXrMgGMvMz/VNruQzf1ypUUT/FBvHWXyCU1RF71layl+bsZE
 yIgrWLpGfYafIC38O+bujd4O5r24TiZI/cxqWjF/j2sV2RmxVLKGuMfuJ7U64CLPI0Hp
 C2JRC5IVIERtb2UjptHPdX2BZAMTCqCLhKMeu4PjrYRllDlwRRMVPTUfbE9EYhtt88xR
 82MQ==
X-Gm-Message-State: AOJu0YyyKOp4DmKKXqwQhzZiYmPriSaeYYF/sGD39eqxVSZxTjZWvTPx
 2/wk2A+K0BJ77ZSvJjDWUmCwv0eIjsEH76YMsGE3f7bB8SJCpQcZau3v8UYk01Y=
X-Google-Smtp-Source: AGHT+IHRAMSiA+qtNMG/28AWXc0G70gvE3PvTjO9/2O2KAZ/qARfJJxtodx1H67LwoTS3l/oxOpgEw==
X-Received: by 2002:a25:7d47:0:b0:df7:8dca:1ef2 with SMTP id
 3f1490d57ef6-e0303f34dd7mr12721208276.34.1719468515692; 
 Wed, 26 Jun 2024 23:08:35 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-72748e84f06sm433399a12.62.2024.06.26.23.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:08:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 15:07:53 +0900
Subject: [PATCH v10 04/12] pcie_sriov: Do not manually unrealize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-reuse-v10-4-7ca0b8ed3d9f@daynix.com>
References: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
In-Reply-To: <20240627-reuse-v10-0-7ca0b8ed3d9f@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::b30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yb1-xb30.google.com
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

A device gets automatically unrealized when being unparented.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index e9b23221d713..499becd5273f 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
     }

-- 
2.45.2


