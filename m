Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3CBC04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxV53-0001gP-Rm; Thu, 18 Apr 2024 12:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxV52-0001fb-7z
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rxV50-0006af-2m
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713459465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMoampdvB7s90DXX2WmcNuNlEXYKtE4p7HEomYYbkJU=;
 b=AJPNe7oOOXILyUhszzwDq7HGg4Zrmm6suafciB4PuJlk76ymDL+xUnkXd3jMAiE3zBa1OD
 4/Zo6CC/uO9T6ErPDSFFXuS5SXsjKH5/0+I6wH93DmudM0iHucXoY8Hg8driBTKT5ww6CJ
 IfUrCMLYdpyWICxlLRmtlQJhsdgfMvA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-gY_YOv0ZMy6VvsayNEMAPQ-1; Thu, 18 Apr 2024 12:57:43 -0400
X-MC-Unique: gY_YOv0ZMy6VvsayNEMAPQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c704fc4b32so1625055b6e.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713459463; x=1714064263;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TMoampdvB7s90DXX2WmcNuNlEXYKtE4p7HEomYYbkJU=;
 b=jXdg2yJqDRjxH1qTOsdN89k7EY/4CThnqIiR6Ki06trijbQdszSNbaNxOXmJDyEtlP
 Eiakad6TO2zMMfF6QJ7shdu+56UrwwV22PzTweScOlzypumd1KaHSzstULC8gYmDWvRv
 rLzwHEke0YzBaCPwKzxoAdTBl5E3TAqPHA5hZ95hfn2QuEqpwx4Cq4qc2u/PI/s5jt69
 qXm4EPCBGkhNimDK1eIzkSkelLexFDlhX9aPl6siRn9sGwVYA25GhzeZw9HTk5N5QtMk
 rUATj8wrOe4/Ki408dR6NhnbLBg6LX1TzTFarVP7JcLw1fVcFehyxnrkNhpZI8N3qaWd
 4VqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0RNKan6bORdSOEvIK/MXrcEepfN7/JYfN1WvcSiIm+P/efPRTh/Wo26AZI035onmax4CmrGY4esMjd2wTOG61TcLnaFA=
X-Gm-Message-State: AOJu0YxFNPlmPqJ9FEL1YAadcLFGPaN/6jaAsnBIjd8DpSeAh8LwDmid
 OLsgxYGk76czq3RWrSlysRu3Dw8ESis2rSUOziARptFTWLD2jG5vqlTtf0Zs8fq52Fy/vURbWSV
 JkWyOkTJw9h13tEaKlIEnuY1h50yQLvyqIN7JZn+O7q/m4es77BqV
X-Received: by 2002:a05:6808:308d:b0:3c5:e97b:a32 with SMTP id
 bl13-20020a056808308d00b003c5e97b0a32mr4842621oib.29.1713459463000; 
 Thu, 18 Apr 2024 09:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLAs1PAXXR8Pd4/F0cuf9PkTU7wp3EzfBCP8WwBM1nZunxvNfX7RfZ2YKnJDTlLaUEzi0NCg==
X-Received: by 2002:a05:6808:308d:b0:3c5:e97b:a32 with SMTP id
 bl13-20020a056808308d00b003c5e97b0a32mr4842587oib.29.1713459462640; 
 Thu, 18 Apr 2024 09:57:42 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 qp8-20020a05620a388800b0078f13e59dc9sm319635qkn.102.2024.04.18.09.57.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 09:57:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Apr 2024 18:57:40 +0200
Message-Id: <D0NEOP6KXJG3.2IIJ9EYG3YTD3@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
User-Agent: aerc/0.17.0-121-g0798a428060d
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com> <ZiFNcLYyha3_teDT@redhat.com>
In-Reply-To: <ZiFNcLYyha3_teDT@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


Hi Daniel,

