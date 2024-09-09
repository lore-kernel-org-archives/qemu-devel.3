Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B2DCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 03:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snV3y-0005wB-Ny; Sun, 08 Sep 2024 23:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snV3v-0005vQ-Oy; Sun, 08 Sep 2024 23:27:35 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snV3u-0000QZ-1w; Sun, 08 Sep 2024 23:27:35 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-846bc2104c8so2177153241.0; 
 Sun, 08 Sep 2024 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725852452; x=1726457252; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Md+SQm6eBgCK12ZzlaLuemUh2OotIkHtPxxbNnHsKns=;
 b=l4LQOy44K+HfLMAtS2Wns4vJ7MfuNs39IUx+id4a2xDkTBpqwdEaL3OFl83L+i0Euz
 ffZFbx/wcNwkoHzOdOT0uyGhWgjyRYWDC1tB14sZBSAB/akwLXzOMhLLP+A9fA8n25wG
 Gqjvfi/nOOG379Jf/69bIhzz0i9vWSwYTrQ0EnRE6J+Pahou/oPjiuX5oLSaHc93WFeR
 RX93fW7gj+zoOVptaaVHGVskAG9WgmDXnlIDDeMtQoZaABlmQLHOQ3PQuggkZa2a4fKN
 NiTb5lhzQFHCclFYrVp3WFBOCtHOxus+cuFDRtjPlj7GjUtAWM3Xngev33catIZEEpIo
 I5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725852452; x=1726457252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Md+SQm6eBgCK12ZzlaLuemUh2OotIkHtPxxbNnHsKns=;
 b=GvSBSkePEWshtfwvbqHU3Lr2UCX9FchOpFsxN/uYhVd5/bHV80f1A1gccFDjwxO157
 gdV33mP6yrnDmz+TLIcQzPRNDbpQ+3Dqrmc7z9OfmtQfU/+Cdu06c7qctEXJC5g8cj/f
 C/M2cymMeL9XkA/MrAXwklFSpy45YSJsMXH/Z7xWIwh+jE7QYRA7HJt2TDxxcSDHEs2d
 5B+7EC7i4h0AhDFX5FzEUx4fkCc9B2D1EL4Rx4c/NnST4TAgB4GYj+hTUSamBEDIlzHX
 xh9BO6dKDumg+z5mhQolZVh/PupdaJlGebBXr6SQeRe87fplEZj3erDbEvslppeBUgt4
 b38Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwG13K0fb8LQeUrtZm6bMaqQ53eS/rGNbRnoSAulznadeulZPKfdbuzTMK4dC3a2zYvrVDuOg99q57@nongnu.org
X-Gm-Message-State: AOJu0YxNFHh8+n3vzlkKCR5v1XGq/eJvbnhKBfHM+TEvGjRsbxr4P2a/
 mdxlMKh4cwe55hMKViKAyAF9iGFLNzzYN5MGWxwkBAWn17XR1lh/UrNbqkTocS6+8Gs+eDJlUkf
 JR/16eabAylrFcJk/yYOYxiW3DAg=
X-Google-Smtp-Source: AGHT+IEFbU83ldc4nU1BKbU6FAITdiOeHYupEqd6E1g67Oyq3niDWeQgXsl6HEyBOuuKVHhT1uSqZUBkIRMAEDQoRgw=
X-Received: by 2002:a05:6102:4429:b0:49b:d6db:bec0 with SMTP id
 ada2fe7eead31-49bdd68ec63mr7075223137.4.1725852452252; Sun, 08 Sep 2024
 20:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240805210444.497723-1-gregorhaas1997@gmail.com>
In-Reply-To: <20240805210444.497723-1-gregorhaas1997@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 13:27:05 +1000
Message-ID: <CAKmqyKM_qgc+wwrDRzZM1yda=dZziM=1rGU2_SDeJU9PTnacVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Add support for generating OpenSBI domains in the
 device tree
To: Gregor Haas <gregorhaas1997@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Aug 6, 2024 at 7:05=E2=80=AFAM Gregor Haas <gregorhaas1997@gmail.co=
m> wrote:
>
> This patch series adds support for specifying OpenSBI domains on the QEMU
> command line. A simple example of what this looks like is below, includin=
g
> mapping the board's UART into the secondary domain:

Thanks for the patch, sorry it took me so long to look into this

>
> qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m 4G=
 -nographic \
>         -device opensbi-memregion,id=3Dmem,base=3D0xBC000000,order=3D26,m=
mio=3Dfalse \
>         -device opensbi-memregion,id=3Duart,base=3D0x10000000,order=3D12,=
mmio=3Dtrue,device0=3D"/soc/serial@10000000" \
>         -device opensbi-domain,id=3Ddomain,possible-harts=3D0-1,boot-hart=
=3D0x0,next-addr=3D0xBC000000,next-mode=3D1,region0=3Dmem,perms0=3D0x3f,reg=
ion1=3Duart,perms1=3D0x3f

