Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B198AC282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 22:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpEhT-00063T-D4; Mon, 03 Mar 2025 17:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1tpEhS-000633-EF; Mon, 03 Mar 2025 17:55:50 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1tpEhQ-0001c3-8W; Mon, 03 Mar 2025 17:55:50 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e8992f9a45so35810376d6.0; 
 Mon, 03 Mar 2025 14:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741042546; x=1741647346; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZZHQZN2L4HaMwIKCYtrRNom5hDTxawWs/qZxfArXl4=;
 b=b7FZ/k2Ge73de9J76qoYE7msrDqk+neMvjSkYlctwKRAfBJzH6BhE200iauH28jAzx
 CpmKTEt4FL3rptRDxVRbWRyAGga+EHuhFbiDKYs6rcZiG98ehD4+oeIpX6mGYdtB5i/+
 6zoMfCEsA/UXLPxxCpei0sv3WVvCInuasXgwMZKdQTnKm3zWtDvKW00Pn4JcHyIVGB90
 MijdSBtm05/jEpQm7zMNkMetjCmNo1l1gBGYsZVGKT5E/yFov/UgprCD+tX/b5mb3pzB
 tde/Ql9xRwg/NxDMm6G27HwBScZ/iHz2SZy/L6ShDc8PAuNfsoDLuCBYOVK+RANcDcJX
 7jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741042546; x=1741647346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZZHQZN2L4HaMwIKCYtrRNom5hDTxawWs/qZxfArXl4=;
 b=JWj7cLSNezl7UnMZ45J+CK2i1L7Zv+1kLhBMtcxOzOwwVg3iT7wHKBFPoAxGFjijey
 s74fGvKBxwYq3v6tbcD2X9O8uAxEadFMH0kKNVkoLBmwPUfKs9HloF1bryWjVcTjgUPf
 GWngaohkhAM5U9WhIw/nwakiwteM72QBM0GSnInjFkKrH4bGje4MFLmPRCIxPuyHuNaK
 htOYZTbruODKF8UpaLH6GlDuUFbSJDLMd7Bun5hUp0SjPU4l6ANFGSPmqVkVF5dvclVw
 0Wx9cKhLS5qY06D+WcLxjkprR8IcH74emVJyHA/5lv4gZq+6r/1zFs2u1x6te0JvKM7w
 13cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4rHU10lxT0FLYbJlXe5i5S1+GyunMSNTlSA8ehxob2I7sfoSLdQIbwXanSLHI3bIgsE4yWutdbhLmuA==@nongnu.org,
 AJvYcCVE7M0B2OqZz34so7nN5DEGKJAnMN2ziC3MMa9/lvZD9ZuQIHsiS6ZzDPsv1EZxj9xLVlfwKB64Ww==@nongnu.org
X-Gm-Message-State: AOJu0YzSOtc3StEqbF7sBEykpGX86iXvCMiIUp3nNrM77wX8EBU46eCz
 a798LjnEZzx+MdPlfR/FGnSP5L2btPpZcQhwqVbuVJhRe5+5O+bxOshhmij/oTCTrOhPzyx0vwT
 lsvQRWmKmC+Sa7sRhv6pylgiRCIs=
X-Gm-Gg: ASbGnctdhyi1p5jsa143WxStN8tydIGxv9NdFsV7XTvbg7c8sK4wS/+f/rZibZVPZF4
 bfSW9bCr5qSS6MLXjgwZr6Pyr4LjcziBvquauYdR5ZXmQ2ieAVoRwFRVaoJehP2vI3sKz+ScNu5
 P/uJgkgfvIavMtkfE6/0EO9DKXFhjmcxg1wpvt+ZUo7hlDs0YGcyEl+Js=
X-Google-Smtp-Source: AGHT+IHhfQq1cJ+ImdKfRYVPTvTGKc3lEKjwKZgg7WIAvtc7X/1TKQArdP0Xmr68d4coUtQbVkYVWLaUaCc9U30sRBs=
X-Received: by 2002:a05:6214:21e7:b0:6e8:9525:2ac3 with SMTP id
 6a1803df08f44-6e8a0d83296mr226855436d6.34.1741042546342; Mon, 03 Mar 2025
 14:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20250225074133.6827-1-kuqin12@gmail.com>
 <20250225074133.6827-2-kuqin12@gmail.com>
 <CAD=n3R2kuvUzyE7nKPmpyELozdo_+eAKVr_CxA5HQ_jLL25stw@mail.gmail.com>
 <CAD=n3R0ntWYNN9LxJWVXApY3s_LRddx4YVQPYRzRojXcL-BDug@mail.gmail.com>
In-Reply-To: <CAD=n3R0ntWYNN9LxJWVXApY3s_LRddx4YVQPYRzRojXcL-BDug@mail.gmail.com>
From: Kun Qin <kuqin12@gmail.com>
Date: Mon, 3 Mar 2025 14:55:34 -0800
X-Gm-Features: AQ5f1JryAsYm99-ks7_wJd7nzxXryqGfZsxfHIbfiMWN7JI5XKWOR01icnfXtws
Message-ID: <CABhrWrRTFF1f7akWJ-jDZ7MGZGz4cBLq-yjf0vD5baBFc_XgtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref
 machine
