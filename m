Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5E606A646
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRsa-0001fj-Rb; Wed, 21 Oct 2026 04:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xJRsU-0001fW-Oj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:40:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xJRsR-00012S-2N
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:40:54 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxKvCEethqLfkXAA--.4136S3;
 Wed, 21 Oct 2026 16:40:37 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxNs2BethqocIuAA--.18892S2;
 Wed, 21 Oct 2026 16:40:35 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Fix clock property name typo and
 order
To: way sorry <waysorrypub@gmail.com>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com
References: <cover.1791803914.git.waysorrypub@gmail.com>
 <8e36ee3baff3e6abef94cda37d564aeb690b161b.1791803914.git.waysorrypub@gmail.com>
 <7a2c2a6c-7ece-7e94-7216-6918558cda74@loongson.cn>
 <3c7bb90f-7b94-5d88-4f92-1b0d99c3d0e6@loongson.cn>
 <CAECqSzWofrjJgj14DB=dQOpJP-OQ5qBPM1mwJ--FKpC=g_zVTw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <8336d47b-28ab-a846-b57b-b56e483c86a9@loongson.cn>
Date: Wed, 21 Oct 2026 16:41:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAECqSzWofrjJgj14DB=dQOpJP-OQ5qBPM1mwJ--FKpC=g_zVTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxNs2BethqocIuAA--.18892S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF1xGryfXw1xCr18CrWrXrc_yoW7Wr1Dpr
 Z3tFWjyr98WFy8X3y0qw13GFyjvr1kt3Wjqr1xG3W5W3yYqr1SqF4avw42gFy7Zr4kAws0
 yr1YgF929Fs8AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Z2-UU
 UUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.387,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/18 下午10:36, way sorry wrote:
> Hi all,
> 
> Thanks for the comments. v2 drops `_CCA` from the UART and adds
> `_STA = 0x0f`. The expected DSDT blobs have been updated, and the
> 5 ACPI subtests pass.
> 
> On the DT side: with Linux 7.0, removing `clock-frequency` makes all
> 4 UARTs report `failed to get clock`, and the real driver fails to
> probe, so we are keeping the property for now. Logs:
> 
> [    0.702431] of_serial 1fe001e0.serial: error -ENOENT: failed to get clock
> [    0.702884] of_serial 1fe001e0.serial: probe with driver of_serial 
> failed with error -2
> [    0.703468] of_serial 1fe002e0.serial: error -ENOENT: failed to get clock
> [    0.703718] of_serial 1fe002e0.serial: probe with driver of_serial 
> failed with error -2
> [    0.704127] of_serial 1fe003e0.serial: error -ENOENT: failed to get clock
> [    0.704371] of_serial 1fe003e0.serial: probe with driver of_serial 
> failed with error -2
> [    0.704762] of_serial 1fe004e0.serial: error -ENOENT: failed to get clock
> [    0.705013] of_serial 1fe004e0.serial: probe with driver of_serial 
> failed with error -2
> 
> On the ACPI side: after removing it, all 4 UARTs still register, but
> `base_baud` changes from 6250000 to 115200. Logs:
> 
> With clock-frequency:
> [    0.813488] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq = 20, base_baud = 
> 6250000) is a 16550A
> Without clock-frequency:
> [    0.843528] 00:00: ttyS0 at MMIO 0x1fe001e0 (irq = 20, base_baud = 
> 115200) is a 16550A
> [    0.844663] printk: legacy console [ttyS0] enabled
> [    0.845209] printk: legacy bootconsole [uart0] disabled
> [    0.869343] 00:01: ttyS1 at MMIO 0x1fe002e0 (irq = 21, base_baud = 
> 115200) is a 16550A
> [    0.892556] 00:02: ttyS2 at MMIO 0x1fe003e0 (irq = 22, base_baud = 
> 115200) is a 16550A
> [    0.914867] 00:03: ttyS3 at MMIO 0x1fe004e0 (irq = 23, base_baud = 
> 115200) is a 16550A
> 
> The reason is that Linux provides a default clock of 1,843,200 Hz in
> `8250_pnp.c`, which matches the current QEMU UART model:
> 
> https://github.com/torvalds/linux/blob/028ef9c96e96197026887c0f092424679298aae8/drivers/tty/serial/8250/8250_pnp.c
> 
> So the property is optional under Linux ACPI, but that does not mean
> Linux does not use it.
> 
> So far I have only verified boot, UART registration, and console
> output. I have not tested other kernels or full TX/RX behavior. We
> would prefer to keep an explicit and accurate frequency description
> rather than rely on a kernel-specific default. But keeping the
> property does not mean keeping the current 100 MHz; the correct value
> still needs discussion.
so what is the suggested frequency from your side?
> 
> Questions: what is the advantage of omitting the ACPI clock property
> here? Is there any compatibility rationale from other guest OSes that
> supports omitting it?
Can you describe the detailed guest OS?  which cannot run in qemu-x86 
platform without ACPI clock property.

