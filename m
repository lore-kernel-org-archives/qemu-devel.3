Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E06DC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 09:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rit3B-0000za-Lw; Sat, 09 Mar 2024 04:31:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1rit37-0000zA-S4
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 04:31:25 -0500
Received: from mail.kernel-space.org ([195.201.34.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1rit33-0005gY-Ng
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 04:31:25 -0500
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id b4dd3ca0;
 Sat, 9 Mar 2024 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=av
 CxpG08+o27AwUsmyzWXwCccBw=; b=05r+MoHKhBkZ+BMzoMP06/+yBO0VwJ82LS
 vXSn/Ul1qbnBqSrgxbu3r8/MIzs3NqRDwpSkfOZLjlCI1H5mc23r6ccTVxMnBUn2
 5oPy4NGsyZ2Q+a4safH3NkgI36ponyqKUrboGQfrMNrDk4kLwumOnADME9cShDAN
 gIQLuddL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 aWqy7NicapSLjXzFAXe3MCiMG4SPIGoGLSj+9xt9nS3Zr2fDUyenp+A4n0urTVkv
 Nx2dSCxTC1MW1zUxCQI2ouZ2f36S+H9Ec+uA+f8o7N+Y08RU9UeboyyrBj+xGq72
 WxfXDSTg/bwqP2M/sxWMsPSZEDtqYVeA3yyAAoXw0uM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1709976526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwNk0gzLukJ+sGpfNytqi/J+srokUkCyvh5UM14Lvxg=;
 b=UuAKMUsCFuNVI/MsmmA4wslsRM7lerTHPi4g04+hV8BrsM5oywmmat72suaoJYHBg1vBSj
 H+ZNRAQ5/ALVP7HnXQGdBOXUNwxBXQjMXVTzUP6e/PCHI5oD0s74WYaizAtR8r0pKOO91f
 HR8qBY3dYtfmXpajvDxtJHOo1ypfNbQ=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it
 [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 359ed46f
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 9 Mar 2024 09:28:46 +0000 (UTC)
Message-ID: <bf69d621-c543-2932-568f-1ccb42deafae@kernel-space.org>
Date: Sat, 9 Mar 2024 10:30:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v2] hw/m68k/mcf5208: add support for reset
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20240308090812.1316635-1-angelo@kernel-space.org>
 <20240309100654.24a89b54@fedora>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240309100654.24a89b54@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.201.34.187;
 envelope-from=angelo@kernel-space.org; helo=mail.kernel-space.org
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.994,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Thomas,

On 09/03/24 10:06 AM, Thomas Huth wrote:
> Am Fri,  8 Mar 2024 10:08:12 +0100
> schrieb Angelo Dureghello <angelo@kernel-space.org>:
> 
>> Add reset support for mcf5208.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   hw/m68k/mcf5208.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
>> index 0cfb806c20..d8a38274d0 100644
>> --- a/hw/m68k/mcf5208.c
>> +++ b/hw/m68k/mcf5208.c
>> @@ -40,6 +40,8 @@
>>   #define PCSR_PRE_SHIFT  8
>>   #define PCSR_PRE_MASK   0x0f00
>>   
>> +#define RCR_SOFTRST     0x80
>> +
>>   typedef struct {
>>       MemoryRegion iomem;
>>       qemu_irq irq;
>> @@ -185,13 +187,54 @@ static const MemoryRegionOps m5208_sys_ops = {
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>   };
>>   
>> -static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
>> +static uint64_t m5208_rcm_read(void *opaque, hwaddr addr,
>> +                               unsigned size)
>> +{
>> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
>> +                  __func__, addr);
> 
> I'd maybe rather not print this message if the guest tries to read from RCR
> or RSR - reading back a 0 should be fine here without logging a "bad
> offset".
> 
>> +    return 0;
>> +}
>> +
>> +static void m5208_rcm_write(void *opaque, hwaddr addr,
>> +                            uint64_t value, unsigned size)
>> +{
>> +    M68kCPU *cpu = opaque;
>> +    CPUState *cs = CPU(cpu);
>> +    switch (addr) {
>> +    case 0x0: /* RCR */
>> +        if (value & RCR_SOFTRST) {
>> +            cpu_reset(cs);
>> +            cpu->env.aregs[7] = ldl_phys(cs->as, 0);
>> +            cpu->env.pc = ldl_phys(cs->as, 4);
>> +        }
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
>> +                      __func__, addr);
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps m5208_rcm_ops = {
>> +    .read = m5208_rcm_read,
>> +    .write = m5208_rcm_write,
>> +    .endianness = DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>> +static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic,
>> +                             M68kCPU *cpu)
>>   {
>> -    MemoryRegion *iomem = g_new(MemoryRegion, 1);
>> +    MemoryRegion *iomem;
> 
> I think it's more common coding style in the QEMU sources to have separate
> variables for separate MemoryRegions instead of re-using one variable for
> separate MemoryRegions like you do it below. See e.g.
> microchip_pfsoc_soc_realize() in hw/riscv/microchip_pfsoc.c.
> 
>>       m5208_timer_state *s;
>>       int i;
>>   
>> +    /* RCM */
>> +    iomem = g_new(MemoryRegion, 1);
>> +    memory_region_init_io(iomem, NULL, &m5208_rcm_ops, cpu,
>> +                          "m5208-rcm", 0x00000080);
>> +    memory_region_add_subregion(address_space, 0xfc0a0000, iomem);
>>       /* SDRAMC.  */
>> +    iomem = g_new(MemoryRegion, 1);
>>       memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
>>       memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
>>       /* Timers.  */
>> @@ -265,7 +308,7 @@ static void mcf5208evb_init(MachineState *machine)
>>       mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
>>       mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));
>>   
>> -    mcf5208_sys_init(address_space_mem, pic);
>> +    mcf5208_sys_init(address_space_mem, pic, cpu);
>>   
>>       mcf_fec_init(address_space_mem, 0xfc030000, pic + 36);
> 
> All in all, patch looks fine to me ... if you could update the above two
> nits by Monday, I can try to get this merged before the next soft freeze of
> QEMU (on Tuesday).

thanks a lot, sending v3.

> 
>   Thanks,
>    Thomas

Regards,
angelo

