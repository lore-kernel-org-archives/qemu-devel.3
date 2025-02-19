Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A17C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 11:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkiCm-0005tc-Px; Wed, 19 Feb 2025 06:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tkiCi-0005sk-Nb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:25:24 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tkiCg-0000lP-FR
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 06:25:24 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-471963ae31bso72475701cf.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1739964319; x=1740569119; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U76MIMyImaSdAXXhzV6BsoIZl+OsKtwKieV7WyvIqUM=;
 b=fu7LOflSZPH167WHPvBNaEpyqkollrkIRALXula51AaXa8S7v5IF6pWmPFIwkhYYqV
 UdZRADk8M7rFE64UWg37DAn4VHdOhFEi8tFJvhP+aMZAnHW3b65i2wIQMiuyX4wfruur
 RX136vYFdMtntJCB+8HDUGsyFYi6VVtsBzBib/BkwyJS2DjdDxX/y91nWJ39geRr4LUp
 5XItHupvDEDM6/HGMjG7GhBWWd4rjnotC3G6pnTLBJYyISAkssceawlZBWOuI2UG/P+T
 uA0IgNNobFDLAfH6DR056m4q4+4mzwxW5t0x939KhHYLNuYypQmEIQs4+nq4i3jCNgT4
 7I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739964319; x=1740569119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U76MIMyImaSdAXXhzV6BsoIZl+OsKtwKieV7WyvIqUM=;
 b=Xe62TGUTGCOfUWWDb2Dn8uTXMR2ZzYOJp2qQHRIV1+5ZLm/MZ+N9aeBg3P69l6RxZT
 yWI0+2oeBYiUKdVPnwq42qa+NicTiVud536vxN48iKHwQpOtuqPiMYqsXJciM17b5JdV
 wpeYCyh7UlgSjFz4SNfrgM9WzIM9LEEabH/MpD4HfRY77a3AZo1+qfOhniizwnNl0Rm6
 Omul1tyKpDcSrjpDpjPB4E505TYuPwnGpC8F7Vz7eLI9Dy0MhsXs5asf+GY23nSN5J4F
 TmjiPMWGRig0mvno7ZyoE5fdMPcrF4busy2k3+hyD89YJgnZ3lCv/JDUA2v1CCRxxJcM
 /J/g==
X-Gm-Message-State: AOJu0YyMc+F8YWBvUStqohRFpuGs1ddQU/1auxwCy9wV0RnBoVvIC4gv
 OoBGjWiLcN7YhKI7XpcMZFZLZZknazvXMaTQPUKE0umPCFeM5dWMmyP89d5cQR/ABgUWJ2mi62S
 NhK57OAKVwHK4AI1CRk3u1qpvCI/dd3kTpqCGzQ==
X-Gm-Gg: ASbGnct2wfwrAmIHqu3rcyzTuYyfA70ByhuEiDMFqTTBhpisS3z+61ZYLmdpXss+Ai1
 Or15i9gJdP8yOB0N1XMp99LjLij9OE9ejuqu020iRPyQJ0L1xwxURn2xu6aZ2Z7oZKVEFYHOiJo
 s=
X-Google-Smtp-Source: AGHT+IFoifCneuVPca4dsDWtQEsqNhruHsRhNM9CVHsQLQsyjKvR0skdoFliJRRopUTh8BS6lQWi/U4xT+Z9dEZIbhM=
X-Received: by 2002:ac8:5a82:0:b0:467:70ce:75f5 with SMTP id
 d75a77b69052e-471dbe7b209mr251136851cf.37.1739964319077; Wed, 19 Feb 2025
 03:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20250217081927.10613-1-yongxuan.wang@sifive.com>
 <20250217081927.10613-2-yongxuan.wang@sifive.com>
 <37cbfff3-9571-47e5-b955-41a85c7ef730@ventanamicro.com>
In-Reply-To: <37cbfff3-9571-47e5-b955-41a85c7ef730@ventanamicro.com>
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Wed, 19 Feb 2025 19:25:08 +0800
X-Gm-Features: AWEUYZlZ3a0V1Qxn_kZGNc9I2Cxq-e_eUOaYqfv7WOyFsa4uCHJCxcHUZiCoR7g
Message-ID: <CAMWQL2j32880zSM2ZesnAYReJiU2BkN7dwfGQDjAbde5t3uLUQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/riscv/virt: KVM AIA refinement
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, greentime.hu@sifive.com, 
 vincent.chen@sifive.com, frank.chang@sifive.com, jim.shu@sifive.com, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On Tue, Feb 18, 2025 at 3:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 2/17/25 5:19 AM, Yong-Xuan Wang wrote:
> > KVM AIA is only needed to be set when the virt machine use the AIA MSI.
> > So we can move the KVM AIA configuration into virt_create_aia() to redu=
ce
> > the condition checking.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
>
> Unfortunately this doesn't work.
>
> The reason is that kvm_riscv_aia_create(), as it is now, is called only o=
nce
> during virt_machine_init() and it's already handling initialization for e=
ach socket:
>
>
>      for (socket =3D 0; socket < socket_count; socket++) {
>          socket_imsic_base =3D imsic_base + socket * (1U << group_shift);
>          hart_count =3D riscv_socket_hart_count(machine, socket);
>          base_hart =3D riscv_socket_first_hartid(machine, socket);
>
>          if (max_hart_per_socket < hart_count) {
>              max_hart_per_socket =3D hart_count;
>          }
>
>          for (i =3D 0; i < hart_count; i++) {
>              imsic_addr =3D socket_imsic_base + i * IMSIC_HART_SIZE(guest=
_bits);
>              ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR=
,
>                                      KVM_DEV_RISCV_AIA_ADDR_IMSIC(i + bas=
e_hart),
>                                      &imsic_addr, true, NULL);
>              if (ret < 0) {
>                  error_report("KVM AIA: failed to set the IMSIC address f=
or hart %d", i);
>                  exit(1);
>              }
>          }
>      }
>
> After this change, kvm_riscv_aia_create() is being called once for each s=
ocket since it's
> now being called inside virt_create_aia(). And this will cause errors whe=
n running qemu-kvm
> with more than one socket:
>
> ./qemu-system-riscv64 \
>         -machine virt,accel=3Dkvm,aia=3Daplic-imsic -m 2G \
>         -object memory-backend-ram,size=3D1G,id=3Dm0 \
>         -object memory-backend-ram,size=3D1G,id=3Dm1 \
>         -smp 2,sockets=3D2,cores=3D1,threads=3D1 \
>         -numa node,memdev=3Dm0,cpus=3D0,nodeid=3D0 \
>         -numa node,memdev=3Dm1,cpus=3D1,nodeid=3D1 \
>          (...)
> qemu-system-riscv64: KVM AIA: failed to set the IMSIC address for hart 0
>

Oh I forgot to test the NUMA config. Sorry.

>
> To make this patch work we would need changes in kvm_riscv_aia_create() t=
o handle just the
> current socket. The loop I mentioned above is one place, and there's anot=
her place where
> we set group_bits and group_shift if socket_count > 1.
>

Also we need to find a place to initialize the in-kernel AIA after
setting up all the IMSICs among sockets. This would make things more
complicated. I will remove this patch in the next version. Thank you!

Regards,
Yong-Xuan


