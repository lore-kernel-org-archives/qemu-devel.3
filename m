Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5ACC36006
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUzA-00033z-1S; Tue, 17 Sep 2024 05:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sqUz8-00033H-9C
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:59:02 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sqUz6-0001FS-Ju
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:59:02 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9a30a0490so599440185a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726567139; x=1727171939; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qM8XkbfaCHFRmFHwUvgRDExNg2VkTJfQXNyA/YgX0SU=;
 b=KPNoruaunVLBoDaUNSeNp5EKfS91RG0Ii1y0suzU1q4FF1wlbCYvpOYHciEdb1uMli
 BM01/EGgxj6drzW5VzTgGSdCzm3OpdJ7tkfFAElsXFn9zQdYJXhjPocTksUna03dLFWP
 ORbUMbIDqpqTviJvbKxeKFPiiMClNdNeyS/j46HeK/mdJj1y26f6eXYDWidjSh4rtXEr
 H/UBRLD0PAYplzKEdlO8VXIT5DIgYUmnSi7qfepIJQFE5+lvSEwUcROWs1lhsrmIAnip
 fmSMTFhJkS3QaEUnUqYjFnwijyH/NHpA8wS+T4tiyWcfHXxz13xeq7Di9UpDKpCMnEyt
 1K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726567139; x=1727171939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qM8XkbfaCHFRmFHwUvgRDExNg2VkTJfQXNyA/YgX0SU=;
 b=iBw2YJMj0DzsVy6Qf9vsEIAiPvfIt3Qw7SRZ50x0g5M7B09bjXrKv3sQaJLQa7kwOh
 5VNDUPJnC9DLSo2Ne2GNjErDuajjIn4/pb35L6KZGmbRJJQN1NAg0zhF26GKRKRPdFqv
 CW2DDpHoXVhZRgFbxVSfOZtlm7XNqhpJQv4sofVzGDini/ejGlk79/AQwUzKNBmBllqc
 ymTmKt5n5x/ixfAmPasZYirUR7WKkoEBwEH5c4isFzBK78Tz1mS+lsUBynLHpayTwT4u
 d6O0hDvRCui0ZPYbsVGJeHRb5gERkBEyJ63wK8cO06G+DEltrvGSmuNYCFTVwrDR9dk+
 M3Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRV/QaBFFmC0UYpeTk6yXqdFFckBbLuMeppM9uW+0vzvUsgX65sS+wSg6j87XZwupNcFOG7OCogqQO@nongnu.org
X-Gm-Message-State: AOJu0Yz/icMv7HlmiHKpExfLv3XaKG4vfgOe/hw5I88EmQh1vWueLH2i
 SsW4t+/0OiZVsrnSS1tdRuaRA83vqJ7ML7BrNVmdMIo/+/0NSlk1jkH/dhdf2LQdo/VFNsOxiGP
 Q9+sXQttvlaG4mcc8oOu16Rn2zAQ=
X-Google-Smtp-Source: AGHT+IEHU5gUKmfrLWbxKxlPRRjTY32beue7lFsIXp7Zu6QoFaz1AINKJdbFO8LGOJ0cJE/SV5gcFMimiLI40sswPnk=
X-Received: by 2002:a05:620a:4710:b0:79d:7a6c:ae5a with SMTP id
 af79cd13be357-7a9e5f2be0cmr3386408185a.33.1726567139030; Tue, 17 Sep 2024
 02:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240917002318.331010-1-dave@treblig.org>
In-Reply-To: <20240917002318.331010-1-dave@treblig.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Sep 2024 13:58:47 +0400
Message-ID: <CAJ+F1C+gvW+EdzoxJYBst1QAEw5RW1VmU2CkqzHEKSn+XpGJmw@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: remove cursor_get_mono_image
To: dave@treblig.org
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000000c05306224dbd4a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72a.google.com
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

