Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0472C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s017o-0000JC-IY; Thu, 25 Apr 2024 11:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s017m-0000Io-BB
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s017k-0001Vm-6i
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714059296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SZp5Uh0oQaZ1Hq2+/IMq0uBS7yJOfARICGEcO8rEBc=;
 b=KlCNKfFWGtCTfiwXOcI11KOgo5snQ/qqns1GpZY1DCvRxJhQBcpKckUMPWiR8+k00Hg7jW
 uTLoKzfdGdNGruzyUXVYRAPoKt/URFH8gQ9xS7TcYkZPno9l235TOzeZY/LcGor3/Mw4nC
 gKU8kbtJhGmNB2wrHzx36ncK0ZyQawc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-59PijWDkP-O-gcBEWGKF-A-1; Thu, 25 Apr 2024 11:34:54 -0400
X-MC-Unique: 59PijWDkP-O-gcBEWGKF-A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-571bfa09a5eso707500a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 08:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714059294; x=1714664094;
 h=in-reply-to:references:user-agent:from:subject:cc:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8SZp5Uh0oQaZ1Hq2+/IMq0uBS7yJOfARICGEcO8rEBc=;
 b=lbqOMa0CU45nVoWDmLwqf7rWgPRGINQqdqcQjrQiPqBWQK5CkEOBF7aFIrxcc73J+Y
 YPF3hdimMBva5xLi3vxLkB/UIDAagCMGJa3wcrmuS1oZ/NOMoIQlUOhf6mBPsTCtYw2a
 W/Y60A4fwNlNP/wgjRF9pQZqDSH4MGuI+1IV5s/RNyH6EK9HBjthA3HVeARCMbBX1uJc
 Z56i0WLpcWgT6fgH+OwEq+tPujjb9N9HSbZW22TI4IKoX676G+7zIFuzYTGmaILoJCZG
 FuncGzKzq+0QPyLJ9GgZ7HEcu5AmTDk3nbSfNnhu/d9ZUtyd0C1UdipGMdNHFzecxml2
 n0DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ECriR6Ib1A+3DBDs4BETuBO1XErQiL14y4H4YHGPShrwN1HZ8QF/wXcaw3/YHz5tScFdN47bgWFZAZiUPsl04suF3kk=
X-Gm-Message-State: AOJu0YzrLpmDUorHUyfORSs9T/rFpD3+qGs+4gIFp+r52O0EBwOXjlEd
 i+R3Ho5T3kQ/+Y3KyU3npjOlpgphe167S/oV0a2WgDVUwGTbw+BuSy3ZelN2XYJDSFHzVfS+Q0u
 J5G27i+svCXW2sooPaX6iScPZ53Z/ZPJ8Quf1gnwVE/6d8w8C1hOI
X-Received: by 2002:a17:906:616:b0:a55:b037:dfc3 with SMTP id
 s22-20020a170906061600b00a55b037dfc3mr84196ejb.26.1714059293709; 
 Thu, 25 Apr 2024 08:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNyY7JO0Mylu/AXuvSXYz5+Lm/2lklPL2f7V9asskNdVkYpwuadtcaP+9zmrjoLNMtEkz6hg==
X-Received: by 2002:a17:906:616:b0:a55:b037:dfc3 with SMTP id
 s22-20020a170906061600b00a55b037dfc3mr84177ejb.26.1714059293326; 
 Thu, 25 Apr 2024 08:34:53 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 qq22-20020a17090720d600b00a554f6fbb25sm9586451ejb.138.2024.04.25.08.34.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 08:34:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Apr 2024 17:34:52 +0200
Message-Id: <D0TBB4DMA8RL.6KN35N5NVAU@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
User-Agent: aerc/0.17.0-121-g0798a428060d
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com> <ZiFNcLYyha3_teDT@redhat.com>
In-Reply-To: <ZiFNcLYyha3_teDT@redhat.com>
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

Hi Daniel,

Daniel P. Berrang=C3=A9, Apr 18, 2024 at 18:42:

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

After some investigation it seems that kvm_state is not yet committed=20
at this point. Shame, because GDB showed me that we have already pass=20
the kvm_accel_instance_init() in accel/kvm/kvm-all.c that sets the=20
value "msr_energy.enable" in kvm_state...

So should I dig more to still do the sanity check in kvm_cpu_realizefn()=20
or should I already move the RAPL feature  from -kvm to -cpu=20
like suggested by Zhao from Intel and then access it from the CPUState ?

The last one would require more work but if I can skip a new iteration=20
because I would need to do it anyway that would save me time in this end.=
=20

Thanks

Regards,
Anthony



