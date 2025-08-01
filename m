Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F84C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 11:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhnZV-00061f-9O; Fri, 01 Aug 2025 07:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhnXv-0004dH-Le
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 07:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhnXr-00058D-6B
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 07:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754046205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M1+Sk9pNo7cv/JnDp1UV7Ke86CJVvuwuc8dPgzS3R6g=;
 b=OmGQhp4eZNsv2EDyElEbyJIVXR50hPowld0OsN3e+ttlmdghMTnC6DBRqqxHCS68kDkUCj
 PY1WX6WB3R4ToXYN9KaZ1FS9m9JXrwBvF5rDJw2a0mXG+MOIu85ZHpY8Nh/wBssDTVFPhV
 EEW1Lay+ES9tdP/wO2xDGg6EGfJx5Jk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-t-CQr1D2PMWpmV6cvtMDPQ-1; Fri, 01 Aug 2025 07:03:23 -0400
X-MC-Unique: t-CQr1D2PMWpmV6cvtMDPQ-1
X-Mimecast-MFC-AGG-ID: t-CQr1D2PMWpmV6cvtMDPQ_1754046202
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-458b301d9ccso124855e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 04:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754046202; x=1754651002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1+Sk9pNo7cv/JnDp1UV7Ke86CJVvuwuc8dPgzS3R6g=;
 b=YAgB+M4Plzp9LuuhJ+fBtS4TdClRRAm55Lpp7eeppXv2agMi4qg1FeXLVhR3iJDs5O
 R5Fm+1ZEw9/kfezuRMzqD6KfPYXUSmochLZB25FYzqaRcU0Syk8j2irP0HtxVuyH891n
 Rg/gu1hB/QyNBprM3/c8AI2THKvEGC9VUNAAFK8XkAhJMLVXJ1vlkLP37AgqLaMFjkUC
 hR8heW4bIALAE+duhgc6M4rlwxKlQ2762fC4Y/7+VGxMGTZs5W0FPgBNGHlXJYMCj2PA
 UF9tqKmwrfCBLSQEK46CaFtX8uUM0W3uf/HGaxKVrSWgyRMpmaHsernPakPgjXURgZL5
 F0WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsH1zSZre/QGNYGbJvbJQj+BVbTi3wt5Ry4K9KYdp0M3JFd6gGktl2BAB/JNPGnOSel3+BWTaLfZT/@nongnu.org
X-Gm-Message-State: AOJu0Yz1tV3TKJ4h62LFP7w6CpdKuLIXG1T7Hf1/B8pqhrfW5jYYud8f
 Mmh4nfo6c+SGgtUK3H5eWC6rtelvDcC18qCzWj1ClRgne8jgzGagz15FV46vWaekz38HFxWg0R2
 Kis7XyaNAZ3dj3fzUVTUt101yTdO9EnW/rrPOOv0DzF2WwgjKtBGjTM5s
X-Gm-Gg: ASbGnctwxNtzxJMJAoeo8R2a9vlN7ssfR3+fZr3YCwBUr5+youFHm3Tmv/Zhch/M1cj
 GlaD/8y4QKUOkChhsb2kmFlVpB9jtPOieKiZuqgRM4O34n/54YckNkb6ANfThqLjMZiKXWmTDj0
 9eDK5U6M/nea9EyNEtLud57r9hkpDCX3otMUkxMuoEjigwo823eukzsDIbyxwJsJlXaNUH5fQYh
 e3l0Dij0+YU5cNZ9x1bGSjoga73kS43UW6QH2Rau5qM5ButfjSgK3m82BIn6rAZrdMWwZuhtMNd
 j13NN4BawY6h0VsN/IMgDcPzxBZ9tg==
X-Received: by 2002:a05:600c:1987:b0:442:dc6f:2f11 with SMTP id
 5b1f17b1804b1-458aa4569b5mr14729845e9.25.1754046202208; 
 Fri, 01 Aug 2025 04:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECO2UEXmaPYCZ7FtqItqqEGDoILlBCS1P9n3CDp+5lmKM0+U/9tTq+nz+jOD12wKgEqBuY2w==
X-Received: by 2002:a05:600c:1987:b0:442:dc6f:2f11 with SMTP id
 5b1f17b1804b1-458aa4569b5mr14729495e9.25.1754046201696; 
 Fri, 01 Aug 2025 04:03:21 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458af8949e1sm9186715e9.2.2025.08.01.04.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 04:03:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:03:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Gustavo Romero
 <gustavo.romero@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
Message-ID: <20250801130319.00736944@fedora>
In-Reply-To: <CAAjaMXZdHEQGi=w==iVCurTs1MrL=_2CfE+i8nTte7vjWL+T7Q@mail.gmail.com>
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
 <20250731110036.00003a0a@huawei.com>
 <e8203af151ea4f9696b809dd5de6b155@huawei.com>
 <CAAjaMXZdHEQGi=w==iVCurTs1MrL=_2CfE+i8nTte7vjWL+T7Q@mail.gmail.com>
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

