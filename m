Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C480E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfD3-0007hf-SA; Sun, 05 Jan 2025 23:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tUfD0-0007hS-NH
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 23:59:22 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tUfCy-0004G0-Fd
 for qemu-devel@nongnu.org; Sun, 05 Jan 2025 23:59:22 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so20434368a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 20:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736139558; x=1736744358; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VF9QAut3on4eHXtBgw7xeHebneM+zowCQIkwHhn0wY=;
 b=njLOq6cgxmrR1UEnNW1RtZkw0kS3ziSmuBB9FbHl/ZnlbH7wXnkh/aRNfiVm7vmJ+S
 MPlbJSqx5/wdE5GEaO/dGly+N9Utfw8aSFv8t6YOzY2AyrMrNeyl2Dd6yPIRFPwayUWw
 46/AFiMyL5zoNyTXbAE4IJnCau1ui3an+UhKYI5QDa9rxbJ/H+mT6bk7O1A1knXIP/Bv
 mzu3qi+eHhJszboob/qgMRLX8p77jlJ3K+/s+odKE2YtGfT5yCczHlel95k3oajMuYfV
 uQMHFnGxWFTkfno+7KJT+LUI9c2TIx8W6nIC9VIB6lCMg17pIiEAgKP1sHL/15O9XbGu
 4SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736139558; x=1736744358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VF9QAut3on4eHXtBgw7xeHebneM+zowCQIkwHhn0wY=;
 b=KwtMJ0ySgy2QlK+ke/K6ZQ6yHq4KdFKcp/AJ09oZattFZQt/kiW4eS6nKxZ0aTGl/v
 ZVOyyKlkTpOBMCu1KlZ/sD2Anp70Aoqyxrs+mYBHP1U9pZuJU8RK2VCS2gKq7qqalfGL
 D1BMZ52ELmRUCTHQxoh5NczaZwI3gEoObleD0i5VPDxic9ssTG35R2pWpYcRd/Cn/Xrh
 XRs0ZUqqalRoi+XacIquXfL3yqQue62dXKZzayZJz38Odfcr8yQmwJbxizPOOU/b7NGD
 bBpyUZNZnlb8BWvJ6rBus2ow04xCf6hC5pKdJ1MzLl3u0oNPQQFotgkmft/S5RZb6N6v
 JaPw==
X-Gm-Message-State: AOJu0Yw0npoN61oFkUHQgdtZoKQGseICbrR0YLE1XYlmzCCPKDzJ6uh/
 pFucGNsplqG0eEE42UPQsE21KSaGHUXv3Yr8W+GKjCfoI6a0/3vG7CgFI/7vV45u5AvIHD8K03j
 AMezdMOslmIehEZyNZwj/6YTO5ns=
X-Gm-Gg: ASbGncvf1/jAbaAx5iFbFE5HK3VBpoX+wga8Vbn8vbDtuKbojVOJg3F5zWkf4LmBpZv
 4qBiqqIGamXFsBCo8yrpRuOHx38AUugYICQIe/Nk=
X-Google-Smtp-Source: AGHT+IG4zYuiMXeAnQKrGEMisxxjV0zaYqADcfvYs/h5v00rkkFST7YZC8j9ep502mwmit3Yyz5VoWyRsxBeo8nkTIU=
X-Received: by 2002:a17:90b:2c84:b0:2ea:a25d:3baa with SMTP id
 98e67ed59e1d1-2f452dfa40bmr88297116a91.5.1736139557527; Sun, 05 Jan 2025
 20:59:17 -0800 (PST)
MIME-Version: 1.0
References: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
 <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
