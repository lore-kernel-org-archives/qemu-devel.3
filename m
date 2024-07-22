Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C19AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVoZF-0000n0-Cm; Mon, 22 Jul 2024 04:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVoZD-0000lj-JA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:38:47 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sVoZB-0007i8-RH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:38:47 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-447f7c7c5fcso22258681cf.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721637524; x=1722242324; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pETOJL/BICGnVZijunC87hi3bZJh2oK8mdoaAQG98tE=;
 b=BIqqFSUg/8xHRZzXu0me2IWYRSXjJs+PbpbuVz7fztY2wT/iRTwxsNAxgYBewEmMAm
 bt0PKbO3NUcJVfLFjSgEn8kOWSFmHH7VS+HhHpHZZXGVtW2Y03++kV/gI3/zDbfdmBYr
 K9os0j4LxSvogpx6B7URkQd+rK6+wCuitW+suzgeclsM2/tSU5xkYLt46k+7Lg0mqh7G
 1HvJlvP8R2wJJfz9xYARsvkW9nDTD5Izo7mmIE6zCR06EfwE0xykQ65fKIE2hz8JMROH
 /VPNBvyruo7r3FrqsZ/64L/ASsw11M2SvYvGvhkPysvqNPqgsH2u8kkI/QHMy96l/uV8
 Alwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721637524; x=1722242324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pETOJL/BICGnVZijunC87hi3bZJh2oK8mdoaAQG98tE=;
 b=m/Jxi1NDZ3DpsenyOzL/0GIfYB8zKW0g1yzr7+GnyZBwZ/86ASbgbciJ88RCakdZU9
 PzmWArl7vr4rucU0zAZ56yGva1WNWNiXG2Ky+fwUn09UHAb1Xl6ESQIyzVPR6rioCUAn
 rMS21LEe54dHMruQd8GlK2CaEgod/QmUYLPFwt7Jf3CoL8aKCvZ6bZ1PiB9el0E7e64q
 /8KfF6yPz7oPT5UROmNnIPGGgPW5aWdZIZ27GSk5qSsTq5qxn1BDo1DeQdAuPmtOh/sQ
 9yUf/NtkLJF6foqvtk51+SjrncTKSiAgzI5ynaT3cw0a8iaLmsSxOCKUEEbZ/IPe13IZ
 /bVg==
X-Gm-Message-State: AOJu0YyNjyU/4jvRppMSIk4iYuVMfhFqGzCkJqzt+V02NC4Clah0WuYu
 MKJpa9RuLstFIV1YAPRNv6YY6w2bdD8A5y8DfPOvOlEoKOFfmNKCyC5OneT6ouYEs+qi0hqOcJd
 aGYoyDCRz+UTxRrjOwC45NNwdH3Y=
X-Google-Smtp-Source: AGHT+IF0uu5SF1R9tlHfYhdm/XpXnB87Loud/C3Z6C2/W5ODIbGKhhyrDGA7tCQpWhQCJdJrO3mtjw16Sg753MCjOvk=
X-Received: by 2002:a05:622a:1aa5:b0:441:5a0c:41d9 with SMTP id
 d75a77b69052e-44fa52aeb5fmr116887051cf.36.1721637524165; Mon, 22 Jul 2024
 01:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <172150520664.2040.13953223569736513482-0@git.sr.ht>
In-Reply-To: <172150520664.2040.13953223569736513482-0@git.sr.ht>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 22 Jul 2024 12:38:32 +0400
Message-ID: <CAJ+F1CJrhUD5wyQDDauoTY=hok0BM7hUx99+5mK4tC4YkhtM4g@mail.gmail.com>
Subject: Re: [PATCH qemu] ui/gtk: Reuse input event slots for GdkEventTouch
To: "~katharine_chui" <kwchuiaa@connect.ust.hk>, Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000f5cfc061dd1f9de"
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

--0000000000000f5cfc061dd1f9de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Adding Sergio in CC, who wrote that code. I don't have means to test it,
which also limits my understanding and ability to check this.

On Sat, Jul 20, 2024 at 11:58=E2=80=AFPM ~katharine_chui <katharine_chui@gi=
t.sr.ht>
wrote:

> From: Katharine Chui <kwchuiaa@connect.ust.hk>
>
> There seems to be no guarantee as to how GdkEventTouch.sequence
> would progress https://docs.gtk.org/gdk3/struct.EventTouch.html
>
>
True, we also abuse the internal implementation which stores low integers
in the sequence pointer.

