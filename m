Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A24C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfTb-0007Ab-Dm; Tue, 02 Jul 2024 11:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOfTY-00077h-Pc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:31:25 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sOfTW-0005CJ-2Q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:31:24 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-446449e5df5so21143951cf.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719934281; x=1720539081; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EzssBnxLsekDQqFHz3eMMn3NJIyn6OIB58pC86B1QWY=;
 b=Jxn3/uTGCpSRPReE2tcGt+of9XI1xXHQiEOFj5XV6epDE/0kezySX03dN5UtvPm425
 222pnDM0r95qpQgev3Ys9mVBAYB/Ouvmg8z3KiTxSwcp41PPybsvID91VCjGWYa2ifAT
 xHpAyZe6q2ba1R0VrWZ5YD0SQeRdO+8I17SeXEt/IgWuYfgDtiRC0Bq6LogkOLqlhcp7
 6JyrzffQEEoq0ya99L1FtJ8vPaUNCMgept2niQS+gOS1QattAyXaogfDpOxO+YYuOGpu
 tOiuKcJu03SSYpc9mH0B3RZieN02fIN10/TZZzTTwyrYYDed3HF9m6TaEzvHTmYW904f
 lnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934281; x=1720539081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzssBnxLsekDQqFHz3eMMn3NJIyn6OIB58pC86B1QWY=;
 b=BY8idrQSGDu6fjpfveGBHZVbTBx83KiaOGELip1sQwRLQ0NtZJU/EB33UuI+Y8Rc5w
 qW+hNRUuqzspLB5O03tuslc+zkq9bWImQSVH0IVB007PmNJDiRSsn00NVkCrj6skDLSb
 x1bHfnk4/ha3N04ig/7C7sOMom4M7oqI21mnBBXQy/RZRzUAzvBAluXn9tFAz3R8mwrH
 W8+BkDEAhYco7juJ/3yKxK75NtNSj1QUnYZGpq5JAa/03QlOxzCsSs/uKkd56Q1ZyWuI
 pCb0u9Zz9SRVbatEWltNhCLr7oxXbVu20NsKzyaziYXhKo4eUutqEerFwnMHkejE0sNA
 USOg==
X-Gm-Message-State: AOJu0Yz1g9oG2N/Nqmd+TgIs+zFv0E3Rd0wSXS1SOd4TMLkz02plWdrf
 1eCYUn8K++qxZn4RUwXCxcMgReDkpuXnDarJAI9DHx03RkpXuX2PdEhqQve4VS6QWeXmaoIygHV
 3pyufgE8WF3exSYTZNjufVpS//9k=
X-Google-Smtp-Source: AGHT+IGWQ8M5/JtsFVnjf7q1j+5zhsm6z5A6DZTsho3Awn7HIOtlk7fu0tlKbLmVOPiP5e8pE5S/YsHYSDDORM/a1Uo=
X-Received: by 2002:ac8:590d:0:b0:441:315:1c90 with SMTP id
 d75a77b69052e-44662c954bbmr108516121cf.12.1719934280635; Tue, 02 Jul 2024
 08:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240701014809.255682-1-zhenzhong.duan@intel.com>
 <20240701014809.255682-2-zhenzhong.duan@intel.com>
In-Reply-To: <20240701014809.255682-2-zhenzhong.duan@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jul 2024 19:31:07 +0400
Message-ID: <CAJ+F1CL1WMK+QdTsSDteBDpUo=rJ91ddhVG7Gx0hsMzsPT5bfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio/display: Fix potential memleak of edid info
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 kraxel@redhat.com, chao.p.peng@intel.com
Content-Type: multipart/alternative; boundary="000000000000d59daa061c456703"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

--000000000000d59daa061c456703
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 5:51=E2=80=AFAM Zhenzhong Duan <zhenzhong.duan@intel=
.com>
wrote:

> EDID related device region info is leaked in vfio_display_edid_init()
> error path and VFIODisplay destroying path.
>
> Fixes: 08479114b0de ("vfio/display: add edid support.")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/vfio/display.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 661e921616..9c57fd3888 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -171,7 +171,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vde=
v)
>
>  err:
>      trace_vfio_display_edid_write_error();
> +    g_free(dpy->edid_info);
>      g_free(dpy->edid_regs);
> +    dpy->edid_info =3D NULL;
>      dpy->edid_regs =3D NULL;
>      return;
>  }
> @@ -182,6 +184,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
>          return;
>      }
>
> +    g_free(dpy->edid_info);
>      g_free(dpy->edid_regs);
>      g_free(dpy->edid_blob);
>      timer_free(dpy->edid_link_timer);
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d59daa061c456703
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 5:51=E2=80=AFA=
M Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.=
duan@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">EDID related device region info is leaked in vfio_display_edi=
d_init()<br>
error path and VFIODisplay destroying path.<br>
<br>
Fixes: 08479114b0de (&quot;vfio/display: add edid support.&quot;)<br>
Signed-off-by: Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.co=
m" target=3D"_blank">zhenzhong.duan@intel.com</a>&gt;<br></blockquote><div>=
<br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=
=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/vfio/display.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/hw/vfio/display.c b/hw/vfio/display.c<br>
index 661e921616..9c57fd3888 100644<br>
--- a/hw/vfio/display.c<br>
+++ b/hw/vfio/display.c<br>
@@ -171,7 +171,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)=
<br>
<br>
=C2=A0err:<br>
=C2=A0 =C2=A0 =C2=A0trace_vfio_display_edid_write_error();<br>
+=C2=A0 =C2=A0 g_free(dpy-&gt;edid_info);<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_regs);<br>
+=C2=A0 =C2=A0 dpy-&gt;edid_info =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0dpy-&gt;edid_regs =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0}<br>
@@ -182,6 +184,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 g_free(dpy-&gt;edid_info);<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_regs);<br>
=C2=A0 =C2=A0 =C2=A0g_free(dpy-&gt;edid_blob);<br>
=C2=A0 =C2=A0 =C2=A0timer_free(dpy-&gt;edid_link_timer);<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000d59daa061c456703--

