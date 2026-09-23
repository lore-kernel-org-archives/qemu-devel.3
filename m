Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD81C98310
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9My5-0002LU-Vn; Wed, 23 Sep 2026 09:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mud-0002Zo-E4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:29 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mua-0007V7-GU
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:27 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664c1479so587782eec.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169673; x=1790774473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aW7Q/4+ozQSDE0PZQ7E9tHZoVUU6eb45JG6HfJcLS94=;
 b=lYS7Niy7JqOrK6SObE++GGfz5/X8m3M8bU9O7/F8HPunnJPDIVLbBXWY9U+igMNC3Y
 +E0EA4hQpFa2TuS/V1vwVNQ6Ojghmcru1gbfJ3YdXFS/a8B5Ebe9a45w9QDo1cu8ADTA
 is+yz4i9B24gY43nqkLB0f4O6ycP6hhKLzLfQUjJ5qq+Mx0/KrmjlL1ADx0y/q50+Rvd
 7tu29sUvy9TzfiIlNMwXnOp2kRnR1j1+0DpW1lplArKhmMrivNM4aS4+95qkeECGCNhg
 uXApdUjYebKXPFz0Jo0SIKdRX1F2RobV8M7oraOZa6BI2exIjjk1hix93eZs00J+Erll
 OrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169673; x=1790774473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aW7Q/4+ozQSDE0PZQ7E9tHZoVUU6eb45JG6HfJcLS94=;
 b=o8lAiV5wVIJJEAW6lnq+EtMV7S8SXBwJGmPbpqIjQdsvi9uob9f+ggx/yLJUvAaOvT
 D9KmqofovaHL3DfyeQPqlJwv4urLudEhsa4WMbDcMhDNYrUDtGMdMDUTZti6OpYBWw0r
 sucYrjF4kyQs3q4YubDbPLSmBL6a4h+9OqnsTAUoDvdgNw+Y6QP7wKUOcF+k0PGfyKlF
 g9oB04CV3m+3gKSabBjyBnN8589H90YKbCOLDYoWxna3zgdmmajURciZY9TJ9yXk5tCf
 eIJyxKia+2UfMK7gTbiWMBahVNFhoDAxS82XimQ14Bb3JlojGR2RAyuTEvDTIDCdr/4X
 9ylQ==
X-Gm-Message-State: AFuF++nmddItg+xlKY++UUerHRq0/+9pwUHJXeZuOWGLy/jCGCxB1QlS
 1AuKK48voJI28EyrcydNX0WrTlDmdMrFn5JAbFy3EPPWXZZyXzYOTenlIo7fHtK/rhU=
X-Gm-Gg: AYBFou0/lL1ojsqsadDbhTbDx0qP/0vHkvSjq0COYVlhluZ6F3u5PSlnsTOnkd+FjPY
 Clo50wAniNUOIlU4yD2geNEKQOFNc6qcMj2lh6XxRGr0DOACLHZnwv+nV9UldS4VK7513V+tBiA
 S4K/zNcxTHQ3jrKcOp7zx4wpOTHDVokHhp6hbcfmbbtmV7ltvGdfptU3PJERYJH2abfY2jL4cSW
 sNeHBvarQ1LglBW2z4RcJH2tc/WCblDnUEM1+QUShIPj95tMCxm6pbkdp2mMJwUF78BqFr/CE+X
 psQNnUHOOYKW9MHka46plGju2ApIdNUG8x/CMj51NAhTCHqjiK52mTPcXxYtOmUM2BjsU8NIsoE
 /7XRVPzxMjumt63JCy66asZ+V3DdLkIPOIa2yuqyAFxofR+JpTpBYMseorrBszXrrlghgVSolvx
 gE839ZrSsK6r30RAUb05mczps/nkUtgYadnQFnFfT/0fXfNnnZF5tTeRqySe17vkliIMYIIvRrZ
 xVnifE+8JQrQrNtLIH9xlOheTKFsRVFP/M2c3+7icLvVYTxgWWhEw==
