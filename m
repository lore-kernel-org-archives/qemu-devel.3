Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB98FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 11:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYkZk-0001Cn-LZ; Fri, 17 Jan 2025 06:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1tYkZi-0001Cf-QJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:31:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1tYkZY-0006Mu-0s
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 06:31:42 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso13097775e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 03:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737113488; x=1737718288; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nng5JAKRrmlKTMI6nkHlXlYBxkslNvTjteMylTgaRaA=;
 b=d1vXX/0X2Pe+/t8wrAht7C7eOJdzMQLziLDCsi3bzG0WQ7cdQqybhEARUcG9UIIegj
 ylnOQ3VALJaAwyA8OV1X2RSBJga18/c6Xo1Lgkk19n89vxyuX6HRUZnz8FUHKIanMDGr
 TZyjFe9pdDRaVZOxiBT3XQcA7ZfT40JnibNtwj4rxPNpXw/8/FuCwFQ2aeTRlgrj739L
 eaO0/ng5oyxiomUnMa/R9C7+GHu9C5mDJWnpiPYPnaBId2+32/ihijULWUHtdJHgrwx8
 lMWmUTVBVmnXnwn3g6TjDA90O7n/x8NiblYLzinhvis1nTbSXhJrXGDr82ziq7MrIrfP
 uApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737113488; x=1737718288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nng5JAKRrmlKTMI6nkHlXlYBxkslNvTjteMylTgaRaA=;
 b=n41/i+4P9o2inbXL4X1FM8uehwn086y/0EKprqwRM2OO6J2Gio4AnGpv3APozSCEDT
 R+MMJIeykG8eHDjw1K8LCrWD1oTUaOuzWBJAz+kZIRhqgDhN9PGkr7OxLIdbc0ZBFwDq
 9L0A/AV1rfOIlQn4J+X0QcFTBaBVfKuqzIC6WbZJhCpMyWgyP7c48H+egoE9pfEJN8FO
 XHQovl0QpDCKKUrjLe98vJTZxM2OOga3K7oMHEqmPBFC/lJX8oU5kaE+7OljjS5c8y5O
 +Byem1BzUYAFphMMcJQVAQ5wAjc3zAu9s2WJfHu+ulptciM1boCnR678m0SiJNyJje7v
 09Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoTVyDCGIPMxhWDZOdS/pP2hRGt2JfL4DalkJntmNLdOIDXS//Sx8nvES8UwZf7OsNyn7ecTkYrXbM@nongnu.org
X-Gm-Message-State: AOJu0YxaCn/ULe3zWkETBGOsSui2xcnZPkOs0EnvrLLnnSddByDRHH4C
 GQtDMV9f5Vmf5aNHIjaNbLJnEkEUYE3XpBvi2ydUcSvlxnbErQZB2NECL1oun8mU3grPczXWe0H
 fHeoIiRde+UzpRk8vobiod65KgmA=
X-Gm-Gg: ASbGnctci/L4RxUMUEu4FEELIlVSzqRlcEXQoYGUhgr5VUnhFx25TpQ/t1OYaBIpgRV
 zawfzvXAoNx6La+IcUN9cec8Ln5nm1tj2eL+YMmk=
X-Google-Smtp-Source: AGHT+IG2vGDSbmjC0pb8FTD3p6zaSFKR3nXjIJZS6rh43XaBWVu6SWGFylmO9gGi23zhUGf6RjjYvq1mgRQmR+TcJVg=
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-438913ef6d0mr24205485e9.18.1737113487265; Fri, 17 Jan 2025
 03:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20250116095355.41909-1-east.moutain.yang@gmail.com>
 <20250116124740.51cf4182.alex.williamson@redhat.com>
 <f4539bec-d74b-4bf8-b874-dd8437126978@redhat.com>
