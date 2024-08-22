Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2E5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 22:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shFvP-0004WT-Ti; Thu, 22 Aug 2024 18:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1shFvN-0004S2-VK
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 18:04:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1shFvK-0007rh-AQ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 18:04:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2021aeee5e4so9873235ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724364289; x=1724969089; darn=nongnu.org;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k2aym3OJq4lBg0ic6V8Bq4xa4m5/4p43oSzuxUUnw30=;
 b=HHKj3XYu+OoQJ1dOCNfw5VmJM5DpvJ1L5Ka8xBRU3UaAo+/OH5e1vw659FipXqw1+q
 LhKiF9UD8dB5P2bnlMjNm/GDaJ8gfaj4Af2bmJ9xp+8qKWNxDNcXlfveOHydCEOwEJ3A
 6cjCslbXrC4l9lA4t2vjsMctHkzPidJLyav0GX0TnmUbneI1Iib0R3Y5WkzKgK9KTNfv
 EPPZNpYD4Gn2kRfbMoi68bcISvayqxoaOCf9cYu94GOaRcl2Ldz3u1fxg3vYIw8k4YJy
 QloritRSaTe7VG/58VKq6pHN5McEVyPzSzy63buk2qkytXAjIydk/LviedFDvRCdDbMP
 HOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724364289; x=1724969089;
 h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k2aym3OJq4lBg0ic6V8Bq4xa4m5/4p43oSzuxUUnw30=;
 b=MJnNa91MkMMP6eMzQF0pDJHifnnnb4nOepC+j1vWbcieDWKXPQu89QW+8i4ESSwRix
 BUzujDlnmxiDhdWQh/woglDuoEiSN/Fqa/RecBDMgeVqy+pLZbHJu7WHqC9LdXIA7jlb
 7xpm5skCjGCO8NH53XH8D3Y62xXIpYd0La/qxw8G6LVDdIORnERbFPaAsSYsEtQJbDf6
 x3IJPtTUc84lMA808UWfEw9yvqkqDBxGLQpYa87J5XeIkehpRgsH/e+IBmMeZSGoeo23
 FoJiSZig7CzOMFr8JZmkx6u9pBo4mcv6REmbb2jeQ5HJiRykGkwYPgqVcbewCNB5jt9j
 J4Dw==
X-Gm-Message-State: AOJu0YxtfXyV+O8ez4+jUh0Nsbtz3MQ1/K/eK35LpGoC9GFK47bNw6dJ
 ob0XxCIgtyr89JxqgEvBfgd1tUw4o3V8cDbnHRZzDx4SEaO3wXzt3lUL4DKV3hm4Z59u1NP7mSE
 kvXKjoCmd3gr6HJp11peMBMEm1i/z1Yox
X-Received: by 2002:a17:902:c406:b0:203:74fe:4ee0 with SMTP id
 d9443c01a7336-2039e5127a6mt1707575ad.53.1724364289163; Thu, 22 Aug 2024
 15:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
 <7b23efde-3af7-4f18-8386-af5e29590d1a@ventanamicro.com>
In-Reply-To: <7b23efde-3af7-4f18-8386-af5e29590d1a@ventanamicro.com>
From: Gregor Haas <gregorhaas1997@gmail.com>
Date: Thu, 22 Aug 2024 15:04:12 -0700
Message-ID: <CAMqWt3o_TQVFiJF8H_=BS84O4hmnS_XEY1RBhYQ3bKQvta6bQw@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 alistair.francis@wdc.com
Content-Type: multipart/alternative; boundary="000000000000ec491c06204cd8ad"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, MALFORMED_FREEMAIL=3.099,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000ec491c06204cd8ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

That's correct -- I believe this [1] patch on the OpenSBI mailing list
addresses
this issue. I am currently waiting for it to be reviewed.

Thanks,
Gregor

[1] http://lists.infradead.org/pipermail/opensbi/2024-August/007240.html

