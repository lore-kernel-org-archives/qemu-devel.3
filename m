Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641BFA3744
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 13:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbfFr-0001D3-6c; Fri, 02 Jan 2026 08:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbfFb-000192-RX
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:31:35 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbfFZ-0000Az-0r
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:31:30 -0500
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so15638448a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767360687; x=1767965487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HjV/59VQGVQxoGFx1fCN4TjjeXxgeOHzmt6liK3MgIk=;
 b=Bi0C/Zj7jkjWZ9H/WG9JCQEL8hcKVjOHbgJZg4Lrew7FH6gUW1pLJ4a1fW/Recn/Qc
 v3mgj4y7T2sDGN7qm75oWeox9hfrfuOAKjHER4nQtFWH+usDLIxjpHdt28DG4CGd/Ll0
 2wCvOQWJvMlSOZXokF7BQZAjAtrM0YvFemAmo5BzBRwGL8DAnf0Hj2+d7AA5ILjw6QQw
 WYp8Pkye/V1AXjy1yG4JBWRJLvXmCVu/V5RCoc6kCOstaeOI/I/y4/QBFQ0P6BDwR2Wr
 co07IjhTX8nAXy/+qa5Zdg8kNMP+S1jL5cq3QgQVAJsKeZFHMSwt4zcZvgRdXgutplyX
 dZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767360687; x=1767965487;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HjV/59VQGVQxoGFx1fCN4TjjeXxgeOHzmt6liK3MgIk=;
 b=RlKb9bKQLuGPDNozDCLZ492cw5t98m1h877poCodbip8CuSDbzzsb4Com1NMLDAcsf
 uRfFXmudfkUqW0AMEnJMI2oI/l3Wpt5h9Xfn+5hWguRp+Mgn2313ANh7rljc8ZOAm6vH
 LIjZiTvrAbtphqOP2Y4t2BJtxRTFatWenoLOOKz5ZuAr7w1MG6HoLVzAkz571AwSUka5
 vUkFV3CFKsNMbP4e2fPUFdFRIbs4wSN2AAwg69abXErpDtpLbyVlgHpDJjWen8nXOsSr
 WbILeZMDSsVRNllsgdLvGhJuBpq1Otlc97V2FwE6I6m1eZ+NR8cDWCQVFgx4NVx0qJN+
 MzpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Nb/K/kOWbyXmHUh+5JfuQRJTvQ50wiO+pbdFNSVayNiy4mPPx/yEODDOYHDq7BtqPJmWw2YhWYZt@nongnu.org
X-Gm-Message-State: AOJu0Yxv53/JEL+6k+L/km2DaD7Zvrn3WHyStRLG6vyH2TgXHm+t/AS1
 r491XI2DV4VFKFfUsrfUjhsmPaQLEJCIIVRAejKTn+sxwzBZpiEvEqkx
X-Gm-Gg: AY/fxX5Kv0FpDq3VBdyPVLHUP8u9vc8Vj06H1goXsMd9MvRu+n/CKeS2yjgZw3KiToY
 gs87S3PwMkJLMCqZ1euxmxucgQr1O+7IMuwbGj0Q5uK7g1d/hPMGoEYKelPJt82qDsyA5GCvZ69
 KITpu+qZtJKSXnmXRreIox+kGcz96OMW00wHt0cs2b7t4UuoTAR7HrOQ1cdM0r6h55ZPVFmeR19
 gyFfrWCdNgZEsCh51QCIdfJMKMaq4IpDL0dVp+cLW9gdaVwYQ8CwdP/jGvxrdy2nkVsf5LLTkeI
 tLpykOGZ7tQ5tTbeywbNxPrWjtYqqd6HLUmSvt8/28KtSREB0tRkODoQQIJlFa5od7dbxdeQH6y
 hJHoMV3EMWIY07QufiAMrdgAIuuTl+cw2guQN2VdzSffnR+YIqBNrI8+Enu1AsRMSfZ2yGy/0KV
 zOb1FAV5KyS6v3ABVY8uWiZf5PZ707FTy9YrjdATA9rjXJUf7yWovBppyJiym35DSoqK06Y3ds
X-Google-Smtp-Source: AGHT+IGtS2kyIPc1LgcqLkXf5L0J2gT63lqsWCr+BRFEtOoEI+hnbTcxGTyEmOKrtLkxUVH155jGIw==
X-Received: by 2002:a05:6402:40cb:b0:64b:bb79:96bb with SMTP id
 4fb4d7f45d1cf-64bbb799a91mr35279427a12.24.1767360687023; 
 Fri, 02 Jan 2026 05:31:27 -0800 (PST)
