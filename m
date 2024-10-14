Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42680D16260
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0L03-0002GW-4H; Mon, 14 Oct 2024 09:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0L02-0002E1-5e
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:20:38 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0L00-0000j0-3V
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:20:37 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4604d8f1622so17910551cf.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728912034; x=1729516834; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FV+u43pN0/GaK2R0u7qyK0Rc+Cvp5PzPv/O7LDOqhEc=;
 b=ZR+4ffXi4A8OQtZgpd0Qx5E+zRPLFju4vN6Y825qX3z3m7ZvQpzE+KJvnncdhKfXdJ
 0H3PBTu6NA2enmicyX27pangyP+8yiNOKCGK7LlktImXWlihtrziPIhBDLkAI8Br1MTt
 p7sEi39oGbU1VVIoGIYI4vSLtHkEg1abCqPfMGq+4IJczSSVssWHLn9vC2wfq3oMeywI
 enJVIJGsdkbImZcJyHwdDByOpMKG37HhYhrxIOFXw4r6hg8cBLnH2JbnA0TTW6heRYvG
 7YS1zp9lPFJXTDAmkrnNixtDUljGkIFdaVeYTi4Rq0u7w5HsqKhahXqI8wAl/phhfl88
 HJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728912034; x=1729516834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FV+u43pN0/GaK2R0u7qyK0Rc+Cvp5PzPv/O7LDOqhEc=;
 b=DokBnfwGvznx/XqNwYK+T3SCDpWicqXNMQr3L1s4vtasP7Mg1BmFGOkb0jN+dytWV9
 LkRQVvbkRJAL7zqokgx5r+zGA6BICJ8KUDV0fgbRz/1nQA/ejXsPZ1p070p+988ylxMA
 u5o/HkKaKQZ4d7iQ67LASEcybdveKmODceK1wahNY+S0QK7M5fpMsyLXjEvpqQvW4XSg
 fCseNx6mntz5hR+dX26EZikMvJiM1GU+TXuyfSZaBgWDIhRhK/xsVx/JqiUDB3G5dUUw
 DEqEI4IGpX06iTMEmyxZf3GXupcG+HTP6wEJ2VhwXtmwC6sXx8F6S81mQlgLSy8ZYmmX
 FR0A==
X-Gm-Message-State: AOJu0YxupfDyQwZtajKfjGKKdNeZlBuiFqaqeKd/1k4HHGHaLEiHrWDm
 mUA/bdGf6drb2vfg1s+igtQnxq7608ahS7Eojg94WTI06qrB8eS19XtUxz3/MH3q8Wt7GfY89K8
 LYVv/zb9Gh9j/b1mUwHG1VZZ/uPkJh816aXE=
X-Google-Smtp-Source: AGHT+IHz+QV7BlI1Ue5vcMdRf/oLXflVzFWR4Zr42/M+TF9TK9FYV5CmqMuUUVhyA0RF/Xvm/cNZdFPUQJMAGsJ0MuM=
X-Received: by 2002:ac8:57d0:0:b0:45e:ff4c:6378 with SMTP id
 d75a77b69052e-4604bb9477emr161216821cf.3.1728912034356; Mon, 14 Oct 2024
 06:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241014114135.389766-1-r.peniaev@gmail.com>
 <20241014114135.389766-7-r.peniaev@gmail.com>
