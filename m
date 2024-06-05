Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D85C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl2X-0000yJ-1y; Wed, 05 Jun 2024 03:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEl2V-0000s5-7C
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:26:31 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEl2S-0004nN-0N
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:26:30 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a68b0a229so3201812a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717572386; x=1718177186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+QXQk4CzxnifsIESvovi/wX7OJpWms4eTn7jWoEsNU4=;
 b=PQVvpvNGs6+a0AQ7tREPLRtuvAN9YVjbKx/YPFMCQFcmu9a6ABobHqErOjCBG9NZyp
 P36637Gv40vaJ915VfzXdfXuBlUoHl2AiZLgNfk75yE2brY/+p0O1/JQiMkERtUKYyoq
 h6TQHWlkqID5k9eEpyxjQzQb1poufJTzrKWG+FZvaVlsRZNQ84LKNU+5UW6wbpGhQj9z
 wpNwQA7asnUfF+UqQnbjvWa2Gw3lTnyBJL2fI6eVA68UIq6YUEH7eC+i2bESEvwFbFcG
 em2/clDLgnRGGjN8zGspXEyAEMHO6lSzmcx1XVEz2ABzUHAiF8PsXgcJgsCy8CdHVrHD
 xRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572386; x=1718177186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+QXQk4CzxnifsIESvovi/wX7OJpWms4eTn7jWoEsNU4=;
 b=mptrTD9utH2jiOwJIjaEqDNZ9nQnrdDDT/1MJan6cbgQJNemQasHX394qsucJZKO6w
 F0FKw97khkA8WSjs0Eqo+KGHaDe/Pzh4kZcHoQJ20n7MKEgFPUM/39TtUb5cuP+d/340
 y8L3ffDgFnQX53jHnwLbNhiiMu+Y60y4RGf6AmuKrz6MTjx622t8kBoztJq9uduCCup7
 /EePsTzNEoqejwYkgGUl/9P2jG7jkGOU3P1x4Ps8AOpXvRz608toidrNUt5efJHrKYg6
 sKet+Lqd4SLUGf8r9JPuSQmTxGVusbaBEZbCfvWKlDAmIAgsZUKB/HrGmTspCS13Ep/d
 HvWg==
X-Gm-Message-State: AOJu0YySnYJgeFm/pH440IlURGQx+xccmJrNj6g0tjBB/k5QbRK8/R2W
 1aqHbHSz8UBrPYlMhuxghq0L3E3pzAIR1aaDXjwkc8d+/YyUzjwTtE7mrrJSPO/W0iGonsy/xjq
 n0mo1DEInzOud3JKdMJkTdayDRv8=
X-Google-Smtp-Source: AGHT+IHsMc46nDO8s0CvkMwTHaVgTyKdEVohz9Z7A5I/F/ArX7xHMIyFy8+yXI8L9LU6/PVnUolEjyjq5DcOYYo3t68=
X-Received: by 2002:a17:906:1395:b0:a68:f6c7:fed5 with SMTP id
 a640c23a62f3a-a699fac1244mr103496866b.34.1717572386056; Wed, 05 Jun 2024
 00:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
In-Reply-To: <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 11:26:11 +0400
Message-ID: <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f271c6061a1f7b66"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x529.google.com
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

--000000000000f271c6061a1f7b66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 4, 2024 at 9:59=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com>=
 wrote:

