Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CDEC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 07:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5KNa-0000dL-4E; Fri, 10 May 2024 03:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s5KNW-0000dA-Qc
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:09:14 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s5KNQ-0000bQ-UJ
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:09:14 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7f82c932858so564613241.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715324945; x=1715929745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=05e6kfPELjdIiB5komuWQQEzsIOEGVInSuH1WtN+4KA=;
 b=JJZ9g+3lLJXkT7GhbPHrZnfexGIxVJIWnAmGnYb6erZpEZvDG1MRRjv3e/uLeREKoc
 e51TNM9YrpPYpSYsiB/Btmk5MeXcCjBmt0vAMv30RfcSsIqm9qZ8jUExIkFtTknGpG+f
 cLWHML9LAX8Z7uY2CC717GbZEYD6JjjMu7OqDHaG5s3uhN4a6eFarIqZkxVueVDPM+yh
 qjCGDmZPRzyIqFcBJ9jb1PGlPrakzHfl82bVlYJN8xtrRFEJNiC2k3bQYfcF7htPbrVz
 OibLtkvbAm1Qgi9xpY69JjYhKWy9TVs7oOmvCgd0ycSfvDACwSq604FzuhXR15MzMNpK
 w/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715324945; x=1715929745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05e6kfPELjdIiB5komuWQQEzsIOEGVInSuH1WtN+4KA=;
 b=iVyQ+ffaU2u7/deazP79DEvAoDtQlk962RisiIJZmq1lGMSVwlV7pcZ5pADRk7jRC6
 aDoWqk3omB2kwaWldVrEasoMDp5NJe4tfquib5eFMsoAz/4m8tkzXgLFChhFP5nU3uU3
 gA0yQYkQeLx9ivtX8owMJK0JQLvIYD882i8CbPmBRdmY6Fn1wEIQjvIvwo3kf/iz7VLj
 2hkqJBN54SlcY3XM1lTydF9wl6SSYO0dXyrOZqGOtIFPY+Oj98BxD7/k4CokMR/uuku2
 yLYMAo2pFS1xecxH66Y93ISjFp1h2O8t6gUEZhLq0uE7fgLlc78ZWBEyJUP+7gwAx/ZP
 oymQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj8t7hCHxgXjErb4RUvpoI/QXU+5a9pQcqsYe5QrZegoGDsFldduJ88r5sWWvbBIPObU6M0eNlZpf/TMB3W1ocRqAogU8=
X-Gm-Message-State: AOJu0YxZs6Onl8K5sJ6zsZEeRdHw1QaSDXs8HM2Qtc3+DFqEDIQHbFIY
 5SKemt60B/Uh2hawoWwcpzX6I8415Vh/2D+9oE5PsBTDNJitka8YkELds73fGfLqxcH3YZP+V/K
 u9a97XGnfba4TuZ6i/9IEFItT3xY=
X-Google-Smtp-Source: AGHT+IFf3hfiFfH2oE67tBkY8UXKV8VN+jilJ+ZwWC4KSCWT0zm4s8nLVRf1shMe2DDxHXQQprTdco6/xC9JjazhNos=
X-Received: by 2002:a05:6102:570d:b0:47c:23b7:f50d with SMTP id
 ada2fe7eead31-48077e5d79cmr1742100137.35.1715324945247; Fri, 10 May 2024
 00:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
 <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
 <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
 <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
 <6fab2d56-84c4-15fa-bcaf-b08f2c8210aa@eik.bme.hu>
In-Reply-To: <6fab2d56-84c4-15fa-bcaf-b08f2c8210aa@eik.bme.hu>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Fri, 10 May 2024 02:08:54 -0500
Message-ID: <CACBuX0R8FowZnK3YCZJTuPhS0uLBr34L2NCa19dLEvyKz_+KTQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000934f806181436c2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x92d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--0000000000000934f806181436c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 3:37=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:

> On Thu, 9 May 2024, Cord Amfmgm wrote:
> > On Thu, May 9, 2024 at 12:48=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org>
> > wrote:
> >
> >> On Wed, 8 May 2024 at 16:29, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >>> On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>>>
> >>>> Your Signed-off-by line does not match the From: line ... could you
> >> please
> >>>> fix this? (see
> >>>>
> >>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
> >>>> , too)
> >>>
> >>>
> >>> I'll submit the new patch request with my pseudonym in the From: and
> >> Signed-off-by: lines, per your request. Doesn't matter to me. However,
> this
> >> arises simply because I don't give gmail my real name -
> >> https://en.wikipedia.org/wiki/Nymwars
> >>
> >> I'm confused now. Of the two names you've used in this
> >> patch (Cord Amfmgm and David Hubbard), are they both
> >> pseudonyms, or is one a pseudonym and one your real name?
> >>
> >>
> > Hi Peter,
> >
> > I am attempting to submit a small patch. For context, I'm getting broad=
er
> > attention now because apparently OHCI is one of the less used component=
s
> of
> > qemu and maybe the review process was taking a while. That's relevant
> > because I wasn't able to get prompt feedback and am now choosing what
> > appears to be the most expeditious approach -- all I want is to get thi=
s
> > patch done and be out of your hair. If Thomas Huth wants me to use a
> > consistent name, have I not complied? Are you asking out of curiosity o=
r
> is
> > there a valid reason why I should answer your question in order to get
> the
> > patch submitted? Would you like to have a friendly chat over virtual
> coffee
> > sometime (but off-list)?
>
> See here:
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
> and also the document linked from there:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docum=
entation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157f#n2=
97


