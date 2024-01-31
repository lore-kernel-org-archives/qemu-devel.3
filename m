Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142F2C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 05:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV2yq-0005E8-9r; Wed, 31 Jan 2024 00:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rV2yo-0005DX-Tp
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 00:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rV2yn-0008Eq-2K
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 00:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706678263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzYhbYkSJ3CuCWd165XM1IMUmYopyacpPokQcjSMsJ4=;
 b=EeMC6hqf1RzK5OJLavjiarQe9f69AYsmbJQ0LsC08gY6sDMfSMgyjjBzoGfV2qezAVz2bd
 SBDSoK1AJg6uY1sxJwp9uIA7XoLXyyIhdSXfwbLBzGG0pv+4hKSQHRpF3TolJU3qBbteU/
 /PGthrFgjSvpOJI0Go+37QS06DT/lqQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-shcb47oLMIqYiPkKjLPRFA-1; Wed, 31 Jan 2024 00:17:42 -0500
X-MC-Unique: shcb47oLMIqYiPkKjLPRFA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-558b84a7eeeso2510155a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 21:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706678261; x=1707283061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzYhbYkSJ3CuCWd165XM1IMUmYopyacpPokQcjSMsJ4=;
 b=vmoRGlcexkV/1eFbe9H5HjA6ax4fIi5Gx+0dyJ7NXlFq4RnYvzPg/jbEG3prUGLASS
 VKFWEJptjdCqLEEe90MEyWuPw917pBsBnNcchE7rfzU0sQss4TGNtUCaFslIswv54Un8
 hRRhxbM0ulHY9RkuB+ICkGrMc6e84t3FsJtE42WBViT3xWHUOOY4AdWpojJ1Lt1aPTSG
 aYtGUkTWpS9RGIepB92c6UThYDAhJUaoiUuz7xUPjC3Hzt25Ipka9sjmDaFNksyn5RQI
 Bu1ZoleGbxEdIQnUbaJVok4DcJOcpiQBMaSMv9Kq6Qze523BXsn33aDWKpMIengvxLGj
 +dsw==
X-Gm-Message-State: AOJu0Yygb9QLofOjasmu5EY4j1VIj1/yhKLMR6iR3iSULBAwhUZNDuBy
 8ETEuPnrtrDhby2b+cgzP1FOJB1aYhMJqc1cazxh7drwMt0ch1/kR59Ln34+gc9t05sNkN8bEcN
 NAQrs+QyTui6pM6PTPf4Ay3Qsc2pIvTJu6TuY1KD6bXT0ezwNPxURZcHPbR8gM5Lr/6ZUqzZwlk
 a7AihAilcOndSmLWnmWLC287zfA4w=
X-Received: by 2002:a17:906:28cd:b0:a36:600d:8911 with SMTP id
 p13-20020a17090628cd00b00a36600d8911mr291171ejd.10.1706678261403; 
 Tue, 30 Jan 2024 21:17:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4FVx0gAEXMgMZWAEmrDSYwGbPM/QyMVXsHmp0eH6IjTDsJ5x5HPj16bDLBWuRFoSMP4RnJR7Yg/nO5zu6y7c=
X-Received: by 2002:a17:906:28cd:b0:a36:600d:8911 with SMTP id
 p13-20020a17090628cd00b00a36600d8911mr291163ejd.10.1706678261075; Tue, 30 Jan
 2024 21:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20240131024906.3920-1-anisinha@redhat.com>
 <ZbnH9Yehg7bWY+ws@intel.com>
