Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7E606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DRYr3m+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPO3n-0000nf-B0; Fri, 06 Nov 2026 12:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPO1H-0000N7-UA
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:46:38 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPO1G-0006bD-4m
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:46:31 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-67990a45e02so962787d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:46:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987189; cv=none;
 d=google.com; s=arc-20260327;
 b=f4He45jAxU2vDFPRoxpRYCQPos4w3woNP58/RS0M1KF9vvfNqDSv8WqiiyO+AsTzHG
 zv3gT236ZM5DmVFJ2tM6L+jFiTEc7HJ3Hjkqad+bpb6v2s9wifg6Ur7yPz0u7F65+fNG
 xA2BwVeCQ1fsaehqZRzRoheoXh6sDR0Z5gUR3DIbuQC4otypWNzErUQUIaVMfYnmY7+n
 6Dz1wpjWVoRp/rBBVLJwiYqcPeJK4V3QkW+ptm5/QwI29L89QRw8tjBnEKnxrhgeN2Rp
 XaLlKBawgO6DBOotUcM8GV/qPtatsrRJirBycBAwZ4DicjsODScLu8Op/yC+4l72As+e
 0iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=TfYHpdnIHaDmIyTKbgswtHkJ5hfmt32LbB9/AoqvBQA=;
 fh=NMe96GAiLKSrd2j6VF4VASvf6rm/0Lv3LDgYXjvc75g=;
 b=MKWQ1Y2CNrCX4o30iC6X7VGuJ++I/ZF0QTsB6rvjoXe5qs2c4hx30OqDcLnC6UM4J+
 rnVKv+nI1KsaBPf2NLKuE9nSKQ0zoeMJ7fiE8QgbEC81aRy+8f31TO1+yqlwVEJPdsY0
 syxl1JTuMJeeUZnjtdQbbQge2INL0Dw6l/ALlCzkp46cVHnBbjQmtjMs8Ps9HvmMKaky
 FkS6w9oL2xboqKzAjcIkbniyVOCYyhpcUyVFOCrgJQThGFP1hGKEq2WZJ90izTZf7Ilc
 gmsAXYptdUcf7QAQNv+jgCs5oGkUYo5dVpuHUfYtHQ8o69nvcCjPcLxaK3nwicTo70ov
 2UlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793987189; x=1794591989; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TfYHpdnIHaDmIyTKbgswtHkJ5hfmt32LbB9/AoqvBQA=;
 b=DRYr3m+hqxlMn5OQHTpv5MdiZ0QwspmjHYCn+sUYX3tJXjfyDKwgEeC1a1/v8kOwpV
 yQwfifPnIE+m4OH79ppF/ouDUyczUjaStT6iHQJTCh0WkaW/q2ELrtLhlrBniYjZalFZ
 Xyh2SdDNnxU0AviZiAWJn7L0N+73HQ+ApcRD2hTSGD86uujXHHUrH4A7c2oyEQJ3CDrs
 cE8xLaKe0PuMz7lLmwoU3zv++WWd8Gc75fz/WfUHDg1KUMMC1iBlEf8Y8783ILFuYD0o
 /vjC9MTjJEGTNXjN4XK1iuQMLgx2YjDotBdwtUC5rBVwYZ6m0AWOsSfwrXasqz+gH1IW
 g/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987189; x=1794591989;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TfYHpdnIHaDmIyTKbgswtHkJ5hfmt32LbB9/AoqvBQA=;
 b=qIZIA7GsylWi6wprsuh2euO6afd3EwKs2pxuCaaeSzZKu+P8M4W2VB/YfcQ6HaCy2H
 JyBjnU+Nfc2DYRDLRUz8jNu1TG75mnEOI7bb8vJST8g9++USOKG9U34pO8INTGhPWV4N
 TAHC/MsriO47LAxh1pfJ8RIEJiiyuWjFC0vBFjVVyVV//bx+U8WReEDhwPPSde+CEzL+
 rmIY0WSH5It2wJ90a3TPfq8ZwFe5/AG5z4ypvzrCX8a8lh+HMqdb++ewGUlutzf1ha/s
 EoQZ3HXRDBsSoTdiUyZJPK7BTf1tTX7WtiUrKhspt31Gi9hH/OHbhRlEcseMmD2aMpK1
 Bc8A==