Yeah the policy makes sense. So it sounds like we're all good for that.


>
>
> As for getting the patch reviewed, it may be difficult as the USB
> maintainer is practically absent and has no time for QEMU for a while and
> as OHCI as you said is not odten used there aren't many people who could
> review it. Getting at least the formal stuff out of the way may help
> though to get somebody to try to review the patch.
>
> Regards,
> BALATON Zoltan


I understand. Well, that's unfortunate that the patch is going back on the
backlog. I'll leave it alone then?

There's always the option if anyone has an old enough system that the EHCI
on it has an actual OHCI companion controller, then they can use actual
hardware to validate the behavior. Barring some message saying the patch
has been approved or that someone wants me to rework the patch, I'll leave
this as abandoned.

--0000000000000934f806181436c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 9, 2024 at 3:37=E2=80=AFP=
M BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.=
hu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Thu, 9 May 2024, Cord Amfmgm wrote:<br>
&gt; On Thu, May 9, 2024 at 12:48=E2=80=AFPM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt;&gt; On Wed, 8 May 2024 at 16:29, Cord Amfmgm &lt;<a href=3D"mailto:dma=
mfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt; On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt; wro=
te:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Your Signed-off-by line does not match the From: line ... =
could you<br>
&gt;&gt; please<br>
&gt;&gt;&gt;&gt; fix this? (see<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-pat=
ch.html#patch-emails-must-include-a-signed-off-by-line" rel=3D"noreferrer" =
target=3D"_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch=
.html#patch-emails-must-include-a-signed-off-by-line</a><br>
&gt;&gt;&gt;&gt; , too)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;ll submit the new patch request with my pseudonym in the=
 From: and<br>
&gt;&gt; Signed-off-by: lines, per your request. Doesn&#39;t matter to me. =
However, this<br>
&gt;&gt; arises simply because I don&#39;t give gmail my real name -<br>
&gt;&gt; <a href=3D"https://en.wikipedia.org/wiki/Nymwars" rel=3D"noreferre=
r" target=3D"_blank">https://en.wikipedia.org/wiki/Nymwars</a><br>
&gt;&gt;<br>
&gt;&gt; I&#39;m confused now. Of the two names you&#39;ve used in this<br>
&gt;&gt; patch (Cord Amfmgm and David Hubbard), are they both<br>
&gt;&gt; pseudonyms, or is one a pseudonym and one your real name?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Hi Peter,<br>
&gt;<br>
&gt; I am attempting to submit a small patch. For context, I&#39;m getting =
broader<br>
&gt; attention now because apparently OHCI is one of the less used componen=
ts of<br>
&gt; qemu and maybe the review process was taking a while. That&#39;s relev=
ant<br>
&gt; because I wasn&#39;t able to get prompt feedback and am now choosing w=
hat<br>
&gt; appears to be the most expeditious approach -- all I want is to get th=
is<br>
&gt; patch done and be out of your hair. If Thomas Huth wants me to use a<b=
r>
&gt; consistent name, have I not complied? Are you asking out of curiosity =
or is<br>
&gt; there a valid reason why I should answer your question in order to get=
 the<br>
&gt; patch submitted? Would you like to have a friendly chat over virtual c=
offee<br>
&gt; sometime (but off-list)?<br>
<br>
See here:<br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html#p=
atch-emails-must-include-a-signed-off-by-line" rel=3D"noreferrer" target=3D=
"_blank">https://www.qemu.org/docs/master/devel/submitting-a-patch.html#pat=
ch-emails-must-include-a-signed-off-by-line</a><br>
and also the document linked from there:<br>
<a href=3D"http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60=
d8157f#n297" rel=3D"noreferrer" target=3D"_blank">http://git.kernel.org/cgi=
t/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?=
id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297</a></blockquote><div><br=
></div><div>Yeah the policy makes sense. So it sounds like we&#39;re all go=
od for that.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
<br>
As for getting the patch reviewed, it may be difficult as the USB <br>
maintainer is practically absent and has no time for QEMU for a while and <=
br>
as OHCI as you said is not odten used there aren&#39;t many people who coul=
d <br>
review it. Getting at least the formal stuff out of the way may help <br>
though to get somebody to try to review the patch.<br>
<br>
Regards,<br>
BALATON Zoltan</blockquote><div>=C2=A0<br></div><div>I understand. Well, th=
at&#39;s unfortunate that the patch is going back on the backlog. I&#39;ll =
leave it alone then?</div><div><br></div><div>There&#39;s always the option=
 if anyone has an old enough system that the EHCI on it has an actual OHCI =
companion controller, then they can use actual hardware to validate the beh=
avior. Barring some message saying the patch has been approved or that some=
one wants=C2=A0me to rework the patch, I&#39;ll leave this as abandoned.</d=
iv></div></div>

--0000000000000934f806181436c2--