To: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Graeme Gregory <graeme@xora.org.uk>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000837f1d062f780ea8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=kuqin12@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000837f1d062f780ea8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leif & Peter,

Thanks for the comments. I will address them in a v2 patch.

Regards,
Kun

On Mon, Mar 3, 2025 at 12:44=E2=80=AFPM Leif Lindholm <
leif.lindholm@oss.qualcomm.com> wrote:

> Doh! Add the lists back in. (No idea how I dropped them off.)
>
> On Mon, 3 Mar 2025 at 17:02, Leif Lindholm
> <leif.lindholm@oss.qualcomm.com> wrote:
> >
> > Hi Kun,
> >
> > Apologies for delay in responding - I was out last week.
> > I agree with this addition, since a TPM is a requirement for servers.
> >
> > However, to help simplify review, could you add some detail in the
> > commit message
> > as to which SystemReady requirements this resolves and whether this
> > implementation
> > fulfills all requirements across BSA/SBSA/BBSA?
> >
> > I agree with Peter that since this is a non-discoverable component, it
> > would make sense
> > to step the machine minor version number. A major version bump would
> > not be required
> > since simply adding this component will not break any existing
> > firmware (which will have
> > no way of knowing it even exists).
> >
> > Regards,
> >
> > Leif
> >
> > On Tue, 25 Feb 2025 at 07:41, Kun Qin <kuqin12@gmail.com> wrote:
> > >
> > > From: Kun Qin <kuqin@microsoft.com>
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625
> > >
> > > This change aims to add a TPM device for SBSA ref machine.
> > >
> > > The implementation adds a TPM create routine during machine
> > > initialization.
> > >
> > > The backend can be the same as the rest of TPM support, by using swtp=
m.
> > >
> > > Signed-off-by: Kun Qin <kuqin12@gmail.com>
> > > ---
> > >  hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > > index e720de306419..93eb3d1e363b 100644
> > > --- a/hw/arm/sbsa-ref.c
> > > +++ b/hw/arm/sbsa-ref.c
> > > @@ -28,6 +28,8 @@
> > >  #include "system/numa.h"
> > >  #include "system/runstate.h"
> > >  #include "system/system.h"
> > > +#include "system/tpm.h"
> > > +#include "system/tpm_backend.h"
> > >  #include "exec/hwaddr.h"
> > >  #include "kvm_arm.h"
> > >  #include "hw/arm/boot.h"
> > > @@ -94,6 +96,7 @@ enum {
> > >      SBSA_SECURE_MEM,
> > >      SBSA_AHCI,
> > >      SBSA_XHCI,
> > > +    SBSA_TPM,
> > >  };
> > >
> > >  struct SBSAMachineState {
> > > @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] =3D {
> > >      /* Space here reserved for more SMMUs */
> > >      [SBSA_AHCI] =3D               { 0x60100000, 0x00010000 },
> > >      [SBSA_XHCI] =3D               { 0x60110000, 0x00010000 },
> > > +    [SBSA_TPM] =3D                { 0x60120000, 0x00010000 },
> > >      /* Space here reserved for other devices */
> > >      [SBSA_PCIE_PIO] =3D           { 0x7fff0000, 0x00010000 },
> > >      /* 32-bit address PCIE MMIO space */
> > > @@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineState
> *sms, PCIBus *bus)
> > >      }
> > >  }
> > >
> > > +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)
> > > +{
> > > +    Error *errp =3D NULL;
> > > +    DeviceState *dev;
> > > +
> > > +    TPMBackend *be =3D qemu_find_tpm_be("tpm0");
> > > +    if (be =3D=3D NULL) {
> > > +        error_report("Couldn't find tmp0 backend");
> > > +        return;
> > > +    }
> > > +
> > > +    dev =3D qdev_new(TYPE_TPM_TIS_SYSBUS);
> > > +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be),
> &errp);
> > > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> > > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
> sbsa_ref_memmap[SBSA_TPM].base);
> > > +}
> > > +
> > >  static void create_pcie(SBSAMachineState *sms)
> > >  {
> > >      hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> > > @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)
> > >      pci_create_simple(pci->bus, -1, "bochs-display");
> > >
> > >      create_smmu(sms, pci->bus);
> > > +
> > > +    create_tpm(sms, pci->bus);
> > >  }
> > >
> > >  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int
> *fdt_size)
> > > --
> > > 2.43.0
> > >
>

--000000000000837f1d062f780ea8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Leif &amp; Peter,<div><br></div><div>Thanks for the com=
ments. I will address them in a v2 patch.</div><div><br></div><div>Regards,=
</div><div>Kun</div></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 3, 2025 at 12:44=E2=
=80=AFPM Leif Lindholm &lt;<a href=3D"mailto:leif.lindholm@oss.qualcomm.com=
">leif.lindholm@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Doh! Add the lists back in. (No idea how I=
 dropped them off.)<br>
