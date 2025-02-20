Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E58C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 19:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlCbZ-0005Ut-RD; Thu, 20 Feb 2025 14:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tlCbT-0005Tv-Tv; Thu, 20 Feb 2025 14:52:59 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tlCbQ-0007IE-MG; Thu, 20 Feb 2025 14:52:58 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e0939c6456so2309873a12.3; 
 Thu, 20 Feb 2025 11:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740081171; x=1740685971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnxlAB7o48lgHBfcg7nTxqKrM20S52gErE0aE/Mjnao=;
 b=mjceW3juN+51Xen/fESVwRgYwvdsm0lCXPyuFJ+q9mfqqV01exayITu4xZjP0Xv0uW
 UtLF/dW1OScr1vIJgfKsclOsapxKrX0wijuSC4jIMt4fPM2nT6tl5rUirIyyqekhUoA1
 Xho9Pca1OXW7CgoKiRJSQ0ZWTcBeFkf+gfQDefqoXoqt05+pbTw0LeP0WvDTiPWtj9eZ
 lxiW+oP5AOqJ2sbnTwKzMhy8CSb5XfG15rhIUT5XeKsFLAPeThD7pzalzratD9jhvCiT
 HGjGk9dZD/hmLsLXWmM/qO5c/j4U6VFS4cna6jxVFnltqCvXxNK5U+84yU0IXuyznpKR
 N/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740081171; x=1740685971;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnxlAB7o48lgHBfcg7nTxqKrM20S52gErE0aE/Mjnao=;
 b=IGJn9BEuTOPSNUSqTvQ9mvhjxDVGXAqDLqZ8y00oTCf7WoOrGa2JdDQLZ2TJTzw+cS
 T5dm0Ku16h07x3auWFhImf3OGNioNzq/PUlY7ms94T1Um3DyDEhjbecziyV0o6bmTMgj
 CjlOCFjIKxS1AS7zRsymMmD8ctfzVOfMmZaCtJZi2yFbA/iBmCDMR6Gha7uM6ghvvD6K
 h4FsxiGhhduCwvkB278yFKMRc8pern8Exj5HmRiaVGf5kY0xCHVt7Wph7wc9Q850JoIG
 jJ0OXgTU4CevRqyco9ockJUYUT5QacGzJfvtovBOlNVXIdQkUmJzoMrEgqUQhqK6BMW8
 /NRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt6XZjRFAbkJsGN261gtsLacWkne5DxavEocSUlHT10Tn+IJvZ9c+EwVImS86a//qOthS4EboBuA==@nongnu.org
X-Gm-Message-State: AOJu0YzfXnWpA7IH0GiguF4bC7xhGZG7avTRQp7lPrDFRLaqACEyr3FD
 KCiMf9/am02yPYIsHgs5uRr7/a6zzacc0530Jv6t9q3zhUw7lBdlh32Kbw==
X-Gm-Gg: ASbGncvOScsqqmCu9gbT2JbFXDSJmycaEsDikFzeXYJYYx2E0rkhjdOY5xSkOvHDSat
 Kz0IdXjuv3IYh7DZ0dnb7T//uPKJQrs9FSaYjmvcpQ0qForxFLHU3nHSCWX143wkR4t9yNP25EY
 Dru7M7GfCcWM4OJe61T7XBDh5FhJ+BUG+u27gNHZHSAjroM5K1TOeOozsMelTVjsCxQPKolmhLW
 WgosfF18p1eu0+jPI5n2W51i/79KSEOThz7bFul4roUggFcNqBltUqaa5eS8ferJbD6sMcrGrGM
 dWHGD5l/XP1W9xdHjQZfkmFcc5BKV5diNGCpQOE6KvGqZ0+UiVi4pRCyB2Q4nzY=
X-Google-Smtp-Source: AGHT+IGw1eCHTKqgK87C+87UdkNTTJtUKUnZFwa67q9AWxA1LEuHHAYF4NN7j+hl7TGfLZ3gLeMU/Q==
X-Received: by 2002:a17:907:94c8:b0:aa6:6c46:7ca1 with SMTP id
 a640c23a62f3a-abc0d97e4eemr7246066b.10.1740081170809; 
 Thu, 20 Feb 2025 11:52:50 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-080-022.78.54.pool.telefonica.de.
 [78.54.80.22]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532323cbsm1535240466b.14.2025.02.20.11.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 11:52:49 -0800 (PST)
Date: Thu, 20 Feb 2025 19:11:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_Partial_impleme?=
 =?US-ASCII?Q?ntation_of_local_access_window_registers?=
