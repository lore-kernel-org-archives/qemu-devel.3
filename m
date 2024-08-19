Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AFBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 07:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfwUf-0004dJ-VC; Mon, 19 Aug 2024 03:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sfwUP-0004b0-6h
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 03:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sfwUN-00007O-Gm
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 03:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724051257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q4jXAUoby86Yj2Sm+cQ4i6IDA2VmVkZBmAdE06nByQo=;
 b=MLdzDUeDffgqoz6V5EunVW7wTDMPDOxvAnVUyDyhrEcwIhO5oyaIgB8sYkS0nlxGCipspw
 aFKBkVyC5wDAoI+fnD0mJZEn71Rfm78ZLJm7Hmj5UDj71Z3lv1i074aD/tLzjHOzOPKLg9
 2YRU7j88f1rv9uMu2WDw3TWMFRPlReA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-yy5TUcNqPZG2PXA0nMNxxQ-1; Mon, 19 Aug 2024 03:07:34 -0400
X-MC-Unique: yy5TUcNqPZG2PXA0nMNxxQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e13c4519ed6so2812650276.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 00:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724051254; x=1724656054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q4jXAUoby86Yj2Sm+cQ4i6IDA2VmVkZBmAdE06nByQo=;
 b=ksgavbEY8q3pYw6oz1mOZDDhf//429RBzK4xIROUy6gXMtg4VGQGb/Km0m31LIU1F1
 Xfwn6ikzMBcWVt/nmgut+9VdOwSDQXvyRU/dxBEe9y3LjbIPOgzt3g95K1amWF7+sdCt
 ASICNedKTUmEIlTeZInssRlQvShMbyZGdcQzTX1gMSyy8rajXJ6Qa/g0x1iClkwgzTEw
 xRCC2VBiawQA0YsglMuZspJ6JpBxwd/vP6+opEzHs4kRqFK/XKMFWfv3PjjVc6knyedi
 odJot8jyKYGhqe6RKCKPlJZUWfOtdyci0wMOUPQ+yPJbLd7WG1SQWnhIaPFl0F1gcF0p
 AvNg==
X-Gm-Message-State: AOJu0YwYBHF7INSEeYgv7cVDeVE61Kl+QOUoFsHFB0gkBGLhlCDvpeu3
 LNaCGJVux7PW41+/n1D8mNrLJvbUds+Vj+g5Aw4I7GAomBcugiDKnPD46uZwOWiVaskoLn9Z8au
 O75LnSqQMu55r8eFJ9sgw/8i3ErcTVE0c6nGvIuJNAJkZkcpqToCn6OOHoPZ3QgMXEzdTg6Vsyj
 617E5xiy61p+UZI/pblbzlSf7U3Ro=
X-Received: by 2002:a05:6902:13cf:b0:e0e:869b:bea with SMTP id
 3f1490d57ef6-e11ad365e06mr7078960276.24.1724051254311; 
 Mon, 19 Aug 2024 00:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExUjpuCFs+ngL6AxHPWmapuRwRyRE1u2/JP4bxjtNecV/5mleYAlUoGp2PL0dpPSUE0G428Rr7qFyc5pHhiUs=
X-Received: by 2002:a05:6902:13cf:b0:e0e:869b:bea with SMTP id
 3f1490d57ef6-e11ad365e06mr7078950276.24.1724051253935; Mon, 19 Aug 2024
 00:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240723070251.25575-1-kkostiuk@redhat.com>
 <20240723070251.25575-26-kkostiuk@redhat.com>
 <CAFEAcA831S0wGbyLwDK7yVeEoi1SFPD7gpYribNqP6AmyQHN5A@mail.gmail.com>
 <CAPMcbCpfP-XX0RsTerdrSunb9Z772efCGKf5h2ju7JQdygvDtA@mail.gmail.com>
 <CAFEAcA9CyhYRZz0kK_oB6WKQF-3EZsEg88mdFWoDzQoF6ZfYAw@mail.gmail.com>
 <CAFEAcA9v2An2=P3aTNbv+z_a2nk6xQ+f-b4B6Ci0rWO2Q=C18A@mail.gmail.com>
