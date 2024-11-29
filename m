Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA6D6EBE0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGv3b-00065e-ES; Fri, 29 Nov 2024 02:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1tGv3W-00065L-Cy
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:04:46 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1tGv3S-0004Fl-6V
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:04:46 -0500
Received: from loongson.cn (unknown [10.20.42.126])
 by gateway (Coremail) with SMTP id _____8AxbeJ4Z0ln+V1LAA--.15520S3;
 Fri, 29 Nov 2024 15:04:24 +0800 (CST)
Received: from [10.20.42.126] (unknown [10.20.42.126])
 by front1 (Coremail) with SMTP id qMiowMDxvkd1Z0lngKRsAA--.48099S3;
 Fri, 29 Nov 2024 15:04:23 +0800 (CST)
Subject: Re: [PATCH v4 0/6] hw/loongarch/virt: Add cpu hotplug support
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20241112021738.1952851-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <633e93eb-cc99-58e8-74c0-6977c6dd2e19@loongson.cn>
Date: Fri, 29 Nov 2024 15:02:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241112021738.1952851-1-maobibo@loongson.cn>
Content-Type: multipart/alternative;
 boundary="------------C8EAE0B8CF490B1EE69F4675"
Content-Language: en-US
X-CM-TRANSID: qMiowMDxvkd1Z0lngKRsAA--.48099S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4fKryxGrW8Wryxtw13Awc_yoWrXr4rpr
 WIyF15KryDGr97Aw1fJ3WrZF9Ygr1kGa12qas3AryIkw4UWr1Yvr1Syr909F45u3yvqF4r
 Zr15Kr1j9a15ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAF
 F20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r
 1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAF
 wI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67
 AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAv7VC0I7IYx2IY67AKxVWUGVWUXw
 Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0
 xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUGVWUWwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
 ZFpf9x07UAWrXUUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-3.164, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------C8EAE0B8CF490B1EE69F4675
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello everyone, I have a question about cpu hotplug to consult you.

When I start qemu with the following parameters:
/usr/bin/qemu-system-loongarch64 \
-machine virt  \
-accel tcg \
-bios /usr/share/edk2/loongarch64/QEMU_EFI.fd \
-m size=1048576k \
-smp 1,maxcpus=4,cores=1,threads=1,sockets=4  \
-nographic \
-monitor telnet:localhost:4444,server,nowait \
-incoming tcp:0:6666 \
-serial stdio

The virtual machine is not running directly and is in the migration state,
At this point I insert a cpu using the following command:
telnet 127.0.0.1 4444
(qemu)  device_add 
la464-loongarch-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu-1

I found that the ged device sends an interrupt signal to the interrupt 
controller,
My understanding is that the current machine is not in the running state,
whether the ged device should send interrupt signal in this state?

The "current_run_state" is  RUN_STATE_INMIGRATE,
And The "machine_phase" is PHASE_MACHINE_READY in qemu.

So do we need to add a conditional on current_run_state to the 
acpi_cpu_plug_cb function?
For example:

@@ -258,7 +258,8 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
      }

      cdev->cpu = CPU(dev);
