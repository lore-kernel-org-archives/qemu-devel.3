Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF3E6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 19:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snNGK-0003sl-Tl; Sun, 08 Sep 2024 15:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jkurape@gmail.com>) id 1snNGE-0003rS-Ig
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:07:47 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jkurape@gmail.com>) id 1snNGB-0005Hp-It
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 15:07:46 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6d6e2b2fbc4so35203617b3.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725822462; x=1726427262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0m6j7NBzgQoAt6NzAbUpmSn1A0BXhs9BmH5wRcRWjNU=;
 b=VT0VsXPccobYVmICNe2OPyUJNVJNM55cqyd/A4ZJJKWUJvZRBPus5/GVzx8aIP4+QX
 NQBnwXvUI20GUHB8lIB8NptIetSxzCv0I1zJUvW5DBe3Oa/TYAoSoOA2l2NmWkUi/nlb
 7EZZORtbbM/kxpExhj5VZNwvi7YcYhLiWBVE0Zmh7gXcXzTK3+bhjydzOXK2bYWTHFNf
 HA8SWgaVz5vyPg2NbCrydeOVFJEmPXuMRjlR6+oGwXKjcBBIsNvhoVJ8EXGU5lXc3if9
 y6LQ25Y83ZaF4uIzKMGXuaeRBq3OFfqC0X+ZeK/IcoQvataMfoKlHGRFO83NnfB3I2Mc
 5EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725822462; x=1726427262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0m6j7NBzgQoAt6NzAbUpmSn1A0BXhs9BmH5wRcRWjNU=;
 b=jW89CbYoNk4Y5M+1me/A4TMaAde8SvBgslZKwoN9/YkxgVdpZf28UR480r2lLbWhR2
 K2Wy0MAgeGP570wHMhpbwuyZuRAlHbmuXxAcyznjw0NrvQULlVfxs8xtgd9Btk+hsl9a
 HeiCJstTNllKo68i/FPlpvpESBCMjFmRl4V8DvBaWmzjvGhco9mKYQD3y5V/lrvDENBh
 FcoHNkE3nuuayxinCbJjmeF0L/7wY+qJ5CnfFcpSJP+h+Htc8/R/SCDIE2vpD6ek4XGg
 Zm4en7aRQ91JLV19B5wOy5ac2ENscLnwmbmWcbpgT0mOosUoAU82Uazpc5h7guFL5EKe
 +o5g==
X-Gm-Message-State: AOJu0YwxRL+p3+asjIkcAHYtDdG7d5lNcTxwoWAXxcZogQ3qocsJ7Vrp
 gCKRDc25YdOzAsu3KWGNcO9V+CGEU0brUslQ9/E7ZsTc/5CHhUMkJuspykM38bYYkbqWIO47DPn
 u4ZkXunexyzYSZEdmWYMrTbptDw==
X-Google-Smtp-Source: AGHT+IFjxJiki275b98C9W+qkRYQ+dt1Fb7kZHA/6S6npWlkJXFfB/Mm1hsIXh9Kqa67iBdbB7Vc99wX0eq+pb3WHsM=
X-Received: by 2002:a05:690c:893:b0:6d4:b774:e503 with SMTP id
 00721157ae682-6db45276285mr108937307b3.41.1725822462126; Sun, 08 Sep 2024
 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALcAbx6pnqwB2TRJMOGu10ZkY-6STOJX81ZGeUNarfXwV+fPvQ@mail.gmail.com>
 <jhkm8.uh7rl3q19uua@linaro.org>
In-Reply-To: <jhkm8.uh7rl3q19uua@linaro.org>
From: Joseph Kurape <jkurape@gmail.com>
Date: Sun, 8 Sep 2024 20:07:30 +0100
Message-ID: <CALcAbx7soPaL30DbYVcLkGLxfzxzbXGVGO0dj2609C_tnKK8zg@mail.gmail.com>
Subject: Re: Contributing to Qemu
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ccfaf50621a05a1e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=jkurape@gmail.com; helo=mail-yw1-x1134.google.com
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

--000000000000ccfaf50621a05a1e
Content-Type: text/plain; charset="UTF-8"

Thank you, Manos.

I'm not discouraged by the difficulty. I guess I just didn't know where to
start from. Thanks for the direction.


On Sun, 08 Sept 2024, 09:51 Manos Pitsidianakis, <
manos.pitsidianakis@linaro.org> wrote:

