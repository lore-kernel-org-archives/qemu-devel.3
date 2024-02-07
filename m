Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005E1C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXiPv-0006Bd-CT; Wed, 07 Feb 2024 08:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXiPt-0006BM-Ie
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:56:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXiPr-0005ZB-LR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707314203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vVKBg+GcPthaVO9ryvw/ZiVIWZ7GfD5ax0ixYa2LxsA=;
 b=IW72XPfEO+GgaJD+4I3y5akp+vCQkifhy0+LD8QkuGzs0p3QBAVyw4t1RE/5S/YJMm6J/P
 gnRQJfr/Dnhy+Bj5qxV1gdA7e9LzePyrSJsOe1I++1IB601C3J6WdBLVevXMUYr057Po8T
 x33G39RjKRWsEO3pkHPSgA5pN1tYNUc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Ed_Zqkx1PPG_qrGt_9Bbxw-1; Wed, 07 Feb 2024 08:56:40 -0500
X-MC-Unique: Ed_Zqkx1PPG_qrGt_9Bbxw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7cee760058bso418362241.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 05:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707314200; x=1707919000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vVKBg+GcPthaVO9ryvw/ZiVIWZ7GfD5ax0ixYa2LxsA=;
 b=siNXstQQ6J8pdAGMs1+2gb+x2CTMPRJMT8UTmF5bypYErVRYXWNv2YslgTbIpE4akR
 eV8qHEVcif8J1lrNhnIV6w2C8Qs3DNIpcMcv+nenltdnAYPWZfWnK2odasmxmlZ7+NAt
 VOgqVgd7FDN35DFQqycIujlupxAwyqh7nBc/PQtj2DI0y8sBZVUXdBrctJMSEiFVyzaE
 SydVpf0Gk3LdQ/bgnpixyvjvzwf6F3S96Yx4efyF8m5y3VcDkAv2BnySyH45N6ECA0/Y
 ULU7RCpex8FSOTHYoeMzGqILqa/WyzJjAkF0COcl8mU0YsP1xbqtZipLMWlQo0/9b/yv
 OhjQ==
X-Gm-Message-State: AOJu0YwXahz6N9zcm1gQE0+P0pPec6gvpfxkrJrdvw+5l/IM/UHP4krS
 dg+KCjTEJwgjIB/oXDHm/hL9XSjWDLIfa7qQoD7BgSa8bk8BXwqwwUHVla7aHN1Lxu843zoirIk
 nai16qWoJqvO2EpwYIZA4uWpz7WaVnRcqjtRdQRxrL4USPbyT7xNbJtGM6JG+MlNokhjwoKP1hr
 9bqzpPRxE8uZHLZZhb/ZJi55EKFPo=
X-Received: by 2002:a05:6102:4193:b0:46d:2f8b:d7 with SMTP id
 cd19-20020a056102419300b0046d2f8b00d7mr3053842vsb.22.1707314200302; 
 Wed, 07 Feb 2024 05:56:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWXC62k3Keea1RQseYWeGyqDhFUIRsXmniKRHA7lJpMYXHz28KfUzBBI9n0zo9A9piG2XyKZktBeWvsOFG0io=
X-Received: by 2002:a05:6102:4193:b0:46d:2f8b:d7 with SMTP id
 cd19-20020a056102419300b0046d2f8b00d7mr3053825vsb.22.1707314199989; Wed, 07
 Feb 2024 05:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-8-pbonzini@redhat.com>
 <187c8163-3bc4-747f-e165-badc086449c3@eik.bme.hu>
In-Reply-To: <187c8163-3bc4-747f-e165-badc086449c3@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Feb 2024 14:56:27 +0100
Message-ID: <CABgObfZQbXb60PTu-qkT+DMocDkz10CF4JNVpPRyf94CGi5Y+A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Bernhard Beschow <shentey@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000692f0b0610cb10aa"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000692f0b0610cb10aa
Content-Type: text/plain; charset="UTF-8"