In-Reply-To: <CAKmqyKPo=a=RHUvvgKZLB_DJnEXO=7u25MwNfXu5EDjak=y0vg@mail.gmail.com>
From: Sam Price <thesamprice@gmail.com>
Date: Sun, 5 Jan 2025 23:59:06 -0500
Message-ID: <CAEekfLaW=-tpTo73or0Lv6zqOuCa67UoYSt9guyHFsw6yM37mg@mail.gmail.com>
Subject: Re: Subject: [PATCH] loader: Add register setting support via cli
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=thesamprice@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I didn't mean to change all of the submodules.
I was somewhat porting from xilinx-qemu over to the main line, and
messed up the commit on that.
Ill get my gitlab branch fixed up on the next commit.
I am horrible at this email part.

I could malloc memory and push all of the register names/ values into
a queue, and then call the backend gdb routines on the number of
calls.
I will rely on the gdb routine for doing validation of both the name /
value arguments.

I will make an implementation of this using the include/qemue/queue.h
to store all passed in register arguments.
https://gitlab.com/thesamprice/qemu/-/blob/master/include/qemu/queue.h
If there is a better datastructure I should use for implementation let me k=
now.

Ill also update docs/system/generic-loader.rst

Are unit tests needed?
Any guidance on what you would want done for this would be appreciated.

Thanks,
Sam