Regards
Bibo Mao
> 
> Thanks,
> pillow
> 
> On Thu, Oct 15, 2026 at 6:03 PM Bibo Mao <maobibo@loongson.cn 
> <mailto:maobibo@loongson.cn>> wrote:
> 
> 
> 
>     On 2026/10/15 下午2:57, Bibo Mao wrote:
>      >
>      >
>      > On 2026/10/12 下午7:39, pillow wrote:
>      >> The original code had a typo in the clock preperty name, and the
>      >> property name and frequency value were in reversed order.
>      >> According to the _DSD format rules, the property name string comes
>      >> first, followed by the property value:
>      >>
>     https://github.com/UEFI/DSD-Guide/blob/main/src/dsd-guide.adoc#data-format-definition
> 
>      >>
>      >>
>      >> Signed-off-by: pillow <waysorrypub@gmail.com
>     <mailto:waysorrypub@gmail.com>>
>      >> ---
>      >>   hw/loongarch/virt-acpi-build.c | 2 +-
>      >>   1 file changed, 1 insertion(+), 1 deletion(-)
>      >>
>      >> diff --git a/hw/loongarch/virt-acpi-build.c
>      >> b/hw/loongarch/virt-acpi-build.c
>      >> index 54965f0..4081730 100644
>      >> --- a/hw/loongarch/virt-acpi-build.c
>      >> +++ b/hw/loongarch/virt-acpi-build.c
>      >> @@ -336,8 +336,8 @@ static void build_uart_device_aml(Aml
>     *table, int
>      >> index)
>      >>                                     AML_SHARED, &uart_irq, 1));
>      >>       aml_append(dev, aml_name_decl("_CRS", crs));
>      >>       pkg0 = aml_package(0x2);
>      >> +    aml_append(pkg0, aml_string("clock-frequency"));
>      >>       aml_append(pkg0, aml_int(0x05F5E100));
>      >> -    aml_append(pkg0, aml_string("clock-frenquency"));
>      >>       pkg1 = aml_package(0x1);
>      >>       aml_append(pkg1, pkg0);
>      >>       pkg2 = aml_package(0x2);
>      >>
>      > Hi,
>      >
>      > yes, there is spelling issue with LoongArch virt machine UART acpi
>      > table. It seems that clock-frequency is not used by serial port.
>     is it
>      > possible to remove pkg0/pkg1/pkg2 property like ISA serial acpi
>     table
>      > defined in function serial_isa_build_aml()?
>      >
>      > Also "_CCA" property should be removed since the emulated serial
>     port
>      > does not support DMA, and add "_STA" property.
>     Also maybe property clock-frequency of uart fdt table in
>     fdt_add_uart_node() can be removed.
> 
>     Regards
>     Bibo Mao
>      >
>      > Regards
>      > Bibo Mao
> 


