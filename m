Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F82C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAad-0006Al-DC; Tue, 12 Mar 2024 18:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaK-00059Z-T9
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaI-0004Kh-67
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fbl/4oY5S27H5N4x4Mfso73+4TVfz4B6Urk0mgRqeEc=;
 b=Y6pVXa07AWElXBenVKGKiOliTNFTBFw2TLZ53vhiLxKFP9k4UEK/3wvOUfJZVoDoGpfyDU
 gIRk1vjRKOjAy5vYymsV2lX1yvdSHWRpNtLE9dyWOE6BS3RZIds5e/UIQHnXI4PUEQwqXz
 Q1IWrq0O/JXa+rOLYOD12GQn6WxXWMY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-_SUAqW6sN0i1_1h1pn4w_Q-1; Tue, 12 Mar 2024 18:26:56 -0400
X-MC-Unique: _SUAqW6sN0i1_1h1pn4w_Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4606018ec4so29755966b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282414; x=1710887214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbl/4oY5S27H5N4x4Mfso73+4TVfz4B6Urk0mgRqeEc=;
 b=CNWxmjBvPinn3GIYB9HZTML/dk06XTB2st9jqP4IHLzgGsdWTrbWqELP2k0Zaz7F+9
 pvWUJ9iBqIoIAoDX2uDwZh3lOgDtre6htQYwypMbVar315Jwmi2iM7yzop3PkIolKYtb
 VRjZ/JGCj9Sia3Pij0iZrDuVcsGd9nBbsWRLLI2ShQUP7caPfNwYe7gJ4eM9+bnN+UTv
 EODjnEIOKi1YsEC7BEBmdxuLCiNOC7pUd2VfUr1dXh1KFqmEoO59LMtvfQ6e9+EDkOkK
 rBXwZTwqttCMC75rui6nrGdoI3Xw5ntOoEFeSY88Ugtl1qTcJ81TvmBvy9Oo2xreK8rb
 fn1A==
X-Gm-Message-State: AOJu0YxgXbScLPuZ4NqnEeZcz9ljAZ2N0gprRw4AR9FEsn88mhwQdRgf
 1j0sqZCn2frpNJslo8ThEEJdefygHCZgVYiEe6hekRNzNrM7mqWw5tuXz9L9ucVR+1UJkLfLOmx
 itEEIQvb2do/OaigTp/FHxiIsGe8rHuzjA74rSzf4aj2v16S+2EopIq5ZsUISKCTVMVH+UKOqx4
 jY+xuLpdJr1Rt2ThmrF8kA3p8PsRDjIUsI
X-Received: by 2002:a17:906:ba84:b0:a46:13a0:2e5c with SMTP id
 cu4-20020a170906ba8400b00a4613a02e5cmr797812ejd.25.1710282414408; 
 Tue, 12 Mar 2024 15:26:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkM5wjMUTJem7bMnk1rIh4+fw7093GCMqaUGBLDBhtf+NP1nzXwtGQofoGY2DEKFZAUu4pVg==
X-Received: by 2002:a17:906:ba84:b0:a46:13a0:2e5c with SMTP id
 cu4-20020a170906ba8400b00a4613a02e5cmr797775ejd.25.1710282413823; 
 Tue, 12 Mar 2024 15:26:53 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 x6-20020a1709065ac600b00a465ad6e994sm6687ejs.152.2024.03.12.15.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:53 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lukas Stockner <lstockner@genesiscloud.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 26/68] pcie: Support PCIe Gen5/Gen6 link speeds
Message-ID: <c08da86dc412cd44039bc78df02227578bc06268.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Lukas Stockner <lstockner@genesiscloud.com>

This patch extends the PCIe link speed option so that slots can be
configured as supporting 32GT/s (Gen5) or 64GT/s (Gen5) speeds.
This is as simple as setting the appropriate bit in LnkCap2 and
the appropriate value in LnkCap and LnkCtl2.

Signed-off-by: Lukas Stockner <lstockner@genesiscloud.com>
Message-Id: <20240215012326.3272366-1-lstockner@genesiscloud.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/common.json                 |  6 +++++-
 include/hw/pci/pcie_regs.h       |  2 ++
 hw/core/qdev-properties-system.c | 16 ++++++++++++++--
 hw/pci/pcie.c                    |  8 ++++++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index f1bb841951..867a9ad9b0 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -107,10 +107,14 @@
 #
 # @16: 16.0GT/s
 #
+# @32: 32.0GT/s
+#
+# @64: 64.0GT/s
+#
 # Since: 4.0
 ##
 { 'enum': 'PCIELinkSpeed',
-  'data': [ '2_5', '5', '8', '16' ] }
+  'data': [ '2_5', '5', '8', '16', '32', '64' ] }
 
 ##
 # @PCIELinkWidth:
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 4972106c42..9d3b6868dc 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -39,6 +39,8 @@ typedef enum PCIExpLinkSpeed {
     QEMU_PCI_EXP_LNK_5GT,
     QEMU_PCI_EXP_LNK_8GT,
     QEMU_PCI_EXP_LNK_16GT,
+    QEMU_PCI_EXP_LNK_32GT,
+    QEMU_PCI_EXP_LNK_64GT,
 } PCIExpLinkSpeed;
 
 #define QEMU_PCI_EXP_LNKCAP_MLS(speed)  (speed)
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b45e90edb2..28ce6162c7 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -955,7 +955,7 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
-/* --- PCIELinkSpeed 2_5/5/8/16 -- */
+/* --- PCIELinkSpeed 2_5/5/8/16/32/64 -- */
 
 static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
@@ -977,6 +977,12 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     case QEMU_PCI_EXP_LNK_16GT:
         speed = PCIE_LINK_SPEED_16;
         break;
+    case QEMU_PCI_EXP_LNK_32GT:
+        speed = PCIE_LINK_SPEED_32;
+        break;
+    case QEMU_PCI_EXP_LNK_64GT:
+        speed = PCIE_LINK_SPEED_64;
+        break;
     default:
         /* Unreachable */
         abort();
@@ -1010,6 +1016,12 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     case PCIE_LINK_SPEED_16:
         *p = QEMU_PCI_EXP_LNK_16GT;
         break;
+    case PCIE_LINK_SPEED_32:
+        *p = QEMU_PCI_EXP_LNK_32GT;
+        break;
+    case PCIE_LINK_SPEED_64:
+        *p = QEMU_PCI_EXP_LNK_64GT;
+        break;
     default:
         /* Unreachable */
         abort();
@@ -1018,7 +1030,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 
 const PropertyInfo qdev_prop_pcie_link_speed = {
     .name = "PCIELinkSpeed",
-    .description = "2_5/5/8/16",
+    .description = "2_5/5/8/16/32/64",
     .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..0b4817e144 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -153,6 +153,14 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
             pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
                                        PCI_EXP_LNKCAP2_SLS_16_0GB);
         }
+        if (s->speed > QEMU_PCI_EXP_LNK_16GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_32_0GB);
+        }
+        if (s->speed > QEMU_PCI_EXP_LNK_32GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_64_0GB);
+        }
     }
 }
 
-- 
MST


