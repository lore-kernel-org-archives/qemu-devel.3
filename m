Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F17C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 18:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2wj-0001MW-Ak; Fri, 16 Feb 2024 13:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb2wh-0001M9-Mm
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:28:23 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb2wf-0000Ca-C5
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:28:23 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-561587ce966so4608127a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708108100; x=1708712900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DJ0t8fvwnXYArPF6SETHJu24qQTbp+OjjRffsTqS8fY=;
 b=UaXWGfgACYrnX8Px1y5y6bAhDq/neBJw5hJnOkfWDaODxamvxmj7KFmyqYo/UOfkXc
 L3+ouZVR49GKJhsMtw4OO7RjJ98BFUgYSeze0+WKAK/X0VYeUuXqMVFyowiVfwGD50gM
 ng5ViBOaPF0U+71bgikWUA+CnCpQyxblKozwCgnUNd1Mr3Pbvb6HlG4DJL+GVxuW63X4
 LB4nACL0mHaJSPRv5ZcaoXLf0BYjz82AyFqaREnEb/2uiuu5Oakd9W+/IxD5WeSAOj41
 fX/xtqoe98n7IbxQtuOyzzBuGFgMzmcJ/r1WErWwpQL9clfcs3bjeGflT26ajFVgYvI6
 mU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708108100; x=1708712900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJ0t8fvwnXYArPF6SETHJu24qQTbp+OjjRffsTqS8fY=;
 b=vspCDGGKtVyMiYffYW5Ue2BhoyhXuI72t0qDQ4VUOxHWhPzgprLYsUSPUMUIg2pZRN
 siH4AkpjFF2UumyY1i8gDRQx2HqPsuLQRTZK7klTKApHFFXinLg2C7FfCBRrykEbd0cX
 wiauWK2jjQUj+spCF0tL3bLxoy9TvqbkEp4mFTUQdlpcBZN57aJr0jnCSDJNq1FyG13W
 sQG5VFRAG+V0LPG7P3ovqMOQ/lMvIBIIDTaPxsVPz0NO6wEfE9NmGysmrU7Ll+VPgywm
 znvAVohF1zwUshqIFsTu13j2v8Z77Cje163n4JGam/B1SBDCCu2EDzgWAwNgGgpqKPot
 eDUQ==
X-Gm-Message-State: AOJu0YzFDR4IcT4o0E2EsfaZlOW9Q+T1iX/Kl68avroho4l4BszoZxCx
 x+B548bqXhJBIHZcHbMgxR/gmqmYtCqnrOUUntf6EmfLbl/LlDCCZjHfJXrfsfjKORqYWO5vI/4
 YjX/2a5xVQI33weCeokX+sOCdKt4=
X-Google-Smtp-Source: AGHT+IHcXeLEn3AwWoDH51T+I8OLardWiSzdgwIMoz3G1gLL2xNZL2pcdVZfXo5B/5w+aTnfxUYSFl+TZGqdUckajiQ=
X-Received: by 2002:aa7:c49a:0:b0:563:3f38:ddc7 with SMTP id
 m26-20020aa7c49a000000b005633f38ddc7mr4991634edq.14.1708108099645; Fri, 16
 Feb 2024 10:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20240216135137.8668-3-atp.exp@gmail.com>
 <20240216135137.8668-4-atp.exp@gmail.com>
 <CAFEAcA_D+rJys-YP3W3UkGM+RFkv+GsrXymqUDGEgOdSu+KKMg@mail.gmail.com>
In-Reply-To: <CAFEAcA_D+rJys-YP3W3UkGM+RFkv+GsrXymqUDGEgOdSu+KKMg@mail.gmail.com>
From: atp exp <atp.exp@gmail.com>
Date: Fri, 16 Feb 2024 23:57:12 +0530
Message-ID: <CAFgBtdGLFZZhD4XaNsKew+k667Dtpfv8y__B5aAfON8ifBntSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] misc: m48t59: replace qemu_system_reset_request()
 call with watchdog_perform_action()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com
