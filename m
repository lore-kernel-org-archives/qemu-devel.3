Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E8CC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uqr-0004Bp-V2; Mon, 06 May 2024 05:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s3uqo-00049y-DX
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1s3uqm-0000OI-9S
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714988494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrt2pu9ujSEY/NhdqwWK9AiD4rtP9brreaTkmsmqEg4=;
 b=aPIbkLtg8d4l+FwaktFub25bUUS84R95uETYkQfvKy4lE4RUcI7tLV9WoYpUIeX+DdWqM3
 QmOZqhAP7zqQqpCaHhMd0UClPbmocTCS/zSsF/QAgcm2aWJD5bCe2ZfcGxNoB1r1/GI3Ou
 xnbarp3icktJO+hnocdUioyMf2RJaaU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-nElVRtR7Nduu-fIgPAw40A-1; Mon, 06 May 2024 05:41:32 -0400
X-MC-Unique: nElVRtR7Nduu-fIgPAw40A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-41ab62f535aso5902275e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714988491; x=1715593291;
 h=in-reply-to:references:user-agent:to:from:subject:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mrt2pu9ujSEY/NhdqwWK9AiD4rtP9brreaTkmsmqEg4=;
 b=I1O0uj41lf0uFsBpZZeZyN8GmCPaK0Kc5Udx+M4wf7B3TVdzqv+VpHbySV+bBFBp3b
 yRR4mLM4c4U1usbfiWBXS324uiE8S4xI/Jum1Kwsjj2Dirh1KpRHrY8A+4WBnTW77aov
 mW0+O5i+nuQq/cxPASBk1vst4SXkme3GYpfIAGaqkhIEbdYRnHNbUW2UHhKcQVl02lRU
 I3igxYYRazjpGolE4VUJt7Hbn67deL0QHpKpWpvGtJaToJB38o5Snk6eLODa6LQD5zFX
 3GQe5Me9XpKFPDr55a86VgaUM4dw7gEfFkXIQOz5mN2hJfqhLpobfma16kDD/T357fc+
 U2ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAXUuJPMSQrpyXur/gOxDb9EQAuGRo2Cox+2QpeHnAXuxr0s+rhOU0JMFPJBuwBcCN6Ryq64Dki+bNJZDe0VzfNIVS3og=
X-Gm-Message-State: AOJu0YwlDAbGexkCP4Rif7Vgb4Jwc4UaQesRgsXvO7wVVRq9gZbNZ8JC
 hTe48NipoAA2Sgb/NsSgGTcdrHgz9cEu7aw1Y/BN11SvGYfTCn9Pf/D1T5qPQ0/6lNyIV09WoTr
 6QXEYJW8S9NRb4ImqsRnmurzQHbYaG4OSjzZujaPvdqrwWLB7L/d+
X-Received: by 2002:a05:600c:4ece:b0:41a:5d49:6143 with SMTP id
 g14-20020a05600c4ece00b0041a5d496143mr7022369wmq.12.1714988491673; 
 Mon, 06 May 2024 02:41:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+xT5GK9nEA3wlXM8EP2eViVpr1wo+k2N7WkIIyaokASSBeki3E3u8tUoMzX+IKLqDWQdexA==
X-Received: by 2002:a05:600c:4ece:b0:41a:5d49:6143 with SMTP id
 g14-20020a05600c4ece00b0041a5d496143mr7022349wmq.12.1714988491070; 
 Mon, 06 May 2024 02:41:31 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a7bc5cf000000b00418176845ddsm7919224wmk.0.2024.05.06.02.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:41:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 11:41:29 +0200
Message-Id: <D12GOJT8L5ZQ.N6Q2YA2B2DO6@redhat.com>
Cc: <berrange@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>, <rjarry@redhat.com>, <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: <pbonzini@redhat.com>
User-Agent: aerc/0.17.0-121-g0798a428060d
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com> <ZiFNcLYyha3_teDT@redhat.com>
 <D0TBB4DMA8RL.6KN35N5NVAU@redhat.com> <Zip57XYKiIVgf2qz@redhat.com>
 <D0TX0YRGY14M.3FU05839TNR56@redhat.com>
