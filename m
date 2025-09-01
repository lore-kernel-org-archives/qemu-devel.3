Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5DACA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Bo-00058j-34; Mon, 01 Sep 2025 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut3Bm-0004wc-D9
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut3BY-0003gx-9m
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756727933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLqhidISZKYdtwaDku+KqyLfsSI4xpXN5PzFUDr90wg=;
 b=TaQALc+r+zPr3rR04wIbxCT0ZaWrTcHrzSRm49IJ2jLaiVKA6LacivUy14E0o93RqhTgG7
 QVBi8PhB1IYY8b/YJ/VrWm+Ipbj14fxd7cGzp9bBHON+VzwLv3ZLeYxFLgsZaSAyRS23+3
 oOVQfZDP8pyuvHsF5+aqmxZTF2QRVyA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-XaHnSpiYPI-W0NYuSrro3w-1; Mon, 01 Sep 2025 07:58:52 -0400
X-MC-Unique: XaHnSpiYPI-W0NYuSrro3w-1
X-Mimecast-MFC-AGG-ID: XaHnSpiYPI-W0NYuSrro3w_1756727931
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b32119e6c6so35958601cf.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727931; x=1757332731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLqhidISZKYdtwaDku+KqyLfsSI4xpXN5PzFUDr90wg=;
 b=XdQHMgCvJA+kMCEM2hkIzSdXV3bqDWYqEtS/xphkNQ2N9dKOG7fgCXC/6TMhEykuHO
 7Ue+WqaXX7GVf7nyJFCDeHVOXz0xojS2Zb3UxmKWkesM6mW9YiKCXdHVUi/pEdlT7pwt
 Hbo9qoRGIUypUf4WgQRgo80iARlNkVPKY2zILhIvZzoc2o32Rdm12EJIRzKxNXXhWH+I
 tq9uKeaABRHBWfvOBaEAWAFuSoRxeZ2ppYV4gjC6yeaIypR/ph5x+HhwpBMJAMhOH8w+
 34vkXGqG+LCiF2H8hAQOF+S9tvEeYtn0Hxu2JsOX1n+UfiHuxF8OsOvhNVjXe9j7tZg1
 wyNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGwhxADtJAwwD65WSe3xJ8k8n1BpiE2XUrA1HvvCZf17TMwFlnGUZ8W9BxawdWqssAn4s0uF5e4J/L@nongnu.org
X-Gm-Message-State: AOJu0YwNE2ZzMPMWs+rSSgHBcFsAvQxTV580tqemmTjFVl1jXvWPrjr7
 Gj4cuyhaj4AXB8sutfmjTKJD1TR4OFW1WcI1eoUcrcFs+noxHrsLokWEMmRftp+MeCJI+DC7krs
 AQYaBbFVHWFu8VOWxtb2RpnLsw0BGV+CsiLYphqlg8+AxXm679VGrR0fB
X-Gm-Gg: ASbGnctURNqAfw/fHgfnzgZ7HTZDrY0JgVLu2/sk6emnkpRTDU7Lf9Zl2bQoQdBQAqe
 Vy8NSe9E6vxA8v3ibkk1BfZcjqaC9cQLwlCNZSJFerZBmVUhk0wSHk4kdilJ88oqPDLsDJMGDbx
 pPc7vfrgwxCIALaHTYVimUGvYNVV1shbJQA+4eALg2fEPHZhBi7VaAvXTdkLrFUAmYOjNiquVcj
 yLHjwH+vNz98m5f8whPvS/YhZLBHxXV1WeruvUGiOGNzlhy9SlVbzIbJ8NFSm4JYpum5qP9HLw2
 Vebef74NHiMKbt/j0QaQ1GIa30oDBg==
X-Received: by 2002:ac8:5e4d:0:b0:4b3:219:b74a with SMTP id
 d75a77b69052e-4b31dcccadbmr96022331cf.72.1756727931364; 
 Mon, 01 Sep 2025 04:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVzSiGIacoyKAkRg9F8q4MC5XJ6qFH5lb5qdryTOPZIv+mpvzivw810mH/xt65m+97zANgJw==
X-Received: by 2002:ac8:5e4d:0:b0:4b3:219:b74a with SMTP id
 d75a77b69052e-4b31dcccadbmr96022101cf.72.1756727930976; 
 Mon, 01 Sep 2025 04:58:50 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb25c6f49sm38525136d6.15.2025.09.01.04.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:58:50 -0700 (PDT)