In-Reply-To: <CAFEAcA9v2An2=P3aTNbv+z_a2nk6xQ+f-b4B6Ci0rWO2Q=C18A@mail.gmail.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 19 Aug 2024 10:07:22 +0300
Message-ID: <CAPMcbCoc2=CuF2iuiePHF_UMedVnqHLiyocLEk5PrhGmsVcAwA@mail.gmail.com>
Subject: Re: [PULL v2 25/25] qga/linux: Add new api 'guest-network-get-route'
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Dehan Meng <demeng@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000090ddc7062003f682"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000090ddc7062003f682
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:18=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 29 Jul 2024 at 10:35, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > On Mon, 29 Jul 2024 at 08:40, Konstantin Kostiuk <kkostiuk@redhat.com>
> wrote:
> > >
> > > Hi Peter,
> > >
> > > How to see the full coverity report? In
> https://gitlab.com/qemu-project/qemu/-/artifacts, I see only job.log
> > > Do you expect to fix these errors for the 9.1 release?
> >
> > Coverity errors are in https://scan.coverity.com/projects/qemu
> >  -- you can ask for an account with the project if you want
> > to see them directly. But I think you have the information
> > you need in this email: the actual coverity issue isn't
> > much more informative.
> >
> > > Do you expect to fix these errors for the 9.1 release?
> >
> > No, I post these emails to inform the people responsible
> > for the original commits about the problem so that they
> > can provide fixes -- after all, it's the original author
> > that knows most about the code and how to test it.
>
> Konstantin, are you or Dehan planning to write fixes
> for these bugs?
>

Hi Peter,

Yes, we plan to fix these bugs for the 9.2 release.

Best Regards,
Konstantin Kostiuk.


>
> thanks
> -- PMM
>
>

--00000000000090ddc7062003f682
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 15, 2024 at 5:18=E2=80=AF=
PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, 29 Jul 2024 at 10:35, Peter Maydell &lt;<a href=3D"ma=
ilto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</=
a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, 29 Jul 2024 at 08:40, Konstantin Kostiuk &lt;<a href=3D"mailto=
:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<=
br>
&gt; &gt;<br>
&gt; &gt; Hi Peter,<br>
&gt; &gt;<br>
&gt; &gt; How to see the full coverity report? In <a href=3D"https://gitlab=
.com/qemu-project/qemu/-/artifacts" rel=3D"noreferrer" target=3D"_blank">ht=
tps://gitlab.com/qemu-project/qemu/-/artifacts</a>, I see only job.log<br>
&gt; &gt; Do you expect to fix these errors for the 9.1 release?<br>
&gt;<br>
&gt; Coverity errors are in <a href=3D"https://scan.coverity.com/projects/q=
emu" rel=3D"noreferrer" target=3D"_blank">https://scan.coverity.com/project=
s/qemu</a><br>
&gt;=C2=A0 -- you can ask for an account with the project if you want<br>
&gt; to see them directly. But I think you have the information<br>
&gt; you need in this email: the actual coverity issue isn&#39;t<br>
&gt; much more informative.<br>
&gt;<br>
&gt; &gt; Do you expect to fix these errors for the 9.1 release?<br>
&gt;<br>
&gt; No, I post these emails to inform the people responsible<br>
&gt; for the original commits about the problem so that they<br>
&gt; can provide fixes -- after all, it&#39;s the original author<br>
&gt; that knows most about the code and how to test it.<br>
<br>
Konstantin, are you or Dehan planning to write fixes<br>
for these bugs?<br></blockquote><div><br></div><div>Hi Peter,</div><div><br=
></div><div>Yes, we plan to fix these bugs for the 9.2 release.<br></div><d=
iv><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></di=
v></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div>

--00000000000090ddc7062003f682--


