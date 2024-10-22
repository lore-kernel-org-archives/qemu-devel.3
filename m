Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DABBD1CDB8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AOL-0001S0-9r; Tue, 22 Oct 2024 04:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AO8-0001M8-UU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AO7-0001SE-ED
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cb89a4e4cso37418315ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586230; x=1730191030;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X+r+qLBzRY4WeVgJO0/0ofS90QVM4PjiCp2hM8/EckU=;
 b=YKrJK4RfbyhQvD1y1gdvcqFeGsSxlw8mSbtkQTUtjLnqlONYivIh3woQP6RJuQOZxW
 hY8aQyy4SJkXIXHk1g4NohUYnFAwaf9obnjLhvDaN0EQ0gD4wop7BMoQ6coLEH3rzivx
 zJcENTyCAh3V4L5hCCJLOzF8+O1i24KqMtFaVr9womuQMoQCogWgXMAm0Tyd8Lj21Ben
 GLUzG+FpAWDhqZIcCtRMiiMoV7MYWK80Exk8Xo5o1Qge+Lr5iUm/7vD1smnDI0xTB00+
 8dNV5ZkfrNmnbeMqSXAsUezNxgPkR47oUdWKFoC/6QiU7wsisc527QM1Wb4YZggHSnQL
 AR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586230; x=1730191030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+r+qLBzRY4WeVgJO0/0ofS90QVM4PjiCp2hM8/EckU=;
 b=JAdoUZOeYucPm1uID4BW+ILmjBuM9IXvw1EeS5l2KP4MIVnlAM0HL/hIwtgwuhS5eI
 TPEYOVvTTr38ejIQKHraAkLye/NFlZlcng3LHRzQKgXQxW4smhZbg1AvYRuGzTSdAVDe
 CLKlWqF2HqmHj44AbnkmLAMVTPgQFfrTDc3nZBy5MbRSKlo2wAtDzgK3cLbMoA18bLyM
 15Rr78WdDq5fjIXbNy7Q02xa9g9f8v3b9693ttx9HsoUYTxqPJSCbBYTM5IdFQwp93SJ
 Bx+a5QRYDeEEmovAWGCMJEVStSlv+iz/cXUNZpwgbio0NXuSLZT1muRcHWhDDgJhtnGG
 aZQA==
X-Gm-Message-State: AOJu0Yx9wTyVsRDZ4A1sPaWndJwrWaSy6+a+dr6M18ujpLmBvnxAj9QE
 jMWSE5FJOv4Dvhys6I0wn/jVqyMIoMR2slfmlYP9EI87tX8e20eXMkc6TPuZrlU=
X-Google-Smtp-Source: AGHT+IHwJc4hOqFWQqrrCs5FrHlLFf4sst4QG4WF2cQD8nvZFtmn3nvJxbcq16mfXKkzTnRsvmarHQ==
X-Received: by 2002:a17:902:f60a:b0:20c:9821:69b9 with SMTP id
 d9443c01a7336-20e5a71edd6mr189646905ad.5.1729586230094; 
 Tue, 22 Oct 2024 01:37:10 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-20e7f0c167bsm37922855ad.140.2024.10.22.01.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:39 +0900
Subject: [PATCH v17 02/14] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-2-bd7c133237e4@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Disabled means it is a disabled SR-IOV VF and hidden from the guest.
Do not create DT when starting the system and also keep the disabled PCI
device not linked to DRC, which generates DT in case of hotplug.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5c0024bef9c4..679a22fe4e79 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1291,8 +1291,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
     PciWalkFdt *p = opaque;
     int err;
 
-    if (p->err) {
-        /* Something's already broken, don't keep going */
+    if (p->err || !pdev->enabled) {
         return;
     }
 
@@ -1592,10 +1591,10 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
     /*
-     * If DR is disabled we don't need to do anything in the case of
-     * hotplug or coldplug callbacks.
+     * If DR or the PCI device is disabled we don't need to do anything
+     * in the case of hotplug or coldplug callbacks.
      */
-    if (!phb->dr_enabled) {
+    if (!phb->dr_enabled || !pdev->enabled) {
         return;
     }
 
@@ -1680,6 +1679,11 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     }
 
     g_assert(drc);
+
+    if (!drc->dev) {
+        return;
+    }
+
     g_assert(drc->dev == plugged_dev);
 
     if (!spapr_drc_unplug_requested(drc)) {

-- 
2.47.0


