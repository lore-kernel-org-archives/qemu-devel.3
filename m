Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9958AE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVsl8-0000F1-AL; Thu, 09 Jan 2025 08:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqLH-00046A-8L; Thu, 09 Jan 2025 06:04:47 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wielandtdan@gmail.com>)
 id 1tVqLE-0001hH-Vu; Thu, 09 Jan 2025 06:04:46 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-467a63f5d1cso5168261cf.0; 
 Thu, 09 Jan 2025 03:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736420683; x=1737025483; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gjDVOKsAhzrLvIUEjQDkn/4L1E+3dODFfJOshhgVrCY=;
 b=MuqkuNMl29GMVB5a1b9CQ24xe8LzG91YBy5H+06CACrhd+3jiH6d8iozUECn9QF46E
 40nJX6TY4/25OAsd1B45Lws2UCyabwSnbE/Z4ByqYBq4oIKVNGcaU5gux0pJO03mHqgh
 yCw+k6var8DjLa+ogXizIxUXKgnBRTWTZD7ByrRJI4cK2F//oNaRJm/sL37D8wrKx4ux
 VcELXDSZnilU/9tkzgvvwsb+BTBHoeJheU/XGByGau9oNfcnWT1Oz7ZXIeeSpcn39MTU
 OuJ49XjwikmHd0c6AsSsHdWMkXQ89L4sSiAWHzPvfu4fLzFGtGrRB9EKc7H1gdvCdyni
 ZJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420683; x=1737025483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjDVOKsAhzrLvIUEjQDkn/4L1E+3dODFfJOshhgVrCY=;
 b=V9Yx5xI/zPuW3ZerrrbbcDp4kS4a492O6PCVKxZ3PmSckrWHOwG/aE/lAJgMWwDvHi
 w7yFiE2SExIb4CYGGmGqTjtMHhVyY7eMZNDDnZ5e0FRUY90UV590Pi9h3TWWZQheec2A
 4XAHTZ9bOVorAjYtkWERm2lkLSb6QwaHXuecyv3dYMyVUVmOHq54RnRwSwWFGEcypCLh
 B5RwBeC3zgyhI8nqPkqFrezrdFWaOHMTEYS5VnPXzsdb5C0UdLshDmYv3ZMB1pio3lXO
 INGtaDOqmYTPRVBzMxoqNzjG4fmzb7FqrGzroTwgNBNjY6pj2ta/NTdOVR3JQbL3Boql
 +UxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXObmkPTScB2Cyft9WfS6bZRHr84MMiMO/nJPdazhBMQaeUGXBWr4icR/kC1CGcfZC/k9kSqhA9XWDY@nongnu.org,
 AJvYcCXiNqx1oNJDpmpKqZrLLJVglRL3MsB9Kc6NxAtJ12XN1kE8ZbC14ejbGrbzui/rA4JwCZ6YLFWdvHXotA==@nongnu.org,
 AJvYcCXyueNSvahQQydorg12NruKMhuj/CvU4R/AFRmwz97zKYeXyum3STZ2uYLDMIf52mmG/a69rTH/jeSt0Es=@nongnu.org
X-Gm-Message-State: AOJu0YwnGSJVS401Yt5BZrwVG60zIY6HQbtlRLbMsTEoZ+lahY+hozg8
 58/mIb105vb0RQDij79cgYDhwy0YKJP6yoUs7TxS716uuaH0ApU3rPVwwZQ7rGbZUOOex8LnfYW
 adpMna6QYfhazpRVteEWGoiL1XDMBcj0p
X-Gm-Gg: ASbGncvqxNEs8sbCdldCC9HQrNgjj6OkkJWarr+TgMJSE27Q6Mmu6lJoVgxcn8/zfzu
 wYOmRApejoAgymTYif7d3LiJG0oUAeUbcC4vO
