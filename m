Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E496C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPcA-0003B0-1u; Tue, 20 Aug 2024 10:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPc3-00039h-8H; Tue, 20 Aug 2024 10:13:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPc0-0006qs-Fy; Tue, 20 Aug 2024 10:13:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a2b4so2193915a12.0; 
 Tue, 20 Aug 2024 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724163204; x=1724768004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HqlixZGtnNSdwk9qAJAaBBrZLbKEh4Yudg6Ug8KTXQw=;
 b=PMuujhJeNXqhjnfwSF5YdKTiNihUHblbaPyC7onuSjlGTEJsnPNTmo0g3Xu8eY4KZ/
 jETY+OonhAOxBkmlzUld4Wv4sGTHDKPMSfKr4J6RqmB1Vj27058DV50JhRuy8O7lkmPg
 9ewrkttfi80D2/7wp7vqSo0+GaoQWRn9jFOiwsPx4T1SKqdkwkgKF/OQotNurWZwy4SP
 GF5kPmJgmJ8FgYaVgGqKUaEB4oCtOkKnauF/q7T7naBdFtwL/MjCGErm3hoVJFFacKpo
 BA7xQqmh+e7Mcpj2xpjv4eDZGo5wITWHWM6oF6QATEnSARSDd+p77DkdtaDM0dQe4FEI
 9T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724163204; x=1724768004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqlixZGtnNSdwk9qAJAaBBrZLbKEh4Yudg6Ug8KTXQw=;
 b=CmlPcwgx/M/5Afj2JlI+crqkQ/JdxmTVsGVG5bPwW630teoCQ7nvF48trdiBpNhVp9
 XEC+GenWo+Tp90dcLBRtv7L73UiIj+igNp6TZh7r7uGeSPWdfhFOMJXgYc5dUIbi5Ffn
 s2C4PbzRCKPASqmA8cxmXB4xJekkFSTjuJXBMGydnfuYM5R3zvffU/z5lmKAUr4GuT2Q
 q2lVDJK3pp13JFz/PMMsVctyCmR4dHvdQudiRrlfAhokhExRqMJZHcnzkLkAO9c+p6mB
 V8Fa/XhwU8Fe9ROJ927q43Mq9eUiG12Z1jkS6dT5hWBAlyXzgE67HxO36OJwEMZzi34V
 1lfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqrdhVVNXBk/vbNFgMTuoJu7CqeWPkmS2WD4KHvGP65ejNpW3BTZ2267ziWuukumugNF8+ZzWqaQ==@nongnu.org,
 AJvYcCXOlTiUFk+iM5UTDXSqUXD+V44A9xCz1elYaoi9wC9FKM9uW1S4gRH5I86TIZ6XyiczkLJnrK1vkSPmhg==@nongnu.org
X-Gm-Message-State: AOJu0YwOdc8842bj2dBmnNGDgfEBlD8gzF8L1B5tDxs9h0yOUYu3Bmzc
 67ap9bU2HNFeVWoJoEh7LIqHs5DQvS5+xc4ukSNitnKhsN9zyzJbaxK40XijFrfCkq9PHP+8xuV
 WwEIPGtwZf2/85lCc49EStbAwyuc=
X-Google-Smtp-Source: AGHT+IFYXoeF3FkeU2yRw9Zo8xB+GajV1hIlPvROdYyo/QgSrD0N91jQzsYOSqk1zJkttdz8EesefwH1O22HjOYezNo=
X-Received: by 2002:a05:6402:1912:b0:5b4:cbba:902a with SMTP id
 4fb4d7f45d1cf-5bf0ac0c9ddmr2867783a12.4.1724163203518; Tue, 20 Aug 2024
 07:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
 <20240812130606.90410-5-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2408121650590.298534@ubuntu-linux-20-04-desktop>
 <ZruRm34zIMtUm7oH@zapote>
 <alpine.DEB.2.22.394.2408131550080.298534@ubuntu-linux-20-04-desktop>
 <ZryZwOoadeb1UWK8@zapote>
 <alpine.DEB.2.22.394.2408141719400.298534@ubuntu-linux-20-04-desktop>
 <CAJy5ezrUbGZCaF=HiYhyLCoXRL3d=t-QbmLeKvu7ByWksV888g@mail.gmail.com>
 <alpine.DEB.2.22.394.2408160949320.298534@ubuntu-linux-20-04-desktop>
 <93de8d6d-6123-4038-a566-d134206ba608@amd.com>
