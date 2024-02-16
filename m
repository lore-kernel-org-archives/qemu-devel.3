Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C377BC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 18:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2ZL-0002OV-B9; Fri, 16 Feb 2024 13:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb2ZK-0002OL-1C
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:04:14 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb2ZI-0003qk-1J
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 13:04:13 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-511acd26c2bso3384069e87.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 10:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708106650; x=1708711450; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+g2R2bRRY3QTPyFingBrSwpVNKRMq5czci+xhOrEMns=;
 b=T8R0DfgbQuiSWEDED825otU0baSulmYrnOldveOL/pAW7d9LfVnV94k6Pm1NrdCFlq
 GNAw7sE45p1tnCcPpmkoUsQtm35QHeJFiFi8BTMAEkGpCwuordBCfZMi9knqG02EwmhQ
 XVYY5FZd5dlUpCsGfuvVizejFjtx768mJH3HicSheRgCASrCGei5nsrARgRc+Kkww9Ws
 Xxz0f/IYe0+azeMRIOrxt2RYz08SY6NHVYtRCNcZAse44TSWQ/uEFjbn1MkN5vex/bwS
 ofS+Z0Cq/MKgECA5pJR4fkblLVsh0RNDLWjasiLwzJTxJa9Qamdy+1Ap5wqCUHWMXeS7
 dnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708106650; x=1708711450;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+g2R2bRRY3QTPyFingBrSwpVNKRMq5czci+xhOrEMns=;
 b=LomHfnXetxN1CS6qnwZRKmiPpjSlBwggcchUs8UYgNhOZ52mwLkSAmrfn8T8ll4Wri
 s5WK6XFk9f7vk+eBlTvv7BHtxOaF8KZdy8s1gIsJLZI8jazQBImWiuWQha1ZCUVbuDqC
 VnF49R6NZ9yZKmcQoY2GHk9f6IGFq5AsCEyTMcns8io1TouKH2srkD+is18UJjeEk2fg
 w/PTTeRydHhpWAZJi3/V/3MRdkMS6qKWNDMVwvzKUkepeHOCsVigrrJIjAgY0J2paFbH
 aiP7EBl5jep0SOcx0UxRJYCUy823WcmceYAJGBhvIWGLsaNlLSNeABpmpKrBlPTJuvgx
 6YmQ==
X-Gm-Message-State: AOJu0YxYhq8NyUrqBjn0Fr8e4r2JezeYjLmQ2+ltH/gqDROMbaPsukxO
 cgtqSz5TVbWY/2q15Em9HijbfrJ2vmrcgoD2j+tjUzRAy8lmoPFLknG54c/4ByqShDIxxbNIAu9
 521iVFhRHA2bnw6urswMLkdLQCCY=
X-Google-Smtp-Source: AGHT+IFDJeaNAwQlo3VQXgaapFmXopJLi4Zn5FmdtPgOv8lpB3bMjY8FwaSbmPTwXLbG/z/23/03W0sIzfUiQefZZMw=
X-Received: by 2002:a19:f706:0:b0:511:9746:6794 with SMTP id
 z6-20020a19f706000000b0051197466794mr4030109lfe.60.1708106649669; Fri, 16 Feb
 2024 10:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20240216135137.8668-3-atp.exp@gmail.com>
 <20240216135137.8668-6-atp.exp@gmail.com>
 <CAFEAcA8dC6siNn684zqgiEZhKkxnw3DRu_AzPPZ16QRUg2410Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8dC6siNn684zqgiEZhKkxnw3DRu_AzPPZ16QRUg2410Q@mail.gmail.com>
From: atp exp <atp.exp@gmail.com>
Date: Fri, 16 Feb 2024 23:33:02 +0530
Message-ID: <CAFgBtdGXmqc0ouH+-oyF2xO9LWucW_AbronG0O6-DV-Rd88CSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] misc: ppc/spapr: replace qemu_system_reset_request()
 calls with watchdog_perform_action()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com
Content-Type: multipart/alternative; boundary="00000000000017952206118392de"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=atp.exp@gmail.com; helo=mail-lf1-x12c.google.com
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

--00000000000017952206118392de
Content-Type: text/plain; charset="UTF-8"

I will exclude this patch from the series for now.
According to the discussions, the current code honours the
guest's preference.
Will wait for the enhancements needed in watchdog QAPI.

Abhiram