In the case of steam gamescope session, touch input would
> increment the number every touch, resulting in all touch inputs
> after the 10th touch to get dropped
>
> ...
> qemu: warning: Unexpected touch slot number:  10 >=3D 10
> qemu: warning: Unexpected touch slot number:  11 >=3D 10
> qemu: warning: Unexpected touch slot number:  12 >=3D 10
> qemu: warning: Unexpected touch slot number:  13 >=3D 10
> qemu: warning: Unexpected touch slot number:  14 >=3D 10
> ...
>
> Reuse the slots on gtk to avoid that
>

But doing modulo like this, there is a chance of conflict with already used
slots.

Maybe it's time for a better gtk implementation which would handle a proper
sequence pointer to slot mapping.


>
> Signed-off-by: Katharine Chui <kwchuiaa@connect.ust.hk>
> ---
>  ui/gtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index bc29f7a1b4..b123c9616d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1090,7 +1090,7 @@ static gboolean gd_touch_event(GtkWidget *widget,
> GdkEventTouch *touch,
>                                 void *opaque)
>  {
>      VirtualConsole *vc =3D opaque;
> -    uint64_t num_slot =3D GPOINTER_TO_UINT(touch->sequence);
> +    uint64_t num_slot =3D GPOINTER_TO_UINT(touch->sequence) %
> INPUT_EVENT_SLOTS_MAX;
>      int type =3D -1;
>
>      switch (touch->type) {
> --
> 2.43.4
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000f5cfc061dd1f9de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><div><br></div><div>Adding Se=
rgio in CC, who wrote that code. I don&#39;t have means to test it, which a=
lso limits my understanding and ability to check this.</div><div><br></div>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Ju=
l 20, 2024 at 11:58=E2=80=AFPM ~katharine_chui &lt;<a href=3D"mailto:kathar=
ine_chui@git.sr.ht">katharine_chui@git.sr.ht</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">From: Katharine Chui &lt;<a hre=
f=3D"mailto:kwchuiaa@connect.ust.hk" target=3D"_blank">kwchuiaa@connect.ust=
.hk</a>&gt;<br>
<br>
There seems to be no guarantee as to how GdkEventTouch.sequence<br>
would progress <a href=3D"https://docs.gtk.org/gdk3/struct.EventTouch.html"=
 rel=3D"noreferrer" target=3D"_blank">https://docs.gtk.org/gdk3/struct.Even=
tTouch.html</a><br>
<br></blockquote><div><br></div><div>True, we also abuse the internal imple=
mentation which stores low integers in the sequence pointer.</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
In the case of steam gamescope session, touch input would<br>
increment the number every touch, resulting in all touch inputs<br>
after the 10th touch to get dropped<br>
<br>
...<br>
qemu: warning: Unexpected touch slot number:=C2=A0 10 &gt;=3D 10<br>
qemu: warning: Unexpected touch slot number:=C2=A0 11 &gt;=3D 10<br>
qemu: warning: Unexpected touch slot number:=C2=A0 12 &gt;=3D 10<br>
qemu: warning: Unexpected touch slot number:=C2=A0 13 &gt;=3D 10<br>
qemu: warning: Unexpected touch slot number:=C2=A0 14 &gt;=3D 10<br>
...<br>
<br>
Reuse the slots on gtk to avoid that<br></blockquote><div><br></div><div>Bu=
t doing modulo like this, there is a chance of conflict with already used s=
lots.</div><div><br></div><div>Maybe it&#39;s time for a better gtk impleme=
ntation which would handle a proper sequence pointer to slot mapping.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Katharine Chui &lt;<a href=3D"mailto:kwchuiaa@connect.ust.hk=
" target=3D"_blank">kwchuiaa@connect.ust.hk</a>&gt;<br>
---<br>
=C2=A0ui/gtk.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/ui/gtk.c b/ui/gtk.c<br>
index bc29f7a1b4..b123c9616d 100644<br>
--- a/ui/gtk.c<br>
+++ b/ui/gtk.c<br>
@@ -1090,7 +1090,7 @@ static gboolean gd_touch_event(GtkWidget *widget, Gdk=
EventTouch *touch,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VirtualConsole *vc =3D opaque;<br>
-=C2=A0 =C2=A0 uint64_t num_slot =3D GPOINTER_TO_UINT(touch-&gt;sequence);<=
br>
+=C2=A0 =C2=A0 uint64_t num_slot =3D GPOINTER_TO_UINT(touch-&gt;sequence) %=
 INPUT_EVENT_SLOTS_MAX;<br>
=C2=A0 =C2=A0 =C2=A0int type =3D -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (touch-&gt;type) {<br>
-- <br>
2.43.4<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000000f5cfc061dd1f9de--