X-Google-Smtp-Source: AGHT+IEkZ7o0r18mbDBJ1BY4nK40qx9DxT548xqPXiu2m5hCUxOuAfX0HryzSG18x2Shawr3ijC9KlscA5+ztmubyu4=
X-Received: by 2002:a05:6214:dca:b0:6dd:dd0:764 with SMTP id
 6a1803df08f44-6df9b1df426mr105953786d6.17.1736420683124; Thu, 09 Jan 2025
 03:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20250108124649.333668-1-f.ebner@proxmox.com>
 <Z3-pTUj66O2nfqc_@redhat.com>
 <CA+7p6PKEx552-wN_5ueq6E=mNTNYpGpUYgo3wGRM+fxbG=icyQ@mail.gmail.com>
 <CA+7p6P+hc7hYqfK1pLeN5y9ALEVM8HoioMvUK-45AboM5yDWuQ@mail.gmail.com>
 <CA+7p6PJwmpTsB3xS+6_ZSKM3ZqBwVv4cGTaRd_mMDWjKsQSLoA@mail.gmail.com>
 <CA+7p6PK3khtvuM7bMyRc0RthH0defrX9kKNEQBdf1Gp3AkjHPw@mail.gmail.com>
In-Reply-To: <CA+7p6PK3khtvuM7bMyRc0RthH0defrX9kKNEQBdf1Gp3AkjHPw@mail.gmail.com>
From: Daniel Wielandt <wielandtdan@gmail.com>
Date: Thu, 9 Jan 2025 05:04:32 -0600
X-Gm-Features: AbW1kvbTCOaCBjPXIpkzx2jFFE41005kN5PyJrnRGuF51RUt8xiT5OHYYeJXlXk
Message-ID: <CA+7p6PKr2CmS-iP053ift3fqJt22JaCNp0qvm6Sq=yk=RUDvww@mail.gmail.com>
Subject: Re: [PATCH] block-backend: protect setting block root to NULL with
 block graph write lock
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ff93d2062b43f134"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=wielandtdan@gmail.com; helo=mail-qt1-x82c.google.com
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

--000000000000ff93d2062b43f134
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just my opinion.. also I want kitty .terminal..red header.. don't worry I
just started this morning..

On Thu, Jan 9, 2025, 5:03=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.com=
> wrote:

> U just need someone whose .og personally invested to tell youwhay needs t=
o
> go. As a third party it'd obvious..remember the kernel and drivers ate no=
t
> the sibstricy..
> Also kernel was written  for free but drivers use a very high overhead..s=
o
> which system deserves world domination.
>
> None stupid it about the people not the crap we argue over at our nightjo=
bs
>
> On Thu, Jan 9, 2025, 4:59=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.c=
om>
> wrote:
>
>> We all know how the thing works and operates it does t take a genius to
>> know what's working and what's not.. I mean. I.notsaying take out tge
>> things that made us like to use it.. but I mean command should be
>> understood logic should be what we use as a am
>> Standard.. and trust me depending on where your at with structure and
>> scripts the logic can even be ...codeing..
>>
>> On Thu, Jan 9, 2025, 4:55=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail.=
com>
>> wrote:
>>
>>> I feel like your too focused on new problems when you  gave up repairin=
g
>>> to old os.. be ause at one time it was real slick.. now.theres parts th=
at
>>> are problems that can be eliminated easy and provide  a less bloated
>>> function with simple code deletion.. fix the original is down its it's
>>> primary parts
>>> .then u can add your fancy automation and setting get real com0lucated
>>>
>>> On Thu, Jan 9, 2025, 4:52=E2=80=AFAM Daniel Wielandt <wielandtdan@gmail=
.com>
>>> wrote:
>>>
>>>> Suggestions hold pattern.. programmers obviously understand control
>>>> logic. Systems built with operational flaws. Will freeze up when u sta=
rt
>>>> repairing it while it's running.
>>>>
>>>> On Thu, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wro=
te:
>>>>
>>>>> Am 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:
>>>>> > Setting blk->root is a graph change operation and thus needs to be
>>>>> > protected by the block graph write lock in blk_remove_bs(). The
>>>>> > assignment to blk->root in blk_insert_bs() is already protected by
>>>>> > the block graph write lock.
>>>>>
>>>>> Hm, if that's the case, then we should also enforce this in the
>>>>> declaration of BlockBackend:
>>>>>
>>>>>     BdrvChild * GRAPH_RDLOCK_PTR root;
>>>>>
>>>>> However, this results in more compiler failures that we need to fix.
>>>>> You
>>>>> caught the only remaining writer, but the lock is only fully effectiv=
e
>>>>> if all readers take it, too.
>>>>>
>>>>> > In particular, the graph read lock in blk_co_do_flush() could
>>>>> > previously not ensure that blk_bs(blk) would always return the same
>>>>> > value during the locked section, which could lead to a segfault [0]
>>>>> in
>>>>> > combination with migration [1].
>>>>> >
>>>>> > From the user-provided backtraces in the forum thread [1], it seems
>>>>> > like blk_co_do_flush() managed to get past the
>>>>> > blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a
>>>>> > non-NULL value during the check, but then, when calling
>>>>> > bdrv_co_flush(), blk_bs(blk) returned NULL.
>>>>> >
>>>>> > [0]:
>>>>> >
>>>>> > > 0  bdrv_primary_child (bs=3Dbs@entry=3D0x0) at ../block.c:8287
>>>>> > > 1  bdrv_co_flush (bs=3D0x0) at ../block/io.c:2948
>>>>> > > 2  bdrv_co_flush_entry (opaque=3D0x7a610affae90) at
>>>>> block/block-gen.c:901
>>>>> >
>>>>> > [1]: https://forum.proxmox.com/threads/158072
>>>>> >
>>>>> > Cc: qemu-stable@nongnu.org
>>>>> > Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>>>>> > ---
>>>>> >  block/block-backend.c | 2 +-
>>>>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> >
>>>>> > diff --git a/block/block-backend.c b/block/block-backend.c
>>>>> > index c93a7525ad..9678615318 100644
>>>>> > --- a/block/block-backend.c
>>>>> > +++ b/block/block-backend.c
>>>>> > @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)
>>>>> >       */
>>>>> >      blk_drain(blk);
>>>>> >      root =3D blk->root;
>>>>> > -    blk->root =3D NULL;
>>>>> >
>>>>> >      bdrv_graph_wrlock();
>>>>> > +    blk->root =3D NULL;
>>>>> >      bdrv_root_unref_child(root);
>>>>> >      bdrv_graph_wrunlock();
>>>>> >  }
>>>>>
>>>>> I think the 'root =3D blk->root' needs to be inside the locked sectio=
n,
>>>>> too. Otherwise blk->root could change during bdrv_graph_wrlock() (whi=
ch
>>>>> has a nested event loop) and root would be stale. I assume clang woul=
d
>>>>> complain about this with the added GRAPH_RDLOCK_PTR.
>>>>>
>>>>> Kevin
>>>>>
>>>>>
>>>>>