In-Reply-To: <20241014114135.389766-7-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Oct 2024 17:20:22 +0400
Message-ID: <CAJ+F1CLwNjxT=OogC=4ujzrSHVZRA8mGqK21khUUKe-OxMoTGA@mail.gmail.com>
Subject: Re: [PATCH 6/8] chardev/mux: switch mux frontends management to bitset
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a7e61306246fb387"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--000000000000a7e61306246fb387
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:45=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> Frontends can be attached and detached during run-time (although detach
> is not implemented, but will follow). Counter variable of muxes is not
> enough for proper attach/detach management, so this patch implements
> bitset: if bit is set for the `mux_bitset` variable, then frontend
> device can be found in the `backend` array (yes, huge confusion with
> backend and frontends names).
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/char-mux.c         | 41 +++++++++++++++++++++++++-------------
>  chardev/char.c             |  2 +-
>  chardev/chardev-internal.h |  2 +-
>  3 files changed, 29 insertions(+), 16 deletions(-)
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 9294f955462e..9c3cacb2fecd 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> +#include "qemu/bitops.h"
>  #include "chardev/char.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/qapi-commands-control.h"
> @@ -168,12 +169,19 @@ static int mux_proc_byte(Chardev *chr, MuxChardev
> *d, int ch)
>          case 'b':
>              qemu_chr_be_event(chr, CHR_EVENT_BREAK);
>              break;
> -        case 'c':
> -            assert(d->mux_cnt > 0); /* handler registered with first fe =
*/
> +        case 'c': {
> +            unsigned int bit;
> +
> +            /* Handler registered with first fe */
> +            assert(d->mux_bitset !=3D 0);
>              /* Switch to the next registered device */
> -            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
> +            bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, d->focus + 1)=
;
> +            if (bit >=3D MAX_MUX) {
> +                bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, 0);
> +            }
> +            mux_set_focus(chr, bit);
>              break;
> -        case 't':
> +        } case 't':
>              d->timestamps =3D !d->timestamps;
>              d->timestamps_start =3D -1;
>              d->linestart =3D false;
> @@ -243,15 +250,16 @@ static void mux_chr_read(void *opaque, const uint8_=
t
> *buf, int size)
>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(chr);
> -    unsigned int i;
> +    int bit;
>
>      if (!muxes_opened) {
>          return;
>      }
>
>      /* Send the event to all registered listeners */
> -    for (i =3D 0; i < d->mux_cnt; i++) {
> -        mux_chr_send_event(d, i, event);
> +    bit =3D -1;
> +    while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) <
> MAX_MUX) {
> +        mux_chr_send_event(d, bit, event);
>      }
>  }
>
> @@ -276,10 +284,11 @@ static GSource *mux_chr_add_watch(Chardev *s,
> GIOCondition cond)
>  static void char_mux_finalize(Object *obj)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(obj);
> -    unsigned int i;
> +    int bit;
>
> -    for (i =3D 0; i < d->mux_cnt; i++) {
> -        CharBackend *be =3D d->backends[i];
> +    bit =3D -1;
> +    while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) <
> MAX_MUX) {
> +        CharBackend *be =3D d->backends[bit];
>          if (be) {
>              be->chr =3D NULL;
>          }
> @@ -304,7 +313,10 @@ static void mux_chr_update_read_handlers(Chardev *ch=
r)
>  bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
>                               unsigned int *tag, Error **errp)
>  {
> -    if (d->mux_cnt >=3D MAX_MUX) {
> +    unsigned int bit;
> +
> +    bit =3D find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
> +    if (bit >=3D MAX_MUX) {
>          error_setg(errp,
>                     "too many uses of multiplexed chardev '%s'"
>                     " (maximum is " stringify(MAX_MUX) ")",
> @@ -312,8 +324,9 @@ bool mux_chr_attach_frontend(MuxChardev *d,
> CharBackend *b,
>          return false;
>      }
>
> -    d->backends[d->mux_cnt] =3D b;
> -    *tag =3D d->mux_cnt++;
> +    d->mux_bitset |=3D (1 << bit);
> +    d->backends[bit] =3D b;
> +    *tag =3D bit;
>
>      return true;
>  }
> @@ -322,7 +335,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
>  {
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>
> -    assert(focus < d->mux_cnt);
> +    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) < MAX_MUX);
>

Wouldn't this be more correct?

+    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) =3D=3D focus);


