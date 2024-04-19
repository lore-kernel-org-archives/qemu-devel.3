Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DECC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqfN-0001ir-KE; Fri, 19 Apr 2024 12:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeb-00017p-VX
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00016I-Ex
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso2009814f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542391; x=1714147191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLJn8Et2P7uvb72LPY76EBgdmCDOnIuXR/Ns31Lbr0Y=;
 b=Hfup9YMO7+EHrw3wBSpoXqVMcDHWa5lMbctw8WZIBNBeaCd+k5NKb+noX9xZAD8Afo
 WuaJVpsObQvm2hyhwNLEeV4ME2AsLJHKp2OTrtoy/CQllsti4R9UYTaG4Pkc4Ijx3e5V
 +9rSP5utRl1JYtf3vDftlXD/vna6CzG7U4yImI/kIqUt8VtWOHtH1ILbV4rRTQ6BAIsC
 Pc8tX+HKvmGWT/8Cz0nTzButfoIORwp0LmAqSlWb4/VPS/X9RsKRwo1IrOWptYkWchQA
 eUKjO+i3NjKfdVni9F5GRKlsmOIdgarFJPVJ06mRs1m/ylCjE2RSQTaO5XwL/2/qRfnQ
 A4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542391; x=1714147191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLJn8Et2P7uvb72LPY76EBgdmCDOnIuXR/Ns31Lbr0Y=;
 b=o/CkubqAS2zqaY5/g4lmFb8D6O66UIVIif+Mf+uax3C9MhWPfBU8iyZFYk33Ne25lX
 ZuOBVutwjfIEbEHIBvW87EUa4+8fjJr/tFHWNgW54ImwbpChdc9Dz9WRGNsCvvBGF06z
 J62SeKIc+kXCUBtS3USip9nsDfuQO8sDcPpGL6Efjjp80h6g/ly5yYdj/6yCAXmFQU6q
 GYoisrDZEC67Mn5LAmSuxnD3vDmJYfvOYW0J0rzvz2BoCrGbPzfG5s+gPB1+9MTjP0t+
 XzHRINo6Na5S0nHaXsbju+K129caBzhoIqFh0trvvU3sk5SQZFiXdvv+nTIlBSg7bqFv
 1L1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0fy1DHvRgCCiO/xMmkreeNFMq2G0/v5LkhYG3Y2Dsgb7B+IYGUjjvpgY3DozX6obY8XAaXeC2kDFcYVLEZI0NdenTLS4=
X-Gm-Message-State: AOJu0YzAcFJouDl1kASslLcKl/rwG7tIwNEoqeEZCvGYDA4Few5KSkm6
 0iO3qjDvpWhMfyI6rK7b1OTM4lOS1L9JkEH0oTT47qgzrA5jptS6tqJGHKGRWkQ=
X-Google-Smtp-Source: AGHT+IHt5SgdwAwTpK9LHFNiGk1VckoKu45Qk/h6ZktffMVSX/Qpn4+HcqAyA1R8ziHYvXM8oh/21A==
X-Received: by 2002:a05:6000:186b:b0:34a:4f1c:3269 with SMTP id
 d11-20020a056000186b00b0034a4f1c3269mr2602929wri.0.1713542390967; 
 Fri, 19 Apr 2024 08:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:50 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 06/22] hw/arm/virt: Disable DTB randomness for confidential
 VMs
Date: Fri, 19 Apr 2024 16:56:54 +0100
Message-ID: <20240419155709.318866-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
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

The dtb-randomness feature, which adds random seeds to the DTB, isn't
really compatible with confidential VMs since it randomizes the Realm
Initial Measurement. Enabling it is not an error, but it prevents
attestation. It also isn't useful to a Realm, which doesn't trust host
input.

