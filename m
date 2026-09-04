Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED6CC79F81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNh-0004P7-1n; Fri, 04 Sep 2026 01:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNe-00041N-4y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:26 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNc-0001X4-C8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:25 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso1057393a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499343; x=1789104143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AVJ8uBQ1nukyOBYJXTfHthUrX35qgEzUAaW/F9BSQ/0=;
 b=huVaGA53OkL3fbboofwToC0J7K3mM6x70Ygs2UVEUYHOUnbqZKJADUd2S7f03JQAEF
 iPcM+PYkUJzMoWjWt1z887DqA0M8s2X1i+YfHViArqbXsNFSKVtrlAXaGStcF/C0CIlU
 V59QfK+loOKICy28/wgSIM1hu8Qdr3QVZO8wbYDZ5IMtB7wQhlLbcNroQgQgAe9o0lb2
 adF+DTpu2tflrR+e5D/cCXSephGozEI3wrQW0as9DL3ZEphfBZx97KZ1yeNcOKx16RC4
 4cS9nZmRXNgCTBKuEikhOmAF30P1LWqvtyqP7GaavTd47KFYZM/DTlFIfxl9b/mgv86R
 5hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499343; x=1789104143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AVJ8uBQ1nukyOBYJXTfHthUrX35qgEzUAaW/F9BSQ/0=;
 b=GGAQAgBUDGg3Nfl7kBAoKd6ry4BhvG2GY0lWG9dRuq82KBEqS1pN8fx5iEzfSiS9ks
 4KvEkU3UrpqWU53f0qOFRyKsmPaAxA9iWEEVJA+qJDm/RLsSSQx78vT7mbeV99ZOS/1l
 cBTrX7Pm0PCh3Ktswwjxp6B2C7iNlIsqV1TWZR/UxwwkK1+JjAm4bf0JjlhxeomW6Mkj
 GeXlz5kMhC9bCfncw2HGyM6tp6baw1ZmkSxCofP2ScrAtP+h78QiJusFrhJOiraHYvPi
 M6GBikOp33J0EKtI7e3i7RCZzq4/nwGPEfMNfgcEubVayh0LWImKdB42LessEow7+qtD
 uwdw==
X-Gm-Message-State: AFuF++knpD8i/F5jsLThLVVx1nrOQ9jQM0rcTJlH8IG6Lyk8JVM3J1PX
 DH/5h7tXIOgsO1HYw/y85CVMLxSzwkxlNvvn/yt/SlkjisFBGDbM48xHwQ0hWw==
X-Gm-Gg: AYBFou1wyBcw8UcCsfH2ERI4Bv9/KK492qUOwrmTyW/F06n798+Lj2H7WpBMZwZuR8r
 KqqXySYDtLdqSni5Zu9RJTEKwi3WAiA9gORWDwDyaMZE5j05CLcjrkt4LptAKA6tLXGxAgCrXHs
 HdG803q+axO5gnAx4NcuC6R/KHQ5jYg3P44MpSUlGA71pfQ3bjJH048Vy6nXeNbi1MrHlq8fdXx
 cCZ6Tbe2NPs/iZE6BOHfE+2Ma/48jzu4dp5MMlZqjVvHWutQIUDxMMbcn8TF5rVGM2YVYRXnz1p
 BEW5fk5hzB1IY32mdHo5O9Hx8RS4Tx5hsWN1k4f4ELWtF/+CGP5tpSVWYGJ2g74AFLhkZgnrFWJ
 /v4eW/yZxkcNnG8XDNFD9v8TUqgypatkUCtJk6d2y6KjWNeqbblhhNCU9WkbopMrNFwQdWsZLAV
 k5sDyf26rbhu5iIqXyVXnCm6PJy1pZSSpEROXwixy3ucpSKKaA41HX2mEzhMEz2x8Z5wPd2dbmZ
 rZkiw==
X-Received: by 2002:a05:6a21:3a41:b0:3d3:ae50:97c8 with SMTP id
 adf61e73a8af0-3da3a16bb4bmr5319249637.21.1788499342792; 
 Thu, 03 Sep 2026 22:22:22 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:22:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/47] hw/riscv/atlantis: Map the SoC through a memory container
Date: Fri,  4 Sep 2026 15:19:43 +1000
Message-ID: <20260904051943.799041-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Give the Atlantis SoC a 'memory' link property. The machine creates a
container MemoryRegion, maps it at address 0 of system memory, and
passes it to the SoC together with the machine RAM. The SoC maps devices
into the 'memory' container instead of system memory, allowing
TTAtlantisSoCState to be composed together with other SoCs in the
future.

This prepares the machine for adding other microcontrollers that share
the memory bus with the Ascalon complex (aka the Atlantis SoC), but with
their own view of the address map.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-17-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  1 +
 hw/riscv/tt_atlantis.c         | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 5d4e4d133b..3923308b7c 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -53,6 +53,7 @@ struct TTAtlantisState {
     /*< public >*/
     Notifier machine_done;
 
+    MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
 };
 
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index c44fd8d6d0..8a219afef7 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -503,8 +503,10 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     ram_addr_t lo_ram_size, ram_size;
     int hart_count = s->num_harts;
 
-    s->memory = get_system_memory();
-
+    if (!s->memory) {
+        error_setg(errp, "'memory' link is not set");
+        return;
+    }
     if (!s->dram) {
         error_setg(errp, "'dram' link is not set");
         return;
@@ -523,6 +525,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
+    object_property_set_link(OBJECT(&s->cpus), "memory", OBJECT(s->memory),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
         return;
     }
@@ -614,6 +618,8 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 static const Property tt_atlantis_soc_props[] = {
     DEFINE_PROP_STRING("cpu-type", TTAtlantisSoCState, cpu_type),
     DEFINE_PROP_UINT32("num-harts", TTAtlantisSoCState, num_harts, 8),
+    DEFINE_PROP_LINK("memory", TTAtlantisSoCState, memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
@@ -633,12 +639,19 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
     TTAtlantisSoCState *s = &ams->soc;
 
+    memory_region_init(&ams->soc_memory, OBJECT(machine),
+                       "tt-atlantis.soc-memory", UINT64_MAX);
+    memory_region_add_subregion(get_system_memory(), 0, &ams->soc_memory);
+
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
     object_property_set_str(OBJECT(&ams->soc), "cpu-type", machine->cpu_type,
                             &error_abort);
     object_property_set_int(OBJECT(&ams->soc), "num-harts", machine->smp.cpus,
                             &error_abort);
+
+    object_property_set_link(OBJECT(&ams->soc), "memory",
+                             OBJECT(&ams->soc_memory), &error_abort);
     object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
                              &error_abort);
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
-- 
2.55.0