X-Received: by 2002:a05:7300:cca4:b0:33b:fc68:9790 with SMTP id
 5a478bee46e88-33e8d2ebd99mr2512374eec.21.1790169672443; 
 Wed, 23 Sep 2026 06:21:12 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:21:09 -0700 (PDT)
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
Subject: [PATCH v3 025/114] hw/riscv: gate boards with target_is_base_riscv
Date: Wed, 23 Sep 2026 21:14:59 +0800
Message-ID: <20260923131635.1894-26-luoyonggang@gmail.com>
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

- Set TypeInfo.is_available to target_is_base_riscv on RISC-V machines
  so a combined qemu-system lists them only for riscv32/riscv64.
---
 hw/riscv/k230.c            | 1 +
 hw/riscv/microchip_pfsoc.c | 1 +
 hw/riscv/opentitan.c       | 1 +
 hw/riscv/shakti_c.c        | 1 +
 hw/riscv/sifive_e.c        | 1 +
 hw/riscv/sifive_u.c        | 1 +
 hw/riscv/spike.c           | 1 +
 hw/riscv/tt_atlantis.c     | 1 +
 hw/riscv/virt.c            | 1 +
 hw/riscv/xiangshan_kmh.c   | 1 +
 10 files changed, 10 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 79715265da6..3890cb6357d 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -557,6 +557,7 @@ static void k230_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo k230_machine_typeinfo = {
     .name       = TYPE_RISCV_K230_MACHINE,
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = k230_machine_class_init,
     .instance_init = k230_machine_instance_init,
     .instance_size = sizeof(K230MachineState),
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index cc4b6bc3529..103c0d7f7ca 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -756,6 +756,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
 static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("microchip-icicle-kit"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 9e3db34eed9..db1fb3e3347 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -337,6 +337,7 @@ static const TypeInfo open_titan_types[] = {
     }, {
         .name           = TYPE_OPENTITAN_MACHINE,
         .parent         = TYPE_MACHINE,
+        .is_available   = target_is_base_riscv,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
         .is_available   = target_is_riscv32,
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 0f96258b764..e8ae770f7ca 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -95,6 +95,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo shakti_c_machine_type_info = {
     .name = TYPE_RISCV_SHAKTI_MACHINE,
     .parent = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1b6f9ab4fee..087d0c48e1e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -165,6 +165,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo sifive_e_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("sifive_e"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = sifive_e_machine_class_init,
     .instance_init = sifive_e_machine_instance_init,
     .instance_size = sizeof(SiFiveEState),
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 344f3d915d7..d5cc9255da6 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -679,6 +679,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo sifive_u_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("sifive_u"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = sifive_u_machine_class_init,
     .instance_init = sifive_u_machine_instance_init,
     .instance_size = sizeof(SiFiveUState),
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 63cf77e1de3..4bb58ec6203 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -292,6 +292,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo spike_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("spike"),
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = spike_machine_class_init,
     .instance_init = spike_machine_instance_init,
     .instance_size = sizeof(SpikeState),
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 086e95bd2d1..6e7272d705c 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -699,6 +699,7 @@ static const TypeInfo tt_atlantis_types[] = {
     }, {
         .name       = MACHINE_TYPE_NAME("tt-atlantis"),
         .parent     = TYPE_MACHINE,
+        .is_available = target_is_base_riscv,
         .class_init = tt_atlantis_machine_class_init,
         .instance_size = sizeof(TTAtlantisState),
         .is_available = target_is_riscv64,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0edf75fefc3..2240a516d85 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1202,6 +1202,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 static const TypeInfo virt_machine_typeinfo = {
     .name       = TYPE_RISCV_VIRT_MACHINE,
     .parent     = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .class_init = virt_machine_class_init,
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 6bc669421fe..9578a11aee6 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -220,6 +220,7 @@ static void xiangshan_kmh_machine_class_init(ObjectClass *klass, const void *dat
 static const TypeInfo xiangshan_kmh_machine_info = {
     .name = TYPE_XIANGSHAN_KMH_MACHINE,
     .parent = TYPE_MACHINE,
+    .is_available = target_is_base_riscv,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
     .is_available = target_is_riscv64,
-- 
2.52.0.windows.1