--000000000000ff93d2062b43f134
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Just my opinion.. also I want kitty .terminal..red header.. =
don&#39;t worry I just started this morning..</p>
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Jan 9, 2025, 5:03=E2=80=AFAM Daniel Wielandt &lt;<a=
 href=3D"mailto:wielandtdan@gmail.com">wielandtdan@gmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">U just need someone=
 whose .og personally invested to tell youwhay needs to go. As a third part=
y it&#39;d obvious..remember the kernel and drivers ate not the sibstricy..=
<br>
 Also kernel was written=C2=A0 for free but drivers use a very high overhea=
d..so which system deserves world domination.</p>
<p dir=3D"ltr">None stupid it about the people not the crap we argue over a=
t our nightjobs</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:59=E2=80=AFAM Daniel Wielandt &lt;<a href=3D"mailto:wielan=
dtdan@gmail.com" target=3D"_blank" rel=3D"noreferrer">wielandtdan@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr">We a=
ll know how the thing works and operates it does t take a genius to know wh=
at&#39;s working and what&#39;s not.. I mean. I.notsaying take out tge thin=
gs that made us like to use it.. but I mean command should be understood lo=
gic should be what we use as a am<br>
Standard.. and trust me depending on where your at with structure and scrip=
ts the logic can even be ...codeing..</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:55=E2=80=AFAM Daniel Wielandt &lt;<a href=3D"mailto:wielan=
dtdan@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">wielandtda=
n@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=
=3D"ltr">I feel like your too focused on new problems when you=C2=A0 gave u=
p repairing to old os.. be ause at one time it was real slick.. now.theres =
parts that are problems that can be eliminated easy and provide=C2=A0 a les=
s bloated function with simple code deletion.. fix the original is down its=
 it&#39;s primary parts<br>
