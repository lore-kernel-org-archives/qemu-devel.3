Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C99DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPtX-0008Dt-Oz; Fri, 09 May 2025 11:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPtU-0008DR-Eb
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uDPtS-0001yz-9P
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746805446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3YdAPz/G+ySpv1BewJ+oTg4/vb8fkPHd3D7oo2CbsY=;
 b=ILbGEJDJv21y3rsxIbMcDBYVLxTSEbsuMkLiLJjbFJl5QRx3jzvuuEtxkTbV9zsrrTw34n
 n/DGcRDSCuyzO7m1pVOg9AYUnil8IRoKyXvr4qCZqWOX2T05oLW5InS3nYheBZftYm/b+m
 XEUNKmWKEf0rAfZME78dHxsYWdFM6ao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-faQEOsJHP5yFBALTwlDo-g-1; Fri, 09 May 2025 11:44:04 -0400
X-MC-Unique: faQEOsJHP5yFBALTwlDo-g-1
X-Mimecast-MFC-AGG-ID: faQEOsJHP5yFBALTwlDo-g_1746805443
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso15816385e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805443; x=1747410243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3YdAPz/G+ySpv1BewJ+oTg4/vb8fkPHd3D7oo2CbsY=;
 b=ocsfHgf87RbtP/Fa6C5R5lRhB1XpyYyt72MPDlXjVQAXyv+ueC5KT+gfH2kpwVQXlS
 jtIp1vtJIRe79T39JX8z5CY3AM539GBcCGE60GAerj/fx+XgUGFZkt0nUQoBl/XwOHrb
 /O7ls1nl3GUgtnlXI8YcJptAYeb+58r3wJuNdgVRsHXG1daG3R3h3PVNHdvX+5eaD/qT
 JcXkzfJFA0VpDexb1yweKQdNcnZz4Pwsn7ZrLhNU4knwCURfOmuNV6vfAFlwYR2XE/C6
 YRoictWjyShTzeTbQxnXtbQjv5N1MIsGBedVDeZ1GtToDHDVeYbqysRsNacUcf89pwyr
 5OgA==
X-Gm-Message-State: AOJu0YyyWUJ5WCDsflfQBHJgZpJ9ujqwg325k/J4c6uqRqMxL3LN9ofC
 amQti5Q7CFOzov9XjC1T/Bt+guN4a47DI8ZW4E6Rq/4ff0l8/YGxZs8PNY8lk6aF5ggUHYTQEiz
 R82uNtdeZbKajPjZHOp+UT+X5OHWEoFr4czJe7iAilognPgCt9eRb
X-Gm-Gg: ASbGncs1VrXoltotP9s4tULZ60lqJ05KQMEW5HxYocvzFaOv8K/lv2BSKHuzZscmV3o
 EMppRkZmbtZivnMi5/ofARbKkFhzzU+gX0s8E6b1EtJP8gkI3Z7YqdQBWCDQVXDWUFNSeSfqZfI
 rTTL79b2jd+RkiDkttAcI7Wl/DtyX2D9n2kmaFnIwl/SB0HalmLRMtnClrGSsIFH4dQnM1QILoV
 hmIUs80mrSaPRjszmIH989WhiE6JKXZSKTNRMN3EUGGwTy25O8bYyiXbyXLcI2WVSxGfd/p3tWF
 ylqxRvlQtjbyw4ZDq5sGXX0IXB6yf2EZ
X-Received: by 2002:a05:6000:a90:b0:3a1:f8d1:6340 with SMTP id
 ffacd0b85a97d-3a1f8d163efmr2412457f8f.34.1746805443454; 
 Fri, 09 May 2025 08:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ4tApLs/7beq2ISsmZX0H/5JPrpQGPA+N4z3F46IuN+nZ43V5QuLAvkC132uAnnrZxwdO0w==
X-Received: by 2002:a05:6000:a90:b0:3a1:f8d1:6340 with SMTP id
 ffacd0b85a97d-3a1f8d163efmr2412425f8f.34.1746805442994; 
 Fri, 09 May 2025 08:44:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2c8sm3612110f8f.61.2025.05.09.08.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:44:02 -0700 (PDT)
Date: Fri, 9 May 2025 17:44:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu
 <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>, Helge Deller
 <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha
 <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Jason
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 07/27] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Message-ID: <20250509174400.1cb2ca7b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250509174125.41bc03a3@imammedo.users.ipa.redhat.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-8-philmd@linaro.org>
 <20250509174125.41bc03a3@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 9 May 2025 17:41:25 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu,  8 May 2025 15:35:30 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
>=20
> > The X86MachineClass::fwcfg_dma_enabled boolean was only used
> > by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
> > removed. Remove it and simplify.
> >=20
> > 'multiboot.bin' isn't used anymore, we'll remove it in the
> > next commit.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  include/hw/i386/x86.h | 2 --
> >  hw/i386/microvm.c     | 3 ---
> >  hw/i386/multiboot.c   | 7 +------
> >  hw/i386/x86-common.c  | 3 +--
> >  hw/i386/x86.c         | 2 --
> >  5 files changed, 2 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> > index fc460b82f82..29d37af11e6 100644
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -29,8 +29,6 @@
> >  struct X86MachineClass {
> >      MachineClass parent;
> > =20
> > -    /* use DMA capable linuxboot option rom */
> > -    bool fwcfg_dma_enabled;
> >      /* CPU and apic information: */
> >      bool apic_xrupt_override;
> >  };
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index e0daf0d4fc3..b1262fb1523 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -637,7 +637,6 @@ GlobalProperty microvm_properties[] =3D {
> > =20
> >  static void microvm_class_init(ObjectClass *oc, const void *data)
> >  {
> > -    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(oc);
> >      MicrovmMachineClass *mmc =3D MICROVM_MACHINE_CLASS(oc);
> >      MachineClass *mc =3D MACHINE_CLASS(oc);
> >      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
> > @@ -671,8 +670,6 @@ static void microvm_class_init(ObjectClass *oc, con=
st void *data)
> >      hc->unplug_request =3D microvm_device_unplug_request_cb;
> >      hc->unplug =3D microvm_device_unplug_cb;
> > =20
> > -    x86mc->fwcfg_dma_enabled =3D true;
> > -
> >      object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
> >                                microvm_machine_get_rtc,
> >                                microvm_machine_set_rtc,
> > diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
> > index 6e6b96bc345..bfa7e8f1e83 100644
> > --- a/hw/i386/multiboot.c
> > +++ b/hw/i386/multiboot.c
> > @@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
> >                     int kernel_file_size,
> >                     uint8_t *header)
> >  {
> > -    bool multiboot_dma_enabled =3D X86_MACHINE_GET_CLASS(x86ms)->fwcfg=
_dma_enabled;
> >      int i, is_multiboot =3D 0;
> >      uint32_t flags =3D 0;
> >      uint32_t mh_entry_addr;
> > @@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
> >      fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
> >                       sizeof(bootinfo));
> > =20
> > -    if (multiboot_dma_enabled) {
> > -        option_rom[nb_option_roms].name =3D "multiboot_dma.bin";
> > -    } else {
> > -        option_rom[nb_option_roms].name =3D "multiboot.bin"; =20
>=20
> shouldn't we remove "multiboot.bin" as well?

never mind, I see it's being removed by the next patch

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