Daniel P. Berrang=C3=A9, Apr 18, 2024 at 18:42:
> On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> > Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> > interface (Running Average Power Limit) for advertising the accumulated
> > energy consumption of various power domains (e.g. CPU packages, DRAM,
> > etc.).
> >=20
> > The consumption is reported via MSRs (model specific registers) like
> > MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> > 64 bits registers that represent the accumulated energy consumption in
> > micro Joules. They are updated by microcode every ~1ms.
> >=20
> > For now, KVM always returns 0 when the guest requests the value of
> > these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> > these MSRs dynamically in userspace.
> >=20
> > To limit the amount of system calls for every MSR call, create a new
> > thread in QEMU that updates the "virtual" MSR values asynchronously.
> >=20
> > Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> > thread updates the vMSR values with the ratio of energy consumed of
> > the whole physical CPU package the vCPU thread runs on and the
> > thread's utime and stime values.
> >=20
> > All other non-vCPU threads are also taken into account. Their energy
> > consumption is evenly distributed among all vCPUs threads running on
> > the same physical CPU package.
> >=20
> > To overcome the problem that reading the RAPL MSR requires priviliged
> > access, a socket communication between QEMU and the qemu-vmsr-helper is
> > mandatory. You can specified the socket path in the parameter.
> >=20
> > This feature is activated with -accel kvm,rapl=3Dtrue,path=3D/path/sock=
.sock
> >=20
> > Actual limitation:
> > - Works only on Intel host CPU because AMD CPUs are using different MSR
> >   adresses.
> >=20
> > - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
> >   the moment.
> >=20
> > Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> > ---
> >  accel/kvm/kvm-all.c           |  27 +++
> >  docs/specs/index.rst          |   1 +
> >  docs/specs/rapl-msr.rst       | 155 ++++++++++++
> >  include/sysemu/kvm.h          |   2 +
> >  include/sysemu/kvm_int.h      |  32 +++
> >  target/i386/cpu.h             |   8 +
> >  target/i386/kvm/kvm-cpu.c     |   9 +
> >  target/i386/kvm/kvm.c         | 428 ++++++++++++++++++++++++++++++++++
> >  target/i386/kvm/meson.build   |   1 +
> >  target/i386/kvm/vmsr_energy.c | 335 ++++++++++++++++++++++++++
> >  target/i386/kvm/vmsr_energy.h |  99 ++++++++
> >  11 files changed, 1097 insertions(+)
> >  create mode 100644 docs/specs/rapl-msr.rst
> >  create mode 100644 target/i386/kvm/vmsr_energy.c
> >  create mode 100644 target/i386/kvm/vmsr_energy.h
> >=20
>
> > diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> > index 9c791b7b0520..eafb625839b8 100644
> > --- a/target/i386/kvm/kvm-cpu.c
> > +++ b/target/i386/kvm/kvm-cpu.c
> > @@ -50,6 +50,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **=
errp)
> >                                                     MSR_IA32_UCODE_REV)=
;
> >          }
> >      }
> > +
> > +    if (kvm_is_rapl_feat_enable(cs)) {
> > +        if (!IS_INTEL_CPU(env)) {
> > +            error_setg(errp, "RAPL feature can only be\
> > +                              enabled with Intel CPU models");
> > +                return false;
> > +        }
> > +    }
>
> I see a crash in kvm_is_rapl_feat_enable() from this caller,
> when I run with this kind of command line:
>
>  $ qemu-system-x86_64 \
>       -kernel /lib/modules/6.6.9-100.fc38.x86_64/vmlinuz \
>       -initrd tiny-initrd.img  -m 2000 -serial stdio -nodefaults \
>       -display none -accel kvm -append "console=3DttyS0 quiet"
>
>
> #0  0x0000555555bc14b7 in kvm_is_rapl_feat_enable (cs=3Dcs@entry=3D0x5555=
57b83470) at ../target/i386/kvm/kvm.c:2531
> #1  0x0000555555bc7534 in kvm_cpu_realizefn (cs=3D0x555557b83470, errp=3D=
0x7fffffffd2a0) at ../target/i386/kvm/kvm-cpu.c:54
> #2  0x0000555555d2432a in accel_cpu_common_realize (cpu=3D0x555557b83470,=
 errp=3D0x7fffffffd2a0) at ../accel/accel-target.c:130
