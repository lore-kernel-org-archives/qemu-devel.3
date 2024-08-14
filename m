Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B66C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 21:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seLIa-0004Gm-CL; Wed, 14 Aug 2024 17:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1seLIZ-0004GJ-Li
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 17:12:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1seLIU-0002QD-HU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 17:12:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-371893dd249so16804f8f.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723669964; x=1724274764; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A1lkVNa+r2qGdoXm7g5nCq8nXlcVB0boBpujh7QU99Y=;
 b=4S6CCRWB8RC4Yx9esFemHDllGlOUfY7aDJ78EgdZza0hBTLlgt2SsdYnerznRX6a8O
 7HUThNr+n1tFIbF0B9GPdzpHBt+5hcIFvTXoof4UjiQf3AUb51jQRMLw7S+V2cD/4bfF
 vMAClzBBq1uaEjlkJOJrO/EElUZRG4XtT21CC73jA0afXJi+oCPPz+jBCsB/n92m3ity
 BC35C7EOYikzkJJ12t2OnWWCyQPQUEaEuS4RToHd735L9OL+DS72bG1fNoMYViv7Ke7l
 HUWa8Pt+ovPj0Bvqi5TmaZfIQixvUxTyCfACkgOuKPd/5mmMiiiZzwmSEWC6uYq9kM++
 wr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723669964; x=1724274764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A1lkVNa+r2qGdoXm7g5nCq8nXlcVB0boBpujh7QU99Y=;
 b=snuIKjE2Pc+IX5VMafHJoeL+siqSEE0COsuGYuKzz1Nt0e4WbF8f4ouwMiQcp0TEgC
 fz5tUiSTrl3Ef2ehVjtesfWKEzyEjDA0eiONSvQs6HGENpIop5eHRwc3OTIm/gcvE2I0
 BaiwB3MPWY5rj0cCN//97XcJaLSSQly1WXmE/wpeh0Asd8B+OX8CVZqT1hOKhF0y24Hk
 zOhWvniAF7Yx6/P0BHpPHh2eLrTH9IvmaMAV0UKdHyVWkucliYXiGiK0011W5IfIs1BQ
 FO6leMgVg3/iOSCATajfPJGiRr2zGULPEOAQQnWPIyQqbF3kDdm98ihXkyNcEGOYyb+b
 9Kjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqb4eg88q/UDK1QDr/6ahidljmn9F/sUFig/BDUJZ9sLLpks65my9TuqN0fWqMEsYdOif+vicct+LZSYhADS6t2DDZSjE=
X-Gm-Message-State: AOJu0Yxwt6+Q87II+TSIZzHjCK5q662eZTZNDQmAGxEu/CwbxPR8wXAy
 z30aug1zZkOnakDwRBQtoy5G4XpQwDV05xdQx5Asz7ETO+GOqpLi7QfROr8dDLxqQ4ugZ5+7WDt
 4az8kcOnJXASuQJt6NA9uA9xMIWxYk/Fw+0fH
X-Google-Smtp-Source: AGHT+IGdlwznpHWE9Ctu13Z6ehFUWbEehuqT0G6nDc85ePg050eiwyK8dX6xStK+hZx9y0//p0crx0SZG6aHZz/Kpnw=
X-Received: by 2002:a05:6000:10d:b0:368:7943:146f with SMTP id
 ffacd0b85a97d-37177797511mr2575335f8f.26.1723669963755; Wed, 14 Aug 2024
 14:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
 <20240627003134.3447175-1-rkir@google.com>
 <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
 <CAOGAQepLGTY-92So1arNZWjg9m+HZ8AjZ28Gsscm2ai5sj1AMQ@mail.gmail.com>
 <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
 <CAOGAQeo+DZpE=6xEeUWUEkqSwYgturQ9QzXyzNNt7QfrFqea-Q@mail.gmail.com>
In-Reply-To: <CAOGAQeo+DZpE=6xEeUWUEkqSwYgturQ9QzXyzNNt7QfrFqea-Q@mail.gmail.com>
From: Patrick Leis <venture@google.com>
Date: Wed, 14 Aug 2024 14:12:32 -0700
Message-ID: <CAO=notwaOEkXK1PN679=1qTSnAh1R_f9kkRAF+ykLBij2nqy9A@mail.gmail.com>
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: Roman Kiryanov <rkir@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, jansene@google.com,
 jpcottin@google.com, mett@google.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e736e3061fab2f27"
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=venture@google.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000e736e3061fab2f27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:55=E2=80=AFAM Roman Kiryanov <rkir@google.com> w=
rote:

