Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06551E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGR-0002iD-GM; Thu, 19 Dec 2024 11:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOJCK-0001ZV-Eh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOJCI-0002y4-4e
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734624981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKev/gR3vimWwOJ3HYhnfvaWkDaBzX6jXWS5q1E1pmo=;
 b=giD0QUUUAr8jZdMJ8CBaortva83xCIGtC/ldoiH7RWG7I1nmNeQAkmnMirC8Y5tzXsrSyZ
 qR+lgnlsWKFhqPyKIxpbC7CfG4nO+tAIVaY1LeWA+DMlIRKnlbL300OEn836MvPoCE4K2q
 lh4JQ0BhTyewu4ZoctcytbkIfS0hRKI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-4bRlzzQlPVuZzfjZ5Azcag-1; Thu, 19 Dec 2024 11:16:18 -0500
X-MC-Unique: 4bRlzzQlPVuZzfjZ5Azcag-1
X-Mimecast-MFC-AGG-ID: 4bRlzzQlPVuZzfjZ5Azcag
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa6a1bf7a82so100764266b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734624977; x=1735229777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YKev/gR3vimWwOJ3HYhnfvaWkDaBzX6jXWS5q1E1pmo=;
 b=OnsS/1zQGW7OWBdNKkjKErdFmLZ1PBJZcRwqcZJmBGBUqsyvJ57AC9mKRlEItBKIuB
 OjtiAivMLF0vcjN0aLTmMAotxpIkr8DnNOXxcxz1Qotce2vKf2smtD/12lDurWLCg2rD
 24EV6rokj8c3j5/47dbSdCSAG0DoyOQrWK3Jpe/LpqljfQzL+msNcEXQDJ7ZVTUAEag5
 UYSQ/3U1v9GniA1yo3PCfETaLmSMNrWqNmr99ts9FyDWwSxuRhcxX8ENJlfwmM3Rqz7X
 0eruaxaSN/qgJwV6ia+vSStaZsDtTX8rsybxTU9T9l5td1ZLAvGQ2dtMGnaSuCkarEEW
 xzmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQZO9l5QtlF/PcPcmtLohVmVEk6/XRypcmfTGjXZbI22G6WEo5k96XcjtUfLXo/wPv2AYG/XxkJ+A@nongnu.org
X-Gm-Message-State: AOJu0YzA589gdpQ3vPk2YLO+zwghXec/h2nSoa5krGg/B4o4xhc4Qhs7
 XfQM+Ab23uIgMzhiEPlQ+3eI/XdalF+WBb1fvWUiINrRFqiqfUXZRhOF81kjxco3oTGUbrSKQqj
 huOF4t/eHTSQaAOs25FXleEQOvAviyzSvfrrYv+FDM58xCUrsdoeGbtdzmXuxZJh0c/H68WUSWI
 uy16/RuEU87VwicoDNSkEfy89Bn5I=
X-Gm-Gg: ASbGncs3sUQ284gWSMnYuphsYUNfnSRsP4pXE5pgqgDbtrAvf4uv7KFLF+zV5iZoXew
 yReRekdb3nZm29ud7bDZ9AJFXvc0Sm2cs7iFdUeM=
X-Received: by 2002:a17:907:7f89:b0:aa6:87e8:1d0e with SMTP id
 a640c23a62f3a-aabf478a57cmr623777666b.34.1734624976794; 
 Thu, 19 Dec 2024 08:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZMglEsU7MTy0bUjgF4gGawngFvIS8xLzr1gPwdUS07HILykdHIYmIw5Jfjlmp9o+6CNG2i+9+wC4p7KlR7g0=
X-Received: by 2002:a17:907:7f89:b0:aa6:87e8:1d0e with SMTP id
 a640c23a62f3a-aabf478a57cmr623774566b.34.1734624976445; Thu, 19 Dec 2024
 08:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
In-Reply-To: <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Dec 2024 21:46:03 +0530
Message-ID: <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008a39880629a1d93e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008a39880629a1d93e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec, 2024, 9:22 pm Philippe Mathieu-Daud=C3=A9, <philmd@linaro.o=
rg>
wrote:

> On 16/12/24 12:48, Ani Sinha wrote:
>
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index d02d96e403..4c5bdb0de2 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true:
> files('mac_via.c'))
> >   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true:
> files('mips_cmgcr.c', 'mips_cpc.c'))
> >   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c')=
)
> >
> > +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true:
> files('vmfwupdate.c'))
>
> FW_CFG_DMA is offered by multiple targets ...:
>
> $ git grep -w FW_CFG_DMA
> hw/arm/Kconfig:19:    select FW_CFG_DMA
> hw/i386/Kconfig:82:    select FW_CFG_DMA
> hw/i386/Kconfig:113:    select FW_CFG_DMA
> hw/loongarch/Kconfig:22:    select FW_CFG_DMA
> hw/riscv/Kconfig:59:    select FW_CFG_DMA
>
> > diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> > new file mode 100644
> > index 0000000000..1e29a610c0
> > --- /dev/null
> > +++ b/hw/misc/vmfwupdate.c
> > @@ -0,0 +1,157 @@
> > +/*
> > + * Guest driven VM boot component update device
> > + * For details and specification, please look at
> docs/specs/vmfwupdate.rst.
> > + *
> > + * Copyright (C) 2024 Red Hat, Inc.
> > + *
> > + * Authors: Ani Sinha <anisinha@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "sysemu/reset.h"
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "hw/i386/pc.h"
>
> ... however ...
>
> > +#include "hw/qdev-properties.h"
> > +#include "hw/misc/vmfwupdate.h"
> > +#include "qemu/error-report.h"
> > +
> > +static void fw_update_reset(void *dev)
> > +{
> > +    /* a NOOP at present */
> > +    return;
> > +}
> > +
> > +
> > +static uint64_t get_max_fw_size(void)
> > +{
> > +    Object *m_obj =3D qdev_get_machine();
> > +    PCMachineState *pcms =3D PC_MACHINE(m_obj);
> > +
> > +    if (pcms) {
> > +        return pcms->max_fw_size;
>
> ... this code depends on x86/PC.
>
> Could it be wiser to add a new VM_FWUPDATE Kconfig
> symbol, having it depending on FW_CFG_DMA && I386?
>

There is no reason why vmfwupdate would be limited to x86 only. There is
minimal support needed from hypervisor side for this mechanism. That
mechanism has little dependency on specific platform.


> +    } else {
> > +        return 0;
> > +    }
> > +}
>
>

--0000000000008a39880629a1d93e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Dec, 2024, 9:22 pm Ph=
ilippe Mathieu-Daud=C3=A9, &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 16/12=
/24 12:48, Ani Sinha wrote:<br>
<br>
&gt; diff --git a/hw/misc/meson.build b/hw/misc/meson.build<br>
&gt; index d02d96e403..4c5bdb0de2 100644<br>
&gt; --- a/hw/misc/meson.build<br>
&gt; +++ b/hw/misc/meson.build<br>
&gt; @@ -148,6 +148,8 @@ specific_ss.add(when: &#39;CONFIG_MAC_VIA&#39;, if=
_true: files(&#39;mac_via.c&#39;))<br>
&gt;=C2=A0 =C2=A0specific_ss.add(when: &#39;CONFIG_MIPS_CPS&#39;, if_true: =
files(&#39;mips_cmgcr.c&#39;, &#39;mips_cpc.c&#39;))<br>
&gt;=C2=A0 =C2=A0specific_ss.add(when: &#39;CONFIG_MIPS_ITU&#39;, if_true: =
files(&#39;mips_itu.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +specific_ss.add(when: &#39;CONFIG_FW_CFG_DMA&#39;, if_true: files(&#3=
9;vmfwupdate.c&#39;))<br>
<br>
FW_CFG_DMA is offered by multiple targets ...:<br>
<br>
$ git grep -w FW_CFG_DMA<br>
hw/arm/Kconfig:19:=C2=A0 =C2=A0 select FW_CFG_DMA<br>
hw/i386/Kconfig:82:=C2=A0 =C2=A0 select FW_CFG_DMA<br>
hw/i386/Kconfig:113:=C2=A0 =C2=A0 select FW_CFG_DMA<br>
hw/loongarch/Kconfig:22:=C2=A0 =C2=A0 select FW_CFG_DMA<br>
hw/riscv/Kconfig:59:=C2=A0 =C2=A0 select FW_CFG_DMA<br>
<br>
&gt; diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..1e29a610c0<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/misc/vmfwupdate.c<br>
&gt; @@ -0,0 +1,157 @@<br>
&gt; +/*<br>
&gt; + * Guest driven VM boot component update device<br>
&gt; + * For details and specification, please look at docs/specs/vmfwupdat=
e.rst.<br>
&gt; + *<br>
&gt; + * Copyright (C) 2024 Red Hat, Inc.<br>
&gt; + *<br>
&gt; + * Authors: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" targ=
et=3D"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;sysemu/reset.h&quot;<br>
&gt; +#include &quot;hw/nvram/fw_cfg.h&quot;<br>
&gt; +#include &quot;hw/i386/pc.h&quot;<br>
<br>
... however ...<br>
<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;hw/misc/vmfwupdate.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +<br>
&gt; +static void fw_update_reset(void *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* a NOOP at present */<br>
&gt; +=C2=A0 =C2=A0 return;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static uint64_t get_max_fw_size(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Object *m_obj =3D qdev_get_machine();<br>
&gt; +=C2=A0 =C2=A0 PCMachineState *pcms =3D PC_MACHINE(m_obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (pcms) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pcms-&gt;max_fw_size;<br>
<br>
... this code depends on x86/PC.<br>
<br>
Could it be wiser to add a new VM_FWUPDATE Kconfig<br>
symbol, having it depending on FW_CFG_DMA &amp;&amp; I386?<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">There is no reaso=
n why vmfwupdate would be limited to x86 only. There is minimal support nee=
ded from hypervisor side for this mechanism. That mechanism has little depe=
ndency on specific platform.=C2=A0</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
</blockquote></div></div></div>

--0000000000008a39880629a1d93e--


