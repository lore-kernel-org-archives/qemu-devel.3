Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB220C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9MxT-0007sG-MA; Wed, 23 Sep 2026 09:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mst-0000yZ-Pu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:19:43 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Msr-00074f-8R
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:19:39 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664c1479so586044eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169566; x=1790774366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wwD9DuwZG4f9q5/deLy+Fa9fAvUmV5QMi6qQxOTBcxg=;
 b=JNC0dUK0+rX5/zmFOGxabz/hUcn0C/M+wreq+GZKFOZhMvB2pOs99IpKPLF9a7u1dI
 peLulM9uYxuF5Xb2OVglPTVCfSJ3K9yEe1dIt+2VxhlLkTadespWdRiEhtm/37hQEavX
 vEQrpvEMnBuv3PJXPZw5HOCwx3OQvyumPw6QIzjwuhDB6CeHPuQPxf+9Nc80x0YI+9DR
 ysDj7AowAt+Im2sTxwwyVD+7pt4d/LH4++LEVETnkqIoITKZ/dKqwAgZ7ZtFHPaUJo64
 RSb2g8Qj4/RW8mjzv1VZg0kP+Zi4cFt+F+ZNs700uYc3fnvv7kouo6p6hsjnVBzSH+03
 8S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169566; x=1790774366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wwD9DuwZG4f9q5/deLy+Fa9fAvUmV5QMi6qQxOTBcxg=;
 b=2o6huYHkn5I2naHGN75eLk9qM9dcPn64eDw8dLGUoJpPhs7nwfSeyWm6MHnmG0QDjA
 rfNLshtCIC1a2LcrxqEdQ7HVwKhUqbYF6wpdfqPbLoWrlqqzcB4ueZCqlPDkcidYpkWC
 cbzmJ3PlLOBQQcRVa6yeabQ4XuA7wgmSmeDIetlfFHdERyQBj9jIGc+pLyLIv6CY7YLC
 GvlVUpZbAfTtkZ9ELoVFWeDgJ3Wp4GVnSHJlIoT015vsyQPyec/eMbnzJKmR7TGZQxtj
 csg3ml2KB3+N1E1eD6SsxeYhILEvbinvYJ0GYPTHvospduUU0JyayjUCa4OB5IS9jGda
 tOYA==
X-Gm-Message-State: AFuF++mX4aVhMk7fidT2x4AbeLvOWrCU3or9SBnIweiIzkADuwiEfktE
 QUpTiWb1+chw8NTYd/MKFkpHfcJooWDHH/T4zGdbQBaGHaVYjtZT5RDCt0Jh2Mu99AE=
X-Gm-Gg: AYBFou0oelyi0EeRWM2RB7XGcBJti1vel5rCMzA+7vnUNRM5130pzx9bTs1Z5JFECTB
 +JIlcfCs17vC/dUgQv36EaVztneShS2Svp3CQGDANh5Q2x5VphM/gHphqCd0Bm1j9GxPgqXRsuN
 ESx9y0rnUmlcUicB1F9PQF0eacx2B0yqJULr0m0y5F3LccmagG2m178CRFwbwT9hCChd/EjKtCK
 kDmDFzpXGBYOgz5LV/EVAUFHl/kdJlEHBbhfQCW6dRmOUt07buuDj01jT0emfR56esTh5+jAmO9
 kqp9FDtvDAyYTANcPKFgtSJZQTaG+9bihB1DYawVRRnIqi4U4DGI9SO21+fZ+VggWd/akhHPvW0
 tJT4U25lPvovPTdtsddxGF25tIBROWyenSphXUKNJq2yN6YCHxcBa413ExYYtsOJpW/1AJqjkqc
 tg0au5MpCoWcm2mHw/n/uvvyK9SWMUy8CySdg1ZfqI7UkZgahZa8j3+k7ze6y3o/1b6MFFnZXfk
 lzU4Fx/KVyGBMHDIIKzeqJGf7yPHcI=
X-Received: by 2002:a05:693c:638c:10b0:33e:6a54:b3ef with SMTP id
 5a478bee46e88-33e8c05f69amr2514746eec.18.1790169565697; 
 Wed, 23 Sep 2026 06:19:25 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:19:24 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 015/114] qom: pass TargetInfo to is_available