X-Gm-Message-State: APuU4Z/iy/xyPTJzdySZ70eUm7TgYSdHc6YD852Z5L/0CCCQnxQXYD+X
 oveoQRqrmH5MW03glA+vhAe7yw48I2ueapYaoACF5x/AuSigltqsjKdjuTU91+A0rVCnmqizhyG
 BxCBCZwoArbS8xWCLrcR9pt8nwZdgv7A=
X-Gm-Gg: AYBFou2FGcMQl9cysGEu9T+5O0Wtp0HXkd52/DUXZjNLH1P5+MWSIbok5BQDqergexZ
 Yh7l3EUDSnyR3JkkipKH6MJBB98BLGVM38kLGBsorrjo280sxsXpugVQPfZ5FcPIq1clN75s6wC
 zrbnGnj5RsyZ0Xu9mU4vNDj6TgaCVFVGQUZg1T8/dDaruGSbU/p1xjFog8rQaaaUoeq6XkaKrf2
 uNXTXmqPFdWLwCUtA289S24b0xo2qaxAGhH9+IRwjlVh0J1dWLDEZ/RDNHzdOlzjEOqEJQzrfwD
 jYKtN1fenDkM5+qfxvsPh/F9LOSQzugFEFTFTMGdwg+gA4EQY4KddexSeIv2vR4ATSe1wsCbSF7
 GC7M+baEnDIksSTXbNPGn/V2mf8XvUV9kuHCHetzDYh8nOs+77xsO4cBNtw==
X-Received: by 2002:a05:690e:4145:b0:67c:1907:922a with SMTP id
 956f58d0204a3-67c19079741mr1871540d50.18.1793987188579; Fri, 06 Nov 2026
 09:46:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105190346.1539-1-luoyonggang@gmail.com>
 <20261105190346.1539-3-luoyonggang@gmail.com>
 <f84768d9-1aa4-463d-a0f5-4844a4babe22@oss.qualcomm.com>
