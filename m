Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9763DE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNOow-00035X-U6; Mon, 16 Dec 2024 23:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tNOov-000350-1I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 23:04:29 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tNOos-0005Et-Be
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 23:04:28 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6a3c42400so844228366b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 20:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734408263; x=1735013063; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eb225oTkRla3XEzjoatD+l4GrZBnflIY7X1i/opYBoc=;
 b=nwhkUQHyo9TTqjJyPRLEgytWq9BtmOAr7hIJglayhkvwgo6e1aSRMPFtPvVjDNwfT1
 s+5NalLu5+8VghNpAnwPJBY71A2CGZYk4fBj6eGTIzNwSYcJUZm9GOQaCKFe7aCANdme
 fDcyqhVLC4H0VMd3/4Tf02y/Ja3qSDGfrna3DV3XgIs2zvr4kGC+wRyUd4Yuo5cwfhzh
 HAo8xpjL0UewtsevVczQEJqnI6uf80I43Pz9C+WZPhhckJUaVpKQ4OhCpNpasvtgRjvd
 DM6Be35aV37YT6/cCcDZHbX/sBJbyq17MpXyVo9f71h87l8Bsl+S/G+AuvxynLUtw+ME
 ZonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408263; x=1735013063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eb225oTkRla3XEzjoatD+l4GrZBnflIY7X1i/opYBoc=;
 b=Tcs/DNJMokmxkbsLBUjb/0PIJtcpEP5kIFn3n6J66t+ct8/jvor3DC88iXuBF+kAMQ
 4LN1ZOmVEjPMHGpkPxDveROap8MSUtoFpRe1ve9t+8uGfREq7mr8BvUW/IwwRcRZSm4m
 v5PZ0ZVtZtTWNXG9BHAlodJ85ghfsQMOZP3m/EC2OJaask6Odo2+LOioxiymK5Ghre1N
 K5uUg8/5k9NU7mLJsmTFSn44D+8iSoIf8AdwogN9Ld4HK9JzSZ7DRtH9IR/sYa4Bsb/8
 y8WhgwcmgwFUAtuNYfUldnIM1oUVNdRyD58jemWcpsy//Qk/TwNDrA65Izfg7kAi1jvQ
 JliA==
X-Gm-Message-State: AOJu0YyXPxLUA9FnY9BsdQL+HiWJ0xG+EoS0lxL5gwUe+r9ZUW+e5Xc+
 JrrfC/Z0lFhOiMZ2DhqQlOC6P+q5aFNIogrdB1tkDScwA1uNUFVjP7tdfEoqa51LW7OCnM/yQsZ
 mlLJz6KxWkBjfIEU6LxjUq5hW1HZtDq9Nhy5BxLLeKjLrG+D/cr0=
X-Gm-Gg: ASbGncuC+9FgSsAWgXJe8OyNb9dl91kNoUnKwX9KMiNnQy7LDWOPQytGlv6Ivuu7EnE
 sNHYmilYzY24XEnNxXJMzIUWO5QRSyIY0N19qe4yK
X-Google-Smtp-Source: AGHT+IEY3CwoGhi4/3CHvSwYy4FWlZbcLneSDZnkPfFTm/wJ3uS0Lg82pOkE5FzNDPOhP/T8oOxz0p9sbzjFuNRl2bI=
X-Received: by 2002:a17:907:7288:b0:aa4:cd1e:c91b with SMTP id
 a640c23a62f3a-aabdc88c332mr156309966b.7.1734408263439; Mon, 16 Dec 2024
 20:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20241120153935.24706-1-jim.shu@sifive.com>
 <CALw707rhW_XpQ4GQbPnpadGN2kw1KQf5gBzGTzoLgXx7ZXCEOQ@mail.gmail.com>
In-Reply-To: <CALw707rhW_XpQ4GQbPnpadGN2kw1KQf5gBzGTzoLgXx7ZXCEOQ@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Tue, 17 Dec 2024 12:04:13 +0800
Message-ID: <CALw707pgKRD33oq8MdS8jpr9j-NqXqg+dpxdG2+aYK5uzdPj1A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Support 64-bit address of initrd
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x629.google.com
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

I'm sorry for the wrong ping.
The email to apply my patch is placed in the spam mail....

On Tue, Dec 17, 2024 at 12:01=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> Hi,
>
> Gentle ping on this patch
>
> Thanks,
> Jim Shu
>
>
>
>
>
> On Wed, Nov 20, 2024 at 11:39=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wro=
te:
> >
> > Support to load DTB after 3GB on RV64 system, so that larger initrd
> > doesn't be overlapped to DTB. DTB loading now will check if overlapping
> > to kernel/initrd and report this error.
> >
> > Verify the patch via running 4GB initramfs on the virt machine.
> >
> >
> > Changes for v4:
> >
> >   - Update the comments of loading DTB in 64-bit CPU
> >   - Align image_[low|high]_addr's type with initrd_start (hwaddr)
> >   - Fix commit 2 to avoid unnecessary change .h file of board
> >
> > Changes for v3:
> >
> >   - Change struct RISCVBootInfo from machine state to local variables.
> >
> > Changes for v2:
> >
> >   - Add DTB overlapping checking and struct RISCVBootInfo
> >   - Remove the commit to change #address-cell of 'initrd-[start|end]'
> >
> > Jim Shu (3):
> >   hw/riscv: Support to load DTB after 3GB memory on 64-bit system.
> >   hw/riscv: Add a new struct RISCVBootInfo
> >   hw/riscv: Add the checking if DTB overlaps to kernel or initrd
> >
> >  hw/riscv/boot.c            | 100 +++++++++++++++++++++++++------------
> >  hw/riscv/microchip_pfsoc.c |  13 +++--
> >  hw/riscv/opentitan.c       |   4 +-
> >  hw/riscv/sifive_e.c        |   4 +-
> >  hw/riscv/sifive_u.c        |  14 +++---
> >  hw/riscv/spike.c           |  14 +++---
> >  hw/riscv/virt.c            |  13 +++--
> >  include/hw/riscv/boot.h    |  28 ++++++++---
> >  8 files changed, 127 insertions(+), 63 deletions(-)
> >
> > --
> > 2.17.1
> >

