Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710CC5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqO3-0002Pa-ON; Wed, 21 Feb 2024 12:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqO2-0002Ob-Hz
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:28:02 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqNz-0001OC-DC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:28:01 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so953774666b.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708536477; x=1709141277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nanjrW8+lHyTaE/BIXI3+e3cjCA8p5Dw61k2o3R3a1A=;
 b=J7o9Wva59OBghUmZfCeNRoB2nr69fGlo311Nlpm/cOxtyoJdb3XTdeIf4kuhA5g5zs
 RyarlQbHIhunDfZdwDgJNZKBq/UTapXAMMIEZGBjI96liltAjXdZMSkkBAd4dY4kaKe9
 CwjX7bll2lIgK+5FGbDnnpi8oRTnbPn78T7NXZcCd4gkKCJhE+/y1ncgPyFi4+e8Q744
 LD0U05Fk9EO7NVJ2XPMC8xGRIHfJd3ZIZ7vhpLlCd01dpbwA2LzV6Q+E7oycSTEolU9I
 hFGbjensccxmZSvDWTy5ZOw/yWmcnB4BEBdj6+SVYr7N9beUo0DJy9+gAQ/icSesEBXv
 p+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536477; x=1709141277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nanjrW8+lHyTaE/BIXI3+e3cjCA8p5Dw61k2o3R3a1A=;
 b=ItmEfqeXIVmCitoHwdfi36tT78KOSr4v29bWLT9fPRF5jWW9Vzvre9yTM9En6wTGgt
 YYsJHqz7dCpMwjgOUfpa/bzwuVE7yjYU4ksIQC5vaGQkoBPdKYr3ZWUdpR18p74HTpX2
 a4jcDwL05qsc3E8D/lxFMZbsa4rXI+83t6WwFv0ntQDa0TCOdFaEqccv11eQhRQTMlaA
 iiJmI8PitTd8h2sHK1J02+zBFTVJBXtVd4EuvJ6Ib9+VwggUufknPfiiyeOlM/0YZfdD
 guL5EMyEG4p1aF9BHXBLCJErwZQp27dYBcmKoAPDzfobwZOlevDPSJ6RC9ijUYIQdN0m
 Q4iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQrzYAkPbIiytNXBdGwAORxCWPBDwURgfoVGNCIk5vhMdBaq2XZDpjrVVsh7M5GbV4ITkHHOAhIK+uwkh/32uoqjpqs4E=
X-Gm-Message-State: AOJu0YyDcTO09dg2LS610d6wvzuVsqYdT+czx5x0KYkBelDKPd5wOBxB
 pl7CNcO+jK4y/ut/SWFyiuBaLUVHJLyQ/v6MADoX2r6XEOfLkaYQSqm2VV98wUM=
X-Google-Smtp-Source: AGHT+IEFy1XZz6MjT8rdd2q/uvb/+AodjOcQrlyNIvuC7uYbTj4hZiqyreXOJMdBGFQem5WlQefVgQ==
X-Received: by 2002:a17:906:f919:b0:a3f:4a97:f552 with SMTP id
 lc25-20020a170906f91900b00a3f4a97f552mr1323185ejb.70.1708536477518; 
 Wed, 21 Feb 2024 09:27:57 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 rf20-20020a1709076a1400b00a3f2bf468b9sm971061ejc.173.2024.02.21.09.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:27:56 -0800 (PST)
Message-ID: <e38c7fa5-8dc8-4e7a-a4a9-06a88206b325@linaro.org>
Date: Wed, 21 Feb 2024 18:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] meson: Enable -Wvla
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240221162636.173136-1-thuth@redhat.com>
 <20240221162636.173136-4-thuth@redhat.com>
 <8dac5c1a-5780-45ca-90fe-147f1ab2fe28@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8dac5c1a-5780-45ca-90fe-147f1ab2fe28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 21/2/24 17:59, Thomas Huth wrote:
> On 21/02/2024 17.26, Thomas Huth wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>>
>> QEMU has historically used variable length arrays only very rarely.
>> Variable length arrays are a potential security issue where an
>> on-stack dynamic allocation isn't correctly size-checked, especially
>> when the size comes from the guest.  (An example problem of this kind
>> from the past is CVE-2021-3527).  Forbidding them entirely is a
>> defensive measure against further bugs of this kind.
>>
>> Enable -Wvla to prevent any new uses from sneaking into the codebase.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-ID: <20240125173211.1786196-3-peter.maydell@linaro.org>
>> [thuth: rebased to current master branch]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>> diff --git a/meson.build b/meson.build
>> index c1dc83e4c0..0ef1654e86 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -592,6 +592,7 @@ warn_flags = [
>>     '-Wstrict-prototypes',
>>     '-Wtype-limits',
>>     '-Wundef',
>> +  '-Wvla',
>>     '-Wwrite-strings',
>>     # Then disable some undesirable warnings
> 
> Sigh, there's a new warning in the latest master branch:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/6225992174
> 
> Caused by commit d65aba828 ("hw/sparc/leon3: implement multiprocessor")...
> Clément, Philippe, could this maybe be written in a different way that 
> does not trigger a -Wvla warning?

Clément, ResetData::entry isn't used, so we can simplify removing
the whole ResetData structure, but I'm not sure this is intended:

-- >8 --
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 4873b59b6c..1ff6b5d63d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -68,14 +68,6 @@
  #define LEON3_APB_PNP_OFFSET (0x800FF000)
  #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)

-typedef struct ResetData {
-    struct CPUResetData {
-        int id;
-        SPARCCPU *cpu;
-    } info[MAX_CPUS];
-    uint32_t entry;             /* save kernel entry in case of reset */
-} ResetData;
-
  static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
  {
      stl_p(code++, 0x82100000); /* mov %g0, %g1                */
@@ -148,17 +140,14 @@ static void write_bootloader(void *ptr, hwaddr 
kernel_addr)

  static void leon3_cpu_reset(void *opaque)
  {
-    struct CPUResetData *info = (struct CPUResetData *) opaque;
-    int id = info->id;
-    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
-    CPUState *cpu = CPU(s->info[id].cpu);
+    CPUState *cpu = opaque;
      CPUSPARCState *env = cpu_env(cpu);

      cpu_reset(cpu);

      cpu->halted = cpu->cpu_index != 0;
-    env->pc = s->entry;
-    env->npc = s->entry + 4;
+    env->pc = LEON3_PROM_OFFSET;
+    env->npc = LEON3_PROM_OFFSET + 4;
  }

  static void leon3_cache_control_int(CPUSPARCState *env)
@@ -259,7 +248,7 @@ static void leon3_generic_hw_init(MachineState *machine)
      ram_addr_t ram_size = machine->ram_size;
      const char *bios_name = machine->firmware ?: LEON3_PROM_FILENAME;
      const char *kernel_filename = machine->kernel_filename;
-    SPARCCPU *cpu;
+    SPARCCPU *cpu[MAX_CPUS];
      CPUSPARCState   *env;
      MemoryRegion *address_space_mem = get_system_memory();
      MemoryRegion *prom = g_new(MemoryRegion, 1);
@@ -267,28 +256,22 @@ static void leon3_generic_hw_init(MachineState 
*machine)
      char       *filename;
      int         bios_size;
      int         prom_size;
-    ResetData  *reset_info;
      DeviceState *dev, *irqmpdev;
      int i;
      AHBPnp *ahb_pnp;
      APBPnp *apb_pnp;

-    reset_info = g_malloc0(sizeof(ResetData));
-
      for (i = 0; i < machine->smp.cpus; i++) {
          /* Init CPU */
-        cpu = SPARC_CPU(object_new(machine->cpu_type));
-        qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, 
"start_cpu", 1);
-        qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
-        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
-        env = &cpu->env;
+        cpu[i] = SPARC_CPU(object_new(machine->cpu_type));
+        qdev_init_gpio_in_named(DEVICE(cpu[i]), leon3_start_cpu, 
"start_cpu", 1);
+        qdev_init_gpio_in_named(DEVICE(cpu[i]), leon3_set_pil_in, 
"pil", 1);
+        qdev_realize(DEVICE(cpu[i]), NULL, &error_fatal);
+        env = &cpu[i]->env;

          cpu_sparc_set_id(env, i);

-        /* Reset data */
-        reset_info->info[i].id = i;
-        reset_info->info[i].cpu = cpu;
-        qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
+        qemu_register_reset(leon3_cpu_reset, cpu[i]);
      }

      ahb_pnp = GRLIB_AHB_PNP(qdev_new(TYPE_GRLIB_AHB_PNP));
@@ -312,13 +295,12 @@ static void leon3_generic_hw_init(MachineState 
*machine)
      sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);

      for (i = 0; i < machine->smp.cpus; i++) {
-        cpu = reset_info->info[i].cpu;
-        env = &cpu->env;
+        env = &cpu[i]->env;
          qdev_connect_gpio_out_named(irqmpdev, "grlib-start-cpu", i,
-                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                    qdev_get_gpio_in_named(DEVICE(cpu[i]),
 
"start_cpu", 0));
          qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", i,
-                                    qdev_get_gpio_in_named(DEVICE(cpu),
+                                    qdev_get_gpio_in_named(DEVICE(cpu[i]),
                                                             "pil", 0));
          env->irq_manager = irqmpdev;
          env->qemu_irq_ack = leon3_irq_manager;
@@ -396,11 +378,6 @@ static void leon3_generic_hw_init(MachineState 
*machine)
               * bootloader.
               */
              write_bootloader(memory_region_get_ram_ptr(prom), entry);
-            reset_info->entry = LEON3_PROM_OFFSET;
-            for (i = 0; i < machine->smp.cpus; i++) {
-                reset_info->info[i].cpu->env.pc = LEON3_PROM_OFFSET;
-                reset_info->info[i].cpu->env.npc = LEON3_PROM_OFFSET + 4;
-            }
          }
      }
---

Regards,

Phil.

