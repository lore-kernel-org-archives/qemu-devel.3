Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D29C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1siP-0001bL-JZ; Tue, 30 Apr 2024 15:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1siG-0001Vm-79
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:00:27 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1siE-0008Bl-46
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:00:23 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51dc5c0ffdbso3017172e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714503620; x=1715108420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/WojhfZdmUedf8K4tVSS5CFnyf5yCb3p3+Wl9G3u2pI=;
 b=GjpowHyFHdMZBPElB0e4pC0+DPEltd14Acg7Lvvwf/uLo4RybLyVjsN/IpmhuiJFQH
 Akzf+224nfdvWg9p40DFj/oBZeUkLjK62mvA4l277wCM1Xv3By8kXPRtY4YiP6Ew/j2I
 +kjSNquvWTDb3km+q8FUWsY4I2gJs1CcuxPFX2LMoUaV+nRvyoaW5G0LuAjhaCyROsnK
 JpcFImd11+cumPxoo3oYio0xcEkieQD7aXrqCPZvFtOr6C9eLYkWhofbEmQeE8LFpSu9
 hmz5OBqSXGBOJqh238GFt8haSTLYjbqp0mT2hNTk8twCNi7NEnOi8fyHle7DTGFKgxE+
 fyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714503620; x=1715108420;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/WojhfZdmUedf8K4tVSS5CFnyf5yCb3p3+Wl9G3u2pI=;
 b=XlCE0ff5PKo3604SiAGstykBLofrEDqh/ol7SZLDP8/uo092Vqx9GefNkp75Zwmnm0
 6k1ChLFjK+ECaJkJcvbRn3jnbtc865HqKmIxVb73Dw32hpN6HN0MAiRu2kcaMOXNaWPx
 2ekLXxjY8Yvl0JeGPawPsH7K8PxUXU6QMd/X9l17pfA3+41KKOuYuhPTydG6XBqWCJ2Q
 h+VDRM0Vw8lDuxSZo4TfZoZFmIIgeFYaJ5qZnGaDlmKMtlR+YuPUK4QPtMDYjOTkFw+O
 mLwrtS+4rt9folLEuP0cC5LEgSVlmhT98rK+kwgiwFmGhLZ8zay9FdVPf1j+L7iXwcU/
 tHrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkyGD1mU1YNXWZEHhpxynpXCe1zpNzWDZHny4CydP2sFvODx0PpV3S0JSQ0CHOjlRFB1OWSuW1blrGWJQZ9Y0hlL0OCHE=
X-Gm-Message-State: AOJu0YxzY83bYQr7im7r+Ot7qYk7x+x2BKOwOnYUD4HKsqFZ/SRE5pq+
 hA0h+aW5LxCHIWM08/Sw4sQlRSQFOF1ifjBRB44Q/WE20yzyKL09U37b9lWV1Es=
X-Google-Smtp-Source: AGHT+IG/7BJjevR2iLXCtyxAoCjDs4wosGMk8XzW3nmF+QLxm34v/n6bOlKMeh4ONOFhGXEKAQ20hw==
X-Received: by 2002:a19:c207:0:b0:51d:f5c7:309e with SMTP id
 l7-20020a19c207000000b0051df5c7309emr222833lfc.22.1714503620015; 
 Tue, 30 Apr 2024 12:00:20 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 gc24-20020a170906c8d800b00a58f3983635sm3749698ejb.50.2024.04.30.12.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 12:00:19 -0700 (PDT)
Message-ID: <90e4b6c6-2bc4-4f4a-ac65-8141c2eb4cb5@linaro.org>
Date: Tue, 30 Apr 2024 21:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] exec: Rework around CPUState user fields (part 2)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
 <363wwielvdpy37h7cqo7jo5luyys2aqmfgeb4t3wypsb3myqxg@kvasyjy4e767>
 <2a5e3a10-cc9a-44ff-8241-484d17b1f9cb@linaro.org>
