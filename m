Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1D7C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb64-00014K-UZ; Thu, 01 May 2025 17:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb63-00013G-Gc
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:31 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb61-0006VR-MQ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:05:31 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d8fc9dbce4so9431785ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133528; x=1746738328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5ZMEn7NCnklWa+DQm3mEiEs22N/Anfjag2M9l8eBgM=;
 b=gDP/Cp1+nSdU3DlP3mtW04nBm9J4WCQR7XHpqtmvYc5tTDHZI7BK/quNDH21I8kqs2
 5T8oU+FuAgDSzl4LMOusSq2FX9fUgTsfeFGc7CpuoROSVffwN+oMwgvvw3QtkFKWkNZo
 0fkcG8Fp6bsy1AxIwmjCYPW0NLDHaNuOzJKABDYKWGO7EhHN6sbCDoa23cVU1KT6cWbo
 ELRjMZ9+jztJ+Ho9rK2W5RblCQ0/WkgNPZS6u86GKBYzDG+SUSuRN6GBYdkT8lVKUAZj
 baxfujiuOJf768bpVVD53n7NrAUGnbOjWBwiBpzXLsyA2GPJw/OunX/2xMRCwTIFqpao
 3oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133528; x=1746738328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5ZMEn7NCnklWa+DQm3mEiEs22N/Anfjag2M9l8eBgM=;
 b=BrKbnc9bjYq7M/qvO2lVLh9jYMuC05r9wHYT9+n7VxtgIPuc+kNB6677KJr85Q9O/O
 v6rWRz7zrA6J9BfhkIKqJ3mlfpa3qnna456AZqb+w4plavrPtQicrdy9dD9xqBfF/mF1
 wV4p53g4DATG9FIxsSQxkH63LxB4koV4OQ5WnECCPE2jmFA+rXWDvDUzaJEB0NljiKVp
 o8we41W4VVO8/bwKsMBjsLZMKRHxlj0FiVNsGfBFHhWPVKyA/V3uFuRGdnIuxvk8XEVH
 BVNMfe+hFEA+8AS1jSnbWqiIhy2b/Pdp4pPHtYhH7rxZH2LhalGSj/7ITDif3NL2g0w8
 hxsw==
X-Gm-Message-State: AOJu0YxGdA1VOUV2WXoD98J9TyFEARCfF3p8DpFjWJMLn5nwJHoYtgQu
 P33aPWZX+WL2WPbod65Onqhj/NvamzoHZJnB/yqgQYib/TLfc+hOpG52VYBfA3id7/CAPJFgpIh
 N
X-Gm-Gg: ASbGncv6nXe5dRR2r/+iTzok8pnkkOrOd2jiZqlWsPhS5fQ1Mykkp929vfDGmhAKcpk
 e5YwUJMIMX0q+HeJZann1ds8AV783TKdL8CHIlkfMjxViV9/TbrEw0JK8tRVv01EfxhaFlj8Ano
 +tsbdxt0e0J8cL11D8+hm2Y8NqQWL32Cp79zV5UYRiHDOnYvGmvrTX5ohtw4o1t47QRCNPTCF2v
 cut21RTT6hm2pPah569xvbbJQ3nd4PWucSqT+irDoQ7OANGFUQTBdF+BA24zMacmS+p209MpXw3
 y7weX157UqrfHqHYDeSPsWkLBkhacgZdW/ssXz/DbOMTJSm/amOdO+/9VnkD4KqZebUEqbDV24t
 +HzQsIwebtCup1cCEOtEAB44ebg==
X-Google-Smtp-Source: AGHT+IH9Rd922q2evnATmm7DN8w668qOn8IOr/ofQzAcWAN0RAGZzume8oqgTvNKsM/uRjmXO/wzFg==
X-Received: by 2002:a05:6e02:3e8d:b0:3d9:3675:f531 with SMTP id
 e9e14a558f8ab-3d97ae710cbmr8096145ab.6.1746133528213; 
 Thu, 01 May 2025 14:05:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e27d71sm3033745ab.10.2025.05.01.14.05.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:05:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 03/18] hw/southbridge/ich9: Remove
 ICH9_LPC_SMI_F_BROADCAST_BIT definition
Date: Thu,  1 May 2025 23:04:41 +0200
Message-ID: <20250501210456.89071-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The ICH9_LPC_SMI_F_BROADCAST_BIT feature bit was only set
in the pc_compat_2_8[] array, via the 'x-smi-broadcast=off'
property. We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h |  1 -
 hw/acpi/ich9.c                |  6 ++----
 hw/isa/lpc_ich9.c             | 22 +++-------------------
 3 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 1e231e89c92..4764c03ac2d 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -244,7 +244,6 @@ struct ICH9LPCState {
 #define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
 
 /* bit positions used in fw_cfg SMI feature negotiation */
-#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
 #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
 #define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c7a735bf642..40564605735 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -477,8 +477,7 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
-        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
-            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
+        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
             error_setg(errp, "cpu hotplug with SMI wasn't enabled by firmware");
             error_append_hint(errp, "update machine type to newer than 5.1 "
                 "and firmware that suppors CPU hotplug with SMM");
@@ -526,8 +525,7 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                !lpc->pm.cpu_hotplug_legacy) {
         uint64_t negotiated = lpc->smi_negotiated_features;
 
-        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
-            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
+        if (!(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
             error_setg(errp, "cpu hot-unplug with SMI wasn't enabled "
                              "by firmware");
             error_append_hint(errp, "update machine type to a version having "
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 71afb45b631..c57a06e0dde 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -400,15 +400,6 @@ static void smi_features_ok_callback(void *opaque)
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
@@ -470,14 +461,9 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
 
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
@@ -830,8 +816,6 @@ static const Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
-    DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
-                      ICH9_LPC_SMI_F_BROADCAST_BIT, true),
     DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
     DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
-- 
2.47.1


