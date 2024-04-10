Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5917CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 12:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruXIw-0006dq-CO; Wed, 10 Apr 2024 08:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruXIh-0006d7-S3
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:43:44 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ruXIe-0007zP-60
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 08:43:39 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e6282dd72so4063570a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712753014; x=1713357814; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=silx6WvOZCCUkQd6NNOSEGukz1iuPqJ3bRG5dHWkQao=;
 b=epWXnhTKdaMB0ywr/7oe1XqfrD+HB2TTwF1+/Q0C0JkNBM7Y+70CjIgSUJGGDKjrv9
 xD/phULZbuJLCrDX7a8dTzHoTqu9fCXc9wZiQ26ePGBUXpMrdnQUwUDpheGMu6bYgFtC
 DtvouM5Jeqdi84d6eKlLv24IikJzr87DGZpDo0TNOEnNMCaRtbYzQAglVBR/RXA5W0TR
 esLpDSDNwfBjK44BfedCi+mDTnS9Z+nRVEdBVJ/dtqqi8WTP0t9D0f/6yTEpbse3pJuU
 W18bZYY5QjRXnYO/5E6ZweVmNQnnwbnMWnYT/nQdMT4r9/R4xAF+Lxp1oY4rZEiL25Mc
 9SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712753014; x=1713357814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=silx6WvOZCCUkQd6NNOSEGukz1iuPqJ3bRG5dHWkQao=;
 b=S/tm6+R58qDNvt4fb6LRftAH7ShzVq6AxQKROzaImPnH08PxIMmqagvF82SVrzkNw9
 kiapc+PycUmEGoQWVv0ualIR7+hnu/13voBuj5BH9W7VHYV83bpG0nK4VrYnMLvD9bvO
 /pztBneKfbJAO+3fUF/E1bfftbW/BE/qFav0wozlAhoQltKE6k/ZuVOizF2tu267PZgl
 eEmkDyfmI2pwFLgU9IfJfSLD6Jv7O2xMVnIuEn3YTtwnglEfYsXWni5LuMheYVTUgUfq
 Udg1V9GrDp9N6fuNdwC2GZMp0rkCLm8iACZo0hiuHxDCuKQF91m0uu3CJPcfNyaHyNGe
 PcRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqMpUR0To0D77dR/V6wbz9+jaahIJcxu3CEHFqrFHOkQzWKYH8PQczverOAQZSwW8UuO7UL9clnmPiafan+Ubb4op9joE=
X-Gm-Message-State: AOJu0YxvGWRWeodX6Tq7DdPlF94YTH6o0gsQNulMB76fDDgcVlPGl2VK
 TBG2bI2984qeBS5ErxUoT2BkrOZzi6jygmlgjWbGJRMTI37Y1eGsEzly5AgaA/wxgpkMLqciUoy
 TStwpXSCeoTaNjvuQdrko+pMLu45bXSrd2+c0J4Fr
X-Google-Smtp-Source: AGHT+IHoJpfLg9UYg5CGJWy1UMpyuu4ud2j4nd2jP5XyU4ZaOEt3o/smjKQK9NGDvUmFDHs824ww6m+HmrzITmMlPHA=
X-Received: by 2002:a50:cd13:0:b0:56e:2e2c:f5c5 with SMTP id
 z19-20020a50cd13000000b0056e2e2cf5c5mr1454055edi.37.1712753014425; Wed, 10
 Apr 2024 05:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <9kisd.h00guzdfowp4@linaro.org> <Zd-ClG4RSAzfli50@amd.com>
In-Reply-To: <Zd-ClG4RSAzfli50@amd.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 10 Apr 2024 14:43:22 +0200
Message-ID: <CAJy5ezq8Kv-PYqwx596CfW9iwd6hMVGYruTjbK-dFKDUbn78hg@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 0/7] Xen: support grant mappings.
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 sstabellini@kernel.org, jgross@suse.com
Content-Type: multipart/alternative; boundary="000000000000034dcf0615bd6307"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x530.google.com
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

--000000000000034dcf0615bd6307
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:00=E2=80=AFPM Vikram Garhwal <vikram.garhwal@amd.=
com>
wrote:

> Hi Manos,
> On Wed, Feb 28, 2024 at 03:27:12PM +0200, Manos Pitsidianakis wrote:
> > Hello Vikram,
> >
> > Series doesn't apply on master. Can you rebase and also provide a
> > base-commit with --base=3D<COMMIT_SHA> when you use git-format-patch? T=
his
> > will help git rebase if there are any conflicts found locally.
> I rebased it with latest master and it works fine. Series is based on
> following
> commit: bfe8020c814a30479a4241aaa78b63960655962b.
>
> For v4, I will send a version with base-commit id.
>
> Can you please share what is base-commit id on your side?
>
> Thanks!
> >
> > Thanks,
>

Hi all,

I'll send a v4 on behalf of Vikram.

Stefano, I saw your comments here:
https://marc.info/?l=3Dqemu-devel&m=3D169999555103080
I've manage to loose the email so I can't reply but you indicated that
you're OK with the current patch but perhaps would have preferred another
approach.
I like what Juergen did (so I RB tagged it) but if you feel strongly about
finding another approach we can have a look.

Best regards,
Edgar

--000000000000034dcf0615bd6307
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Feb 28, 2024 at 8:00=E2=80=AFPM V=
ikram Garhwal &lt;<a href=3D"mailto:vikram.garhwal@amd.com">vikram.garhwal@=
amd.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Hi Manos,<br>
On Wed, Feb 28, 2024 at 03:27:12PM +0200, Manos Pitsidianakis wrote:<br>
&gt; Hello Vikram,<br>
&gt; <br>
&gt; Series doesn&#39;t apply on master. Can you rebase and also provide a<=
br>
&gt; base-commit with --base=3D&lt;COMMIT_SHA&gt; when you use git-format-p=
atch? This<br>
&gt; will help git rebase if there are any conflicts found locally.<br>
I rebased it with latest master and it works fine. Series is based on follo=
wing<br>
commit: bfe8020c814a30479a4241aaa78b63960655962b.<br>
<br>
For v4, I will send a version with base-commit id.<br>
<br>
Can you please share what is base-commit id on your side?<br>
<br>
Thanks!<br>
&gt; <br>
&gt; Thanks,<br></blockquote><div><br></div><div>Hi all,</div><div><br></di=
v><div>I&#39;ll send a v4 on behalf of Vikram.</div><div><br></div><div>Ste=
fano, I saw your comments here: <a href=3D"https://marc.info/?l=3Dqemu-deve=
l&amp;m=3D169999555103080">https://marc.info/?l=3Dqemu-devel&amp;m=3D169999=
555103080</a></div><div>I&#39;ve manage to loose the email so I can&#39;t r=
eply but you indicated that you&#39;re OK with the current patch but perhap=
s would have preferred=C2=A0another approach.</div><div>I like what Juergen=
 did (so I RB tagged it) but if you feel strongly about finding another app=
roach we can have a look.</div><div><br></div><div>Best regards,</div><div>=
Edgar</div><div><br></div><div><br></div><div>=C2=A0</div></div></div>

--000000000000034dcf0615bd6307--

