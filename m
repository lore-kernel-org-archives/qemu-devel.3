Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8A4C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 06:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsoX-0000zm-54; Thu, 25 Jan 2024 01:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junho920219@gmail.com>)
 id 1rSsoQ-0000sd-9W; Thu, 25 Jan 2024 01:02:07 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junho920219@gmail.com>)
 id 1rSsoL-0007Uv-Tp; Thu, 25 Jan 2024 01:02:04 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2c179aa5c4so668201466b.0; 
 Wed, 24 Jan 2024 22:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706162511; x=1706767311; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GQ26Gcz3SLQl8JTqQGnk1B/O0vFJDdf+UI3qd9GHIZE=;
 b=h+SMbLMUVmPAy1p+NG0ZhNuBfFtsZcsVSnmfov9FPmH6TP8tLjwHQpL7kOahj1HipH
 UyB6oF2Lfph2cGM8zujg8gba0+qfnF7lGKoYCMaOvEZyOBymctsBlcPHsE6JgJd8imBF
 60e7wPORHUz+h0k8GOcqW/wRHoZIHV+IyxpVFmVpyEE3WP+76Zy5r9b2PdJOiiZpuC7M
 PDQNPEx3hCLQ2kjS7RCwfn24hCOPjgmFBDLRbkmIu/5d87IKFWSpEpEmxRbq2JmmuFYV
 1ln23b0jO+eBZpPF3RteFdYj47damqU/infy9hMWJmEGUy5ujZk4svqnhk9ZXDBgRKVV
 YUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706162511; x=1706767311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQ26Gcz3SLQl8JTqQGnk1B/O0vFJDdf+UI3qd9GHIZE=;
 b=ArYkOTdDVF2UXqctGXjjg8zagsj/2ZYXdXmJoksJmGymz1nzrJ7qNZccnhBXVTxslB
 6eHMwZjnKUBiPKX0IwsCX4IMVv7PMDpw18UshmN03mHjZdM1iBd6GtwgFNlazlrRx64O
 Rlbd/ybr3pC4rvqPywHLBO1pOA/7UBGfQOSplfuDZAfGv/TdWldBU7M2DmkQ7wKfYEsx
 Fl7qj8AngLTKFVFqQUIn26uG0dMe+IRncAwrojQxk8e5q3QbtuSc7wOCb2+Xdl/RK1hG
 9ENH4Yk3sWkiEE4QZIwIVBlRxN/zmCuODg85VrWbpYBrXPGRhWM1h83+HGLIySpbibwS
 sGqg==
X-Gm-Message-State: AOJu0YxS7HfXwI63FgowQtCKk/7ebMdfasVid+XczmHh4RxieWfqOMFa
 SNM+PN1dX92Yl7CliucRXeSqqdYdg4Y2YBVsdUHP7JfHL4y/dxRcjtvjMI0gDadzaOASmexHqMI
 tyceU4CRhANTKbIzCioN5R7LoTBq2SljoJ5Q=
X-Google-Smtp-Source: AGHT+IEF2KqcGp116/k8mKiAAv7i+++2SXlzDLSp9w8Uw2zsJM1S6XnsX9kDel0EWpOl31hH8JF0UD60F9qI1RfOP7s=
X-Received: by 2002:a17:906:180a:b0:a2e:94a0:93b4 with SMTP id
 v10-20020a170906180a00b00a2e94a093b4mr167815eje.61.1706162510817; Wed, 24 Jan
 2024 22:01:50 -0800 (PST)
MIME-Version: 1.0
References: <CACrrvNSKQ1du+f40RvcDCvhjojvvDSsHi0FyWoJMMBtt8R+Q3A@mail.gmail.com>
 <20754e51-3100-4eab-a04d-110ca229a38b@redhat.com>
 <CYLWWAEWNXN2.1TJLV7UOK9M6R@wheely>
In-Reply-To: <CYLWWAEWNXN2.1TJLV7UOK9M6R@wheely>
From: Junho <junho920219@gmail.com>
Date: Thu, 25 Jan 2024 15:01:39 +0900
Message-ID: <CACrrvNSgx3sKdzvYu5cWeHCLnEOa6-0SDEcy9FKaUYKnxD82Rw@mail.gmail.com>
Subject: Re: How can I know Page Table address on RAM?
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000062ef12060fbeea3f"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=junho920219@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000062ef12060fbeea3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Nick,

It helped a lot.
The page table is software loaded on the MMU of the target I'm using.
I'll watch for TLBs as recommended.

