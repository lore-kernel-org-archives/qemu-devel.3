Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C750EC48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 04:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWThi-00030S-6a; Sat, 03 Feb 2024 23:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rWThg-00030K-DE
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 23:02:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rWThd-0002Xb-QO
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 23:02:00 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxmfAtDL9l0oIKAA--.30369S3;
 Sun, 04 Feb 2024 12:01:50 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxhcwpDL9lKikvAA--.9316S2; 
 Sun, 04 Feb 2024 12:01:47 +0800 (CST)
Subject: Re: [PATCH] loongarch: Change the UEFI loading mode to loongarch
From: lixianglai <lixianglai@loongson.cn>
To: maobibo <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn
References: <20240204015430.162509-1-lixianglai@loongson.cn>
 <aa9a0f88-9ce0-2356-b518-906d663fd8b7@loongson.cn>
 <423629fb-f8e2-e4ca-d23c-2a465de91f3f@loongson.cn>
Message-ID: <a486be19-33da-bb10-b1a7-5efb058bcf55@loongson.cn>
Date: Sun, 4 Feb 2024 12:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <423629fb-f8e2-e4ca-d23c-2a465de91f3f@loongson.cn>
Content-Type: multipart/alternative;
 boundary="------------E21A1A0907880EA0E132FFCF"
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxhcwpDL9lKikvAA--.9316S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4rJw4UZrW8uw4xCry3GFX_yoW5XFyxpF
 y8CFyDWrykGw1xWF18J3W3GFWUJrsrGa4UXr47WFW8J3W5Gr1jgry0vws09r18WFWrJry7
 tF1DJrZF93WDK3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAF
 F20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r
 106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAF
 wI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67
 AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq
 07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1lYx0E2Ix0cI8IcVAFwI0_JrI_Jr
 ylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCj
 r7xvwVCIw2I0I7xG6c02F41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v2
 6r106r1rMI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
 Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
 Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
 IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1F_M3UUUUU=
 =
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.509, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------E21A1A0907880EA0E132FFCF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi  maobibo:
>>
>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>> index 6ef9a92394..d1fba1204e 100644
>>> --- a/include/hw/loongarch/virt.h
>>> +++ b/include/hw/loongarch/virt.h
>>> @@ -20,8 +20,10 @@
>>>   #define VIRT_BIOS_BASE          0x1c000000UL
>>>   #define VIRT_BIOS_SIZE          (4 * MiB)
>>>   #define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
>>> -#define VIRT_FLASH_BASE         0x1d000000UL
>>> -#define VIRT_FLASH_SIZE         (16 * MiB)
>>> +#define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
>>> +#define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
>>
>> Xianglai,
>>
>> If there are two flash, what is size for flash0 16M (VIRT_FLASH1_BASE 
>> - VIRT_FLASH0_BASE) or 4M (VIRT_BIOS_SIZE) ?
>>
>> IIRC it should be 16M (VIRT_FLASH1_BASE -  VIRT_FLASH0_BASE).
>>
>> Regards
>> Bibo Mao
>>
> I referred to Philippe's last review suggestion:
>
>
> https://lore.kernel.org/qemu-devel/b62401b2-3a12-e89d-6953-b40dd170b4ba@linaro.org/
>
> > @@ -20,6 +21,9 @@ > #define VIRT_FWCFG_BASE 0x1e020000UL > #define VIRT_BIOS_BASE 
> 0x1c000000UL > #define VIRT_BIOS_SIZE (4 * MiB) > +#define 
> VIRT_FLASH_SECTOR_SIZE (128 * KiB) > +#define VIRT_FLASH0_BASE 
> (VIRT_BIOS_BASE + VIRT_BIOS_SIZE)
> Do you really want the flash base addr to depend of the ROM size?
> It could be safer/simpler to start with a fixed address, leaving
> room for a bigger ROM if you think you might have to use one.

Ok, I think I misunderstood what he meant, I will keep the changes to 
VIRT_FLASH0_BASE

and change the VIRT_BIOS_SIZE to 16MB, like this：

  - #define VIRT_BIOS_SIZE          (4 * MiB)

   +#define VIRT_BIOS_SIZE          (16 * MiB)

   #define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
-#define VIRT_FLASH_BASE         0x1d000000UL
-#define VIRT_FLASH_SIZE         (16 * MiB)
+#define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
+#define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE

+#define VIRT_FLASH1_BASE        0x1d000000UL
+#define VIRT_FLASH1_SIZE        (16 * MiB)

Thanks,

Xianglai