> Paolo, thank you for your comments.
>
> On Thu, Jun 27, 2024 at 10:16=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om>
> wrote:
> > I think the easiest options would be:
> >
> > 1) if possible, allocate the timer and the callbackState statically in
> > the device.
>
> I think this assumption is not good for both QEMU and us.
>
> > 2) use "aio_wait_bh_oneshot(qemu_get_aio_context(), [](void
> > *opaque){}, NULL);" after timer_del(). You can also put the timer and
> > the callbackState in a RAII wrapper, so that aio_wait_bh_oneshot() is
> > executed when the RAII wrapper is destructed
>
> My understanding is that this will work as a fence waiting for all
> timers to finish. If so, maybe there is a value to put it into QEMU
> (as times_joins() or even as timer_join(QEMUTimer *ts)) if one day
> you decide to implement it in a more efficient way?
>
> > Another thing that you could do is to use a shared_ptr<> for the
> > timer+callbackState combo, and pass a weak_ptr<> to the timer. Then:
> >
> > - at the beginning of the timer, you upgrade the weak_ptr with lock()
> > and if it fails, return
> >
> > I'm not sure how you'd pass the weak_ptr/shared_ptr to a callback
>
> I suspect this is not possible in plain C++ without modifying QEMU or
> code generating at runtime.
>
> I would go with your aio_wait_bh_oneshot suggestion. Please consider
> adding it to QEMU as I pointed above. I can send a patch.
>

Hey - this is an important race condition to resolve, can we get some
attention back on this patchset please.  It's pressing.

Patrick

--000000000000e736e3061fab2f27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 27, 2024 at 10:55=E2=80=
=AFAM Roman Kiryanov &lt;<a href=3D"mailto:rkir@google.com">rkir@google.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Paolo, thank you for your comments.<br>
<br>
On Thu, Jun 27, 2024 at 10:16=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailt=
o:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:=
<br>
&gt; I think the easiest options would be:<br>
&gt;<br>
&gt; 1) if possible, allocate the timer and the callbackState statically in=
<br>
&gt; the device.<br>
<br>
I think this assumption is not good for both QEMU and us.<br>
<br>
&gt; 2) use &quot;aio_wait_bh_oneshot(qemu_get_aio_context(), [](void<br>
&gt; *opaque){}, NULL);&quot; after timer_del(). You can also put the timer=
 and<br>
&gt; the callbackState in a RAII wrapper, so that aio_wait_bh_oneshot() is<=
br>
&gt; executed when the RAII wrapper is destructed<br>
<br>
My understanding is that this will work as a fence waiting for all<br>
timers to finish. If so, maybe there is a value to put it into QEMU<br>
(as times_joins() or even as timer_join(QEMUTimer *ts)) if one day<br>
you decide to implement it in a more efficient way?<br>
<br>
&gt; Another thing that you could do is to use a shared_ptr&lt;&gt; for the=
<br>
&gt; timer+callbackState combo, and pass a weak_ptr&lt;&gt; to the timer. T=
hen:<br>
&gt;<br>
&gt; - at the beginning of the timer, you upgrade the weak_ptr with lock()<=
br>
&gt; and if it fails, return<br>
&gt;<br>
&gt; I&#39;m not sure how you&#39;d pass the weak_ptr/shared_ptr to a callb=
ack<br>
<br>
I suspect this is not possible in plain C++ without modifying QEMU or<br>
code generating at runtime.<br>
<br>
I would go with your aio_wait_bh_oneshot suggestion. Please consider<br>
adding it to QEMU as I pointed above. I can send a patch.<br></blockquote><=
div><br></div><div>Hey - this is an important race condition to resolve, ca=
n we get some attention back on this patchset please.=C2=A0 It&#39;s pressi=
ng.</div><div><br></div><div>Patrick</div><div>=C2=A0</div></div></div>

--000000000000e736e3061fab2f27--

