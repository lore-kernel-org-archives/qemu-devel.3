Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15417C27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6Yg-0001Re-Vf; Mon, 17 Jun 2024 03:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6YN-0000cz-La
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:25 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6YL-0002SN-Ag
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:13:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6f1f33486eso247197366b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608399; x=1719213199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYqx5B4mfJikAZAr9G9xjfKdU2jEXdXtppsYhpr3gkw=;
 b=pQQcsNOsIjRN8OaL6fGCPBOjdGMOy8UjEMy9ZGaTTFvIdgawC5BIAsdi+/Ho8JFpx3
 zg6l6aTaVgXad8CrB4jUvVw1oO0lxfmDTriu6fnMxrpMkYl+aq51PvT1ob2EzozZGPcF
 X3DpY2dup0SmpBmBHJDJyEvGWv+4148xTY1vb6gbC4c0ZU/rwTS0fFCudTAREmZ7xS2x
 tR9VyuNCTF3M1z+l6Bqb0wM5oejktZD+VKRXGq4K5LXrgyx89DKviBb36LwOV9fIIKsn
 VCTq9LJlaGJ9WVXxe31eJ5pjn0AynDjIHp8kkbYFdTRsQVz45zz4GtgUWcrS/rePo1Uz
 HsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608399; x=1719213199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYqx5B4mfJikAZAr9G9xjfKdU2jEXdXtppsYhpr3gkw=;
 b=Sh6+4E9ItPXgvbKqlguSn5j+qXoV/GI7CutwR7qOsAGd6ysFhso3dzx5KNjv5fjRoL
 WbSpGEb24T7fJydvzpkMGvSkc/9KjvMLa9MaYl10Y1+MKYSZNXG9ra9wPb0PeODSt/fF
 k9i5o2aPp+arTaPD9u3cTyD2pM8PYI7Nowt3u8Dc0BHCQIAZuIWnZmh9T4etk0OGTrJP
 SfHe6Hm6HZzKYtNudCuOp2h/LQVwazY1pDX/89R5765C/0VT05wJnRFk4ZlfInnH+ufJ
 aCqHOy9rFupdYLCzMGjLiILH50Mfz+yuXIiHamD+0m2MRGKshf0RMn77FWzy9WiAdr2j
 kPiQ==
X-Gm-Message-State: AOJu0Yw9Nu24o5y5QJQe7w9OqnaGmBXtqSjRGdDxfcDWivJOPPJg3qJp
 6LI/yBpZjqN8Y2bBdhHXZy9lsnrXHoL4oAGExRpwrRgYiftsBUWBM2yU5iSghyzAFo9Gbnowgu0
 D/YY=
X-Google-Smtp-Source: AGHT+IFjteYPsPWm9MIFQpzJ+obSUY8uwvdQXEvw0y+eErPp/gj2y8iI6cS729M7xSFjB3IOZNBQ3w==
X-Received: by 2002:aa7:d650:0:b0:57c:bdad:5ffe with SMTP id
 4fb4d7f45d1cf-57cbdad6030mr6975503a12.39.1718608399396; 
 Mon, 17 Jun 2024 00:13:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f41a7asm486153366b.159.2024.06.17.00.13.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:13:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 21/23] hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
Date: Mon, 17 Jun 2024 09:11:16 +0200
Message-ID: <20240617071118.60464-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Last commit removed the last non-NULL use of DEFINE_I440FX_MACHINE
3rd parameter. 'compatfn' is now obsolete, remove it.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_piix.c | 69 ++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 217c749705..e4930b7f48 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -414,13 +414,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-/* Looking for a pc_compat_2_4() function? It doesn't exist.
- * pc_compat_*() functions that run on machine-init time and
- * change global QEMU state are deprecated. Please don't create
- * one, and implement any pc-*-2.4 (and newer) compat code in
- * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
- */
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -452,13 +445,9 @@ static void pc_xen_hvm_init(MachineState *machine)
 }
 #endif
 
-#define DEFINE_I440FX_MACHINE(suffix, name, compatfn, optionfn) \
+#define DEFINE_I440FX_MACHINE(suffix, name, optionfn) \
     static void pc_init_##suffix(MachineState *machine) \
     { \
-        void (*compat)(MachineState *m) = (compatfn); \
-        if (compat) { \
-            compat(machine); \
-        } \
         pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
@@ -496,7 +485,7 @@ static void pc_i440fx_9_1_machine_options(MachineClass *m)
     m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
+DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1",
                       pc_i440fx_9_1_machine_options);
 
 static void pc_i440fx_9_0_machine_options(MachineClass *m)
@@ -512,7 +501,7 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
     pcmc->isa_bios_alias = false;
 }
 
-DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
+DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0",
                       pc_i440fx_9_0_machine_options);
 
 static void pc_i440fx_8_2_machine_options(MachineClass *m)
