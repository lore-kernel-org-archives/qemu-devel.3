Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7765C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sERY2-0006lf-K0; Tue, 04 Jun 2024 06:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sERY0-0006lN-Gl
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:37:44 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sERXs-0002Ik-N9
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 06:37:38 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-794c3946468so58184485a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717497455; x=1718102255; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TOnDgupvw3Q5CPgiTXtf+qdjCXkFSFK/HfdTMFR4G9I=;
 b=f/cXPTxaR/G5t8zDZ0h0htQ+Qel5m6tVpMJGnlMJnfirpWcK2iw0s3wxgs7/2sqjrc
 N3fCiRjQvcu2hssNsbqllAD5IfGBieRDiTMaFZyQmkveMnEfweh1c4Uf+26skIwvRR4V
 LOh7BSrqNmEbkA50bbutAWaslQjPY4jtFWyRsZ70sFzLKqTmWXleOnaQFwIa+s5fnxKv
 7cCsaCIYJ31C6YoCN2rIADo0nVOmOPAwsk7U856AZNXcZtTXECiBKKuMti7AoUEzDvpx
 G5jNdN9PNQJvY4KthTm8+ftKX4wl50JHYanlJmJ80JX7PJ1TupuOqCQod7VCw064qExe
 EN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717497455; x=1718102255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TOnDgupvw3Q5CPgiTXtf+qdjCXkFSFK/HfdTMFR4G9I=;
 b=nwOPC8fguwjqWuY8WIOcOkkKJoJzW3ONE2WhBxQzHbqcO+moCyYOlcn31sAWlooc0H
 7aq0Cd19cNZg1n4jzDdiQJcxxYUuegx2P7MTG3g4s81HMsM19b/CB3UF3KsGzkx2J4+G
 NH4Ss7hy9r2rTzc/IIPmavi4YR0bEBRUq8Gkx06I6iAhxGdWSjo+JGQkk+kyWG874Ttm
 BQPDtIdiBinx9YmSw9NWM9gakgmQRF6f+1TKOuy9FXVN0JIgW3XkfYRNKYUODyvg3ZF3
 WAUDhwJL3eRnOLN/Pc2K8SM+ra8gwZOAZkpryfuth0I7f2zTyKUH5XalDRW8fP/hvEOd
 gpTQ==
X-Gm-Message-State: AOJu0YxzNA7A2+fxmmX9uPvwtNm6gu26y3hQAW94Pzr8Ic5ynkvSkQxh
 s2NPvM5xGtcOUc4nK639bP25pbnSiZtZI8P259ufKAqrx6hLX4n2Zr93D5AfYWF4yFaD3KwuTih
 ByytF3xLcAs5RyF/b08kcbN554NU=
X-Google-Smtp-Source: AGHT+IH5xKImrZX/KUbZXHSBkfwID1MZpDA6iLjalm3r++xRfPoRjGz97jKWTSPzamuitS7uv3wHrIlJdTnV+NhJ9HA=
X-Received: by 2002:a05:620a:40d5:b0:792:e9e4:4a10 with SMTP id
 af79cd13be357-794f5c98081mr1466743785a.34.1717497454712; Tue, 04 Jun 2024
 03:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240531185804.119557-1-dongwon.kim@intel.com>
In-Reply-To: <20240531185804.119557-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jun 2024 14:37:22 +0400
Message-ID: <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b0e2ef061a0e0919"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
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