On Thu, 31 Jul 2025 15:20:29 +0300
Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:

> On Thu, Jul 31, 2025 at 2:14=E2=80=AFPM Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> >
> > =20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > Sent: Thursday, July 31, 2025 11:01 AM
> > > To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > Cc: qemu-devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
> > > qemu-arm@nongnu.org; Gustavo Romero <gustavo.romero@linaro.org>;
> > > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
> > >
> > > On Wed, 30 Jul 2025 15:21:41 +0300
> > > Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
> > > =20
> > > > NVDIMM is used for fast rootfs with EROFS, for example by kata
> > > > containers. To allow booting with static NVDIMM memory, add them to
> > > > the device tree in arm virt machine.
> > > >
> > > > This allows users to boot directly with nvdimm memory devices witho=
ut
> > > > having to rely on ACPI and hotplug.
> > > >
> > > > Verified to work with command invocation:
> > > >
> > > > ./qemu-system-aarch64 \
> > > >   -M virt,nvdimm=3Don \
> > > >   -cpu cortex-a57 \
> > > >   -m 4G,slots=3D2,maxmem=3D8G \
> > > >   -object memory-backend-file,id=3Dmem1,share=3Don,mem- =20
> > > path=3D/tmp/nvdimm,size=3D4G,readonly=3Doff \ =20
> > > >   -device nvdimm,id=3Dnvdimm1,memdev=3Dmem1,unarmed=3Doff \
> > > >   -drive file=3D./debian-12-nocloud-arm64-commited.qcow2,format=3Dq=
cow2 \
> > > >   -kernel ./vmlinuz-6.1.0-13-arm64 \
> > > >   -append "root=3D/dev/vda1 console=3DttyAMA0,115200 acpi=3Doff"
> > > >   -initrd ./initrd.img-6.1.0-13-arm64 \
> > > >   -nographic \
> > > >   -serial mon:stdio
> > > >
> > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>=
 =20
> > >
> > > +CC shameer who might be able to remember how the nvdimm stuff works
> > > in
> > > +ACPI better
> > > than I can.  I think this is fine but more eyes would be good. =20
> > =20
>=20
> Hello Shameer,
>=20
> > The cold plug DT support was part of the initial NVDIMM series,
> > https://lore.kernel.org/qemu-devel/20191004155302.4632-5-shameerali.kol=
othum.thodi@huawei.com/
> >
> > But I can't remember the reason for dropping it, other than the comment=
 from
> > Igor, that why we should do it for NVDIMM but not PC-DIMM.
> > https://lore.kernel.org/qemu-devel/20191111154627.63fc061b@redhat.com/
> >
> > So, I guess there was not a strong use case for that at that time. =20
>=20
> Yes. Our motivation for this patch is just feature parity with x86.
> It's a nice-to-have, if it's possible.

if it's parity with x86, then why not use acpi like x86 does?

If I'm not mistaken, DT in arm/virt was mostly intended to bootstrap
1st steps of firmware, and the preferred way do get other info from QEMU
was via fw_cfg or standard enumeration methods (PCI/ACPI/...).

(point is: do not duplicate acpi features in DT for arm/virt machine type,
perhaps arm/sbsa-ref is a better target for DT).
=20
> >
> > The PC-DIMM DT cold plug was dropped due to the issues/obstacles mentio=
ned here,
> > https://lore.kernel.org/qemu-devel/5FC3163CFD30C246ABAA99954A238FA83F1B=
6A66@lhreml524-mbs.china.huawei.com/ =20
>=20
> Thank you very much for this link. On a first glance, if this problem
> is still happening with edk2, perhaps a temporary fix would be to only
> put coldplugged DIMMs in the device tree when the machine has acpi=3Doff
> explicitly to prevent the potential for firmware confusion?
>=20
> >
> > +CC: Igor and Eric.
> >
> > Thanks,
> > Shameer
> > =20
> > > > ---
> > > >  hw/arm/boot.c | 39 +++++++++++++++++++++++++++++++++++++++
> > > >  hw/arm/virt.c |  8 +++++---
> > > >  2 files changed, 44 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/hw/arm/boot.c b/hw/arm/boot.c index
> > > > =20
> > > d391cd01bb1b92ff213e69b84e5a69413b36c4f8..a0c1bcdf946ca98bb5da63f1
> > > a518 =20
> > > > 018eb578dd81 100644
> > > > --- a/hw/arm/boot.c
> > > > +++ b/hw/arm/boot.c
> > > > @@ -25,6 +25,7 @@
> > > >  #include "hw/boards.h"
> > > >  #include "system/reset.h"
> > > >  #include "hw/loader.h"
> > > > +#include "hw/mem/memory-device.h"
> > > >  #include "elf.h"
> > > >  #include "system/device_tree.h"
> > > >  #include "qemu/config-file.h"
> > > > @@ -515,6 +516,26 @@ static void fdt_add_psci_node(void *fdt, =20
> > > ARMCPU *armcpu) =20
> > > >      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);  }
> > > >
> > > > +static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t =
scells,
> > > > +                             int64_t mem_base, int64_t size, int64=
_t
> > > > +node) {
> > > > +    int ret;
> > > > +
> > > > +    g_autofree char *nodename =3D g_strdup_printf("/pmem@%" PRIx64,
> > > > + mem_base);
> > > > +
> > > > +    qemu_fdt_add_subnode(fdt, nodename);
> > > > +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem- =20
> > > region"); =20
> > > > +    ret =3D qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", ace=
lls,
> > > > +                                       mem_base, scells, size); =20
> > >
> > > I'd burn some lines to avoid a comment covering unrelated ret handling
> > >
> > >       if (ret)
> > >               return ret;
> > >
> > >       if (node >=3D 0) {
> > >               return qem_fdt_setprop_cell()
> > >       }
> > >
> > >       return 0;
> > > =20
> > > > +    /* only set the NUMA ID if it is specified */
> > > > +    if (!ret && node >=3D 0) {
> > > > +        ret =3D qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id=
",
> > > > +                                    node);
> > > > +    }
> > > > +
> > > > +    return ret;
> > > > +}
> > > > +
> > > >  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
> > > >                   hwaddr addr_limit, AddressSpace *as, MachineState=
 *ms,
