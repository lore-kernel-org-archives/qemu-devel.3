Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4CAEDE9BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so86Q-0003qd-UT; Tue, 10 Sep 2024 17:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so86O-0003oO-Sz; Tue, 10 Sep 2024 17:08:44 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1so86M-0000W0-Du; Tue, 10 Sep 2024 17:08:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-205909afad3so14660505ad.2; 
 Tue, 10 Sep 2024 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726002520; x=1726607320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EyvdhTD6EW6YNBj4N2vepxcFc1zzLWSo7Ny83hNOZeU=;
 b=AqTKILs+Gv0ouUC40e/iYoxLvh2W4+Tvg4SX9o05YUR7cFsrltuIP7PiiduleWVFPZ
 Hls1ZypGpy1Lo5zdqGjuNnPcA4WQaxn9URccbG33Z6SAipEEQ4ksYozph3jE4XeckLfM
 7dR+MhLFHLna+8BdjslrMYzFZN7/VcLfn8zF9WBw8xBjV6aaTAWB4gOHljY1f7OI8HCR
 6DsthKFZ7yZbBRDovE1Bu2ZoU3V4gIruv+ayQfTLYxlC9k3OTjmbXEZ5q4wVFaDf5wd2
 4Ys6gCkMbc4LmyphdI1M+rz6d3RT02cYqp/PPQ8Jks1vVx37PPO34ItFRSjYX4osGyHv
 W4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726002520; x=1726607320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyvdhTD6EW6YNBj4N2vepxcFc1zzLWSo7Ny83hNOZeU=;
 b=Z5t5TBVOq+LwCTnggzorPkMqlDnnlYl4gU3ZR9WlI1d/rP1A8VY7W09W9FqKIRBi2w
 efEuy0y78DmdwiBMmP4xniFfqO87+6eIgvzHYFJYT714Ymep/MtwoGfj0BosnerLOHu1
 gCwXMdgxzsDB8QjX969or8VpkaVq1mlGHooKVj7QzsiRdLbTIcFnoM3LNBhEEvSI6fL8
 p9RprR+V2CYw7SrVUd/YmMohvWnABK3legEWouz3lQKjym8GopG8YSscp/TUwNSZ8Dia
 /PcueyJb6nQs7iop6tzmpJ+ai1gmbWc4cS8jARslbZlSgsWxhcpRUD8iJ/9DEHNGRsVh
 6USg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCF0jezqbFROKS4p9qA6AyB9IIlBP6QZIkJt+IceRwbKmkl40idMK/2lMQ6li3OAW0q6XiSdADKToL@nongnu.org
X-Gm-Message-State: AOJu0YwtEN+AZEVDsAcPBBMUzKJQxkdtVRgdP9bNN6ZX9VegFvv5SiHA
 pgMBG+jqdX3Hkj0HvaPcG7EgabQPLUG+4CF95opuVoK7TgiU2pMW258vFTEUmHIefc3odlrFJHg
 qWtRbh62rbNffXavzvFMJtbnf1cM=
X-Google-Smtp-Source: AGHT+IHjQ1YdHBYAHvoNhs5V6EFGIo79NAf+uIrAJ7ZN0kDfL2bqzkwicxkfsEoPqAJjGq5Ak9DTnNvY0If8BXQUhEE=
X-Received: by 2002:a17:902:f60b:b0:206:cfb3:8c81 with SMTP id
 d9443c01a7336-207521f679bmr10427235ad.55.1726002520447; Tue, 10 Sep 2024
 14:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
 <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
In-Reply-To: <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Tue, 10 Sep 2024 14:08:04 -0700
Message-ID: <CAMqWt3oWGLaXBsM7inQkird0+VQcdbaQoZ-uF2Okmg4B2Q8uqg@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: multipart/alternative; boundary="0000000000001ce2af0621ca4752"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x62a.google.com
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

--0000000000001ce2af0621ca4752
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair!

