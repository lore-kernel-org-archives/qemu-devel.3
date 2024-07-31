Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037EBC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 16:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBkA-0004jL-6O; Wed, 31 Jul 2024 12:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sZBk8-0004hg-MD
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:00:00 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sZBk6-0002cW-SG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 12:00:00 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db1eb76702so3707711b6e.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722441596; x=1723046396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2W/wyqnYvc2kDvsHbvUBLVDdYht+5bwwb9fodtW0Swc=;
 b=U6GW9Fz5ceTmKAJGO6D02aZpoDOrwKFoJup+RVwJ6Cs6f68XxWINqseOr5mfK5vBwd
 9KHI7wgzC75LxeQXh3hghRNzO8owuEwNgNhe0V7G3uha2iysz9p1wcujOBqI7Vh0uRP4
 c7PT5+v9m0+K94BkSCtvsheuksX6waeoXWBmDdTN5uAvP6P8+JTtlzKkpxxsBtTkyyKF
 EIFng2Xm+uAExVz95uHqsOXG6oYHVDxZiViVcPr+J+aD6/v6/u9EQdkA2ilUV5upTh9P
 IqhhucQffKWLPpEZo7DaUa4HVLTYycbQqEuB1zVX5zrSsEoCypHthaeGk1z9C99kxzfw
 kC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722441596; x=1723046396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2W/wyqnYvc2kDvsHbvUBLVDdYht+5bwwb9fodtW0Swc=;
 b=F/sxWW+GvUDVdWbeFvhBe8Bz0Xi9oPZ5gSwGEcg+L4Aobp1GYcY3+xBtWIMNDRw09C
 5CxqvOUdPAw86VtdCQZJF8XLy/8p4NvgZOXV/W2EacfCno1cFkBcHFfkOyljMw+ZK5km
 0d1UeNLmUCbpgFiuZfnM29iO35/g+d5uKxpv+THC9znI57IHRjaUTrfWNhl5oMW/YBeq
 EIXXRcLkb7gRMtVRytnI9qT30CjcRaId7z9Jnh4oCoiHoQUAW0QJ5ryw8tv+uUNSv36g
 Pmo20OtP8Yla14TA4KVR+/yMPaiXdyQg2/MtW1HFIpoaFXJHHyyloGg1Xc8ibc4BQ2Kn
 51Iw==
X-Gm-Message-State: AOJu0Yw/hbkeYRFS0UpIV6ngpopxd8WiAEJpb1SehWgVJZpzHKAw1bS4
 utLKVa7+phVoIOIbCb6h2bb8Rk4J4OWf+5JdQzb3sDcj7zAOOynCAtOeaaXV+64Ew11kLFf99s5
 5VFDcKykbY065HzMuhfVl+HQauE0=
X-Google-Smtp-Source: AGHT+IFT0hgkbDU+JiFVQ/6a0MUo8V1OuRpzTMGz3iv5eyAkItN4aamtu5rjy3D24k/HIeAHe9bUhSx6nD4+mBA1RVo=
X-Received: by 2002:a05:6808:180b:b0:3d5:64d6:9f1e with SMTP id
 5614622812f47-3db23ce8844mr18337332b6e.36.1722441596665; Wed, 31 Jul 2024
 08:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
In-Reply-To: <20240731154136.3494621-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Jul 2024 19:59:44 +0400
Message-ID: <CAJ+F1CK3C0dM5vq8=VP63mg1xCC25XEEhsRFXaXQBeRw+ZYYRQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] virtio-gpu-gl: Improve OpenGL and related display
 error messages
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000840a12061e8d2f8a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22b.google.com
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

