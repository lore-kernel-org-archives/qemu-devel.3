Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5EDEA8549
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 23:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzNF9-0008IY-RK; Sun, 08 Mar 2026 19:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNF8-0008I9-4n
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:09:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNF6-0008A6-DR
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AqeSfDh5QlhdWUEYShzCdR52V/Dc0oQIKl4CE34MReQ=; b=0ywHZ8P6I+c65aF+I0seTxbIAf
 3S21d0cyEFmPCLMQ/Gj7NQtN0u/fg7aknEDTvltbByXpT64OqqRzgkI2q3FILByI7Sfr7AQBS/bUH
 nepcbDw6ctCFsI0QDvUhQZXOKrDp8+LDosfrN0b/vCF3O6laMraVm6bQT4eWd0LKkqMbmW7SZCcvc
 bQ9UBxgJj0Srv4ScK8UDIewGVQfWDX3PW53D60zjxJO73rBCO4pnS/ndtWvUGIA0UJoAFmcVIV8V1
 KDakeR46lP2/3FsGcB9DWDED1/SsYAeN062GMjo+eUFeiKx9uTLf3ntFBWOFiXWcd1SwFtjssQN1L
 tdJwwoWZGLlATxD1CCPOlnQCYXLW+EGAyxM5MGEQzyKwztVHL2UX2/2LcRQJRQudw6y/NGSScFpj3
 MBygZcpgOsAzMaTRwBjs+Z2wFmRtrfwAmaJz/NJJjsDE5aYevu3OXnPsdr7uzeZaavDnvlVGniKOw
 r3ZHBr5xi104tjsZumn84V7W747uOMihTJwok3Np/TOe2fJu1mmhtv6OyG2hKHxKQ0Asn5FQnE614
 zpDYgSgWMLdZAdGzyEud6HOorQiwRFidVJKd+4EFgX9lgWdzddJh29XI0lZIN2Y/yCuRE3w/AMScb
 AM4Xud4TLxsaqlEO0/d8Nz6yWPCIt2P7L0Vh23AY0=;
Received: from [2a02:8012:2f01:0:853d:6c6b:2689:bc0e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNC9-0004m9-Or; Sun, 08 Mar 2026 23:06:01 +0000
Message-ID: <28970d39-7284-4ed8-a942-34d7c930681a@ilande.co.uk>
Date: Sun, 8 Mar 2026 23:08:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
 <20260307112931.3322532-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260307112931.3322532-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:853d:6c6b:2689:bc0e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/3] hw/sparc/sun4m: Use qdev GPIOs rather than
 qemu_allocate_irqs()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 07/03/2026 11:29, Peter Maydell wrote:

> In the sun4m machine creation code, we currently use qemu_allocate_irqs()
> to set up the IRQ lines that act as the inbound IRQ lines to the CPUs.
> This results in a memory leak:
> 
> Direct leak of 128 byte(s) in 1 object(s) allocated from:
>      #0 0x5a23c1281ec3 in malloc (/home/pm215/qemu/build/sparc-san/qemu-system-sparc+0xdf1ec3) (BuildId: e6aa10be01feb5524656dd083997bc82b85e3e93)
>      #1 0x79e8f78f0ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5a23c1a94e54 in qemu_extend_irqs /home/pm215/qemu/build/sparc-san/../../hw/core/irq.c:77:51
>      #3 0x5a23c1a39e03 in cpu_devinit /home/pm215/qemu/build/sparc-san/../../hw/sparc/sun4m.c:802:17
>      #4 0x5a23c1a39e03 in sun4m_hw_init /home/pm215/qemu/build/sparc-san/../../hw/sparc/sun4m.c:838:9
> 
> The leak is unimportant as it is a "once at startup" leak, but
> fixing it helps in getting a clean leak-sanitizer test run.
> 
> Switch the sun4m code to handle CPU interrupt lines in the same way
> as the leon3 machine does: the machine init code uses
> qdev_init_gpio_in to create GPIO lines on the CPU objects.  This is a
> little bit odd as ideally the CPU would do that itself, but for these
> 32-bit SPARC machines the machine and the CPU are very closely
> coupled already (the functions handling the IRQ lines modify data
> fields inside the CPU).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/sparc/sun4m.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 29bc26ebcb..b9f8236be5 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -341,7 +341,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
>   static DeviceState *slavio_intctl_init(hwaddr addr,
>                                          hwaddr addrg,
>                                          unsigned int smp_cpus,
> -                                       qemu_irq **parent_irq)
> +                                       DeviceState **cpus)
>   {
>       DeviceState *dev;
>       SysBusDevice *s;
> @@ -354,7 +354,8 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
>   
>       for (i = 0; i < smp_cpus; i++) {
>           for (j = 0; j < MAX_PILS; j++) {
> -            sysbus_connect_irq(s, i * MAX_PILS + j, parent_irq[i][j]);
> +            sysbus_connect_irq(s, i * MAX_PILS + j,
> +                               qdev_get_gpio_in_named(cpus[i], "pil", j));
>           }
>       }
>       sysbus_mmio_map(s, 0, addrg);
> @@ -785,22 +786,25 @@ static const TypeInfo ram_info = {
>       .class_init    = ram_class_init,
>   };
>   
> -static void cpu_devinit(const char *cpu_type, unsigned int id,
> -                        uint64_t prom_addr, qemu_irq **cpu_irqs)
> +static DeviceState *cpu_devinit(const char *cpu_type, unsigned int id,
> +                                uint64_t prom_addr)
>   {
>       SPARCCPU *cpu;
>       CPUSPARCState *env;
> +    DeviceState *cpudev;
>   
>       cpu = SPARC_CPU(object_new(cpu_type));
>       env = &cpu->env;
> +    cpudev = DEVICE(cpu);
>   
>       qemu_register_reset(sun4m_cpu_reset, cpu);
>       object_property_set_bool(OBJECT(cpu), "start-powered-off", id != 0,
>                                &error_abort);
> -    qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
> +    qdev_init_gpio_in_named(cpudev, cpu_set_irq, "pil", MAX_PILS);
> +    qdev_realize_and_unref(cpudev, NULL, &error_fatal);
>       cpu_sparc_set_id(env, id);
> -    *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
>       env->prom_addr = prom_addr;
> +    return cpudev;
>   }
>   
>   static void dummy_fdc_tc(void *opaque, int irq, int level)
> @@ -813,13 +817,14 @@ static void sun4m_hw_init(MachineState *machine)
>       DeviceState *slavio_intctl;
>       unsigned int i;
>       Nvram *nvram;
> -    qemu_irq *cpu_irqs[MAX_CPUS], slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
> +    qemu_irq slavio_irq[32], slavio_cpu_irq[MAX_CPUS];
>       qemu_irq fdc_tc;
>       unsigned long kernel_size;
>       uint32_t initrd_size;
>       DriveInfo *fd[MAX_FD];
>       FWCfgState *fw_cfg;
>       DeviceState *dev, *ms_kb_orgate, *serial_orgate;
> +    DeviceState *cpus[MAX_CPUS];
>       SysBusDevice *s;
>       unsigned int smp_cpus = machine->smp.cpus;
>       unsigned int max_cpus = machine->smp.max_cpus;
> @@ -835,7 +840,7 @@ static void sun4m_hw_init(MachineState *machine)
>   
>       /* init CPUs */
>       for(i = 0; i < smp_cpus; i++) {
> -        cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
> +        cpus[i] = cpu_devinit(machine->cpu_type, i, hwdef->slavio_base);
>       }
>   
>       /* Create and map RAM frontend */
> @@ -855,7 +860,7 @@ static void sun4m_hw_init(MachineState *machine)
>       slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
>                                          hwdef->intctl_base + 0x10000ULL,
>                                          smp_cpus,
> -                                       cpu_irqs);
> +                                       cpus);
>   
>       for (i = 0; i < 32; i++) {
>           slavio_irq[i] = qdev_get_gpio_in(slavio_intctl, i);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


