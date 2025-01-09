Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD095E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVslA-0000JC-Hq; Thu, 09 Jan 2025 08:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqfa-0000M9-Vj; Thu, 09 Jan 2025 06:25:47 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqfZ-0005Rx-0H; Thu, 09 Jan 2025 06:25:46 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso6138606d6.2; 
 Thu, 09 Jan 2025 03:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736421943; x=1737026743; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XMeD5lDVpb1YJEsVtFO/csxTRuXtZpT83jX0pLiBs2Q=;
 b=ZGDxOKMOI47LPJfrQjECKbSSHGsMSziRVOO4h8pzJ1+ctlvnwS2lv0k6GwqmayiChG
 RWNCpPXS0h4tYiX4xXACaa0DJQRU3TPMzc96pTleFTol6x1MyZ9dgRaf7/dSIjWpsoKh
 Ps126kTSroRfg5J8Xbj28Jnu4YHbqm+AVWZ+gqyh2Iyu680qvcPphwg8FnhTF7D8Fbjp
 ghccbMu8fGcpaMC3L2acfOrc2Co8jN60NWIXju6Gtup8xA6JJOs1qwwfWEhsrp43RAMu
 nuCXGDqfZO0pPLPkICZg3KJKXi9aC2PQITZqHD2ViZHf4DOvkEMxAtTgG83Ir7yK9xGL
 WFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736421943; x=1737026743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XMeD5lDVpb1YJEsVtFO/csxTRuXtZpT83jX0pLiBs2Q=;
 b=FPaItwPLrp0mFlVsG83amucmuBAyYDlblrM89MtZxd8ApOg6kG6DZ9ra9SLOomjTDr
 lLXIi5R7pwAdyQ0EIih3I+S2wir7kr+YywKa7i4AFNdiXIwoZwISXmi7fyh+2Cp8iVxS
 Op6I7C41KtpW/quYHRa43KdhbOKx4NG4M6A8qub+zQJ3KUMCW2gedc8Of0pakDk2QdOZ
 GTcfPBpw7lpIXNolCoTL+zrLCI46LbmdQpTTyRQccblYnrt/qAbPcoOgWbBUSpqB4oIS
 6uqH59zEJWCEUkPPzHFa1MYqYHI2wsjJc0myRnssxYgAQ00O35DMpnzdQaFbtkQXNShr
 T1PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEf4YraGsbogOtWRgUIoyxpcmUFUyMrkdCE5a62iFh3Pe3DaDT1UU06ZtSIc+ALD2HfVff/q+yBQ==@nongnu.org,
 AJvYcCV3kjidfByq1rMFQJeU1QLQ7l2pkrAph41rF/NGWP0JldL1cdl4dhoFbjdhrHko0MkfW426GWGmsF8TyA==@nongnu.org,
 AJvYcCX9dOEGIS82j5oRy/+og27Vy8HYj5i5dn+NQOl5yGX6ZDrMB+DKMu/GHau8bXef62ydplG00ciuLUqw3Ow=@nongnu.org
X-Gm-Message-State: AOJu0Yz7TkWOsZiMLXd8vqD4QNS/MxzchNLYnS2x0h1Ypogub1hErvKi
 p9oUOszpBeNAFu2NlyIggHDuOYJ3J/tzeXarlVuqjQ+ghbM1bHEq+Qka283KvAYbyIHmHoBNOUJ
 EeOQWRf61ZEjn3pBWLg4B7Gu1mA8=
X-Gm-Gg: ASbGncs024kPjH0ygm6TG40lQq6zZpuCe7tvr9cbZRNjANZk677VIA2x1+JZ9lSS5Hj
 XPaAoKVPWaWa7J1Ppzdc1eFbER5tfbRieqQpn
X-Google-Smtp-Source: AGHT+IFpNIl2Y2aL6XrsE6Ed3+ys8rwTyb3MS4IqTeq74L7MF1XnXP2M0Ady6B9UL5z690Zov1/sSED83JdRVlokbp4=
X-Received: by 2002:a05:6214:c25:b0:6df:99e9:39b3 with SMTP id
 6a1803df08f44-6df9b1eebccmr98397376d6.15.1736421942799; Thu, 09 Jan 2025
 03:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <20241218181511.3575613-4-alex.bennee@linaro.org>
 <718a0ab6-cc07-4721-9560-7745ed1c04a6@linaro.org>