@@ -527,7 +516,7 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
-DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
+DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2",
                       pc_i440fx_8_2_machine_options);
 
 static void pc_i440fx_8_1_machine_options(MachineClass *m)
@@ -541,7 +530,7 @@ static void pc_i440fx_8_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
+DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1",
                       pc_i440fx_8_1_machine_options);
 
 static void pc_i440fx_8_0_machine_options(MachineClass *m)
@@ -556,7 +545,7 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
-DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
+DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0",
                       pc_i440fx_8_0_machine_options);
 
 static void pc_i440fx_7_2_machine_options(MachineClass *m)
@@ -566,7 +555,7 @@ static void pc_i440fx_7_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
+DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2",
                       pc_i440fx_7_2_machine_options);
 
 static void pc_i440fx_7_1_machine_options(MachineClass *m)
@@ -576,7 +565,7 @@ static void pc_i440fx_7_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1", NULL,
+DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1",
                       pc_i440fx_7_1_machine_options);
 
 static void pc_i440fx_7_0_machine_options(MachineClass *m)
@@ -588,7 +577,7 @@ static void pc_i440fx_7_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0", NULL,
+DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0",
                       pc_i440fx_7_0_machine_options);
 
 static void pc_i440fx_6_2_machine_options(MachineClass *m)
@@ -598,7 +587,7 @@ static void pc_i440fx_6_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2", NULL,
+DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2",
                       pc_i440fx_6_2_machine_options);
 
 static void pc_i440fx_6_1_machine_options(MachineClass *m)
@@ -609,7 +598,7 @@ static void pc_i440fx_6_1_machine_options(MachineClass *m)
     m->smp_props.prefer_sockets = true;
 }
 
-DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1", NULL,
+DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1",
                       pc_i440fx_6_1_machine_options);
 
 static void pc_i440fx_6_0_machine_options(MachineClass *m)
@@ -619,7 +608,7 @@ static void pc_i440fx_6_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0", NULL,
+DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0",
                       pc_i440fx_6_0_machine_options);
 
 static void pc_i440fx_5_2_machine_options(MachineClass *m)
@@ -629,7 +618,7 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
+DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2",
                       pc_i440fx_5_2_machine_options);
 
 static void pc_i440fx_5_1_machine_options(MachineClass *m)
@@ -643,7 +632,7 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
     pcmc->pci_root_uid = 1;
 }
 
-DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
+DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1",
                       pc_i440fx_5_1_machine_options);
 
 static void pc_i440fx_5_0_machine_options(MachineClass *m)
@@ -655,7 +644,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->auto_enable_numa_with_memdev = false;
 }
 
-DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
+DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",
                       pc_i440fx_5_0_machine_options);
 
 static void pc_i440fx_4_2_machine_options(MachineClass *m)
@@ -665,7 +654,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
+DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2",
                       pc_i440fx_4_2_machine_options);
 
 static void pc_i440fx_4_1_machine_options(MachineClass *m)
@@ -675,7 +664,7 @@ static void pc_i440fx_4_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
+DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1",
                       pc_i440fx_4_1_machine_options);
 
 static void pc_i440fx_4_0_machine_options(MachineClass *m)
@@ -687,7 +676,7 @@ static void pc_i440fx_4_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
+DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0",
                       pc_i440fx_4_0_machine_options);
 
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
@@ -701,7 +690,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
+DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1",
                       pc_i440fx_3_1_machine_options);
 
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
@@ -711,7 +700,7 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
+DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0",
                       pc_i440fx_3_0_machine_options);
 
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
@@ -722,7 +711,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
+DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12",
                       pc_i440fx_2_12_machine_options);
 
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
@@ -732,7 +721,7 @@ static void pc_i440fx_2_11_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
+DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11",
                       pc_i440fx_2_11_machine_options);
 
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
@@ -743,7 +732,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
     m->auto_enable_numa_with_memhp = false;
 }
 
-DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
+DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10",
                       pc_i440fx_2_10_machine_options);
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
@@ -753,7 +742,7 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
+DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9",
                       pc_i440fx_2_9_machine_options);
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
@@ -763,7 +752,7 @@ static void pc_i440fx_2_8_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
+DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8",
                       pc_i440fx_2_8_machine_options);
 
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
@@ -773,7 +762,7 @@ static void pc_i440fx_2_7_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
+DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7",
                       pc_i440fx_2_7_machine_options);
 
 static void pc_i440fx_2_6_machine_options(MachineClass *m)
@@ -788,7 +777,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
+DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6",
                       pc_i440fx_2_6_machine_options);
 
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
@@ -802,7 +791,7 @@ static void pc_i440fx_2_5_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
+DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5",
                       pc_i440fx_2_5_machine_options);
 
 static void pc_i440fx_2_4_machine_options(MachineClass *m)
@@ -816,7 +805,7 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
+DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4",
                       pc_i440fx_2_4_machine_options)
 
 #ifdef CONFIG_ISAPC
-- 
2.41.0