> On Sun, 08 Sep 2024 10:28, Joseph Kurape <jkurape@gmail.com> wrote:
> >Hello,
> >
> >I'm new to open-source, but I've learned C and Python.
> >
> >I've read the 'Getting Started' guide, but aside from signing up for the
> >mailing list and getting the source code, it doesn't provide much
> direction
> >for beginners.
> >
> >I'm looking for somewhere I can contribute. Could any maintainer suggest
> >any issue they need fixing or offer general directions on the best way to
> >get started?
>
> Hello Joseph!
>
> First, the bad news: QEMU is a sophisticated and complicated project,
> and I would not recommend it as the first foray of serious programming
> to most people. But the good news is, it is still possible to contribute
> without being an expert simply because QEMU is composed of many
> different things.
>
> The usual advice is to take a look at the issues labelled as
> "Bite-Sized" on our Issue tracker:
>
>
> https://gitlab.com/qemu-project/qemu/-/issues/?sort=created_date&state=opened&label_name%5B%5D=Bite+Sized&first_page_size=50
>
> Take your time looking at each of them and you can choose something that
> looks approachable to you.
>
> Note: I see that in many issues people say they want to contribute and
> ask for the issue to be assigned to them- no need to do that! Focus on
> writing down your solution and sending it to the list while following
> the "submitting a patch" docs:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html
>
> If you have any kind of technical question you should ask on IRC, if you
> happen on any developer being online at the same time as you, or on the
> list. Do not ask people in private because not only will less people see
> your question, but most QEMU maintainers only pay attention to the
> mailing list for QEMU related discussion.
>
> If you have any more questions feel free to ask!
>
>
>

--000000000000ccfaf50621a05a1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><p dir=3D"ltr">Thank you, Manos.</p>
<p dir=3D"ltr">I&#39;m not discouraged by the difficulty. I guess I just di=
dn&#39;t know where to start from. Thanks for the direction.=C2=A0</p><br>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun=
, 08 Sept 2024, 09:51 Manos Pitsidianakis, &lt;<a href=3D"mailto:manos.pits=
idianakis@linaro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidiana=
kis@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Su=
n, 08 Sep 2024 10:28, Joseph Kurape &lt;<a href=3D"mailto:jkurape@gmail.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">jkurape@gmail.com</a>&gt;=
 wrote:<br>
&gt;Hello,<br>
&gt;<br>
&gt;I&#39;m new to open-source, but I&#39;ve learned C and Python.<br>
&gt;<br>
&gt;I&#39;ve read the &#39;Getting Started&#39; guide, but aside from signi=
ng up for the<br>
&gt;mailing list and getting the source code, it doesn&#39;t provide much d=
irection<br>
&gt;for beginners.<br>
&gt;<br>
&gt;I&#39;m looking for somewhere I can contribute. Could any maintainer su=
ggest<br>
&gt;any issue they need fixing or offer general directions on the best way =
to<br>
&gt;get started?<br>
<br>
Hello Joseph!<br>
<br>
First, the bad news: QEMU is a sophisticated and complicated project, <br>
and I would not recommend it as the first foray of serious programming <br>
to most people. But the good news is, it is still possible to contribute <b=
r>
without being an expert simply because QEMU is composed of many <br>
different things.<br>
<br>
The usual advice is to take a look at the issues labelled as <br>
&quot;Bite-Sized&quot; on our Issue tracker:<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/?sort=3Dcreated_da=
te&amp;state=3Dopened&amp;label_name%5B%5D=3DBite+Sized&amp;first_page_size=
=3D50" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://g=
itlab.com/qemu-project/qemu/-/issues/?sort=3Dcreated_date&amp;state=3Dopene=
d&amp;label_name%5B%5D=3DBite+Sized&amp;first_page_size=3D50</a><br>
<br>
Take your time looking at each of them and you can choose something that <b=
r>
looks approachable to you.<br>
<br>
Note: I see that in many issues people say they want to contribute and <br>
ask for the issue to be assigned to them- no need to do that! Focus on <br>
writing down your solution and sending it to the list while following <br>
the &quot;submitting a patch&quot; docs: <br>
<a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch.html" =
rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://www.qemu=
.org/docs/master/devel/submitting-a-patch.html</a><br>
<br>
If you have any kind of technical question you should ask on IRC, if you <b=
r>
happen on any developer being online at the same time as you, or on the <br=
>
list. Do not ask people in private because not only will less people see <b=
r>
your question, but most QEMU maintainers only pay attention to the <br>
mailing list for QEMU related discussion.<br>
<br>
If you have any more questions feel free to ask!<br>
<br>
<br>
</blockquote></div>
</div></div>

--000000000000ccfaf50621a05a1e--

