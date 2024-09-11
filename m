Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57216EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOlE-00043C-Kg; Wed, 11 Sep 2024 10:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhn-0007L8-U0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhk-0007EZ-4b
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=21NUaZFIhKQyua/2/GS7TeIRDshB3RMyrgRirFWhK1A=;
 b=AbnWMPuLXPFNq6bNiaEZ2hIAf026U5DtimHGNHQ2YTZNIS/ADur7WbGQyH7RB3SsVCK9Vo
 17OpJGyKensvSgFlRDVYVA5njXBKc/avh4/dMU8NPqm6S2XD9BJar8IX3s4D0WB+bDckup
 /jUxUWda9QwBSEfC3Gbh0MnqjXaDIe0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-oxgrtz_VOhSIef3AGv6bXg-1; Wed, 11 Sep 2024 09:52:04 -0400
X-MC-Unique: oxgrtz_VOhSIef3AGv6bXg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c960ee7aso4965221f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062722; x=1726667522;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21NUaZFIhKQyua/2/GS7TeIRDshB3RMyrgRirFWhK1A=;
 b=Ir7FvGQvDvLpQEa478T4thqzNbmTr9zrUK9p0ybPJIC40ytDA6bIUHBMHpfGOQregM
 Yu8JLjy0ykarwD0oNJi4dtqHZrghg70XNhdNAEDUu+pdmQYDIare4L7gFBeJ1xka5KCx
 E0ncf8S83xaJzkv0V1oO+v1pRd2tUqyHlC10gif5az00QJRYDa71apPhQqjWTBkW8NvV
 ozd0E0EgKodvN/jALr2mpELKZ3RKEhhho3BlMePWIqRQInM/lLEqUNaPgbtTQ681keS9
 DJ4pUNBltsblJ9yXl3DRhT8oamjCT7wqkb4OspAQqFdS15rg8Jgovl2AO/3BS67fvK1e
 bNEw==
X-Gm-Message-State: AOJu0YxXFBsJkZq98bVhcwtdxn7phtqDh93VBXjCCXNXpc37wvl9GTY+
 7kvw87v1acIbuIw4pdW6j5NVdI/AQLZWS/oM6tvPEv1Fr3pf2oeQoT6oL+MVtVdmvJzTo4uiI9m
 dgtjmFVatP4NuocTDva85jPnuQ049Vs/6HNH30wJmIu40DC9pTtSJDo5YuZsMuFhur0I8kO80Ok
 tHadHI0EE6PhRHB0OcXDIQ3pxT/y80kQ==
X-Received: by 2002:adf:fa0e:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-378922b76a7mr11326639f8f.32.1726062722297; 
 Wed, 11 Sep 2024 06:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgJ9pcGrlZ32rWOY4HYbjerStdbxUQoPUG/5a/myHUXn/GwQj1W6gKLd0zWa/Et38nB572FA==
X-Received: by 2002:adf:fa0e:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-378922b76a7mr11326597f8f.32.1726062721645; 
 Wed, 11 Sep 2024 06:52:01 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b85bsm613363966b.77.2024.09.11.06.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:00 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/18] hw/i386/acpi-build: Return a pre-computed _PRT table
Message-ID: <99cb2c6c7b3674359c61a40fb17a75516b8e159d.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ricardo Ribalda <ribalda@chromium.org>

When qemu runs without kvm acceleration the ACPI executions take a great
amount of time. If they take more than the default time (30sec), the
ACPI calls fail and the system might not behave correctly.

Now the _PRT table is computed on the fly. We can drastically reduce the
execution of the _PRT method if we return a pre-computed table.

Without this patch:
[   51.343484] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[   51.527032] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[   51.530049] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
[   51.530797] virtio-pci 0000:00:02.0: PCI INT A: no GSI
[   81.922901] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[   82.103534] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[   82.106088] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
[   82.106761] virtio-pci 0000:00:04.0: PCI INT A: no GSI
[  112.192568] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[  112.486687] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[  112.489554] virtio-pci 0000:00:05.0: can't derive routing for PCI INT A
[  112.490027] virtio-pci 0000:00:05.0: PCI INT A: no GSI
[  142.559448] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[  142.718596] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[  142.722889] virtio-pci 0000:00:06.0: can't derive routing for PCI INT A
[  142.724578] virtio-pci 0000:00:06.0: PCI INT A: no GSI

With this patch:
[   22.938076] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   24.214002] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[   25.465170] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[   27.944920] ACPI: \_SB_.LNKC: Enabled at IRQ 11