On Sun, Sep 8, 2024 at 8:27=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om>
wrote:

> On Tue, Aug 6, 2024 at 7:05=E2=80=AFAM Gregor Haas <gregorhaas1997@gmail.=
com>
> wrote:
> >
> > This patch series adds support for specifying OpenSBI domains on the QE=
MU
> > command line. A simple example of what this looks like is below,
> including
> > mapping the board's UART into the secondary domain:
>
> Thanks for the patch, sorry it took me so long to look into this
>

No worries -- thanks for your review!


>
> >
> > qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m
> 4G -nographic \
> >         -device
> opensbi-memregion,id=3Dmem,base=3D0xBC000000,order=3D26,mmio=3Dfalse \
> >         -device
> opensbi-memregion,id=3Duart,base=3D0x10000000,order=3D12,mmio=3Dtrue,devi=
ce0=3D"/soc/serial@10000000"
> \
> >         -device
> opensbi-domain,id=3Ddomain,possible-harts=3D0-1,boot-hart=3D0x0,next-addr=
=3D0xBC000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f,region1=3Duart,perm=
s1=3D0x3f
>
> This will need documentation added under docs (probably under
> docs/system/riscv) of how this should be used.
>

I've just sent a v4 patch series which includes documentation! Please let
me know what you think.


> I'm not convinced this is something we want though. A user can dump
> the QEMU DTB and edit it to support OpenSBI domains if they want.
>
> My worry is that the command line method is complex for users to get
> right and will be fragile and prone to breakage as parts of QEMU's DTB
> changes.
>

I've found this patch series really useful for programmatically generating
test
fixtures in an isolation system I'm working on, which is built on top of
OpenSBI
domains. In that sense, I've found generating the correct flags is easier
rather
than manually editing or generating several dozen device tree files for eac=
h
test configuration.

I take your point that these flags are hard to get right, and there may be
more
user-friendly ways to do this. FWIW, I that this will only rarely break if
QEMU's
DTB changes -- the only part that really depends on QEMU's DTB (rather than
just adding new information to it) is the device-linking part for
memregions, and
it gives a loud, direct error if it cannot find the user-specified device.