Content-Language: en-US
In-Reply-To: <2a5e3a10-cc9a-44ff-8241-484d17b1f9cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 30/4/24 20:45, Philippe Mathieu-Daudé wrote:
> Hi Ilya,
> 
> On 30/4/24 19:55, Ilya Leoshkevich wrote:
>> On Tue, Apr 30, 2024 at 02:27:54PM +0200, Philippe Mathieu-Daudé wrote:
>>> Missing WASM testing by Ilya (branch available at
>>> https://gitlab.com/philmd/qemu/-/commits/tcg_flush_jmp_cache)
>>
>> Hmm, it dies very early now:
>>
>>    # gdb --args ./qemu-s390x -L /usr/s390x-linux-gnu 
>> /build/wasmtime/target/s390x-unknown-linux-gnu/debug/deps/component_fuzz_util-d10a3a6b4ad8af47
>>
>>    Thread 1 "qemu-s390x" received signal SIGSEGV, Segmentation fault.
>>    0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0, 
>> errp=<optimized out>) at 
>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>>    217             cpu->accel->plugin_state = 
>> qemu_plugin_create_vcpu_state();
>>
>>    (gdb) bt
>>    #0  0x000055555559b718 in cpu_common_realizefn (dev=0x5555557c28c0, 
>> errp=<optimized out>) at 
>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:217
>>    #1  0x000055555559f59a in s390_cpu_realizefn (dev=0x5555557c28c0, 
>> errp=0x7fffffffe1a0) at ../home/iii/myrepos/qemu/target/s390x/cpu.c:284
>>    #2  0x000055555563f76b in device_set_realized (obj=<optimized out>, 
>> value=<optimized out>, errp=0x7fffffffe2e0) at 
>> ../home/iii/myrepos/qemu/hw/core/qdev.c:510
>>    #3  0x000055555564363d in property_set_bool (obj=0x5555557c28c0, 
>> v=<optimized out>, name=<optimized out>, opaque=0x5555557a9140, 
>> errp=0x7fffffffe2e0) at ../home/iii/myrepos/qemu/qom/object.c:2362
>>    #4  0x0000555555646b9b in object_property_set 
>> (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 
>> "realized", v=v@entry=0x5555557c6650, errp=errp@entry=0x7fffffffe2e0)
>>        at ../home/iii/myrepos/qemu/qom/object.c:1471
>>    #5  0x000055555564a43f in object_property_set_qobject 
>> (obj=obj@entry=0x5555557c28c0, name=name@entry=0x5555556e8ae2 
>> "realized", value=value@entry=0x5555557a7a90, 
>> errp=errp@entry=0x7fffffffe2e0)
>>        at ../home/iii/myrepos/qemu/qom/qom-qobject.c:28
>>    #6  0x0000555555647204 in object_property_set_bool 
>> (obj=0x5555557c28c0, name=name@entry=0x5555556e8ae2 "realized", 
>> value=value@entry=true, errp=errp@entry=0x7fffffffe2e0)
>>        at ../home/iii/myrepos/qemu/qom/object.c:1541
>>    #7  0x000055555564025c in qdev_realize (dev=<optimized out>, 
>> bus=bus@entry=0x0, errp=errp@entry=0x7fffffffe2e0) at 
>> ../home/iii/myrepos/qemu/hw/core/qdev.c:291
>>    #8  0x000055555559bbb4 in cpu_create (typename=<optimized out>) at 
>> ../home/iii/myrepos/qemu/hw/core/cpu-common.c:61
>>    #9  0x000055555559a467 in main (argc=4, argv=0x7fffffffeaa8, 
>> envp=<optimized out>) at ../home/iii/myrepos/qemu/linux-user/main.c:811
>>
>>    (gdb) p cpu
>>    $1 = (CPUState *) 0x5555557c28c0
>>    (gdb) p cpu->accel
>>    $2 = (AccelCPUState *) 0x0
>>
>> Configured with: '/home/iii/myrepos/qemu/configure' 
>> '--target-list=s390x-linux-user' '--disable-tools' '--disable-slirp' 
>> '--disable-fdt' '--disable-capstone' '--disable-docs'
>>
>> If you don't see what can be wrong here right away, I can debug this.