--000000000000840a12061e8d2f8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:42=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> If you try to use the virtio-gpu-gl device, the error messages
> we produce are not very specific, which can leave users confused
> about what they need to do (see the issue
> https://gitlab.com/qemu-project/qemu/-/issues/2443 for an example).
>
> This patchset tries to improve those errors:
>
> (1) Trying to use virtio-gpu-gl without enabling GL on the
> display backend:
>
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl
>
> Currently we say
>   qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available
> With these patches we will say
>   qemu-system-aarch64: -device virtio-gpu-gl: The display backend does no=
t
> have OpenGL support enabled
>   It can be enabled with '-display BACKEND,gl=3Don' where BACKEND is the
> name of the display backend to use.
>
> (2) Trying to enable GL on a backend that doesn't support it:
> $ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=3D=
on
>
> Currently we say
>   qemu-system-aarch64: OpenGL is not supported by the display
> With these patches we will say
>   qemu-system-aarch64: OpenGL is not supported by display backend 'curses=
'
>
> (3) Trying to enable GL when the QEMU binary wasn't built with it:
>
> Currently we say
>   qemu-system-aarch64: OpenGL support is disabled
> With these patches we will say
>   qemu-system-aarch64: OpenGL support was disabled when QEMU was compiled
>
> (4) -display help doesn't mention that display types can have suboptions
>
> Currently -display help just prints the list of backends. With these
> patches we will also say
>   Some display backends support suboptions, which can be set with
>      -display backend,option=3Dvalue,option=3Dvalue...
>   For a short list of the suboptions for each display, see the top-level
> -help output; more detail is in the documentation.
>
> (The ideal for that last would be to be like -device and let you
> say "-display gtk,help", but that doesn't work.)
>
>
> Peter Maydell (3):
>   hw/display/virtio-gpu: Improve "opengl is not available" error message
>   system/vl.c: Expand OpenGL related errors
>   ui/console: Note in '-display help' that some backends support
>     suboptions
>
>  hw/display/virtio-gpu-gl.c | 8 +++++++-
>  system/vl.c                | 5 +++--
>  ui/console.c               | 5 +++++
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>
>
Series:
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--000000000000840a12061e8d2f8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 31, 2024 at 7:42=E2=80=AF=
PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">If you try to use the virtio-gpu-gl device, the error message=
s<br>
we produce are not very specific, which can leave users confused<br>
about what they need to do (see the issue<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2443" rel=3D"noref=
errer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2443=
</a> for an example).<br>
<br>
This patchset tries to improve those errors:<br>
<br>
(1) Trying to use virtio-gpu-gl without enabling GL on the<br>
display backend:<br>
<br>
$ qemu-system-aarch64 -M virt -device virtio-gpu-gl<br>
<br>
Currently we say<br>
=C2=A0 qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available<=
br>
With these patches we will say<br>
=C2=A0 qemu-system-aarch64: -device virtio-gpu-gl: The display backend does=
 not have OpenGL support enabled<br>
=C2=A0 It can be enabled with &#39;-display BACKEND,gl=3Don&#39; where BACK=
END is the name of the display backend to use.<br>
<br>
(2) Trying to enable GL on a backend that doesn&#39;t support it:<br>
$ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=3Don=
<br>
<br>
Currently we say<br>
=C2=A0 qemu-system-aarch64: OpenGL is not supported by the display<br>
With these patches we will say<br>
=C2=A0 qemu-system-aarch64: OpenGL is not supported by display backend &#39=
;curses&#39;<br>
<br>
(3) Trying to enable GL when the QEMU binary wasn&#39;t built with it:<br>
<br>
Currently we say<br>
=C2=A0 qemu-system-aarch64: OpenGL support is disabled<br>
With these patches we will say<br>
=C2=A0 qemu-system-aarch64: OpenGL support was disabled when QEMU was compi=
led<br>
<br>
(4) -display help doesn&#39;t mention that display types can have suboption=
s<br>
<br>
Currently -display help just prints the list of backends. With these<br>
patches we will also say<br>
=C2=A0 Some display backends support suboptions, which can be set with<br>
=C2=A0 =C2=A0 =C2=A0-display backend,option=3Dvalue,option=3Dvalue...<br>
=C2=A0 For a short list of the suboptions for each display, see the top-lev=
el -help output; more detail is in the documentation.<br>
<br>
(The ideal for that last would be to be like -device and let you<br>
say &quot;-display gtk,help&quot;, but that doesn&#39;t work.)<br>
<br>
<br>
Peter Maydell (3):<br>
=C2=A0 hw/display/virtio-gpu: Improve &quot;opengl is not available&quot; e=
rror message<br>
=C2=A0 system/vl.c: Expand OpenGL related errors<br>
=C2=A0 ui/console: Note in &#39;-display help&#39; that some backends suppo=
rt<br>
=C2=A0 =C2=A0 suboptions<br>
<br>
=C2=A0hw/display/virtio-gpu-gl.c | 8 +++++++-<br>
=C2=A0system/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
5 +++--<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
5 +++++<br>
=C2=A03 files changed, 15 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.34.1<br>
<br></blockquote><div><br></div><div>Series:</div><div>Acked-by: Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.=
lureau@redhat.com</a>&gt; <br></div></div><br clear=3D"all"><br><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000840a12061e8d2f8a--

