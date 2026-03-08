Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAE0EA8549
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 23:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzNDz-0007CE-VE; Sun, 08 Mar 2026 19:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNDx-0007Bw-W9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:07:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNDw-00087x-BZ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Ii6yX2+1ACPZVmoh3EuqMeVk0q1w4Zd90bUfdIQjVEs=; b=ctf34xejO/fmwXVnAUy2DA7ksY
 NRlm0QAjaOv1rOuASVUK92Tw+KL165rw/86RNjJseEkA5d8dLFN2j+h6eDXWAJ6kg+XiAU5J4HPVw
 DMspllLARK//KsxYce6HjxmahvjvBWqBdc+V9Rj19CtAgnGHsCvnTKM5F2lmepfA0tc+rBlC4eELV
 dNjEUQ5Ufx6EI8+KFXRBi9IACnsf+gZY7Urq7qlmE6KSMFJHXXzug5dmmiMvtdV/6J+Dj6IBJrAY7
 cHPr7kIZFE7yD7q+YCDpRE/cFTMV8bRQ5XE0NEaeKB5wKinyC9Mi2q6KV/Eb23fV+6GeX98H6P0Tp
 oUw45kZ0NVvvbomNmywVRDIdcjw/lFXvv0X6i6VW0spIcnw3G0jBQiCAHoT8Vq8Ceowbs1M05ch67
 n+h2xujrmwLq1GKhouVbQvoq1zb+Rjl27PbwaovKwt3KgjHscCSvx00VgCJ7xy7I7gI4MubHi+aUm
 quFoLD/0RoawUIWwcMkrbYmsmlRu4R4HSPLY94RZ30fxCvuYjbHyiDmsbAKr24C13x4Zbh5XD4DMC
 hzibklIsDv0mjc4WO13++O1vbC57W0mkx9dz1Sb8YorSLqpjQKraHzPi6tWiYRwWrTUPBA19WvqzN
 DWqqKg3Dpbs28dX16Ml//ZwxUqWuHbo5NT9YaVt/E=;
Received: from [2a02:8012:2f01:0:853d:6c6b:2689:bc0e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNB1-0004lS-UX; Sun, 08 Mar 2026 23:04:48 +0000
Message-ID: <8bf3c2c3-efbb-468f-bbd3-571aaf468bd6@ilande.co.uk>
Date: Sun, 8 Mar 2026 23:07:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
 <20260307112931.3322532-2-peter.maydell@linaro.org>
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
In-Reply-To: <20260307112931.3322532-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:853d:6c6b:2689:bc0e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/3] hw/sparc/sun4m: Don't set up dummy cpu interrupts
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

> In the sun4m machine init, we set up the cpu_irqs[] array
> with the real inbound IRQs for each CPU, followed by some
> dummy IRQs for the remaining slots from smp_cpus up to
> MAX_CPUS. These dummy IRQs do nothing when set/cleared
> because the dummy_cpu_set_irq() function does nothing.
> 
> Instead of creating these "do nothing" qemu_irqs, instead
> pass the number of CPUs to slavio_intctl_init() so that it
> can only wire up the interrupt controller's interrupts
> for the CPUs that actually exist. Calling qemu_set_irq()
> on an irq that isn't connected does nothing, so this is
> a simpler way to achieve the same result.
> 
> This cleanup fixes an unimportant memory leak reported by
> the address sanitizer that happens because we allocate these
> dummy IRQs with qemu_allocate_irqs():
> 
> Direct leak of 1920 byte(s) in 15 object(s) allocated from:
>      #0 0x5cb7b120cf63 in malloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0bf63) (BuildId: d27f9230a7cc82ebfaf0cf9e439dc215ddd7ac68)
>      #1 0x743cd6dc5ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5cb7b1a42fb4 in qemu_extend_irqs /home/pm215/qemu/build/san/../../hw/core/irq.c:77:51
>      #3 0x5cb7b19e7e72 in sun4m_hw_init /home/pm215/qemu/build/san/../../hw/sparc/sun4m.c:845:23
>      #4 0x5cb7b141d3dd in machine_run_board_init /home/pm215/qemu/build/san/../../hw/core/machine.c:1709:5
>      #5 0x5cb7b1542895 in qemu_init_board /home/pm215/qemu/build/san/../../system/vl.c:2717:5
>      #6 0x5cb7b1542895 in qmp_x_exit_preconfig /home/pm215/qemu/build/san/../../system/vl.c:2811:5
>      #7 0x5cb7b15493ac in qemu_init /home/pm215/qemu/build/san/../../system/vl.c:3849:9
>      #8 0x5cb7b1f3f201 in main /home/pm215/qemu/build/san/../../system/main.c:71:5
>      #9 0x743cd4a2a1c9 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>      #10 0x743cd4a2a28a in __libc_start_main csu/../csu/libc-start.c:360:3
>      #11 0x5cb7b1172114 in _start (/home/pm215/qemu/build/san/qemu-system-sparc+0xd71114) (BuildId: d27f9230a7cc82ebfaf0cf9e439dc215ddd7ac68)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/sparc/sun4m.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index a17bdb3692..29bc26ebcb 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -196,10 +196,6 @@ static void cpu_set_irq(void *opaque, int irq, int level)
>       }
>   }
>   
> -static void dummy_cpu_set_irq(void *opaque, int irq, int level)
> -{
> -}
> -
>   static void sun4m_cpu_reset(void *opaque)
>   {
>       SPARCCPU *cpu = opaque;
> @@ -344,6 +340,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
>   
>   static DeviceState *slavio_intctl_init(hwaddr addr,
>                                          hwaddr addrg,
> +                                       unsigned int smp_cpus,
>                                          qemu_irq **parent_irq)
>   {
>       DeviceState *dev;
> @@ -355,7 +352,7 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
>       s = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(s, &error_fatal);
>   
> -    for (i = 0; i < MAX_CPUS; i++) {
> +    for (i = 0; i < smp_cpus; i++) {
>           for (j = 0; j < MAX_PILS; j++) {
>               sysbus_connect_irq(s, i * MAX_PILS + j, parent_irq[i][j]);
>           }
> @@ -841,9 +838,6 @@ static void sun4m_hw_init(MachineState *machine)
>           cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
>       }
>   
> -    for (i = smp_cpus; i < MAX_CPUS; i++)
> -        cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
> -
>       /* Create and map RAM frontend */
>       dev = qdev_new("memory");
>       object_property_set_link(OBJECT(dev), "memdev", OBJECT(ram_memdev), &error_fatal);
> @@ -860,6 +854,7 @@ static void sun4m_hw_init(MachineState *machine)
>   
>       slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
>                                          hwdef->intctl_base + 0x10000ULL,
> +                                       smp_cpus,
>                                          cpu_irqs);
>   
>       for (i = 0; i < 32; i++) {

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