> Also, how are users supposed to know what options to use? Maybe some
> documentation will help clear up how this should be used by users
>
> >
> > As a result of the above configuration, QEMU will add the following
> subnodes to
> > the device tree:
> >
> > chosen {
> >         opensbi-domains {
> >                 compatible =3D "opensbi,domain,config";
> >
> >                 domain {
> >                         next-mode =3D <0x01>;
> >                         next-addr =3D <0x00 0xbc000000>;
> >                         boot-hart =3D <0x03>;
> >                         regions =3D <0x8000 0x3f 0x8002 0x3f>;
> >                         possible-harts =3D <0x03 0x01>;
> >                         phandle =3D <0x8003>;
> >                         compatible =3D "opensbi,domain,instance";
> >                 };
> >
> >                 uart {
> >                         phandle =3D <0x8002>;
> >                         devices =3D <0x1800000>;
> >                         mmio;
> >                         order =3D <0x0c>;
> >                         base =3D <0x00 0x10000000>;
> >                         compatible =3D "opensbi,domain,memregion";
> >                 };
> >
> >                 mem {
> >                         phandle =3D <0x8000>;
> >                         order =3D <0x1a>;
> >                         base =3D <0x00 0xbc000000>;
> >                         compatible =3D "opensbi,domain,memregion";
> >                 };
> >         };
> > };
> >
> > This results in OpenSBI output as below, where regions 01-03 are
> inherited from
> > the root domain and regions 00 and 04 correspond to the user specified
> ones:
> >
> > Domain1 Name              : domain
> > Domain1 Boot HART         : 0
> > Domain1 HARTs             : 0,1
> > Domain1 Region00          : 0x0000000010000000-0x0000000010000fff M:
> (I,R,W,X) S/U: (R,W,X)
> > Domain1 Region01          : 0x0000000002000000-0x000000000200ffff M:
> (I,R,W) S/U: ()
> > Domain1 Region02          : 0x0000000080080000-0x000000008009ffff M:
> (R,W) S/U: ()
> > Domain1 Region03          : 0x0000000080000000-0x000000008007ffff M:
> (R,X) S/U: ()
> > Domain1 Region04          : 0x00000000bc000000-0x00000000bfffffff M:
> (R,W,X) S/U: (R,W,X)
> > Domain1 Next Address      : 0x00000000bc000000
> > Domain1 Next Arg1         : 0x0000000000000000
> > Domain1 Next Mode         : S-mode
> > Domain1 SysReset          : no
> > Domain1 SysSuspend        : no
> >
> > v3:
> > - Addressed review comments from v2 by adding default values to new
> properties.
> >   This results in concrete errors at QEMU configuration time if a
> mandatory
> >   property (as mandated by the OpenSBI spec) is not provided.
> > - Changed command line encoding for the possible-harts field from a CPU
> bitmask
> >   (e.g. where bit X is set if CPU X is a possible hart) to a range
> format (e.g.
> >   the possible harts should be CPUs X-Y, where Y >=3D X). This does
> constrain the
> >   hart assignment to consecutive ranges of harts, but this constraint i=
s
> also
> >   present for other QEMU subsystems (such as NUMA).
> > - Added create_fdt_one_device(), which is invoked when scanning the
> device tree
> >   for a memregion's devices. This function allocates a phandle for a
> region's
> >   device if one does not yet exist.
> >
> > v2:
> > - Addressed review comments from v1. Specifically, renamed domain.{c,h}
> ->
> >   opensbi_domain.{c,h} to increase clarity of what these files do. Also=
,
> more
> >   consistently use g_autofree for dynamically allocated variables
> > - Added an "assign" flag to OpenSBIDomainState, which indicates whether
> to
> >   assign the domain's boot hart to it at domain parsing time.
> >
> > Gregor Haas (1):
> >   Add support for generating OpenSBI domains in the device tree
> >
> >  MAINTAINERS                       |   7 +
> >  hw/riscv/Kconfig                  |   4 +
> >  hw/riscv/meson.build              |   1 +
> >  hw/riscv/opensbi_domain.c         | 542 ++++++++++++++++++++++++++++++
>
> There should be a license comment at the start of new files. Have a
> look at other QEMU files for examples
>

I've included this in my v4 patch series as well!


> Alistair
>
> >  hw/riscv/virt.c                   |   3 +
> >  include/hw/riscv/opensbi_domain.h |  50 +++
> >  6 files changed, 607 insertions(+)
> >  create mode 100644 hw/riscv/opensbi_domain.c
> >  create mode 100644 include/hw/riscv/opensbi_domain.h
> >
> > --
> > 2.45.2
> >
> >
>

Thanks,
Gregor

--0000000000001ce2af0621ca4752
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Alistair!<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 8, 2024 at 8:27=E2=80=AFP=
M Alistair Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@g=
mail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Tue, Aug 6, 2024 at 7:05=E2=80=AFAM Gregor Haas &lt;<a href=3D"m=
ailto:gregorhaas1997@gmail.com" target=3D"_blank">gregorhaas1997@gmail.com<=
/a>&gt; wrote:<br>
&gt;<br>
&gt; This patch series adds support for specifying OpenSBI domains on the Q=
EMU<br>
&gt; command line. A simple example of what this looks like is below, inclu=
ding<br>
&gt; mapping the board&#39;s UART into the secondary domain:<br>
<br>
Thanks for the patch, sorry it took me so long to look into this<br></block=
quote><div><br></div><div>No worries -- thanks for your review!<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m=
 4G -nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-device opensbi-memregion,id=3Dmem,ba=