On Thu, Aug 22, 2024 at 2:49=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 8/5/24 6:04 PM, Gregor Haas wrote:
> > This patch series adds support for specifying OpenSBI domains on the QE=
MU
> > command line. A simple example of what this looks like is below,
> including
> > mapping the board's UART into the secondary domain:
> >
> > qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m
> 4G -nographic \
> >          -device
> opensbi-memregion,id=3Dmem,base=3D0xBC000000,order=3D26,mmio=3Dfalse \
> >          -device
> opensbi-memregion,id=3Duart,base=3D0x10000000,order=3D12,mmio=3Dtrue,devi=
ce0=3D"/soc/serial@10000000"
> \
> >          -device
> opensbi-domain,id=3Ddomain,possible-harts=3D0-1,boot-hart=3D0x0,next-addr=
=3D0xBC000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f,region1=3Duart,perm=
s1=3D0x3f
> >
> > As a result of the above configuration, QEMU will add the following
> subnodes to
> > the device tree:
> >
> > chosen {
> >          opensbi-domains {
> >                  compatible =3D "opensbi,domain,config";
> >
> >                  domain {
> >                          next-mode =3D <0x01>;
> >                          next-addr =3D <0x00 0xbc000000>;
> >                          boot-hart =3D <0x03>;
> >                          regions =3D <0x8000 0x3f 0x8002 0x3f>;
> >                          possible-harts =3D <0x03 0x01>;
> >                          phandle =3D <0x8003>;
> >                          compatible =3D "opensbi,domain,instance";
> >                  };
> >
> >                  uart {
> >                          phandle =3D <0x8002>;
> >                          devices =3D <0x1800000>;
> >                          mmio;
> >                          order =3D <0x0c>;
> >                          base =3D <0x00 0x10000000>;
> >                          compatible =3D "opensbi,domain,memregion";
> >                  };
> >
> >                  mem {
> >                          phandle =3D <0x8000>;
> >                          order =3D <0x1a>;
> >                          base =3D <0x00 0xbc000000>;
> >                          compatible =3D "opensbi,domain,memregion";
> >                  };
> >          };
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
>
> I believe we need OpenSBI patches for this output, don't we? If I try thi=
s
> example using stock
> OpenSBI 1.5.1 from QEMU this happens:
>
>
> OpenSBI v1.5.1
>     ____                    _____ ____ _____
>    / __ \                  / ____|  _ \_   _|
>   | |  | |_ __   ___ _ __ | (___ | |_) || |
>   | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>   | |__| | |_) |  __/ | | |____) | |_) || |_
>    \____/| .__/ \___|_| |_|_____/|____/_____|
>          | |
>          |_|
>
> sbi_domain_finalize: platform domains_init() failed (error -3)
> init_coldboot: domain finalize failed (error -3)
> (--- hangs ---)
>
> It's not a big deal or a blocker to have this merged in QEMU regardless,
> but it would be nice
> to have this documented somewhere (perhaps a new doc file). This would
> prevent users from trying
> to use the device without the proper support.
>
> This can be done after this patch is queued though. Thanks,
>
>
> Daniel
>
>
> >
> > v3:
> > - Addressed review comments from v2 by adding default values to new
> properties.
> >    This results in concrete errors at QEMU configuration time if a
> mandatory
> >    property (as mandated by the OpenSBI spec) is not provided.
> > - Changed command line encoding for the possible-harts field from a CPU
> bitmask
> >    (e.g. where bit X is set if CPU X is a possible hart) to a range
> format (e.g.
> >    the possible harts should be CPUs X-Y, where Y >=3D X). This does
> constrain the
> >    hart assignment to consecutive ranges of harts, but this constraint
> is also
> >    present for other QEMU subsystems (such as NUMA).
> > - Added create_fdt_one_device(), which is invoked when scanning the
> device tree
> >    for a memregion's devices. This function allocates a phandle for a
> region's
> >    device if one does not yet exist.
> >
> > v2:
> > - Addressed review comments from v1. Specifically, renamed domain.{c,h}
> ->
> >    opensbi_domain.{c,h} to increase clarity of what these files do.
> Also, more
> >    consistently use g_autofree for dynamically allocated variables
> > - Added an "assign" flag to OpenSBIDomainState, which indicates whether
> to
> >    assign the domain's boot hart to it at domain parsing time.
> >
> > Gregor Haas (1):
> >    Add support for generating OpenSBI domains in the device tree
> >
> >   MAINTAINERS                       |   7 +
> >   hw/riscv/Kconfig                  |   4 +
> >   hw/riscv/meson.build              |   1 +
> >   hw/riscv/opensbi_domain.c         | 542 +++++++++++++++++++++++++++++=
+
> >   hw/riscv/virt.c                   |   3 +
> >   include/hw/riscv/opensbi_domain.h |  50 +++
> >   6 files changed, 607 insertions(+)
> >   create mode 100644 hw/riscv/opensbi_domain.c
> >   create mode 100644 include/hw/riscv/opensbi_domain.h
> >
>

