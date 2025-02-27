Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276C9C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhMe-00051m-Mg; Thu, 27 Feb 2025 12:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnhMW-0004uw-Kj; Thu, 27 Feb 2025 12:07:52 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnhMT-0003da-QM; Thu, 27 Feb 2025 12:07:52 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF1714E602E;
 Thu, 27 Feb 2025 18:07:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id FBvJ92HBg7-V; Thu, 27 Feb 2025 18:07:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 081474E601A; Thu, 27 Feb 2025 18:07:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 05C4674577C;
 Thu, 27 Feb 2025 18:07:45 +0100 (CET)
Date: Thu, 27 Feb 2025 18:07:44 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 3/4] ppc/amigaone: Add default environment
In-Reply-To: <D8336Y20C01W.31TRBEP0KTC1U@gmail.com>
Message-ID: <0107b4ec-b780-aab0-f13b-37dfb64de9de@eik.bme.hu>
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <f1b53e0822111c6c557797adcc75f8d2c7eed17f.1740243918.git.balaton@eik.bme.hu>
 <D82U15TLWUH7.2HKA1PQKQGVMM@gmail.com>
 <3a522e6f-5800-c530-e59f-a602c11a0fea@eik.bme.hu>
 <D8336Y20C01W.31TRBEP0KTC1U@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 27 Feb 2025, Nicholas Piggin wrote:
> On Thu Feb 27, 2025 at 12:18 PM AEST, BALATON Zoltan wrote:
>> On Thu, 27 Feb 2025, Nicholas Piggin wrote:
>>> On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
>>>> Initialise empty NVRAM with default values. This also enables IDE UDMA
>>>> mode in AmigaOS that is faster but has to be enabled in environment
>>>> due to problems with real hardware but that does not affect emulation
>>>> so we can use faster defaults here.
>>>
>>> So this overwrites a blank NVRAM file. Okay I suppose if that works.
>>
>> We're emulating what U-Boot does. If it does not find a valid environment
>> it will overwrite with defaults.
>
> AFAIKS u-boot provides a default environment if the CRC does not match.
>
> If all-zeros env was created with correct CRC, IMO it should be
> accepted.
>
> Does u-boot write back a default environment or corrected CRC to NVRAM
> if it was missing/bad?

No, U-Boot replaces the in memory copy with the default, the NVRAM is only 
changed if saveenv command is issued. I don't want to 100% emulate U-Boot 
but make it easier for users, see below.

>> These defaults are to get the same
>> behaviour and additionally to enable UDMA for IDE driver that until now
>> had to be done manually to get the same speed as with pegasos2 where this
>> is enabled by default. (That's because these VIA VT82C686B chips had some
>> issues with DMA even in PCs but the emulated devices work so can be
>> enabled and that's faster on QEMU too.)
>>
>>> You could have a property to supply the default environment
>>> alternatively.
>>
>> U-Boot has the defaults hard coded. I set and use it from the same file so
>> I don't see the need to send this through a property. (Properties are also
>> listed in QEMU Monitor with info qtree and I don't know how a long string
>> with embedded zeros would look there so I don't think that's a good idea.)
>>
>>> Anywhere to document this behaviour for users?
>>
>> I've added docs in the cover letter that I hope would end up in the
>> changelog and I have a separate page for this which I'll update at
>> qmiga.codeberg.page (Haven't done that yet but would do it by the
>> release once this is merged.)
>
> Okay. It would still be better to add QEMU options to docs/ files and
> point the amiga pages to that rather than the other way around, since
> this is QEMU specific stuff. Doc in cover letter unfortunately is
> not very good since it  just gets lost.

I hope that part of the cover letter would end up in the QEMU changelog so 
it will be in QEMU docs. The amigang.rst doc specifically documents how to 
run Linux on these machines and these patches don't affect Linux nor work 
with it so I left them out to not confuse readers with options they don't 
need.

