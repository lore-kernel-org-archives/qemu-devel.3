Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66280C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmFt-0002aq-RS; Tue, 30 Jan 2024 06:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rUmFj-0002JL-00
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:26:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rUmFf-0004X9-58
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706613959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+cvj0+JWmpQv7QrivMosLH5YkbAAE8R0nw3Aj3nLcI=;
 b=EqS44u67jZrL2gBoKFysakuIj2aV8kLk9dlxIbpakmoBZGULxBdpNxBCV+e1NRS/Z9XiLl
 RczwkCayTve/0zWAW0QlysTopOua6s9OqP4gTYI4SjR7VySHI8WPDnh/VImIXLRo8pEcgI
 MM9Bsjg+T81YB1zPeiut6tzkHiIcAo0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-voVu9cDJNO-cU-tmxtxJyw-1; Tue, 30 Jan 2024 06:25:55 -0500
X-MC-Unique: voVu9cDJNO-cU-tmxtxJyw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42ab5a050caso10076481cf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706613955; x=1707218755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9+cvj0+JWmpQv7QrivMosLH5YkbAAE8R0nw3Aj3nLcI=;
 b=eD9kE3WjU6jZerAvPOo2O/YhiXdoecjDPZG5G0h48cKT6g+kDNnNIvG1+Fr/vERM6e
 uYtY+oLAzKEyypW8sMafnxanlk4mLz1puL1ltm+cPRtB73amz6THnPO7i8YuabIDqRry
 dEuDfu5ddE2eQJhdQ9sDiltTQ84s2F7A99JAJua0MnqD2m6MP9rzY+L1JZsDzV8+clJM
 O6r5IMoOvMyjwwf0pgfau0mJqkJ7U4eNBdVgngal2cs2kyZVJXaCdSS6lhJIUZiqmVi3
 5ErsJ7QSim+PbOljSikNTZrzWr8b4m4vgFydmtI41i1BXs8bH+KSyve5+Hqq23qECFOM
 U8vQ==
X-Gm-Message-State: AOJu0Yx0OO9IDycKY1yCk0+lNTDUnrf9M5JwyGCjxCC7pnzFyIfQwWuk
 +PCem2z8au3w+8g42lMzaeJFz7EjGu2nML727K7dqc29NjY4mDoe+iYyQgRUiunksW9u9Cb9hfS
 /lht9K0kGlMMxC09yQY4khVbTIsATh8OR0zoErDbfq+FwD9KMLhKIVNmbf5mn6sWkFPZqUoTiG3
 LdcYJtMnFAioA+jmmOoI5V2xXYDSM=
X-Received: by 2002:ac8:5896:0:b0:42a:9c4d:5de3 with SMTP id
 t22-20020ac85896000000b0042a9c4d5de3mr1086169qta.52.1706613954853; 
 Tue, 30 Jan 2024 03:25:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdzS8+THLpB6XVtGZowMv5/yK8/IQShN2EvGdw7ZGxEAbMnjXERh0GpUvPo3Q93tXKwWMODe0wpLLSvZ3sLHY=
X-Received: by 2002:ac8:5896:0:b0:42a:9c4d:5de3 with SMTP id
 t22-20020ac85896000000b0042a9c4d5de3mr1086148qta.52.1706613954466; Tue, 30
 Jan 2024 03:25:54 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jan 2024 03:25:53 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <cover.1704369486.git.lixianglai@loongson.cn>
 <CABJz62MxNvFfs4aCRyp+7YANupU2T4k7x1C6avm=curjB+NmkA@mail.gmail.com>
 <17234d81-cc17-6859-720a-f033206780da@loongson.cn>
MIME-Version: 1.0
In-Reply-To: <17234d81-cc17-6859-720a-f033206780da@loongson.cn>
Date: Tue, 30 Jan 2024 03:25:53 -0800
Message-ID: <CABJz62OtwrfUj_OogStyzwk0zoh6U1+dFKRN9Y0t_y5r66WhZQ@mail.gmail.com>
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
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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

On Tue, Jan 30, 2024 at 04:59:53PM +0800, lixianglai wrote:
> Hi Andrea:
>
> =C2=A0=C2=A0=C2=A0 I'm sorry for taking so long to reply you!

No worries. In the meantime, I've been busy working on some of the
enhancements the the libvirt code structure that I've mentioned
during the previous round of review, and that I hope will make your
job (as well as that of whoever comes around looking to add support
for the next architecture) somewhat easier.