Date: Mon, 1 Sep 2025 13:58:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org, Song Gao
 <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: Re: [PATCH] hw/loongarch/virt: Fix the cpu hotplug issue
Message-ID: <20250901135846.12a9c3e2@fedora>
In-Reply-To: <34bc7ebf-4a7e-d2f8-65de-529ef658be49@loongson.cn>
References: <20250829013243.1237107-1-lixianglai@loongson.cn>
 <34bc7ebf-4a7e-d2f8-65de-529ef658be49@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 29 Aug 2025 10:31:57 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On 2025/8/29 =E4=B8=8A=E5=8D=889:32, Xianglai Li wrote:
> > The hot-plugged cpu does not register the cpu reset function, so the cpu
> > plugged in later cannot reset properly, and there will be problems when
> > restarting.
> >=20
> > Now register the cpu reset function in the cpu hotplug callback functio=
n. =20
> Oh, it is actually one problem and it is missing :(. There is similiar=20
> patch posted at:
> =20
> https://lore.kernel.org/qemu-devel/20241031065418.3111892-1-maobibo@loong=
son.cn/
>=20
> I prefer to adding cpu reset in CPU object realize function rather=20
> hotplug handler, and executing reset_load_elf() in board specific
> reset callback. However peter has different thoughts.

this patch and above mentioned one expose direct boot specific
reset_load_elf() on a generic hardware bring up path. That's
probably isn't right.

Ideally default (cpu_reset()) reset would happen 1st during
cpu creation/board init and then direct boot would patch
the CPU that actually would execute payload.

PS:
what's the reason to call reset_load_elf() on all present
vCPUs and why hotplugged ones matter here?

Shouldn't direct booted QEMU patch BSP only?

>=20
> Regards
> Bibo Mao
> >=20
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > ---
> >   hw/loongarch/boot.c         | 8 +-------
> >   hw/loongarch/virt.c         | 4 ++++
> >   include/hw/loongarch/virt.h | 1 +
> >   3 files changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> > index 14d6c52d4e..6bc1f3d50c 100644
> > --- a/hw/loongarch/boot.c
> > +++ b/hw/loongarch/boot.c
> > @@ -324,7 +324,7 @@ static int64_t load_kernel_info(struct loongarch_bo=
ot_info *info)
> >       return kernel_entry;
> >   }
> >  =20
> > -static void reset_load_elf(void *opaque)
> > +void reset_load_elf(void *opaque)
> >   {
> >       LoongArchCPU *cpu =3D opaque;
> >       CPULoongArchState *env =3D &cpu->env;
> > @@ -429,12 +429,6 @@ static void loongarch_direct_kernel_boot(MachineSt=
ate *ms,
> >   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_in=
fo *info)
> >   {
> >       LoongArchVirtMachineState *lvms =3D LOONGARCH_VIRT_MACHINE(ms);
> > -    int i;
> > -
> > -    /* register reset function */
> > -    for (i =3D 0; i < ms->smp.cpus; i++) {
> > -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu=
(i)));
> > -    }
> >  =20
> >       info->kernel_filename =3D ms->kernel_filename;
> >       info->kernel_cmdline =3D ms->kernel_cmdline;
> > diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> > index b15ada2078..71f8ddc980 100644
> > --- a/hw/loongarch/virt.c
> > +++ b/hw/loongarch/virt.c
> > @@ -1013,6 +1013,8 @@ static void virt_cpu_unplug(HotplugHandler *hotpl=
ug_dev,
> >       /* Notify acpi ged CPU removed */
> >       hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err=
or_abort);
> >  =20
> > +    /* unregister reset function */
> > +    qemu_unregister_reset(reset_load_elf, cpu);
> >       cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> >       cpu_slot->cpu =3D NULL;
> >   }
> > @@ -1037,6 +1039,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug=
_dev,
> >                                &error_abort);
> >       }
> >  =20
> > +    /* register reset function */
> > +    qemu_register_reset(reset_load_elf, cpu);
> >       cpu_slot =3D virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
> >       cpu_slot->cpu =3D CPU(dev);
> >   }
> > diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> > index 602feab0f0..15ea393386 100644
> > --- a/include/hw/loongarch/virt.h
> > +++ b/include/hw/loongarch/virt.h
> > @@ -71,6 +71,7 @@ struct LoongArchVirtMachineState {
> >   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_=
MACHINE)
> >   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
> >   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
> > +void reset_load_elf(void *opaque);
> >  =20
> >   static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState=
 *lvms)
> >   {
> >  =20
>=20
>=20


