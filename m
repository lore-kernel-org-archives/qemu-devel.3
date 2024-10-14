Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3EBD16273
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Lf4-0004kW-FH; Mon, 14 Oct 2024 10:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0Lf3-0004kA-EF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:03:01 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t0Lf1-0007Bh-38
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:03:00 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b1205e0e03so189888085a.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728914578; x=1729519378; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aGalByJBVjF4RTuyP1RuAJzE3ve3yOrtTpug4CTQT2Y=;
 b=auKWIJLuDnAslgjzUKHtdMDXXUkfc8vC5E72A3AiZHbOK4LUjRv1LraG3bchduwiwW
 wWWlMI8QnPsYJDrNSdpmcbDR+19G86Y7TaadfrpiTNszk86URhMf1xEyb8/iy8DrMj9j
 elbIDaWAYMaLdqdQ2JvUtbsRdwea1c/qExHAOAMTh9AuC+LQomhHWKuVNrbEV9esx0CH
 Z3XTV4Nq+1HXHRRdR4MzqvInCqGHotSRxWqa5RBhltwXFOYvscg1G7fQOEtb4XD9Sgy8
 RCXzL4JdIet95QO5VqpPkQSG54DtSsaRODk9qlqA7YoduCwH9p27c79BBDpbLElZFSRr
 J+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914578; x=1729519378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGalByJBVjF4RTuyP1RuAJzE3ve3yOrtTpug4CTQT2Y=;
 b=cOC1ZWTWRoX84mTXbBxShFuzVEPbESkyX0ORSJkDJSXtwMLO6bHK1ffkBH+KEG0vYP
 lM6x9MDOJc/HG4pgNlslYCm6Qx/ixfUhdl6ZVaxgwdjS/fPPmsVoOP4+VfmXw+pCTyUV
 g63PMt4yvi6mqOBjdKXOc1+k+1TuMQcvYbjlLYJXVSSwCZC4UYDdKSFWh+1vcw4A/qie
 6yPxkaEXayU0iwaiJnAlu0rDDOPDuEBqfBQJ/WSxZS1c++Z1I0XOzXLhZfspKVuLa+fk
 1EO2XqiESWbGQIdl/YDMunVvuOfDNqObj1qqvPtjykQ8KpDv4MxtPz7LZ3XC2440PFEo
 /yFg==
X-Gm-Message-State: AOJu0YwDRGfwSs5KHCBcgyZmWVL9LRXJaY/01DFAf7LAtbHxUIslXax1
 pH8bHjKJKT5w4qXwHPHZL5XdDyisOlL5fbXS1iTAqU0ILFtRy8V2jE2aubsg70joXTGTwRUlpki
 iiakgnwM3gQV+BEgbt6+DHDxsZCM=
X-Google-Smtp-Source: AGHT+IFTsNDuAsyVHFzeK5/o98mCg5xH7peiLjVq3SYLtbmls1EppQbn+w66gml7ThghlYWzhVM0hr/dsuzkoQ9EjfM=
X-Received: by 2002:a05:620a:450c:b0:7b1:171a:5abf with SMTP id
 af79cd13be357-7b11a3ad759mr2152564185a.45.1728914577332; Mon, 14 Oct 2024
 07:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241014114135.389766-1-r.peniaev@gmail.com>
 <20241014114135.389766-7-r.peniaev@gmail.com>
 <CAJ+F1CLwNjxT=OogC=4ujzrSHVZRA8mGqK21khUUKe-OxMoTGA@mail.gmail.com>
 <CACZ9PQV+-ZjKZUxJOb2g80zTMKXMizWMwzW3bsi16BPs1YnMBQ@mail.gmail.com>
In-Reply-To: <CACZ9PQV+-ZjKZUxJOb2g80zTMKXMizWMwzW3bsi16BPs1YnMBQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Oct 2024 18:02:46 +0400
Message-ID: <CAJ+F1CLmEKiZw3DkxzVXY+Enqur0BmeuGsm_h19RiQtp6vzfQA@mail.gmail.com>
Subject: Re: [PATCH 6/8] chardev/mux: switch mux frontends management to bitset
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003aa3720624704b46"
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x730.google.com
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