In-Reply-To: <93de8d6d-6123-4038-a566-d134206ba608@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 20 Aug 2024 16:13:10 +0200
Message-ID: <CAJy5ezonjsd95GhkoagrivQy_Vme7wyj1xLvVd9ZxNP_tJyBRA@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] hw/arm: xenpvh: Add support for SMP guests
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, 
 andrew.cooper3@citrix.com
Content-Type: multipart/alternative; boundary="00000000000047d8ac06201e0744"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000047d8ac06201e0744
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 2:45=E2=80=AFAM Jason Andryuk <jason.andryuk@amd.co=
m> wrote:

> On 2024-08-16 12:53, Stefano Stabellini wrote:
> > On Fri, 16 Aug 2024, Edgar E. Iglesias wrote:
> >> On Thu, Aug 15, 2024 at 2:30=E2=80=AFAM Stefano Stabellini <
> sstabellini@kernel.org> wrote:
> >>        On Wed, 14 Aug 2024, Edgar E. Iglesias wrote:
> >>        > On Tue, Aug 13, 2024 at 03:52:32PM -0700, Stefano Stabellini
> wrote:
> >>        > > On Tue, 13 Aug 2024, Edgar E. Iglesias wrote:
> >>        > > > On Mon, Aug 12, 2024 at 06:47:17PM -0700, Stefano
> Stabellini wrote:
> >>        > > > > On Mon, 12 Aug 2024, Edgar E. Iglesias wrote:
> >>        > > > > > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >>        > > > > >
> >>        > > > > > Add SMP support for Xen PVH ARM guests. Create
> max_cpus ioreq
> >>        > > > > > servers to handle hotplug.
> >>        > > > > >
> >>        > > > > > Signed-off-by: Edgar E. Iglesias <
> edgar.iglesias@amd.com>
> >>        > > > > > ---
> >>        > > > > >  hw/arm/xen_arm.c | 5 +++--
> >>        > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> >>        > > > > >
> >>        > > > > > diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> >>        > > > > > index 5f75cc3779..ef8315969c 100644
> >>        > > > > > --- a/hw/arm/xen_arm.c
> >>        > > > > > +++ b/hw/arm/xen_arm.c
> >>        > > > > > @@ -173,7 +173,7 @@ static void
> xen_arm_init(MachineState *machine)
> >>        > > > > >
> >>        > > > > >      xen_init_ram(machine);
> >>        > > > > >
> >>        > > > > > -    xen_register_ioreq(xam->state, machine->smp.cpus=
,
> &xen_memory_listener);
> >>        > > > > > +    xen_register_ioreq(xam->state,
> machine->smp.max_cpus, &xen_memory_listener);
> >>        > > > > >
> >>        > > > > >      xen_create_virtio_mmio_devices(xam);
> >>        > > > > >
> >>        > > > > > @@ -218,7 +218,8 @@ static void
> xen_arm_machine_class_init(ObjectClass *oc, void *data)
> >>        > > > > >      MachineClass *mc =3D MACHINE_CLASS(oc);
> >>        > > > > >      mc->desc =3D "Xen PVH ARM machine";
> >>        > > > > >      mc->init =3D xen_arm_init;
> >>        > > > > > -    mc->max_cpus =3D 1;
> >>        > > > > > +    /* MAX number of vcpus supported by Xen.  */
> >>        > > > > > +    mc->max_cpus =3D GUEST_MAX_VCPUS;
> >>        > > > >
> >>        > > > > Will this cause allocations of data structures with 128
> elements?
> >>        > > > > Looking at hw/xen/xen-hvm-common.c:xen_do_ioreq_registe=
r
> it seems
> >>        > > > > possible? Or
> hw/xen/xen-hvm-common.c:xen_do_ioreq_register is called
> >>        > > >
> >>        > > > Yes, in theory there's probably overhead with this but as
> you correctly
> >>        > > > noted below, a PVH aware xl will set the max_cpus option
> to a lower value.
> >>        > > >
> >>        > > > With a non-pvh aware xl, I was a little worried about the
> overhead
> >>        > > > but I couldn't see any visible slow-down on ARM neither i=
n
> boot or in network
> >>        > > > performance (I didn't run very sophisticated benchmarks).
> >>        > >
> >>        > > What do you mean by "non-pvh aware xl"? All useful versions
> of xl
> >>        > > support pvh?
> >>        >
> >>        >
> >>        > I mean an xl without our PVH patches merged.
> >>        > xl in upstream doesn't know much about PVH yet.
> >>        > Even for ARM, we're still carrying significant patches in our
> tree.
> >>
> >>        Oh I see. In that case, I don't think we need to support
> "non-pvh aware xl".
> >>
> >>
> >>        > > > > later on with the precise vCPU value which should be
> provided to QEMU
> >>        > > > > via the -smp command line option
> >>        > > > >
> (tools/libs/light/libxl_dm.c:libxl__build_device_model_args_new)?
> >>        > > >
> >>        > > > Yes, a pvh aware xl will for example pass -smp 2,maxcpus=
=3D4
> based on
> >>        > > > values from the xl.cfg. If the user doesn't set maxvcpus
> in xl.cfg, xl
> >>        > > > will set maxvcpus to the same value as vcpus.
> >>        > >
> >>        > > OK good. In that case if this is just an initial value mean=
t
> to be
> >>        > > overwritten, I think it is best to keep it as 1.
> >>        >
> >>        > Sorry but that won't work. I think the confusion here may be
> that
> >>        > it's easy to mix up mc->max_cpus and machine->smp.max_cpus,
> these are
> >>        > not the same. They have different purposes.
> >>        >
> >>        > I'll try to clarify the 3 values in play.
> >>        >
> >>        > machine-smp.cpus:
> >>        > Number of guest vcpus active at boot.
> >>        > Passed to QEMU via the -smp command-line option.
> >>        > We don't use this value in QEMU's ARM PVH machines.
> >>        >
> >>        > machine->smp.max_cpus:
> >>        > Max number of vcpus that the guest can use (equal or larger
> than machine-smp.cpus).
> >>        > Will be set by xl via the "-smp X,maxcpus=3DY" command-line
> option to QEMU.
> >>        > Taken from maxvcpus from xl.cfg, same as XEN_DMOP_nr_vcpus.
> >>        > This is what we use for xen_register_ioreq().
> >>        >
> >>        > mc->max_cpus:
> >>        > Absolute MAX in QEMU used to cap the -smp command-line option=
s.
> >>        > If xl tries to set -smp (machine->smp.max_cpus) larger than
> this, QEMU will bail out.
> >>        > Used to setup xen_register_ioreq() ONLY if -smp maxcpus was
> NOT set (i.e by a non PVH aware xl).
> >>        > Cannot be 1 because that would limit QEMU to MAX 1 vcpu.
> >>        >
> >>        > I guess we could set mc->max_cpus to what XEN_DMOP_nr_vcpus
> returns but I'll
> >>        > have to check if we can even issue that hypercall this early
> in QEMU since
> >>        > mc->max_cpus is setup before we even parse the machine
> options. We may
> >>        > not yet know what domid we're attaching to yet.
> >>
> >>        If mc->max_cpus is the absolute max and it will not be used if
> -smp is
> >>        passed to QEMU, then I think it is OK to use GUEST_MAX_VCPUS
> >>
> >> Looking at this a little more. If users (xl) don't pass an -smp option
> we actually default to smp.max_cpus=3D1.
> >> So, another option is to simply remove the upper limit in QEMU (e.g we
> can set mc->max_cpus to something very large like UINT32_MAX).
> >> That would avoid early hypercalls, avoid using GUEST_MAX_VCPUS and
> always let xl dictate the max_cpus value using the -smp cmdline option.
> >
> > As the expectation is that there will be always a smp.max_cpus option
> > passed to QEMU, I would avoid an extra early hypercall.
> >
> > For the initial value, I would use something static and large, but not
> > unreasonably large as UINT32_MAX to be more resilient in (erroneous)
> > cases where smp.max_cpus is not passed.
> >
> > So I would initialize it to GUEST_MAX_VCPUS, or if we don't want to use
> > GUEST_MAX_VCPUS, something equivalent in the 64-256 range.
>

Thanks Stefano,

I'm going to send a v2 following this suggestion of using GUEST_MAX_VCPUS.
Will also add comments clarifying that this is a MAX value for the
command-line option
and not what gets passed to register_ioreq.
We can continue the discussion from there to see if we want to change
things,
I don't have a strong opinion here so I'm happy to go either way.



> >
> > Alternative we can have a runtime check and exit with a warning if
> > smp.max_cpus is not set.
>
> FYI, xl only passes a -smp option when the domU has more than 1 vcpu.
> Though that implies only a single vcpu.
>
>
Thanks Jason, yes, in that case the default of cpus=3D1, maxcpus=3D1 gets s=
et.
I was initially under the wrong assumption that without -smp options, the
max would get set.
This is what I was trying to clarify in my previous email:
>> Looking at this a little more. If users (xl) don't pass an -smp option
we actually default to smp.max_cpus=3D1.

Best regards,
Edgar

--00000000000047d8ac06201e0744
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Aug 17, 2024 at 2:45=E2=80=AFAM J=
ason Andryuk &lt;<a href=3D"mailto:jason.andryuk@amd.com">jason.andryuk@amd=
.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 2024-08-16 12:53, Stefano Stabellini wr=
ote:<br>
&gt; On Fri, 16 Aug 2024, Edgar E. Iglesias wrote:<br>
&gt;&gt; On Thu, Aug 15, 2024 at 2:30=E2=80=AFAM Stefano Stabellini &lt;<a =
href=3D"mailto:sstabellini@kernel.org" target=3D"_blank">sstabellini@kernel=
.org</a>&gt; wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 On Wed, 14 Aug 2024, Edgar E. Iglesias =
wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; On Tue, Aug 13, 2024 at 03:52:32PM=
 -0700, Stefano Stabellini wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; On Tue, 13 Aug 2024, Edgar E.=
 Iglesias wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; On Mon, Aug 12, 2024 at =
06:47:17PM -0700, Stefano Stabellini wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; On Mon, 12 Aug 2024=
, Edgar E. Iglesias wrote:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; From: &quot;Ed=
gar E. Iglesias&quot; &lt;<a href=3D"mailto:edgar.iglesias@amd.com" target=
=3D"_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; Add SMP suppor=
t for Xen PVH ARM guests. Create max_cpus ioreq<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; servers to han=
dle hotplug.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; Signed-off-by:=
 Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com" target=3D"=
_blank">edgar.iglesias@amd.com</a>&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 hw/arm/x=
en_arm.c | 5 +++--<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 1 file c=
hanged, 3 insertions(+), 2 deletions(-)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; diff --git a/h=
w/arm/xen_arm.c b/hw/arm/xen_arm.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; index 5f75cc37=
79..ef8315969c 100644<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; --- a/hw/arm/x=
en_arm.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; +++ b/hw/arm/x=
en_arm.c<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; @@ -173,7 +173=
,7 @@ static void xen_arm_init(MachineState *machine)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =
=C2=A0 xen_init_ram(machine);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0=
 xen_register_ioreq(xam-&gt;state, machine-&gt;smp.cpus, &amp;xen_memory_li=
stener);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0=
 xen_register_ioreq(xam-&gt;state, machine-&gt;smp.max_cpus, &amp;xen_memor=
y_listener);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =
=C2=A0 xen_create_virtio_mmio_devices(xam);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; @@ -218,7 +218=
,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =
=C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =
=C2=A0 mc-&gt;desc =3D &quot;Xen PVH ARM machine&quot;;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =
=C2=A0 mc-&gt;init =3D xen_arm_init;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0=
 mc-&gt;max_cpus =3D 1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0=
 /* MAX number of vcpus supported by Xen.=C2=A0 */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0=
 mc-&gt;max_cpus =3D GUEST_MAX_VCPUS;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; Will this cause all=
ocations of data structures with 128 elements?<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; Looking at hw/xen/x=
en-hvm-common.c:xen_do_ioreq_register it seems<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; possible? Or hw/xen=
/xen-hvm-common.c:xen_do_ioreq_register is called<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; Yes, in theory there&#39=
;s probably overhead with this but as you correctly<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; noted below, a PVH aware=
 xl will set the max_cpus option to a lower value.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; With a non-pvh aware xl,=
 I was a little worried about the overhead<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; but I couldn&#39;t see a=
ny visible slow-down on ARM neither in boot or in network<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; performance (I didn&#39;=
t run very sophisticated benchmarks).<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; What do you mean by &quot;non=
-pvh aware xl&quot;? All useful versions of xl<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; support pvh?<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I mean an xl without our PVH patch=
es merged.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; xl in upstream doesn&#39;t know mu=
ch about PVH yet.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Even for ARM, we&#39;re still carr=
ying significant patches in our tree.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Oh I see. In that case, I don&#39;t thi=
nk we need to support &quot;non-pvh aware xl&quot;.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; later on with the p=
recise vCPU value which should be provided to QEMU<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; via the -smp comman=
d line option<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; &gt; (tools/libs/light/l=
ibxl_dm.c:libxl__build_device_model_args_new)?<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; Yes, a pvh aware xl will=
 for example pass -smp 2,maxcpus=3D4 based on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; values from the xl.cfg. =
If the user doesn&#39;t set maxvcpus in xl.cfg, xl<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; &gt; will set maxvcpus to the=
 same value as vcpus.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; OK good. In that case if this=
 is just an initial value meant to be<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; &gt; overwritten, I think it is be=
st to keep it as 1.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Sorry but that won&#39;t work. I t=
hink the confusion here may be that<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; it&#39;s easy to mix up mc-&gt;max=
_cpus and machine-&gt;smp.max_cpus, these are<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; not the same. They have different =
purposes.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ll try to clarify the 3 valu=
es in play.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; machine-smp.cpus:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Number of guest vcpus active at bo=
ot.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Passed to QEMU via the -smp comman=
d-line option.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; We don&#39;t use this value in QEM=
U&#39;s ARM PVH machines.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; machine-&gt;smp.max_cpus:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Max number of vcpus that the guest=
 can use (equal or larger than machine-smp.cpus).<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Will be set by xl via the &quot;-s=
mp X,maxcpus=3DY&quot; command-line option to QEMU.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Taken from maxvcpus from xl.cfg, s=
ame as XEN_DMOP_nr_vcpus.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; This is what we use for xen_regist=
er_ioreq().<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; mc-&gt;max_cpus:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Absolute MAX in QEMU used to cap t=
he -smp command-line options.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; If xl tries to set -smp (machine-&=
gt;smp.max_cpus) larger than this, QEMU will bail out.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Used to setup xen_register_ioreq()=
 ONLY if -smp maxcpus was NOT set (i.e by a non PVH aware xl).<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; Cannot be 1 because that would lim=
it QEMU to MAX 1 vcpu.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; I guess we could set mc-&gt;max_cp=
us to what XEN_DMOP_nr_vcpus returns but I&#39;ll<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; have to check if we can even issue=
 that hypercall this early in QEMU since<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; mc-&gt;max_cpus is setup before we=
 even parse the machine options. We may<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; not yet know what domid we&#39;re =
attaching to yet.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 If mc-&gt;max_cpus is the absolute max =
and it will not be used if -smp is<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 passed to QEMU, then I think it is OK t=
o use GUEST_MAX_VCPUS<br>
&gt;&gt;<br>
&gt;&gt; Looking at this a little more. If users (xl) don&#39;t pass an -sm=
p option we actually default to smp.max_cpus=3D1.<br>
&gt;&gt; So, another option is to simply remove the upper limit in QEMU (e.=
g we can set mc-&gt;max_cpus to something very large like UINT32_MAX).<br>
&gt;&gt; That would avoid early hypercalls, avoid using GUEST_MAX_VCPUS and=
 always let xl dictate the max_cpus value using the -smp cmdline option.<br=
>
&gt; <br>
&gt; As the expectation is that there will be always a smp.max_cpus option<=
br>
&gt; passed to QEMU, I would avoid an extra early hypercall.<br>
&gt; <br>
&gt; For the initial value, I would use something static and large, but not=
<br>
&gt; unreasonably large as UINT32_MAX to be more resilient in (erroneous)<b=
r>
&gt; cases where smp.max_cpus is not passed.<br>
&gt; <br>
&gt; So I would initialize it to GUEST_MAX_VCPUS, or if we don&#39;t want t=
o use<br>
&gt; GUEST_MAX_VCPUS, something equivalent in the 64-256 range.<br></blockq=
uote><div><br></div><div>Thanks Stefano,</div><div><br></div><div>I&#39;m g=
oing to send a v2 following this suggestion of using=C2=A0GUEST_MAX_VCPUS.<=
/div><div>Will also add comments clarifying that this is a MAX value for th=
e command-line option</div><div>and not what gets passed to register_ioreq.=
</div><div>We can continue the discussion from there to see if we want to c=
hange things,</div><div>I don&#39;t have a strong opinion here so I&#39;m h=
appy to go either way.</div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Alternative we can have a runtime check and exit with a warning if<br>
&gt; smp.max_cpus is not set.<br>
<br>
FYI, xl only passes a -smp option when the domU has more than 1 vcpu. <br>
Though that implies only a single vcpu.<br><br></blockquote><div><br></div>=
<div>Thanks Jason, yes, in that case the default of cpus=3D1, maxcpus=3D1 g=
ets set. I was initially under the wrong assumption that without -smp optio=
ns, the max would get set.</div><div>This is what I was trying to clarify i=
n my previous email:</div><div>&gt;&gt; Looking at this a little more. If u=
sers (xl) don&#39;t pass an -smp option we actually default to smp.max_cpus=
=3D1.</div><div><br></div><div>Best regards,</div><div>Edgar</div></div></d=
iv>

--00000000000047d8ac06201e0744--