Content-Type: multipart/alternative; boundary="0000000000008473c4061183e883"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=atp.exp@gmail.com; helo=mail-ed1-x52e.google.com
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

--0000000000008473c4061183e883
Content-Type: text/plain; charset="UTF-8"

I agree, comment here is redundant, i will fix
it in the next patch.

Abhiram

On Fri, 16 Feb 2024 at 20:19, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 16 Feb 2024 at 13:56, Abhiram Tilak <atp.exp@gmail.com> wrote:
> >
> > A few watchdog devices use qemu_system_reset_request(). This is not
> ideal since
> > behaviour of watchdog-expiry can't be changed by QMP using
> `watchdog_action`.
> > As stated in BiteSizedTasks wiki page, instead of using
> qemu_system_reset_request()
> > to reset when a watchdog timer expires, let watchdog_perform_action()
> decide
> > what to do.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
> > Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> > ---
> >  hw/rtc/m48t59.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> > index aa44c4b20c..ebda084478 100644
> > --- a/hw/rtc/m48t59.c
> > +++ b/hw/rtc/m48t59.c
> > @@ -36,6 +36,7 @@
> >  #include "qemu/bcd.h"
> >  #include "qemu/module.h"
> >  #include "trace.h"
> > +#include "sysemu/watchdog.h"
> >
> >  #include "m48t59-internal.h"
> >  #include "migration/vmstate.h"
> > @@ -163,8 +164,7 @@ static void watchdog_cb (void *opaque)
> >      if (NVRAM->buffer[0x1FF7] & 0x80) {
> >          NVRAM->buffer[0x1FF7] = 0x00;
> >          NVRAM->buffer[0x1FFC] &= ~0x40;
> > -        /* May it be a hw CPU Reset instead ? */
> > -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +        watchdog_perform_action(); /* watchdog-expired action */
> >      } else {
>
> I don't think we need the comment, it's clear enough from the
> name of the function.
>
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>

--0000000000008473c4061183e883
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I agree, comment here is redundant, i will fix<div>it in t=
he next patch.</div><div><br></div><div>Abhiram</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 16 Feb 2024 =
at 20:19, Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pet=
er.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Fri, 16 Feb 2024 at 13:56, Abhiram Tilak &lt;<a hre=
f=3D"mailto:atp.exp@gmail.com" target=3D"_blank">atp.exp@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; A few watchdog devices use qemu_system_reset_request(). This is not id=
eal since<br>
&gt; behaviour of watchdog-expiry can&#39;t be changed by QMP using `watchd=
og_action`.<br>
&gt; As stated in BiteSizedTasks wiki page, instead of using qemu_system_re=
set_request()<br>
&gt; to reset when a watchdog timer expires, let watchdog_perform_action() =
decide<br>
&gt; what to do.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/212=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2124</a><br>
&gt; Signed-off-by: Abhiram Tilak &lt;<a href=3D"mailto:atp.exp@gmail.com" =
target=3D"_blank">atp.exp@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/rtc/m48t59.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c<br>
&gt; index aa44c4b20c..ebda084478 100644<br>
&gt; --- a/hw/rtc/m48t59.c<br>
&gt; +++ b/hw/rtc/m48t59.c<br>
&gt; @@ -36,6 +36,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/bcd.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt; +#include &quot;sysemu/watchdog.h&quot;<br>
&gt;<br>
&gt;=C2=A0 #include &quot;m48t59-internal.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/vmstate.h&quot;<br>
&gt; @@ -163,8 +164,7 @@ static void watchdog_cb (void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (NVRAM-&gt;buffer[0x1FF7] &amp; 0x80) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NVRAM-&gt;buffer[0x1FF7] =3D 0x00;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NVRAM-&gt;buffer[0x1FFC] &amp;=3D ~0=
x40;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* May it be a hw CPU Reset instead ? */<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(SHUTDOWN_CAUSE_=
GUEST_RESET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 watchdog_perform_action(); /* watchdog-ex=
pired action */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
<br>
I don&#39;t think we need the comment, it&#39;s clear enough from the<br>
name of the function.<br>
<br>
Otherwise<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000008473c4061183e883--

