Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFF8C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4K-0005ue-Ge; Fri, 21 Feb 2025 07:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4G-0005km-0J
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4D-00076L-DZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BVlPptZNlm2Qp+Na4geuSvUcMsY7gT+KX61fq3waWVU=;
 b=iQN5dSsY9XkSHBOoIMX7DGS6rBIE96Fd87ZPn4O4nyjcWJTYyglT3i8jaCN8ciC+3zxoyD
 9+PG0mbgNtTpT/7CRAgSxw/K9XJxSYO2licb7P5AdS9KNKryEI7B6m5u9fSiUzdb7ErVr9
 ey56NnBC9JHi7HOv3bwMuxc5+0i4a5Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-soFATn_pPxKQDYVnr7IeQA-1; Fri, 21 Feb 2025 07:23:39 -0500
X-MC-Unique: soFATn_pPxKQDYVnr7IeQA-1
X-Mimecast-MFC-AGG-ID: soFATn_pPxKQDYVnr7IeQA_1740140618
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f4bf0d5faso1190909f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140618; x=1740745418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVlPptZNlm2Qp+Na4geuSvUcMsY7gT+KX61fq3waWVU=;
 b=o2hSHjf02M7Cx5BS4ZuKoTKHEIu6GJWWomK2UySqSShJwp4Gpas/vTOszPfnak4c0R
 SntIafZODRFcXV87SvlIW1yiIojqt+s7a0v+VGNTqS93DiSTcMLqPXHuTVo/fbLSOZZU
 OejtLvGQNvOgUpQmRydccnxpRLxwRYrqRBdiLT3cJ+ABemQr8/rIFTj3+xwRI7yu9qQZ
 4rLjvwDNMmmATT/5DPXx5os7FLeXlxSNkRn9buyK+PhLOpJI9xYkokIktnkGjzKuhgWF
 +wM0ZjkoJ0yzW9V+LvcMHgPplgrN2FWadMkP4BHPM7bYZcgQOaCbEkwaWDuhy9e77aNB
 dt1Q==
X-Gm-Message-State: AOJu0YyqDLigGNzgVRJH2NTGjP3ptCOuNXJ4XkeIntNmTLO6nyjg6aGq
 PZC8qHiW2eKyt2FB+hOYTBSTSnAwXMMzfDzpd1nuQzOLegbqBD67By8tebQJicddGjcKMqnaRV9
 2sOowz64/RsuG1mCDkP7rQ8xc9is4KhJRbMRbdG99yLHN1AmDGPcKRgwCNRjM/QqZrSTJfa+nxp
 E4HwDQaiZ7tK4BK/esFDMpqUUgfaxvjQ==
X-Gm-Gg: ASbGncuX936TKGMJz3f+uxyALQ+33nNpdCziZXfLLw4EyfbL44Z6WFSjVvTe5eOZOUk
 HyFphORACrlui7Yp6gE/5rcf8KzYnYGkrUNf2mcQDbYIoUoefuwFA+2x8oB8fN35Vq3wsqZ/C1f
 RfiAGfa+FF9Wvz8R8sVbzXEYJqNpdCzEPdkzer4D/cYSWc73GGVTwULe1dSJDPyBBQHj4M+NqbL
 a+hKMv2YyUEJhq2Dh9vJKRMeQsdlxOn4XJqc9qB4ru7dMR78BOxRO58cm9NyFRMw4162j+6lDZi
 CtvZNw==
X-Received: by 2002:a05:6000:1f8f:b0:38f:452f:9fa9 with SMTP id
 ffacd0b85a97d-38f6e753bbamr2421668f8f.2.1740140617776; 
 Fri, 21 Feb 2025 04:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdqyGBgHa+Vk9exghcMJlYeGh7AIcRbWUs1CO90fDwyzVXwO0REgi1xmkmoUlfO7mzg18jwQ==
X-Received: by 2002:a05:6000:1f8f:b0:38f:452f:9fa9 with SMTP id
 ffacd0b85a97d-38f6e753bbamr2421643f8f.2.1740140617327; 
 Fri, 21 Feb 2025 04:23:37 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5e92sm23595672f8f.66.2025.02.21.04.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:36 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 18/41] hw/i386/microvm: Fix crash that occurs when
 introspecting the microvm machine