--000000000000ec491c06204cd8ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<br><br>That&#39;s correct -- I believe this [1]=
 patch on the OpenSBI mailing list addresses<br>this issue. I am currently =
waiting for it to be reviewed.<br><br>Thanks,<br>Gregor<br><br>[1] <a href=
=3D"http://lists.infradead.org/pipermail/opensbi/2024-August/007240.html">h=
ttp://lists.infradead.org/pipermail/opensbi/2024-August/007240.html</a></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
hu, Aug 22, 2024 at 2:49=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=3D"=
mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 8/5/24 6:04 PM, Gregor Haas wrote:<br>
&gt; This patch series adds support for specifying OpenSBI domains on the Q=
EMU<br>
&gt; command line. A simple example of what this looks like is below, inclu=
ding<br>
&gt; mapping the board&#39;s UART into the secondary domain:<br>
&gt; <br>
&gt; qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m=
 4G -nographic \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device opensbi-memregion,id=3Dmem,b=
ase=3D0xBC000000,order=3D26,mmio=3Dfalse \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device opensbi-memregion,id=3Duart,=
base=3D0x10000000,order=3D12,mmio=3Dtrue,device0=3D&quot;/soc/serial@100000=
00&quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device opensbi-domain,id=3Ddomain,p=
ossible-harts=3D0-1,boot-hart=3D0x0,next-addr=3D0xBC000000,next-mode=3D1,re=
gion0=3Dmem,perms0=3D0x3f,region1=3Duart,perms1=3D0x3f<br>
&gt; <br>
&gt; As a result of the above configuration, QEMU will add the following su=
bnodes to<br>
&gt; the device tree:<br>
&gt; <br>
&gt; chosen {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opensbi-domains {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatib=
le =3D &quot;opensbi,domain,config&quot;;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 domain {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 next-mode =3D &lt;0x01&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 next-addr =3D &lt;0x00 0xbc000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 boot-hart =3D &lt;0x03&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 regions =3D &lt;0x8000 0x3f 0x8002 0x3f&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 possible-harts =3D &lt;0x03 0x01&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 phandle =3D &lt;0x8003&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 compatible =3D &quot;opensbi,domain,instance&quot;;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uart {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 phandle =3D &lt;0x8002&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 devices =3D &lt;0x1800000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 mmio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 order =3D &lt;0x0c&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 base =3D &lt;0x00 0x10000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 compatible =3D &quot;opensbi,domain,memregion&quot;;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 phandle =3D &lt;0x8000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 order =3D &lt;0x1a&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 base =3D &lt;0x00 0xbc000000&gt;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 compatible =3D &quot;opensbi,domain,memregion&quot;;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; };<br>
&gt; <br>
&gt; This results in OpenSBI output as below, where regions 01-03 are inher=
ited from<br>
&gt; the root domain and regions 00 and 04 correspond to the user specified=
 ones:<br>
&gt; <br>
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
<br>
I believe we need OpenSBI patches for this output, don&#39;t we? If I try t=
his example using stock<br>
OpenSBI 1.5.1 from QEMU this happens:<br>
<br>
<br>
OpenSBI v1.5.1<br>
=C2=A0 =C2=A0 ____=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 _____ ____ _____<br>
=C2=A0 =C2=A0/ __ \=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 / ____|=C2=A0 _ \_=C2=A0 =C2=A0_|<br>
=C2=A0 | |=C2=A0 | |_ __=C2=A0 =C2=A0___ _ __ | (___ | |_) || |<br>
=C2=A0 | |=C2=A0 | | &#39;_ \ / _ \ &#39;_ \ \___ \|=C2=A0 _ &lt; | |<br>
=C2=A0 | |__| | |_) |=C2=A0 __/ | | |____) | |_) || |_<br>
=C2=A0 =C2=A0\____/| .__/ \___|_| |_|_____/|____/_____|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|_|<br>
<br>
sbi_domain_finalize: platform domains_init() failed (error -3)<br>
init_coldboot: domain finalize failed (error -3)<br>
(--- hangs ---)<br>
<br>
It&#39;s not a big deal or a blocker to have this merged in QEMU regardless=
, but it would be nice<br>
to have this documented somewhere (perhaps a new doc file). This would prev=
ent users from trying<br>
to use the device without the proper support.<br>
<br>
This can be done after this patch is queued though. Thanks,<br>
<br>
<br>
Daniel<br>
<br>
<br>
&gt; <br>
&gt; v3:<br>
&gt; - Addressed review comments from v2 by adding default values to new pr=
operties.<br>
&gt;=C2=A0 =C2=A0 This results in concrete errors at QEMU configuration tim=
e if a mandatory<br>
&gt;=C2=A0 =C2=A0 property (as mandated by the OpenSBI spec) is not provide=
d.<br>
&gt; - Changed command line encoding for the possible-harts field from a CP=
U bitmask<br>
&gt;=C2=A0 =C2=A0 (e.g. where bit X is set if CPU X is a possible hart) to =
a range format (e.g.<br>
&gt;=C2=A0 =C2=A0 the possible harts should be CPUs X-Y, where Y &gt;=3D X)=
. This does constrain the<br>
&gt;=C2=A0 =C2=A0 hart assignment to consecutive ranges of harts, but this =
constraint is also<br>
&gt;=C2=A0 =C2=A0 present for other QEMU subsystems (such as NUMA).<br>
&gt; - Added create_fdt_one_device(), which is invoked when scanning the de=
vice tree<br>
&gt;=C2=A0 =C2=A0 for a memregion&#39;s devices. This function allocates a =
phandle for a region&#39;s<br>
&gt;=C2=A0 =C2=A0 device if one does not yet exist.<br>
&gt; <br>
&gt; v2:<br>
&gt; - Addressed review comments from v1. Specifically, renamed domain.{c,h=
} -&gt;<br>
&gt;=C2=A0 =C2=A0 opensbi_domain.{c,h} to increase clarity of what these fi=
les do. Also, more<br>
&gt;=C2=A0 =C2=A0 consistently use g_autofree for dynamically allocated var=
iables<br>
&gt; - Added an &quot;assign&quot; flag to OpenSBIDomainState, which indica=
tes whether to<br>
&gt;=C2=A0 =C2=A0 assign the domain&#39;s boot hart to it at domain parsing=
 time.<br>
&gt; <br>
&gt; Gregor Haas (1):<br>
&gt;=C2=A0 =C2=A0 Add support for generating OpenSBI domains in the device =
tree<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/opensbi_domain.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 542 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0include/hw/riscv/opensbi_domain.h |=C2=A0 50 +++<br>
&gt;=C2=A0 =C2=A06 files changed, 607 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/riscv/opensbi_domain.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/riscv/opensbi_domain.h<br>
&gt; <br>
</blockquote></div>

--000000000000ec491c06204cd8ad--