>
> Thanks!
>
> Xianglai
>
>
>>> +#define VIRT_FLASH1_BASE 0x1d000000UL
>>> +#define VIRT_FLASH1_SIZE        (16 * MiB)
>>>     #define VIRT_LOWMEM_BASE        0
>>>   #define VIRT_LOWMEM_SIZE        0x10000000
>>> @@ -49,7 +51,7 @@ struct LoongArchMachineState {
>>>       int          fdt_size;
>>>       DeviceState *platform_bus_dev;
>>>       PCIBus       *pci_bus;
>>> -    PFlashCFI01  *flash;
>>> +    PFlashCFI01  *flash[2];
>>>       MemoryRegion system_iocsr;
>>>       MemoryRegion iocsr_mem;
>>>       AddressSpace as_iocsr;
>>>
>>

--------------E21A1A0907880EA0E132FFCF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">Hi  maobibo:</div>
    <blockquote type="cite"
      cite="mid:423629fb-f8e2-e4ca-d23c-2a465de91f3f@loongson.cn">
      <blockquote type="cite"
        cite="mid:aa9a0f88-9ce0-2356-b518-906d663fd8b7@loongson.cn"><br>
        <blockquote type="cite">diff --git a/include/hw/loongarch/virt.h
          b/include/hw/loongarch/virt.h <br>
          index 6ef9a92394..d1fba1204e 100644 <br>
          --- a/include/hw/loongarch/virt.h <br>
          +++ b/include/hw/loongarch/virt.h <br>
          @@ -20,8 +20,10 @@ <br>
            #define VIRT_BIOS_BASE          0x1c000000UL <br>
            #define VIRT_BIOS_SIZE          (4 * MiB) <br>
            #define VIRT_FLASH_SECTOR_SIZE  (128 * KiB) <br>
          -#define VIRT_FLASH_BASE         0x1d000000UL <br>
          -#define VIRT_FLASH_SIZE         (16 * MiB) <br>
          +#define VIRT_FLASH0_BASE        VIRT_BIOS_BASE <br>
          +#define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE <br>
        </blockquote>
        <br>
        Xianglai, <br>
        <br>
        If there are two flash, what is size for flash0 16M
        (VIRT_FLASH1_BASE - VIRT_FLASH0_BASE) or 4M (VIRT_BIOS_SIZE) ? <br>
        <br>
        IIRC it should be 16M (VIRT_FLASH1_BASE -  VIRT_FLASH0_BASE). <br>
        <br>
        Regards <br>
        Bibo Mao <br>
        <br>
      </blockquote>
      <p>I referred to Philippe's last review suggestion:</p>
      <p><br>
      </p>
      <p><a class="moz-txt-link-freetext"
href="https://lore.kernel.org/qemu-devel/b62401b2-3a12-e89d-6953-b40dd170b4ba@linaro.org/"
          moz-do-not-send="true">https://lore.kernel.org/qemu-devel/b62401b2-3a12-e89d-6953-b40dd170b4ba@linaro.org/</a><br>
      </p>
      <pre id="b"><span class="q">&gt; @@ -20,6 +21,9 @@
&gt;   #define VIRT_FWCFG_BASE         0x1e020000UL
&gt;   #define VIRT_BIOS_BASE          0x1c000000UL
&gt;   #define VIRT_BIOS_SIZE          (4 * MiB)
&gt; +#define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
&gt; +#define VIRT_FLASH0_BASE        (VIRT_BIOS_BASE + VIRT_BIOS_SIZE)
</span>
Do you really want the flash base addr to depend of the ROM size?
It could be safer/simpler to start with a fixed address, leaving
room for a bigger ROM if you think you might have to use one.
</pre>
    </blockquote>
    <p>Ok, I think I misunderstood what he meant, I will keep the
      changes to VIRT_FLASH0_BASE</p>
    <p>and change the VIRT_BIOS_SIZE to 16MB, like this：</p>
    <p> - #define VIRT_BIOS_SIZE          (4 * MiB) <br>
    </p>
    <p>  +#define VIRT_BIOS_SIZE          (16 * MiB) <br>
    </p>
    <p>  #define VIRT_FLASH_SECTOR_SIZE  (128 * KiB) <br>
      -#define VIRT_FLASH_BASE         0x1d000000UL <br>
      -#define VIRT_FLASH_SIZE         (16 * MiB) <br>
      +#define VIRT_FLASH0_BASE        VIRT_BIOS_BASE <br>
      +#define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE</p>
    <pre class="moz-quote-pre" wrap="">+#define VIRT_FLASH1_BASE        0x1d000000UL
+#define VIRT_FLASH1_SIZE        (16 * MiB)</pre>
    <p> </p>
    <p>Thanks,</p>
    <p>Xianglai</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:423629fb-f8e2-e4ca-d23c-2a465de91f3f@loongson.cn">
      <p><br>
      </p>
      <p>Thanks!</p>
      <p>Xianglai</p>
      <p><br>
      </p>
      <blockquote type="cite"
        cite="mid:aa9a0f88-9ce0-2356-b518-906d663fd8b7@loongson.cn">
        <blockquote type="cite">+#define VIRT_FLASH1_BASE       
          0x1d000000UL <br>
          +#define VIRT_FLASH1_SIZE        (16 * MiB) <br>
              #define VIRT_LOWMEM_BASE        0 <br>
            #define VIRT_LOWMEM_SIZE        0x10000000 <br>
          @@ -49,7 +51,7 @@ struct LoongArchMachineState { <br>
                int          fdt_size; <br>
                DeviceState *platform_bus_dev; <br>
                PCIBus       *pci_bus; <br>
          -    PFlashCFI01  *flash; <br>
          +    PFlashCFI01  *flash[2]; <br>
                MemoryRegion system_iocsr; <br>
                MemoryRegion iocsr_mem; <br>
                AddressSpace as_iocsr; <br>
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------E21A1A0907880EA0E132FFCF--