--000000000000b0e2ef061a0e0919
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, May 31, 2024 at 11:00=E2=80=AFPM <dongwon.kim@intel.com> wrote:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This patch series is a replacement of
> https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.html
>
> There is a need, expressed by several users, to assign ownership of one
> or more physical monitors/connectors to individual guests. This creates
> a clear notion of which guest's contents are being displayed on any given
> monitor. Given that there is always a display server/compositor running
> on the host, monitor ownership can never truly be transferred to guests.
> However, the closest approximation is to request the host compositor to
> fullscreen the guest's windows on individual monitors. This allows for
> various configurations, such as displaying four different guests' windows
> on four different monitors, a single guest's windows (or virtual consoles=
)
> on four monitors, or any similar combination.
>
> This patch series attempts to accomplish this by introducing a new
> parameter named "connector" to assign monitors to the GFX VCs associated
> with a guest. If the assigned monitor is not connected, the guest's windo=
w
> will not be displayed, similar to how a host compositor behaves when
> connectors are not connected. Once the monitor is hot-plugged, the guest'=
s
> window(s) will be positioned on the assigned monitor.
>
> Usage example:
>
> -display gtk,gl=3Don,connectors=3DDP-1:eDP-1:HDMI-2...
>
> In this example, the first graphics virtual console will be placed on the
> DP-1 display, the second on eDP-1, and the third on HDMI-2.
>
>
Unfortunately, this approach with GTK is doomed. gtk4 dropped the
gtk_window_set_position() altogether.

It's not even clear how the different monitors/outputs/connectors are
actually named, whether they are stable etc (not mentioning the
portability).

Window placement & geometry is a job for the compositor. Can you discuss
this issue with GTK devs & the compositor you are targeting?

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b0e2ef061a0e0919
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 31, 2024 at 11:00=E2=80=
=AFPM &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim@intel.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Dongwon Kim &lt;<a href=3D"mailto:dongwon.kim@intel.com" target=3D"_blan=
k">dongwon.kim@intel.com</a>&gt;<br>
<br>
This patch series is a replacement of<br>
<a href=3D"https://mail.gnu.org/archive/html/qemu-devel/2023-06/msg03989.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://mail.gnu.org/archive/html/=
qemu-devel/2023-06/msg03989.html</a><br>
<br>
There is a need, expressed by several users, to assign ownership of one<br>
or more physical monitors/connectors to individual guests. This creates<br>
a clear notion of which guest&#39;s contents are being displayed on any giv=
en<br>
monitor. Given that there is always a display server/compositor running<br>
on the host, monitor ownership can never truly be transferred to guests.<br=
>
However, the closest approximation is to request the host compositor to<br>
fullscreen the guest&#39;s windows on individual monitors. This allows for<=
br>
various configurations, such as displaying four different guests&#39; windo=
ws<br>
on four different monitors, a single guest&#39;s windows (or virtual consol=
es)<br>
on four monitors, or any similar combination.<br>
<br>
This patch series attempts to accomplish this by introducing a new<br>
parameter named &quot;connector&quot; to assign monitors to the GFX VCs ass=
ociated<br>
with a guest. If the assigned monitor is not connected, the guest&#39;s win=
dow<br>
will not be displayed, similar to how a host compositor behaves when<br>
connectors are not connected. Once the monitor is hot-plugged, the guest&#3=
9;s<br>
window(s) will be positioned on the assigned monitor.<br>
<br>
Usage example:<br>
<br>
-display gtk,gl=3Don,connectors=3DDP-1:eDP-1:HDMI-2...<br>
<br>
In this example, the first graphics virtual console will be placed on the<b=
r>
DP-1 display, the second on eDP-1, and the third on HDMI-2.<br>
<br>
</blockquote></div><div><br></div><div>Unfortunately, this approach with GT=
K is doomed. gtk4 dropped the gtk_window_set_position() altogether.</div><d=
iv><br></div><div>It&#39;s not even clear how the different monitors/output=
s/connectors are actually named, whether they are stable etc (not mentionin=
g the portability).</div><div><br></div><div>Window placement &amp; geometr=
y is a job for the compositor. Can you discuss this issue with GTK devs &am=
p; the compositor you are targeting?<br></div><br><span class=3D"gmail_sign=
ature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc=
-Andr=C3=A9 Lureau<br></div></div>

--000000000000b0e2ef061a0e0919--