On Fri, 16 Feb 2024 at 20:24, Peter Maydell <peter.maydell@linaro.org>
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
> > I am unsure about the changes in `spapr_watchdog.c` in patch 3, it would
> be great
> > if any of the maintainers review it.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
> > Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> > ---
> >  hw/watchdog/spapr_watchdog.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
> > index 2bb1d3c532..9751b19506 100644
> > --- a/hw/watchdog/spapr_watchdog.c
> > +++ b/hw/watchdog/spapr_watchdog.c
> > @@ -18,6 +18,7 @@
> >  #include "target/ppc/cpu.h"
> >  #include "migration/vmstate.h"
> >  #include "trace.h"
> > +#include "sysemu/watchdog.h"
> >
> >  #include "hw/ppc/spapr.h"
> >
> > @@ -114,7 +115,7 @@ static void watchdog_expired(void *pw)
> >          qemu_system_vmstop_request(RUN_STATE_SHUTDOWN);
> >          break;
> >      case PSERIES_WDTF_ACTION_HARD_RESTART:
> > -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +        watchdog_perform_action();
> >          break;
> >      case PSERIES_WDTF_ACTION_DUMP_RESTART:
> >          CPU_FOREACH(cs) {
>
> This one is more complicated, because the spapr watchdog
> has multiple possible behaviours which the guest can ask for.
>
> We had a discussion on the mailing list about this a little while back:
>
> https://lore.kernel.org/qemu-devel/CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com/
>
> The conclusion was that the watchdog-behaviour QAPI API
> needs to be enhanced to be able to handle this kind of
> "the guest picks an action" watchdog, so that the user can
> either override the guest's choice, or request that the
> behaviour be what the guest wants it to be.
>
> thanks
> -- PMM
>

--00000000000017952206118392de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I will exclude this patch from the series for now. <br>Acc=
ording to the discussions, the current code honours the<div>guest&#39;s pre=
ference.<br>Will wait for the enhancements needed in watchdog QAPI.<br><br>=
Abhiram</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, 16 Feb 2024 at 20:24, Peter Maydell &lt;<a href=3D"mai=
lto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Fri, 16 Feb 2024 at 13:56, Abhiram Tilak &lt;<a href=3D"mailto:atp.exp@gmai=
l.com" target=3D"_blank">atp.exp@gmail.com</a>&gt; wrote:<br>
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
&gt; I am unsure about the changes in `spapr_watchdog.c` in patch 3, it wou=
ld be great<br>
&gt; if any of the maintainers review it.<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/212=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2124</a><br>
&gt; Signed-off-by: Abhiram Tilak &lt;<a href=3D"mailto:atp.exp@gmail.com" =
target=3D"_blank">atp.exp@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/watchdog/spapr_watchdog.c | 3 ++-<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog=
.c<br>
&gt; index 2bb1d3c532..9751b19506 100644<br>
&gt; --- a/hw/watchdog/spapr_watchdog.c<br>
&gt; +++ b/hw/watchdog/spapr_watchdog.c<br>
&gt; @@ -18,6 +18,7 @@<br>
&gt;=C2=A0 #include &quot;target/ppc/cpu.h&quot;<br>
&gt;=C2=A0 #include &quot;migration/vmstate.h&quot;<br>
&gt;=C2=A0 #include &quot;trace.h&quot;<br>
&gt; +#include &quot;sysemu/watchdog.h&quot;<br>
&gt;<br>
&gt;=C2=A0 #include &quot;hw/ppc/spapr.h&quot;<br>
&gt;<br>
&gt; @@ -114,7 +115,7 @@ static void watchdog_expired(void *pw)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_vmstop_request(RUN_STATE=
_SHUTDOWN);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PSERIES_WDTF_ACTION_HARD_RESTART:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(SHUTDOWN_CAUSE_=
GUEST_RESET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 watchdog_perform_action();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PSERIES_WDTF_ACTION_DUMP_RESTART:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU_FOREACH(cs) {<br>
<br>
This one is more complicated, because the spapr watchdog<br>
has multiple possible behaviours which the guest can ask for.<br>
<br>
We had a discussion on the mailing list about this a little while back:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/CAFEAcA_KjSgt-oC=3Dd2m6WAdqoR=
sUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com/" rel=3D"noreferrer" target=3D"_bla=
nk">https://lore.kernel.org/qemu-devel/CAFEAcA_KjSgt-oC=3Dd2m6WAdqoRsUcs1W_=
ji7Ng2fgVjxAWLZEw@mail.gmail.com/</a><br>
<br>
The conclusion was that the watchdog-behaviour QAPI API<br>
needs to be enhanced to be able to handle this kind of<br>
&quot;the guest picks an action&quot; watchdog, so that the user can<br>
either override the guest&#39;s choice, or request that the<br>
behaviour be what the guest wants it to be.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--00000000000017952206118392de--

