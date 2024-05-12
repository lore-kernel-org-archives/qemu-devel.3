Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B609C25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 16:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Bzs-0006RX-0A; Sun, 12 May 2024 12:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s6Bzq-0006RG-PG
 for qemu-devel@nongnu.org; Sun, 12 May 2024 12:24:22 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s6Bzo-0006Yi-LP
 for qemu-devel@nongnu.org; Sun, 12 May 2024 12:24:22 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7f161a3eeb6so1236985241.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715531059; x=1716135859; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ASAhVbWUB/KXmvkwRkIe6IAkWNIqhuV2oon05OBEvmo=;
 b=ZbCPAijZzk+FlZuKovqRROUn9g6+gyBta6SPa+bkj0B7XfRyRVdns29WoLZiYU+5D8
 6JJsXp77PEoqKCmGcxgJ96cdV9ZUYMqgQS50BN54TOGwfXOICg345DZpv97Bf3YDCnPe
 gbEggPMHFbxIS72dS/Ge9LuugBUyRJc2laaBFz/dAx/LevtaI6QEFsiX++OIW/6H9m4b
 XKl1MF+BuHwpppjEu/tM10iHZlf9/85eTd84yCaeyex7AYyOMVNw6hVFeGI13tjOPu2W
 SbDT61ERDQNxrzEmudQ3lG122svtmqidKtm3r6zrcAlUtALqZEMxSUzh3ib6pw8zQpwZ
 AmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715531059; x=1716135859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASAhVbWUB/KXmvkwRkIe6IAkWNIqhuV2oon05OBEvmo=;
 b=LEkiJ9sUHgHmHq8wSgVX8ttmhOxgWQqs8Dlf3gaBIgMoxhugbAjT11ysji9/GYQtF+
 wdsgzgk8awgCFMC/xlLQMynUg0sYczHDpA9XVzlkTwwtNawFSR78qHOIun4zU1vaWDyg
 KPeNhb17pEcNCnU//anzmdLoy04kQOvkJjMi8keIOW9K0u5Y16023oazkdKh2cUkR7tR
 hpy1mEskW11Hr3pMKHSysWilHqvrxVepd2p/rLA2OcIh7dwuDO8Y6536Cgt23ivcG0Ba
 prBVu8gntygwY3iHWLHzyEm1pEmgBLUzjeZPL4kKN93hBrZX7idkoB/9qZt/NNBXpp6U
 d+Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOFzcoorE5XfrPT0apSY2KSZQBxgpMvnavEa1eET0GON5hg7tDQZr7vMsZNp7ZZvGr1QH7p2Hy8e+GSRdYjN8bf4X19no=
X-Gm-Message-State: AOJu0YzkJEAEmuJIjwrF68RwV5DjGo4lCYX6BCOOYZPwgCBmf/K2wW1J
 0VQno7P9X88RmhSG3dYZbPQAQ7giUoCOq8eiBsV+xya2EF+mugWe45RIM2Oxsq4Siiq9c6E8t/h
 9TToEo1I2lTbya2GQu1J1owudjx0=
X-Google-Smtp-Source: AGHT+IGASzzH87QgfXtt5Bau/yyf1KkZkDz+cj7tqjc4D6oH/Tz2bV51qnJJ7Apb4nBO/yw1SQwAHIsiMwx41M069lA=
X-Received: by 2002:a05:6102:41a8:b0:47b:6fb1:5299 with SMTP id
 ada2fe7eead31-48077e03423mr7770932137.14.1715531058735; Sun, 12 May 2024
 09:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
 <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
 <8dadea4d-ab16-4102-93e6-61559fb5b00c@linaro.org>
 <CACBuX0QepgcGW=X9gYZzY9_9voZT1L+vstfqn_9FQmvpG0-sXQ@mail.gmail.com>
 <CAFEAcA8sF4C-r2+Es4tqzXa_HsNVcMizN+eMCN2QM7guZPPYsg@mail.gmail.com>
 <CACBuX0SbF_eMT4XsDZsVVZSYF6fNgtX2fJFsahaThELoyGA9Jw@mail.gmail.com>
 <CAFEAcA-4OynucjRAHQEUkwqKd=mGtVmUZako-K3crinFEiTRYg@mail.gmail.com>
