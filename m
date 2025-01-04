Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EDAE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyy8-0001QD-QC; Sat, 04 Jan 2025 02:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxy-0001H3-ON
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxx-000344-74
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:02 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso176406495ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977180; x=1736581980;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DRA5SFwLixA5p1Smgb33TcMmhiFuTV2U9nSiZzVSvuY=;
 b=KhK7lkjmCvPcimKd3LowOnDgIv/tZ/aNLqc+f9BGsvMMUNk8ZCnCswDnn+c9q7v2bf
 2Gka+uKCgmNSW7K9EilDs/6QXlvb0fFAY+snM0fnd5u3/jTYnCKVv/VMC+Uk1zbiVkUb
 54RFKIHur9U3TwJfG9uC7RWIRpaEVzCQ5bu+bCoJH+ILdrbruZ0QD3qKR1T4UeuYBZpy
 56VoSW+CRM/HoC8wUXvf2cAyT853gRQ36g/lfzY9B1VRLEtvTngupZFdFVgEm0CII2Mp
 kEZIrJ6CyqXDPwbBlNP5oYQqptgizq3mwYhC+KLVWN7Xm0mfZazkMgSzbO7N6HXDTMlB
 dA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977180; x=1736581980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRA5SFwLixA5p1Smgb33TcMmhiFuTV2U9nSiZzVSvuY=;
 b=QZtWIw3rQUZDYIkmRlpfXw68ZPo+vhUMbQN4tI9bgqtMbPiXtA1qysrIUba51GPDk/
 hvW1fgxl7UoIrwWxOX3vC4MQSTLYaiQ/Xz3exmCWgdWmPoelOANEGtJHJuNClutWUIeg
 4ogWZ9zykauxBOqklVPddEOU/rDKvk4FK+66JrnFgHQzTPZnSnUezJPjxBY5Tq+K+ZHW
 dm+jW/j7FPS4abCvKofte8RtZ0vm9UrLY8zkTHRoIBt3gS+6VmcypuTZxUd8aXJ1bQAs
 GlMK+fpYIArb4PcS6GxD39gejC7L6k7WaZct8njcU5pdLf7UW2MHbjgO77PsJneLoNUs
 sg8w==
X-Gm-Message-State: AOJu0YwEjXVcTHaVDwn9Xv/Y6Q05JZ1hHAm5VFLvrbzYdIcw40E1EF3/
 6z0PGAaRulKGfGSlF1YyHj15KRQQliDC7BHtKF5DPdMlLQFDc26b69Xut54bLl4=
X-Gm-Gg: ASbGncu7IJHT5eY0uqJwynZ5sJL7xn2BpyCF44siad+MUuPJhS2ifBEmSG+3JG261Fe
 XPYewPf76yYc+zb80xEwNVMkZqXSPVP8zrCwGAnMhd2J48xaYc4ABxdnXp+XOOkojAqnXwaYfqL
 qUR5Aa7GS4G5iCjsZr0bAnxNcdyCjZLOmE8rU1hhz8xnPhzFiGaNLV0s7OhlzMdnwH2HDleEmn/
 qejP01A3ppLu1/Fkfm4u2V4vQKD7zjT1CyKQQ6JmQCM86CUWRbMOyFoCVlj
X-Google-Smtp-Source: AGHT+IHsPO9c/m1yuEg5mf+TBn/tNlRwyfyQ3WC5KCu8ejCc4wAW43JYbhRNDvAz5XDtyKzwJhX+dw==
X-Received: by 2002:a17:902:ce83:b0:216:5b8b:9062 with SMTP id
 d9443c01a7336-219e70dd21cmr775551145ad.54.1735977179942; 
 Fri, 03 Jan 2025 23:52:59 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc9f693asm255751135ad.224.2025.01.03.23.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:52:59 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:24 +0900
Subject: [PATCH v18 04/14] s390x/pci: Avoid creating zpci for VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-4-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VFs are automatically created by PF, and creating zpci for them will
result in unexpected usage of fids. Currently QEMU does not support
multifunction for s390x so we don't need zpci for VFs anyway.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index eead269cc285..8c5eb69f7d76 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pbdev = s390_pci_find_dev_by_target(s, dev->id);
         if (!pbdev) {
+            /*
+             * VFs are automatically created by PF, and creating zpci for them
+             * will result in unexpected usage of fids. Currently QEMU does not
+             * support multifunction for s390x so we don't need zpci for VFs
+             * anyway.
+             */
+            if (pci_is_vf(pdev)) {
+                return;
+            }
+
             pbdev = s390_pci_device_new(s, dev->id, errp);
             if (!pbdev) {
                 return;
@@ -1167,7 +1177,10 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         int32_t devfn;
 
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            g_assert(pci_is_vf(pci_dev));
+            return;
+        }
 
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
@@ -1206,7 +1219,11 @@ static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
          * we've checked the PCI device already (to prevent endless recursion).
          */
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            g_assert(pci_is_vf(PCI_DEVICE(dev)));
+            return;
+        }
+
         pbdev->pci_unplug_request_processed = true;
         qdev_unplug(DEVICE(pbdev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {

-- 
2.47.1