> To be honest I'm not sure if all these extra required changes are worth t=
he simplification
> this patch is proposing.
>
>
> Thanks,
>
> Daniel
>
>
>
>
>
> >   hw/riscv/virt.c | 79 +++++++++++++++++++++++-------------------------=
-
> >   1 file changed, 37 insertions(+), 42 deletions(-)
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index dae46f4733cd..a52117ef71ee 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -58,14 +58,6 @@
> >   #include "qapi/qapi-visit-common.h"
> >   #include "hw/virtio/virtio-iommu.h"
> >
> > -/* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by =
QEMU. */
> > -static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> > -{
> > -    bool msimode =3D aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC;
> > -
> > -    return riscv_is_kvm_aia_aplic_imsic(msimode);
> > -}
> > -
> >   static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
> >   {
> >       bool msimode =3D aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC;
> > @@ -1298,10 +1290,12 @@ static DeviceState *virt_create_plic(const MemM=
apEntry *memmap, int socket,
> >       return ret;
> >   }
> >
> > -static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia=
_guests,
> > +static DeviceState *virt_create_aia(RISCVVirtState *s,
> >                                       const MemMapEntry *memmap, int so=
cket,
> >                                       int base_hartid, int hart_count)
> >   {
> > +    RISCVVirtAIAType aia_type =3D s->aia_type;
> > +    int aia_guests =3D s->aia_guests;
> >       int i;
> >       hwaddr addr =3D 0;
> >       uint32_t guest_bits;
> > @@ -1309,6 +1303,28 @@ static DeviceState *virt_create_aia(RISCVVirtAIA=
Type aia_type, int aia_guests,
> >       DeviceState *aplic_m =3D NULL;
> >       bool msimode =3D aia_type =3D=3D VIRT_AIA_TYPE_APLIC_IMSIC;
> >
> > +    if (!kvm_enabled()) {
> > +        /* Per-socket M-level APLIC */
> > +        aplic_m =3D riscv_aplic_create(memmap[VIRT_APLIC_M].base +
> > +                                     socket * memmap[VIRT_APLIC_M].siz=
e,
> > +                                     memmap[VIRT_APLIC_M].size,
> > +                                     (msimode) ? 0 : base_hartid,
> > +                                     (msimode) ? 0 : hart_count,
> > +                                     VIRT_IRQCHIP_NUM_SOURCES,
> > +                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
> > +                                     msimode, true, NULL);
> > +    }
> > +
> > +    /* Per-socket S-level APLIC */
> > +    aplic_s =3D riscv_aplic_create(memmap[VIRT_APLIC_S].base +
> > +                                 socket * memmap[VIRT_APLIC_S].size,
> > +                                 memmap[VIRT_APLIC_S].size,
> > +                                 (msimode) ? 0 : base_hartid,
> > +                                 (msimode) ? 0 : hart_count,
> > +                                 VIRT_IRQCHIP_NUM_SOURCES,
> > +                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
> > +                                 msimode, false, aplic_m);
> > +
> >       if (msimode) {
> >           if (!kvm_enabled()) {
> >               /* Per-socket M-level IMSICs */
> > @@ -1329,32 +1345,20 @@ static DeviceState *virt_create_aia(RISCVVirtAI=
AType aia_type, int aia_guests,
> >                                  base_hartid + i, false, 1 + aia_guests=
,
> >                                  VIRT_IRQCHIP_NUM_MSIS);
> >           }
> > -    }
> >
> > -    if (!kvm_enabled()) {
> > -        /* Per-socket M-level APLIC */
> > -        aplic_m =3D riscv_aplic_create(memmap[VIRT_APLIC_M].base +
> > -                                     socket * memmap[VIRT_APLIC_M].siz=
e,
> > -                                     memmap[VIRT_APLIC_M].size,
> > -                                     (msimode) ? 0 : base_hartid,
> > -                                     (msimode) ? 0 : hart_count,
> > -                                     VIRT_IRQCHIP_NUM_SOURCES,
> > -                                     VIRT_IRQCHIP_NUM_PRIO_BITS,
> > -                                     msimode, true, NULL);
> > -    }
> >
> > -    /* Per-socket S-level APLIC */
> > -    aplic_s =3D riscv_aplic_create(memmap[VIRT_APLIC_S].base +
> > -                                 socket * memmap[VIRT_APLIC_S].size,
> > -                                 memmap[VIRT_APLIC_S].size,
> > -                                 (msimode) ? 0 : base_hartid,
> > -                                 (msimode) ? 0 : hart_count,
> > +        if (kvm_irqchip_in_kernel()) {
> > +            kvm_riscv_aia_create(MACHINE(s), IMSIC_MMIO_GROUP_MIN_SHIF=
T,
> >                                    VIRT_IRQCHIP_NUM_SOURCES,
> > -                                 VIRT_IRQCHIP_NUM_PRIO_BITS,
> > -                                 msimode, false, aplic_m);
> > +                                 VIRT_IRQCHIP_NUM_MSIS,
> > +                                 memmap[VIRT_APLIC_S].base,
> > +                                 memmap[VIRT_IMSIC_S].base,
> > +                                 aia_guests);
> > +        }
> >
> > -    if (kvm_enabled() && msimode) {
> > -        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
> > +        if (kvm_enabled()) {
> > +            riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr)=
;
> > +        }
> >       }
> >
> >       return kvm_enabled() ? aplic_s : aplic_m;
> > @@ -1621,9 +1625,8 @@ static void virt_machine_init(MachineState *machi=
ne)
> >               s->irqchip[i] =3D virt_create_plic(memmap, i,
> >                                                base_hartid, hart_count)=
;
> >           } else {
> > -            s->irqchip[i] =3D virt_create_aia(s->aia_type, s->aia_gues=
ts,
> > -                                            memmap, i, base_hartid,
> > -                                            hart_count);
> > +            s->irqchip[i] =3D virt_create_aia(s, memmap, i,
> > +                                            base_hartid, hart_count);
> >           }
> >
> >           /* Try to use different IRQCHIP instance based device type */
> > @@ -1641,14 +1644,6 @@ static void virt_machine_init(MachineState *mach=
ine)
> >           }
> >       }
> >
> > -    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> > -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
> > -                             VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NU=
M_MSIS,
> > -                             memmap[VIRT_APLIC_S].base,
> > -                             memmap[VIRT_IMSIC_S].base,
> > -                             s->aia_guests);
> > -    }
> > -
> >       if (riscv_is_32bit(&s->soc[0])) {
> >   #if HOST_LONG_BITS =3D=3D 64
> >           /* limit RAM size in a 32-bit system */
>