ACPI disassembly:
        Scope (PCI0)
        {
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                Return (Package (0x80)
                {
                    Package (0x04)
                    {
                        0xFFFF,
                        Zero,
                        LNKD,
                        Zero
                    },

                    Package (0x04)
                    {
                        0xFFFF,
                        One,
                        LNKA,
                        Zero
                    },

                    Package (0x04)
                    {
                        0xFFFF,
                        0x02,
                        LNKB,
                        Zero
                    },

                    Package (0x04)
                    {
                        0xFFFF,
                        0x03,
                        LNKC,
                        Zero
                    },

                    Package (0x04)
                    {
                        0x0001FFFF,
                        Zero,
                        LNKS,
                        Zero
                    },
Context: https://lore.kernel.org/virtualization/20240417145544.38d7b482@imammedo.users.ipa.redhat.com/T/#t

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240814115736.1580337-3-ribalda@chromium.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 118 ++++++++-----------------------------------
 1 file changed, 21 insertions(+), 97 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5d4bd2b710..4967aa7459 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -724,120 +724,44 @@ static Aml *aml_pci_pdsm(void)
     return method;
 }
 
-/**
- * build_prt_entry:
- * @link_name: link name for PCI route entry
- *
- * build AML package containing a PCI route entry for @link_name
- */
-static Aml *build_prt_entry(const char *link_name)
-{
-    Aml *a_zero = aml_int(0);
-    Aml *pkg = aml_package(4);
-    aml_append(pkg, a_zero);
-    aml_append(pkg, a_zero);
-    aml_append(pkg, aml_name("%s", link_name));
-    aml_append(pkg, a_zero);
-    return pkg;
-}
-
 /*
- * initialize_route - Initialize the interrupt routing rule
- * through a specific LINK:
- *  if (lnk_idx == idx)
- *      route using link 'link_name'
- */
-static Aml *initialize_route(Aml *route, const char *link_name,
-                             Aml *lnk_idx, int idx)
-{
-    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
-    Aml *pkg = build_prt_entry(link_name);
-
-    aml_append(if_ctx, aml_store(pkg, route));
-
-    return if_ctx;
-}
-
-/*
- * build_prt - Define interrupt rounting rules
+ * build_prt - Define interrupt routing rules
  *
  * Returns an array of 128 routes, one for each device,
  * based on device location.
  * The main goal is to equally distribute the interrupts
  * over the 4 existing ACPI links (works only for i440fx).
- * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
+ * The hash function is: (slot + pin) & 3 -> "LNK[D|A|B|C]".
  *
  */
 static Aml *build_prt(bool is_pci0_prt)
 {
-    Aml *method, *while_ctx, *pin, *res;
+    const int nroutes = 128;
+    Aml *rt_pkg, *method;
+    int pin;
 
     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    res = aml_local(0);
-    pin = aml_local(1);
-    aml_append(method, aml_store(aml_package(128), res));
-    aml_append(method, aml_store(aml_int(0), pin));
+    rt_pkg = aml_varpackage(nroutes);
 
-    /* while (pin < 128) */
-    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
-    {
-        Aml *slot = aml_local(2);
-        Aml *lnk_idx = aml_local(3);
-        Aml *route = aml_local(4);
+    for (pin = 0; pin < nroutes; pin++) {
+        Aml *pkg = aml_package(4);
+        int slot = pin >> 2;
 
-        /* slot = pin >> 2 */
-        aml_append(while_ctx,
-                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
-        /* lnk_idx = (slot + pin) & 3 */
-        aml_append(while_ctx,
-            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
-                      lnk_idx));
-
-        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
-        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
-        if (is_pci0_prt) {
-            Aml *if_device_1, *if_pin_4, *else_pin_4;
-
-            /* device 1 is the power-management device, needs SCI */
-            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
-            {
-                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
-                {
-                    aml_append(if_pin_4,
-                        aml_store(build_prt_entry("LNKS"), route));
-                }
-                aml_append(if_device_1, if_pin_4);
-                else_pin_4 = aml_else();
-                {
-                    aml_append(else_pin_4,
-                        aml_store(build_prt_entry("LNKA"), route));
-                }
-                aml_append(if_device_1, else_pin_4);
-            }
-            aml_append(while_ctx, if_device_1);
+        aml_append(pkg, aml_int((slot << 16) | 0xFFFF));
+        aml_append(pkg, aml_int(pin & 3));
+        /* device 1 is the power-management device, needs SCI */
+        if (is_pci0_prt && pin == 4) {
+            aml_append(pkg, aml_name("%s", "LNKS"));
         } else {
-            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
+            static const char link_name[][5] = {"LNKD", "LNKA", "LNKB", "LNKC"};
+            int hash = (slot + pin) & 3;
+            aml_append(pkg, aml_name("%s", link_name[hash]));
         }
-        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
-        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
-
-        /* route[0] = 0x[slot]FFFF */
-        aml_append(while_ctx,
-            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
-                             NULL),
-                      aml_index(route, aml_int(0))));
-        /* route[1] = pin & 3 */
-        aml_append(while_ctx,
-            aml_store(aml_and(pin, aml_int(3), NULL),
-                      aml_index(route, aml_int(1))));
-        /* res[pin] = route */
-        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
-        /* pin++ */
-        aml_append(while_ctx, aml_increment(pin));
+        aml_append(pkg, aml_int(0));
+        aml_append(rt_pkg, pkg);
     }
-    aml_append(method, while_ctx);
-    /* return res*/
-    aml_append(method, aml_return(res));
+
+    aml_append(method, aml_return(rt_pkg));
 
     return method;
 }
-- 
MST


