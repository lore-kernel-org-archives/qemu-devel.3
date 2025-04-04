Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37947C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0jLa-0006rE-Pf; Fri, 04 Apr 2025 11:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0jLY-0006qt-Fj
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:52:44 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u0jLV-0001T7-Mr
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:52:44 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3fa6c54cdb2so1638212b6e.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743781960; x=1744386760;
 darn=nongnu.org; 
 h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vXQjPVQOf1IM+nKzoIBxjpgRpzuRcwdMT+CPBQ3MAFo=;
 b=KSWtqBB7cUrbPomSlPOEf4bNz3KksBfv+UxOxcKLIJ+BjIF90ce1TXOINytxpGQZW2
 Z4DCFWzEvJvr8wmaMblDuhUOliq3IPsEYcTqL9Z5ig3fxlHcB5yAd9swj8Z0YSrbGGa+
 Knalk4PYzui0dOzkGO2HO4sdv9llrtcxLxVghtjsWmwBK4v3xZN8uO57WDv52w2LQe8M
 J4B6KjgKhIi8GuifgpWozGKNR+bT85INYhxc0wCREnOLZR/3fbNugzG4foOftDOI2g0K
 2vawvIsPYdX7w7mRdwCmbeKdyzxhr+vJK1XzC7BHKAKlSPtH+6aXHoKz/avc8PhzeA77
 E5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743781960; x=1744386760;
 h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXQjPVQOf1IM+nKzoIBxjpgRpzuRcwdMT+CPBQ3MAFo=;
 b=XGhKk+lyGk4SrI0klw9LD6khAOMvOrcyfqXK4gNhXjgqS+iw/DcmS3sYo1VHNedvrG
 Y1+rVRrWA5D6XilSKzW/BhbFFqMJDmS3/8QUFToOTZy2F2JKJpnnw83tVY0BIi6FrZKu
 fbQKQoUvMVjCGZJzV10FbhXf1axrv/2oQVdFT3w3BSOkkClcYnETOLKsaUm7pqVhxZWa
 h0f9GYmzpfyF6khbugFTCEDqHYkSL8Bmf25ooscuE36GlfwceAPyJtptN8TpR3JiiuPq
 T4jVagslSsbkeBXxH9Il7hoNzqa/vSZ6/yLSNI1ny6ankMznkhz6n8zA+qpCMKxoKpO1
 kxTg==
X-Gm-Message-State: AOJu0Yw3o83wmwIdA4jBM3ajNytxSH+MGYQlta2oYmueh15U1PPf1WSo
 EJwAjwPkrwfWOqjlbqKmEFTqBMFqq+ovwDaUit5o8hOWUkWRjNXRUEjQMW8D1nl0XjK+ZBVvz6u
 G
X-Gm-Gg: ASbGncu5Ib7X2rHXF7K1Zcj++TqV9kjGMGiXo14YKdfReRzDRgTieX0a5t/LHNZ7aZY
 DHTxgP9qla/Ot98UE3DZ1X1SOxwXLZ28NrrfFWbPPotlxMyF5lJry3TPtT+a8Y1gmKTSWmxn19P
 X+ko8GYCEmZZWIxUncYTQUIKGmN/gxFK3G2w1UQA9z0serFuQq2tTYLHBRTlAeDMEMzrZJc+5Ot
 iB6JnovryI/B0ZBXjy4DSP5twumZxMhrkn+DMfuI6mgFsPMDg0w4X2bbr2AcYWssguWlwvyOHMT
 Xth8tBxOiMWdhEj15zOVANbWGbiq2aZLEYonZUGDuJge4yNa
X-Google-Smtp-Source: AGHT+IFaqAD4M4JyUjRE7DsG4IA+YeU+h5Y6DibYu/5VnsWvH9tD7L/ppOj32ZFKsuHhvkn/PyXniA==
X-Received: by 2002:a05:6808:22a8:b0:3f9:d5a2:8999 with SMTP id
 5614622812f47-4004655e008mr1854599b6e.3.1743781959707; 
 Fri, 04 Apr 2025 08:52:39 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:5413:2ba6:c80b:5b46])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff4e3edsm675352b6e.6.2025.04.04.08.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 08:52:39 -0700 (PDT)