In-Reply-To: <f4539bec-d74b-4bf8-b874-dd8437126978@redhat.com>
From: Yang Dongshan <east.moutain.yang@gmail.com>
Date: Fri, 17 Jan 2025 19:31:16 +0800
X-Gm-Features: AbW1kvaUME88uKF4tgnNiG93vV6Ga52ZI-TdwHqnPRgYmMjbeVbUqEMKKkpey44
Message-ID: <CALrP2iWcijh7x=H_PrQT-h9rpdckn6O3FoXbBzzcrGmWQyBjWw@mail.gmail.com>
Subject: Re: [PATCH] vfio: Support P2P access in confidential VM
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com, 
 sgarzare@redhat.com
Content-Type: multipart/alternative; boundary="00000000000057d7ea062be54009"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000057d7ea062be54009
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Yes. This patch should also be divided in 4 parts :
>
>  - kernel header changes with links to the threads modifying the kernel.
>   - common part,
>   - vpda part,
>   - and vfio,

ok, I will divide it into 4 patches.
thanks C=C3=A9dric

On Fri, Jan 17, 2025 at 2:15=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:

> >> --- a/linux-headers/linux/vfio.h
> >> +++ b/linux-headers/linux/vfio.h
> >> @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
> >>   #define VFIO_DMA_MAP_FLAG_READ (1 << 0)            /* readable from
> device */
> >>   #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)   /* writable from device *=
/
> >>   #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
> >> +#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)
> >
> > Where's the kernel patch that implements the MMIO map flag.  That needs
> > to come first.
>
> Yes. This patch should also be divided in 4 parts :
>
>    - kernel header changes with links to the threads modifying the kernel=
.
>    - common part,
>    - vpda part,
>    - and vfio,
>
>
> Thanks,
>
> C.
>
>
>
> > I also don't understand why we're creating multiple read-only and
> > ramdev flags to distill back into vfio mapping flags.  Thanks,
> >
>
>

--00000000000057d7ea062be54009
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; Yes. This patch should also be divided in 4 part=
s :<br>&gt;=C2=A0<br>&gt;=C2=A0 - kernel header changes with links to the t=
hreads modifying the kernel.<br>&gt;=C2=A0 =C2=A0- common part,<br>&gt;=C2=
=A0 =C2=A0- vpda part,<br>&gt;=C2=A0 =C2=A0- and vfio,</div><div><br></div>=
<div>ok, I will divide it into 4 patches.</div><div>thanks=C2=A0C=C3=A9dric=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, Jan 17, 2025 at 2:15=E2=80=AFAM C=C3=A9dric L=
e Goater &lt;<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;&gt; --- a=
/linux-headers/linux/vfio.h<br>
&gt;&gt; +++ b/linux-headers/linux/vfio.h<br>
&gt;&gt; @@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {<br>
&gt;&gt;=C2=A0 =C2=A0#define VFIO_DMA_MAP_FLAG_READ (1 &lt;&lt; 0)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* readable from device */<br>
&gt;&gt;=C2=A0 =C2=A0#define VFIO_DMA_MAP_FLAG_WRITE (1 &lt;&lt; 1)=C2=A0 =
=C2=A0/* writable from device */<br>
&gt;&gt;=C2=A0 =C2=A0#define VFIO_DMA_MAP_FLAG_VADDR (1 &lt;&lt; 2)<br>
&gt;&gt; +#define VFIO_DMA_MAP_FLAG_MMIO (1 &lt;&lt; 3)<br>
&gt; <br>
&gt; Where&#39;s the kernel patch that implements the MMIO map flag.=C2=A0 =
That needs<br>
&gt; to come first.<br>
<br>
Yes. This patch should also be divided in 4 parts :<br>
<br>
=C2=A0 =C2=A0- kernel header changes with links to the threads modifying th=
e kernel.<br>
=C2=A0 =C2=A0- common part,<br>
=C2=A0 =C2=A0- vpda part,<br>
=C2=A0 =C2=A0- and vfio,<br>
<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
<br>
&gt; I also don&#39;t understand why we&#39;re creating multiple read-only =
and<br>
&gt; ramdev flags to distill back into vfio mapping flags.=C2=A0 Thanks,<br=
>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000057d7ea062be54009--