> Hi Philippe:
>
> =C2=A0=C2=A0=C2=A0 When developing libvirt on loongarch, we encountered s=
ome problems
> related to pflash.
>
> libvirt and qemu met some difficulties in the coordination of UEFI loadin=
g.
>
> I think we need your suggestions and opinions on the solution.
>
> > Anyway, I fetched and installed this. The firmware descriptor looks
> > like:
> >
> >    {
> >       "interface-types": [
> >         "uefi"
> >       ],
> >       "mapping": {
> >         "device": "memory",
> >         "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd"
> >       },
> >       "targets": [
> >         {
> >           "architecture": "loongarch64",
> >           "machines": [
> >             "virt",
> >             "virt-*"
> >           ]
> >         }
> >       ],
> >       "features": [
> >           "acpi"
> >       ]
> >     }
> >
> > This is not what I expected: specifically, it results in libvirt
> > generating
> >
> >    -bios /usr/share/edk2/loongarch64/QEMU_EFI.fd
> >
> > So only one of the two files is used, in read-only mode, and there is
> > no persistent NVRAM storage that the guest can use.
> >
> > This is what I expected instead:
> >
> >    {
> >       "interface-types": [
> >         "uefi"
> >       ],
> >       "mapping": {
> >         "device": "flash",
> >         "mode": "split",
> >         "executable": {
> >           "filename": "/usr/share/edk2/loongarch64/QEMU_EFI.fd",
> >           "format": "raw"
> >         },
> >         "nvram-template": {
> >           "filename": "/usr/share/edk2/loongarch64/QEMU_VARS.fd",
> >           "format": "raw"
> >         }
> >       },
> >       "targets": [
> >         {
> >           "architecture": "loongarch64",
> >           "machines": [
> >             "virt",
> >             "virt-*"
> >           ]
> >         }
> >       ],
> >       "features": [
> >           "acpi"
> >      ]
> >    }
> >
> > I've tried installing such a descriptor and libvirt picks it up,
> > resulting in the following guest configuration:
> >
> >    <os firmware=3D'efi'>
> >      <type arch=3D'loongarch64' machine=3D'virt'>hvm</type>
> >      <firmware>
> >        <feature enabled=3D'no' name=3D'enrolled-keys'/>
> >        <feature enabled=3D'no' name=3D'secure-boot'/>
> >      </firmware>
> >      <loader readonly=3D'yes'
> > type=3D'pflash'>/usr/share/edk2/loongarch64/QEMU_EFI.fd</loader>
> >      <nvram template=3D'/usr/share/edk2/loongarch64/QEMU_VARS.fd'>/var/=
lib/libvirt/qemu/nvram/guest_VARS.fd</nvram>
> >      <boot dev=3D'hd'/>
> >    </os>
> >
> > which in turn produces the following QEMU command line options:
> >
> >    -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/=
QEMU_EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"d=
iscard":"unmap"}'
> >    -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"d=
river":"raw","file":"libvirt-pflash0-storage"}'
> >    -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/=
guest_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,=
"discard":"unmap"}'
> >    -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"=
driver":"raw","file":"libvirt-pflash1-storage"}'
> >
> > Unfortunately, with this configuration the guest fails to start:
> >
> >    qemu-system-loongarch64: Property 'virt-machine.pflash0' not found
> >
> > This error message looked familiar to me, as it is the same that I
> > hit when trying out UEFI support on RISC-V roughly a year ago[1]. In
> > this case, however, it seems that the issue runs deeper: it's not
> > just that the flash devices are not wired up to work as blockdevs,
> > but even the old -drive syntax doesn't work.
> >
> > Looking at the QEMU code, it appears that the loongarch/virt machine
> > only creates a single pflash device and exposes it via -bios. So it
> > seems that there is simply no way to achieve the configuration that
> > we want.
> >
> > I think that this is something that needs to be addressed as soon as
> > possible. In the long run, guest-accessible NVRAM storage is a must,
> > and I'm not sure it would make a lot of sense to merge loongarch
> > support into libvirt until the firmware situation has been sorted out
> > in the lower layers.
>
> In the qemu code, loongarch virt machine does only create a pflash,
>
> which is used for nvram, and uefi code is loaded by rom.
>
> In summary, loongarch virt machine can use nvram with the following comma=
nd:
>
> -------------------------------------------------------------------------=
------------------------------
>
> qemu-system-loongarch64 \
> -m 8G \
> -smp 4 \
> -cpu la464=C2=A0\
> -blockdev '{"driver":"file","filename":"./QEMU_VARS-pflash.raw","node-nam=
e":"libvirt-pflash0-storage","auto-read-only":false,"discard":"unmap"}' \
> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":false,"drive=
r":"raw","file":"libvirt-pflash0-storage"}' \
> -machine virt,pflash=3Dlibvirt-pflash0-format=C2=A0\
> -bios ./QEMU_EFI.fd
>
> -------------------------------------------------------------------------=
------------------------------
>
>
> This is really a big difference from the following boot method, and it st=
ill
> looks weird.
>
> -------------------------------------------------------------------------=
------------------------------
>
> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_=
EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discar=
d":"unmap"}'
> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver=
":"raw","file":"libvirt-pflash0-storage"}'
> -blockdev '{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/guest=
_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"disc=
ard":"unmap"}'
> -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"drive=
r":"raw","file":"libvirt-pflash1-storage"}'
>
> -------------------------------------------------------------------------=
------------------------------
>
> However, during the development of qemu loongarch,
>
> we also used a RISCV-like solution to create two pflash,
>
> but the qemu community suggested that we put uefi code in rom for the
> following reasons:
>
>
> https://lore.kernel.org/qemu-devel/2f381d06-842f-ac8b-085c-0419675a4872@l=
inaro.org/
>
> "
>
> Since you are starting a virtual machine from scratch, you should take
> the opportunity to learn from other early mistakes. X86 ended that way
> due to 1/ old firmwares back-compability and 2/ QEMU pflash block
> protections not being implemented. IIUC if we were starting with a
> UEFI firmware today, the layout design (still using QEMU) would be
> to map the CODE area in a dumb ROM device, and the VARSTORE area
> in a PFlash device. Since Virt machines don't need to use Capsule
> update, having the CODE area in ROM drastically simplifies the design
> and maintainance.
>
> "
>
> Well, anyway, now that we have an issue with qemu loongarch using nvram t=
hat
> is incompatible with libvirt,
>
> here I have come up with two solutions to solve this problem:
>
>
>    Option 1:
>
> If the interface type "rom-uefi" is added and the device type "rom-flash"=
 is
