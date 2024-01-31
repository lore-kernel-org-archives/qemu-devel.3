Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7587C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7jL-00007B-HD; Wed, 31 Jan 2024 05:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rV7jJ-00006o-JW
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:22:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rV7jH-0003kt-Fj
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706696522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/MuvmI2PVv2KdQyXop6MzDJQv7POnDrRYpSHGSI7k0=;
 b=PmqzfG/CFm2NG0m5gFNUkvf8hets9RHBFaTPyI2EhlWDtrJEtluJnvZ4NMTCfngdf5Pi1p
 6XUtHubAbKvKdhTDplm7gKInFL2DAeOfDb6NulZaYV35bRFlI1hkvqectitD8vJ3k/t8tt
 5tUdyJuDnb67oFfRu+KRmFkxq1B6DEs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-luFyFVbYNQOBy0Ji03yY9g-1; Wed, 31 Jan 2024 05:22:00 -0500
X-MC-Unique: luFyFVbYNQOBy0Ji03yY9g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42a9eb912a4so14435931cf.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 02:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706696519; x=1707301319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B/MuvmI2PVv2KdQyXop6MzDJQv7POnDrRYpSHGSI7k0=;
 b=B9HbofUtV4pqpvIXaaxWsLgSQYBaek2ESe2HVZZY51rR04Jsd8lN+CXHHtm2eX4QFv
 B9lYqCSysgRoDr7U/tovOLRpAe63WUoUsJf6mBSnzE9bMJ83YJde4clo13JkppGlBx/U
 CkCmgUB3NHqdv31S308vvz4kR1vCP6ipA9AmjtPSHkQCA9DW8So68UCxn6eZJOvLpWuE
 dbP4Nl0flI8BjMbRAbOgApw/mVRcWLu5e+7utDIxpg1vbedqSYMprVyq/8xA9ZJRNBLd
 p2akhK0CQMpbSWIjCGo09BZcl8ljTQV1L2Ixq9ayzshXcf/H+o3BeFXfKWsKMwOg66Xu
 oqzQ==
X-Gm-Message-State: AOJu0YxN9FhH/pl/dZjKE96wWeHc4ney6oEW7MkqYegTecaR8AmVm1Dz
 iO+9xZE3ACjcZTxLvmYyGwf8WzbUkUd6rCfmWl7P77bFyAHcDMBJPXPqFfxczMs1mvPeXYtKt2a
 tqbQFu/v3wiS1zgp2s5Lr0IAro3MashTm6avn/Q9ldm/PEq1c31B8L+aixiYjr1l79NkRvb+bjB
 +v6o8skdT/8EM4n2hUYd+yK1JqsWk=
X-Received: by 2002:a05:622a:448:b0:42a:b64b:1fc8 with SMTP id
 o8-20020a05622a044800b0042ab64b1fc8mr3562202qtx.58.1706696519636; 
 Wed, 31 Jan 2024 02:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb4tlnLKU8JkzcahSZJSAXDdnX61hgY6PbvsfLXMOtT7gwmV2s8IjBXnYjxRaBbu8JuMTwBGLouW7wvxiipt4=
X-Received: by 2002:a05:622a:448:b0:42a:b64b:1fc8 with SMTP id
 o8-20020a05622a044800b0042ab64b1fc8mr3562190qtx.58.1706696519228; Wed, 31 Jan
 2024 02:21:59 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 31 Jan 2024 02:21:58 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <cover.1704369486.git.lixianglai@loongson.cn>
 <CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com>
 <17234d81-cc17-6859-720a-f033206780da@loongson.cn>
 <CABJz62OtwrfUj_OogStyzwk0zoh6U1+dFKRN9Y0t_y5r66WhZQ@mail.gmail.com>
 <6edc28f0-bc21-cbe3-4ce2-94c8f6073f61@loongson.cn>
MIME-Version: 1.0
In-Reply-To: <6edc28f0-bc21-cbe3-4ce2-94c8f6073f61@loongson.cn>
Date: Wed, 31 Jan 2024 02:21:58 -0800
Message-ID: <CABJz62N9Tmsgy_WbgQ0Pwr9kJUOBsEqajZ-G3=hM0aaVHHzFHg@mail.gmail.com>
Subject: Re: Re: [libvirt PATCH V2 0/4] add loongarch support for libvirt
To: lixianglai <lixianglai@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, devel@lists.libvirt.org,
 maobibo@loongson.cn, lichao@loongson.cn, jiyin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 31, 2024 at 11:20:41AM +0800, lixianglai wrote:
> > > In the qemu code, loongarch virt machine does only create a pflash,
> > >
> > > which is used for nvram, and uefi code is loaded by rom.
> > >
> > > In summary, loongarch virt machine can use nvram with the following c=
ommand:
> > >
> > > ---------------------------------------------------------------------=
----------------------------------
> > >
> > > qemu-system-loongarch64 \
> > > -m 8G \
> > > -smp 4 \
> > > -cpu la464=C2=A0\
> > > -blockdev '{"driver":"file","filename":"./QEMU_VARS-pflash.raw","node=
-name":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}'=
 \
> > > -blockdev '{"node-name":"libvirt-pflash0-format","read-only":false,"d=
river":"raw","file":"libvirt-pflash0-storage"}' \
> > > -machine virt,pflash=3Dlibvirt-pflash0-format=C2=A0\
> > > -bios ./QEMU_EFI.fd
> > >
> > > ---------------------------------------------------------------------=
----------------------------------
> > >
> > > This is really a big difference from the following boot method, and i=
t still
> > > looks weird.
> > >
> > > ---------------------------------------------------------------------=
----------------------------------
> > >
> > > -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/Q=
EMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"di=
scard":"unmap"}'
> > > -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"dr=
iver":"raw","file":"libvirt-pflash0-storage"}'
> > > -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/g=
uest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"=
discard":"unmap"}'
> > > -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"d=
river":"raw","file":"libvirt-pflash1-storage"}'
> > >
> > > ---------------------------------------------------------------------=
----------------------------------
> > >
> > > However, during the development of qemu loongarch,
> > >
> > > we also used a RISCV-like solution to create two pflash,
> > >
> > > but the qemu community suggested that we put uefi code in rom for the
> > > following reasons:
> > >
> > > https://lore.kernel.org/qemu-devel/2f381d06-842f-ac8b-085c-0419675a48=
72@linaro.org/
> > >
> > > "
> > >
> > > Since you are starting a virtual machine from scratch, you should tak=
e
> > > the opportunity to learn from other early mistakes. X86 ended that wa=
y
> > > due to 1/ old firmwares back-compability and 2/ QEMU pflash block
> > > protections not being implemented. IIUC if we were starting with a
> > > UEFI firmware today, the layout design (still using QEMU) would be
> > > to map the CODE area in a dumb ROM device, and the VARSTORE area
> > > in a PFlash device. Since Virt machines don't need to use Capsule
> > > update, having the CODE area in ROM drastically simplifies the design
> > > and maintainance.
> > >
> > > "
> > >
> > > Well, anyway, now that we have an issue with qemu loongarch using nvr=
am that
> > > is incompatible with libvirt,
> > >
> > > here I have come up with two solutions to solve this problem:
> > >
> > >
> > >     Option 1:
> > >
> > > If the interface type "rom-uefi" is added and the device type "rom-fl=
ash" is
> > > added, the json file should be written like this:
> > >
> > > ---------------------------------------------------------------------=
----------------------------------
> > >
> > > {
> > >  =C2=A0=C2=A0 "interface-types": [
> > >       "rom-uefi"
> > >  =C2=A0=C2=A0 ],
> > >  =C2=A0=C2=A0 "mapping": {
> > >       "device": "rom-flash",
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 "executable": {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": "/usr/share/edk2/lo=
ongarch64/QEMU_EFI.fd",
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "format": "raw"
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 },
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 "nvram-template": {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": "/usr/share/edk2/lo=
ongarch64/QEMU_VARS.fd",
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "format": "raw"
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 }
> > >  =C2=A0=C2=A0 },
> > >  =C2=A0=C2=A0 "targets": [
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "architecture": "loongarch64",
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "machines": [
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "virt",
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "virt-*"
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> > >  =C2=A0=C2=A0=C2=A0=C2=A0 }
> > >  =C2=A0=C2=A0 ],
> > >  =C2=A0=C2=A0 "features": [
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "acpi"
> > >  =C2=A0=C2=A0 ]
> > >
> > >  =C2=A0--------------------------------------------------------------=
-----------------------------------------
> > >
> > > Then add the parsing of the new interface types in libvirt and load
> > > QEMU_CODE.fd as -bios and QEMU_VARS.fd as nvram
> > >
> > > when creating the command line, generating commands like the followin=
g:
> > >
> > >  =C2=A0--------------------------------------------------------------=
-----------------------------------------
> > >
> > > -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/Q=
EMU_VARS.fd/","node-name":"libvirt-pflash0-storage","auto-read-only":false,=
"discard":"unmap"}' \
> > > -blockdev '{"node-name":"libvirt-pflash0-format","read-only":false,"d=
river":"raw","file":"libvirt-pflash0-storage"}' \
> > > -machine virt,pflash=3Dlibvirt-pflash0-format=C2=A0\
> > > -bios /usr/share/edk2/loongarch64///QEMU_EFI.fd \
> > >
> > > ---------------------------------------------------------------------=
----------------------------------
> > >
> > >     Option 2:
> > >
> > > Solution 2 mainly starts from qemu. Now the rom that bios is loaded i=
nto is
> > > a memory region that cannot be configured with attributes,
> > >
> > > so we imagine abstracting rom as a device, creating it during machine
> > > initialization and setting "pflash0" attribute for it.
> > >
> > > Then create a pflash and set its property to "pflash1", so our startu=
p
> > > command will look like this:
> > >
> > >  =C2=A0--------------------------------------------------------------=
-----------------------------------------
> > >
> > > -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/Q=
EMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"di=
scard":"unmap"}' \
> > > -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"dr=
iver":"raw","file":"libvirt-pflash0-storage"}' \
> > > -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/Q=
EMU_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"d=
iscard":"unmap"}' \
> > > -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"d=
river":"raw","file":"libvirt-pflash1-storage"}' \
> > > -machine virt,pflash0=3Dlibvirt-pflash0-format,pflash1=3Dlibvirt-pfla=
sh1-format \
> > >
> > >  =C2=A0--------------------------------------------------------------=
-----------------------------------------
> > >
> > > This way, without modifying libvirt, QEMU_CODE.fd can be loaded into =
the
> > > rom,
> > >
> > > but it is still a little strange that it is clearly rom but set a "pf=
lash0"
> > > attribute, which can be confusing.
> >
> > We recently had a very similar discussion regarding EFI booting on
> > RISC-V.
> >
> > Personally I would prefer to see the approach with two pflash
> > devices, one read-only and one read/write, adopted. This is pretty
> > much the de-facto standard across architectures: x86_64, aarch64 and
> > riscv64 all boot edk2 this way.
> >
> > I understand the desire to simplify things where possible, and I am
> > sympathetic towards it. If we could boot from just rom, without using
> > pflash at all, I would definitely see the appeal. However, as noted
> > earlier, in the case of EFI having some read/write storage space is
> > necessary to expose the full functionality, so going without it is
> > not really an option.
> >
> > With all the above in mind, the cost of loongarch64 doing things
> > differently from other architectures seems like it would outweight
> > the benefits, and I strongly advise against it.
>
> Hi Andrea :
>
> =C2=A0=C2=A0=C2=A0 So, just to be clear, you're not suggesting either of =
the options I
> suggested above,
>
> =C2=A0=C2=A0=C2=A0 are you? And still recommend that we use a two-piece p=
flash solution
> similar to other architectures,
>
> =C2=A0=C2=A0=C2=A0=C2=A0 right?

I thought that the second solution that you proposed above was the
same as other architectures, but reading again I think what you're
suggesting is that you'd have some logic in QEMU that ensures what
you ask to be loaded in pflash0 (CODE) would be loaded into ROM, and
what you ask to be loaded in pflash1 (VARS) would instead go into the
single pflash device for the machine?

If that's a correct understanding, my vote is emphatically against
that approach. The QEMU interface should be as "do exactly as I said"
as possible, with little to no cleverness to it. This is especially
true for a young architecture such as loongarch64, where you don't
need to be concerned about causing breakages for all the users
accumulated over decades.

> Hi Philippe :
>
> =C2=A0 I look forward to your reply and the comments of other members of =
the qemu
> community very much.
>
> =C2=A0If everyone has no opinions,
>
> I will submit a patch to the community to change the loading mode of qemu
> under loongarch architecture to UEFI with two pieces of pflash.

I think this is the way to go.

Note that changing this will likely requires adaptations in edk2 too.
That was the case when riscv64 made the same change.

--=20
Andrea Bolognani / Red Hat / Virtualization