-    if (dev->hotplugged) {
+    if (dev->hotplugged &&
+        runstate_check(RUN_STATE_RUNNING)) {
          cdev->is_inserting = true;
          acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
      }


> LoongArch cpu hotplug is based on ACPI GED device, there is a little
> change about ipi and extioi device, the value of num-cpu property is
> maximum cpu number rather than present cpu number.
>
> It can be verified with qemu command:
>    qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
> and vcpu can be added or remove with hmp command:
>    device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
>    device_del cpu-2
>
> ---
> v3 ... v4:
>    1. For cold-plug CPUs, move socket-id/core-id/thread-id property
>       setting from preplug function to CPU object creating loop, since
>       there is topo information calculation already in CPU object creating
>       loop.
>    2. Init interrupt pin of CPU object in cpu plug interface for both
>       cold-plug CPUs and hot-plug CPUs.
>    3. Apply the patch based on latest qemu version.
>
> v2 ... v3:
>    1. Use qdev_realize_and_unref() with qdev_realize() and object_unref().
>    2. Set vcpus_count with 1 since vcpu object is created for every thread.
>    3. Remove property hw-id, use internal variable hw_id to differentiate
>       cold-plug cpus and hot-plug cpus.
>    4. Add generic function virt_init_cpu_irq() to init interrupt pin
>       of CPU object, used by both cold-plug and hot-plug CPUs
>
> v1 ... v2:
>    1. Add new property hw-id, property hw-id is set for cold-added CPUs,
>       and property socket-id/core-id/thread-id is set for hot-added CPUs.
>       The two properties can be generated from each other.
>    2. Use general hotplug api such as hotplug_handler_pre_plug etc
>    3. Reorganize the patch order, split the patch set into 4 small
>       patches.
> ---
> Bibo Mao (6):
>    hw/loongarch/virt: Add CPU topology support
>    hw/loongarch/virt: Implement cpu plug interface
>    hw/loongarch/virt: Add generic function to init interrupt pin of CPU
>    hw/loongarch/virt: Init interrupt pin of CPU during plug interface
>    hw/loongarch/virt: Update the ACPI table for hotplug cpu
>    hw/loongarch/virt: Enable cpu hotplug feature on virt machine
>
>   docs/system/loongarch/virt.rst |  31 +++
>   hw/loongarch/Kconfig           |   1 +
>   hw/loongarch/acpi-build.c      |  35 ++-
>   hw/loongarch/virt.c            | 374 ++++++++++++++++++++++++++++-----
>   include/hw/loongarch/virt.h    |   3 +
>   target/loongarch/cpu.c         |  25 +++
>   target/loongarch/cpu.h         |  17 ++
>   7 files changed, 428 insertions(+), 58 deletions(-)
>
>
> base-commit: 134b443512825bed401b6e141447b8cdc22d2efe


--------------C8EAE0B8CF490B1EE69F4675
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hello everyone, I have a question about cpu hotplug to consult you.<br>
    <br>
    When I start qemu with the following parameters:<br>
    /usr/bin/qemu-system-loongarch64 \<br>
    -machine virt  \<br>
    -accel tcg \<br>
    -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd \<br>
    -m size=1048576k \<br>
    -smp 1,maxcpus=4,cores=1,threads=1,sockets=4  \<br>
    -nographic \<br>
    -monitor telnet:localhost:4444,server,nowait \<br>
    -incoming tcp:0:6666 \<br>
    -serial stdio<br>
    <br>
    The virtual machine is not running directly and is in the migration
    state,<br>
    At this point I insert a cpu using the following command:<br>
    telnet 127.0.0.1 4444<br>
    (qemu)  device_add
    la464-loongarch-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu-1 <br>
    <br>
    I found that the ged device sends an interrupt signal to the
    interrupt controller,<br>
    My understanding is that the current machine is not in the running
    state, <br>
    whether the ged device should send interrupt signal in this state?<br>
    <br>
    The "current_run_state" is  RUN_STATE_INMIGRATE,<br>
    And The "machine_phase" is PHASE_MACHINE_READY in qemu.<br>
    <br>
    So do we need to add a conditional on current_run_state to the
    acpi_cpu_plug_cb function?<span style="color: rgb(90, 117, 224);
      font-family: PingFangSC-Regular, &quot;Microsoft YaHei&quot;,
      Segoe UI Variable Static Display; font-size: 16px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space:
      normal; background-color: rgb(255, 255, 255);
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><br>
    </span>For example:<br>
    <br>
    @@ -258,7 +258,8 @@ void acpi_cpu_plug_cb(HotplugHandler
    *hotplug_dev,<br>
         }<br>
     <br>
         cdev-&gt;cpu = CPU(dev);<br>
    -    if (dev-&gt;hotplugged) {<br>
    +    if (dev-&gt;hotplugged &amp;&amp;<br>
    +        runstate_check(RUN_STATE_RUNNING)) {<br>
             cdev-&gt;is_inserting = true;<br>
             acpi_send_event(DEVICE(hotplug_dev),
    ACPI_CPU_HOTPLUG_STATUS);<br>
         }<br>
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:20241112021738.1952851-1-maobibo@loongson.cn">
      <pre class="moz-quote-pre" wrap="">LoongArch cpu hotplug is based on ACPI GED device, there is a little
change about ipi and extioi device, the value of num-cpu property is
maximum cpu number rather than present cpu number.

It can be verified with qemu command:
  qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
and vcpu can be added or remove with hmp command:
  device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
  device_del cpu-2

---
v3 ... v4:
  1. For cold-plug CPUs, move socket-id/core-id/thread-id property
     setting from preplug function to CPU object creating loop, since
     there is topo information calculation already in CPU object creating
     loop.
  2. Init interrupt pin of CPU object in cpu plug interface for both
     cold-plug CPUs and hot-plug CPUs.
  3. Apply the patch based on latest qemu version.

v2 ... v3:
  1. Use qdev_realize_and_unref() with qdev_realize() and object_unref().
  2. Set vcpus_count with 1 since vcpu object is created for every thread.
  3. Remove property hw-id, use internal variable hw_id to differentiate
     cold-plug cpus and hot-plug cpus.
  4. Add generic function virt_init_cpu_irq() to init interrupt pin
     of CPU object, used by both cold-plug and hot-plug CPUs

v1 ... v2:
  1. Add new property hw-id, property hw-id is set for cold-added CPUs,
     and property socket-id/core-id/thread-id is set for hot-added CPUs.
     The two properties can be generated from each other.
  2. Use general hotplug api such as hotplug_handler_pre_plug etc
  3. Reorganize the patch order, split the patch set into 4 small
     patches.
---
Bibo Mao (6):
  hw/loongarch/virt: Add CPU topology support
  hw/loongarch/virt: Implement cpu plug interface
  hw/loongarch/virt: Add generic function to init interrupt pin of CPU
  hw/loongarch/virt: Init interrupt pin of CPU during plug interface
  hw/loongarch/virt: Update the ACPI table for hotplug cpu
  hw/loongarch/virt: Enable cpu hotplug feature on virt machine

 docs/system/loongarch/virt.rst |  31 +++
 hw/loongarch/Kconfig           |   1 +
 hw/loongarch/acpi-build.c      |  35 ++-
 hw/loongarch/virt.c            | 374 ++++++++++++++++++++++++++++-----
 include/hw/loongarch/virt.h    |   3 +
 target/loongarch/cpu.c         |  25 +++
 target/loongarch/cpu.h         |  17 ++
 7 files changed, 428 insertions(+), 58 deletions(-)


base-commit: 134b443512825bed401b6e141447b8cdc22d2efe
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------C8EAE0B8CF490B1EE69F4675--


