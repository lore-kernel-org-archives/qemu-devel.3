Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E47BC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMQG-0006F2-Vy; Fri, 23 Aug 2024 01:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQ3-0005cp-C1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQ0-0008NB-8X
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2020ac89cabso15118945ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389258; x=1724994058;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1EH/aHXKf0I4GydXqDhlyHJMWgC5ukj8mIGCdjS/Jn4=;
 b=XAWpIozx3KysePLDDNXO8dLQq/UlS0WLMeefRun608ix7vurvOSQgWu2J/KaB9KpFz
 At3itfXU1fIzg3c3yHWjM+UpPtoJd+luTbtHDuTNWzPti4euJIwxXXCNyUwgT7gqrwoj
 +U8haodaIRewGwFMxtEIaB7CBx0pTH0DKUrOJgOEAwMOspwD7FZv2oeHoF/PqPwo9/gI
 RoJ9X/sdoOtIlRkyc1HV3JaZUGNgwRwuokoB8wwW2WunzLx49eWeRIZBmmyHc3cRYdCm
 mdp5gfcO1VbF5LMb9ybVM4T2xBPNEum5LGwpOjJA4wQEjjlqQSSW4i62GyZjULG+y71T
 oD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389258; x=1724994058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EH/aHXKf0I4GydXqDhlyHJMWgC5ukj8mIGCdjS/Jn4=;
 b=kB7UL8+SWKbgIeDGrpq5xqbua3TqkfAdnfFy4bW2Dr3w2s0nmirz1nOplb68CrpKHg
 Q7dSHao0Wplj7e3WD3pGdQquRwz7C0B5ceoQWXodsakJ+v4C8ujO2YRtf/p4JItUWKn0
 el3B4UKhBmMrt5cSuhdrljX1XArVrEjGJ5kJ/TqaqtOZVmW5Cn8bTtrAhbgT/dWGyOER
 YV3Q9Dk8UuNkaD7B8hfu2rjQYfWCGotOR99bJlOq8EdTWfuQgat2B8usKfwBvyBCS3u+
 nXvLomeE0p+6z6kJWhkjN0BnbxNV04suqTY835G+z4kWSOyido23zQ/+X9OxMqpKSFyn
 O4AQ==
X-Gm-Message-State: AOJu0Yzf79Err7temsCeiFdcUg1vlC0JIYUel64kC6bs11FxhxDrXdcA
 X/+Z8Y4uS5BVcEkXYEkIHI8WtX4sBmo+lYdz07AMQQntqb7wSjPnV+Lcyat24HQ=
X-Google-Smtp-Source: AGHT+IFJPU/ZQk7YLLmmkfIvYw/sTQH1F4ovLsoe1qB9E7inPyUhusf0saDy3auTBJy4WZSiH2SQpw==
X-Received: by 2002:a17:902:cecb:b0:1fb:8cab:ccc9 with SMTP id
 d9443c01a7336-2039e4e8468mr11032935ad.45.1724389258450; 
 Thu, 22 Aug 2024 22:00:58 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-203859f00fcsm20697475ad.247.2024.08.22.22.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:00:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 14:00:40 +0900
Subject: [PATCH for-9.2 v15 03/11] hw/ppc/spapr_pci: Do not reject VFs
 created after a PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-reuse-v15-3-eddcb960e289@daynix.com>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
In-Reply-To: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
2.46.0


