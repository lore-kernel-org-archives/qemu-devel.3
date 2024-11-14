Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00653D68B02
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZPM-0008Kj-0y; Thu, 14 Nov 2024 07:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tBZPJ-0008KE-SU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:57:09 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1tBZPH-0000E8-Ra
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:57:09 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4635760725cso6975451cf.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731589025; x=1732193825; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IRgWLcON7fsv7VdVrLmWrCf0K//3N0zUDAu6FV+v0Us=;
 b=RQCRZ8MRen1bC7uNvAhZgEe+rce7Lxw7GRt5Y/vLLoysTC0OJi9+UybWC+vO4P/FAm
 t681W+I7hmeiVV8XQ9qy3AyMREU8LcIb2x1BXNwJ2nKQq21v1MCfgHVTE1ce9soMA6s7
 u5LLnqmC4UUvaritXImsaHhJays+Rn5Q7xugj4GonBFJ24n0GBYbHwUB+a7X6vvCjSSw
 o8t87JlIz+KVKGSt9ggZNiMdQ/doNNrKcu1jv6bW8XKmn8K5HZ7X3ej6WB1fuscSY3Yz
 I7F47L88ooQkG41bg3tCH8Lu+D/gE7wUMRAmvtywXxoNwz34jkUlxrxvZABZoAYsa2nm
 Rd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589025; x=1732193825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IRgWLcON7fsv7VdVrLmWrCf0K//3N0zUDAu6FV+v0Us=;
 b=CLPDxKDriG+RWWITsOBSHLDUQ0vPQW0hTKS6lGL8sV1D0XR/lm9d79EvlA+o7m/DA/
 EJdIS0a24E30mtfezoY+IEPg44WCAHHkAu/ZliGOGA07vX9vdEBSkVzIk/SRbKlOAIWy
 GjyYtQwjHtsBDflIyIXy7YEOtaB9XjsyuNbSHh2rp7f9ozorLPCqEnUGLm20YC1yijGU
 1fY2+7D2UnVGw4Ukj2cXWAGDdgki50RV2jDuX4L/iz7hLhXieKQ9dmh47+UG6uaBfy4Z
 rl9DZdyKdaE6/hfyE/rrXHeHZrTn3vfJ33RBoqBdD9cwD3skGHWG75iAjeKARTJzXeBO
 s5aQ==
X-Gm-Message-State: AOJu0YzRgRM7FWLgkUFtdIj7nKQImndfHtiZp6O9rcyiv3ymMK0CQP/m
 Zdekyv2urLLUNReaSHR3+Ex9LZL7a8k5Z8Hs4H+Ji+KP9nx0ZwSvFaYo07xhfUtm+YJ67SkMBa7
 lPk6kT32YodsUFUJk5efCNJ0PtV8o8Q==
X-Google-Smtp-Source: AGHT+IHGKKBGXt+/Z0lRmOGHY16YrS6EcptHedcr7ey2OpBXqXhTTszLFpMmQ0wP5y/UfK9eCGQWz+fiKOYN5GZWUeA=
X-Received: by 2002:a05:622a:22a3:b0:462:b447:1286 with SMTP id
 d75a77b69052e-46356b1f661mr45806691cf.7.1731589025313; Thu, 14 Nov 2024
 04:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20241105083203.2230983-1-marcandre.lureau@redhat.com>
In-Reply-To: <20241105083203.2230983-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2024 16:56:52 +0400
Message-ID: <CAJ+F1C+JTfhgOFw_4oOsOPA-JbYPQh7P7adp2EkOFY_JVpXBvw@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/hda: avoid unnecessary re-open stream on
 reconfiguration
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: mjt@tls.msk.ru, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c03aed0626defcfa"
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

--000000000000c03aed0626defcfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo

Did you see that patch? What do you say about it?

On Tue, Nov 5, 2024 at 12:33=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Closing and opening a stream too quickly during reconfiguration create
> issues with Spice.
>
> Note: the issue with Spice has been there before and still is. When the
> audio stream is recreated, for example when using
> `out.mixing-engine=3Dfalse`.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2639
> Fixes: 6d6e23361f ("hw/audio/hda: fix memory leak on audio setup")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/audio/hda-codec.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index bc661504cf..b734a5c718 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -502,7 +502,15 @@ static void hda_audio_setup(HDAAudioStream *st)
>      trace_hda_audio_format(st->node->name, st->as.nchannels,
>                             fmt2name[st->as.fmt], st->as.freq);
>
> -    hda_close_stream(st->state, st);
> +    /*
> +     * Do not hda_close_stream(st->state, st), AUD_open_() handles the
> logic for
> +     * fixed_settings, and same format. This helps prevent race issues i=
n
> Spice
> +     * server & client code too. (see #2639)
> +     */
> +    if (use_timer) {
> +        timer_free(st->buft);
> +        st->buft =3D NULL;
> +    }
>      if (st->output) {
>          if (use_timer) {
>              cb =3D hda_audio_output_cb;
> --
> 2.47.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c03aed0626defcfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Paolo</div><div><br></div><div>Did you see that pa=
tch? What do you say about it?<br></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 5, 2024 at 12:33=E2=80=
=AFPM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
Closing and opening a stream too quickly during reconfiguration create<br>
issues with Spice.<br>
<br>
Note: the issue with Spice has been there before and still is. When the<br>
audio stream is recreated, for example when using<br>
`out.mixing-engine=3Dfalse`.<br>
<br>
Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2639" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/is=
sues/2639</a><br>
Fixes: 6d6e23361f (&quot;hw/audio/hda: fix memory leak on audio setup&quot;=
)<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/audio/hda-codec.c | 10 +++++++++-<br>
=C2=A01 file changed, 9 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c<br>
index bc661504cf..b734a5c718 100644<br>
--- a/hw/audio/hda-codec.c<br>
+++ b/hw/audio/hda-codec.c<br>
@@ -502,7 +502,15 @@ static void hda_audio_setup(HDAAudioStream *st)<br>
=C2=A0 =C2=A0 =C2=A0trace_hda_audio_format(st-&gt;node-&gt;name, st-&gt;as.=
nchannels,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fmt2name[st-&gt;as.fmt], st-&gt;as.freq);<br>
<br>
-=C2=A0 =C2=A0 hda_close_stream(st-&gt;state, st);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Do not hda_close_stream(st-&gt;state, st), AUD_open_=
() handles the logic for<br>
+=C2=A0 =C2=A0 =C2=A0* fixed_settings, and same format. This helps prevent =
race issues in Spice<br>
+=C2=A0 =C2=A0 =C2=A0* server &amp; client code too. (see #2639)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (use_timer) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_free(st-&gt;buft);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 st-&gt;buft =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (st-&gt;output) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (use_timer) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cb =3D hda_audio_output_cb;=
<br>
-- <br>
2.47.0<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Ma=
rc-Andr=C3=A9 Lureau<br></div>

--000000000000c03aed0626defcfa--