>
>      if (d->focus !=3D -1) {
>          mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
> diff --git a/chardev/char.c b/chardev/char.c
> index f54dc3a86286..a1722aa076d9 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
>  {
>      if (CHARDEV_IS_MUX(s)) {
>          MuxChardev *d =3D MUX_CHARDEV(s);
> -        return d->mux_cnt > 0;
> +        return d->mux_bitset !=3D 0;
>      } else {
>          return s->be !=3D NULL;
>      }
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index 8126ce180690..b89aada5413b 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -37,8 +37,8 @@ struct MuxChardev {
>      Chardev parent;
>      CharBackend *backends[MAX_MUX];
>      CharBackend chr;
> +    unsigned long mux_bitset;
>      int focus;
> -    unsigned int mux_cnt;
>      bool term_got_escape;
>      /* Intermediate input buffer catches escape sequences even if the
>         currently active device is not accepting any input - but only
> until it
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000a7e61306246fb387
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 14, 2024 at 3:45=E2=80=AF=
PM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Frontends can be attached and detached during run-time (although detach=
<br>
is not implemented, but will follow). Counter variable of muxes is not<br>
enough for proper attach/detach management, so this patch implements<br>
bitset: if bit is set for the `mux_bitset` variable, then frontend<br>
device can be found in the `backend` array (yes, huge confusion with<br>
backend and frontends names).<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 41 ++++++++++++=
+++++++++++++-------------<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
=C2=A0chardev/chardev-internal.h |=C2=A0 2 +-<br>
=C2=A03 files changed, 29 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index 9294f955462e..9c3cacb2fecd 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -26,6 +26,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/option.h&quot;<br>
+#include &quot;qemu/bitops.h&quot;<br>
=C2=A0#include &quot;chardev/char.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
=C2=A0#include &quot;qapi/qapi-commands-control.h&quot;<br>
@@ -168,12 +169,19 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d,=
 int ch)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;b&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_chr_be_event(chr, CHR_=
EVENT_BREAK);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;c&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(d-&gt;mux_cnt &gt; 0); /*=
 handler registered with first fe */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;c&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int bit;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Handler registered with first=
 fe */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(d-&gt;mux_bitset !=3D 0);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Switch to the next regis=
tered device */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_set_focus(chr, (d-&gt;focus =
+ 1) % d-&gt;mux_cnt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit =3D find_next_bit(&amp;d-&gt=
;mux_bitset, MAX_MUX, d-&gt;focus + 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bit &gt;=3D MAX_MUX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit =3D find_next_=
bit(&amp;d-&gt;mux_bitset, MAX_MUX, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_set_focus(chr, bit);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;t&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } case &#39;t&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d-&gt;timestamps =3D !d-&gt=
;timestamps;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d-&gt;timestamps_start =3D =
-1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d-&gt;linestart =3D false;<=
br>
@@ -243,15 +250,16 @@ static void mux_chr_read(void *opaque, const uint8_t =
*buf, int size)<br>
=C2=A0void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(chr);<br>
-=C2=A0 =C2=A0 unsigned int i;<br>
+=C2=A0 =C2=A0 int bit;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!muxes_opened) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Send the event to all registered listeners */<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;mux_cnt; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_send_event(d, i, event);<br>
+=C2=A0 =C2=A0 bit =3D -1;<br>
+=C2=A0 =C2=A0 while ((bit =3D find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX=
, bit + 1)) &lt; MAX_MUX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_send_event(d, bit, event);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -276,10 +284,11 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCond=
ition cond)<br>
=C2=A0static void char_mux_finalize(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(obj);<br>
-=C2=A0 =C2=A0 unsigned int i;<br>
+=C2=A0 =C2=A0 int bit;<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;mux_cnt; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CharBackend *be =3D d-&gt;backends[i];<br>
+=C2=A0 =C2=A0 bit =3D -1;<br>
+=C2=A0 =C2=A0 while ((bit =3D find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX=
, bit + 1)) &lt; MAX_MUX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CharBackend *be =3D d-&gt;backends[bit];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (be) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be-&gt;chr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -304,7 +313,10 @@ static void mux_chr_update_read_handlers(Chardev *chr)=
<br>
=C2=A0bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *tag, Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (d-&gt;mux_cnt &gt;=3D MAX_MUX) {<br>
+=C2=A0 =C2=A0 unsigned int bit;<br>
+<br>
+=C2=A0 =C2=A0 bit =3D find_next_zero_bit(&amp;d-&gt;mux_bitset, MAX_MUX, 0=
);<br>
+=C2=A0 =C2=A0 if (bit &gt;=3D MAX_MUX) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;too many uses of multiplexed chardev &#39;%s&#39;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
; (maximum is &quot; stringify(MAX_MUX) &quot;)&quot;,<br>
@@ -312,8 +324,9 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend=
 *b,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 d-&gt;backends[d-&gt;mux_cnt] =3D b;<br>
-=C2=A0 =C2=A0 *tag =3D d-&gt;mux_cnt++;<br>
+=C2=A0 =C2=A0 d-&gt;mux_bitset |=3D (1 &lt;&lt; bit);<br>
+=C2=A0 =C2=A0 d-&gt;backends[bit] =3D b;<br>
+=C2=A0 =C2=A0 *tag =3D bit;<br>
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
@@ -322,7 +335,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(chr);<br>
<br>
-=C2=A0 =C2=A0 assert(focus &lt; d-&gt;mux_cnt);<br>
+=C2=A0 =C2=A0 assert(find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, focus) =
&lt; MAX_MUX);<br></blockquote><div><br></div><div>Wouldn&#39;t this be mor=
e correct?<br></div><div><br></div><div>+ =C2=A0 =C2=A0assert(find_next_bit=
(&amp;d-&gt;mux_bitset, MAX_MUX, focus) =3D=3D focus);<br>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0if (d-&gt;focus !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux_chr_send_event(d, d-&gt;focus, CHR_EV=
ENT_MUX_OUT);<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index f54dc3a86286..a1722aa076d9 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(s);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;mux_cnt &gt; 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;mux_bitset !=3D 0;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;be !=3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h<br>
index 8126ce180690..b89aada5413b 100644<br>
--- a/chardev/chardev-internal.h<br>
+++ b/chardev/chardev-internal.h<br>
@@ -37,8 +37,8 @@ struct MuxChardev {<br>
=C2=A0 =C2=A0 =C2=A0Chardev parent;<br>
=C2=A0 =C2=A0 =C2=A0CharBackend *backends[MAX_MUX];<br>
=C2=A0 =C2=A0 =C2=A0CharBackend chr;<br>
+=C2=A0 =C2=A0 unsigned long mux_bitset;<br>
=C2=A0 =C2=A0 =C2=A0int focus;<br>
-=C2=A0 =C2=A0 unsigned int mux_cnt;<br>
=C2=A0 =C2=A0 =C2=A0bool term_got_escape;<br>
=C2=A0 =C2=A0 =C2=A0/* Intermediate input buffer catches escape sequences e=
ven if the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 currently active device is not accepting any in=
put - but only until it<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000a7e61306246fb387--

