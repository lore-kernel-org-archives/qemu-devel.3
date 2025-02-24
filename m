Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1540C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfTs-0002tv-TU; Mon, 24 Feb 2025 15:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tmfTn-0002q2-Dx
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:55:07 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tmfTk-0005WL-M2
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:55:07 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dbfc122b82so2969a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740430503; x=1741035303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P1J0GeWm5MJLjeHwTWIr2ypSEGDFmTu7z9+C3tEHxms=;
 b=2gVLAYJlsSGDaLaDGuGiujq5Kx53VljpkpCnsEmGNp0yEpvrks6r3CufXvOS7Nqjl9
 5Yo/BkbGXcstkBLiqLSuXQA9iVGdYBYQsD8uatL7CsYBIjmmHUImciu+dTaE/7j+llvg
 aRgHvdxNmSiwH0GGLe4lElSOS3br1p09EKSf4OogBtKukkFeBMMux3mgECPvuBUyeEtz
 5lHVF4ZlHwg+4J0luF5K4nroRM8XwzKOub2IsFBoFbsYo3MZjWCDRZ0QhOY3vvk6vHcW
 PtPzfwMZw2FZI2Ccexc5KDmA80V3U/qxRrbACg6K0fVHEOrGmxqUa+FU7xAAAL5h+kNB
 4Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740430503; x=1741035303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P1J0GeWm5MJLjeHwTWIr2ypSEGDFmTu7z9+C3tEHxms=;
 b=MkkRCqCGTAKaWqQ+OOFRXs2l9cyERFIe96NRWiChHKYhREyUoTaO2CjIE9EOLyfUn3
 LywbocjwtEnX3nes8KIPautCQjh5DIyH7ZLwWaqTKX3HZTfrWfPDgwlZSOWf8JYKHEzQ
 rMMyQM75m5riDvX6QhuFKMQfrhs0BbZGnJIcDMDLugnhi84vii+e+cgFtb8m+/8oxkk6
 x8edzPIk4R+Lk9nIxQm09jyisNKAiV8NLIMEtC4DKQnEQIhZlo09xx4CdC9f/305gxGC
 RbHxo+HMH27xl6kg8htKrLv+SnO9KwymKm6mBOrLbBWXhIIJttiEbwPBeIpOdmKNIMz6
 CD+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9m8uLabMUm2eQZmsJyYTc70JnnH/ZpaMIrGyk4GsrT2h44KtnU8svTkY62ddJisUjiBIFVcxkLV17@nongnu.org
X-Gm-Message-State: AOJu0YwuWYXLJiJ+ttiy3Winl9n4IPa0t43ZrgHMT6lmpM2RS9sYOb6c
 iWiYaP23txLyQETccM/cFKzgYfgbsxb+iCfWzz+UZo74aL2UJ0qQxHtDiK5eyEKVKTd9YnyOy1N
 0w4sA567+ZkC/L2bMRrnbngLHPR65NXuxqUG0
X-Gm-Gg: ASbGnctZmplsqV0NCjXwp5niPnq0B76ZzjBHFSO/ry5pNUggMOBFGEG1HOloFyeXPkC
 UYbzEth82GyPSrIBce+CNeQS5uup3+/m3/d0w7a5N16ltziu8SvexZ5sMH06KMueB74CdDhCKaM
 e3QxkdanQd3q2M8IiJx0pQLrYuEi2z6HRRfbxh
X-Google-Smtp-Source: AGHT+IEgzHjX4r6QQo4rrXAnU2egsv9pQ+bfJ602JzbozKCn0XeCQyWntg7pr/UY7YA+rd7TFUFVdizgVSvFQrCGF0Q=
X-Received: by 2002:aa7:c741:0:b0:5e0:fea1:143a with SMTP id
 4fb4d7f45d1cf-5e40a069c8fmr31276a12.7.1740430502869; Mon, 24 Feb 2025
 12:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20250219184609.1839281-1-wuhaotsh@google.com>
 <20250219184609.1839281-7-wuhaotsh@google.com>
 <4ff5c838-27b8-43ce-adb9-1816c9e4a097@linaro.org>
In-Reply-To: <4ff5c838-27b8-43ce-adb9-1816c9e4a097@linaro.org>
From: Hao Wu <wuhaotsh@google.com>
Date: Mon, 24 Feb 2025 12:54:48 -0800
X-Gm-Features: AWEUYZnlgphwWGCVTBBgQWtERUG4s3BUArGIo9GgOj0wjxxiSJaTLddQfgNggoU
Message-ID: <CAGcCb10vwMzjidhEdmxV9DS4oH+r6yvzDF5UY5aPwwMtMWwwPg@mail.gmail.com>
Subject: Re: [PATCH v5 06/17] hw/misc: Add nr_regs and cold_reset_values to
 NPCM GCR
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 venture@google.com, Avi.Fishman@nuvoton.com, kfting@nuvoton.com, 
 hskinnemoen@google.com, titusr@google.com, 
 chli30@nuvoton.corp-partner.google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me, philmd@linaro.org