<br>
On Mon, 3 Mar 2025 at 17:02, Leif Lindholm<br>
&lt;<a href=3D"mailto:leif.lindholm@oss.qualcomm.com" target=3D"_blank">lei=
f.lindholm@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Kun,<br>
&gt;<br>
&gt; Apologies for delay in responding - I was out last week.<br>
&gt; I agree with this addition, since a TPM is a requirement for servers.<=
br>
&gt;<br>
&gt; However, to help simplify review, could you add some detail in the<br>
&gt; commit message<br>
&gt; as to which SystemReady requirements this resolves and whether this<br=
>
&gt; implementation<br>
&gt; fulfills all requirements across BSA/SBSA/BBSA?<br>
&gt;<br>
&gt; I agree with Peter that since this is a non-discoverable component, it=
<br>
&gt; would make sense<br>
&gt; to step the machine minor version number. A major version bump would<b=
r>
&gt; not be required<br>
&gt; since simply adding this component will not break any existing<br>
&gt; firmware (which will have<br>
&gt; no way of knowing it even exists).<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Leif<br>
&gt;<br>
&gt; On Tue, 25 Feb 2025 at 07:41, Kun Qin &lt;<a href=3D"mailto:kuqin12@gm=
ail.com" target=3D"_blank">kuqin12@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Kun Qin &lt;<a href=3D"mailto:kuqin@microsoft.com" target=
=3D"_blank">kuqin@microsoft.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issue=
s/2625" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/qemu/-/issues/2625</a><br>
&gt; &gt;<br>
&gt; &gt; This change aims to add a TPM device for SBSA ref machine.<br>
&gt; &gt;<br>
&gt; &gt; The implementation adds a TPM create routine during machine<br>
&gt; &gt; initialization.<br>
&gt; &gt;<br>
&gt; &gt; The backend can be the same as the rest of TPM support, by using =
swtpm.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kun Qin &lt;<a href=3D"mailto:kuqin12@gmail.com" t=
arget=3D"_blank">kuqin12@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++<br>
&gt; &gt;=C2=A0 1 file changed, 24 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c<br>
&gt; &gt; index e720de306419..93eb3d1e363b 100644<br>
&gt; &gt; --- a/hw/arm/sbsa-ref.c<br>
&gt; &gt; +++ b/hw/arm/sbsa-ref.c<br>
&gt; &gt; @@ -28,6 +28,8 @@<br>
&gt; &gt;=C2=A0 #include &quot;system/numa.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;system/runstate.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;system/system.h&quot;<br>
&gt; &gt; +#include &quot;system/tpm.h&quot;<br>
&gt; &gt; +#include &quot;system/tpm_backend.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;exec/hwaddr.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;kvm_arm.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;hw/arm/boot.h&quot;<br>
&gt; &gt; @@ -94,6 +96,7 @@ enum {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 SBSA_SECURE_MEM,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 SBSA_AHCI,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 SBSA_XHCI,<br>
&gt; &gt; +=C2=A0 =C2=A0 SBSA_TPM,<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 struct SBSAMachineState {<br>
&gt; &gt; @@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] =
=3D {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Space here reserved for more SMMUs */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_AHCI] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x60100000, 0x00010000 },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_XHCI] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x60110000, 0x00010000 },<br>
&gt; &gt; +=C2=A0 =C2=A0 [SBSA_TPM] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 { 0x60120000, 0x00010000 },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Space here reserved for other devices */<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 [SBSA_PCIE_PIO] =3D=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{ 0x7fff0000, 0x00010000 },<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* 32-bit address PCIE MMIO space */<br>
&gt; &gt; @@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineSta=
te *sms, PCIBus *bus)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 Error *errp =3D NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 DeviceState *dev;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 TPMBackend *be =3D qemu_find_tpm_be(&quot;tpm0&quo=
t;);<br>
&gt; &gt; +=C2=A0 =C2=A0 if (be =3D=3D NULL) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Couldn&#39;t find=
 tmp0 backend&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_TPM_TIS_SYSBUS);<br>
&gt; &gt; +=C2=A0 =C2=A0 object_property_set_link(OBJECT(dev), &quot;tpmdev=
&quot;, OBJECT(be), &amp;errp);<br>
&gt; &gt; +=C2=A0 =C2=A0 object_property_set_str(OBJECT(dev), &quot;tpmdev&=
quot;, be-&gt;id, &amp;errp);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &amp=
;error_fatal);<br>
&gt; &gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_m=
emmap[SBSA_TPM].base);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 static void create_pcie(SBSAMachineState *sms)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PCI=
E_ECAM].base;<br>
&gt; &gt; @@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms=
)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 pci_create_simple(pci-&gt;bus, -1, &quot;boch=
s-display&quot;);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 create_smmu(sms, pci-&gt;bus);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 create_tpm(sms, pci-&gt;bus);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo=
, int *fdt_size)<br>
&gt; &gt; --<br>
&gt; &gt; 2.43.0<br>
&gt; &gt;<br>
</blockquote></div>

--000000000000837f1d062f780ea8--