se=3D0xBC000000,order=3D26,mmio=3Dfalse \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-device opensbi-memregion,id=3Duart,b=
ase=3D0x10000000,order=3D12,mmio=3Dtrue,device0=3D&quot;/soc/serial@1000000=
0&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-device opensbi-domain,id=3Ddomain,po=
ssible-harts=3D0-1,boot-hart=3D0x0,next-addr=3D0xBC000000,next-mode=3D1,reg=
ion0=3Dmem,perms0=3D0x3f,region1=3Duart,perms1=3D0x3f<br>
<br>
This will need documentation added under docs (probably under<br>
docs/system/riscv) of how this should be used.<br></blockquote><div><br></d=
iv><div>I&#39;ve just sent a v4 patch series which includes documentation! =
Please let</div><div>me know what you think.<br></div><div>=C2=A0<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m not convinced this is something we want though. A user can dump<br>
the QEMU DTB and edit it to support OpenSBI domains if they want.<br>
<br>
My worry is that the command line method is complex for users to get<br>
right and will be fragile and prone to breakage as parts of QEMU&#39;s DTB<=
br>
changes.<br></blockquote><div><br></div><div>I&#39;ve found this patch seri=
es really useful for programmatically generating test=C2=A0</div><div>fixtu=
res in an isolation system I&#39;m working on, which is built on top of Ope=
nSBI</div><div>domains. In that sense, I&#39;ve found generating the correc=
t flags is easier rather</div><div>than manually editing or generating seve=
ral dozen device tree files for each</div><div>test configuration.</div><di=
v><br></div><div>I take your point that these flags are hard to get right, =
and there may be more</div><div>user-friendly ways to do this. FWIW, I that=
 this will only rarely break if QEMU&#39;s</div><div>DTB changes -- the onl=