Content-Type: multipart/alternative; boundary="000000000000e1b2b4062ee98d5a"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=wuhaotsh@google.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000e1b2b4062ee98d5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! I can review the patch.

On Mon, Feb 24, 2025 at 12:52=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> Hello,
>
> This patch introduces a buffer-overflow, now reported by address sanitize=
r.
>
> I sent a patch:
> https://lore.kernel.org/qemu-devel/20250224205053.104959-1-
> pierrick.bouvier@linaro.org/T/#u
>
> You're welcome to review it, or fix the problem differently if there is
> a better approach.
>
> Regards,
> Pierrick
>
> On 2/19/25 10:45, Hao Wu wrote:
> > These 2 values are different between NPCM7XX and NPCM8XX
> > GCRs. So we add them to the class and assign different values
> > to them.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Hao Wu <wuhaotsh@google.com>
> > ---
> >   hw/misc/npcm_gcr.c         | 27 ++++++++++++++++-----------
> >   include/hw/misc/npcm_gcr.h | 13 +++++++++++--
> >   2 files changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c
> > index 0959f2e5c4..d89e8c2c3b 100644
> > --- a/hw/misc/npcm_gcr.c
> > +++ b/hw/misc/npcm_gcr.c
> > @@ -66,10 +66,9 @@ enum NPCM7xxGCRRegisters {
> >       NPCM7XX_GCR_SCRPAD          =3D 0x013c / sizeof(uint32_t),
> >       NPCM7XX_GCR_USB1PHYCTL,
> >       NPCM7XX_GCR_USB2PHYCTL,
> > -    NPCM7XX_GCR_REGS_END,
> >   };
> >
> > -static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] =3D {
> > +static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] =
=3D {
> >       [NPCM7XX_GCR_PDID]          =3D 0x04a92750,   /* Poleg A1 */
> >       [NPCM7XX_GCR_MISCPE]        =3D 0x0000ffff,
> >       [NPCM7XX_GCR_SPSWC]         =3D 0x00000003,
> > @@ -88,8 +87,9 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr
> offset, unsigned size)
> >   {
> >       uint32_t reg =3D offset / sizeof(uint32_t);
> >       NPCMGCRState *s =3D opaque;
> > +    NPCMGCRClass *c =3D NPCM_GCR_GET_CLASS(s);
> >
> > -    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
> > +    if (reg >=3D c->nr_regs) {
> >           qemu_log_mask(LOG_GUEST_ERROR,
> >                         "%s: offset 0x%04" HWADDR_PRIx " out of range\n=
",
> >                         __func__, offset);
> > @@ -106,11 +106,12 @@ static void npcm_gcr_write(void *opaque, hwaddr
> offset,
> >   {
> >       uint32_t reg =3D offset / sizeof(uint32_t);
> >       NPCMGCRState *s =3D opaque;
> > +    NPCMGCRClass *c =3D NPCM_GCR_GET_CLASS(s);
> >       uint32_t value =3D v;
> >
> > -    trace_npcm_gcr_write(offset, value);
> > +    trace_npcm_gcr_write(offset, v);
> >
> > -    if (reg >=3D NPCM7XX_GCR_NR_REGS) {
> > +    if (reg >=3D c->nr_regs) {
> >           qemu_log_mask(LOG_GUEST_ERROR,
> >                         "%s: offset 0x%04" HWADDR_PRIx " out of range\n=
",
> >                         __func__, offset);
> > @@ -156,10 +157,12 @@ static const struct MemoryRegionOps npcm_gcr_ops =
=3D
> {
> >   static void npcm7xx_gcr_enter_reset(Object *obj, ResetType type)
> >   {
> >       NPCMGCRState *s =3D NPCM_GCR(obj);
> > +    NPCMGCRClass *c =3D NPCM_GCR_GET_CLASS(obj);
> >
> > -    QEMU_BUILD_BUG_ON(sizeof(s->regs) !=3D sizeof(cold_reset_values));
> > -
> > -    memcpy(s->regs, cold_reset_values, sizeof(s->regs));
> > +    g_assert(sizeof(s->regs) >=3D sizeof(c->cold_reset_values));
> > +    g_assert(sizeof(s->regs) >=3D c->nr_regs * sizeof(uint32_t));
> > +    memcpy(s->regs, c->cold_reset_values, c->nr_regs *
> sizeof(uint32_t));
> > +    /* These 3 registers are at the same location in both 7xx and 8xx.
> */
> >       s->regs[NPCM7XX_GCR_PWRON] =3D s->reset_pwron;
> >       s->regs[NPCM7XX_GCR_MDLR] =3D s->reset_mdlr;
> >       s->regs[NPCM7XX_GCR_INTCR3] =3D s->reset_intcr3;
> > @@ -224,7 +227,7 @@ static const VMStateDescription vmstate_npcm_gcr =
=3D {
> >       .version_id =3D 1,
> >       .minimum_version_id =3D 1,
> >       .fields =3D (const VMStateField[]) {
> > -        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM7XX_GCR_NR_REGS),
> > +        VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, NPCM_GCR_MAX_NR_REGS)=
,
> >           VMSTATE_END_OF_LIST(),
> >       },
> >   };
> > @@ -238,7 +241,6 @@ static void npcm_gcr_class_init(ObjectClass *klass,
> void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> >
> > -    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END > NPCM7XX_GCR_NR_REGS);
> >       dc->realize =3D npcm_gcr_realize;
> >       dc->vmsd =3D &vmstate_npcm_gcr;
> >
> > @@ -247,13 +249,15 @@ static void npcm_gcr_class_init(ObjectClass
> *klass, void *data)
> >
> >   static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
> >   {
> > +    NPCMGCRClass *c =3D NPCM_GCR_CLASS(klass);
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> >       ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> >
> > -    QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END !=3D NPCM7XX_GCR_NR_REGS);
> >       dc->desc =3D "NPCM7xx System Global Control Registers";
> >       rc->phases.enter =3D npcm7xx_gcr_enter_reset;
> >
> > +    c->nr_regs =3D NPCM7XX_GCR_NR_REGS;
> > +    c->cold_reset_values =3D npcm7xx_cold_reset_values;
> >   }
> >
> >   static const TypeInfo npcm_gcr_info[] =3D {
> > @@ -262,6 +266,7 @@ static const TypeInfo npcm_gcr_info[] =3D {
> >           .parent             =3D TYPE_SYS_BUS_DEVICE,
> >           .instance_size      =3D sizeof(NPCMGCRState),
> >           .instance_init      =3D npcm_gcr_init,
> > +        .class_size         =3D sizeof(NPCMGCRClass),
> >           .class_init         =3D npcm_gcr_class_init,
> >           .abstract           =3D true,
> >       },
> > diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
> > index 6d3d00d260..9af24e5cdc 100644
> > --- a/include/hw/misc/npcm_gcr.h
> > +++ b/include/hw/misc/npcm_gcr.h
> > @@ -18,6 +18,7 @@
> >
> >   #include "exec/memory.h"
> >   #include "hw/sysbus.h"
> > +#include "qom/object.h"
> >
> >   /*
> >    * NPCM7XX PWRON STRAP bit fields
> > @@ -53,6 +54,7 @@
> >    * Number of registers in our device state structure. Don't change
> this without
> >    * incrementing the version_id in the vmstate.
> >    */
> > +#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
> >   #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
> >
> >   typedef struct NPCMGCRState {
> > @@ -60,15 +62,22 @@ typedef struct NPCMGCRState {
> >
> >       MemoryRegion iomem;
> >
> > -    uint32_t regs[NPCM7XX_GCR_NR_REGS];
> > +    uint32_t regs[NPCM_GCR_MAX_NR_REGS];
> >
> >       uint32_t reset_pwron;
> >       uint32_t reset_mdlr;
> >       uint32_t reset_intcr3;
> >   } NPCMGCRState;
> >
> > +typedef struct NPCMGCRClass {
> > +    SysBusDeviceClass parent;
> > +
> > +    size_t nr_regs;
> > +    const uint32_t *cold_reset_values;
> > +} NPCMGCRClass;
> > +
> >   #define TYPE_NPCM_GCR "npcm-gcr"
> >   #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
> > -OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)
> > +OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)
> >
> >   #endif /* NPCM_GCR_H */
>
>

--000000000000e1b2b4062ee98d5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks! I can review the patch.</div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mo=
n, Feb 24, 2025 at 12:52=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:=
pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
This patch introduces a buffer-overflow, now reported by address sanitizer.=
<br>
<br>
I sent a patch:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20250224205053.104959-1-" rel=
=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu-devel/202502=
24205053.104959-1-</a><br>
<a href=3D"http://pierrick.bouvier@linaro.org/T/#u" rel=3D"noreferrer" targ=
et=3D"_blank">pierrick.bouvier@linaro.org/T/#u</a><br>
<br>
You&#39;re welcome to review it, or fix the problem differently if there is=
 <br>
a better approach.<br>
<br>
Regards,<br>
Pierrick<br>
<br>
On 2/19/25 10:45, Hao Wu wrote:<br>
&gt; These 2 values are different between NPCM7XX and NPCM8XX<br>
&gt; GCRs. So we add them to the class and assign different values<br>
&gt; to them.<br>
&gt; <br>
&gt; Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" targe=
t=3D"_blank">wuhaotsh@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/misc/npcm_gcr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 27 +=
+++++++++++++++-----------<br>
&gt;=C2=A0 =C2=A0include/hw/misc/npcm_gcr.h | 13 +++++++++++--<br>
&gt;=C2=A0 =C2=A02 files changed, 27 insertions(+), 13 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/misc/npcm_gcr.c b/hw/misc/npcm_gcr.c<br>
&gt; index 0959f2e5c4..d89e8c2c3b 100644<br>
&gt; --- a/hw/misc/npcm_gcr.c<br>
&gt; +++ b/hw/misc/npcm_gcr.c<br>
&gt; @@ -66,10 +66,9 @@ enum NPCM7xxGCRRegisters {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_GCR_SCRPAD=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 0x013c / sizeof(uint32_t),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_GCR_USB1PHYCTL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM7XX_GCR_USB2PHYCTL,<br>
&gt; -=C2=A0 =C2=A0 NPCM7XX_GCR_REGS_END,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static const uint32_t cold_reset_values[NPCM7XX_GCR_NR_REGS] =3D {<br=
>
&gt; +static const uint32_t npcm7xx_cold_reset_values[NPCM7XX_GCR_NR_REGS] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[NPCM7XX_GCR_PDID]=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 0x04a92750,=C2=A0 =C2=A0/* Poleg A1 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[NPCM7XX_GCR_MISCPE]=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 0x0000ffff,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[NPCM7XX_GCR_SPSWC]=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=3D 0x00000003,<br>
&gt; @@ -88,8 +87,9 @@ static uint64_t npcm_gcr_read(void *opaque, hwaddr o=
ffset, unsigned size)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reg =3D offset / sizeof(uint32_t);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCMGCRState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 NPCMGCRClass *c =3D NPCM_GCR_GET_CLASS(s);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (reg &gt;=3D NPCM7XX_GCR_NR_REGS) {<br>
&gt; +=C2=A0 =C2=A0 if (reg &gt;=3D c-&gt;nr_regs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;%s: offset 0x%04&quot; HWADDR_PRIx &quot; out of =
range\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__func__, offset);<br>
&gt; @@ -106,11 +106,12 @@ static void npcm_gcr_write(void *opaque, hwaddr =
offset,<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reg =3D offset / sizeof(uint32_t);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCMGCRState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 NPCMGCRClass *c =3D NPCM_GCR_GET_CLASS(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t value =3D v;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 trace_npcm_gcr_write(offset, value);<br>
&gt; +=C2=A0 =C2=A0 trace_npcm_gcr_write(offset, v);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (reg &gt;=3D NPCM7XX_GCR_NR_REGS) {<br>
&gt; +=C2=A0 =C2=A0 if (reg &gt;=3D c-&gt;nr_regs) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;%s: offset 0x%04&quot; HWADDR_PRIx &quot; out of =
range\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__func__, offset);<br>
&gt; @@ -156,10 +157,12 @@ static const struct MemoryRegionOps npcm_gcr_ops=
 =3D {<br>
&gt;=C2=A0 =C2=A0static void npcm7xx_gcr_enter_reset(Object *obj, ResetType=
 type)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NPCMGCRState *s =3D NPCM_GCR(obj);<br>
&gt; +=C2=A0 =C2=A0 NPCMGCRClass *c =3D NPCM_GCR_GET_CLASS(obj);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 QEMU_BUILD_BUG_ON(sizeof(s-&gt;regs) !=3D sizeof(cold_r=
eset_values));<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 memcpy(s-&gt;regs, cold_reset_values, sizeof(s-&gt;regs=
));<br>
&gt; +=C2=A0 =C2=A0 g_assert(sizeof(s-&gt;regs) &gt;=3D sizeof(c-&gt;cold_r=
eset_values));<br>
&gt; +=C2=A0 =C2=A0 g_assert(sizeof(s-&gt;regs) &gt;=3D c-&gt;nr_regs * siz=
eof(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 memcpy(s-&gt;regs, c-&gt;cold_reset_values, c-&gt;nr_re=
gs * sizeof(uint32_t));<br>
&gt; +=C2=A0 =C2=A0 /* These 3 registers are at the same location in both 7=
xx and 8xx. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[NPCM7XX_GCR_PWRON] =3D s-&gt;rese=
t_pwron;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[NPCM7XX_GCR_MDLR] =3D s-&gt;reset=
_mdlr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;regs[NPCM7XX_GCR_INTCR3] =3D s-&gt;res=
et_intcr3;<br>
&gt; @@ -224,7 +227,7 @@ static const VMStateDescription vmstate_npcm_gcr =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.version_id =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.minimum_version_id =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.fields =3D (const VMStateField[]) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, =
NPCM7XX_GCR_NR_REGS),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, NPCMGCRState, =
NPCM_GCR_MAX_NR_REGS),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST(),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt;=C2=A0 =C2=A0};<br>
&gt; @@ -238,7 +241,6 @@ static void npcm_gcr_class_init(ObjectClass *klass=
, void *data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END &gt; NPCM7XX_GCR=
_NR_REGS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;realize =3D npcm_gcr_realize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_npcm_gcr;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -247,13 +249,15 @@ static void npcm_gcr_class_init(ObjectClass *kla=
ss, void *data)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void npcm7xx_gcr_class_init(ObjectClass *klass, voi=
d *data)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 NPCMGCRClass *c =3D NPCM_GCR_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ResettableClass *rc =3D RESETTABLE_CLASS(kla=
ss);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 QEMU_BUILD_BUG_ON(NPCM7XX_GCR_REGS_END !=3D NPCM7XX_GCR=
_NR_REGS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dc-&gt;desc =3D &quot;NPCM7xx System Global =
Control Registers&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc-&gt;phases.enter =3D npcm7xx_gcr_enter_re=
set;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 c-&gt;nr_regs =3D NPCM7XX_GCR_NR_REGS;<br>
&gt; +=C2=A0 =C2=A0 c-&gt;cold_reset_values =3D npcm7xx_cold_reset_values;<=
br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const TypeInfo npcm_gcr_info[] =3D {<br>
&gt; @@ -262,6 +266,7 @@ static const TypeInfo npcm_gcr_info[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D TYPE_SYS_BUS_DEVICE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_size=C2=A0 =C2=A0 =
=C2=A0 =3D sizeof(NPCMGCRState),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.instance_init=C2=A0 =C2=A0 =
=C2=A0 =3D npcm_gcr_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D sizeof(NPCMGCRClass),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D npcm_gcr_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.abstract=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h<b=
r>
&gt; index 6d3d00d260..9af24e5cdc 100644<br>
&gt; --- a/include/hw/misc/npcm_gcr.h<br>
&gt; +++ b/include/hw/misc/npcm_gcr.h<br>
&gt; @@ -18,6 +18,7 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;exec/memory.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * NPCM7XX PWRON STRAP bit fields<br>
&gt; @@ -53,6 +54,7 @@<br>
&gt;=C2=A0 =C2=A0 * Number of registers in our device state structure. Don&=
#39;t change this without<br>
&gt;=C2=A0 =C2=A0 * incrementing the version_id in the vmstate.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; +#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS<br>
&gt;=C2=A0 =C2=A0#define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct NPCMGCRState {<br>
&gt; @@ -60,15 +62,22 @@ typedef struct NPCMGCRState {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion iomem;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 uint32_t regs[NPCM7XX_GCR_NR_REGS];<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[NPCM_GCR_MAX_NR_REGS];<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reset_pwron;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reset_mdlr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t reset_intcr3;<br>
&gt;=C2=A0 =C2=A0} NPCMGCRState;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +typedef struct NPCMGCRClass {<br>
&gt; +=C2=A0 =C2=A0 SysBusDeviceClass parent;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 size_t nr_regs;<br>
&gt; +=C2=A0 =C2=A0 const uint32_t *cold_reset_values;<br>
&gt; +} NPCMGCRClass;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#define TYPE_NPCM_GCR &quot;npcm-gcr&quot;<br>
&gt;=C2=A0 =C2=A0#define TYPE_NPCM7XX_GCR &quot;npcm7xx-gcr&quot;<br>
&gt; -OBJECT_DECLARE_SIMPLE_TYPE(NPCMGCRState, NPCM_GCR)<br>
&gt; +OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif /* NPCM_GCR_H */<br>
<br>
</blockquote></div>

--000000000000e1b2b4062ee98d5a--

