Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A36C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 08:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0H44-0002qa-0a; Fri, 26 Apr 2024 04:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s0H3x-0002pR-2W
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s0H3v-0002DH-8b
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714120566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IldAG9zlrrL/gReM6cDzpnoELZsC8ZDOak7UdXEil1s=;
 b=KqwRPBAXG2v1KGeKXIWvIsfeEFPkGCI+VD+e9E7Iw7D33jR4717qRT25eYCdLY62Sf3J+x
 0SlQ8azdlVudfDj6NbaCaXAw5F3ZumK43DvTOFhpcri7gds0BRiwdub2dqe3wtPopAfGTJ
 sQNeSQrp9duQX7x1witbAlAXeV8ymgs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-_eS2NOX5P9GV-IjwoS3FIg-1; Fri, 26 Apr 2024 04:36:04 -0400
X-MC-Unique: _eS2NOX5P9GV-IjwoS3FIg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2dccd9dee76so16644911fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 01:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714120562; x=1714725362;
 h=in-reply-to:references:user-agent:subject:cc:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IldAG9zlrrL/gReM6cDzpnoELZsC8ZDOak7UdXEil1s=;
 b=mLitegPbyhZXb/1DFzigYY9tFrrUCR+NtDSTkY/gkX2acw23mAAXf8caFO1Wy8z8b1
 zEJfKHXhpNP6kgaTlJzrBFqTSbEsCagOf+mEAfUSOv0+OgDquqOy5F0tv5r+i69NoJ8W
 DxmaY2xRYff9Mvx8D6S/UOeCY3qwINm8JMBkE323+WJJEVz7JgiVsRZo5hLEpG6tocR4
 VDH6556+ic16lWfu9naFVnpeA+xvj9x83l22dwJTqVvlExUpJWXmjdnMRljDvzwLDH1f
 RM4MBO3KH/LPzoHH7RVomHpoyqp2tDe0s9MsJHg70o7/80z7ky5JC9wfozw338GYjrhs
 7uJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ShcEbOXFHWnB3IlEmpEzqmXNj+Zvb0/gYQqCH6qBZkObFkQpvVEFnphteck9HRDt5trdeXxhFAyFBS8I2VhLyvrAnZM=
X-Gm-Message-State: AOJu0Yw6H4CWHw/RWfQ477xTR0uIhAJcfCDL9SU1sMZ5KizTMyPgeNZ3
 A+IeUdrGVHinM3KbEwrY/qpqkob2OWj/tG4q/W6Py8heixfOwYrEQiKOUcENz+D+VXJvsc6P5cs
 OUW9ka814xLC0ZdjyGJIsWkiyExn3qkm2JEJKEKsD1HnSjWY130YRZFEdLoWz1VI=
X-Received: by 2002:a2e:9246:0:b0:2d8:729f:cf3a with SMTP id
 v6-20020a2e9246000000b002d8729fcf3amr1129300ljg.32.1714120562121; 
 Fri, 26 Apr 2024 01:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO2iLNDsl1hmB0AY7SmKygNvORppu3JXtVdxFZ6IrmJPI4TafQ7Zpl8W7GTsf0QcC6sPWnbw==
X-Received: by 2002:a2e:9246:0:b0:2d8:729f:cf3a with SMTP id
 v6-20020a2e9246000000b002d8729fcf3amr1129293ljg.32.1714120561751; 
 Fri, 26 Apr 2024 01:36:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a05600c3b1000b0041496734318sm34043225wms.24.2024.04.26.01.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 01:36:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Apr 2024 10:36:00 +0200
Message-Id: <D0TX0YRGY14M.3FU05839TNR56@redhat.com>
From: "Anthony Harivel" <aharivel@redhat.com>
To: <pbonzini@redhat.com>
Cc: <berrange@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>, <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
User-Agent: aerc/0.17.0-121-g0798a428060d
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com> <ZiFNcLYyha3_teDT@redhat.com>
 <D0TBB4DMA8RL.6KN35N5NVAU@redhat.com> <Zip57XYKiIVgf2qz@redhat.com>
In-Reply-To: <Zip57XYKiIVgf2qz@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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


Hi Paolo,

Daniel P. Berrang=C3=A9, Apr 25, 2024 at 17:42:
> On Thu, Apr 25, 2024 at 05:34:52PM +0200, Anthony Harivel wrote:
> > Hi Daniel,
> >=20
> > Daniel P. Berrang=C3=A9, Apr 18, 2024 at 18:42:
> >=20
> > > > +    if (kvm_is_rapl_feat_enable(cs)) {
> > > > +        if (!IS_INTEL_CPU(env)) {
> > > > +            error_setg(errp, "RAPL feature can only be\
> > > > +                              enabled with Intel CPU models");
> > > > +                return false;
> > > > +        }
> > > > +    }
> > >
> > > I see a crash in kvm_is_rapl_feat_enable() from this caller,
> > > when I run with this kind of command line:
> > >
> > >  $ qemu-system-x86_64 \
> > >       -kernel /lib/modules/6.6.9-100.fc38.x86_64/vmlinuz \
> > >       -initrd tiny-initrd.img  -m 2000 -serial stdio -nodefaults \
> > >       -display none -accel kvm -append "console=3DttyS0 quiet"
> > >
> > >
> > > #0  0x0000555555bc14b7 in kvm_is_rapl_feat_enable (cs=3Dcs@entry=3D0x=
555557b83470) at ../target/i386/kvm/kvm.c:2531
> > > #1  0x0000555555bc7534 in kvm_cpu_realizefn (cs=3D0x555557b83470, err=
p=3D0x7fffffffd2a0) at ../target/i386/kvm/kvm-cpu.c:54
> > > #2  0x0000555555d2432a in accel_cpu_common_realize (cpu=3D0x555557b83=
470, errp=3D0x7fffffffd2a0) at ../accel/accel-target.c:130
> > > #3  0x0000555555cdd955 in cpu_exec_realizefn (cpu=3Dcpu@entry=3D0x555=
557b83470, errp=3Derrp@entry=3D0x7fffffffd2a0) at ../cpu-target.c:137
> > > #4  0x0000555555c14b89 in x86_cpu_realizefn (dev=3D0x555557b83470, er=
rp=3D0x7fffffffd310) at ../target/i386/cpu.c:7320
> > > #5  0x0000555555d58f4b in device_set_realized (obj=3D<optimized out>,=
 value=3D<optimized out>, errp=3D0x7fffffffd390) at ../hw/core/qdev.c:510
