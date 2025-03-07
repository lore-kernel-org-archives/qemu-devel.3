Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868A5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZku-0004AI-VE; Fri, 07 Mar 2025 10:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tqZkf-00048Z-VP; Fri, 07 Mar 2025 10:36:45 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tqZkd-0000Xu-Jz; Fri, 07 Mar 2025 10:36:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0441C4E6000;
 Fri, 07 Mar 2025 16:36:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id vCyFp1qOsc_A; Fri,  7 Mar 2025 16:36:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2B9C4E600F; Fri, 07 Mar 2025 16:36:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E05AF74577C;
 Fri, 07 Mar 2025 16:36:19 +0100 (CET)
Date: Fri, 7 Mar 2025 16:36:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/5] ppc/amigaone: Add default environment
In-Reply-To: <3bff4d7a-56c8-44a4-8093-9a7a10699d2b@linaro.org>
Message-ID: <caf052a4-2a12-ae71-eeb2-86f27cff7ccb@eik.bme.hu>
References: <cover.1740673173.git.balaton@eik.bme.hu>
 <4d63f88191612329e0ca8102c7c0d4fc626dc372.1740673173.git.balaton@eik.bme.hu>
 <84151f43-d952-4515-aee5-04f339baa546@linaro.org>
 <33e3ef97-749e-4701-4955-0e88d0eb2199@eik.bme.hu>
 <3bff4d7a-56c8-44a4-8093-9a7a10699d2b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1937983146-1741361779=:94221"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1937983146-1741361779=:94221
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 7 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 7/3/25 15:46, BALATON Zoltan wrote:
>> On Fri, 7 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> Hi Zoltan,
>>> 
>>> Minor review comments in case you respin (not blocking).
>>> 
>>> On 27/2/25 17:39, BALATON Zoltan wrote:
>>>> Initialise empty NVRAM with default values. This also enables IDE UDMA
>>>> mode in AmigaOS that is faster but has to be enabled in environment
>>>> due to problems with real hardware but that does not affect emulation
>>>> so we can use faster defaults here.
>>>> 
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 36 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>>> index 849c9fc6e0..5c5585d39a 100644
>>>> --- a/hw/ppc/amigaone.c
>>>> +++ b/hw/ppc/amigaone.c
>>>> @@ -52,6 +52,28 @@ static const char dummy_fw[] = {
>>>>   #define NVRAM_ADDR 0xfd0e0000
>>>>   #define NVRAM_SIZE (4 * KiB)
>>>>   +static char default_env[] =
>>> 
>>> 'const'
>> 
>> OK. Could be fixed up on merge by Nick or I can send a new version if 
>> needed.
>> 
>>>> +    "baudrate=115200\0"
>>>> +    "stdout=vga\0"
>>>> +    "stdin=ps2kbd\0"
>>>> +    "bootcmd=boota; menu; run menuboot_cmd\0"
>>>> +    "boot1=ide\0"
>>>> +    "boot2=cdrom\0"
>>>> +    "boota_timeout=3\0"
>>>> +    "ide_doreset=on\0"
>>>> +    "pci_irqa=9\0"
>>>> +    "pci_irqa_select=level\0"
>>>> +    "pci_irqb=10\0"
>>>> +    "pci_irqb_select=level\0"
>>>> +    "pci_irqc=11\0"
>>>> +    "pci_irqc_select=level\0"
>>>> +    "pci_irqd=7\0"
>>>> +    "pci_irqd_select=level\0"
>>>> +    "a1ide_irq=1111\0"
>>>> +    "a1ide_xfer=FFFF\0";
>>>> +#define CRC32_DEFAULT_ENV 0xb5548481
>>>> +#define CRC32_ALL_ZEROS   0x603b0489
>>> 
>>>> +
>>>>   #define TYPE_A1_NVRAM "a1-nvram"
>>>>   OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>>>   @@ -94,7 +116,7 @@ static void nvram_realize(DeviceState *dev, Error 
>>>> **errp)
>>>>   {
>>>>       A1NVRAMState *s = A1_NVRAM(dev);
>>>>       void *p;
>>>> -    uint32_t *c;
>>>> +    uint32_t crc, *c;
>>>>         memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, 
>>>> "nvram",
>>>>                                     NVRAM_SIZE, &error_fatal);
>>>> @@ -113,12 +135,25 @@ static void nvram_realize(DeviceState *dev, Error 
>>>> **errp)
>>>>               return;
>>>>           }
>>>>       }
>>>> +    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
>>>> +    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default 
>>>> */
>>>> +        *c = cpu_to_be32(CRC32_DEFAULT_ENV);
>>> 
>>> Prefer the ld/st API over cpu_to/from:
>>> 
>>>           stl_be_p(c, CRC32_DEFAULT_ENV);
>>> 
>>>> +        /* Also copies terminating \0 as env is terminated by \0\0 */
>>>> +        memcpy(p + 4, default_env, sizeof(default_env));
>>>> +        if (s->blk) {
>>>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 
>>>> 0);
>>>> +        }
>>>> +        return;
>>>> +    }
>>>>       if (*c == 0) {
>>>>           *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>>>           if (s->blk) {
>>>>               blk_pwrite(s->blk, 0, 4, p, 0);
>>>>           }
>>>>       }
>>>> +    if (be32_to_cpu(*c) != crc) {
>>> 
>>>       if (ldl_be_p(c) != crc) {
>> 
>> Why? Here we want to convert a value from host CPU endianness to a specific 
>> endianness and vice versa in code running on the host. (We are not 
>> accessing guest memory, we operate on the memory region pointer. The guest 
>> is not even running yet.)
>> 
>> Also:
>> 
>> static inline int ldl_be_p(const void *ptr)
>> {
>>      return be_bswap(ldl_he_p(ptr), 32);
>> }
>> 
>> static inline int ldl_he_p(const void *ptr)
>> {
>>      int32_t r;
>>      __builtin_memcpy(&r, ptr, sizeof(r));
>>      return r;
>> }
>> 
>> #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>> 
>> so this is
>> 
>> int32_t r;
>> __builtin_memcpy(&r, c, sizeof(r));
>
> This call makes the address alignment access safe.
>
> Sometimes we use similar API doing unaligned access and static
> analyzers complain [*]. Rather than maintaining 2 differents APIs
> with some corner cases in one, we could always use the reliable
> one.
>
> [*] see for example commit 5814c084679 ("hw/net/virtio-net.c: Don't assume IP 
> length field is aligned")

That concern does not apply here as it's unlikely to have a memory region 
allocated unaligned so I'd keep this until it's removed from everywhere. 
We have a lot of uses of cpu_to_, _to_cpu now so it's not likely it would 
go away soon. I see no advantage in introducing unneeded complexity here 
to prevent something that cannot happen.

Regards,
BALATON Zoltan

>> __builtin_bswap32(r);
>> 
>> versus
>> 
>> static inline type endian ## size ## _to_cpu(type v)
>> {
>>      return glue(endian, _bswap)(v, size);
>> }
>> 
>> which is just
>> 
>> __builtin_bswap32(*c);
>> 
>> The second one makes more sense to me and don't see why I'd want to do it 
>> in a more cumbersome way when we end up with the same result but simpler.
>> 
>> Regards,
>> BALATON Zoltan
>> 
>>>> +        warn_report("NVRAM checksum mismatch");
>>>> +    }
>>>>   }
>
>
--3866299591-1937983146-1741361779=:94221--

