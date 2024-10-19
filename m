Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD81D3C923
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 17:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2DGx-0003GM-ML; Sat, 19 Oct 2024 13:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1t2DGw-0003GD-PT
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 13:29:50 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1t2DGv-0001Y6-9j
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 13:29:50 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84fcb49691fso966035241.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729358988; x=1729963788; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mRx6I5UIL0lJKXEhh8jODYiE5PeoCQVTR0JvhTjfNX0=;
 b=UOn2jWFY+KxvNyfZJGebnRh3cR8eaPjAg5jlkfHts1YfDJa3zW8/FhMNXiXtmd0wal
 Ld5JHMF8HCe5t2MRnEAYhYfoNmdomEg69VtIytD65M7MrkYAEHDc3ayZchdJQdfK6BCe
 MwxiNdRpnu2GsltzhnI18Vvjbf71faal9vIz34TGTpwCOd0XiroU9zaPZpsH4A/VBSb2
 J47KCQLA8g3hlT4o8B3eJubmM9rkk7W2b3are3LDLbEtWlhmIsNX3RXcodBOkynHiNWx
 sF8WbtSqBxT3oVyZoJuFf+Vkp0X8FEcVD9QGthCo5yiCtwkoOhpmpR2psot05u0PZeyg
 RXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729358988; x=1729963788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mRx6I5UIL0lJKXEhh8jODYiE5PeoCQVTR0JvhTjfNX0=;
 b=r2ETqmdxe/g7GeegnHBixCIQYRVFDAWUnz1QAU5La9+d6Rqt81/UE+jwxoQf20I4Ku
 IEKbDuObtk9j/u5MnDGR9B+mT3Ohugk4ky3+NdX5t+2UZ82peD0xYdumpWdxgj6A+fcI
 r9mAelP0JWzYPS/N0ZYWkIkdWo0US2/coW9Mry2yBUdrDwvPIiLwe8nYbKCZR1x2Xxii
 AbOcGZ4RpX2WGTcXlP08lsp4EZDfFACglIprFFFymm8IXarNh8uw66v2jtdhjTOBCDLc
 GmuVyNTg8R4/p4DBem5Op5fe0JQMDNG4i5xsXaPsXAWGiJPqXds9TfB4j2ZCARNC4+u4
 qJyg==
X-Gm-Message-State: AOJu0YzfJAJNxsdmLJSssxZvOA8uQbSuQBYg800nmaeD/v/7fn16Rf/L
 QpAUg9cJTdEQhYM++7/IYfDbuKmQxbF0qj7jk+ht4vuiWrZg6p1+sNiH3NVEL71F+V1TriOaUzT
 u3S4IsoWGAmbj0Xn7wjY0xHhCIsSKAwSB
X-Google-Smtp-Source: AGHT+IHmW8bvc1YKFMvjJA3EoObQ4hwSQwka7cIeNgSJEDivDkfTkFb2YspBswH6o4I5MT/p4jUSXFTdJOFw8ukPvzw=
X-Received: by 2002:a05:6102:c8b:b0:4a5:b32d:be00 with SMTP id
 ada2fe7eead31-4a5d6b8ec29mr6340258137.18.1729358987866; Sat, 19 Oct 2024
 10:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <5807fbae77440ce091c1480a173e371a72142952.1729355735.git.neither@nut.email>
In-Reply-To: <5807fbae77440ce091c1480a173e371a72142952.1729355735.git.neither@nut.email>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 19 Oct 2024 20:29:09 +0300
Message-ID: <CAK4993jgSfvHDvtgtzeqEYneN9k8c7Qru_KH5FXJDfgmzJiX4w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/7] target/avr: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000293b580624d7c45b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=mrolnik@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000293b580624d7c45b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Michael Rolnik <mrolnik@gmail.com>

On Sat, Oct 19, 2024 at 7:39=E2=80=AFPM Julian Ganz <neither@nut.email> wro=
te:

> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places the hook for AVR targets. That architecture appears
> to only know interrupts.
>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  target/avr/helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 345708a1b3..be94552674 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -28,6 +28,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/address-spaces.h"
>  #include "exec/helper-proto.h"
> +#include "qemu/plugin.h"
>
>  bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>  {
> @@ -97,6 +98,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
>      env->sregI =3D 0; /* clear Global Interrupt Flag */
>
>      cs->exception_index =3D -1;
> +
> +    qemu_plugin_vcpu_interrupt_cb(cs);
>  }
>
>  hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> --
> 2.45.2
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000293b580624d7c45b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@=
gmail.com">mrolnik@gmail.com</a>&gt;<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 19, 2024 at 7:39=E2=80=
=AFPM Julian Ganz &lt;neither@nut.email&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">We recently introduced API for registeri=
ng callbacks for trap related<br>
events as well as the corresponding hook functions. Due to differences<br>
between architectures, the latter need to be called from target specific<br=
>
code.<br>
<br>
This change places the hook for AVR targets. That architecture appears<br>
to only know interrupts.<br>
<br>
Signed-off-by: Julian Ganz &lt;neither@nut.email&gt;<br>
---<br>
=C2=A0target/avr/helper.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/target/avr/helper.c b/target/avr/helper.c<br>
index 345708a1b3..be94552674 100644<br>
--- a/target/avr/helper.c<br>
+++ b/target/avr/helper.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;exec/cpu_ldst.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
=C2=A0#include &quot;exec/helper-proto.h&quot;<br>
+#include &quot;qemu/plugin.h&quot;<br>
<br>
=C2=A0bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)<br>
=C2=A0{<br>
@@ -97,6 +98,8 @@ void avr_cpu_do_interrupt(CPUState *cs)<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;sregI =3D 0; /* clear Global Interrupt Flag */<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D -1;<br>
+<br>
+=C2=A0 =C2=A0 qemu_plugin_vcpu_interrupt_cb(cs);<br>
=C2=A0}<br>
<br>
=C2=A0hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Best Regards,=
<br>Michael Rolnik</div>

--000000000000293b580624d7c45b--