Date: Wed, 23 Sep 2026 21:14:49 +0800
Message-ID: <20260923131635.1894-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Change TypeInfo.is_available to TypeIsAvailable taking const
TargetInfo *. Store the callback on TypeImpl and add
object_class_get_is_available. ARM and RISC-V machines use
target_is_aarch64(), target_is_riscv32(), and target_is_riscv64().
object.h includes target-info.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/aspeed_ast27x0-fc.c  |  2 +-
 hw/arm/aspeed_ast27x0_evb.c |  4 ++--
 hw/arm/raspi.c              |  4 ++--
 hw/arm/raspi4b.c            |  2 +-
 hw/riscv/boston-aia.c       |  4 ++--
 hw/riscv/k230.c             |  4 ++--
 hw/riscv/microchip_pfsoc.c  |  4 ++--
 hw/riscv/opentitan.c        |  4 ++--
 hw/riscv/shakti_c.c         |  4 ++--
 hw/riscv/tt_atlantis.c      |  4 ++--
 hw/riscv/xiangshan_kmh.c    |  4 ++--
 include/qom/object.h        | 27 ++++++++++++++++++++++++---
 qom/object.c                | 11 ++++++++++-
 13 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 73362b60d2a..8a7c6a116ac 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -234,7 +234,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 460c9ff0d2e..02a8cff1d9d 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -75,13 +75,13 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-        .is_available  = target_aarch64,
+        .is_available  = target_is_aarch64,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
-        .is_available  = target_aarch64,
+        .is_available  = target_is_aarch64,
     }
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fadbacb2534..22b06c6ca22 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -403,12 +403,12 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 566d64572db..a1dc477f25e 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -121,7 +121,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
-    .is_available   = target_aarch64,
+    .is_available   = target_is_aarch64,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index ba16b7dbc69..2618b424efe 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -468,14 +468,14 @@ static const TypeInfo boston_types[] = {
         .name          = TYPE_MIPS_BOSTON_AIA,
         .parent        = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(BostonState),
-        .is_available  = target_riscv64,
+        .is_available  = target_is_riscv64,
     },
     {
         .name          = MACHINE_TYPE_NAME("boston-aia"),
         .parent        = TYPE_MACHINE,
         .class_init    = boston_mach_class_init,
         .instance_size = sizeof(MachineState),
-        .is_available  = target_riscv64,
+        .is_available  = target_is_riscv64,
     },
 };
 
diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 43b6ae6d2f2..79715265da6 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -421,7 +421,7 @@ static const TypeInfo k230_soc_type_info = {
     .instance_size = sizeof(K230SoCState),
     .instance_init = k230_soc_init,
     .class_init = k230_soc_class_init,
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void k230_soc_register_types(void)
@@ -560,7 +560,7 @@ static const TypeInfo k230_machine_typeinfo = {
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
     .instance_size = sizeof(K230MachineState),
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void k230_machine_init_register_types(void)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index b2991e5a710..cc4b6bc3529 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -505,7 +505,7 @@ static const TypeInfo microchip_pfsoc_soc_type_info = {
     .instance_size = sizeof(MicrochipPFSoCState),
     .instance_init = microchip_pfsoc_soc_instance_init,
     .class_init = microchip_pfsoc_soc_class_init,
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void microchip_pfsoc_soc_register_types(void)
@@ -759,7 +759,7 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void microchip_icicle_kit_machine_init_register_types(void)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index c3a563db926..9e3db34eed9 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -333,13 +333,13 @@ static const TypeInfo open_titan_types[] = {
         .instance_size  = sizeof(LowRISCIbexSoCState),
         .instance_init  = lowrisc_ibex_soc_init,
         .class_init     = lowrisc_ibex_soc_class_init,
-        .is_available   = target_riscv32,
+        .is_available   = target_is_riscv32,
     }, {
         .name           = TYPE_OPENTITAN_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
-        .is_available   = target_riscv32,
+        .is_available   = target_is_riscv32,
     }
 };
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 76cfe30918a..0f96258b764 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -98,7 +98,7 @@ static const TypeInfo shakti_c_machine_type_info = {
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void shakti_c_machine_type_info_register(void)
@@ -188,7 +188,7 @@ static const TypeInfo shakti_c_type_info = {
     .class_init = shakti_c_soc_class_init,
     .instance_init = shakti_c_soc_instance_init,
     .instance_size = sizeof(ShaktiCSoCState),
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void shakti_c_type_info_register(void)
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index f54eb942f37..086e95bd2d1 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -695,13 +695,13 @@ static const TypeInfo tt_atlantis_types[] = {
         .instance_size = sizeof(TTAtlantisSoCState),
         .instance_init = tt_atlantis_soc_init,
         .class_init = tt_atlantis_soc_class_init,
-        .is_available = target_riscv64,
+        .is_available = target_is_riscv64,
     }, {
         .name       = MACHINE_TYPE_NAME("tt-atlantis"),
         .parent     = TYPE_MACHINE,
         .class_init = tt_atlantis_machine_class_init,
         .instance_size = sizeof(TTAtlantisState),
-        .is_available = target_riscv64,
+        .is_available = target_is_riscv64,
     },
 };
 
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index f2383c53993..6bc669421fe 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -158,7 +158,7 @@ static const TypeInfo xiangshan_kmh_soc_info = {
     .instance_size = sizeof(XiangshanKmhSoCState),
     .instance_init = xiangshan_kmh_soc_instance_init,
     .class_init = xiangshan_kmh_soc_class_init,
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void xiangshan_kmh_soc_register_types(void)
@@ -222,7 +222,7 @@ static const TypeInfo xiangshan_kmh_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
-    .is_available = target_riscv64,
+    .is_available = target_is_riscv64,
 };
 
 static void xiangshan_kmh_machine_register_types(void)
diff --git a/include/qom/object.h b/include/qom/object.h
index 4c0645817a5..f2dc22f0eb0 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 
 struct TypeImpl;
 typedef struct TypeImpl *Type;
@@ -117,6 +118,15 @@ typedef void (ObjectUnparent)(Object *obj);
  */
 typedef void (ObjectFree)(void *obj);
 
+/**
+ * typedef TypeIsAvailable:
+ * @ti: TargetInfo to test.
+ *
+ * Returns whether a type is available for @ti. Typical implementations
+ * are target_is_*().
+ */
+typedef bool (TypeIsAvailable)(const TargetInfo *ti);
+
 #define OBJECT_CLASS_CAST_CACHE 4
 
 /**
@@ -473,8 +483,10 @@ struct Object
  * @class_data: Data to pass to the @class_init,
  *   @class_base_init. This can be useful when building dynamic
  *   classes.
- * @is_available: callback invoked at registration time, to dynamically check if
- *   this type should be available or not.
+ * @is_available: Optional callback. Unset inherits the parent type's
+ *   callback in the MODULE_INIT_QOM after pass (parents are not all
+ *   registered at type_register time). After inherit the callback is
+ *   never NULL. Callers may also invoke it with a chosen TargetInfo.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
  *   element.
@@ -498,7 +510,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
-    bool (*is_available)(void);
+    TypeIsAvailable *is_available;
     const InterfaceInfo *interfaces;
 };
 
@@ -1087,6 +1099,15 @@ bool object_class_is_abstract(ObjectClass *klass);
  */
 bool object_class_is_secure(ObjectClass *klass);
 
+/**
+ * object_class_get_is_available:
+ * @klass: The class to obtain TypeInfo.is_available for.
+ *
+ * Returns: The availability callback (own or inherited from a parent).
+ * Never %NULL after MODULE_INIT_QOM inherit.
+ */
+TypeIsAvailable *object_class_get_is_available(ObjectClass *klass);
+
 /**
  * object_class_by_name:
  * @typename: The QOM typename to obtain the class for.
diff --git a/qom/object.c b/qom/object.c
index 96498f3d001..a3e75927e82 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -15,6 +15,7 @@
 #include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
+#include "qemu/target-info-qapi.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qapi/visitor.h"
@@ -71,6 +72,8 @@ struct TypeImpl
     bool abstract;
     bool secure;
 
+    TypeIsAvailable *is_available;
+
     const char *parent;
     TypeImpl *parent_type;
 
@@ -126,6 +129,7 @@ static TypeImpl *type_new(const TypeInfo *info)
 
     ti->abstract = info->abstract;
     ti->secure = info->secure;
+    ti->is_available = info->is_available;
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -167,7 +171,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available()) {
+    if (info->is_available && !info->is_available(target_info())) {
         return NULL;
     }
 
@@ -1153,6 +1157,11 @@ bool object_class_is_secure(ObjectClass *klass)
     return klass->type->secure;
 }
 
+TypeIsAvailable *object_class_get_is_available(ObjectClass *klass)
+{
+    return klass->type->is_available;
+}
+
 const char *object_class_get_name(ObjectClass *klass)
 {
     return klass->type->name;
-- 
2.52.0.windows.1