In-Reply-To: <a4083d0c-acd5-f9da-66da-d796d09a0808@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
 <32BC6ABA-EE27-437C-81C0-AEEE3E0DFC9A@gmail.com>
 <81cd9319-848c-93f5-156d-b35226f90966@eik.bme.hu>
 <4023E866-442D-408B-9BD7-9036694DD8DF@gmail.com>
 <a4083d0c-acd5-f9da-66da-d796d09a0808@eik.bme.hu>
Message-ID: <F5E0CFB5-ABE9-448E-B76B-4D08D541A092@gmail.com>
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



Am 13=2E Februar 2025 00:13:24 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>On Wed, 12 Feb 2025, Bernhard Beschow wrote:
>> Am 7=2E Februar 2025 01:12:38 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Thu, 6 Feb 2025, Bernhard Beschow wrote:
>>>> Am 2=2E Februar 2025 01:25:22 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>>>=20
>>>> I had to apply <https://github=2Ecom/shentok/qemu/commit/56550cbb2805=
be2913ad9c12d6d9c6a9a3bf6f2c> to have the SPL load the whole U-Boot proper=
=2E
>>>=20
>>> Is that an alternative to commenting out page_aligned =3D true?
>>=20
>> Well, it's not needed with the patch applied=2E The patch ensures that =
all data gets loaded: <https://lore=2Ekernel=2Eorg/qemu-devel/D62F06C8-5247=
-4FBC-82A9-9127352B30A6@gmail=2Ecom/>
>
>I think the block layer has a solution for such long running operations a=
nd uses coroutines for that but I don't know how that works and I could not=
 find useful documentation on it=2E But I don't understand the problem eith=
er so if you've solved it and submit a patch that can be merged that's good=
 enough for me=2E
>
>>> There are two U-Boot binaries on the card for some reason (I think may=
be the first one runs from cache as RAM and sets up the memory controller),=
 then the first one loads some env variables and then the second U-Boot whi=
ch then loads the bootloader=2E
>>=20
>> Yeah, that's the SPL and U-Boot proper=2E The first one sets up RAM bas=
ed on DDR3 data, copies U-Boot proper there (currently broken in QEMU, see =
above), and passes control to it=2E
>
>U-Boot proper runs for me too but it may have a bug in the Tabor specific=
 patch (maybe revealed by missing emulation) that prevents the bootloader t=
o find a device but I can run until U-Boot and enter commands to it, it onl=
y stops in the bootloader when that calls back to U-Boot=2E If you extract =
U-Boot proper from the SD card image, convert it to elf and run it with -bi=
os you'd get a prompt so it works=2E That's what I do now for experimenting=
 but I'd like it to boot from the SD card the same way as real machine does=
 eventually=2E
>
>> Considering the technical manual it may be possible to compile U-Boot o=
neself and replace components of the firmware image=2E That way, one could =
track down why no bootable devices are found, i=2Ee=2E check whether and wh=
ich bootmenu_x variables are populated=2E That's not on my todo list though=
=2E
>
>First of all one would need the source for that which should be available=
 because of GPL but it's not, at least I could not find it yet=2E Eventuall=
y I'll get it and may look at this but I'd also like to run binary known to=
 work on real machine to make sure emulation is correct=2E
>
>>> These existing machines set up values in PPCE500MachineClass in their =
init methods that the e500=2Ec uses to change its behaviour to match the ma=
chine so to continue adding another board in the classic way I'd continue l=
ike that=2E I've added another similar board file like those machines setti=
ng the values matching P1022=2E For the additional devices in e500=2Ec I've=
 just patched them in for experimenting but these could be optionally creat=