Received: from [10.0.2.15] (dynamic-089-012-124-190.89.12.pool.telefonica.de.
 [89.12.124.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b916b82e7sm46634540a12.35.2026.01.02.05.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 05:31:25 -0800 (PST)
Message-ID: <05eac9c6-1134-4d0b-999f-c6f2ee20f443@gmail.com>
Date: Fri, 2 Jan 2026 14:31:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH v1 1/6] hw/arm/sabrelite: Convert machine to full class
To: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <4bece01078549fe0565af4cd28df46da97a372fb.1765826753.git.matyas.bobek@gmail.com>
Content-Language: en-US
In-Reply-To: <4bece01078549fe0565af4cd28df46da97a372fb.1765826753.git.matyas.bobek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x541.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 15. Dezember 2025 20:03:10 UTC schrieb "Matyáš Bobek" 
<matyas.bobek@gmail.com>:
>Define SABRELITE_MACHINE manually instead of
>DEFINE_MACHINE_ARM to allow "canbus*" machine
>properties to be added later.
>
>Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
>---
> hw/arm/sabrelite.c | 54 +++++++++++++++++++++++++++++++++++++---------
> 1 file changed, 44 insertions(+), 10 deletions(-)
>
>diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
>index 5b4ab7d77a..29418af190 100644
>--- a/hw/arm/sabrelite.c
>+++ b/hw/arm/sabrelite.c
>@@ -20,6 +20,16 @@
> #include "qemu/error-report.h"
> #include "system/qtest.h"
> 
>+typedef struct SabreliteMachineState {

No need for a typedef here since a "SabreliteMachineState" typedef is 
introduced by OBJECT_DECLARE_SIMPLE_TYPE below which should be used instead.

>+    MachineState parent_obj;

Add one blank line here to visually separate the base class.

>+    FslIMX6State soc;
>+
>+    struct arm_boot_info binfo;

"binfo" is unused.

>+} Sabrelite;

So your struct may look like this:

struct SabreliteMachineState {
     MachineState parent_obj;

     FslIMX6State soc;
};

>+
>+#define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
>+OBJECT_DECLARE_SIMPLE_TYPE(SabreliteMachineState, SABRELITE_MACHINE)
>+
> static struct arm_boot_info sabrelite_binfo = {
>     /* DDR memory start */
>     .loader_start = FSL_IMX6_MMDC_ADDR,
>@@ -41,7 +51,7 @@ static void sabrelite_reset_secondary(ARMCPU *cpu,
> 
> static void sabrelite_init(MachineState *machine)
> {
>-    FslIMX6State *s;
>+    Sabrelite *s = SABRELITE_MACHINE(machine);
> 
>     /* Check the amount of memory is compatible with the SOC */
>     if (machine->ram_size > FSL_IMX6_MMDC_SIZE) {
>@@ -50,13 +60,12 @@ static void sabrelite_init(MachineState *machine)
>         exit(1);
>     }
> 
>-    s = FSL_IMX6(object_new(TYPE_FSL_IMX6));
>-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX6);
> 
>     /* Ethernet PHY address is 6 */
>-    object_property_set_int(OBJECT(s), "fec-phy-num", 6, &error_fatal);
>+    object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fatal);
> 
>-    qdev_realize(DEVICE(s), NULL, &error_fatal);
>+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> 
>     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
>                                 machine->ram);
>@@ -70,7 +79,7 @@ static void sabrelite_init(MachineState *machine)
>         /* Add the sst25vf016b NOR FLASH memory to first SPI */
>         Object *spi_dev;
> 
>-        spi_dev = object_resolve_path_component(OBJECT(s), "spi1");
>+        spi_dev = object_resolve_path_component(OBJECT(&s->soc), "spi1");
>         if (spi_dev) {
>             SSIBus *spi_bus;
> 
>@@ -89,23 +98,33 @@ static void sabrelite_init(MachineState *machine)
>                 qdev_realize_and_unref(flash_dev, BUS(spi_bus), &error_fatal);
> 
>                 cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
>-                qdev_connect_gpio_out(DEVICE(&s->gpio[2]), 19, cs_line);
>+                qdev_connect_gpio_out(DEVICE(&s->soc.gpio[2]), 19, cs_line);
>             }
>         }
>     }
> 
>+

Extra line here. Please remove to keep the style consistent.

>     sabrelite_binfo.ram_size = machine->ram_size;
>     sabrelite_binfo.secure_boot = true;
>     sabrelite_binfo.write_secondary_boot = sabrelite_write_secondary;
>     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
> 
>     if (!qtest_enabled()) {
>-        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
>+        arm_load_kernel(&s->soc.cpu[0], machine, &sabrelite_binfo);
>     }
> }
> 
>-static void sabrelite_machine_init(MachineClass *mc)
>+static void sabrelite_machine_instance_init(Object *obj)
> {
>+    Sabrelite *s = SABRELITE_MACHINE(obj);
>+
>+    (void)s;

Unused variable. This normally results in a warning, so shouldn't be 
done. I suggest deferring introduction of this method to patch "hw/arm: 
Plug FlexCAN into FSL_IMX6 and Sabrelite".

You may also consider splitting this patch in two, one which open codes 
the DEFINE_MACHINE_ARM macro and a second one introducing the dedicated 
struct SabreliteMachineState.

Best regards,
Bernhard

>+}
>+
>+static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
>+{
>+    MachineClass *mc = MACHINE_CLASS(oc);
>+
>     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
>     mc->init = sabrelite_init;
>     mc->max_cpus = FSL_IMX6_NUM_CPUS;
>@@ -114,4 +133,19 @@ static void sabrelite_machine_init(MachineClass *mc)
>     mc->auto_create_sdcard = true;
> }
> 
>-DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
>+static const TypeInfo sabrelite_machine_init_typeinfo = {
>+    .name       = TYPE_SABRELITE_MACHINE,
>+    .parent     = TYPE_MACHINE,
>+    .class_init = sabrelite_machine_class_init,
>+    .instance_init = sabrelite_machine_instance_init,
>+    .instance_size = sizeof(Sabrelite),
>+    .abstract   = false,
>+    .interfaces = arm_machine_interfaces,
>+};
>+
>+static void sabrelite_machine_init_register_types(void)
>+{
>+    type_register_static(&sabrelite_machine_init_typeinfo);
>+}
>+
>+type_init(sabrelite_machine_init_register_types)