In-Reply-To: <f84768d9-1aa4-463d-a0f5-4844a4babe22@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 01:46:12 +0800
X-Gm-Features: AclHuK9kqQy2EfbHo6VtQiH7_wVFW-o6mRBIkq3MZzMYAL2-ZGfXMZAviKqrLcE
Message-ID: <CAE2XoE_u9AhjKZxtocf-e=8SjgiJ5gURxJVmwoXHTu6uKWK9+g@mail.gmail.com>
Subject: Re: [PATCH 2/5] target-info: add target_mask_selected()
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb12b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 1:44=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/5/2026 11:03 AM, Yonggang Luo wrote:
> > Return the QEMU_ARCH_* mask of the selected target. System mode
> > returns QEMU_ARCH_ALL until a target is selected. User mode returns
> > that target's bit. Tools return 0.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/qemu/target-info-init.h | 15 ++++++++++-----
> >  include/qemu/target-info.h      |  9 +++++++++
> >  stubs/meson.build               |  1 +
> >  stubs/target-mask-selected.c    | 13 +++++++++++++
> >  target-info-def.c               |  3 +++
> >  target-info-qom.c               | 10 ++++++++++
> >  6 files changed, 46 insertions(+), 5 deletions(-)
> >  create mode 100644 stubs/target-mask-selected.c
> >
> > diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info=
-init.h
> > index b7024c9fae..8492986832 100644
> > --- a/include/qemu/target-info-init.h
> > +++ b/include/qemu/target-info-init.h
> > @@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT_T=
ARGET_INFO)
> >
> >  /*
> >   * User mode does not support multiple targets in the same binary, so =
just
> > - * define target_info().
> > + * define target_info() and target_mask_selected(). The target is alwa=
ys
> > + * selected.
> >   */
> > -#define target_info_init(ti_var)        \
> > -const TargetInfo *target_info(void)     \
> > -{                                       \
> > -    return &ti_var;                     \
> > +#define target_info_init(ti_var)                           \
> > +const TargetInfo *target_info(void)                        \
> > +{                                                          \
> > +    return &ti_var;                                        \
> > +}                                                          \
> > +uint64_t target_mask_selected(void)                        \
> > +{                                                          \
> > +    return QEMU_ARCH_BIT((ti_var).target_arch);            \
> >  }
> >
> >  #else /* CONFIG_USER_ONLY */
> > diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> > index 2cd4cc5671..5673d10eba 100644
> > --- a/include/qemu/target-info.h
> > +++ b/include/qemu/target-info.h
> > @@ -134,4 +134,13 @@ bool target_base_riscv(void);
> >   */
> >  bool target_riscv64(void);
> >
> > +/**
> > + * target_mask_selected:
> > + *
> > + * Returns the QEMU_ARCH_* mask of the selected target. System mode
> > + * returns QEMU_ARCH_ALL until a target is selected. User mode returns
> > + * that target's bit. Tools return 0.
> > + */
> > +uint64_t target_mask_selected(void);
> > +
> >  #endif
> > diff --git a/stubs/meson.build b/stubs/meson.build
> > index 744fb759a2..49cede8582 100644
> > --- a/stubs/meson.build
> > +++ b/stubs/meson.build
> > @@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
> >  stub_ss.add(files('qapi-event-emit.c'))
> >  stub_ss.add(files('replay-mode.c'))
> >  stub_ss.add(files('trace-control.c'))
> > +stub_ss.add(files('target-mask-selected.c'))
> >
>
> For which configs is the stub required?
> target-info-def will always be present.

For tools

>
> >  if have_block
> >    stub_ss.add(files('bdrv-next-monitor-owned.c'))
> > diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selected.=
c
> > new file mode 100644
> > index 0000000000..510a515851
> > --- /dev/null
> > +++ b/stubs/target-mask-selected.c
> > @@ -0,0 +1,13 @@
> > +/*
> > + * Tools have no selected target.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/target-info.h"
> > +
> > +uint64_t target_mask_selected(void)
> > +{
> > +    return 0;
> > +}
> > diff --git a/target-info-def.c b/target-info-def.c
> > index bcf9cfe1e4..a992019626 100644
> > --- a/target-info-def.c
> > +++ b/target-info-def.c
> > @@ -9,6 +9,9 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/target-info.h"
> >  #include "qemu/target-info-def.h"
> > +#ifdef CONFIG_USER_ONLY
> > +#include "qemu/base-arch-defs.h"
> > +#endif
> >  #include "qemu/target-info-init.h"
> >  #include "hw/core/boards.h"
> >  #include "cpu.h"
> > diff --git a/target-info-qom.c b/target-info-qom.c
> > index aeeedb7e81..fb4c9835e5 100644
> > --- a/target-info-qom.c
> > +++ b/target-info-qom.c
> > @@ -9,6 +9,8 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "qom/object.h"
> > +#include "qemu/base-arch-defs.h"
> > +#include "qemu/target-info.h"
> >  #include "qemu/target-info-def.h"
> >  #include "qemu/target-info-init.h"
> >  #include "qemu/target-info-qom.h"
> > @@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
> >      return target_info_ptr;
> >  }
> >
> > +uint64_t target_mask_selected(void)
> > +{
> > +    if (!target_info_ptr) {
> > +        return QEMU_ARCH_ALL;
> > +    }
> > +    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
> > +}
> > +
> >  void target_info_qom_set_target(void)
> >  {
> >      g_autoptr(GSList) targets =3D object_class_get_list(TYPE_TARGET_IN=
FO, false);
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

