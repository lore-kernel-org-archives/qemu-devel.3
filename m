Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40725CA1017
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuAeS-0000ew-Ju; Thu, 04 Sep 2025 10:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uuAeQ-0000dq-3K
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uuAeF-0004GQ-N8
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756994944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/EUi8Y9shTFGtRNWqHWvth/iLI5Wr8UxERmm/ziFj8=;
 b=bG99dMxro/hgAeR/l8BcrYafiiHs1HSbDLwJtMqXGUcA54N7/1Fw/GvwoB+Ohe5ZKr6NSt
 B4F/Su4NM9lcXlzhtL5/TxuJtGmrt5x7Jec9WYv3wyPhxFWIlIbJEhHnaUF4t8H8r92Egu
 l/cThpIt/BA3BjJt8k6xikoS8UVeZT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-s-OqbN9eM2iwN5bHzUlaQQ-1; Thu, 04 Sep 2025 10:09:02 -0400
X-MC-Unique: s-OqbN9eM2iwN5bHzUlaQQ-1
X-Mimecast-MFC-AGG-ID: s-OqbN9eM2iwN5bHzUlaQQ_1756994942
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7c01a6d3so6041945e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756994942; x=1757599742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/EUi8Y9shTFGtRNWqHWvth/iLI5Wr8UxERmm/ziFj8=;
 b=W8H4jAsCwBO1O9dC3ar8zjGdeYL9Kat7dynfZcnCQgAgbwXbo8hnj3AFV9/yU3TFtE
 EdqtFBTCl+jPRXgRWY7eBJx2olNkLqqI2Jm5MvmpKecCrNo5k0qkAtLNGeRPIl26hun4
 OUkKgZHDqTbZvhUI2fcug0+wwySNIaW5vm2ze8nnsIx4T6EG+h7qaOm1DCQpqwMIR5Ry
 kM1CIElad6qsmekvVqKWD8IC5L2ZvWV0gwBM3xanqwqwl3y/7huxtwiND+ms9XC4+MdO
 6X7F4t9zsnTMYdyE6xidp+S1rh9+egAX/HLuBueXg8DM638ueWirKvgPHm5xGMhdSPLT
 j0mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOFuFpBKliS+al8GijLZP0cMVCjeFo4Ledi01/kQUwFSSFc/r8BHB7ttpPCm3X0ScmxIvbFfH16G7j@nongnu.org
X-Gm-Message-State: AOJu0YwbqfFeVvZ815tHcxVRPOVmmBWAh+1IdTDwN5/hKiABXAu9GeIg
 Du3OMZuyNIWFFbJA0mf4Bt5fGeN9tpavDAOvJ9Hb46J4AJyv7iSVuoNIfUeEEyH3jKwQPbAq2Vy
 e+YRUmvuAb1FDwnS4Csm6pa+VuI3Mjno0kCXiBfdofYS/oL3/flgtEA+0
X-Gm-Gg: ASbGncvtY6lka4Qful8yv227WRPJC/p8++5osDLQ7IpKuc3w2K5sNezEBDIK7rRRdN2
 iCWkRoJEDkXUZjgTpWpqRDyAzPWyRnHnKY4WdD1IHxGxAJiOsFlbw6pOCbWd3ipvNF//ud0QhXJ
 W5MhrqT7CRcS+qz33zkXtJhU7LGlULdpoTndwV+supRqCOLP4wrqkghm2DqU4uyyIIrbq/Y5EYV
 B35CM27pK0OtljZA2SWsNq/ggI1tFfcdJZFbMLDVSOhfap+lcRW5rS35TLp0iDwuiUYa1cBP0d6
 jvgemv20lniqkFcWnlNeFRgNT/USgA==
X-Received: by 2002:a05:600c:5303:b0:45b:86ee:415f with SMTP id
 5b1f17b1804b1-45b86ee43ebmr164563855e9.6.1756994941607; 
 Thu, 04 Sep 2025 07:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5JfmxRjhlf/pDvW4qlKtipg2aA8IZDlzhFd/a780Kmt2I7lBn2ArTdTZo3Gi2nySW8gwQiw==
X-Received: by 2002:a05:600c:5303:b0:45b:86ee:415f with SMTP id
 5b1f17b1804b1-45b86ee43ebmr164563445e9.6.1756994941179; 
 Thu, 04 Sep 2025 07:09:01 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b81a9e971sm299723275e9.18.2025.09.04.07.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 07:09:00 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:08:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Xianglai Li <lixianglai@loongson.cn>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] hw/loongarch/virt: Register reset interface with
 CPU object