Currently the feature is automatically enabled, unless the user disables
it on the command-line. Change it to OnOffAuto, and automatically
disable it for confidential VMs, unless the user explicitly enables it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: separate patch, use OnOffAuto
---
 docs/system/arm/virt.rst |  9 +++++----
 include/hw/arm/virt.h    |  2 +-
 hw/arm/virt.c            | 41 +++++++++++++++++++++++++---------------
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 26fcba00b7..e4bbfec662 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -172,10 +172,11 @@ dtb-randomness
   rng-seed and kaslr-seed nodes (in both "/chosen" and
   "/secure-chosen") to use for features like the random number
   generator and address space randomisation. The default is
-  ``on``. You will want to disable it if your trusted boot chain
-  will verify the DTB it is passed, since this option causes the
-  DTB to be non-deterministic. It would be the responsibility of
-  the firmware to come up with a seed and pass it on if it wants to.
+  ``off`` for confidential VMs, and ``on`` otherwise. You will want
+  to disable it if your trusted boot chain will verify the DTB it is
+  passed, since this option causes the DTB to be non-deterministic.
+  It would be the responsibility of the firmware to come up with a
+  seed and pass it on if it wants to.
 
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index bb486d36b1..90a148dac2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -150,7 +150,7 @@ struct VirtMachineState {
     bool virt;
     bool ras;
     bool mte;
-    bool dtb_randomness;
+    OnOffAuto dtb_randomness;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 07ad31876e..f300f100b5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -259,6 +259,7 @@ static bool ns_el2_virt_timer_present(void)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -268,6 +269,16 @@ static void create_fdt(VirtMachineState *vms)
         exit(1);
     }
 
+    /*
+     * Including random data in the DTB causes random intial measurement on CCA,
+     * so disable it for confidential VMs.
+     */
+    if (vms->dtb_randomness == ON_OFF_AUTO_OFF ||
+        (vms->dtb_randomness == ON_OFF_AUTO_AUTO &&
+         virt_machine_is_confidential(vms))) {
+        dtb_randomness = false;
+    }
+
     ms->fdt = fdt;
 
     /* Header */
@@ -278,13 +289,13 @@ static void create_fdt(VirtMachineState *vms)
 
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
-    if (vms->dtb_randomness) {
+    if (dtb_randomness) {
         create_randomness(ms, "/chosen");
     }
 
     if (vms->secure) {
         qemu_fdt_add_subnode(fdt, "/secure-chosen");
-        if (vms->dtb_randomness) {
+        if (dtb_randomness) {
             create_randomness(ms, "/secure-chosen");
         }
     }
@@ -2474,18 +2485,21 @@ static void virt_set_its(Object *obj, bool value, Error **errp)
     vms->its = value;
 }
 
-static bool virt_get_dtb_randomness(Object *obj, Error **errp)
+static void virt_get_dtb_randomness(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
+    OnOffAuto dtb_randomness = vms->dtb_randomness;
 
-    return vms->dtb_randomness;
+    visit_type_OnOffAuto(v, name, &dtb_randomness, errp);
 }
 
-static void virt_set_dtb_randomness(Object *obj, bool value, Error **errp)
+static void virt_set_dtb_randomness(Object *obj, Visitor *v, const char *name,
+                                    void *opaque, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    vms->dtb_randomness = value;
+    visit_type_OnOffAuto(v, name, &vms->dtb_randomness, errp);
 }
 
 static char *virt_get_oem_id(Object *obj, Error **errp)
@@ -3123,16 +3137,16 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable "
                                           "ITS instantiation");
 
-    object_class_property_add_bool(oc, "dtb-randomness",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-randomness", "OnOffAuto",
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-randomness",
                                           "Set off to disable passing random or "
                                           "non-deterministic dtb nodes to guest");
 
-    object_class_property_add_bool(oc, "dtb-kaslr-seed",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-kaslr-seed", "OnOffAuto",
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-kaslr-seed",
                                           "Deprecated synonym of dtb-randomness");
 
@@ -3203,9 +3217,6 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
-    /* Supply kaslr-seed and rng-seed by default */
-    vms->dtb_randomness = true;
-
     vms->irqmap = a15irqmap;
 
     virt_flash_create(vms);
-- 
2.44.0


