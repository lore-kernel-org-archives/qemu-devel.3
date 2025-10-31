Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72FCCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 22:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vExTE-00049J-2c; Fri, 31 Oct 2025 18:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vExT8-000493-PS
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 18:19:39 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vExT5-0003bv-A9
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 18:19:37 -0400
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-64034284521so4842991a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761949168; x=1762553968; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P3BFta9pXZHK1C8C+3Blyg3aC0fiU3m/BSmsRjtcDNU=;
 b=Z2BbH7qKhyJUO6s2yuTQo4Ey7ctUEh0HzAcspS7W5V7GuYUSjvP7FIyWVKACOy+5Pz
 baPcWuK2FjLBhGEN6sw5cRH5uKFzLIc+6IzjSWFjM1jRImMzQXOzSzb+5YM2Y0gkrPdD
 QnQx+azpOqK+9QM5jEailbHRxijuFBVt5n54Q3Y1Nb2TLx6iyOhDJW7A6A+/cMZlDqqq
 eYT91OqWllzGGzdMe4xkyqmqB4BbD+3h7YXKVUr4N7amt9LPU26yxp/pzT5gdfeCbbe8
 qytVEcg8P5a7h4KwpIuCWEUWb2AlRKQ7RML+j+at+CI3iYsFXtTyhvH3fbes5gzXma2Z
 GAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761949168; x=1762553968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3BFta9pXZHK1C8C+3Blyg3aC0fiU3m/BSmsRjtcDNU=;
 b=VAZMC49dfJtzZGcjQ6mYRlx+qwGWSVkq23f1/r6PAI6FUiSIUPi3M6Tn9FN+qnnWbO
 Z4hckLpFHBITCtJrQH2GHbL96fEosf1FM2/2rDO664BL0Yj/Tvyr14zdRk+qoN6ktgZk
 wcBcFnHYTIIW2BoJb0nvYs9aXJa0nIp9GAU3nE8mGFVoLhoQubDQkFN4u6k91ZGzhMaM
 iKizDfL67g1wydwvtP78/Ku2kA5qDR2C0RfAvR+chjr34b3xkhY8g9NQKPrArabgY1Cc
 kdcKJvzH9b0r64P4xpHA9bvxDjvGapi9agtBJeCrz0lIssgj9k3RMEZXZpmuc2He1Ebf
 7JLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO+QyHeNjp3O5YHR4wRl685ZIoCUioSupaCzRhyywQEKqmhZCWgCE304SGjOTYmbmdeLYRJ7PvaduE@nongnu.org
X-Gm-Message-State: AOJu0Yy9X92zKTlrrBCdHukJYfDHgLKBS/x7kLptZ6Gru42ue3GUKuMb
 yeha+jJEKKGMOkbrOcK3vOIli2Ff1xjqeJMkSPPtp8X410tZUL6tIbFDmVbL7cRhXPGrsvPudXT
 3TeBIVYIcuieWek3Iz67nhABG2ffH0UU=
X-Gm-Gg: ASbGnct8k0ztVcPKePfIxkgDI1GmnoU7vmGwGqWtwhrIP4xVpXplbz3eYgHsvbcDEXo
 OmEfSKHA1ow8DOHenQT3OtaDGvgB97hVRUBOfIg1+7+gFK7GX5Prvom9Uht4n2Jt6GdM5NCYh1Q
 x9C5IBGAPpInKYZkS6y8J4GRhOBMlekIwU4Lg77o5QFZk/Uzd6Ql0mOHExKPdiZkkUpazdg5Xsp
 6xbUH6ZjVqHue96k+/Vgt9c6IbtkvTvCUdQLM0/4gcxsDjHcmxWM2g6XveR2+UCLtfd40x33CSW
 Nz+qFTis1nuIkJHj4UKSPevqzmU=
X-Google-Smtp-Source: AGHT+IErXjSIf/Wg6ABPMvYM1GhljJeszM/P1JGcaMBAlZTCOXY2MDQTUuNvGQQqtRPlHw0fp7NILlKXTrmArRT0yo0=
X-Received: by 2002:a05:6402:354a:b0:63e:85fc:4ebe with SMTP id
 4fb4d7f45d1cf-64076f75084mr3925513a12.15.1761949167318; Fri, 31 Oct 2025
 15:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251031032437.107674-1-zhaoguohan_salmon@163.com>
 <35addd9c-9e82-4972-89e9-a911f8e43e4f@gmx.de>
In-Reply-To: <35addd9c-9e82-4972-89e9-a911f8e43e4f@gmx.de>
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Date: Sat, 1 Nov 2025 03:49:16 +0530
X-Gm-Features: AWmQ_bkcQdDt0Zz6dnpribDU9A8gV6qWiZPi9NAPl3SisT1x_yTZNfr_ZlPyRQ0
Message-ID: <CAGkZZ+uceioG3Kk9qDLvdyDeSsQipo-HFKkE5zA7jfdG0tOeWA@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/ncr710: Fix null pointer dereference in
 `ncr710_transfer_data`
To: Helge Deller <deller@gmx.de>
Cc: zhaoguohan_salmon@163.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, fam@euphon.net, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Content-Type: multipart/alternative; boundary="0000000000003afa2206427bc2c4"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-ed1-x542.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003afa2206427bc2c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:39=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:

> On 10/31/25 04:24, zhaoguohan_salmon@163.com wrote:
> > From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> >
> > Fix a null pointer dereference issue.
> >
> > The code dereferences s->current before checking if it is NULL. Move th=
e
> > null check before the dereference to prevent potential crashes.
> >
> > This issue could occur if s->current is NULL when the function reaches
> > the "Host adapter (re)connected" path, though this should not normally
> > happen during correct operation.
> >
> > Fixes: 9ce93b74cdc0 ("ncr710: Add driver for the NCR 53c710 SCSI chip")
> > Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> > ---
> >   hw/scsi/ncr53c710.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> > index ade951b1d107..e479a212bc54 100644
> > --- a/hw/scsi/ncr53c710.c
> > +++ b/hw/scsi/ncr53c710.c
> > @@ -831,14 +831,14 @@ void ncr710_transfer_data(SCSIRequest *req,
> uint32_t len)
> >           }
> >       }
> >
> > -    /* Host adapter (re)connected */
> > -    s->current->dma_len =3D len;
> > -    s->command_complete =3D NCR710_CMD_DATA_READY;
>
> ^^
> I wonder if you need to keep s->command_complete, and not move it...
> Maybe only dma_len needs to be protected?
> I added Soumyajyotii to Cc here...
>

Hello GuoHan,
Thank you for pointing out the issue and suggesting the fix.
Unfortunately, with the changes you have suggested, it seems to fail to
boot on my setup while
I tried to reproduce it.
I think moving it below might break the boot process, as we never set the
s->command_complete properly.
I believe as Helge suggested only s->current->dma_len needs to be null
protected.

So i did something along the lines of::
-    /* Host adapter (re)connected */
-    s->current->dma_len =3D len;
     s->command_complete =3D NCR710_CMD_DATA_READY;
-
     if (!s->current) {
-        return;
+        s->current =3D (NCR710Request *)req->hba_private;
     }
+    s->current->dma_len =3D len;
 and it seems to work.

Thank you,
Soumyajyotii


> >       if (!s->current) {
> >           return;
> >       }
> >
> > +    /* Host adapter (re)connected */
> > +    s->current->dma_len =3D len;
> > +    s->command_complete =3D NCR710_CMD_DATA_READY;
>
>

--0000000000003afa2206427bc2c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 31, 2025=
 at 9:39=E2=80=AFPM Helge Deller &lt;<a href=3D"mailto:deller@gmx.de" targe=
t=3D"_blank">deller@gmx.de</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 10/31/25 04:24, <a href=3D"mailto:zhaoguohan_s=
almon@163.com" target=3D"_blank">zhaoguohan_salmon@163.com</a> wrote:<br>
&gt; From: GuoHan Zhao &lt;<a href=3D"mailto:zhaoguohan@kylinos.cn" target=
=3D"_blank">zhaoguohan@kylinos.cn</a>&gt;<br>
&gt; <br>
&gt; Fix a null pointer dereference issue.<br>
&gt; <br>
&gt; The code dereferences s-&gt;current before checking if it is NULL. Mov=
e the<br>
&gt; null check before the dereference to prevent potential crashes.<br>
&gt; <br>
&gt; This issue could occur if s-&gt;current is NULL when the function reac=
hes<br>
&gt; the &quot;Host adapter (re)connected&quot; path, though this should no=
t normally<br>
&gt; happen during correct operation.<br>
&gt; <br>
&gt; Fixes: 9ce93b74cdc0 (&quot;ncr710: Add driver for the NCR 53c710 SCSI =
chip&quot;)<br>
&gt; Signed-off-by: GuoHan Zhao &lt;<a href=3D"mailto:zhaoguohan@kylinos.cn=
" target=3D"_blank">zhaoguohan@kylinos.cn</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/scsi/ncr53c710.c | 8 ++++----<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c<br>
&gt; index ade951b1d107..e479a212bc54 100644<br>
&gt; --- a/hw/scsi/ncr53c710.c<br>
&gt; +++ b/hw/scsi/ncr53c710.c<br>
&gt; @@ -831,14 +831,14 @@ void ncr710_transfer_data(SCSIRequest *req, uint=
32_t len)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* Host adapter (re)connected */<br>
&gt; -=C2=A0 =C2=A0 s-&gt;current-&gt;dma_len =3D len;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;command_complete =3D NCR710_CMD_DATA_READY;<br>
<br>
^^<br>
I wonder if you need to keep s-&gt;command_complete, and not move it...<br>
Maybe only dma_len needs to be protected?<br>
I added Soumyajyotii to Cc here...<br>=C2=A0</blockquote><div>Hello GuoHan,=
</div><div>Thank you for pointing out the issue and suggesting the fix.</di=
v><div>Unfortunately, with the changes you have suggested, it seems to fail=
 to boot on my setup while</div><div>I tried to reproduce it.</div><div>I t=
hink moving it below might break the boot process, as we never set the s-&g=
t;command_complete properly.</div><div>I believe as Helge suggested only s-=
&gt;current-&gt;dma_len needs to be null protected.</div><div><br></div><di=
v>So i did something along the lines of::</div><div>- =C2=A0 =C2=A0/* Host =
adapter (re)connected */<br>- =C2=A0 =C2=A0s-&gt;current-&gt;dma_len =3D le=
n;<br>=C2=A0 =C2=A0 =C2=A0s-&gt;command_complete =3D NCR710_CMD_DATA_READY;=
<br>-<br>=C2=A0 =C2=A0 =C2=A0if (!s-&gt;current) {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;current =3D (NCR710=
Request *)req-&gt;hba_private;<br>=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0s=
-&gt;current-&gt;dma_len =3D len;<br>=C2=A0and it seems to work.</div><div>=
<br></div><div>Thank you,</div><div>Soumyajyotii</div><div><br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;current) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Host adapter (re)connected */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;current-&gt;dma_len =3D len;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;command_complete =3D NCR710_CMD_DATA_READY;<br>
<br>
</blockquote></div></div>
</div>

--0000000000003afa2206427bc2c4--