--0000000000003aa3720624704b46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:58=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> On Mon, Oct 14, 2024 at 3:20=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> >
> >
> > On Mon, Oct 14, 2024 at 3:45=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.=
com>
> wrote:
> >>
> >> Frontends can be attached and detached during run-time (although detac=
h
> >> is not implemented, but will follow). Counter variable of muxes is not
> >> enough for proper attach/detach management, so this patch implements
> >> bitset: if bit is set for the `mux_bitset` variable, then frontend
> >> device can be found in the `backend` array (yes, huge confusion with
> >> backend and frontends names).
> >>
> >> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> >> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> >> Cc: qemu-devel@nongnu.org
> >> ---
> >>  chardev/char-mux.c         | 41 +++++++++++++++++++++++++------------=
-
> >>  chardev/char.c             |  2 +-
> >>  chardev/chardev-internal.h |  2 +-
> >>  3 files changed, 29 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> >> index 9294f955462e..9c3cacb2fecd 100644
> >> --- a/chardev/char-mux.c
> >> +++ b/chardev/char-mux.c
> >> @@ -26,6 +26,7 @@
> >>  #include "qapi/error.h"
> >>  #include "qemu/module.h"
> >>  #include "qemu/option.h"
> >> +#include "qemu/bitops.h"
> >>  #include "chardev/char.h"
> >>  #include "sysemu/block-backend.h"
> >>  #include "qapi/qapi-commands-control.h"
> >> @@ -168,12 +169,19 @@ static int mux_proc_byte(Chardev *chr, MuxCharde=
v
> *d, int ch)
> >>          case 'b':
> >>              qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> >>              break;
> >> -        case 'c':
> >> -            assert(d->mux_cnt > 0); /* handler registered with first
> fe */
> >> +        case 'c': {
> >> +            unsigned int bit;
> >> +
> >> +            /* Handler registered with first fe */
> >> +            assert(d->mux_bitset !=3D 0);
> >>              /* Switch to the next registered device */
> >> -            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
> >> +            bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, d->focus +=
 1);
> >> +            if (bit >=3D MAX_MUX) {
> >> +                bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, 0);
> >> +            }
> >> +            mux_set_focus(chr, bit);
> >>              break;
> >> -        case 't':
> >> +        } case 't':
> >>              d->timestamps =3D !d->timestamps;
> >>              d->timestamps_start =3D -1;
> >>              d->linestart =3D false;
> >> @@ -243,15 +250,16 @@ static void mux_chr_read(void *opaque, const
> uint8_t *buf, int size)
> >>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
> >>  {
> >>      MuxChardev *d =3D MUX_CHARDEV(chr);
> >> -    unsigned int i;
> >> +    int bit;
> >>
> >>      if (!muxes_opened) {
> >>          return;
> >>      }
> >>
> >>      /* Send the event to all registered listeners */
> >> -    for (i =3D 0; i < d->mux_cnt; i++) {
> >> -        mux_chr_send_event(d, i, event);
> >> +    bit =3D -1;
> >> +    while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) =
<
> MAX_MUX) {
> >> +        mux_chr_send_event(d, bit, event);
> >>      }
> >>  }
> >>
> >> @@ -276,10 +284,11 @@ static GSource *mux_chr_add_watch(Chardev *s,
> GIOCondition cond)
> >>  static void char_mux_finalize(Object *obj)
> >>  {
> >>      MuxChardev *d =3D MUX_CHARDEV(obj);
> >> -    unsigned int i;
> >> +    int bit;
> >>
> >> -    for (i =3D 0; i < d->mux_cnt; i++) {
> >> -        CharBackend *be =3D d->backends[i];
> >> +    bit =3D -1;
> >> +    while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) =
<
> MAX_MUX) {
> >> +        CharBackend *be =3D d->backends[bit];
> >>          if (be) {
> >>              be->chr =3D NULL;
> >>          }
> >> @@ -304,7 +313,10 @@ static void mux_chr_update_read_handlers(Chardev
> *chr)
> >>  bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
> >>                               unsigned int *tag, Error **errp)
> >>  {
> >> -    if (d->mux_cnt >=3D MAX_MUX) {
> >> +    unsigned int bit;
> >> +
> >> +    bit =3D find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
> >> +    if (bit >=3D MAX_MUX) {
> >>          error_setg(errp,
> >>                     "too many uses of multiplexed chardev '%s'"
> >>                     " (maximum is " stringify(MAX_MUX) ")",
> >> @@ -312,8 +324,9 @@ bool mux_chr_attach_frontend(MuxChardev *d,
> CharBackend *b,
> >>          return false;
> >>      }
> >>
> >> -    d->backends[d->mux_cnt] =3D b;
> >> -    *tag =3D d->mux_cnt++;
> >> +    d->mux_bitset |=3D (1 << bit);
> >> +    d->backends[bit] =3D b;
> >> +    *tag =3D bit;
> >>
> >>      return true;
> >>  }
> >> @@ -322,7 +335,7 @@ void mux_set_focus(Chardev *chr, unsigned int focu=
s)
> >>  {
> >>      MuxChardev *d =3D MUX_CHARDEV(chr);
> >>
> >> -    assert(focus < d->mux_cnt);
> >> +    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) < MAX_MUX);
> >
> >
> > Wouldn't this be more correct?
> >
> > +    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) =3D=3D focus)=
;
> >
>
> Yes, makes sense. Thanks.
>
> Do you want the whole patchset to be resend,
> or only changed patches with "v2" prefix in subject?
>

