Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A70F3D315
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBE9-0003sY-5U; Thu, 05 Mar 2026 11:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vyBDW-0003YW-Lp
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vyBDS-0002jA-DZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772726781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YDjE+9k9MNmsvq+6ukykaS5k+agsXvI0qYXR8mKfBo=;
 b=Eel5tm2RPThRPyMHTVtwzYctCCDD8LCE7OXYT7LIk2GREL9jkNepJhctdbXJzFzQvlXCkA
 YU1R6oSOZJpCwgVeVRDFkjjIeswF8955I9Ik6DSXVgOsESNGFyxHrOZjAo1bnXP2sX9gem
 OkYHjP9UJQkVZ0FFZF+GY+mcJvkokmg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-W7QtM-m4OtiUPR7zZqgbiA-1; Thu,
 05 Mar 2026 11:06:19 -0500
X-MC-Unique: W7QtM-m4OtiUPR7zZqgbiA-1
X-Mimecast-MFC-AGG-ID: W7QtM-m4OtiUPR7zZqgbiA_1772726779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD9AB1800623; Thu,  5 Mar 2026 16:06:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E85AA1958DC5; Thu,  5 Mar 2026 16:06:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, philmd@linaro.org, kraxel@redhat.com,
 thuth@redhat.com
Subject: [PATCH v3 17/16] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Date: Thu,  5 Mar 2026 17:06:14 +0100
Message-ID: <20260305160614.2525174-1-imammedo@redhat.com>
In-Reply-To: <20260303140058.2423099-1-imammedo@redhat.com>
References: <20260303140058.2423099-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
in the pc_compat_2_8[] array, via the 'x-smi-broadcast=off'
property. We removed all machines using that array, lets remove
that property.
However the code related to ICH9_LPC_SMI_F_BROADCAST_BIT
(OVMF optimization hack) has to stay as SMI broadcast is not what
hw do by default, and it will cause guest reboots if SMI is triggered
if firmware is not aware about it (SeaBIOS and pretty much everything
else except of OVMF).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
   - use |= when initializing smi_host_features (Thomas)
   - send SMI broadcast is OVMF hack, and has be be negotiated before it's used
v2:
   - do not check for SMI features if hotplug happens when
     SMI is not enabled. (matters for qtest and possibly seabios)
   - removing property also removes default ICH9_LPC_SMI_F_BROADCAST_BIT
     put default back in place only set it initfn() instead
---
 hw/acpi/ich9.c    | 4 ++--
 hw/isa/lpc_ich9.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index bbb1bd60a2..87afe86bcc 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -432,7 +432,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
-        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
+        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
             !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
             error_setg(errp, "cpu hotplug with SMI wasn't enabled by firmware");
             error_append_hint(errp, "update machine type to newer than 5.1 "
@@ -476,7 +476,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
-        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
+        if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN &&
             !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
             error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
                              "by firmware");
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 51dc680029..8517ec9cae 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -476,11 +476,12 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
     if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
         if (lpc->smi_negotiated_features &
             (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
+            /* optimization for OVMF with ICH9_LPC_SMI_F_BROADCAST_BIT */
             CPUState *cs;
             CPU_FOREACH(cs) {
                 cpu_interrupt(cs, CPU_INTERRUPT_SMI);
             }
-        } else {
+        } else { /* default ich9 behavior, SeaBIOS doesn't have SMI broadcast */
             cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
         }
     }
@@ -685,6 +686,7 @@ static void ich9_lpc_initfn(Object *obj)
 
     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+    lpc->smi_host_features |= BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT);
 
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
@@ -834,8 +836,6 @@ static const Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
-    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
-                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
     DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
     DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
-- 
2.47.3