Thank you,
Junho



2024=EB=85=84 1=EC=9B=94 23=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 4:36, N=
icholas Piggin <npiggin@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Mon Jan 22, 2024 at 6:54 PM AEST, Thomas Huth wrote:
> > On 22/01/2024 05.11, Junho wrote:
> > > Hello,
> > >
> > > I'm a QEMU user with PowerPc target architecture.
> > > I have some personal modifications related to tb jmp cache and
> chaining
> > > logic to improve the performance of a specific guest code. To verify
> the
> > > safety, I have to guarantee that the page table on RAM does not chang=
e
> after
> > > initialization. Do you have any information related to this work?
> Currently,
> > > what I need to find is the page table start address on the RAM so tha=
t
> I can
> > > test with the range detected.
> > >
> > > I look forward to your response.
> > >
> > > Thank you
> > > Junho
> >
> >   Hi,
> >
> > maybe it's best to ask this question on the qemu-ppc mailing list
> instead
> > (done now), since most PPC folks will rather read than one instead of
> the
> > high-traffic qemu-devel mailing list.
>
> Hi Junho,
>
> ppc targets have a lot of different MMUs, so it depends what you are
> looking at.
>
> The hash MMU has a page table that is linear in physical (real) memory,
> so you might feasibly be able to watch it for updates. The SDR1 SPR has
> hash table base and size. ISA v3.0 and later use an in-memory table
> that is pointed to by the PTCR SPR.
>
> Other types are software loaded and radix page tables which might be
> infeasible or impossible to really track.
>
> It would be interesting to know what kind of modifications you're doing,
> it's possible they might be achieved another way. For example, there is
> no requirement in the architecture for the TLB to be kept coherent with
> page table modifications, so you might be able to watch for TLB flush
> instructions rather than page table changes.
>
> Thanks,
> Nick
>

--00000000000062ef12060fbeea3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Nick,<div><br></div><div>It helped a lot.</div><div>=
The page table is software loaded on the MMU of the target I&#39;m using.</=
div><div>I&#39;ll=C2=A0watch for TLBs=C2=A0as=C2=A0recommended.</div><div><=
br></div><div>Thank you,</div><div>Junho=C2=A0</div><div><br></div><div><br=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">2024=EB=85=84 1=EC=9B=94 23=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 =
4:36, Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com">npiggin@gmai=
l.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon Jan 22, 2024 at 6:54 PM AEST, Th=
omas Huth wrote:<br>
&gt; On 22/01/2024 05.11, Junho wrote:<br>
&gt; &gt; Hello,<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m a QEMU user with PowerPc target architecture.<br>
&gt; &gt; I have some personal modifications related to tb jmp cache and ch=
aining <br>
&gt; &gt; logic to improve the performance of a specific guest code. To ver=
ify the <br>
&gt; &gt; safety, I have to guarantee that the page table on RAM does not c=
hange after <br>
&gt; &gt; initialization. Do you have any information related to this work?=
 Currently, <br>
&gt; &gt; what I need to find is the page table start address on the RAM so=
 that I can <br>
&gt; &gt; test with the range detected.<br>
&gt; &gt; <br>
&gt; &gt; I look forward to your response.<br>
&gt; &gt; <br>
&gt; &gt; Thank you<br>
&gt; &gt; Junho<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt; maybe it&#39;s best to ask this question on the qemu-ppc mailing list =
instead <br>
&gt; (done now), since most PPC folks will rather read than one instead of =
the <br>
&gt; high-traffic qemu-devel mailing list.<br>
<br>
Hi Junho,<br>
<br>
ppc targets have a lot of different MMUs, so it depends what you are<br>
looking at.<br>
<br>
The hash MMU has a page table that is linear in physical (real) memory,<br>
so you might feasibly be able to watch it for updates. The SDR1 SPR has<br>
hash table base and size. ISA v3.0 and later use an in-memory table<br>
that is pointed to by the PTCR SPR.<br>
<br>
Other types are software loaded and radix page tables which might be<br>
infeasible or impossible to really track.<br>
<br>
It would be interesting to know what kind of modifications you&#39;re doing=
,<br>
it&#39;s possible they might be achieved another way. For example, there is=
<br>
no requirement in the architecture for the TLB to be kept coherent with<br>
page table modifications, so you might be able to watch for TLB flush<br>
instructions rather than page table changes.<br>
<br>
Thanks,<br>
Nick<br>
</blockquote></div>

--00000000000062ef12060fbeea3f--