Message-ID: <38ef383073b8ee59d598643160f206a19a46237f.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when you try to inspect the properties of the
microvm machine:

 $ echo '{ "execute": "qmp_capabilities" }
         { "execute": "qom-list-properties","arguments":
           { "typename": "microvm-machine"}}' | \
   ./qemu-system-x86_64 -qmp stdio
 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
  "package": "v9.2.0-1072-g60af367187-dirty"}, "capabilities": ["oob"]}}
 {"return": {}}
 qemu-system-x86_64: ../qemu/hw/i386/acpi-microvm.c:250:
  void acpi_setup_microvm(MicrovmMachineState *):
   Assertion `x86ms->fw_cfg' failed.
 Aborted (core dumped)

This happens because the microvm machine adds a machine_done (and a
powerdown_req) notifier in their instance_init function - however, the
instance_init of machines are not only called for machines that are
realized, but also for machines that are introspected, so in this case
the listener is added for a microvm machine that is never realized. And
since there is already a running machine, the listener function is
triggered immediately, causing a crash since it was not for the right
machine it was meant for.

Such listener functions must never be installed from an instance_init
function. Let's do it from microvm_machine_state_init() instead - this
function is the MachineClass->init() function instead, i.e. guaranteed
to be only called once in the lifetime of a QEMU process.

Since the microvm_machine_done() and microvm_powerdown_req() were
defined quite late in the microvm.c file, we have to move them now
also earlier, so that we can get their function pointers from
microvm_machine_state_init() without having to introduce a separate
prototype for those functions earlier.

Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250123204708.1560305-1-thuth@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/microvm.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe..d0a236c74f 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -451,11 +451,44 @@ static HotplugHandler *microvm_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void microvm_machine_done(Notifier *notifier, void *data)
+{
+    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
+                                            machine_done);
+    X86MachineState *x86ms = X86_MACHINE(mms);
+
+    acpi_setup_microvm(mms);
+    dt_setup_microvm(mms);
+    fw_cfg_add_e820(x86ms->fw_cfg);
+}
+
+static void microvm_powerdown_req(Notifier *notifier, void *data)
+{
+    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
+                                            powerdown_req);
+    X86MachineState *x86ms = X86_MACHINE(mms);
+
+    if (x86ms->acpi_dev) {
+        Object *obj = OBJECT(x86ms->acpi_dev);
+        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
+        adevc->send_event(ACPI_DEVICE_IF(x86ms->acpi_dev),
+                          ACPI_POWER_DOWN_STATUS);
+    }
+}
+
 static void microvm_machine_state_init(MachineState *machine)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
 
+    /* State */
+    mms->kernel_cmdline_fixed = false;
+
+    mms->machine_done.notify = microvm_machine_done;
+    qemu_add_machine_init_done_notifier(&mms->machine_done);
+    mms->powerdown_req.notify = microvm_powerdown_req;
+    qemu_register_powerdown_notifier(&mms->powerdown_req);
+
     microvm_memory_init(mms);
 
     x86_cpus_init(x86ms, CPU_VERSION_LATEST);
@@ -581,31 +614,6 @@ static void microvm_machine_set_auto_kernel_cmdline(Object *obj, bool value,
     mms->auto_kernel_cmdline = value;
 }
 
-static void microvm_machine_done(Notifier *notifier, void *data)
-{
-    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
-                                            machine_done);
-    X86MachineState *x86ms = X86_MACHINE(mms);
-
-    acpi_setup_microvm(mms);
-    dt_setup_microvm(mms);
-    fw_cfg_add_e820(x86ms->fw_cfg);
-}
-
-static void microvm_powerdown_req(Notifier *notifier, void *data)
-{
-    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
-                                            powerdown_req);
-    X86MachineState *x86ms = X86_MACHINE(mms);
-
-    if (x86ms->acpi_dev) {
-        Object *obj = OBJECT(x86ms->acpi_dev);
-        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
-        adevc->send_event(ACPI_DEVICE_IF(x86ms->acpi_dev),
-                          ACPI_POWER_DOWN_STATUS);
-    }
-}
-
 static void microvm_machine_initfn(Object *obj)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
@@ -617,14 +625,6 @@ static void microvm_machine_initfn(Object *obj)
     mms->isa_serial = true;
     mms->option_roms = true;
     mms->auto_kernel_cmdline = true;
-
-    /* State */
-    mms->kernel_cmdline_fixed = false;
-
-    mms->machine_done.notify = microvm_machine_done;
-    qemu_add_machine_init_done_notifier(&mms->machine_done);
-    mms->powerdown_req.notify = microvm_powerdown_req;
-    qemu_register_powerdown_notifier(&mms->powerdown_req);
 }
 
 GlobalProperty microvm_properties[] = {
-- 
MST