--00000000000000c05306224dbd4a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 4:23=E2=80=AFAM <dave@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> cursor_get_mono_image has been unused since 2018's
>   0015ca5cba ("ui: remove support for SDL1.2 in favour of SDL2")
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/ui/console.h |  1 -
>  ui/cursor.c          | 24 ------------------------
>  2 files changed, 25 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index fa986ab97e..5832d52a8a 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -175,7 +175,6 @@ int cursor_get_mono_bpl(QEMUCursor *c);
>  void cursor_set_mono(QEMUCursor *c,
>                       uint32_t foreground, uint32_t background, uint8_t
> *image,
>                       int transparent, uint8_t *mask);
> -void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *mask)=
;
>  void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)=
;
>
>  typedef void *QEMUGLContext;
> diff --git a/ui/cursor.c b/ui/cursor.c
> index dd3853320d..6e23244fbe 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -197,30 +197,6 @@ void cursor_set_mono(QEMUCursor *c,
>      }
>  }
>
> -void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *image=
)
> -{
> -    uint32_t *data =3D c->data;
> -    uint8_t bit;
> -    int x,y,bpl;
> -
> -    bpl =3D cursor_get_mono_bpl(c);
> -    memset(image, 0, bpl * c->height);
> -    for (y =3D 0; y < c->height; y++) {
> -        bit =3D 0x80;
> -        for (x =3D 0; x < c->width; x++, data++) {
> -            if (((*data & 0xff000000) =3D=3D 0xff000000) &&
> -                ((*data & 0x00ffffff) =3D=3D foreground)) {
> -                image[x/8] |=3D bit;
> -            }
> -            bit >>=3D 1;
> -            if (bit =3D=3D 0) {
> -                bit =3D 0x80;
> -            }
> -        }
> -        image +=3D bpl;
> -    }
> -}
> -
>  void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
>  {
>      uint32_t *data =3D c->data;
> --
> 2.46.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000000c05306224dbd4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 17, 2024 at 4:23=E2=80=AF=
AM &lt;<a href=3D"mailto:dave@treblig.org">dave@treblig.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: &quot;Dr. =
David Alan Gilbert&quot; &lt;<a href=3D"mailto:dave@treblig.org" target=3D"=
_blank">dave@treblig.org</a>&gt;<br>
<br>
cursor_get_mono_image has been unused since 2018&#39;s<br>
=C2=A0 0015ca5cba (&quot;ui: remove support for SDL1.2 in favour of SDL2&qu=
ot;)<br>
<br>
Remove it.<br>
<br>
Signed-off-by: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dave@treblig.or=
g" target=3D"_blank">dave@treblig.org</a>&gt;<br></blockquote><div><br></di=
v><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0include/ui/console.h |=C2=A0 1 -<br>
=C2=A0ui/cursor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 ------------------=
------<br>
=C2=A02 files changed, 25 deletions(-)<br>
<br>
diff --git a/include/ui/console.h b/include/ui/console.h<br>
index fa986ab97e..5832d52a8a 100644<br>
--- a/include/ui/console.h<br>
+++ b/include/ui/console.h<br>
@@ -175,7 +175,6 @@ int cursor_get_mono_bpl(QEMUCursor *c);<br>
=C2=A0void cursor_set_mono(QEMUCursor *c,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t foreground, uint32_t background, uint8_t *image,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int transparent, uint8_t *mask);<br>
-void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *mask);<=
br>
=C2=A0void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *ma=
sk);<br>
<br>
=C2=A0typedef void *QEMUGLContext;<br>
diff --git a/ui/cursor.c b/ui/cursor.c<br>
index dd3853320d..6e23244fbe 100644<br>
--- a/ui/cursor.c<br>
+++ b/ui/cursor.c<br>
@@ -197,30 +197,6 @@ void cursor_set_mono(QEMUCursor *c,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *image)<=
br>
-{<br>
-=C2=A0 =C2=A0 uint32_t *data =3D c-&gt;data;<br>
-=C2=A0 =C2=A0 uint8_t bit;<br>
-=C2=A0 =C2=A0 int x,y,bpl;<br>
-<br>
-=C2=A0 =C2=A0 bpl =3D cursor_get_mono_bpl(c);<br>
-=C2=A0 =C2=A0 memset(image, 0, bpl * c-&gt;height);<br>
-=C2=A0 =C2=A0 for (y =3D 0; y &lt; c-&gt;height; y++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bit =3D 0x80;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (x =3D 0; x &lt; c-&gt;width; x++, data++)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (((*data &amp; 0xff000000) =
=3D=3D 0xff000000) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((*data &amp; 0x00=
ffffff) =3D=3D foreground)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 image[x/8] |=3D bi=
t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit &gt;&gt;=3D 1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bit =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit =3D 0x80;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 image +=3D bpl;<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
=C2=A0void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *ma=
sk)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t *data =3D c-&gt;data;<br>
-- <br>
2.46.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000000c05306224dbd4a--