> #3  0x0000555555cdd955 in cpu_exec_realizefn (cpu=3Dcpu@entry=3D0x555557b=
83470, errp=3Derrp@entry=3D0x7fffffffd2a0) at ../cpu-target.c:137
> #4  0x0000555555c14b89 in x86_cpu_realizefn (dev=3D0x555557b83470, errp=
=3D0x7fffffffd310) at ../target/i386/cpu.c:7320
> #5  0x0000555555d58f4b in device_set_realized (obj=3D<optimized out>, val=
ue=3D<optimized out>, errp=3D0x7fffffffd390) at ../hw/core/qdev.c:510
> #6  0x0000555555d5d78d in property_set_bool (obj=3D0x555557b83470, v=3D<o=
ptimized out>, name=3D<optimized out>, opaque=3D0x5555578558e0, errp=3D0x7f=
ffffffd390)
>     at ../qom/object.c:2358
> #7  0x0000555555d60b0b in object_property_set (obj=3Dobj@entry=3D0x555557=
b83470, name=3Dname@entry=3D0x55555607c799 "realized", v=3Dv@entry=3D0x5555=
57b8ccb0, errp=3D0x7fffffffd390,=20
>     errp@entry=3D0x555556e210d8 <error_fatal>) at ../qom/object.c:1472
> #8  0x0000555555d6444f in object_property_set_qobject
>     (obj=3Dobj@entry=3D0x555557b83470, name=3Dname@entry=3D0x55555607c799=
 "realized", value=3Dvalue@entry=3D0x555557854800, errp=3Derrp@entry=3D0x55=
5556e210d8 <error_fatal>)
>     at ../qom/qom-qobject.c:28
> #9  0x0000555555d61174 in object_property_set_bool
>     (obj=3D0x555557b83470, name=3Dname@entry=3D0x55555607c799 "realized",=
 value=3Dvalue@entry=3Dtrue, errp=3Derrp@entry=3D0x555556e210d8 <error_fata=
l>) at ../qom/object.c:1541
> #10 0x0000555555d59a3c in qdev_realize (dev=3D<optimized out>, bus=3Dbus@=
entry=3D0x0, errp=3Derrp@entry=3D0x555556e210d8 <error_fatal>) at ../hw/cor=
e/qdev.c:292
> #11 0x0000555555bd51e0 in x86_cpu_new (x86ms=3D<optimized out>, apic_id=
=3D0, errp=3D0x555556e210d8 <error_fatal>) at ../hw/i386/x86.c:105
> #12 0x0000555555bd52ce in x86_cpus_init (x86ms=3Dx86ms@entry=3D0x555557aa=
ed30, default_cpu_version=3D<optimized out>) at ../hw/i386/x86.c:156
> #13 0x0000555555bdc1a7 in pc_init1 (machine=3D0x555557aaed30, pci_type=3D=
0x55555604aa61 "i440FX") at ../hw/i386/pc_piix.c:185
> #14 0x0000555555947a11 in machine_run_board_init (machine=3D0x555557aaed3=
0, mem_path=3D<optimized out>, errp=3D<optimized out>, errp@entry=3D0x55555=
6e210d8 <error_fatal>)
>     at ../hw/core/machine.c:1547
> #15 0x0000555555b020ed in qemu_init_board () at ../system/vl.c:2613
> #16 qmp_x_exit_preconfig (errp=3D0x555556e210d8 <error_fatal>) at ../syst=
em/vl.c:2705
> #17 0x0000555555b0611e in qemu_init (argc=3D<optimized out>, argv=3D<opti=
mized out>) at ../system/vl.c:3739
> #18 0x0000555555897ca9 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at ../system/main.c:47
>
> The problem is that 'cs->kvm_state' is NULL here
>

Oh boy... Thanks for the feedback!
I'll put that on my priority list for tomorrow.

Regards,
Anthony

> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