In-Reply-To: <ZbnH9Yehg7bWY+ws@intel.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 31 Jan 2024 10:47:29 +0530
Message-ID: <CAK3XEhOOGFtGPr6h1YpSv54QeBBjVnASUk6k59842vCvBt0qLQ@mail.gmail.com>
Subject: Re: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 kraxel@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 31, 2024 at 9:27=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Ani,
>
> On Wed, Jan 31, 2024 at 08:19:06AM +0530, Ani Sinha wrote:
> > Date: Wed, 31 Jan 2024 08:19:06 +0530
> > From: Ani Sinha <anisinha@redhat.com>
> > Subject: [PATCH v2] pc: q35: Bump max_cpus to 1856 vcpus
> > X-Mailer: git-send-email 2.42.0
> >
> > Since commit f10a570b093e6 ("KVM: x86: Add CONFIG_KVM_MAX_NR_VCPUS to a=
llow up to 4096 vCPUs")
> > Linux kernel can support upto a maximum number of 4096 vCPUS when MAXSM=
P is
> > enabled in the kernel. At present, QEMU has been tested to correctly bo=
ot a
> > linux guest with 1856 vcpus and no more both with edk2 and seabios firm=
wares.
>
> About background, could I ask if there will be Host machines with so
> much CPUs? What are the benefits of vCPUs that far exceed the number
> of Host CPUs?

Yes HPE has SAP HANA host machines with large numbers of physical
cores and memory. For example QEMU was tested on a system with 3840
cores.

>
> Thanks,
> Zhao
>
> > If an additional vcpu is added, that is with 1857 vcpus, edk2 currently=
 fails
> > with the following error messages:
> >
> > AllocatePages failed: No 0x400 Pages is available.
> > There is only left 0x2BF pages memory resource to be allocated.
> > ERROR: Out of aligned pages
> > ASSERT /builddir/build/BUILD/edk2-ba91d0292e/MdeModulePkg/Core/DxeIplPe=
im/X64/VirtualMemory.c(814): BigPageAddress !=3D 0
> >
> > This error exists only with edk2. Seabios currently can boot a linux gu=
est
> > fine with 4096 vcpus. Since the lowest common denominator for a working=
 VM for
> > both edk2 and seabios is 1856 vcpus, bump up the value max_cpus to 1856=
 for q35
> > machines versions 9 and newer. Q35 machines versions 8.2 and older cont=
inue
> > to support 1024 maximum vcpus as before for compatibility reasons.
> >
> > If KVM is not able to support the specified number of vcpus, QEMU would
> > return the following error messages:
> >
> > $ ./qemu-system-x86_64 -cpu host -accel kvm -machine q35 -smp 1728
> > qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested (=
1728) exceeds the recommended cpus supported by KVM (12)
> > qemu-system-x86_64: -accel kvm: warning: Number of hotpluggable cpus re=
quested (1728) exceeds the recommended cpus supported by KVM (12)
> > Number of SMP cpus requested (1728) exceeds the maximum cpus supported =
by KVM (1024)
> >
> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Julia Suvorova <jusual@redhat.com>
> > Cc: kraxel@redhat.com
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >  hw/i386/pc_q35.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Changelog:
> > v2: bump up the vcpu number to 1856. Add failure messages from ekd2 in
> > the commit description.
> > See also RH Jira https://issues.redhat.com/browse/RHEL-22202
> >
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index f43d5142b8..f9c4b6594d 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -375,7 +375,7 @@ static void pc_q35_machine_options(MachineClass *m)
> >      m->default_nic =3D "e1000e";
> >      m->default_kernel_irqchip_split =3D false;
> >      m->no_floppy =3D 1;
> > -    m->max_cpus =3D 1024;
> > +    m->max_cpus =3D 1856;
> >      m->no_parallel =3D !module_object_class_by_name(TYPE_ISA_PARALLEL)=
;
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
> >      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE)=
;
> > @@ -396,6 +396,7 @@ static void pc_q35_8_2_machine_options(MachineClass=
 *m)
> >  {
> >      pc_q35_9_0_machine_options(m);
> >      m->alias =3D NULL;
> > +    m->max_cpus =3D 1024;
> >      compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len=
);
> >      compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len=
);
> >  }
> > --
> > 2.42.0
> >
> >
>