> added, the json file should be written like this:
>
> -------------------------------------------------------------------------=
------------------------------
>
> {
> =C2=A0=C2=A0 "interface-types": [
>      "rom-uefi"
> =C2=A0=C2=A0 ],
> =C2=A0=C2=A0 "mapping": {
>      "device": "rom-flash",
> =C2=A0=C2=A0=C2=A0=C2=A0 "executable": {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": "/usr/share/edk2/loongar=
ch64/QEMU_EFI.fd",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "format": "raw"
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 "nvram-template": {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": "/usr/share/edk2/loongar=
ch64/QEMU_VARS.fd",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "format": "raw"
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0 },
> =C2=A0=C2=A0 "targets": [
> =C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "architecture": "loongarch64",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "machines": [
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "virt",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "virt-*"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ]
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0 ],
> =C2=A0=C2=A0 "features": [
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "acpi"
> =C2=A0=C2=A0 ]
>
> =C2=A0-------------------------------------------------------------------=
------------------------------------
>
> Then add the parsing of the new interface types in libvirt and load
> QEMU_CODE.fd as -bios and QEMU_VARS.fd as nvram
>
> when creating the command line, generating commands like the following:
>
> =C2=A0-------------------------------------------------------------------=
------------------------------------
>
> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_=
VARS.fd/","node-name":"libvirt-pflash0-storage","auto-read-only":false,"dis=
card":"unmap"}' \
> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":false,"drive=
r":"raw","file":"libvirt-pflash0-storage"}' \
> -machine virt,pflash=3Dlibvirt-pflash0-format=C2=A0\
> -bios /usr/share/edk2/loongarch64///QEMU_EFI.fd \
>
> -------------------------------------------------------------------------=
------------------------------
>
>    Option 2:
>
> Solution 2 mainly starts from qemu. Now the rom that bios is loaded into =
is
> a memory region that cannot be configured with attributes,
>
> so we imagine abstracting rom as a device, creating it during machine
> initialization and setting "pflash0" attribute for it.
>
> Then create a pflash and set its property to "pflash1", so our startup
> command will look like this:
>
> =C2=A0-------------------------------------------------------------------=
------------------------------------
>
> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_=
EFI.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discar=
d":"unmap"}' \
> -blockdev '{"node-name":"libvirt-pflash0-format","read-only":true,"driver=
":"raw","file":"libvirt-pflash0-storage"}' \
> -blockdev '{"driver":"file","filename":"/usr/share/edk2/loongarch64/QEMU_=
VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"disca=
rd":"unmap"}' \
> -blockdev '{"node-name":"libvirt-pflash1-format","read-only":false,"drive=
r":"raw","file":"libvirt-pflash1-storage"}' \
> -machine virt,pflash0=3Dlibvirt-pflash0-format,pflash1=3Dlibvirt-pflash1-=
format \
>
> =C2=A0-------------------------------------------------------------------=
------------------------------------
>
> This way, without modifying libvirt, QEMU_CODE.fd can be loaded into the
> rom,
>
> but it is still a little strange that it is clearly rom but set a "pflash=
0"
> attribute, which can be confusing.

We recently had a very similar discussion regarding EFI booting on
RISC-V.

Personally I would prefer to see the approach with two pflash
devices, one read-only and one read/write, adopted. This is pretty
much the de-facto standard across architectures: x86_64, aarch64 and
riscv64 all boot edk2 this way.

I understand the desire to simplify things where possible, and I am
sympathetic towards it. If we could boot from just rom, without using
pflash at all, I would definitely see the appeal. However, as noted
earlier, in the case of EFI having some read/write storage space is
necessary to expose the full functionality, so going without it is
not really an option.

With all the above in mind, the cost of loongarch64 doing things
differently from other architectures seems like it would outweight
the benefits, and I strongly advise against it.

--=20
Andrea Bolognani / Red Hat / Virtualization