I added this commit in the same branch:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue Apr 30 20:57:15 2024 +0200

     accel/tcg: Initialize TCG plugins in cpu-target.c

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/cpu-target.c b/cpu-target.c
index 5af120e8aa..585533cfa3 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -46,6 +46,10 @@
  #include "hw/core/accel-cpu.h"
  #include "trace/trace-root.h"
  #include "qemu/accel.h"
+#ifdef CONFIG_PLUGIN
+#include "accel/tcg/vcpu-state.h"
+#include "qemu/plugin.h"
+#endif

  #ifndef CONFIG_USER_ONLY
  static int cpu_common_post_load(void *opaque, int version_id)
@@ -131,6 +135,13 @@ const VMStateDescription vmstate_cpu_common = {
  };
  #endif

+#ifdef CONFIG_PLUGIN
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data 
unused)
+{
+    qemu_plugin_vcpu_init_hook(cpu);
+}
+#endif
+
  bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
  {
      /* cache the cpu class for the hotpath */
@@ -143,6 +154,15 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
      /* Wait until cpu initialization complete before exposing cpu. */
      cpu_list_add(cpu);

+#ifdef CONFIG_PLUGIN
+    assert(cpu->accel);
+    /* Plugin initialization must wait until the cpu start executing 
code */
+    if (tcg_enabled()) {
+        cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();
+        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, 
RUN_ON_CPU_NULL);
+    }
+#endif
+
  #ifdef CONFIG_USER_ONLY
      assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
             qdev_get_vmsd(DEVICE(cpu))->unmigratable);
@@ -171,6 +191,13 @@ void cpu_exec_unrealizefn(CPUState *cpu)
      }
  #endif

+#ifdef CONFIG_PLUGIN
+    /* Call the plugin hook before clearing the cpu is fully unrealized */
+    if (tcg_enabled()) {
+        qemu_plugin_vcpu_exit_hook(cpu);
+    }
+#endif
+
      cpu_list_remove(cpu);
      /*
       * Now that the vCPU has been removed from the RCU list, we can call
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e03d31876f..cd8bd99131 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -30,10 +30,6 @@
  #include "hw/boards.h"
  #include "hw/qdev-properties.h"
  #include "trace.h"
-#ifdef CONFIG_PLUGIN
-#include "accel/tcg/vcpu-state.h"
-#include "qemu/plugin.h"
-#endif

  CPUState *cpu_by_arch_id(int64_t id)
  {
@@ -181,13 +177,6 @@ static void cpu_common_parse_features(const char 
*typename, char *features,
      }
  }

-#ifdef CONFIG_PLUGIN
-static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data 
unused)
-{
-    qemu_plugin_vcpu_init_hook(cpu);
-}
-#endif
-
  static void cpu_common_realizefn(DeviceState *dev, Error **errp)
  {
      CPUState *cpu = CPU(dev);
@@ -211,14 +200,6 @@ static void cpu_common_realizefn(DeviceState *dev, 
Error **errp)
          cpu_resume(cpu);
      }

-    /* Plugin initialization must wait until the cpu start executing 
code */
-#ifdef CONFIG_PLUGIN
-    if (tcg_enabled()) {
-        cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();
-        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, 
RUN_ON_CPU_NULL);
-    }
-#endif
-
      /* NOTE: latest generic point where the cpu is fully realized */
  }

@@ -226,13 +207,6 @@ static void cpu_common_unrealizefn(DeviceState *dev)
  {
      CPUState *cpu = CPU(dev);

-    /* Call the plugin hook before clearing the cpu is fully unrealized */
-#ifdef CONFIG_PLUGIN
-    if (tcg_enabled()) {
-        qemu_plugin_vcpu_exit_hook(cpu);
-    }
-#endif
-
      /* NOTE: latest generic point before the cpu is fully unrealized */
      cpu_exec_unrealizefn(cpu);
  }
---

Totally untested here because it is late (only built...).

