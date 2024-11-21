Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF4BE64007
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECcZ-0004iw-Sb; Thu, 21 Nov 2024 14:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tECcU-0004iX-Mw
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:13:38 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tECcR-0001Lu-Vc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:13:38 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2126408cf52so10805175ad.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732216414; x=1732821214;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cufcVhkUlLE0PGra2WqKXCNA5OXhw5P0kChrAB+TGiQ=;
 b=tMxz0CjqN2GNbxXMm5ub7JqQ4U5qIR0rV8VRBRXLpEBMTOsXp07nf8pk4bM0VMp6dJ
 6jgACOe+VWLQ3PJBmWbaBjegfEbH3xOwTZFxtb2QrkSxNqTRfEV6cRsG0caIEbGvNXKX
 gmoSo31xdjWC+0IMc4XZBuqtoTXnKl1gx7iP1Ok0b1jtaos2cVFEBNWlrZE+roROHoAC
 rE5Q6Pxb4oePqs7Pr5pqAT/sfkypC8oCP5erFhNOky26o8jFCyyFxvZI2X29Ki8ZUOfW
 dCM+adKSoTGpuNAzkl/cFtFMdgmH+4A6+oCt0T9w6zsnqcGUT6ZG8ZAWJEokXz+CNKFC
 ks2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216414; x=1732821214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cufcVhkUlLE0PGra2WqKXCNA5OXhw5P0kChrAB+TGiQ=;
 b=jBEL/Liln/S+SvLaPEZRMu0orJucByzZdWBvW9WOYzWynZyZKFDRv0h5nGwnBK2rcE
 dI46Meo8fajZXc4i2MS5AKDi+Oxqe3wsgt4IYRF++adHVY4Uy2KheTvvFjx5+BbNI1WY
 E3eccukIwGkRB6w4g6tQ/TBA6He5rdHNuK+PtRsNDAU3dXcLshlFX10wNzHR3DoK8/Od
 uan40gv3o54G3UuK/L8t3ztqvBL6xrAJSRBlMzk8AnaEd/Cqk525BDAyFneDnXAjyD1U
 7stxN82HHbi0073MbwCY33kYigyF6yONwdXwNIL8qPJ3JG4spVNCHZKKFXYKorIKh/mN
 DMng==
X-Gm-Message-State: AOJu0Yzx0/XRJRBZn7AsowzQ39a8vzbHoT2lznnt7ZmX/fNPmeamu0R2
 Vg7gzBwgw7oyGEpdnzab4pAG20RlWlx060o3SskcXD6WXnilc4Y+SDaN4XZMc1dqgAY1r1oFS7p
 MQ2D+RHerNWJSRwXPEORHq2KLpWlgQ1RB/H/L
X-Gm-Gg: ASbGncs3F48QtLNccLM0+jRyK2KvSxl5yRMk5bm3DaVOTaXNHEgKWvHOfAhBKkyc0iZ
 dTgcVFpajUCQqIBd2ZgZdlaQmnCnQB2Q=
X-Google-Smtp-Source: AGHT+IHkfJJDPlz9VfbwaKWRiITwRj/3rv5dE0/XljykO8xbaABBczTdXt5+gsX4fqD5uHY3cnYcHA/NddR+K+jc+88=
X-Received: by 2002:a17:90b:1845:b0:2ea:63e8:f24 with SMTP id
 98e67ed59e1d1-2eaca7de65fmr8635011a91.36.1732216413615; Thu, 21 Nov 2024
 11:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20241121162146.53643-1-charmitro@posteo.net>
In-Reply-To: <20241121162146.53643-1-charmitro@posteo.net>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 21 Nov 2024 20:13:22 +0100
Message-ID: <CAGCz3vs0miAOVy4tEBXh03fC-_iB--R1+vVuLo5XAjVgQzrT6A@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Fix event handling on macOS hosts
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: multipart/alternative; boundary="00000000000002127a0627711016"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::62f;
 envelope-from=lists@philjordan.eu; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000002127a0627711016
Content-Type: text/plain; charset="UTF-8"