In-Reply-To: <D0TX0YRGY14M.3FU05839TNR56@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Anthony Harivel, Apr 26, 2024 at 10:36:
>
> Hi Paolo,
>
> Daniel P. Berrang=C3=A9, Apr 25, 2024 at 17:42:
> > On Thu, Apr 25, 2024 at 05:34:52PM +0200, Anthony Harivel wrote:
> > > Hi Daniel,
> > >=20
> > > Daniel P. Berrang=C3=A9, Apr 18, 2024 at 18:42:
> > >=20
> > > > > +    if (kvm_is_rapl_feat_enable(cs)) {
> > > > > +        if (!IS_INTEL_CPU(env)) {
> > > > > +            error_setg(errp, "RAPL feature can only be\
> > > > > +                              enabled with Intel CPU models");
> > > > > +                return false;
> > > > > +        }
> > > > > +    }
> > > >
> > > > I see a crash in kvm_is_rapl_feat_enable() from this caller,
> > > > when I run with this kind of command line:
> > > >
> > > >  $ qemu-system-x86_64 \
> > > >       -kernel /lib/modules/6.6.9-100.fc38.x86_64/vmlinuz \
> > > >       -initrd tiny-initrd.img  -m 2000 -serial stdio -nodefaults \
> > > >       -display none -accel kvm -append "console=3DttyS0 quiet"
> > > >
> > > >
> > > > #0  0x0000555555bc14b7 in kvm_is_rapl_feat_enable (cs=3Dcs@entry=3D=
0x555557b83470) at ../target/i386/kvm/kvm.c:2531
> > > > #1  0x0000555555bc7534 in kvm_cpu_realizefn (cs=3D0x555557b83470, e=
rrp=3D0x7fffffffd2a0) at ../target/i386/kvm/kvm-cpu.c:54
> > > > #2  0x0000555555d2432a in accel_cpu_common_realize (cpu=3D0x555557b=
83470, errp=3D0x7fffffffd2a0) at ../accel/accel-target.c:130
> > > > #3  0x0000555555cdd955 in cpu_exec_realizefn (cpu=3Dcpu@entry=3D0x5=
55557b83470, errp=3Derrp@entry=3D0x7fffffffd2a0) at ../cpu-target.c:137
> > > > #4  0x0000555555c14b89 in x86_cpu_realizefn (dev=3D0x555557b83470, =
errp=3D0x7fffffffd310) at ../target/i386/cpu.c:7320
> > > > #5  0x0000555555d58f4b in device_set_realized (obj=3D<optimized out=
>, value=3D<optimized out>, errp=3D0x7fffffffd390) at ../hw/core/qdev.c:510
> > > > #6  0x0000555555d5d78d in property_set_bool (obj=3D0x555557b83470, =
v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x5555578558e0, errp=
=3D0x7fffffffd390)
> > > >     at ../qom/object.c:2358
> > > > #7  0x0000555555d60b0b in object_property_set (obj=3Dobj@entry=3D0x=
555557b83470, name=3Dname@entry=3D0x55555607c799 "realized", v=3Dv@entry=3D=
0x555557b8ccb0, errp=3D0x7fffffffd390,=20
> > > >     errp@entry=3D0x555556e210d8 <error_fatal>) at ../qom/object.c:1=
472
> > > > #8  0x0000555555d6444f in object_property_set_qobject
> > > >     (obj=3Dobj@entry=3D0x555557b83470, name=3Dname@entry=3D0x555556=
07c799 "realized", value=3Dvalue@entry=3D0x555557854800, errp=3Derrp@entry=
=3D0x555556e210d8 <error_fatal>)
> > > >     at ../qom/qom-qobject.c:28
> > > > #9  0x0000555555d61174 in object_property_set_bool
> > > >     (obj=3D0x555557b83470, name=3Dname@entry=3D0x55555607c799 "real=
ized", value=3Dvalue@entry=3Dtrue, errp=3Derrp@entry=3D0x555556e210d8 <erro=
r_fatal>) at ../qom/object.c:1541
> > > > #10 0x0000555555d59a3c in qdev_realize (dev=3D<optimized out>, bus=
=3Dbus@entry=3D0x0, errp=3Derrp@entry=3D0x555556e210d8 <error_fatal>) at ..=
/hw/core/qdev.c:292
> > > > #11 0x0000555555bd51e0 in x86_cpu_new (x86ms=3D<optimized out>, api=
c_id=3D0, errp=3D0x555556e210d8 <error_fatal>) at ../hw/i386/x86.c:105
> > > > #12 0x0000555555bd52ce in x86_cpus_init (x86ms=3Dx86ms@entry=3D0x55=
5557aaed30, default_cpu_version=3D<optimized out>) at ../hw/i386/x86.c:156
> > > > #13 0x0000555555bdc1a7 in pc_init1 (machine=3D0x555557aaed30, pci_t=
ype=3D0x55555604aa61 "i440FX") at ../hw/i386/pc_piix.c:185
> > > > #14 0x0000555555947a11 in machine_run_board_init (machine=3D0x55555=
7aaed30, mem_path=3D<optimized out>, errp=3D<optimized out>, errp@entry=3D0=
x555556e210d8 <error_fatal>)
> > > >     at ../hw/core/machine.c:1547
> > > > #15 0x0000555555b020ed in qemu_init_board () at ../system/vl.c:2613
> > > > #16 qmp_x_exit_preconfig (errp=3D0x555556e210d8 <error_fatal>) at .=
./system/vl.c:2705
> > > > #17 0x0000555555b0611e in qemu_init (argc=3D<optimized out>, argv=
=3D<optimized out>) at ../system/vl.c:3739
> > > > #18 0x0000555555897ca9 in main (argc=3D<optimized out>, argv=3D<opt=
imized out>) at ../system/main.c:47
> > > >
> > > > The problem is that 'cs->kvm_state' is NULL here
> > > >
> > >=20
> > > After some investigation it seems that kvm_state is not yet committed=
=20
> > > at this point. Shame, because GDB showed me that we have already pass=
=20
> > > the kvm_accel_instance_init() in accel/kvm/kvm-all.c that sets the=20
> > > value "msr_energy.enable" in kvm_state...
> > >=20
> > > So should I dig more to still do the sanity check in kvm_cpu_realizef=
n()=20
> > > or should I already move the RAPL feature  from -kvm to -cpu=20
> > > like suggested by Zhao from Intel and then access it from the CPUStat=
e ?
> >
> > I'm not so sure about that question. I think Paolo is best placed
> > to suggest which is better, as the KVM maintainer.
> >
>
> I'm facing an issue that either require a simple change or a more=20
> complex one depending on the decision.
>
> TL;DR: Should I move from -kvm to -cpu the rapl feature ?=20
>
> Zhao from Intel suggested me that enabling the rapl feature looks more=20
> natural than through -kvm feature because it is indeed a cpu feature.=20
>
> From the point of view of the QEMU architecture, it's more easier to=20
> enable the feature with -kvm because it is kvm dependent; but maybe from=
=20
> the point of view of the user, it's more natural to enable this at -cpu=
=20
> level.=20
>
> The issue I'm facing above is from a suggestion from Daniel to do the=20
> sanity check at kvm_cpu_realizefn() level. However GDB showed me that=20
> kvm_state is not yet populated, even if we have passed the init instance=
=20
> kvm_accel_instance_init().
>
> So either I'm moving from -kvm to -cpu and change the location of the=20
> sanity check (checking if rapl feat is activated on Host / if Intel CPU)=
=20
> or I keep the feature on -kvm and either find a solution of the above=20
> issue or change the location of the sanity check.
>
> Thanks in advance for your guidance.
>
> Regards,
> Anthony

Hi Paolo,

Just a gentle ping for the above question that would unlock me for the=20
next iteration.=20

Thanks a lot.

Regards,
Anthony