.then u can add your fancy automation and setting get real com0lucated</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:52=E2=80=AFAM Daniel Wielandt &lt;<a href=3D"mailto:wielan=
dtdan@gmail.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank"=
>wielandtdan@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><p dir=3D"ltr">Suggestions hold pattern.. programmers obviously understa=
nd control logic. Systems built with operational flaws. Will freeze up when=
 u start repairing it while it&#39;s running.<br>
</p>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jan 9, 2025, 4:48=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redha=
t.com" rel=3D"noreferrer noreferrer noreferrer noreferrer" target=3D"_blank=
">kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">A=
m 08.01.2025 um 13:46 hat Fiona Ebner geschrieben:<br>
&gt; Setting blk-&gt;root is a graph change operation and thus needs to be<=
br>
&gt; protected by the block graph write lock in blk_remove_bs(). The<br>
&gt; assignment to blk-&gt;root in blk_insert_bs() is already protected by<=
br>
&gt; the block graph write lock.<br>
<br>
Hm, if that&#39;s the case, then we should also enforce this in the<br>
declaration of BlockBackend:<br>
<br>
=C2=A0 =C2=A0 BdrvChild * GRAPH_RDLOCK_PTR root;<br>
<br>
However, this results in more compiler failures that we need to fix. You<br=
>
caught the only remaining writer, but the lock is only fully effective<br>
if all readers take it, too.<br>
<br>
&gt; In particular, the graph read lock in blk_co_do_flush() could<br>
&gt; previously not ensure that blk_bs(blk) would always return the same<br=
>
&gt; value during the locked section, which could lead to a segfault [0] in=
<br>
&gt; combination with migration [1].<br>
&gt; <br>
&gt; From the user-provided backtraces in the forum thread [1], it seems<br=
>
&gt; like blk_co_do_flush() managed to get past the<br>
&gt; blk_co_is_available(blk) check, meaning that blk_bs(blk) returned a<br=
>
&gt; non-NULL value during the check, but then, when calling<br>
&gt; bdrv_co_flush(), blk_bs(blk) returned NULL.<br>
&gt; <br>
&gt; [0]:<br>
&gt; <br>
&gt; &gt; 0=C2=A0 bdrv_primary_child (bs=3Dbs@entry=3D0x0) at ../block.c:82=
87<br>
&gt; &gt; 1=C2=A0 bdrv_co_flush (bs=3D0x0) at ../block/io.c:2948<br>
&gt; &gt; 2=C2=A0 bdrv_co_flush_entry (opaque=3D0x7a610affae90) at block/bl=
ock-gen.c:901<br>
&gt; <br>
&gt; [1]: <a href=3D"https://forum.proxmox.com/threads/158072" rel=3D"noref=
errer noreferrer noreferrer noreferrer noreferrer noreferrer" target=3D"_bl=
ank">https://forum.proxmox.com/threads/158072</a><br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" rel=3D"noreferrer norefe=
rrer noreferrer noreferrer noreferrer" target=3D"_blank">qemu-stable@nongnu=
.org</a><br>
&gt; Signed-off-by: Fiona Ebner &lt;<a href=3D"mailto:f.ebner@proxmox.com" =
rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer" target=3D"_b=
lank">f.ebner@proxmox.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/block-backend.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/block/block-backend.c b/block/block-backend.c<br>
&gt; index c93a7525ad..9678615318 100644<br>
&gt; --- a/block/block-backend.c<br>
&gt; +++ b/block/block-backend.c<br>
&gt; @@ -887,9 +887,9 @@ void blk_remove_bs(BlockBackend *blk)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 blk_drain(blk);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 root =3D blk-&gt;root;<br>
&gt; -=C2=A0 =C2=A0 blk-&gt;root =3D NULL;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_graph_wrlock();<br>
&gt; +=C2=A0 =C2=A0 blk-&gt;root =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_root_unref_child(root);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_graph_wrunlock();<br>
&gt;=C2=A0 }<br>
<br>
I think the &#39;root =3D blk-&gt;root&#39; needs to be inside the locked s=
ection,<br>
too. Otherwise blk-&gt;root could change during bdrv_graph_wrlock() (which<=
br>
has a nested event loop) and root would be stale. I assume clang would<br>
complain about this with the added GRAPH_RDLOCK_PTR.<br>
<br>
Kevin<br>
<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--000000000000ff93d2062b43f134--