In-Reply-To: <CAFEAcA-4OynucjRAHQEUkwqKd=mGtVmUZako-K3crinFEiTRYg@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Sun, 12 May 2024 11:24:07 -0500
Message-ID: <CACBuX0TS4cp+3w=+dTxOCKtq4-eg2kjwH7bN6A2FqO2o2FvpgQ@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005b726e061844336a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=dmamfmgm@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000005b726e061844336a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 5:25=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 9 May 2024 at 19:17, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >
> >
> >
> > On Thu, May 9, 2024 at 12:48=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >>
> >> On Wed, 8 May 2024 at 16:29, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> >> > On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth <thuth@redhat.com=
> wrote:
> >> >>
> >> >> Your Signed-off-by line does not match the From: line ... could you
> please
> >> >> fix this? (see
> >> >>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emai=
ls-must-include-a-signed-off-by-line
> >> >> , too)
> >> >
> >> >
> >> > I'll submit the new patch request with my pseudonym in the From: and
> Signed-off-by: lines, per your request. Doesn't matter to me. However, th=
is
> arises simply because I don't give gmail my real name -
> https://en.wikipedia.org/wiki/Nymwars
> >>
> >> I'm confused now. Of the two names you've used in this
> >> patch (Cord Amfmgm and David Hubbard), are they both
> >> pseudonyms, or is one a pseudonym and one your real name?
> >>
> >
> > Hi Peter,
> >
> > I am attempting to submit a small patch. For context, I'm getting
> broader attention now because apparently OHCI is one of the less used
> components of qemu and maybe the review process was taking a while. That'=
s
> relevant because I wasn't able to get prompt feedback and am now choosing
> what appears to be the most expeditious approach -- all I want is to get
> this patch done and be out of your hair. If Thomas Huth wants me to use a
> consistent name, have I not complied? Are you asking out of curiosity or =
is
> there a valid reason why I should answer your question in order to get th=
e
> patch submitted? Would you like to have a friendly chat over virtual coff=
ee
> sometime (but off-list)?
> >
> > If you could please clarify I'm sure the answer is an easy one.
>
> I'm asking because our basic expected position is "commits
> are from the submitter's actual name, not a pseudonym". Obviously
> we can't tell if people use a consistent plausible looking
> pseudonym whether that corresponds to their real-world name
> or not, but if you have a real name you're happy to attach
> to this patch and are merely using a pseudonym for Google
> email, then the resubmit of this patch didn't seem to me
> to do that. i.e. I was expecting the change to be "make the
> patch From: match the Signed-off-by line", not "make the
> Signed-off-by line match the patch From:". (For avoidance
> of doubt, we don't care about the email From: line, which
> is distinct from the commit message From: i.e. author.)
> So I was essentially asking "did you mean to do this, or did
> you misunderstand what we were asking for?".
>

I think that is what caught me off guard. I'm learning how to submit the
correctly formatted patch. I would very much like to disconnect the patch
From: from the email From: line.


> On the question of the actual patch, I'll try to get to it
> if Gerd doesn't first (though I have a conference next week
> so it might be the week after). The main thing I need to chase
> down is whether it's OK to call usb_packet_addbuf() with a
> zero length or not.
>

Good catch. I have no problem modifying the patch with better logic for a
zero length packet.

--0000000000005b726e061844336a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 11, 2024 at 5:25=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Thu, 9 May 2024 at 19:17, Cord Amfmgm &lt;<a href=3D"mailt=
o:dmamfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, May 9, 2024 at 12:48=E2=80=AFPM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, 8 May 2024 at 16:29, Cord Amfmgm &lt;<a href=3D"mailto:dma=
mfmgm@gmail.com" target=3D"_blank">dmamfmgm@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; On Wed, May 8, 2024 at 3:45=E2=80=AFAM Thomas Huth &lt;<a hre=
f=3D"mailto:thuth@redhat.com" target=3D"_blank">thuth@redhat.com</a>&gt; wr=
ote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Your Signed-off-by line does not match the From: line ...=
 could you please<br>