Date: Fri, 4 Apr 2025 10:52:29 -0500
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/ipmi: Move vmsd registration to device class
Message-ID: <Z_AAPdpBWQjXq6fJ@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=corey@minyard.net; helo=mail-oi1-x235.google.com
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It's the right way to do it now, and it handles multiple instances
properly.  I need multiple instances for some testing I'm doing so this
is the right thing to do.

Tested by doing:

   (qemu) migrate -d exec:cat>filen.mig

before and after the fix, then:

   scripts/analyze-migration.py -d desc -f file1.mig >file1.json
   scripts/analyze-migration.py -d desc -f file2.mig >file2.json
   diff file1.json file2.json

with no differences.

Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_extern.c |  3 +--
 hw/ipmi/ipmi_bmc_sim.c    |  3 +--
 hw/ipmi/isa_ipmi_bt.c     |  3 +--
 hw/ipmi/isa_ipmi_kcs.c    | 12 +++++-------
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index d015500254..3e9f8c5a50 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -497,8 +497,6 @@ static void ipmi_bmc_extern_realize(DeviceState *dev, Error **errp)
 
     qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
                              chr_event, NULL, ibe, NULL, true);
-
-    vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
 }
 
 static void ipmi_bmc_extern_init(Object *obj)
@@ -528,6 +526,7 @@ static void ipmi_bmc_extern_class_init(ObjectClass *oc, void *data)
     bk->handle_reset = ipmi_bmc_extern_handle_reset;
     dc->hotpluggable = false;
     dc->realize = ipmi_bmc_extern_realize;
+    dc->vmsd = &vmstate_ipmi_bmc_extern;
     device_class_set_props(dc, ipmi_bmc_extern_properties);
 }
 
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac7120..bc0ddc52a9 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2187,8 +2187,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     register_cmds(ibs);
 
     ibs->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, ipmi_timeout, ibs);
-
-    vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
 }
 
 static const Property ipmi_sim_properties[] = {
@@ -2212,6 +2210,7 @@ static void ipmi_sim_class_init(ObjectClass *oc, void *data)
 
     dc->hotpluggable = false;
     dc->realize = ipmi_sim_realize;
+    dc->vmsd = &vmstate_ipmi_sim;
     device_class_set_props(dc, ipmi_sim_properties);
     bk->handle_command = ipmi_sim_handle_command;
 }
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index a1b66d5ee8..474a792c9a 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -117,8 +117,6 @@ static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iib->bt.io_base, iib->bt.io_length);
 
     isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
-
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIBTDevice, dev);
 }
 
 static void isa_ipmi_bt_init(Object *obj)
@@ -147,6 +145,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(oc);
 
     dc->realize = isa_ipmi_bt_realize;
+    dc->vmsd = &vmstate_ISAIPMIBTDevice;
     device_class_set_props(dc, ipmi_isa_properties);
 
     iic->get_backend_data = isa_ipmi_bt_get_backend_data;
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index d9ebdd5371..94bbe45d35 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -72,6 +72,10 @@ static bool vmstate_kcs_before_version2(void *opaque, int version)
     return version <= 1;
 }
 
+/*
+ * Version 1 had an incorrect name, it clashed with the BT IPMI
+ * device, so receive it, but transmit a different version.
+ */
 static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
     .name = TYPE_IPMI_INTERFACE,
     .version_id = 2,
@@ -119,13 +123,6 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
     qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_length);
 
     isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
-
-    /*
-     * Version 1 had an incorrect name, it clashed with the BT
-     * IPMI device, so receive it, but transmit a different
-     * version.
-     */
-    vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
 }
 
 static void isa_ipmi_kcs_init(Object *obj)
@@ -154,6 +151,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc, void *data)
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(oc);
 
     dc->realize = ipmi_isa_realize;
+    dc->vmsd = &vmstate_ISAIPMIKCSDevice;
     device_class_set_props(dc, ipmi_isa_properties);
 
     iic->get_backend_data = isa_ipmi_kcs_get_backend_data;
-- 
2.43.0