> > > >                   ARMCPU *cpu)
> > > > @@ -525,6 +546,7 @@ int arm_load_dtb(hwaddr addr, const struct =20
> > > arm_boot_info *binfo, =20
> > > >      unsigned int i;
> > > >      hwaddr mem_base, mem_len;
> > > >      char **node_path;
> > > > +    g_autofree MemoryDeviceInfoList *md_list =3D NULL;
> > > >      Error *err =3D NULL;
> > > >
> > > >      if (binfo->dtb_filename) {
> > > > @@ -628,6 +650,23 @@ int arm_load_dtb(hwaddr addr, const struct =20
> > > arm_boot_info *binfo, =20
> > > >          }
> > > >      }
> > > >
> > > > +    md_list =3D qmp_memory_device_list();
> > > > +    for (MemoryDeviceInfoList *m =3D md_list; m !=3D NULL; m =3D m=
->next) {
> > > > +        MemoryDeviceInfo *mi =3D m->value;
> > > > +
> > > > +        if (mi->type =3D=3D MEMORY_DEVICE_INFO_KIND_NVDIMM) {
> > > > +            PCDIMMDeviceInfo *di =3D mi->u.nvdimm.data;
> > > > +
> > > > +            rc =3D fdt_add_pmem_node(fdt, acells, scells,
> > > > +                                   di->addr, di->size, di->node);
> > > > +            if (rc < 0) {
> > > > +                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx6=
4" =20
> > > node\n", =20
> > > > +                        di->addr);
> > > > +                goto fail;
> > > > +            }
> > > > +        }
> > > > +    }
> > > > +
> > > >      rc =3D fdt_path_offset(fdt, "/chosen");
> > > >      if (rc < 0) {
> > > >          qemu_fdt_add_subnode(fdt, "/chosen"); diff --git
> > > > a/hw/arm/virt.c b/hw/arm/virt.c index
> > > > =20
> > > ef6be3660f5fb38da84235c32dc2d13a5c61889c..910f5bb5f66ee217a9140f912
> > > 880 =20
> > > > 4a5b9f69b5b6 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -2917,7 +2917,7 @@ static void =20
> > > virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev, =
=20
> > > >      const MachineState *ms =3D MACHINE(hotplug_dev);
> > > >      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev),
> > > > TYPE_NVDIMM);
> > > >
> > > > -    if (!vms->acpi_dev) {
> > > > +    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
> > > >          error_setg(errp,
> > > >                     "memory hotplug is not enabled: missing acpi-ge=
d device");
> > > >          return;
> > > > @@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler =
=20
> > > *hotplug_dev, =20
> > > >          nvdimm_plug(ms->nvdimms_state);
> > > >      }
> > > >
> > > > -    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> > > > -                         dev, &error_abort);
> > > > +    if (vms->acpi_dev) {
> > > > +        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
> > > > +                             dev, &error_abort);
> > > > +    }
> > > >  }
> > > >
> > > >  static void virt_machine_device_pre_plug_cb(HotplugHandler
> > > > *hotplug_dev,
> > > >
> > > > ---
> > > > base-commit: 9b80226ece693197af8a981b424391b68b5bc38e
> > > > change-id: 20250730-nvdimm_arm64_virt-931a764bbe0c
> > > >
> > > > --
> > > > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=
=CF=87=CE=B8=CE=AE=CF=84=CF=89
> > > >
> > > > =20
> > =20
>=20


