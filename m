Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CAEC83F21
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIo-0004b9-3x; Mon, 14 Jul 2025 19:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIB-0002RT-Cy
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSI9-0005nc-Gx
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wLsKPagMrSSZ7Gtre3WseVjTbI6weoA/9UfazL/iDaA=;
 b=Ti5jXVrKcHJBL3uDbWfOcAuTHRl2YD32RFQBxB63KUA5+kTCHWGXte0s6aXjh3K9n5SieC
 PffirW7IJcmmOUxZu+W4WS9xjjFXpErv4dOuijRHuoDOrZJpOCCmIeVZ6oqFgFNjnyVvQj
 uxWN5MxsPlbzjpiImrEmP/tQnmZ+kys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-tNNn0RtFNpitIIh7k1ho0g-1; Mon, 14 Jul 2025 19:08:59 -0400
X-MC-Unique: tNNn0RtFNpitIIh7k1ho0g-1
X-Mimecast-MFC-AGG-ID: tNNn0RtFNpitIIh7k1ho0g_1752534538
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso2323773f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534538; x=1753139338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLsKPagMrSSZ7Gtre3WseVjTbI6weoA/9UfazL/iDaA=;
 b=X5FyYnasFMo+cJseTF0aGjd/LBaODfrIPvHD0OP9Z8/aqcVn5gX70j7XckJ/bABu8+
 1t/c3hu5beXPVO49uGbNUA1z7whbw1YYSrCtOSTDskT3t0mXEgAKDRj0p3itvdpJdunZ
 eCtrU1n6jOrvTbyPsV9cUK3jFcTMlYFU8lUXisst47WRlJx3ZsaOk/i0J6tGxbcJiBDI
 Awonc41yrJmyn+qsuGaKpA3jzPefp8pH3MAqODTTCe5MMUysV1ynHJcwa0tRiPIZRgWI
 +q0SHP5eNOtt/jPHZU/Nptc/ZHf197MR8Mr+gsubSvmpIICJXnBjxHT79hFPGugjLZr8
 L+pw==
X-Gm-Message-State: AOJu0YwCBHttS2hiBvGl7HFFwGjDw7OidJ2fxngmXXAI76Ty1Ui3lNXR
 AlpQrXe+7WQJgqyI62/k0u9hg3J+//yUdYYyKPVzN2r1uqbf3/g+YawB8vzxCZBkyvHybi/kxPK
 PsS6bmp2newTZJujukskOx+cuHaAPRlUwvFMMYS1qAkTO0hujNL0acNDevXz9y3LFOi37jSGYCS
 3nZ7xRSaIbPbky/WplqSCNaRi63Lf7+L8c2Q==
X-Gm-Gg: ASbGncscMCDTm1Z3883Av/pLlWxe/gV5LrXS2gYJgVWfBmRxSsqCwe75Zw5Tn4N6zAu
 k7he3AKzsyJ5eGR3IBgC9tzOWB/Gy+xzaV5exoxV0mM7YQU6OIQAei2egKmi6VXLCwiFiRq7o4l
 ztwfoZMkKyCO5ocZWszXxXtGwO2QxwwGMlNmKC98P9NGhKfuiSLFFXB82TbewI1sOmjJwFHm5/+
 mbbt0m9FwnMMIJvRKcgUswlMtf4MKe9Q2HuZclpoHZ79weZ5Zq/Gdb522vq7XX2Kn2BZD6WU9Hd
 bV/oa97ThY0x39RCV27mFh7M4AWxE499
X-Received: by 2002:a05:6000:290b:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b5f359d08dmr10954228f8f.59.1752534538108; 
 Mon, 14 Jul 2025 16:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHKYf9TfWNzQ38nWLMICaaq3N5Ev1KPs2u1gk9NTXmbaUObqSLZdBsF0lwPSGkenEO6y/srg==
X-Received: by 2002:a05:6000:290b:b0:3b3:9c75:acc6 with SMTP id
 ffacd0b85a97d-3b5f359d08dmr10954205f8f.59.1752534537594; 
 Mon, 14 Jul 2025 16:08:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560538da14sm87693425e9.23.2025.07.14.16.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:08:56 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:08:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 62/97] hw/i386/acpi-build: Move aml_pci_edsm to a generic place
Message-ID: <7b96127b8213b9222074aa7eb9f03f6ad3e46e80.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Move aml_pci_edsm to pci-bridge.c since we want to reuse that for
ARM and acpi-index support. Also rename it into build_pci_bridge_edsm.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-17-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/pci.h |  1 +
 hw/acpi/pci-bridge.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  | 57 ++-----------------------------------------
 3 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 69bae95eac..20b672575f 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -42,5 +42,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 void build_srat_generic_affinity_structures(GArray *table_data);
 
 Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
