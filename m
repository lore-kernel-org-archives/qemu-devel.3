Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A3606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tlcQNz9H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXuM-0005bF-P9; Mon, 09 Nov 2026 17:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXu1-0005Hx-4W
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:50 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xQXty-0003x2-OV
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:31:48 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8b5efadd183so641140b3a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794263505; x=1794868305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2v6GFCmmyVopOT4+6X7oJautrva+0tDipmVQjAHAiYU=;
 b=tlcQNz9HcOm0MsbYZYj5kV0BD0VmQN4NhdmxOYppXdYtqCEOGZaVatxDIZovhOlx2Q
 sf5uCpt8CL8qPSlwL2MkS+9vexfdkvkbHY5JNxD6kIiDsLeW7faL7i6xybo0VYwZdAnT
 P6hBIy6lICZkvT7m9/41BePjw0usSuJ7IoFoHtPM6UJThpLZBq9InMUbu+7JKhOw6MIP
 EPrOwJNlLDi5hMzKV/QUPR/r6HRJ46CZS8S22sv4rCk0IsFVLQeiLkr8/JaWrtRCGd2r
 bvuklLcfwnRnngF4aQeBv/4koWrn+ZLqlIrpPuusK8WEeOhmyd0EE70UKdalobBGaYjd
 fMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794263505; x=1794868305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2v6GFCmmyVopOT4+6X7oJautrva+0tDipmVQjAHAiYU=;
 b=psaID9vjbANLGxD4/PWmydxRlP+x/tlu9DjyFRz4IzlSQpRMHnO1whwyORZ+4KbMDQ
 FK2Pjw8Q+4dO9esujlymiG4mDBr/FvxxQjIF7UdyILdDaDsMQb4qiDJ/EnoeECEyTRxK
 r/72jclBzy6kzVhsZejlhDPmI8xSr1ZgIIK7wOaDkFQ9qdFu467nKBgcEA8B8NAK91Qx
 01EHPurFFUqih9clqwpBZGoXvUGoRMVxgbtlyQVSVXURIG1cnr6cBuYsg95bYR+n1oVa
 HLMJqATnNWtNAch2vBWolAWhkDH5RiS9Qnj0+lQlZNYmH9ReGuGlrMtleKBP1keMteaO
 T5og==
X-Gm-Message-State: APuU4Z+BO3MWh+Ef4hHxwpocl9y9dr3jM5gIibEnboG2HW40Jtif1C+t
 fxlkVzsQRtOMrTZnr3v1NTUJjD0Uz9mpnuBwRU8p7OVTZjFTl+eQDG/ZtdDw+yIjA/A=
X-Gm-Gg: AYBFou1YDSYhTWPkRy2f7/u3eG3HKQ5O/j5LsAfX/YvXMYY/MyQ73m61GU9fXbiDjxQ
 T8CHp9YqEp6Dwf54H3HlVd6NuDRCKk5ydjUgTCLeoTNwqqxofgRJhWSfd89gjbu8o0bfZvQoBl/
 5VZkVMRSmyXlE1Pfhn9yz0LzUHQaNyZD4Tyhvo/Mtu9ILP3cTtxzm5xfaHcXKjmw8wweCT5QtTg
 Hf3BDQgBP+IJgHcGctXOie1As4ENgTwv18oN1+tMJPMy4WypUNYbg77/kg6VsAE7xIBrAL+qOme
 4TzUkXPOLFt6YxAT6sH7w0FLU2aTgu9c1EyBrjvDhQwhNysEsT6aNvuepUjzbQ8UIQxQYWjqw4p
 DvKNGBytWY4dzflY+rCZBv9wsFTxmmSCBLB17ZpsvQ4uqsKc26hK4PRUmRm7DgAkgZbxMt9TK91
 Ce+POjwNtgL0rS6v6gzBA2W5HaMusEuQH2UBX0G9eCss8dAraRk5bSGlesF41yhQz+EwcUcVfxT
 /mal4f5AQriLNCncPaDoO9H+pBXLkETBmc153SlCPnQYFWO4+JsdS1zP/WQs3tvmKsmMIl/S4I/
 b83kHCT2UtGfOujTrrAx9iu3nXOzbpTCAx3asoM5bdWDk3KDLpqV3T4=
X-Received: by 2002:a05:6a21:62c4:b0:3e1:4e53:4e7f with SMTP id
 adf61e73a8af0-3f18f4ac9aamr338799637.27.1794263504634; 
 Mon, 09 Nov 2026 14:31:44 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:31:44 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com, michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 17/23] hw/arm/virt: Disable DTB randomness for confidential
 VMs
Date: Mon,  9 Nov 2026 16:31:04 -0600
Message-ID: <20261109223110.1619504-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

The dtb-randomness feature, which adds random seeds to the DTB, isn't
really compatible with confidential VMs since it randomizes the Realm
Initial Measurement. Enabling it is not an error, but it prevents
attestation. It also isn't useful to a Realm, which doesn't trust host
input.

Currently the feature is automatically enabled, unless the user disables
it on the command-line. Change it to OnOffAuto, and automatically
disable it for confidential VMs, unless the user explicitly enables it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/arm/virt.rst |  9 +++++----
 hw/arm/virt.c            | 43 ++++++++++++++++++++++++++--------------
 include/hw/arm/virt.h    |  2 +-
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 5f6dd1797862..9882b842ddd5 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -238,10 +238,11 @@ dtb-randomness
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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9dd89f39a044..9d53ed4d51ca 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -410,6 +410,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
 
 static void create_fdt(VirtMachineState *vms)
 {
+    bool dtb_randomness = true;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->num_nodes;
     void *fdt = create_device_tree(&vms->fdt_size);
@@ -419,6 +420,16 @@ static void create_fdt(VirtMachineState *vms)
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
@@ -440,13 +451,13 @@ static void create_fdt(VirtMachineState *vms)
 
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
@@ -3523,18 +3534,21 @@ static void virt_set_virtio_transports(Object *obj, Visitor *v,
     vms->virtio_transports = transports;
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
@@ -4352,16 +4366,18 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set MSI settings. "
                                           "Valid values are auto, gicv2m, its and off");
 
-    object_class_property_add_bool(oc, "dtb-randomness",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-randomness", "OnOffAuto",
+                              &OnOffAuto_type_info,
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-randomness",
                                           "Set off to disable passing random or "
                                           "non-deterministic dtb nodes to guest");
 
-    object_class_property_add_bool(oc, "dtb-kaslr-seed",
-                                   virt_get_dtb_randomness,
-                                   virt_set_dtb_randomness);
+    object_class_property_add(oc, "dtb-kaslr-seed", "OnOffAuto",
+                              &OnOffAuto_type_info,
+                              virt_get_dtb_randomness, virt_set_dtb_randomness,
+                              NULL, NULL);
     object_class_property_set_description(oc, "dtb-kaslr-seed",
                                           "Deprecated synonym of dtb-randomness");
 
@@ -4424,9 +4440,6 @@ static void virt_instance_init(Object *obj)
     /* MTE is disabled by default.  */
     vms->mte = false;
 
-    /* Supply kaslr-seed and rng-seed by default */
-    vms->dtb_randomness = true;
-
     vms->irqmap = a15irqmap;
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 22e66d1a113c..d4c1aa04f664 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -176,7 +176,7 @@ struct VirtMachineState {
     bool virt;
     bool ras;
     bool mte;
-    bool dtb_randomness;
+    OnOffAuto dtb_randomness;
     bool second_ns_uart_present;
     OnOffAuto acpi;
     VirtGICType gic_version;
-- 
2.53.0