In-Reply-To: <718a0ab6-cc07-4721-9560-7745ed1c04a6@linaro.org>
From: Daniel Wielandt <wielandtdan@gmail.com>
Date: Thu, 9 Jan 2025 05:25:32 -0600
X-Gm-Features: AbW1kvaTPNBtSvRdchYiKenHB3PVhoj18TtmBI3OVwRdTGlOlh8uzqgyezsBjJE
Message-ID: <CA+7p6P+UAHEX_CFy6VNCGWYtCRBPd7mf1v6OMZ3=70d+kxsHgw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] target/arm: implement SEL2 physical and virtual
 timers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 qemu-stable@nongnu.org, Andrei Homescu <ahomescu@google.com>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@google.com>, 
 =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi.denis.courmont@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000014b339062b443dcb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=wielandtdan@gmail.com; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Jan 2025 08:39:34 -0500
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

--00000000000014b339062b443dcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's not the context that lacks its the protocol.. lol. I wish I was good
with words and a genius... oh no wait. It's easier being simple..you
think.u could find the s
B listers. There's gotta b a mpatch

On Thu, Jan 9, 2025, 5:19=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@li=
naro.org>
wrote:

> On 18/12/24 19:15, Alex Benn=C3=A9e wrote:
> > When FEAT_SEL2 was implemented the SEL2 timers where missed. This
> > shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The
> > actual implementation utilises the same logic as the rest of the
> > timers so all we need to do is:
> >
> >    - define the timers and their access functions
> >    - conditionally add the correct system registers
> >    - create a new accessfn as the rules are subtly different to the
> >      existing secure timer
> >
> > Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: qemu-stable@nongnu.org
> > Cc: Andrei Homescu <ahomescu@google.com>
> > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@google.com>
> > Cc: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> >
> > ---
> > v1
> >    - add better comments to GTIMER descriptions
> >    - also define new timers for sbsa-ref
> >    - don't conditionally gate qemu_timer creation on the feature
> >    - take cntvoff_el2 int account for SEC_VEL2 in
> gt_recalc/g_tval_[read|write]
> > v2
> >    - rename IRQ to ARCH_TIMER_S_EL2_VIRT_IRQ
> >    - split machine enablement into separate patches
> >    - return CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases
> > ---
> >   include/hw/arm/bsa.h |   2 +
> >   target/arm/cpu.h     |   2 +
> >   target/arm/gtimer.h  |   4 +-
> >   target/arm/cpu.c     |   4 ++
> >   target/arm/helper.c  | 158 ++++++++++++++++++++++++++++++++++++++++++=
+
> >   5 files changed, 169 insertions(+), 1 deletion(-)
>
>
> > diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
> > index de016e6da3..f8f7425a5f 100644
> > --- a/target/arm/gtimer.h
> > +++ b/target/arm/gtimer.h
> > @@ -15,7 +15,9 @@ enum {
> >       GTIMER_HYP      =3D 2, /* EL2 physical timer */
> >       GTIMER_SEC      =3D 3, /* EL3 physical timer */
>
> Should we rename as GTIMER_SEC_PEL3 for consistency?
>
> >       GTIMER_HYPVIRT  =3D 4, /* EL2 virtual timer */
>
> Also GTIMER_HYP     -> GTIMER_PEL2,
>       GTIMER_HYPVIRT -> GTIMER_VEL2?
>
> > -#define NUM_GTIMERS   5
> > +    GTIMER_SEC_PEL2 =3D 5, /* Secure EL2 physical timer */
> > +    GTIMER_SEC_VEL2 =3D 6, /* Secure EL2 virtual timer */
> > +#define NUM_GTIMERS   7
> >   };
> >
> >   #endif|
>
>