> Hi Marc-Andr=C3=A9,
>
> On 6/4/2024 3:37 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, May 31, 2024 at 11:00=E2=80=AFPM <dongwon.kim@intel.com
> > <mailto:dongwon.kim@intel.com>> wrote:
> >
> >     From: Dongwon Kim <dongwon.kim@intel.com <mailto:
> dongwon.kim@intel.com>>
> >
> >     This patch series is a replacement of
> >     https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html
> >     <https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html=
>
> >
> >     There is a need, expressed by several users, to assign ownership of
> one
> >     or more physical monitors/connectors to individual guests. This
> creates
> >     a clear notion of which guest's contents are being displayed on any
> >     given
> >     monitor. Given that there is always a display server/compositor
> running
> >     on the host, monitor ownership can never truly be transferred to
> guests.
> >     However, the closest approximation is to request the host composito=
r
> to
> >     fullscreen the guest's windows on individual monitors. This allows
> for
> >     various configurations, such as displaying four different guests'
> >     windows
> >     on four different monitors, a single guest's windows (or virtual
> >     consoles)
> >     on four monitors, or any similar combination.
> >
> >     This patch series attempts to accomplish this by introducing a new
> >     parameter named "connector" to assign monitors to the GFX VCs
> associated
> >     with a guest. If the assigned monitor is not connected, the guest's
> >     window
> >     will not be displayed, similar to how a host compositor behaves whe=
n
> >     connectors are not connected. Once the monitor is hot-plugged, the
> >     guest's
> >     window(s) will be positioned on the assigned monitor.
> >
> >     Usage example:
> >
> >     -display gtk,gl=3Don,connectors=3DDP-1:eDP-1:HDMI-2...
> >
> >     In this example, the first graphics virtual console will be placed
> >     on the
> >     DP-1 display, the second on eDP-1, and the third on HDMI-2.
> >
> >
> > Unfortunately, this approach with GTK is doomed. gtk4 dropped the
> > gtk_window_set_position() altogether.
>
> Do you mean we have a plan to lift GTK version in QEMU? Are we going to
> lose all GTK3 specific features?
>

No concrete plan, no. But eventually GTK3 will go away some day.

fwiw, I wish QEMU wouldn't have N built-in UIs/Spice/VNC, but different
projects elsewhere using -display dbus. There is
https://gitlab.gnome.org/GNOME/libmks or
https://gitlab.com/marcandre.lureau/qemu-display gtk4 efforts.


> >
> > It's not even clear how the different monitors/outputs/connectors are
> > actually named, whether they are stable etc (not mentioning the
> > portability).
> >
> > Window placement & geometry is a job for the compositor. Can you discus=
s
> > this issue with GTK devs & the compositor you are targeting?
>
> I guess you are talking about wayland compositor. We are mainly using
> Xorg on the host and this feature works pretty good on it. I am
>

Xorg may not be going away soon, but it's used less and less. As one of the
developers, I am no longer running/testing it for a long time. I wish we
would just drop its support tbh.

wondering if we limit the feature to Xorg case or adding some warning
> messages with error return in case any of parts is not working?
> (like the warning message I added
>
> +        model =3D gdk_monitor_get_model(monitor);
> +        if (!model) {
> +            g_warning("retrieving connector name using\n"
> +                      "gdk_monitor_get_model isn't supported\n"
> +                      "please do not use connectors param in\n"
> +                      "current environment\n");
> +            return -1;
> +        }
> )
>

Is it really worth maintaining this upstream if we know it will only work
for a diminishing fraction of users?



--=20
Marc-Andr=C3=A9 Lureau