>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>  hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>>> index 5273543460..35e4075cc3 100644
>>>> --- a/hw/ppc/amigaone.c
>>>> +++ b/hw/ppc/amigaone.c
>>>> @@ -52,6 +52,28 @@ static const char dummy_fw[] = {
>>>>  #define NVRAM_ADDR 0xfd0e0000
>>>>  #define NVRAM_SIZE (4 * KiB)
>>>>
>>>> +static char default_env[] =
>>>> +    "baudrate=115200\0"
>>>> +    "stdout=vga\0"
>>>> +    "stdin=ps2kbd\0"
>>>> +    "bootcmd=boota; menu; run menuboot_cmd\0"
>>>> +    "boot1=ide\0"
>>>> +    "boot2=cdrom\0"
>>>> +    "boota_timeout=3\0"
>>>> +    "ide_doreset=on\0"
>>>> +    "pci_irqa=9\0"
>>>> +    "pci_irqa_select=level\0"
>>>> +    "pci_irqb=10\0"
>>>> +    "pci_irqb_select=level\0"
>>>> +    "pci_irqc=11\0"
>>>> +    "pci_irqc_select=level\0"
>>>> +    "pci_irqd=7\0"
>>>> +    "pci_irqd_select=level\0"
>
> Hmm, the u-boot default env (before it was removed) selected
> edge for these. Was that wrong?

What was in upstream U-Boot wasn't what was in the binary that came with 
the machine. The binary has these defaults and AmigaOS depends on it, it 
does not work with edge as found for the pegasos2 where the default was 
edge and that resulted in missed IRQs.

>>>> +    "a1ide_irq=1111\0"
>>>> +    "a1ide_xfer=FFFF\0";
>>>> +#define CRC32_DEFAULT_ENV 0xb5548481
>>>> +#define CRC32_ALL_ZEROS   0x603b0489
>>>> +
>>>>  #define TYPE_A1_NVRAM "a1-nvram"
>>>>  OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>>>
>>>> @@ -97,7 +119,7 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>>>>  {
>>>>      A1NVRAMState *s = A1_NVRAM(dev);
>>>>      void *p;
>>>> -    uint32_t *c;
>>>> +    uint32_t crc, *c;
>>>>
>>>>      memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
>>>>                                    NVRAM_SIZE, &error_fatal);
>>>> @@ -116,12 +138,25 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>>>>              return;
>>>>          }
>>>>      }
>>>> +    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
>>>> +    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
>>>> +        *c = cpu_to_be32(CRC32_DEFAULT_ENV);
>>>> +        /* Also copies terminating \0 as env is terminated by \0\0 */
>>>> +        memcpy(p + 4, default_env, sizeof(default_env));
>>>> +        if (s->blk) {
>>>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
>>>> +        }
>>>> +        return;
>>>> +    }
>>>>      if (*c == 0) {
>>>>          *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>>>          if (s->blk) {
>>>>              blk_pwrite(s->blk, 0, 4, p, 0);
>>>>          }
>>>>      }
>>>> +    if (be32_to_cpu(*c) != crc) {
>>>> +        warn_report("NVRAM checksum mismatch");
>>>> +    }
>>>
>>> Maybe the default environment should be set if there is no CRC? If there
>>> is a CRC already then that seems to indicate a valid rom file was
>>> supplied and user wanted it blank.
>>
>> The idea is to allow supplying an environment via the backing file or let
>> users edit it and clear the checksum in which case it will take the
>> supplied data and only fix the checksum. Unlike U-Boot it will only
>> replace empty backing file with defaults. (This is kind of undocumented
>> for advanced users only but that's why the above code looks like that.)
>> Having an empty NVRAM does not make much sense as U-Boot always has some
>> values there so it's never empty. If it finds empty NVRAM then installs
>> default env which is to help new users so they only need to create an
>> empty file to get started. It also works without backing file in which
>> case we want to use defaults and keep it persistent only for the session.
>>
>>> This can also be rewritten:
>>>
>>>    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
>>>    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
>>>        /* Also copies terminating \0 as env is terminated by \0\0 */
>>>        memcpy(p + 4, default_env, sizeof(default_env));
>>>        crc = CRC32_DEFAULT_ENV;
>>>    }
>>>    if (*c == 0) {
>>>        *c = cpu_to_be32(crc);
>>>        if (s->blk) {
>>>            blk_pwrite(s->blk, 0, 4, p, 0);
>>>        }
>>>    } else if (be32_to_cpu(*c) != crc) {
>>>        warn_report("NVRAM checksum mismatch");
>>>    }
>>
>> I have the checksum check in separate if to warn if there is a checksum
>> but it's wrong because I only want it to fix checksum if it's zero but not
>> touch it otherwise. Basically it will only overwrite zero values but leave
>> nonzero values there. (Might be useful for testing what does the guest do
>> if the checksum is wrong, although on real machine U-Boot would have
>> replaced the env with default in that case so this would only happen if
>> the NVRAM is changed during runtime without updating the checksum.)
>
> Right, you can just rewrite it a bit simpler to have only one exit point
> and only do the blk_pwrite once etc I think (although my version might
> have had a bug it was a bit hasty but you get the idea).

It would not be simpler because I'd need another variable to keep how much 
of the NVRAM to rewrite. Note that the area to write in the two blk_pwrite 
calls are different. We have 3 cases:

1. User just created an empty NVRAM file to allow persisting settings in 
it for future runs. Something has to put defaults there but if not running 
with -bios firmware.bin because using -kernel to boot instead, it would 
stay empty. Also firmware.bin has defaults that does not autoboot so needs 
manual intervention and disable UDMA so it will be slow. In this case we 
init NVRAM with sensible defaults which is done in the first if. (This is 
also used when no NVRAM file is provided.)

2. The NVRAM has some values in it either because the user supplied their 
preferred values or edited previous content directly and not within the 
guest. To make their life easier and allow them to leave checksum empty I 
allow setting crc to 0 in which case it will just update the crc and use 
the contents. This is handled in the second if.

3. There is content in NVRAM with a crc. In this case only the crc is 
checked and nothing is replaced. This is done in the third if and will 
never fail in one of the first two cases but checks NVRAM in the third 
case. When checksum does not match U-Boot would use defaults for the 
memory copy used only while U-Boot is running but unless user issues 
saveenv it still passes wrong NVRAM contents to the guest so without 
U-Boot we get the same behaviour here.

Regards,
BALATON Zoltan

