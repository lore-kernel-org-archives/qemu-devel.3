Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD51C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 20:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiJHP-0004n1-W0; Wed, 12 Feb 2025 15:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tiJHN-0004hr-D9; Wed, 12 Feb 2025 15:24:17 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tiJHI-00084o-C5; Wed, 12 Feb 2025 15:24:15 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so137139a12.1; 
 Wed, 12 Feb 2025 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739391850; x=1739996650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDCBaC/1pLLVm8uWy10WMEkFq+jGLr/pPQJ73XDcquQ=;
 b=JV4gaYPCo/Rx1kKbI9OG8SnRffT957IAAQ0IxQwqkbe96KusufpuvFMW8s71gZAjYg
 NRQVNvYcx4SmlBWwgBkwmTQgpnDGifS2aVlojypC+BPNgqO6kNc7eHs+HPKkyp9hB6VB
 ze03mgcw6U4kbdnpeE829fVEzqFhV9d681yrR5HpZt05HmAC629efxz+HI0HzWCO35Aa
 uxt+7ofud7NgroLKVHRVA1wn+Cq53Y8RsAUo6Q5QgFahZbGuNRg9ce8KVGPTN47wtWFh
 HVQ7TSiygyy8Nyd1L3oR5qA7RDF0/vQluETfAsv8svmDuSD0zNMTlI3LlPazBOeFENI8
 uQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739391850; x=1739996650;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDCBaC/1pLLVm8uWy10WMEkFq+jGLr/pPQJ73XDcquQ=;
 b=J1RK0pNE1xlYFLUpfXZe2izBv+jR2kz6aPkb0zSQKbFAl+XDeug2ZYwvDKcxADLA/t
 Bo0Z6xSfYoufwoOTKHBRk/WAkWnQErwsMOpiJkNYL+yMiRbO/6eTRlH4XphjU/PPXAOa
 0D2KuhShv/88RWNLubie7KYghtHh/RGgk0QW2ZreW00dcQe4MKTo5jVzVFFnEtwOBeAl
 55Vzjneww6FGE0F7pURhJb8Wx6h4qyaTczu1d2EEcO6at/pv+VbBE6b+PdPvtiTnmo5N
 deeEfbk8cPMnFmkhHJutPIfhn6aIdbf6eHF2YokQL5HqXTfUBzrEt4q4BECZ2pcSW6LJ
 0CLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV3VlAScBtpUOkAhS+x1+smXOsgvU0z9nq5KCUV7NjoT+WWk8AeUwyO4n/N/7wbPLkfw1AKpQKMg==@nongnu.org
X-Gm-Message-State: AOJu0Yyg8qe+9PoYn1qbd+u610oP8cvtqk0HvOMmbTHd6iG0SBCnLHtp
 qcoQUnGTfQC+Ofp9LsthVCOZIt4bw0eKgzdDK01mz984PGzIXvhSXsIf0A==
X-Gm-Gg: ASbGncvaZlD7qEEta/d7VTGB0TPVgyD+kWQSqEULuMXVCgA5lKUuQHfLlDdWN5hvqlo
 s0m0MOP/I8Z2UI4anBFaePU1W2ms0RRM5DLfKyaqo5E2gV3QIRmVQojfmj30O6JIR4KfDV0MTZR
 3Csm8z9d/5HU+Q9NERwgDb6UfVrFDdXVUgPyAIgrSIU1D5Z0U1DLzBa2q636GFmapWIhFMsPfKL
 mMb0FON64YKeQXy8gA4lPwVLS+t8e2loS82Zl0G+Gm2ItEM0LHxJ9kt1AshxBUr72vDh0HkVycm
 wyq+cCSUrTTMGuWGhxm8rwlUgefVo1Wq+WrUuwObZWLo3M52YuOMvXIJjUhCTUuO6sdJ
X-Google-Smtp-Source: AGHT+IFtscNFVITXOu7FdfuaOErYfSnJfxXxlMQrx+8079BfKeyiejuKCER3AVL1HeY6dLVmJEzjXw==
X-Received: by 2002:a05:6402:3606:b0:5dc:7fbe:730a with SMTP id
 4fb4d7f45d1cf-5dec9b70130mr572273a12.0.1739391849813; 
 Wed, 12 Feb 2025 12:24:09 -0800 (PST)