Charalampos contacted me off-list with his original patch and I made a few
suggestions after testing it. So I'm not sure the 'Co-developed-by' tag is
warranted given I didn't write any code. In any case, this patch worked in
the testing I did on macOS, and it looks to be near-zero risk on other
platforms. I can't think of a simpler fix to the problem.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
or
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>

whichever is deemed appropriate in these circumstances.


On Thu, 21 Nov 2024 at 17:23, Charalampos Mitrodimas <charmitro@posteo.net>
wrote:

> The GTK+ UI was not properly handling events on macOS due to missing
> event loop polling in the Cocoa backend. Add polling of the GLib main
> context during display refresh to ensure UI events are processed.
>
> This fixes UI responsiveness issues when running QEMU with the GTK
> display (--display gtk) on macOS hosts.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2676
>
> Co-developed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  ui/gtk.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index bf9d3dd679..979210255f 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -437,6 +437,15 @@ static void gd_update(DisplayChangeListener *dcl,
>
>  static void gd_refresh(DisplayChangeListener *dcl)
>  {
> +#ifdef GDK_WINDOWING_QUARTZ
> +    GMainContext *context;
> +    if (GDK_IS_QUARTZ_DISPLAY(gdk_display_get_default())) {
> +        context = g_main_context_default();
> +        while (g_main_context_pending(context)) {
> +            g_main_context_iteration(context, FALSE);
> +        }
> +    }
> +#endif
>      graphic_hw_update(dcl->con);
>  }
>
> --
> 2.39.5 (Apple Git-154)
>
>
>

--00000000000002127a0627711016
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Charalampos contacted me off-list with his original p=
atch and I made a few suggestions after testing it. So I&#39;m not sure the=
 &#39;Co-developed-by&#39; tag is warranted given I didn&#39;t write any co=
de. In any case, this patch worked in the testing I did on macOS, and it lo=
oks to be near-zero risk on other platforms. I can&#39;t think of a simpler=
 fix to the problem.<br></div><div><br></div><div dir=3D"ltr">Signed-off-by=
: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjor=
dan.eu</a>&gt;</div><div>or<br></div><div>Reviewed-by: Phil Dennis-Jordan &=
lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a>&gt;</div><d=
iv>Tested-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">=
phil@philjordan.eu</a>&gt;</div><div><br></div><div>whichever is deemed app=
ropriate in these circumstances.<br></div><div><br></div><div><br></div><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 21 No=
v 2024 at 17:23, Charalampos Mitrodimas &lt;<a href=3D"mailto:charmitro@pos=
teo.net">charmitro@posteo.net</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">The GTK+ UI was not properly handling events o=
n macOS due to missing<br>
event loop polling in the Cocoa backend. Add polling of the GLib main<br>
context during display refresh to ensure UI events are processed.<br>
<br>
This fixes UI responsiveness issues when running QEMU with the GTK<br>
display (--display gtk) on macOS hosts.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2676" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2676</a><br>
<br>
Co-developed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.e=
u" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
Signed-off-by: Charalampos Mitrodimas &lt;<a href=3D"mailto:charmitro@poste=
o.net" target=3D"_blank">charmitro@posteo.net</a>&gt;<br>
---<br>
=C2=A0ui/gtk.c | 9 +++++++++<br>
=C2=A01 file changed, 9 insertions(+)<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index bf9d3dd679..979210255f 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -437,6 +437,15 @@ static void gd_update(DisplayChangeListener *dcl,<br>
<br>
=C2=A0static void gd_refresh(DisplayChangeListener *dcl)<br>
=C2=A0{<br>
+#ifdef GDK_WINDOWING_QUARTZ<br>
+=C2=A0 =C2=A0 GMainContext *context;<br>
+=C2=A0 =C2=A0 if (GDK_IS_QUARTZ_DISPLAY(gdk_display_get_default())) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 context =3D g_main_context_default();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (g_main_context_pending(context)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_main_context_iteration(context=
, FALSE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0graphic_hw_update(dcl-&gt;con);<br>
=C2=A0}<br>
<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
<br>
</blockquote></div></div>

--00000000000002127a0627711016--

