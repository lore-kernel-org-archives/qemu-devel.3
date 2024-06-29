Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F12C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNX1a-000202-Ts; Sat, 29 Jun 2024 08:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX1Z-0001zi-2S
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:17:49 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX1X-0004JD-7G
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:17:48 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-44637e13866so10623511cf.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719663466; x=1720268266; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OOR6+l9trsCPsSOs9H6YoufPjjfUBWF6we1PXYoHru4=;
 b=QMxXj56KsMbdL2WfK5MeBPiGucAP0ncTF/18en/4a0SP2/ITF/b+3GOsN/wBm/cnpb
 LYG06MLG+ZLEkEmqObZhRPeENSNbL4wTveMEhiT1LCNN0AL6jfKca8D/cGOZhsjwDROd
 2Musn7uxoSLQ2WYk5RLmZvQ0kpiuHIELZ9F5/lh4Xtz0SE6pKN4JTb3AuZwIB59MU8k5
 3v0K8pClZO0O9XbxtobE04BUwF1isZND5hybFfoWSNy6Mq0jdlqmLLqxCnKNpyxGp9/x
 rOx4HbYecXfCfsZnTOO+Iw7mP9aP3QgE6t7lBldOtG9koi6xYqMvlC+VWWkMOaD+MBI+
 2hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719663466; x=1720268266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOR6+l9trsCPsSOs9H6YoufPjjfUBWF6we1PXYoHru4=;
 b=V7NJeL7TXIf4oyHHLHPbtQGcgE4J094Uye32Sd7eVzyy7eLAPRsWUw7ziKdd1q50FR
 8dCOTH3Nf2hJaFEO8Jmco43X8AFpzGUakZwpV2MvvfanV/riaQe41hqKBcLkew4DdvOZ
 GBc6KSOb2kz0WHlme6cGBAUk8RslWw+aN4CuuirARfLwAm2Jse2WIQs8UTob1F4iWniO
 Ve+1567HdgWJ8e4p2lvN0SGSNHwGuktuQJMgv54DzblHk0mYTD7EfXYXKaCnYldg125f
 VHOAnlwp2gOu6K2JuyVQVR2aoPnFROiZbhuMAon9h+QGyu/wcANddjII01GrilGoIbJ9
 zuPA==
X-Gm-Message-State: AOJu0YywWPCCAnuVys2btblpPF6o+OTXNQOs1OhBwLU/usSEFRFMi9q3
 zSpwGG+9C7HltaX7CTw6awNUIBXsaMNO027S6gVFds4ZWsSbN0L3EtPiAq6ZRPtChuDSI1zKJ2D
 f151OcTRVmoHZ5xB/XxFgLmVew70=
X-Google-Smtp-Source: AGHT+IFjoqkNIuDzSkOPSPt0A+Ihi7pPHb7PvxrCgO+qawWxaOvmkla6eeqEvwwbhcGRl95CMdb/OzHF4LGXZDsqiRg=
X-Received: by 2002:a05:622a:50b:b0:446:5901:d1a4 with SMTP id
 d75a77b69052e-44662ea1fb4mr8689291cf.64.1719663465850; Sat, 29 Jun 2024
 05:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240628092815.164423-1-zhenzhong.duan@intel.com>
 <20240628092815.164423-3-zhenzhong.duan@intel.com>
In-Reply-To: <20240628092815.164423-3-zhenzhong.duan@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 29 Jun 2024 16:17:34 +0400
Message-ID: <CAJ+F1CLsm+GaxJZiYmDscyGqgtH5RzCr86MZyDB17G0OeQgFMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfio/display: Fix vfio_display_edid_init() error path
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 kraxel@redhat.com, chao.p.peng@intel.com
Content-Type: multipart/alternative; boundary="00000000000003efb8061c065a1a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

--00000000000003efb8061c065a1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 1:31=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com>
wrote:

> vfio_display_edid_init() can fail for many reasons and return silently.
> It would be good to report the error.
>
> Old mdev driver may not support vfio edid region and we allow to go
> through in this case.
>
> vfio_display_edid_update() isn't changed because it can be called at
> runtime when UI changes (i.e. window resize).
>
> Fixes: 08479114b0de ("vfio/display: add edid support.")
> Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  hw/vfio/display.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 5926bd6628..462845ce69 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -124,7 +124,7 @@ static void vfio_display_edid_ui_info(void *opaque,
> uint32_t idx,
>      }
>  }
>
> -static void vfio_display_edid_init(VFIOPCIDevice *vdev)
> +static bool vfio_display_edid_init(VFIOPCIDevice *vdev, Error **errp)
>  {
>      VFIODisplay *dpy =3D vdev->dpy;
>      int fd =3D vdev->vbasedev.fd;
> @@ -135,7 +135,8 @@ static void vfio_display_edid_init(VFIOPCIDevice *vde=
v)
>                                     VFIO_REGION_SUBTYPE_GFX_EDID,
>                                     &dpy->edid_info);
>      if (ret) {
> -        return;
> +        /* Failed to get GFX edid info, allow to go through without edid=
.
> */
> +        return true;
>      }
>
>      trace_vfio_display_edid_available();
> @@ -167,14 +168,15 @@ static void vfio_display_edid_init(VFIOPCIDevice
> *vdev)
>                                          vfio_display_edid_link_up, vdev)=
;
>
>      vfio_display_edid_update(vdev, true, 0, 0);
> -    return;
> +    return true;
>
>  err:
> +    error_setg(errp, "vfio: failed to read GFX edid field");
>      trace_vfio_display_edid_write_error();
>      g_free(dpy->edid_info);
>      g_free(dpy->edid_regs);
>      dpy->edid_regs =3D NULL;
> -    return;
> +    return false;
>  }
>
>  static void vfio_display_edid_exit(VFIODisplay *dpy)
> @@ -367,8 +369,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice
> *vdev, Error **errp)
>              return false;
>          }
>      }
> -    vfio_display_edid_init(vdev);
> -    return true;
> +    return vfio_display_edid_init(vdev, errp);
>  }
>
>  static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000003efb8061c065a1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 28, 2024 at 1:31=E2=80=AF=
PM Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong=
.duan@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">vfio_display_edid_init() can fail for many reasons and retur=
n silently.<br>
It would be good to report the error.<br>
<br>
Old mdev driver may not support vfio edid region and we allow to go<br>
through in this case.<br>
<br>
vfio_display_edid_update() isn&#39;t changed because it can be called at<br=
>
runtime when UI changes (i.e. window resize).<br>
<br>
Fixes: 08479114b0de (&quot;vfio/display: add edid support.&quot;)<br>
Suggested-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat.com" t=
arget=3D"_blank">clg@redhat.com</a>&gt;<br>
Signed-off-by: Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.co=
m" target=3D"_blank">zhenzhong.duan@intel.com</a>&gt;<br></blockquote><div>=
<br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/vfio/display.c | 13 +++++++------<br>
=C2=A01 file changed, 7 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/hw/vfio/display.c b/hw/vfio/display.c<br>
index 5926bd6628..462845ce69 100644<br>
--- a/hw/vfio/display.c<br>
+++ b/hw/vfio/display.c<br>
@@ -124,7 +124,7 @@ static void vfio_display_edid_ui_info(void *opaque, uin=
t32_t idx,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void vfio_display_edid_init(VFIOPCIDevice *vdev)<br>
+static bool vfio_display_edid_init(VFIOPCIDevice *vdev, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VFIODisplay *dpy =3D vdev-&gt;dpy;<br>
=C2=A0 =C2=A0 =C2=A0int fd =3D vdev-&gt;vbasedev.fd;<br>
@@ -135,7 +135,8 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VFIO_REGION_SUBTYPE_GF=
X_EDID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;dpy-&gt;edid_info=
);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Failed to get GFX edid info, allow to go th=
rough without edid. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_display_edid_available();<br>
@@ -167,14 +168,15 @@ static void vfio_display_edid_init(VFIOPCIDevice *vde=
v)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vf=
io_display_edid_link_up, vdev);<br>
<br>
=C2=A0 =C2=A0 =C2=A0vfio_display_edid_update(vdev, true, 0, 0);<br>
-=C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 return true;<br>
<br>
=C2=A0err:<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;vfio: failed to read GFX edid field&q=
uot;);<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_display_edid_write_error();<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_info);<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_regs);<br>
=C2=A0 =C2=A0 =C2=A0dpy-&gt;edid_regs =3D NULL;<br>
-=C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 return false;<br>
=C2=A0}<br>
<br>
=C2=A0static void vfio_display_edid_exit(VFIODisplay *dpy)<br>
@@ -367,8 +369,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vde=
v, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 vfio_display_edid_init(vdev);<br>
-=C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 return vfio_display_edid_init(vdev, errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void vfio_display_dmabuf_exit(VFIODisplay *dpy)<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000003efb8061c065a1a--