ed based on new values in the MachineClass, like has_2nd_i2c or similar to =
not change existing machines=2E
>>=20
>> The challenge is that different variants of the SoC have the same IP co=
res mapped at different offsets with possibly (haven't checked) IRQs=2E The=
se need to be considered when generating the DTB=2E To avoid dealing with t=
his question -- and at the same time explore data-driven machine creation -=
- I reversed the process and generated the machine from the DTB=2E But this=
 question needs to be answered when implementing a P1022=2E
>
>Yes, your DTB based board code is a nice way to create different machines=
 as the DTB already describes these offsets and irq connections and your co=
de seems to be quite simple so I think it's a good idea that's worth pursui=
ng, that could enhance the ppce500 machine and make it more generic=2E It c=
ould then also drop the separate mpc85xx machine and put all of these under=
 one ppce500 machine with passing the right dtb to create the different mac=
hines=2E As long as these are similar enough and only differ in the devices=
 they have, this could emulate a lot of these SoCs with the same code=2E

The existing machines can already be created from a DTB, see the pc-bios f=
older which contains the two respective =2Edts files=2E

>
>>> I would not go into more elaborate solutions if your fdt based machine=
 creation replaces this eventually=2E
>>=20
>> As said before, I'd send an RFC for discussion on how to proceed=2E
>
>As I wrote before I think one issue to solve as a next step would be avoi=
d needing subclasses with comma in names for all compatible devices=2E I th=
ink allowing alternative names for the same type in the types hash table co=
uld be enough but to hide these from users and -device which can't take com=
ma names, these might need to go in a separate hash table instead=2E This c=
ould work the same as register_type but would be something like register_co=
mpatible_name_for_type that adds only a name for an existing type so it doe=
s not need a subclass and duplicate class or type struct when all we need i=
s a different name for the existing type=2E I don't know if it's best put i=
n a new hash table or the same one that holds type names=2E E=2Eg=2E machin=
e names already have aliases for versioned machines for example=2E This cou=
ld be similar for devices that could have alias names for compatible proper=
ty in the DTB=2E Putting these in a separate hash table might be needed if =
adding them to the same type name would list them in -device help or having=
 names with ',' there would cause a problem but it might even work without =
that=2E
>
>These are only high level ideas and I don't know how to implement these b=
ut maybe you can do something with it=2E In any case, I'm looking forward f=
or your RFC and try to help reviewing it but I don't have free time to cont=
ribute so I'll continue experimenting with the current code upstream that's=
 good enough for what I do and it's faw away to try to upstream it so by th=
en your changes could be merged=2E

Thanks for your input, I'll look into it closer after my RFC=2E Right now =
I'm quite busy driving the i=2EMX 8M Plus machine forward, hence my delayed=
 responses=2E

>What I may contribute is new device emulation for missing parts=2E I have=
 some dummy sata that does nothing but allows the Linux driver to pass dete=
cting no devices, a half working DIU I made in the last few days that needs=
 more work but I got some image from U-Boot on it and may look at the DMA c=
ontroller in the future=2E Let me know if you're interested in these or hav=
e something for these or other parts I could use instead=2E I've tested you=
r SPI flash implementation but it wasn't working with U-Boot for me and may=
 look at your USB eventually=2E

Your additions sound promising! And thanks for testing the devices=2E

>
>>>> This is implemented on my branch=2E It pokes the L2 cache registers t=
o configure some (but not all) SRAM to load the SPL to=2E This SPL uses cac=
he as RAM which I'm emulating with a modified sparse-mem region device=2E
>>>=20
>>> This is new addition from today=2E I still don't get why you need spar=
se-mem when you also have a separate patch for l2cache regs which could hav=
e a memory region itself for this but for now I'm OK with adding this regio=
n from the tabor board code on my branch for experimenting=2E
>>=20
>> The stack location is specific to U-Boot, not the chip=2E It resides in=
 cache (used as RAM) rather than in SRAM=2E Modeling a cache with cache lin=
es etc=2E was a rabbit hole I didn't want to get into=2E Hence I extended s=
parse-mem for this stack region to be user-creatable=2E When implementing a=
 Tabor machine this stack region could be hardcoded there=2E
>
>I'm not sure I follow what you say but also not sure if you meant cache w=
hen writing stack in some places=2E Sure, the whole cache with all its deta=
ils does not need to be modelled but what I meant is that if you emulate l2=
cache controller registers you could emulate the one that maps the cache at=
 some address as sram then the BOOT table at the beginning of the SD card s=
hould write that to map it at the right place so if you also have code to p=
arse that then no sparse-mem should be needed on the command line=2E Or is =
that some other register not part of l2cache? But this is something that ca=
n be sorted later so not a big deal, until then adding s memory region ther=
e either from board code or from command line will do=2E I think I get now =
that maybe you mean that command line is better because different boards ha=
ve this at different location so you need to specify the address and that's=
 easier with -device=2E

The l2cache controller manages 256kB of memory which is configured as cach=
e by default=2E The Tabor BOOT table configures part of it as RAM which inv=
olves mapping just that part into the address space=2E The SPL gets copied =
into  into it and is executed from there=2E At runtime the SPL sets up a st=
ack=2E This is another memory region disjoint from the SPL's=2E Rather than=
 configuring the new region as RAM, you can think of this region to be mark=
ed just as cacheable in the MMU=2E Hence, when the SPL uses this region as =
stack, the data will be captured by the cache rather than ending up in the =
void=2E In QEMU, the l2cache implementation creates the SPL region and the =
stack region is modeled by the sparse-mem device in order to avoid implemen=
ting a cache=2E

HTH,
Bernhard

>
>Regards,
>BALATON Zoltan

