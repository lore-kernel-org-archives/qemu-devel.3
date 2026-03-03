Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45290EC1454
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQJz-0001gu-Ea; Tue, 03 Mar 2026 09:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxQJG-0001e2-Ia
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxQJC-0006sc-Cc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772546468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocKWBVrFMFsX5PqPkynIrsMVJWrJy74cQL6Eh5x/eTU=;
 b=MB+70Yo853FbmQRYoUq08KM7raVwpQe1TC4kN7SqnDNIJvUUylNP+ciiHnTJGChZuw77WO
 p3nkwZb8TujHHY4E2lacVwrjNhZC6SHVm6zP9MxRD5aTLRVc6bFp0smAvN6tdgSZgQYMNa
 lf35gisoMM5GWfWYEgR4HfgSc80yqlA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Y50mUOKINse3lHA6E7RU0w-1; Tue,
 03 Mar 2026 09:01:04 -0500
X-MC-Unique: Y50mUOKINse3lHA6E7RU0w-1
X-Mimecast-MFC-AGG-ID: Y50mUOKINse3lHA6E7RU0w_1772546463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 642861956053; Tue,  3 Mar 2026 14:01:03 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55A0530001BF; Tue,  3 Mar 2026 14:01:01 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, philmd@linaro.org, kraxel@redhat.com,
 thuth@redhat.com
Subject: [PATCH 17/16] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Date: Tue,  3 Mar 2026 15:00:58 +0100
Message-ID: <20260303140058.2423099-1-imammedo@redhat.com>
In-Reply-To: <20260225092024.794595-1-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v2:
   - do not check for SMI features if hotplug happens when
     SMI is not enabled. (matters for qtest and possibly seabios)
   - removing property also removes default ICH9_LPC_SMI_F_BROADCAST_BIT
     put default back in place only set it initfn() instead

The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
in the pc_compat_2_8[] array, via the 'x-smi-broadcast=off'
property. We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ich9.c    |  4 ++--
 hw/isa/lpc_ich9.c | 23 ++++-------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

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
index 51dc680029..04169ffa24 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -404,15 +404,6 @@ static void smi_features_ok_callback(void *opaque)
     guest_cpu_hotplug_features = guest_features &
                                  (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
                                   BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT));
-    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
-        guest_cpu_hotplug_features) {
-        /*
-         * cpu hot-[un]plug with SMI requires SMI broadcast,
-         * leave @features_ok at zero
-         */
-        return;
-    }
-
     if (guest_cpu_hotplug_features ==
         BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT)) {
         /* cpu hot-unplug is unsupported without cpu-hotplug */
@@ -474,14 +465,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
 
     /* SMI_EN = PMBASE + 30. SMI control and enable register */
     if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
-        if (lpc->smi_negotiated_features &
-            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
-            CPUState *cs;
-            CPU_FOREACH(cs) {
-                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
-            }
-        } else {
-            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
+        CPUState *cs;
+        CPU_FOREACH(cs) {
+            cpu_interrupt(cs, CPU_INTERRUPT_SMI);
         }
     }
 }
@@ -685,6 +671,7 @@ static void ich9_lpc_initfn(Object *obj)
 
     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+    lpc->smi_host_features = BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT);
 
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
@@ -834,8 +821,6 @@ static const Property ich9_lpc_properties[] = {
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


