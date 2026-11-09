Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3B606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3hauFPS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNgN-0005eR-AI; Mon, 09 Nov 2026 06:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfj-0005P5-1K
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:31 -0500
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xQNfg-0000Hd-BQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:36:22 -0500
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-372bdb942dbso1043306eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794224179; x=1794828979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=trdyjfrcu55TFPiuJVn/ZYauBXRPJs1lWH3zrWaBRr0=;
 b=I3hauFPSlH3ZmbrBn8p+3ddJ8ogtw7oyeLbuPEqFm+lk1Hv3LbpYX/gPmBQ4HFWN8J
 sakNT6H/+/C3n11v9vzkDLkRQOqgzuVKJVI1d9PAc7f/nXaWBRNs88LkhrTmsJMA8EIp
 Bki5VdY/0VYj3M8DGPC+a60b/OeqXK6E7VmrHACdkI8tk46vPxa5irChEVltHtP3FFNR
 KCw5kecQslqIh1UlI+JEPR1WnBKAcw0ATbxPjYcfmV+P6tdKOQTrggGFuweFG8tHmXQO
 r/0bdmo0eLhB4MqYDy73gSx/hV4FNy7TKq2MM0a4z/hQ853uDtGpfuH+Tv9ku+R77AbY
 0ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794224179; x=1794828979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=trdyjfrcu55TFPiuJVn/ZYauBXRPJs1lWH3zrWaBRr0=;
 b=exXFvYq5EgyLSq854UoXCgwizjMhABr8HWXiypXTM8EJhJqagKkA0A28xZR/ptYARF
 55i1UHUiALuIsGi4OoZlgsYN5Q5aiU4V6G5wekLDZteBp2bVdYSR2vvG+bXtVMM4SQsz
 QhMlKXTzvcP0Hd3sjTYD9mN/5DVdgFEJ14rRAVkGC4g4FH0BWfkoA62o5PWsG4Wo8dfi
 AWkKA4geZtSAGzUF+wXbRWJWFWYuJ8iZr1EzFZqyQXr72M9QHWur/iO8JckSBxU0sKRN
 XMKwowTtG8ZskQxTB9IKFHXaEpHoqTn9857isE9QuumMfuaoUoMVsTJeUzjVyNvcNT4Z
 frww==
X-Gm-Message-State: APuU4Z8wQNblXPP2g6mxhToZ4utAicZq5JRMSRGBptNm910NVQfluZWW
 pAM/FEWPK+nmnKr5jjoa25QlcSlSuws9YpiHW5CdJ1z4w36BKik1AsvRFUsosG3v014=
X-Gm-Gg: AYBFou2zcBc/MoRQfGB7WxubAeeDuu1TTML4KtSGcZ/HpEgrXdmTdRjGOk7W0o0IPS1
 r5LdnKscEnUG24YY1G8PCtItAgeKfpDOQv6RBxvH4UJ6P1qs4XB5Lk8cIXyotPnVCegEBUf6fVJ
 2Bc/wc88GuzHbbTKRHPb3j6mZ9s692b0ba2EvmqSVhK+F6LrupFHAcAAEGnDpoUKHYBUc7uvNt9
 EF5wgm2v11Ulx54+qmciFuM5q1ixPhk1RyMhPokVZtEzCHQUtW0lFpl27qwOQiBTuQjtEAcLt1K
 3AGEDzWQ4mzgesMI9oU40S77dPfKWocVJLupU2dRE19yzKWs85+bbcg9rAEyRHZhBIuksfiwSrd
 jSJW84x8+rvMqVqVpc9yi292wndkoceEsl8mQ50jHilkfZNKq2Kjm9bTgoD/P6JHPK/ez0a7S5q
 FX7V2+XTFCDpM9u+ZtE34hk2oeqQrjSf4N7CYesLjEXp8pJKQbvLrK1mia6VclMEfrLF7FeRU5T
 nJIF11CrVdv3ExBZUan5R+Bihy3zP8lh9BJqqAw7sYB95WUIw+tGySIMJjEMRgXjy1gRe3TSnyo
 S0wAKZHA1NdUoANcUbSDv8s8lm19acKP
X-Received: by 2002:a05:7301:7004:b0:36c:9b35:5d46 with SMTP id
 5a478bee46e88-372571d9ac9mr7271524eec.26.1794224178576; 
 Mon, 09 Nov 2026 03:36:18 -0800 (PST)
Received: from ubuntu.lan ([2405:4802:913e:86f0:35c7:7294:a0c3:69b2])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372660f444csm19762941eec.19.2026.11.09.03.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:36:18 -0800 (PST)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH v2 5/8] hw/arm/allwinner-h618: Connect Allwinner SID controller
Date: Mon,  9 Nov 2026 18:35:33 +0700
Message-ID: <20261109113545.18561-6-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109113545.18561-1-dovankhai97@gmail.com>
References: <20261109113545.18561-1-dovankhai97@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x132a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wire up the Allwinner Security ID (SID) eFuse controller into the
H618 SoC model:
- Map SID MMIO registers at 0x03006000 with 256 bytes capacity
- Remove sid from unimplemented peripheral list
- Configure default fixed SID identifier in Orange Pi Zero 2W machine
- Select ALLWINNER_SID in Kconfig