--000000000000f271c6061a1f7b66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 9:59=E2=
=80=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.=
kim@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
On 6/4/2024 3:37 AM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Fri, May 31, 2024 at 11:00=E2=80=AFPM &lt;<a href=3D"mailto:dongwon=
.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">=
dongwon.kim@intel.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0From: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim=
@intel.com" target=3D"_blank">dongwon.kim@intel.com</a> &lt;mailto:<a href=
=3D"mailto:dongwon.kim@intel.com" target=3D"_blank">dongwon.kim@intel.com</=
a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch series is a replacement of<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://mail.gnu.org/archive/html/qemu-d=
evel/2023-06/msg03989.html" rel=3D"noreferrer" target=3D"_blank">https://ma=
il.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://mail.gnu.org/archive/html/qe=
mu-devel/2023-06/msg03989.html" rel=3D"noreferrer" target=3D"_blank">https:=
//mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html</a>&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0There is a need, expressed by several users, to ass=
ign ownership of one<br>
&gt;=C2=A0 =C2=A0 =C2=A0or more physical monitors/connectors to individual =
guests. This creates<br>
&gt;=C2=A0 =C2=A0 =C2=A0a clear notion of which guest&#39;s contents are be=
ing displayed on any<br>
&gt;=C2=A0 =C2=A0 =C2=A0given<br>
&gt;=C2=A0 =C2=A0 =C2=A0monitor. Given that there is always a display serve=
r/compositor running<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the host, monitor ownership can never truly be t=
ransferred to guests.<br>
&gt;=C2=A0 =C2=A0 =C2=A0However, the closest approximation is to request th=
e host compositor to<br>
&gt;=C2=A0 =C2=A0 =C2=A0fullscreen the guest&#39;s windows on individual mo=
nitors. This allows for<br>
&gt;=C2=A0 =C2=A0 =C2=A0various configurations, such as displaying four dif=
ferent guests&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0windows<br>
&gt;=C2=A0 =C2=A0 =C2=A0on four different monitors, a single guest&#39;s wi=
ndows (or virtual<br>
&gt;=C2=A0 =C2=A0 =C2=A0consoles)<br>
&gt;=C2=A0 =C2=A0 =C2=A0on four monitors, or any similar combination.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch series attempts to accomplish this by in=
troducing a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0parameter named &quot;connector&quot; to assign mon=
itors to the GFX VCs associated<br>
&gt;=C2=A0 =C2=A0 =C2=A0with a guest. If the assigned monitor is not connec=
ted, the guest&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0window<br>
&gt;=C2=A0 =C2=A0 =C2=A0will not be displayed, similar to how a host compos=
itor behaves when<br>
&gt;=C2=A0 =C2=A0 =C2=A0connectors are not connected. Once the monitor is h=
ot-plugged, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0window(s) will be positioned on the assigned monito=
r.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Usage example:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-display gtk,gl=3Don,connectors=3DDP-1:eDP-1:HDMI-2=
...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In this example, the first graphics virtual console=
 will be placed<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0DP-1 display, the second on eDP-1, and the third on=
 HDMI-2.<br>
&gt; <br>
&gt; <br>
&gt; Unfortunately, this approach with GTK is doomed. gtk4 dropped the <br>
&gt; gtk_window_set_position() altogether.<br>
<br>
Do you mean we have a plan to lift GTK version in QEMU? Are we going to <br=
>
lose all GTK3 specific features?<br></blockquote><div><br></div><div>No con=
crete plan, no. But eventually GTK3 will go away some day.</div><div><br></=
div><div>fwiw, I wish QEMU wouldn&#39;t have N built-in UIs/Spice/VNC, but =
different projects elsewhere using -display dbus. There is <a href=3D"https=
://gitlab.gnome.org/GNOME/libmks">https://gitlab.gnome.org/GNOME/libmks</a>=
 or <a href=3D"https://gitlab.com/marcandre.lureau/qemu-display">https://gi=
tlab.com/marcandre.lureau/qemu-display</a> gtk4 efforts.<br></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; It&#39;s not even clear how the different monitors/outputs/connectors =
are <br>
&gt; actually named, whether they are stable etc (not mentioning the <br>
&gt; portability).<br>
&gt; <br>
&gt; Window placement &amp; geometry is a job for the compositor. Can you d=
iscuss <br>
&gt; this issue with GTK devs &amp; the compositor you are targeting?<br>
<br>
I guess you are talking about wayland compositor. We are mainly using <br>
Xorg on the host and this feature works pretty good on it. I am <br></block=
quote><div><br></div><div>Xorg may not be going away soon, but it&#39;s use=
d less and less. As one of the developers, I am no longer running/testing i=
t for a long time. I wish we would just drop its support tbh.<br></div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
wondering if we limit the feature to Xorg case or adding some warning <br>
messages with error return in case any of parts is not working?<br>
(like the warning message I added<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 model =3D gdk_monitor_get_model(monitor);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!model) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_warning(&quot;retrieving conne=
ctor name using\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;gdk_monitor_get_model isn&#39;t supported\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;please do not use connectors param in\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;current environment\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
)<br>
</blockquote></div><br clear=3D"all"></div><div>Is it really worth maintain=
ing this upstream if we know it will only work for a diminishing fraction o=
f users?<br></div><div><br></div><div><br></div><div><br></div><div><span c=
lass=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gma=
il_signature">Marc-Andr=C3=A9 Lureau<br></div></div></div>

--000000000000f271c6061a1f7b66--