--00000000000014b339062b443dcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">It&#39;s not the context that lacks its the protocol.. lol. =
I wish I was good with words and a genius... oh no wait. It&#39;s easier be=
ing simple..you think.u could find the s<br>
B listers. There&#39;s gotta b a mpatch</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jan 9, 2025, 5:19=E2=80=AFAM Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">On 18/12/24 19:15, Alex Benn=
=C3=A9e wrote:<br>
&gt; When FEAT_SEL2 was implemented the SEL2 timers where missed. This<br>
&gt; shows up when building the latest Hafnium with SPMC_AT_EL=3D2. The<br>
&gt; actual implementation utilises the same logic as the rest of the<br>
&gt; timers so all we need to do is:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 - define the timers and their access functions<br>
&gt;=C2=A0 =C2=A0 - conditionally add the correct system registers<br>
&gt;=C2=A0 =C2=A0 - create a new accessfn as the rules are subtly different=
 to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 existing secure timer<br>
&gt; <br>
&gt; Fixes: e9152ee91c (target/arm: add ARMv8.4-SEL2 system registers)<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;=
<br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank" rel=3D=
"noreferrer">qemu-stable@nongnu.org</a><br>
&gt; Cc: Andrei Homescu &lt;<a href=3D"mailto:ahomescu@google.com" target=
=3D"_blank" rel=3D"noreferrer">ahomescu@google.com</a>&gt;<br>
&gt; Cc: Arve Hj=C3=B8nnev=C3=A5g &lt;<a href=3D"mailto:arve@google.com" ta=
rget=3D"_blank" rel=3D"noreferrer">arve@google.com</a>&gt;<br>
&gt; Cc: R=C3=A9mi Denis-Courmont &lt;<a href=3D"mailto:remi.denis.courmont=
@huawei.com" target=3D"_blank" rel=3D"noreferrer">remi.denis.courmont@huawe=
i.com</a>&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; v1<br>
&gt;=C2=A0 =C2=A0 - add better comments to GTIMER descriptions<br>
&gt;=C2=A0 =C2=A0 - also define new timers for sbsa-ref<br>
&gt;=C2=A0 =C2=A0 - don&#39;t conditionally gate qemu_timer creation on the=
 feature<br>
&gt;=C2=A0 =C2=A0 - take cntvoff_el2 int account for SEC_VEL2 in gt_recalc/=
g_tval_[read|write]<br>
&gt; v2<br>
&gt;=C2=A0 =C2=A0 - rename IRQ to ARCH_TIMER_S_EL2_VIRT_IRQ<br>
&gt;=C2=A0 =C2=A0 - split machine enablement into separate patches<br>
&gt;=C2=A0 =C2=A0 - return CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/bsa.h |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0target/arm/gtimer.h=C2=A0 |=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0target/arm/cpu.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 ++<br>
&gt;=C2=A0 =C2=A0target/arm/helper.c=C2=A0 | 158 ++++++++++++++++++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 =C2=A05 files changed, 169 insertions(+), 1 deletion(-)<br>
<br>
<br>
&gt; diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h<br>
&gt; index de016e6da3..f8f7425a5f 100644<br>
&gt; --- a/target/arm/gtimer.h<br>
&gt; +++ b/target/arm/gtimer.h<br>
&gt; @@ -15,7 +15,9 @@ enum {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GTIMER_HYP=C2=A0 =C2=A0 =C2=A0 =3D 2, /* EL2=
 physical timer */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GTIMER_SEC=C2=A0 =C2=A0 =C2=A0 =3D 3, /* EL3=
 physical timer */<br>
<br>
Should we rename as GTIMER_SEC_PEL3 for consistency?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0GTIMER_HYPVIRT=C2=A0 =3D 4, /* EL2 virtual t=
imer */<br>
<br>
Also GTIMER_HYP=C2=A0 =C2=A0 =C2=A0-&gt; GTIMER_PEL2,<br>
=C2=A0 =C2=A0 =C2=A0 GTIMER_HYPVIRT -&gt; GTIMER_VEL2?<br>
<br>
&gt; -#define NUM_GTIMERS=C2=A0 =C2=A05<br>
&gt; +=C2=A0 =C2=A0 GTIMER_SEC_PEL2 =3D 5, /* Secure EL2 physical timer */<=
br>
&gt; +=C2=A0 =C2=A0 GTIMER_SEC_VEL2 =3D 6, /* Secure EL2 virtual timer */<b=
r>
&gt; +#define NUM_GTIMERS=C2=A0 =C2=A07<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#endif|<br>
<br>
</blockquote></div>

--00000000000014b339062b443dcb--

