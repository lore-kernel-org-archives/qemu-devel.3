Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DC0C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saX7u-0000r0-J8; Sun, 04 Aug 2024 05:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7t-0000nd-0e
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:05 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saX7q-0001AW-8n
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:02:04 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so5774911a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762121; x=1723366921;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=se1PRngWzVhYpXsmyJvXcmD1zB/CfAS+yeZv5bDF8lgGMKoXwVXVij4NwY2Eg+JYrr
 dgekPOQdWX+PlNYldzQb34so0Pj/Zog9GKI21O5ZpW48N0uYBAKm7NKWCwIVctKnuKEJ
 4VcIr8kbDo3/6ZxlAnHpUFTfIvHxdD+8WN8gGqm1f8FobjtLypTFwFi3J+BTUJ8iuMKS
 JrIyeIt9tGNXZaVYbNg6u++Ad8dVaR95p85btL2u5iF0fUBRLA67YWojiorwIcSP/oYp
 QCu0gewX+VagKwUB7FLP1VNNRl4zwnxGr9CguGNT6x61QUYaMjo+Cp+FU9eaaa8WDzjC
 5B9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762121; x=1723366921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvYGkO0/34C91V8NXfef8guAibLAhiHYP0GgJQZDQZY=;
 b=HSdnFgRGqT4dzZjVfUh15R7gT43kNWYwyKBneGJtWRf4UsvJzTNrcytJLMYvFtMx4o
 TDvyIjXlFYSRxvw1NTz5kcB0BRmKJhh0RdB0BvTLosunU9JF0+7Og6GNOAqq8yK7k1yt
 Hl/cl28IuE7yBt2rfAYj0ltT8V4AOknjBbvUkHdw9O3gGa2TlXiUPejP+6DCerOPf/2S
 P2dEJCPTTGuF1XfeHBJMSSUZ2jHI/uCA9BZR5l46v0MejHH59oFnU5XVinmgIod8Nxl7
 2mDTK/GzKndymSYglNMg6iKPKqiRifCmsSQrqb9GkE/yIsfum5P6O/DSQgvMd2HegvXd
 pRIA==
X-Gm-Message-State: AOJu0YwvN+TXt5yG4wcPc/qnMt2Q4Pz+NFJqaMI7R7g8gFfiDvEINZUI
 HS5TTXR9E55/mYV25HN6nChT2qvjL3J0sG07NK9mjcdtMv7k7/3JD9d1ZZrTOhg=
X-Google-Smtp-Source: AGHT+IEZB+jzw+fwTdgCj9vPKQldLsIQaA22mri47vxU2RsO2iDG8ZA9d16FmgHw2gIY1OmMQ8gm4A==
X-Received: by 2002:a17:90b:4c0e:b0:2c9:6ccc:2fbb with SMTP id
 98e67ed59e1d1-2cff946945bmr10804829a91.24.1722762120774; 
 Sun, 04 Aug 2024 02:02:00 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2cfdc4064cesm8060563a91.12.2024.08.04.02.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:02:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 04 Aug 2024 18:01:39 +0900
Subject: [PATCH for-9.2 v12 03/11] hw/ppc/spapr_pci: Do not reject VFs
 created after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240804-reuse-v12-3-d3930c4111b2@daynix.com>
References: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
In-Reply-To: <20240804-reuse-v12-0-d3930c4111b2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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

A PF may automatically create VFs and the PF may be function 0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/ppc/spapr_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f63182a03c41..ed4454bbf79e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1573,7 +1573,9 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
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
2.45.2


