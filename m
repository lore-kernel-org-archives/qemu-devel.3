Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BFDC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 12:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNX6a-0004Ep-6X; Sat, 29 Jun 2024 08:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX6Y-0004EQ-OR
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:22:58 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sNX6W-0005ma-JI
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 08:22:58 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4464b843e37so8546051cf.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719663775; x=1720268575; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IUUBXtzLWID0iiQPuCoYq1xSqAb3toPxlam8a3AodsA=;
 b=jx1nzAXBb+A1zT04U3lWn//7VBq2BnYAIW0jTFPGIkwYHlg/x1LChRwo8v71QnZOj1
 Yn8oSwpis8U6ljOIKeGcEF49vnSp/9/TBDuj6oz6hinA2YRJzdNannNvpNNeZgKAmHP1
 uunCHOocjc5Ob6Q9/wmelgtGAeD2RMXR+GzMWUO2+U2wo5QsNEpueZ7kG3unAXDZy6c+
 s2GUUwUgGDF+zDzeIuU5sCpjLBvTAlPs0U6chPT4RwgM1oGK35RgomfOn2niwdpCGJUf
 +8TTPUEHDZ51VuW8l3AoGJmsHi07J9kZBuc/7jyVx6s/U3Ed2JqcN2sSxN7ESYDlJp0g
 boGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719663775; x=1720268575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IUUBXtzLWID0iiQPuCoYq1xSqAb3toPxlam8a3AodsA=;
 b=MthhjZJXfLddhcIfbUR+o3KR0Df5PYz+09ZMXJweYH6whs+eIkuEweghaJaDbOovve
 cjRzVIILOWRxpBz0d8yYis2HxtJKie7fAWrHIviwxtWrON0jrqPaIicugtDUVn4iMo6e
 qugkS1fpbpHjp4txpGFcyzm1Bq7wnhhlBTE7Qmh/NOpaBbcZApZEPn544Qm+LhNTHpvV
 xR8KXvqrq7f5xclFZ8GjmJ32nc6MvfI3rGWOILGjrY1gO691zc+7lTauD3vJxZtXoA5S
 sHkI6sLo2sQEnPrNizqCdyMGrKftP+SFw+DSg1E9XVD/epZVpv/JpzXoqV51c8dQWBpY
 ymfw==
X-Gm-Message-State: AOJu0YyaDCCut5k4FqU82p//xklgSXv5bZAGX5+YfVSmPeIcKiCOqIKz
 CwvUKKW4esp17Jhw9Rta91xORzboym6cgGRfbCuCQseMwXmLgvTRmBEVpH7gtJbuA/+fnK97b9n
 fkvsIKRv2XYOjZu8s2/V2KIDFpeYZeOWh+L0=
X-Google-Smtp-Source: AGHT+IHLf9fdPxj7pL8quvDIGIKotJnBZijYK9yb83YM+0bN5xvsBn/pbCyKmOlRngM8O0gD0xqJycMbZEHN+k21yFU=
X-Received: by 2002:ac8:5809:0:b0:446:49f1:79a with SMTP id
 d75a77b69052e-44662dd024emr8897111cf.24.1719663775105; Sat, 29 Jun 2024
 05:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240624101040.82726-1-phil@philjordan.eu>
In-Reply-To: <20240624101040.82726-1-phil@philjordan.eu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 29 Jun 2024 16:22:43 +0400
Message-ID: <CAJ+F1CJMzyWr3y7kEGcj2hE8fogLqH_PBcHkXYK=N28+t96OsQ@mail.gmail.com>
Subject: Re: [PATCH v2] Cursor: 8 -> 1 bit alpha downsampling improvement
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, lists@philjordan.eu
Content-Type: multipart/alternative; boundary="00000000000072daa6061c066c83"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

--00000000000072daa6061c066c83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 2:11=E2=80=AFPM Phil Dennis-Jordan <phil@philjordan=
.eu>
wrote:

> Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
> turning alpha values of 255 into 1 and everything else into 0. This
> means that mostly-opaque pixels ended up completely invisible.
>
> This patch changes the behaviour so that only pixels with less than 50%
> alpha (0-127) are treated as transparent when converted to 1-bit alpha.
>
> This greatly improves the subjective appearance of anti-aliased mouse
> cursors, such as those used by macOS, when using a front-end UI without
> support for alpha-blended cursors, such as some VNC clients.
>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  ui/cursor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/cursor.c b/ui/cursor.c
> index 29717b3ecb..dd3853320d 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -232,7 +232,7 @@ void cursor_get_mono_mask(QEMUCursor *c, int
> transparent, uint8_t *mask)
>      for (y =3D 0; y < c->height; y++) {
>          bit =3D 0x80;
>          for (x =3D 0; x < c->width; x++, data++) {
> -            if ((*data & 0xff000000) !=3D 0xff000000) {
> +            if ((*data & 0x80000000) =3D=3D 0x0) { /* Alpha < 0x80 (128)=
 */
>                  if (transparent !=3D 0) {
>                      mask[x/8] |=3D bit;
>                  }
> --
> 2.39.3 (Apple Git-146)
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000072daa6061c066c83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 24, 2024 at 2:11=E2=80=AF=
PM Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjo=
rdan.eu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity map=
s by<br>
turning alpha values of 255 into 1 and everything else into 0. This<br>
means that mostly-opaque pixels ended up completely invisible.<br>
<br>
This patch changes the behaviour so that only pixels with less than 50%<br>
alpha (0-127) are treated as transparent when converted to 1-bit alpha.<br>
<br>
This greatly improves the subjective appearance of anti-aliased mouse<br>
cursors, such as those used by macOS, when using a front-end UI without<br>
support for alpha-blended cursors, such as some VNC clients.<br>
<br>
Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br></blockquote><div><br></di=
v><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0ui/cursor.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/ui/cursor.c b/ui/cursor.c<br>
index 29717b3ecb..dd3853320d 100644<br>
--- a/ui/cursor.c<br>
+++ b/ui/cursor.c<br>
@@ -232,7 +232,7 @@ void cursor_get_mono_mask(QEMUCursor *c, int transparen=
t, uint8_t *mask)<br>
=C2=A0 =C2=A0 =C2=A0for (y =3D 0; y &lt; c-&gt;height; y++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bit =3D 0x80;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (x =3D 0; x &lt; c-&gt;width; x++, da=
ta++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*data &amp; 0xff000000) !=
=3D 0xff000000) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*data &amp; 0x80000000) =3D=
=3D 0x0) { /* Alpha &lt; 0x80 (128) */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (transpare=
nt !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mask[x/8] |=3D bit;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.39.3 (Apple Git-146)<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000072daa6061c066c83--