+Aml *build_pci_bridge_edsm(void);
 
 #endif
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 7baa7034a1..394a919479 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -35,3 +35,57 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
         }
     }
 }
+
+Aml *build_pci_bridge_edsm(void)
+{
+    Aml *method, *ifctx;
+    Aml *zero = aml_int(0);
+    Aml *func = aml_arg(2);
+    Aml *ret = aml_local(0);
+    Aml *aidx = aml_local(1);
+    Aml *params = aml_arg(4);
+
+    method = aml_method("EDSM", 5, AML_SERIALIZED);
+
+    /* get supported functions */
+    ifctx = aml_if(aml_equal(func, zero));
+    {
+        /* 1: have supported functions */
+        /* 7: support for function 7 */
+        const uint8_t caps = 1 | BIT(7);
+        build_append_pci_dsm_func0_common(ifctx, ret);
+        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
+        aml_append(ifctx, aml_return(ret));
+    }
+    aml_append(method, ifctx);
+
+    /* handle specific functions requests */
+    /*
+     * PCI Firmware Specification 3.1
+     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
+     *        Operating Systems
+     */
+    ifctx = aml_if(aml_equal(func, aml_int(7)));
+    {
+       Aml *pkg = aml_package(2);
+       aml_append(pkg, zero);
+       /* optional, if not impl. should return null string */
+       aml_append(pkg, aml_string("%s", ""));
+       aml_append(ifctx, aml_store(pkg, ret));
+
+       /*
+        * IASL is fine when initializing Package with computational data,
+        * however it makes guest unhappy /it fails to process such AML/.
+        * So use runtime assignment to set acpi-index after initializer
+        * to make OSPM happy.
+        */
+       aml_append(ifctx,
+           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
+       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
+       aml_append(ifctx, aml_return(ret));
+    }
+    aml_append(method, ifctx);
+
+    return method;
+}
+
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fe8bc62c03..423c4959fe 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -338,59 +338,6 @@ build_facs(GArray *table_data)
     g_array_append_vals(table_data, reserved, 40); /* Reserved */
 }
 
-static Aml *aml_pci_edsm(void)
-{
-    Aml *method, *ifctx;
-    Aml *zero = aml_int(0);
-    Aml *func = aml_arg(2);
-    Aml *ret = aml_local(0);
-    Aml *aidx = aml_local(1);
-    Aml *params = aml_arg(4);
-
-    method = aml_method("EDSM", 5, AML_SERIALIZED);
-
-    /* get supported functions */
-    ifctx = aml_if(aml_equal(func, zero));
-    {
-        /* 1: have supported functions */
-        /* 7: support for function 7 */
-        const uint8_t caps = 1 | BIT(7);
-        build_append_pci_dsm_func0_common(ifctx, ret);
-        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
-        aml_append(ifctx, aml_return(ret));
-    }
-    aml_append(method, ifctx);
-
-    /* handle specific functions requests */
-    /*
-     * PCI Firmware Specification 3.1
-     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
-     *        Operating Systems
-     */
-    ifctx = aml_if(aml_equal(func, aml_int(7)));
-    {
-       Aml *pkg = aml_package(2);
-       aml_append(pkg, zero);
-       /* optional, if not impl. should return null string */
-       aml_append(pkg, aml_string("%s", ""));
-       aml_append(ifctx, aml_store(pkg, ret));
-
-       /*
-        * IASL is fine when initializing Package with computational data,
-        * however it makes guest unhappy /it fails to process such AML/.
-        * So use runtime assignment to set acpi-index after initializer
-        * to make OSPM happy.
-        */
-       aml_append(ifctx,
-           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
-       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
-       aml_append(ifctx, aml_return(ret));
-    }
-    aml_append(method, ifctx);
-
-    return method;
-}
-
 /*
  * build_prt - Define interrupt routing rules
  *
@@ -937,7 +884,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
-        aml_append(dev, aml_pci_edsm());
+        aml_append(dev, build_pci_bridge_edsm());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -952,7 +899,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, build_pci_host_bridge_osc_method(!pm->pcihp_bridge_en));
-        aml_append(dev, aml_pci_edsm());
+        aml_append(dev, build_pci_bridge_edsm());
         aml_append(sb_scope, dev);
         if (mcfg_valid) {
             aml_append(sb_scope, build_q35_dram_controller(&mcfg));
-- 
MST