Il mer 7 feb 2024, 14:16 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> On Wed, 7 Feb 2024, Paolo Bonzini wrote:
> > itc_reconfigure() is referenced from TCG, provide a stub if needed.
> > This makes it possible to build a QEMU binary that only includes
> > boards without a CPS device (only Malta and Boston create one).
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> > hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
> > hw/mips/meson.build     |  1 +
> > 2 files changed, 27 insertions(+)
> > create mode 100644 hw/mips/mips_itu-stub.c
> >
> > diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
> > new file mode 100644
> > index 00000000000..4cc82b8461f
> > --- /dev/null
> > +++ b/hw/mips/mips_itu-stub.c
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Inter-Thread Communication Unit emulation.
> > + *
> > + * Copyright (c) 2016 Imagination Technologies
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/misc/mips_itu.h"
> > +
> > +void itc_reconfigure(MIPSITUState *tag)
> > +{
> > +    abort();
>
> Isn't g_assert_not_reached() preferred now for it giving better
> dignostics? But I don't know, just asking.
>

Sure, changed.

Paolo


> Regards,
> BALATON Zoltan
>
> > +}
> > diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> > index f06d88f3430..2b1b96147a6 100644
> > --- a/hw/mips/meson.build
> > +++ b/hw/mips/meson.build
> > @@ -4,6 +4,7 @@ mips_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true:
> files('fw_cfg.c'))
> > mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true:
> files('loongson3_bootp.c', 'loongson3_virt.c'))
> > mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
> > mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
> > +mips_ss.add(when: 'CONFIG_MIPS_ITU', if_false: files('mips_itu-stub.c'))
> >
> > if 'CONFIG_TCG' in config_all_accel
> > mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
> >
>
>

--000000000000692f0b0610cb10aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 7 feb 2024, 14:16 BALATON Zoltan &lt;<a href=3D=
"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; ha scritto:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Wed, 7 Feb 2024, Paolo Bonzini wrote:<br=
>
&gt; itc_reconfigure() is referenced from TCG, provide a stub if needed.<br=
>
&gt; This makes it possible to build a QEMU binary that only includes<br>
&gt; boards without a CPS device (only Malta and Boston create one).<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++<br>
&gt; hw/mips/meson.build=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt; 2 files changed, 27 insertions(+)<br>
&gt; create mode 100644 hw/mips/mips_itu-stub.c<br>
&gt;<br>
&gt; diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..4cc82b8461f<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/mips/mips_itu-stub.c<br>
&gt; @@ -0,0 +1,26 @@<br>
&gt; +/*<br>
&gt; + * Inter-Thread Communication Unit emulation.<br>
&gt; + *<br>
&gt; + * Copyright (c) 2016 Imagination Technologies<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
p://www.gnu.org/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;hw/misc/mips_itu.h&quot;<br>
&gt; +<br>
&gt; +void itc_reconfigure(MIPSITUState *tag)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abort();<br>
<br>
Isn&#39;t g_assert_not_reached() preferred now for it giving better <br>
dignostics? But I don&#39;t know, just asking.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Sure, changed.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; +}<br>
&gt; diff --git a/hw/mips/meson.build b/hw/mips/meson.build<br>
&gt; index f06d88f3430..2b1b96147a6 100644<br>
&gt; --- a/hw/mips/meson.build<br>
&gt; +++ b/hw/mips/meson.build<br>
&gt; @@ -4,6 +4,7 @@ mips_ss.add(when: &#39;CONFIG_FW_CFG_MIPS&#39;, if_tru=
e: files(&#39;fw_cfg.c&#39;))<br>
&gt; mips_ss.add(when: &#39;CONFIG_LOONGSON3V&#39;, if_true: files(&#39;loo=
ngson3_bootp.c&#39;, &#39;loongson3_virt.c&#39;))<br>
&gt; mips_ss.add(when: &#39;CONFIG_MALTA&#39;, if_true: files(&#39;malta.c&=
#39;))<br>
&gt; mips_ss.add(when: &#39;CONFIG_MIPS_CPS&#39;, if_true: files(&#39;cps.c=
&#39;))<br>
&gt; +mips_ss.add(when: &#39;CONFIG_MIPS_ITU&#39;, if_false: files(&#39;mip=
s_itu-stub.c&#39;))<br>
&gt;<br>
&gt; if &#39;CONFIG_TCG&#39; in config_all_accel<br>
&gt; mips_ss.add(when: &#39;CONFIG_JAZZ&#39;, if_true: files(&#39;jazz.c&#3=
9;))<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000692f0b0610cb10aa--