Signed-off-by: Khai Do <dovankhai97@gmail.com>
---
 hw/arm/Kconfig                  |  1 +
 hw/arm/allwinner-h618.c         | 11 ++++++++++-
 hw/arm/orangepi-zero2w.c        |  8 ++++++++
 include/hw/arm/allwinner-h618.h |  3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 21480e277d..a1c09272fd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -339,6 +339,7 @@ config ALLWINNER_H618
     default y if TCG && AARCH64
     select SERIAL_MM
     select ARM_GIC
+    select ALLWINNER_SID
     select UNIMP
 
 config MAX78000_SOC
diff --git a/hw/arm/allwinner-h618.c b/hw/arm/allwinner-h618.c
index 59e0196fc6..19e9c3f0a3 100644
--- a/hw/arm/allwinner-h618.c
+++ b/hw/arm/allwinner-h618.c
@@ -29,6 +29,7 @@ const hwaddr allwinner_h618_memmap[] = {
     [AW_H618_DEV_GIC_CPU]  = 0x03022000,
     [AW_H618_DEV_GIC_HYP]  = 0x03024000,
     [AW_H618_DEV_GIC_VCPU] = 0x03026000,
+    [AW_H618_DEV_SID]      = 0x03006000,
     [AW_H618_DEV_UART0]    = 0x05000000,
     [AW_H618_DEV_UART1]    = 0x05000400,
     [AW_H618_DEV_UART2]    = 0x05000800,
@@ -44,7 +45,6 @@ static const struct AwH618Unimplemented {
 } unimplemented[] = {
     { "ccu",       0x03001000, 4 * KiB },
     { "dma",       0x03002000, 4 * KiB },
-    { "sid",       0x03006000, 4 * KiB },
     { "smc",       0x03007000, 4 * KiB },
     { "timer",     0x03009000, 4 * KiB },
     { "pwm",       0x0300a000, 4 * KiB },
@@ -91,6 +91,10 @@ static void allwinner_h618_init(Object *obj)
     }
 
     object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
+
+    object_initialize_child(obj, "sid", &s->sid, TYPE_AW_SID);
+    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
+                              "identifier");
 }
 
 static void allwinner_h618_realize(DeviceState *dev, Error **errp)
@@ -172,6 +176,11 @@ static void allwinner_h618_realize(DeviceState *dev, Error **errp)
                                             ppibase + AW_H618_GIC_PPI_MAINT));
     }
 
+    /* Security Identifier */
+    qdev_prop_set_uint32(DEVICE(&s->sid), "size", 256);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sid), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H618_DEV_SID]);
+
     /* SRAM */
     memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
                            64 * KiB, &error_abort);
diff --git a/hw/arm/orangepi-zero2w.c b/hw/arm/orangepi-zero2w.c
index fe87a98efc..1cc9ad7ba6 100644
--- a/hw/arm/orangepi-zero2w.c
+++ b/hw/arm/orangepi-zero2w.c
@@ -40,6 +40,14 @@ static void orangepi_zero2w_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "soc", OBJECT(h618));
     object_unref(OBJECT(h618));
 
+    /* Setup SID properties. Currently using a default fixed SID identifier. */
+    if (qemu_uuid_is_null(&h618->sid.identifier)) {
+        qdev_prop_set_string(DEVICE(h618), "identifier",
+                             "03006180-1111-2222-3333-000044556677");
+    } else if (ldl_be_p(&h618->sid.identifier.data[0]) != 0x03006180) {
+        warn_report("Security Identifier value does not include H618 prefix");
+    }
+
     /* Mark H618 object realized */
     qdev_realize(DEVICE(h618), NULL, &error_abort);
 
diff --git a/include/hw/arm/allwinner-h618.h b/include/hw/arm/allwinner-h618.h
index e1b7162759..d4c3d19725 100644
--- a/include/hw/arm/allwinner-h618.h
+++ b/include/hw/arm/allwinner-h618.h
@@ -11,6 +11,7 @@
 
 #include "qom/object.h"
 #include "hw/intc/arm_gic.h"
+#include "hw/misc/allwinner-sid.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -23,6 +24,7 @@ enum {
     AW_H618_DEV_GIC_CPU,
     AW_H618_DEV_GIC_HYP,
     AW_H618_DEV_GIC_VCPU,
+    AW_H618_DEV_SID,
     AW_H618_DEV_UART0,
     AW_H618_DEV_UART1,
     AW_H618_DEV_UART2,
@@ -50,6 +52,7 @@ struct AwH618State {
     ARMCPU cpus[AW_H618_NUM_CPUS];
     const hwaddr *memmap;
     GICState gic;
+    AwSidState sid;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
 };
-- 
2.43.0