Yes, please send a v2 with the change and r-b. For the other series, use
Based-on tag as necessary (
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01288.html)

thanks

--=20
Marc-Andr=C3=A9 Lureau

--0000000000003aa3720624704b46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 14, 2024 at 5:58=E2=80=AF=
PM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Mon, Oct 14, 2024 at 3:20=E2=80=AFPM Marc-Andr=C3=A9 Lureau<br>
&lt;<a href=3D"mailto:marcandre.lureau@gmail.com" target=3D"_blank">marcand=
re.lureau@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Oct 14, 2024 at 3:45=E2=80=AFPM Roman Penyaev &lt;<a href=3D"m=
ailto:r.peniaev@gmail.com" target=3D"_blank">r.peniaev@gmail.com</a>&gt; wr=
ote:<br>
&gt;&gt;<br>
&gt;&gt; Frontends can be attached and detached during run-time (although d=
etach<br>
&gt;&gt; is not implemented, but will follow). Counter variable of muxes is=
 not<br>
&gt;&gt; enough for proper attach/detach management, so this patch implemen=
ts<br>
&gt;&gt; bitset: if bit is set for the `mux_bitset` variable, then frontend=
<br>
&gt;&gt; device can be found in the `backend` array (yes, huge confusion wi=
th<br>
&gt;&gt; backend and frontends names).<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail=
.com" target=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
&gt;&gt; Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&g=
t;<br>
&gt;&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qem=
u-devel@nongnu.org</a><br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 41 +++=
++++++++++++++++++++++-------------<br>
&gt;&gt;=C2=A0 chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
&gt;&gt;=C2=A0 chardev/chardev-internal.h |=C2=A0 2 +-<br>
&gt;&gt;=C2=A0 3 files changed, 29 insertions(+), 16 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
&gt;&gt; index 9294f955462e..9c3cacb2fecd 100644<br>
&gt;&gt; --- a/chardev/char-mux.c<br>
&gt;&gt; +++ b/chardev/char-mux.c<br>
&gt;&gt; @@ -26,6 +26,7 @@<br>
&gt;&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;qemu/option.h&quot;<br>
&gt;&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;chardev/char.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;sysemu/block-backend.h&quot;<br>
&gt;&gt;=C2=A0 #include &quot;qapi/qapi-commands-control.h&quot;<br>
&gt;&gt; @@ -168,12 +169,19 @@ static int mux_proc_byte(Chardev *chr, MuxCh=
ardev *d, int ch)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;b&#39;:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_be_event(=
chr, CHR_EVENT_BREAK);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;c&#39;:<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(d-&gt;mux_cnt &g=
t; 0); /* handler registered with first fe */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;c&#39;: {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int bit;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Handler registered w=
ith first fe */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(d-&gt;mux_bitset=
 !=3D 0);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Switch to the n=
ext registered device */<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_set_focus(chr, (d-&=
gt;focus + 1) % d-&gt;mux_cnt);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit =3D find_next_bit(&=
amp;d-&gt;mux_bitset, MAX_MUX, d-&gt;focus + 1);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bit &gt;=3D MAX_MUX=
) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bit =3D f=
ind_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, 0);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_set_focus(chr, bit)=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;t&#39;:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } case &#39;t&#39;:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;timestamps =
=3D !d-&gt;timestamps;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;timestamps_s=
tart =3D -1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;linestart =
=3D false;<br>
&gt;&gt; @@ -243,15 +250,16 @@ static void mux_chr_read(void *opaque, const=
 uint8_t *buf, int size)<br>