&gt;&gt; &gt;&gt; fix this? (see<br>
&gt;&gt; &gt;&gt; <a href=3D"https://www.qemu.org/docs/master/devel/submitt=
ing-a-patch.html#patch-emails-must-include-a-signed-off-by-line" rel=3D"nor=
eferrer" target=3D"_blank">https://www.qemu.org/docs/master/devel/submittin=
g-a-patch.html#patch-emails-must-include-a-signed-off-by-line</a><br>
&gt;&gt; &gt;&gt; , too)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;ll submit the new patch request with my pseudonym in th=
e From: and Signed-off-by: lines, per your request. Doesn&#39;t matter to m=
e. However, this arises simply because I don&#39;t give gmail my real name =
- <a href=3D"https://en.wikipedia.org/wiki/Nymwars" rel=3D"noreferrer" targ=
et=3D"_blank">https://en.wikipedia.org/wiki/Nymwars</a><br>
&gt;&gt;<br>
&gt;&gt; I&#39;m confused now. Of the two names you&#39;ve used in this<br>
&gt;&gt; patch (Cord Amfmgm and David Hubbard), are they both<br>
&gt;&gt; pseudonyms, or is one a pseudonym and one your real name?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Hi Peter,<br>
&gt;<br>
&gt; I am attempting to submit a small patch. For context, I&#39;m getting =
broader attention now because apparently OHCI is one of the less used compo=
nents of qemu and maybe the review process was taking a while. That&#39;s r=
elevant because I wasn&#39;t able to get prompt feedback and am now choosin=
g what appears to be the most expeditious approach -- all I want is to get =
this patch done and be out of your hair. If Thomas Huth wants me to use a c=
onsistent name, have I not complied? Are you asking out of curiosity or is =
there a valid reason why I should answer your question in order to get the =
patch submitted? Would you like to have a friendly chat over virtual coffee=
 sometime (but off-list)?<br>
&gt;<br>
&gt; If you could please clarify I&#39;m sure the answer is an easy one.<br=
>
<br>
I&#39;m asking because our basic expected position is &quot;commits<br>
are from the submitter&#39;s actual name, not a pseudonym&quot;. Obviously<=
br>
we can&#39;t tell if people use a consistent plausible looking<br>
pseudonym whether that corresponds to their real-world name<br>
or not, but if you have a real name you&#39;re happy to attach<br>
to this patch and are merely using a pseudonym for Google<br>
email, then the resubmit of this patch didn&#39;t seem to me<br>
to do that. i.e. I was expecting the change to be &quot;make the<br>
patch From: match the Signed-off-by line&quot;, not &quot;make the<br>
Signed-off-by line match the patch From:&quot;. (For avoidance<br>
of doubt, we don&#39;t care about the email From: line, which<br>
is distinct from the commit message From: i.e. author.)<br>
So I was essentially asking &quot;did you mean to do this, or did<br>
you misunderstand what we were asking for?&quot;.<br></blockquote><div><br>=
</div><div>I think that is what caught me off guard. I&#39;m learning how t=
o submit the correctly formatted patch. I would very much like to disconnec=
t the patch From: from the email From: line.</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
On the question of the actual patch, I&#39;ll try to get to it<br>
if Gerd doesn&#39;t first (though I have a conference next week<br>
so it might be the week after). The main thing I need to chase<br>
down is whether it&#39;s OK to call usb_packet_addbuf() with a<br>
zero length or not.<br></blockquote><div><br></div><div>Good catch. I have =
no problem modifying the patch with better logic for a zero length packet.=
=C2=A0</div></div></div>

--0000000000005b726e061844336a--