y part that really depends on QEMU&#39;s DTB (rather than</div><div>just ad=
ding new information to it) is the device-linking part for memregions, and<=
/div><div>it gives a loud, direct error if it cannot find the user-specifie=
d device.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
Also, how are users supposed to know what options to use? Maybe some<br>
documentation will help clear up how this should be used by users<br>
<br>
&gt;<br>
&gt; As a result of the above configuration, QEMU will add the following su=
bnodes to<br>
&gt; the device tree:<br>
&gt;<br>
&gt; chosen {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opensbi-domains {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatibl=
e =3D &quot;opensbi,domain,config&quot;;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0next-mode =3D &lt;0x01&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0next-addr =3D &lt;0x00 0xbc000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0boot-hart =3D &lt;0x03&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0regions =3D &lt;0x8000 0x3f 0x8002 0x3f&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0possible-harts =3D &lt;0x03 0x01&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0phandle =3D &lt;0x8003&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0compatible =3D &quot;opensbi,domain,instance&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uart {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0phandle =3D &lt;0x8002&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0devices =3D &lt;0x1800000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mmio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0order =3D &lt;0x0c&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0base =3D &lt;0x00 0x10000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0compatible =3D &quot;opensbi,domain,memregion&quot;;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0phandle =3D &lt;0x8000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0order =3D &lt;0x1a&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0base =3D &lt;0x00 0xbc000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0compatible =3D &quot;opensbi,domain,memregion&quot;;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; };<br>
&gt;<br>
&gt; This results in OpenSBI output as below, where regions 01-03 are inher=
ited from<br>
&gt; the root domain and regions 00 and 04 correspond to the user specified=
 ones:<br>
&gt;<br>
&gt; Domain1 Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : domain<=
br>
&gt; Domain1 Boot HART=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0<br>
&gt; Domain1 HARTs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0,1<br>
&gt; Domain1 Region00=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x000000001000000=
0-0x0000000010000fff M: (I,R,W,X) S/U: (R,W,X)<br>
&gt; Domain1 Region01=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x000000000200000=
0-0x000000000200ffff M: (I,R,W) S/U: ()<br>
&gt; Domain1 Region02=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x000000008008000=
0-0x000000008009ffff M: (R,W) S/U: ()<br>
&gt; Domain1 Region03=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x000000008000000=
0-0x000000008007ffff M: (R,X) S/U: ()<br>
&gt; Domain1 Region04=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x00000000bc00000=
0-0x00000000bfffffff M: (R,W,X) S/U: (R,W,X)<br>
&gt; Domain1 Next Address=C2=A0 =C2=A0 =C2=A0 : 0x00000000bc000000<br>
&gt; Domain1 Next Arg1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0x000000000000000=
0<br>
&gt; Domain1 Next Mode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: S-mode<br>
&gt; Domain1 SysReset=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : no<br>
&gt; Domain1 SysSuspend=C2=A0 =C2=A0 =C2=A0 =C2=A0 : no<br>
&gt;<br>
&gt; v3:<br>
&gt; - Addressed review comments from v2 by adding default values to new pr=
operties.<br>
&gt;=C2=A0 =C2=A0This results in concrete errors at QEMU configuration time=
 if a mandatory<br>
&gt;=C2=A0 =C2=A0property (as mandated by the OpenSBI spec) is not provided=
.<br>
&gt; - Changed command line encoding for the possible-harts field from a CP=
U bitmask<br>
&gt;=C2=A0 =C2=A0(e.g. where bit X is set if CPU X is a possible hart) to a=
 range format (e.g.<br>
&gt;=C2=A0 =C2=A0the possible harts should be CPUs X-Y, where Y &gt;=3D X).=
 This does constrain the<br>
&gt;=C2=A0 =C2=A0hart assignment to consecutive ranges of harts, but this c=
onstraint is also<br>
&gt;=C2=A0 =C2=A0present for other QEMU subsystems (such as NUMA).<br>
&gt; - Added create_fdt_one_device(), which is invoked when scanning the de=
vice tree<br>
&gt;=C2=A0 =C2=A0for a memregion&#39;s devices. This function allocates a p=
handle for a region&#39;s<br>
&gt;=C2=A0 =C2=A0device if one does not yet exist.<br>
&gt;<br>
&gt; v2:<br>
&gt; - Addressed review comments from v1. Specifically, renamed domain.{c,h=
} -&gt;<br>
&gt;=C2=A0 =C2=A0opensbi_domain.{c,h} to increase clarity of what these fil=
es do. Also, more<br>
&gt;=C2=A0 =C2=A0consistently use g_autofree for dynamically allocated vari=
ables<br>
&gt; - Added an &quot;assign&quot; flag to OpenSBIDomainState, which indica=
tes whether to<br>
&gt;=C2=A0 =C2=A0assign the domain&#39;s boot hart to it at domain parsing =
time.<br>
&gt;<br>
&gt; Gregor Haas (1):<br>
&gt;=C2=A0 =C2=A0Add support for generating OpenSBI domains in the device t=
ree<br>
&gt;<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 hw/riscv/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 hw/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/riscv/opensbi_domain.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 542=
 ++++++++++++++++++++++++++++++<br>
<br>
There should be a license comment at the start of new files. Have a<br>
look at other QEMU files for examples<br></blockquote><div><br></div><div>I=
&#39;ve included this in my v4 patch series as well!<br></div><div>=C2=A0<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Alistair<br>
<br>
&gt;=C2=A0 hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 include/hw/riscv/opensbi_domain.h |=C2=A0 50 +++<br>
&gt;=C2=A0 6 files changed, 607 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/riscv/opensbi_domain.c<br>
&gt;=C2=A0 create mode 100644 include/hw/riscv/opensbi_domain.h<br>
&gt;<br>
&gt; --<br>
&gt; 2.45.2<br>
&gt;<br>
&gt;<br></blockquote><div><br></div><div>Thanks,</div><div>Gregor <br></div=
></div></div>

--0000000000001ce2af0621ca4752--