Received: from [127.0.0.1] (dynamic-092-224-233-244.92.224.pool.telefonica.de.
 [92.224.233.244]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5d484c76sm9003847a12.35.2025.02.12.12.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 12:24:09 -0800 (PST)
Date: Wed, 12 Feb 2025 19:40:08 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_Partial_impleme?=
 =?US-ASCII?Q?ntation_of_local_access_window_registers?=
In-Reply-To: <81cd9319-848c-93f5-156d-b35226f90966@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
 <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
 <81cd9319-848c-93f5-156d-b35226f90966@eik.bme.hu>
Message-ID: <4023E866-442D-408B-9BD7-9036694DD8DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E Februar 2025 01:12:38 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Thu, 6 Feb 2025, Bernhard Beschow wrote:
>> Am 2=2E Februar 2025 01:25:22 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Sat, 1 Feb 2025, Bernhard Beschow wrote:
>>>> Am 1=2E Februar 2025 14:55:15 UTC schrieb Bernhard Beschow <shentey@g=
mail=2Ecom>:
>>>>> Am 30=2E Januar 2025 12:45:58 UTC schrieb BALATON Zoltan <balaton@ei=
k=2Ebme=2Ehu>:
>>>>>> On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>>>>>>> This allows guests to set the CCSR base address=2E Also store and =
return
>>>>>>> values of the local access window registers but their functionalit=
y
>>>>>>> isn't implemented=2E
>>>>>>=20
>>>>>> Ping?
>>>>>=20
>>>>> I guess you're trying to boot a real firmware image from SD card?
>>>=20
>>> I'm not trying, I've done it=2E I only needed these patches and commen=
ting out the page_aligned =3D true in hw/sd/sdhci=2Ec as I noted in the pre=
vious patch=2E
>>=20
>> I had to apply <https://github=2Ecom/shentok/qemu/commit/56550cbb2805be=
2913ad9c12d6d9c6a9a3bf6f2c> to have the SPL load the whole U-Boot proper=2E
>
>Is that an alternative to commenting out page_aligned =3D true?

Well, it's not needed with the patch applied=2E The patch ensures that all=
 data gets loaded: <https://lore=2Ekernel=2Eorg/qemu-devel/D62F06C8-5247-4F=
BC-82A9-9127352B30A6@gmail=2Ecom/>

>(Previously it also needed some tweak on when to set DMA bit but after yo=
ur fix in commit 5df50b8e973 in master resolved it that's no longer needed=
=2E Now only the interrupt control reset values and commenting page_aligned=
 =3D true was needed to get it work=2E)
>
>>> U-Boot works and I can run commands in the firmware prompt but I did n=
ot try to boot an OS yet=2E The amigaos boot loader which U-Boot for Tabor =
loads by default crashes somewhere but this may be a bug in the patched U-B=
oot=2E I think I've seen similar with sam460ex U-Boot before, maybe it's be=
cause of not finding some expected devices and not handling the returned NU=
LL value well but I did not debug it=2E
>>=20
>> Do you use the Tabor U-Boot or something else?
>
>I've tested the firmware image available from this page:
>http://eliyahu=2Eorg/tabor/setup=2Ehtml
>There's also a technical manual there that has info on the content of the=
 SD card image=2E

I got both from there as well=2E

>
>> How do you get to the command prompt? For me, the bootloader applicatio=
n started by Tabor U-Boot doesn't crash but then doesn't find bootable devi=
ces, not even with an emulated USB stick=2E Instead of dropping to the comm=
and prompt it only offers a restart to the firmware which then starts the b=
ootloader application again=2E=2E=2E
>
>There are two U-Boot binaries on the card for some reason (I think maybe =
the first one runs from cache as RAM and sets up the memory controller), th=
en the first one loads some env variables and then the second U-Boot which =
then loads the bootloader=2E

Yeah, that's the SPL and U-Boot proper=2E The first one sets up RAM based =
on DDR3 data, copies U-Boot proper there (currently broken in QEMU, see abo=
ve), and passes control to it=2E

>If you change one byte in the environment on the SD card it breaks the ch=
ecksum and then it does not load the bootloader but gives a prompt=2E You c=
an then look around in U-Boot=2E Alternatively you can extract the U-Boot b=
inaries and convert to elf to load it with -bios then you can skip the SD c=
ard=2E Maybe depending on some env settings I haven't identified yet, the b=
ootloader either says no bootable devices found or crashes when calling bac=
k into U-Boot which may be something similar that I had to fix for sam460ex=
 here: https://gitlab=2Ecom/qemu-project/u-boot-sam460ex/-/commit/f6402c160=
f781145206b2dc0eb4d50738d0531d4/ but I don't have the Tabor U-Boot sources =
yet to check=2E Presumably it works on real machine so maybe it checks for =
SATA or other devices which aren't emulated so it may get an unexpected NUL=
L value=2E I've tried adding dummy SATA emulation that shows an empty bus b=
ut it did not fix that=2E It could also be something completely different=
=2E With the USB patch, it at least finds USB storage devices after usb sta=
rt in U-Boot but that's all I could test=2E I should find some Linux boot m=
edia known to work on real machine to test further but haven't had time for=
 it=2E

Considering the technical manual it may be possible to compile U-Boot ones=
elf and replace components of the firmware image=2E That way, one could tra=
ck down why no bootable devices are found, i=2Ee=2E check whether and which=
 bootmenu_x variables are populated=2E That's not on my todo list though=2E

>
>>>>> I've implemented that in my e500-fdt branch which I want to send as =
an RFC=2E I still need to clean it up=2E Once it's on the list we could mak=
e a plan how to turn it into a p10xx=2E Would that work for you?
>>>=20
>>> Sure, I can try to test your patches once they are submitted to the li=
st and rebase my changes on top if they still needed=2E I've just submitted=
 these so you can incorporate them in your tree so I have less to rebase bu=
t I see you already have most of these=2E I'm OK to wait until your tree is=
 cleaned and submitted but it seems there are a lot of patches so it might =
take a while=2E I don't expect that you can get it merged before the next r=
elease=2E Some of the patches may need several versions or alternative appr=
oaches until they can be merged=2E For example I expect problems with allow=
ing ',' in device names as this is something that was removed before to avo=
id the need of quoting or something like that=2E But I'm not in a hurry as =
I don't have much free time for it anyway so only come back to this time to=
 time and it's far from anything useful yet=2E
>>=20
>> My branch is not a maintainer tree=2E I neither expect it to be mergeab=
le like this, nor is it my goal=2E Instead, it's just an experiment to inve=
stigate data-driven machine creation which I'd like to share as an RFC with=
 the community=2E
>>=20
>> That said, one could probably turn that branch into a p10xx SoC impleme=
nted in the classic way=2E For this, one would need to decide on how to pro=
ceed with the mpc8544ds and e500plat machines=2E There are
>
>These existing machines set up values in PPCE500MachineClass in their ini=
t methods that the e500=2Ec uses to change its behaviour to match the machi=
ne so to continue adding another board in the classic way I'd continue like=
 that=2E I've added another similar board file like those machines setting =
the values matching P1022=2E For the additional devices in e500=2Ec I've ju=
st patched them in for experimenting but these could be optionally created =
based on new values in the MachineClass, like has_2nd_i2c or similar to not=
 change existing machines=2E

The challenge is that different variants of the SoC have the same IP cores=
 mapped at different offsets with possibly (haven't checked) IRQs=2E These =
need to be considered when generating the DTB=2E To avoid dealing with this=
 question -- and at the same time explore data-driven machine creation -- I=
 reversed the process and generated the machine from the DTB=2E But this qu=
estion needs to be answered when implementing a P1022=2E

>I would not go into more elaborate solutions if your fdt based machine cr=
eation replaces this eventually=2E

As said before, I'd send an RFC for discussion on how to proceed=2E=20

>
>> Buildroot recipes for the machines, both 32 and 64 bit, which might be =
nice to keep working -- ideas welcome=2E Once the p10xx SoC is
>
>I think the e500 machine was originally made for running with KVM and not=
 for TCG emulation but it fell out of maintenance for a while and maybe Lin=
ux dropped some of the support by now so don't know if that still works=2E =
But it seems to still work for booting Linux in emulation so that should de=
finitely be kept working=2E

I haven't tried running on KVM since I don't have access to a PPC machine=
=2E Judging from the code both methods should work alike=2E
Buildroot still works because it builds an old toolchain, kernel, etc=2E

>
>> implemented, a tabor machine could be added which uses it=2E
>>=20
>>>=20
>>>>>=20
>>>>> Best regards,
>>>>> Bernhard
>>>>>=20
>>>>> P=2ES=2E The last commit teaches you how to start a firmware from SD=
 card=2E
>>>=20
>>> I did not try your version but looking at the patch looks like you hav=
e some sparse-mem region=2E (I've added similar one from board code, I did =
not know about this device=2E) Isn't that the l2cache as RAM or on-chip SRA=
M or whatever it's called? You seem to have some emulation of that l2cache =
in a previous patch so can't that be mapped there? Maybe we'll eventually n=
eed to implement reading the BOOT data from the beginning of the SD card or=
 flash ROM which may have some initial register values that set things up t=
hat are currently hard coded=2E
>>=20
>> This is implemented on my branch=2E It pokes the L2 cache registers to =
configure some (but not all) SRAM to load the SPL to=2E This SPL uses cache=
 as RAM which I'm emulating with a modified sparse-mem region device=2E
>
>This is new addition from today=2E I still don't get why you need sparse-=
mem when you also have a separate patch for l2cache regs which could have a=
 memory region itself for this but for now I'm OK with adding this region f=
rom the tabor board code on my branch for experimenting=2E

The stack location is specific to U-Boot, not the chip=2E It resides in ca=
che (used as RAM) rather than in SRAM=2E Modeling a cache with cache lines =
etc=2E was a rabbit hole I didn't want to get into=2E Hence I extended spar=
se-mem for this stack region to be user-creatable=2E When implementing a Ta=
bor machine this stack region could be hardcoded there=2E

Best regards,
Bernhard

>I'm a long way from this to work or being mergeable so your RFC might be =
ready and merged before that and then I don't need most of my changes, so I=
 try to keep them minimal and have no intent trying to clean up the existin=
g machines or SoC emulation=2E
>
>>> Meanwhile I can cherry pick some patches from your tree and test them=
=2E Looks like you have some DDR3 support added, I haven't got to that yet=
=2E
>>>=20
>>> For USB I had this for now:
>>>=20
>>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>>> index ee17acdb69=2E=2E54890d25f3 100644
>>> --- a/hw/ppc/e500=2Ec
>>> +++ b/hw/ppc/e500=2Ec
>>> @@ -900,6 +900,29 @@ static void ppce500_power_off(void *opaque, int l=
ine, int on)
>>>     }
>>> }
>>>=20
>>> +static uint64_t usb_read(void *opaque, hwaddr addr, unsigned size)
>>> +{
>>> +    switch (addr) {
>>> +    case 0:
>>> +        return BIT(2) | BIT(17);
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static void usb_write(void *opaque, hwaddr addr, uint64_t val, unsign=
ed size)
>>> +{
>>> +}
>>> +
>>> +static const MemoryRegionOps usb_ops =3D {
>>> +    =2Eread =3D usb_read,
>>> +    =2Ewrite =3D usb_write,
>>> +    =2Eendianness =3D DEVICE_BIG_ENDIAN,
>>> +    =2Evalid =3D {
>>> +        =2Emin_access_size =3D 4,
>>> +        =2Emax_access_size =3D 4,
>>> +    },
>>> +};
>>> +
>>> void ppce500_init(MachineState *machine)
>>> {
>>>     MemoryRegion *address_space_mem =3D get_system_memory();
>>> @@ -1118,6 +1141,19 @@ void ppce500_init(MachineState *machine)
>>>                                     sysbus_mmio_get_region(s, 0));
>>>     }
>>>=20
>>> +    /* USB */
>>> +    dev =3D qdev_new("tegra2-ehci-usb");
>>> +    s =3D SYS_BUS_DEVICE(dev);
>>> +    sysbus_realize_and_unref(s, &error_fatal);
>>> +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, 12));
>>> +    memory_region_add_subregion(ccsr_addr_space, 0x22000,
>>> +                                sysbus_mmio_get_region(s, 0));
>>> +    {
>>> +        MemoryRegion *mr =3D  g_new(MemoryRegion, 1);
>>> +        memory_region_init_io(mr, OBJECT(dev), &usb_ops, s, "fsl-ehci=
", 4);
>>> +        memory_region_add_subregion(ccsr_addr_space, 0x22500, mr);
>>> +    }
>>> +
>>>     /* General Utility device */
>>>     dev =3D qdev_new("mpc8544-guts");
>>>     s =3D SYS_BUS_DEVICE(dev);
>>>=20
>>> which is reusing a sufficiently similar existing device just to have m=
inimal changes=2E This isn't the right way but since most of these just dif=
fer in the reg offsets I wonder if we could turn these offsets into propert=
ies so we don't need to add a new subclass for every device=2E I think subc=
lasses came from the pci version where the PCI IDs are different and maybe =
sysbus was modelled after that but we only need subclasses where additional=
 registers are needed (which may be the case for this fsl device so this pr=
operty idea is just unrelated clean up)=2E
>>=20
>> My implementation has similar usb_ops but is based on TYPE_CHIPIDEA whi=
ch also has the "endpoints" registers covered=2E It is used by some i=2EMX =
machines and given that these and p1022 are NXP SoCs I wouldn't be surprise=
d if they shared a relation in the real world=2E
>
>Yes, the CHIPIDEA maybe is a better idea=2E I've only picked one that had=
 the regs at the right place for a start and it seemed to work enough=2E Bu=
t you likely have a more complete implementation so if you submit that even=
tually this will also be resolved for me so I can drop the above change and=
 use yours instead=2E I just added it above because you seem to not have BI=
T(2) but I don't remember what that was and if it's really needed=2E Otherw=
ise it looked you have the same=2E
>
>Regards,
>BALATON Zoltan