> > > #6  0x0000555555d5d78d in property_set_bool (obj=3D0x555557b83470, v=
=3D<optimized out>, name=3D<optimized out>, opaque=3D0x5555578558e0, errp=
=3D0x7fffffffd390)
> > >     at ../qom/object.c:2358
> > > #7  0x0000555555d60b0b in object_property_set (obj=3Dobj@entry=3D0x55=
5557b83470, name=3Dname@entry=3D0x55555607c799 "realized", v=3Dv@entry=3D0x=
555557b8ccb0, errp=3D0x7fffffffd390,=20
> > >     errp@entry=3D0x555556e210d8 <error_fatal>) at ../qom/object.c:147=
2
> > > #8  0x0000555555d6444f in object_property_set_qobject
> > >     (obj=3Dobj@entry=3D0x555557b83470, name=3Dname@entry=3D0x55555607=
c799 "realized", value=3Dvalue@entry=3D0x555557854800, errp=3Derrp@entry=3D=
0x555556e210d8 <error_fatal>)
> > >     at ../qom/qom-qobject.c:28
> > > #9  0x0000555555d61174 in object_property_set_bool
> > >     (obj=3D0x555557b83470, name=3Dname@entry=3D0x55555607c799 "realiz=
ed", value=3Dvalue@entry=3Dtrue, errp=3Derrp@entry=3D0x555556e210d8 <error_=
fatal>) at ../qom/object.c:1541
> > > #10 0x0000555555d59a3c in qdev_realize (dev=3D<optimized out>, bus=3D=
bus@entry=3D0x0, errp=3Derrp@entry=3D0x555556e210d8 <error_fatal>) at ../hw=
/core/qdev.c:292
> > > #11 0x0000555555bd51e0 in x86_cpu_new (x86ms=3D<optimized out>, apic_=
id=3D0, errp=3D0x555556e210d8 <error_fatal>) at ../hw/i386/x86.c:105
> > > #12 0x0000555555bd52ce in x86_cpus_init (x86ms=3Dx86ms@entry=3D0x5555=
57aaed30, default_cpu_version=3D<optimized out>) at ../hw/i386/x86.c:156
> > > #13 0x0000555555bdc1a7 in pc_init1 (machine=3D0x555557aaed30, pci_typ=
e=3D0x55555604aa61 "i440FX") at ../hw/i386/pc_piix.c:185
> > > #14 0x0000555555947a11 in machine_run_board_init (machine=3D0x555557a=
aed30, mem_path=3D<optimized out>, errp=3D<optimized out>, errp@entry=3D0x5=
55556e210d8 <error_fatal>)
> > >     at ../hw/core/machine.c:1547
> > > #15 0x0000555555b020ed in qemu_init_board () at ../system/vl.c:2613
> > > #16 qmp_x_exit_preconfig (errp=3D0x555556e210d8 <error_fatal>) at ../=
system/vl.c:2705
> > > #17 0x0000555555b0611e in qemu_init (argc=3D<optimized out>, argv=3D<=
optimized out>) at ../system/vl.c:3739
> > > #18 0x0000555555897ca9 in main (argc=3D<optimized out>, argv=3D<optim=
ized out>) at ../system/main.c:47
> > >
> > > The problem is that 'cs->kvm_state' is NULL here
> > >
> >=20
> > After some investigation it seems that kvm_state is not yet committed=
=20
> > at this point. Shame, because GDB showed me that we have already pass=
=20
> > the kvm_accel_instance_init() in accel/kvm/kvm-all.c that sets the=20
> > value "msr_energy.enable" in kvm_state...
> >=20
> > So should I dig more to still do the sanity check in kvm_cpu_realizefn(=
)=20
> > or should I already move the RAPL feature  from -kvm to -cpu=20
> > like suggested by Zhao from Intel and then access it from the CPUState =
?
>
> I'm not so sure about that question. I think Paolo is best placed
> to suggest which is better, as the KVM maintainer.
>

I'm facing an issue that either require a simple change or a more=20
complex one depending on the decision.

TL;DR: Should I move from -kvm to -cpu the rapl feature ?=20

Zhao from Intel suggested me that enabling the rapl feature looks more=20
natural than through -kvm feature because it is indeed a cpu feature.=20

From the point of view of the QEMU architecture, it's more easier to=20
enable the feature with -kvm because it is kvm dependent; but maybe from=20
the point of view of the user, it's more natural to enable this at -cpu=20
level.=20

The issue I'm facing above is from a suggestion from Daniel to do the=20
sanity check at kvm_cpu_realizefn() level. However GDB showed me that=20
kvm_state is not yet populated, even if we have passed the init instance=20
kvm_accel_instance_init().

So either I'm moving from -kvm to -cpu and change the location of the=20
sanity check (checking if rapl feat is activated on Host / if Intel CPU)=20
or I keep the feature on -kvm and either find a solution of the above=20
issue or change the location of the sanity check.

Thanks in advance for your guidance.

Regards,
Anthony




