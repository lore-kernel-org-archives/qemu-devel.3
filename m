Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953BFC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 06:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHHhO-0007v3-IX; Wed, 12 Jun 2024 02:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHHhM-0007uk-TR
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 02:43:08 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHHhK-000736-Vd
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 02:43:08 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dfdb6122992so1094185276.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 23:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718174585; x=1718779385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7uljngEgBJSUc2E6vSGDQntB2a2QWVo10OeMcPtI7HU=;
 b=PA9ArBhiE0XT/+dRAEPolafUWLLKuSP0MrmGRGh2ZEmq7bUYRfe0W4y989dXsLWAkn
 ZqY3OKIGKDd0YyqUbar6BUXW+3nvGeQClaFFyQ6pqnSQhte1bbQVPWboW1R+aoBtTjx/
 JUQxFc5hYJpdvN2KyBshNMwPHXELFiZZzh8VJ9qfgWc1TfcrVq9t8u9mQrmVqRTsSkpk
 2tKEstRkacm85gJw6XUQ6bEK+d8XazYx41o0nslGTkSgIyPoT2GqjHT1sj7CtztUn8yY
 AdbOQSSkxqtRBOBZdfCip6SD51uf+I+3iJ6NYPvtqgvN4zhGL5e7EXhJpsqGc9WsRqG1
 Z7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718174585; x=1718779385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uljngEgBJSUc2E6vSGDQntB2a2QWVo10OeMcPtI7HU=;
 b=Uybgaaews0h2PQWO1TnAAOhe87iZX8yvswp7Z6z0OYoVj1dHyzGqOQhOskYT5KO/Qq
 2JYgu/6yjoNpS4aQ6GDyOy+UN6ZDkqqb1UAKs1vCanHpIJ3cwkNNbfDIMdT+DB3KrOvB
 X9GXx5jgBmRXhw05XlnZRP+vjl9AHVjMwrI8v0Rp7+hKFOMEm5wgehG42bgD1bvAnSCC
 D9hV/ySQolrsOBDpfkPpB/aq16jmYr7mL6kASOqxFzGEjEEebXZohaZ0kEjFBrYla7Fh
 nhjf34cDQ4aoBagLrstk7XORDGDOyvdKmnU3i1mmCmQ6ANyDgeuuI7TMIvipQKOy5/p3
 H2Dg==
X-Gm-Message-State: AOJu0YwptXGXTGi2jsS3h7Xr1t2aFtysTyeFaeVGP63Dsf7A9p/ck6xf
 Zj/EMAmw6hM/2Ehbc3b2Yj0/sfSpUEGTb32x6iak3nPaAR//71L5WT6w0+LpSHuwoaQ0dsbzqyl
 AoL2QSUkx8le7JtAZ7sOaPTMRtns=
X-Google-Smtp-Source: AGHT+IFXq2NFx5MkX+wf1r5MnmC0MFWzZ/mxU87zmXYwb5yJZuCR3rAsmacoys8PgTL1vLwD40SJ4GLEZZjq7XDsgsU=
X-Received: by 2002:a25:aa4d:0:b0:dfe:1ba4:371b with SMTP id
 3f1490d57ef6-dfe691032bamr719572276.57.1718174585241; Tue, 11 Jun 2024
 23:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
 <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
In-Reply-To: <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Jun 2024 10:42:53 +0400
Message-ID: <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d0cad5061aabb139"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000d0cad5061aabb139
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 11, 2024 at 10:28=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.co=
m> wrote:

> Hi Marc-Andr=C3=A9,
>
> On 6/5/2024 12:26 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Jun 4, 2024 at 9:59=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.=
com
> > <mailto:dongwon.kim@intel.com>> wrote:
>
> Xorg may not be going away soon, but it's used less and less. As one of
> > the developers, I am no longer running/testing it for a long time. I
> > wish we would just drop its support tbh.
>
> There are features offered by Xorg that are not offered by Wayland
> compositors and again, we have customers that rely on these features.
> One of them is the ability to position the window via
> gtk_window_set_position(). There are strong arguments
> made on either side when it comes to window positioning:
>
> https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests=
/247
>
> Until there is a way to do this with Wayland compositors, we have to
> unfortunately rely on Gnome + Xorg.
>
>
It's a smaller and smaller number of users. The potential/future users are
greater if we focus on Wayland.

Fwiw, GNOME (and RHEL) is set to drop Xorg support (
https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98)

Btw, there is a similar monitor-mapping functionality implemented in
virt-viewer/remote-viewer:
https://www.mankier.com/1/virt-viewer#Configuration. Is this something that
those users could use instead?


--=20
Marc-Andr=C3=A9 Lureau

--000000000000d0cad5061aabb139
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 11, 2024 at 10:28=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
On 6/5/2024 12:26 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Tue, Jun 4, 2024 at 9:59=E2=80=AFPM Kim, Dongwon &lt;<a href=3D"mai=
lto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br></blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; Xorg may not be going away soon, but it&#39;s used less and less. As o=
ne of <br>
&gt; the developers, I am no longer running/testing it for a long time. I <=
br>
&gt; wish we would just drop its support tbh.<br>
<br>
There are features offered by Xorg that are not offered by Wayland <br>
compositors and again, we have customers that rely on these features.<br>
One of them is the ability to position the window via <br>
gtk_window_set_position(). There are strong arguments<br>
made on either side when it comes to window positioning:<br>
<a href=3D"https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge=
_requests/247" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesk=
top.org/wayland/wayland-protocols/-/merge_requests/247</a><br>
<br>
Until there is a way to do this with Wayland compositors, we have to <br>
unfortunately rely on Gnome + Xorg.<br>
<br></blockquote><div><br></div><div><div>It&#39;s a smaller and smaller nu=
mber of users. The potential/future users are greater if we focus on Waylan=
d.</div><div><br></div><div>Fwiw, GNOME (and RHEL) is set to drop Xorg supp=
ort (<a href=3D"https://gitlab.gnome.org/GNOME/gnome-session/-/merge_reques=
ts/98">https://gitlab.gnome.org/GNOME/gnome-session/-/merge_requests/98</a>=
)</div><div><br></div><div>Btw, there is a similar monitor-mapping function=
ality implemented in virt-viewer/remote-viewer: <a href=3D"https://www.mank=
ier.com/1/virt-viewer#Configuration">https://www.mankier.com/1/virt-viewer#=
Configuration</a>. Is this something that those users could use instead?</d=
iv><div><br></div></div></div><br><span class=3D"gmail_signature_prefix">--=
 </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lure=
au<br></div></div>

--000000000000d0cad5061aabb139--