This will need documentation added under docs (probably under
docs/system/riscv) of how this should be used.

I'm not convinced this is something we want though. A user can dump
the QEMU DTB and edit it to support OpenSBI domains if they want.

My worry is that the command line method is complex for users to get
right and will be fragile and prone to breakage as parts of QEMU's DTB
changes.

Also, how are users supposed to know what options to use? Maybe some
documentation will help clear up how this should be used by users

>
> As a result of the above configuration, QEMU will add the following subno=
des to
> the device tree:
>
> chosen {
>         opensbi-domains {
>                 compatible =3D "opensbi,domain,config";
>
>                 domain {
>                         next-mode =3D <0x01>;
>                         next-addr =3D <0x00 0xbc000000>;
>                         boot-hart =3D <0x03>;
>                         regions =3D <0x8000 0x3f 0x8002 0x3f>;
>                         possible-harts =3D <0x03 0x01>;
>                         phandle =3D <0x8003>;
>                         compatible =3D "opensbi,domain,instance";
>                 };
>
>                 uart {
>                         phandle =3D <0x8002>;
>                         devices =3D <0x1800000>;
>                         mmio;
>                         order =3D <0x0c>;
>                         base =3D <0x00 0x10000000>;
>                         compatible =3D "opensbi,domain,memregion";
>                 };
>
>                 mem {
>                         phandle =3D <0x8000>;
>                         order =3D <0x1a>;
>                         base =3D <0x00 0xbc000000>;
>                         compatible =3D "opensbi,domain,memregion";
>                 };
>         };
> };
>
> This results in OpenSBI output as below, where regions 01-03 are inherite=
d from
> the root domain and regions 00 and 04 correspond to the user specified on=
es:
>
> Domain1 Name              : domain
> Domain1 Boot HART         : 0
> Domain1 HARTs             : 0,1
> Domain1 Region00          : 0x0000000010000000-0x0000000010000fff M: (I,R=
,W,X) S/U: (R,W,X)
> Domain1 Region01          : 0x0000000002000000-0x000000000200ffff M: (I,R=
,W) S/U: ()
> Domain1 Region02          : 0x0000000080080000-0x000000008009ffff M: (R,W=
) S/U: ()
> Domain1 Region03          : 0x0000000080000000-0x000000008007ffff M: (R,X=
) S/U: ()
> Domain1 Region04          : 0x00000000bc000000-0x00000000bfffffff M: (R,W=
,X) S/U: (R,W,X)
> Domain1 Next Address      : 0x00000000bc000000
> Domain1 Next Arg1         : 0x0000000000000000
> Domain1 Next Mode         : S-mode
> Domain1 SysReset          : no
> Domain1 SysSuspend        : no
>
> v3:
> - Addressed review comments from v2 by adding default values to new prope=
rties.
>   This results in concrete errors at QEMU configuration time if a mandato=
ry
>   property (as mandated by the OpenSBI spec) is not provided.
> - Changed command line encoding for the possible-harts field from a CPU b=
itmask
>   (e.g. where bit X is set if CPU X is a possible hart) to a range format=
 (e.g.
>   the possible harts should be CPUs X-Y, where Y >=3D X). This does const=
rain the
>   hart assignment to consecutive ranges of harts, but this constraint is =
also
>   present for other QEMU subsystems (such as NUMA).
> - Added create_fdt_one_device(), which is invoked when scanning the devic=
e tree
>   for a memregion's devices. This function allocates a phandle for a regi=
on's
>   device if one does not yet exist.
>
> v2:
> - Addressed review comments from v1. Specifically, renamed domain.{c,h} -=
>
>   opensbi_domain.{c,h} to increase clarity of what these files do. Also, =
more
>   consistently use g_autofree for dynamically allocated variables
> - Added an "assign" flag to OpenSBIDomainState, which indicates whether t=
o
>   assign the domain's boot hart to it at domain parsing time.
>
> Gregor Haas (1):
>   Add support for generating OpenSBI domains in the device tree
>
>  MAINTAINERS                       |   7 +
>  hw/riscv/Kconfig                  |   4 +
>  hw/riscv/meson.build              |   1 +
>  hw/riscv/opensbi_domain.c         | 542 ++++++++++++++++++++++++++++++

There should be a license comment at the start of new files. Have a
look at other QEMU files for examples

Alistair

>  hw/riscv/virt.c                   |   3 +
>  include/hw/riscv/opensbi_domain.h |  50 +++
>  6 files changed, 607 insertions(+)
>  create mode 100644 hw/riscv/opensbi_domain.c
>  create mode 100644 include/hw/riscv/opensbi_domain.h
>
> --
> 2.45.2
>
>