Message-ID: <20250904160859.6cacea91@fedora>
In-Reply-To: <5be0c9ed-d572-42e0-e6aa-607483410bea@loongson.cn>
References: <20250903023556.3082693-1-maobibo@loongson.cn>
 <20250903023556.3082693-4-maobibo@loongson.cn>
 <20250904101347.0599daab@fedora>
 <5be0c9ed-d572-42e0-e6aa-607483410bea@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 4 Sep 2025 19:55:49 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On 2025/9/4 =E4=B8=8B=E5=8D=884:13, Igor Mammedov wrote:
> > On Wed,  3 Sep 2025 10:35:56 +0800
> > Bibo Mao <maobibo@loongson.cn> wrote:
> >  =20
> >> With cpu hotplug is implemented on LoongArch virt machine, reset
> >> interface with hot-added CPU should be registered. Otherwise there
> >> will be problem if system reboots after cpu is hot-added.
> >>
> >> Now register reset interface with CPU object is realized and remove
> >> the reset interface with CPU object unrealizd.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   hw/loongarch/boot.c    | 13 -------------
> >>   target/loongarch/cpu.c |  4 ++++
> >>   2 files changed, 4 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> >> index 5799b4c75c..a516415822 100644
> >> --- a/hw/loongarch/boot.c
> >> +++ b/hw/loongarch/boot.c
> >> @@ -350,13 +350,6 @@ static int64_t load_kernel_info(struct loongarch_=
boot_info *info)
> >>       return kernel_entry;
> >>   }
> >>  =20
> >> -static void reset_load_elf(void *opaque)
> >> -{
> >> -    LoongArchCPU *cpu =3D opaque;
> >> -
> >> -    cpu_reset(CPU(cpu));
> >> -}
> >> -
> >>   static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
> >>                                      FWCfgState *fw_cfg)
> >>   {
> >> @@ -439,12 +432,6 @@ static void loongarch_direct_kernel_boot(MachineS=
tate *ms,
> >>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_i=
nfo *info)
> >>   {
> >>       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(ms);
> >> -    int i;
> >> -
> >> -    /* register reset function */
> >> -    for (i =3D 0; i < ms->smp.cpus; i++) {
> >> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cp=
u(i)));
> >> -    }
> >>  =20
> >>       info->kernel_filename =3D ms->kernel_filename;
> >>       info->kernel_cmdline =3D ms->kernel_cmdline;
> >> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> >> index 3a7621c0ea..9edb8ebc4d 100644
> >> --- a/target/loongarch/cpu.c
> >> +++ b/target/loongarch/cpu.c
> >> @@ -668,6 +668,9 @@ static void loongarch_cpu_realizefn(DeviceState *d=
ev, Error **errp)
> >>  =20
> >>       qemu_init_vcpu(cs);
> >>       cpu_reset(cs);
> >> + #ifndef CONFIG_USER_ONLY
> >> +    qemu_register_resettable(OBJECT(dev));
> >> + #endif =20
> >=20
> > I'd put this in virt_cpu_plug() as last step, which should work both for
> > cold and hotpluged cpus. And drop CONFIG_USER_ONLY while at it. =20
> With symmetry is the same with qemu_unregister_resettable()=20
> Symmetrically, to put it in virt_cpu_unplug()?

yep

>=20
> If there are many boards in future, the boards do not need to care about=
=20
> registering cpu reset interface, which is done in CPU object already.

lets worry about more boards when that arrives.
that said, yanking reset pin on CPU is usually the board/firmware responsib=
ility.

PS:
we have reset registered in realizefn() across QEMU, largely due to histori=
cal reasons.

>=20
> Regards
> Bibo Mao
> >=20
> > with that
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >=20
> > PS:
> > the rest of the patches are very arch specific so I won't review them.
> >  =20
> >>  =20
> >>       lacc->parent_realize(dev, errp);
> >>   }
> >> @@ -678,6 +681,7 @@ static void loongarch_cpu_unrealizefn(DeviceState =
*dev)
> >>  =20
> >>   #ifndef CONFIG_USER_ONLY
> >>       cpu_remove_sync(CPU(dev));
> >> +    qemu_unregister_resettable(OBJECT(dev));
> >>   #endif
> >>  =20
> >>       lacc->parent_unrealize(dev); =20
> >  =20
>=20