On Sun, Jan 5, 2025 at 11:41=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, Dec 6, 2024 at 1:30=E2=80=AFPM Sam Price <thesamprice@gmail.com> =
wrote:
> >
> > I needed to set the registers prior to boot up to mimic what uboot
> > would do prior to loading a binary.  This adds a generic option of reg
> > to the loader command, it uses the existing gcc commands for setting
> > register values.
> >
> > I'm sorry I couldn't figure out how to work the git send-email
> > properly.  Configuring it with my gmail became too cumbersome, and my
> > work email was also challenging to configure.
> >
> > I have the file staged here.
> > https://gitlab.com/thesamprice/qemu/-/tree/loader?ref_type=3Dheads
> > I am unsure of how to add tests for this.
> > I could continue working too polish this off with instructions from
> > others if it is desired for the main line.
>
> Thanks for the patch. This will need documentation added under
> `docs/system/generic-loader.rst` so that people know how to use it and
> what it does
>
> >
> > Signed-off-by: Sam Price <thesamprice@gmail.com>
> > ---
> >
> > ---
> >  hw/core/generic-loader.c         | 28 ++++++++++++++++++++++++++++
> >  include/hw/core/generic-loader.h |  6 +++++-
> >  roms/SLOF                        |  2 +-
> >  roms/edk2                        |  2 +-
> >  roms/openbios                    |  2 +-
> >  roms/opensbi                     |  2 +-
> >  roms/seabios                     |  2 +-
> >  roms/seabios-hppa                |  2 +-
> >  tests/lcitool/libvirt-ci         |  2 +-
> >  9 files changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> > index ea8628b892..ebda8ac43f 100644
> > --- a/hw/core/generic-loader.c
> > +++ b/hw/core/generic-loader.c
> > @@ -55,6 +55,19 @@ static void generic_loader_reset(void *opaque)
> >          }
> >      }
> >
> > +    for (int i =3D 0; i < 31; i++) {
>
> Why 31?
>
> I'm guessing you picked this because that's how many registers your
> architecture supports, but that's not the same for all architectures
>
> > +        if (s->has_register_defaults[i]) {
> > +            CPUClass *cc =3D CPU_GET_CLASS(s->cpu);
> > +            uint8_t buf[sizeof(uint64_t)];
> > +            memcpy(buf, &s->register_defaults[i], sizeof(uint64_t));
> > +            if (cc && cc->gdb_write_register) {
> > +                cc->gdb_write_register(s->cpu, buf, i);
> > +            }
> > +        }
> > +    }
> > +
> > +
> > +
> >      if (s->data_len) {
> >          assert(s->data_len <=3D sizeof(s->data));
> >          dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
> > @@ -172,6 +185,20 @@ static void generic_loader_realize(DeviceState
> > *dev, Error **errp)
> >      } else {
> >          s->data =3D cpu_to_le64(s->data);
> >      }
> > +
> > +    /* Store the CPU register default if specified */
> > +    if (s->reg) {
> > +        int reg_num;
> > +        if (sscanf(s->reg, "r%d", &reg_num) =3D=3D 1 &&
> > +                    reg_num >=3D 0 && reg_num < 31) {
>
> I don't think all architectures call their registers r* and they don't
> all have 31 registers
>
> > +            s->register_defaults[reg_num] =3D s->data;
> > +            s->has_register_defaults[reg_num] =3D true;
> > +        } else {
> > +            error_setg(errp, "Unsupported register: %s", s->reg);
> > +            return;
> > +        }
> > +    }
> > +
> >  }
> >
> >  static void generic_loader_unrealize(DeviceState *dev)
> > @@ -186,6 +213,7 @@ static Property generic_loader_props[] =3D {
> >      DEFINE_PROP_BOOL("data-be", GenericLoaderState, data_be, false),
> >      DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NON=
E),
> >      DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false=
),
> > +    DEFINE_PROP_STRING("reg", GenericLoaderState, reg),
> >      DEFINE_PROP_STRING("file", GenericLoaderState, file),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic=
-loader.h
> > index 19d87b39c8..d81e1632fd 100644
> > --- a/include/hw/core/generic-loader.h
> > +++ b/include/hw/core/generic-loader.h
> > @@ -35,10 +35,14 @@ struct GenericLoaderState {
> >      uint32_t cpu_num;
> >
> >      char *file;
> > -
> > +    char *reg;
> >      bool force_raw;
> >      bool data_be;
> >      bool set_pc;
> > +
> > +    /* Add an array for storing default register values */
> > +    bool has_register_defaults[31];  /* Track if a default value is pr=
ovided */
> > +    uint64_t register_defaults[31];  /* Default values for registers r=
0-r30 */
> >  };
> >
> >  #define TYPE_GENERIC_LOADER "loader"
> > diff --git a/roms/SLOF b/roms/SLOF
> > index 3a259df244..6b6c16b4b4 160000
> > --- a/roms/SLOF
> > +++ b/roms/SLOF
> > @@ -1 +1 @@
> > -Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
> > +Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
> > diff --git a/roms/edk2 b/roms/edk2
> > index 4dfdca63a9..f80f052277 160000
> > --- a/roms/edk2
> > +++ b/roms/edk2
> > @@ -1 +1 @@
> > -Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
> > +Subproject commit f80f052277c88a67c55e107b550f504eeea947d3
> > diff --git a/roms/openbios b/roms/openbios
> > index c3a19c1e54..af97fd7af5 160000
> > --- a/roms/openbios
> > +++ b/roms/openbios
> > @@ -1 +1 @@
> > -Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
> > +Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5
> > diff --git a/roms/opensbi b/roms/opensbi
> > index 43cace6c36..057eb10b6d 160000
> > --- a/roms/opensbi
> > +++ b/roms/opensbi
> > @@ -1 +1 @@
> > -Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
> > +Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
> > diff --git a/roms/seabios b/roms/seabios
> > index a6ed6b701f..ea1b7a0733 160000
> > --- a/roms/seabios
> > +++ b/roms/seabios
> > @@ -1 +1 @@
> > -Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
> > +Subproject commit ea1b7a0733906b8425d948ae94fba63c32b1d425
> > diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> > index a528f01d7a..673d2595d4 160000
> > --- a/roms/seabios-hppa
> > +++ b/roms/seabios-hppa
> > @@ -1 +1 @@
> > -Subproject commit a528f01d7abd511d3cc71b7acaab6e036ee524bd
> > +Subproject commit 673d2595d4f773cc266cbf8dbaf2f475a6adb949
> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> > index 9ad3f70bde..9bff3b763b 160000
> > --- a/tests/lcitool/libvirt-ci
> > +++ b/tests/lcitool/libvirt-ci
> > @@ -1 +1 @@
> > -Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
> > +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
>
> Did you mean to change all of these submodules?
>
>
> Alistair
>
> > --
> > 2.45.2
> >



--=20
Sincerely,

Sam Price