&gt;&gt;=C2=A0 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event=
)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);<br>
&gt;&gt; -=C2=A0 =C2=A0 unsigned int i;<br>
&gt;&gt; +=C2=A0 =C2=A0 int bit;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (!muxes_opened) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* Send the event to all registered listeners =
*/<br>
&gt;&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;mux_cnt; i++) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_send_event(d, i, event);<br>
&gt;&gt; +=C2=A0 =C2=A0 bit =3D -1;<br>
&gt;&gt; +=C2=A0 =C2=A0 while ((bit =3D find_next_bit(&amp;d-&gt;mux_bitset=
, MAX_MUX, bit + 1)) &lt; MAX_MUX) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_send_event(d, bit, event);<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; @@ -276,10 +284,11 @@ static GSource *mux_chr_add_watch(Chardev *s=
, GIOCondition cond)<br>
&gt;&gt;=C2=A0 static void char_mux_finalize(Object *obj)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(obj);<br>
&gt;&gt; -=C2=A0 =C2=A0 unsigned int i;<br>
&gt;&gt; +=C2=A0 =C2=A0 int bit;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;mux_cnt; i++) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 CharBackend *be =3D d-&gt;backends[i]=
;<br>
&gt;&gt; +=C2=A0 =C2=A0 bit =3D -1;<br>
&gt;&gt; +=C2=A0 =C2=A0 while ((bit =3D find_next_bit(&amp;d-&gt;mux_bitset=
, MAX_MUX, bit + 1)) &lt; MAX_MUX) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CharBackend *be =3D d-&gt;backends[bi=
t];<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (be) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr =3D NUL=
L;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; @@ -304,7 +313,10 @@ static void mux_chr_update_read_handlers(Char=
dev *chr)<br>
&gt;&gt;=C2=A0 bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *tag, Error **err=
p)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; -=C2=A0 =C2=A0 if (d-&gt;mux_cnt &gt;=3D MAX_MUX) {<br>
&gt;&gt; +=C2=A0 =C2=A0 unsigned int bit;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 bit =3D find_next_zero_bit(&amp;d-&gt;mux_bitset, M=
AX_MUX, 0);<br>
&gt;&gt; +=C2=A0 =C2=A0 if (bit &gt;=3D MAX_MUX) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;too many uses of multiplexed chardev &#39;%s&#39;&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot; (maximum is &quot; stringify(MAX_MUX) &quot;)&quot;,<br>
&gt;&gt; @@ -312,8 +324,9 @@ bool mux_chr_attach_frontend(MuxChardev *d, Ch=
arBackend *b,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 d-&gt;backends[d-&gt;mux_cnt] =3D b;<br>
&gt;&gt; -=C2=A0 =C2=A0 *tag =3D d-&gt;mux_cnt++;<br>
&gt;&gt; +=C2=A0 =C2=A0 d-&gt;mux_bitset |=3D (1 &lt;&lt; bit);<br>
&gt;&gt; +=C2=A0 =C2=A0 d-&gt;backends[bit] =3D b;<br>
&gt;&gt; +=C2=A0 =C2=A0 *tag =3D bit;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt; @@ -322,7 +335,7 @@ void mux_set_focus(Chardev *chr, unsigned int =
focus)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 assert(focus &lt; d-&gt;mux_cnt);<br>
&gt;&gt; +=C2=A0 =C2=A0 assert(find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX=
, focus) &lt; MAX_MUX);<br>
&gt;<br>
&gt;<br>
&gt; Wouldn&#39;t this be more correct?<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 assert(find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, fo=
cus) =3D=3D focus);<br>
&gt;<br>
<br>
Yes, makes sense. Thanks.<br>
<br>
Do you want the whole patchset to be resend,<br>
or only changed patches with &quot;v2&quot; prefix in subject?<br></blockqu=
ote><div><br></div><div>Yes, please send a v2 with the change and r-b. For =
the other series, use Based-on tag as necessary (<a href=3D"https://lists.g=
nu.org/archive/html/qemu-devel/2017-08/msg01288.html">https://lists.gnu.org=
/archive/html/qemu-devel/2017-08/msg01288.html</a>)</div></div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">thanks<br clear=3D"al=
l"></div><br><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000003aa3720624704b46--

