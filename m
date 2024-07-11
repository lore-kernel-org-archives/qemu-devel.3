Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E88C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 16:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRwbK-0003QB-K8; Thu, 11 Jul 2024 12:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRwbI-0003Pf-Om
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:24:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <halouworls@gmail.com>)
 id 1sRwbF-0005Vf-6l
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 12:24:55 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58d24201934so1872826a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720715090; x=1721319890; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kQBJiIXPhFZfoZbBDwkaEOTpbGMzOzBLebN5LNTauTI=;
 b=Poo7Zr9M+YW9ZwC3zEtK0+dQR33nZ5sKpX0MlB4vhoZRMNtJ4gJUinqszqxbDZtHi5
 7SHBHXetzpOz8pOGx3I49tGA2nIYwiQ11v6purSwq6nByllm9OM/byp3Mvxh0PxxlxfH
 fnEZdxYIq33a7247pnewivfx01kRCugi2x/0OC+cgxSsCM6jxyD6dhrM2Eg2kP6hutdh
 masMtmI6vwi22Tj07xp6VhbFSOu+7k5iDMjqmUH6T+JEd8rMkcMMuTShe+zhYxlGICsP
 R0+cMCwYMZGK+nuGlwihw0/fozsAaz8yLd0G5yZjqjigOeqIyPyDpd3ztGUDE27yyRm/
 SGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720715090; x=1721319890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQBJiIXPhFZfoZbBDwkaEOTpbGMzOzBLebN5LNTauTI=;
 b=wHKIO00emcJfNWJufzwcZRkCRQV6rtKJE/modFYZ1nh6CEHZLIRgt0JazaA232BVTW
 h1z6elciv44BXw2hfhk4KfsJHH3TqqXuv50/lD+RdzNMNUEYlXgkw+WUqmX36q+Vcr+3
 g4UT/OVtm0elHqWVGcRb0japHPY4KLIDTMHckjJg5neAKkXGVjKMTIICacXlUK5PW9pm
 dZfvjb4S9IuUf94detDk4iSy0i/BJhdxvmZLFgBCekHq+31x6cgXySTDxR4Xwgae5aPr
 HynYs+JuIyTad+uC8m2Z009E5323eYhEFfmWbEyflwY+ILIJMze8uU9pkcI6OTcdGESJ
 dIUw==
X-Gm-Message-State: AOJu0YztJvFwbHH5wVRafW0g6mt9ozFw0+jnZbCvahkjde41dwrxdsXw
 /XpVYcKKiwRcYjORSZi/DiYBVA531lrXzKP2uAZEnyK63CHkPK1OHsQ4BZkJxDZFN4gRTc8cg0E
 79e7XDkRfns+00HkXpaCu5ccFTc0QSjSm7dpAMg==
X-Google-Smtp-Source: AGHT+IHMa+Jd4fcPctCJpaC2erZJ975ONqkqrMHQVu1EpOVWTbrh2zB2PCGfTgBhG3uIDBtiERJlislxh8X8pDPr0E0=
X-Received: by 2002:a50:8e53:0:b0:58a:f14f:4d6d with SMTP id
 4fb4d7f45d1cf-599604d633cmr133486a12.19.1720715089953; Thu, 11 Jul 2024
 09:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240708112520.106127-1-junjiehua@tencent.com>
 <CAFEAcA_pR6VLjKcOgcL+m8aONtey5Lm2ODkWAKv2ne_3ziqknw@mail.gmail.com>
 <CA+TA2aVV8qSK9zEv+HHyp-ib00vqaCLW_s4Hc5pGa_UJskQvUQ@mail.gmail.com>
 <CAFEAcA9oGivebEDmKK+rGitH_CDXt+r7kLhpw0vXP76cexN_GA@mail.gmail.com>
In-Reply-To: <CAFEAcA9oGivebEDmKK+rGitH_CDXt+r7kLhpw0vXP76cexN_GA@mail.gmail.com>
From: junjiehua <halouworls@gmail.com>
Date: Fri, 12 Jul 2024 00:24:13 +0800
Message-ID: <CA+TA2aVKjdgrvV=+VUdPt-CMUYB2mDyQ_kNXmAk8FjA-i_4OyA@mail.gmail.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Content-Type: multipart/alternative; boundary="000000000000b24a9f061cfb3306"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=halouworls@gmail.com; helo=mail-ed1-x532.google.com
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

--000000000000b24a9f061cfb3306
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 12:25=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org>
> wrote:

On Wed, 10 Jul 2024 at 09:02, hellord <halouworls@gmail.com> wrote:
> >
> >
> >>
> >>
> >> On Tue, Jul 9, 2024 at 10:39=E2=80=AFPM Peter Maydell <peter.maydell@l=
inaro.org>
> wrote:
> >> Is there a particular reason to use 128MB here? If the
> >> runtime only fails on 4GB or more, maybe we should use
> >> a larger MAX_CHUNK_SIZE, like 2GB ?
> >
> >
> > According to current analysis, size <=3D 4GB all are safe, however ther=
e
> are many
> > versions of msvcrt, this bug exists on Server 2008/2019/2022 and Window=
s
> 11(all
> > with full latest updates), and it may also exist in other versions, but
> it is difficult to
> > check each version individually. I am not sure if all versions handle
> boundary sizes
> > like 2GB/4GB correctly. So I prefer a relatively conservative value:
> 128MB.
> >
> > Maybe we could use #ifdef _WIN32 to differentiate the handling between
> Linux and
> > Windows. For Linux, it remains unchanged, while for Windows, it
> processes by chunks
> > with max_chunk_sizeto 1GB.
>
> I don't think it's worth making this Windows-specific. I agree that
> it's OK to be a bit conservative, but 128MB seems to me extremely
> conservative. I think we could say, for instance, 512MB or 1GB, without
> being at much danger of running into broken implementations here.
>


OK, I will change the max size to 1GB and send patch V2 in the next few
days.

--000000000000b24a9f061cfb3306
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, Jul 11, 2024 at 1=
2:25=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.or=
g">peter.maydell@linaro.org</a>&gt; wrote:</blockquote><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Wed, 10 Jul 2024 at 09:02, hellord &lt;<a =
href=3D"mailto:halouworls@gmail.com" target=3D"_blank">halouworls@gmail.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Jul 9, 2024 at 10:39=E2=80=AFPM Peter Maydell &lt;<a href=
=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro=
.org</a>&gt; wrote:<br>
&gt;&gt; Is there a particular reason to use 128MB here? If the<br>
&gt;&gt; runtime only fails on 4GB or more, maybe we should use<br>
&gt;&gt; a larger MAX_CHUNK_SIZE, like 2GB ?<br>
&gt;<br>
&gt;<br>
&gt; According to current analysis, size &lt;=3D 4GB all are safe, however =
there are many<br>
&gt; versions of msvcrt, this bug exists on Server 2008/2019/2022 and Windo=
ws 11(all<br>
&gt; with full latest updates), and it may also exist in other versions, bu=
t it is difficult to<br>
&gt; check each version individually. I am not sure if all versions handle =
boundary sizes<br>
&gt; like 2GB/4GB correctly. So I prefer a relatively conservative value: 1=
28MB.<br>
&gt;<br>
&gt; Maybe we could use #ifdef _WIN32 to differentiate the handling between=
 Linux and<br>
&gt; Windows. For Linux, it remains unchanged, while for Windows, it proces=
ses by chunks<br>
&gt; with max_chunk_sizeto 1GB.<br>
<br>
I don&#39;t think it&#39;s worth making this Windows-specific. I agree that=
<br>
it&#39;s OK to be a bit conservative, but 128MB seems to me extremely<br>
conservative. I think we could say, for instance, 512MB or 1GB, without<br>
being at much danger of running into broken implementations here.<br></bloc=
kquote><div>=C2=A0</div><div><br></div><div>OK, I will change the max size =
to 1GB and send patch V2 in the next few days.<br></div><div><div class=3D"=
gmail-ChatMessagesView_messagePair__ZEXUz" style=3D"display:flex"><div clas=
s=3D"gmail-ChatMessage_chatMessage__xkgHx" style=3D"scrollbar-width: thin;"=
><div class=3D"gmail-ChatMessage_messageRow__DHlnq" style=3D"display:flex">=
<div class=3D"gmail-ChatMessage_messageWrapper__4Ugd6" style=3D"display:fle=
x;min-width:0px"><div class=3D"gmail-Message_rowWithFooter__FShU6" style=3D=
"min-width:0px"><div class=3D"gmail-Message_row__ug_UU" style=3D"display:fl=
ex"><div class=3D"gmail-Message_botMessageBubble__aYctV" style=3D"display:f=
lex;overflow-x:hidden;border-radius:12px;word-break:break-word;box-sizing:b=
order-box"><div class=3D"gmail-Markdown_markdownContainer__Tz3HQ" style=3D"=
display:flex;overflow-x:auto"><p style=3D"padding:0px;margin:0px"><br></p><=
/div></div></div></div></div></div></div></div></div></div></div>

--000000000000b24a9f061cfb3306--

