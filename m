Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86052C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPxD-0002c7-4R; Wed, 27 Mar 2024 05:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPx9-0002Zz-Ub
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:17 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPx7-0006ke-DN
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56c1364ff79so3818564a12.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533123; x=1712137923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Js0WEaSYuml8ErvbskM5ta30rxhDRoSlwVbQCDwzIUk=;
 b=Xanmuq6qbSqz3CZfpTIDzgLahQuD3mSzMVBZ4JE+Fc4gJUy7fmkDfD8h/PwC/Q34D4
 +2zomZVW3kjrTdWwyKjnej1560EAWQ6Gp1e16ehZyKWcbOqFBN4WpblW1XbLH26nlZPb
 aSaxIc4CJfxS6CkNcsoyvDzAK/prNTvIGQcAwE6gK3NUIIDSR3AkPXEPRYQURxV2ka0O
 sAN7D9GqoY+X5+/uOcZ6UHv7Jx5rgS+EHphF+tuF5rShUgkXGg6ONHvnLp+MvTVJBRVZ
 gdGj8toXEmrXo512+ugC0qr2NG7w3hiFHlfdEWpkBlxy1WwTy1+hoebUtdm2iT68ywNu
 vuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533123; x=1712137923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Js0WEaSYuml8ErvbskM5ta30rxhDRoSlwVbQCDwzIUk=;
 b=IgybcYXx6tLjIW+6tcU/Euy7E6js1XTwm2YPpdFPZKvXVy6BZj4ut2tq2V9u3YFByf
 DifYV/HE65ohV0E1ntTlCPznfZ+ZnoUX0HaZhAupbzWUFVzCb6H7WLb7IhDmbHENykLz
 NorcwpAKAmSxnOUMEVhUh6MsUGX0GKqpn5OIwGM0mN2ZCPe4CCtEzWXWoqt4o+HqKK3w
 OmbjVf0uWHLP7JocprMeQ1mPUIApt3BPmp7zoBx021/aIEzKOAXj9qvL22D8Aa6WWfmL
 JR62j/AjKZ6ciKKlHcOeDO+ivgh9mT4VUirqV4p4sqIwu2djNVODt6clYuUjSoH2nTD7
 XFHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU09rH07nzevgmbObMe2Kafg6hSpcH97hXFk1g0OVdMvwP+TNeKzzqWfAt8zPV1H+gx6oWh0iVU3IsKgJOBAdP6vUA3KmM=
X-Gm-Message-State: AOJu0YyYIFYEGvsFqvinyKDPpUjbK4Z55QduG00zmAUbvoWa7GNSj5j1
 MCB9zruEuO8VTszCAWziSg2SFvd+qtOLD7pQPKN7ezwpYBIVaa2fdTQyG2sP2DLC9nPbzjABUVa
 b
X-Google-Smtp-Source: AGHT+IHxywKurn8/b3ZgPFDYGU/9ECuDJYTo5pJEp7wZQlIBsQRuJAibAzSqnxJ1OVXAMKBDm7uwyw==
X-Received: by 2002:a17:906:3412:b0:a47:330f:f110 with SMTP id
 c18-20020a170906341200b00a47330ff110mr1508335ejb.7.1711533123448; 
 Wed, 27 Mar 2024 02:52:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a170906244a00b00a46ab5aaffcsm5238971ejb.178.2024.03.27.02.52.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:52:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.1 v2 06/21] hw/acpi/ich9: Remove dead code related to
 'acpi_memory_hotplug'
Date: Wed, 27 Mar 2024 10:51:08 +0100
Message-ID: <20240327095124.73639-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

acpi_memory_hotplug::is_enabled is set to %true once via
ich9_lpc_initfn() -> ich9_pm_add_properties(). No need to
check it, so remove now dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/ich9.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 9b605af21a..02d8546bd3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -153,17 +153,10 @@ static int ich9_pm_post_load(void *opaque, int version_id)
      .offset     = vmstate_offset_pointer(_state, _field, uint8_t),  \
  }
 
-static bool vmstate_test_use_memhp(void *opaque)
-{
-    ICH9LPCPMRegs *s = opaque;
-    return s->acpi_memory_hotplug.is_enabled;
-}
-
 static const VMStateDescription vmstate_memhp_state = {
     .name = "ich9_pm/memhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .needed = vmstate_test_use_memhp,
     .fields = (const VMStateField[]) {
         VMSTATE_MEMORY_HOTPLUG(acpi_memory_hotplug, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
@@ -335,11 +328,9 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
         OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
 
-    if (pm->acpi_memory_hotplug.is_enabled) {
-        acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
-                                 &pm->acpi_memory_hotplug,
-                                 ACPI_MEMORY_HOTPLUG_BASE);
-    }
+    acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
+                             &pm->acpi_memory_hotplug,
+                             ACPI_MEMORY_HOTPLUG_BASE);
 }
 
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
@@ -460,12 +451,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
-        !lpc->pm.acpi_memory_hotplug.is_enabled) {
-        error_setg(errp,
-                   "memory hotplug is not enabled: %s.memory-hotplug-support "
-                   "is not set", object_get_typename(OBJECT(lpc)));
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
         if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
@@ -509,8 +495,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_request_cb(hotplug_dev,
                                       &lpc->pm.acpi_memory_hotplug, dev,
                                       errp);
@@ -545,8 +530,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         acpi_memory_unplug_cb(&lpc->pm.acpi_memory_hotplug, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
                !lpc->pm.cpu_hotplug_legacy) {
-- 
2.41.0


