Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EB2C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNWzD-0000ms-9s; Sat, 29 Jun 2024 08:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNWzA-0000mZ-PP
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:15:20 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNWz9-0001UT-11
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:15:20 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4464c3c8f10so7363071cf.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719663317; x=1720268117; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lvva+nsAmZRZorttpYfylhnmWw9sKbxliOMueCj8+II=;
 b=SGy/rVEavvnLTpXMRl+dBAAe7ZkZHAFDRPfAUDaYDU7WnCitt4GpxtNpzs/t4jMUcG
 FY9S1mN7OODwe276KqRc2rJsUJ1ORmAwqGFn3IO6LkhY37zZ9TVDggP+31CJsxCT5MaD
 /3iUJsF/7QVTf9rbxLsI/+f9Y6g7EHzsRe313WpvbXhGv87jKh44aAk9r5RCRWDwAlop
 dO1JtRqL0b9mBPNuhw7CPWqDkk4bIkSf9vYpzzzwxDFI3dQ0QpWeW4EwEg0fVUzlnUKs
 5sjnruf2BOZ+jSqhbyQn0r2fte6jRiW8Qn1+K0ZDuVffQO3VCuQK/RVNMgnJHxc6ZfDz
 yPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719663317; x=1720268117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lvva+nsAmZRZorttpYfylhnmWw9sKbxliOMueCj8+II=;
 b=fUlL8+tbaA7qvDrsGv9jgRgQSDnpeillEZCl0Ld1DPUxHqXNKuaSlpTbajND6c9hiS
 2N6vignZTiQi3gSk4UxOMotz09s11l4rE5UY83d3sAsXU/byIF7odry+aunLAC2EYcSH
 1IS7oyrzHG4pXoYzXssjPKMv62x6u5NTB0QgPotcpPfklduklXi3S/S2pj3AnUZ1K3Ul
 qTqogdOB5imvbPK11XqcfGiDM8zg2OyyLmt9IzVfwC+TDsdeeQDVfHf1YP9bmK3AlmX7
 HNHx98mWHD+PvGzOx8N4Af7athZ+UXzmX9eJG/fEi/vNrWo40SQEUiXMmxFHNxLtOXpV
 jI7g==
X-Gm-Message-State: AOJu0Yw/TbZm+dLbCrUAW3vbgp+d0+Ziw+OFyu4vLL1L8ySJezGMBPkV
 xY+7NNk9OZxXE/uSLpbbvtShCNu6TZSOw/6lZNM4WzFoZDhxuV6PbaO/y8PZ2FErL9ZhyXmFXO3
 x3XJFq2IaW2fLUfcDnW8CQ7WHcys=
X-Google-Smtp-Source: AGHT+IGUbrAVdgP2gIDF+dINbUy1+IdHx5zemY7XtiR/Bae8q6bwlr9rXA0vE/EMpZ78p0601fWcJl3WeDMiqbjOX0k=
X-Received: by 2002:ac8:7d07:0:b0:446:5308:6340 with SMTP id
 d75a77b69052e-44662c96956mr8287651cf.11.1719663317412; Sat, 29 Jun 2024
 05:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240628092815.164423-1-zhenzhong.duan@intel.com>
 <20240628092815.164423-2-zhenzhong.duan@intel.com>
In-Reply-To: <20240628092815.164423-2-zhenzhong.duan@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 29 Jun 2024 16:15:06 +0400
Message-ID: <CAJ+F1C+UAGau1W=Tbztx_tuhwEatmDA-DwxVwsC3UCA9rf9=VA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio/display: Fix potential memleak of edid info
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 kraxel@redhat.com, chao.p.peng@intel.com
Content-Type: multipart/alternative; boundary="0000000000002af3b4061c065125"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

--0000000000002af3b4061c065125
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 28, 2024 at 1:32=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com>
wrote:

> EDID related device region info is leaked in three paths:
> 1. In vfio_get_dev_region_info(), when edid info isn't find, the last
> device region info is leaked.
> 2. In vfio_display_edid_init() error path, edid info is leaked.
> 3. In VFIODisplay destroying path, edid info is leaked.
>
> Fixes: 08479114b0de ("vfio/display: add edid support.")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/display.c | 2 ++
>  hw/vfio/helpers.c | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 661e921616..5926bd6628 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -171,6 +171,7 @@ static void vfio_display_edid_init(VFIOPCIDevice *vde=
v)
>
>  err:
>      trace_vfio_display_edid_write_error();
> +    g_free(dpy->edid_info);
>

It would be better to set it to NULL.


>      g_free(dpy->edid_regs);
>      dpy->edid_regs =3D NULL;
>      return;
> @@ -182,6 +183,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
>          return;
>      }
>
> +    g_free(dpy->edid_info);
>      g_free(dpy->edid_regs);
>      g_free(dpy->edid_blob);
>      timer_free(dpy->edid_link_timer);
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b14edd46ed..3dd32b26a4 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -586,6 +586,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev,
> uint32_t type,
>          g_free(*info);
>      }
>
> +    g_free(*info);
>

This seems incorrect, it is freed at the end of the loop above if it didn't
retun.


>      *info =3D NULL;
>      return -ENODEV;
>  }
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002af3b4061c065125
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 28, 2024 at 1:32=E2=80=
=AFPM Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzh=
ong.duan@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">EDID related device region info is leaked in three paths:=
<br>
1. In vfio_get_dev_region_info(), when edid info isn&#39;t find, the last<b=
r>
device region info is leaked.<br>
2. In vfio_display_edid_init() error path, edid info is leaked.<br>
3. In VFIODisplay destroying path, edid info is leaked.<br>
<br>
Fixes: 08479114b0de (&quot;vfio/display: add edid support.&quot;)<br>
Signed-off-by: Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.co=
m" target=3D"_blank">zhenzhong.duan@intel.com</a>&gt;<br>
---<br>
=C2=A0hw/vfio/display.c | 2 ++<br>
=C2=A0hw/vfio/helpers.c | 1 +<br>
=C2=A02 files changed, 3 insertions(+)<br>
<br>
diff --git a/hw/vfio/display.c b/hw/vfio/display.c<br>
index 661e921616..5926bd6628 100644<br>
--- a/hw/vfio/display.c<br>
+++ b/hw/vfio/display.c<br>
@@ -171,6 +171,7 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)=
<br>
<br>
=C2=A0err:<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_display_edid_write_error();<br>
+=C2=A0 =C2=A0 g_free(dpy-&gt;edid_info);<br></blockquote><div><br></div><d=
iv>It would be better to set it to NULL.</div><div>=C2=A0<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_regs);<br>
=C2=A0 =C2=A0 =C2=A0dpy-&gt;edid_regs =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
@@ -182,6 +183,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 g_free(dpy-&gt;edid_info);<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_regs);<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_blob);<br>
=C2=A0 =C2=A0 =C2=A0timer_free(dpy-&gt;edid_link_timer);<br>
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c<br>
index b14edd46ed..3dd32b26a4 100644<br>
--- a/hw/vfio/helpers.c<br>
+++ b/hw/vfio/helpers.c<br>
@@ -586,6 +586,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint=
32_t type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(*info);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 g_free(*info);<br></blockquote><div><br></div><div>This seem=
s incorrect, it is freed at the end of the loop above if it didn&#39;t retu=
n.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
=C2=A0 =C2=A0 =C2=A0*info =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000002af3b4061c065125--

