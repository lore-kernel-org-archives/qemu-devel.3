Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DA3C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 09:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1iaz-0007p5-W9; Mon, 07 Apr 2025 05:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1u1iax-0007ox-PV
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:16:43 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1u1iau-0001L1-Es
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 05:16:43 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30ddad694c1so43666351fa.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744017393; x=1744622193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dFw9f9oORgNP86WG3ObM4nO5VHLeCGsVOu4jzneYOmU=;
 b=fUmBX2f+/7E4ahuvTTTbvrOEQ7Sl7jXJdFN6OMo4NqbwUYOE2enXhMO/zoePbPWF46
 ljF5NTcSsDrJLLtiXAMdnle1o8rRMaYsk3rakOpcZjTV/F3TCxmZ2PPY1Y9Ppfe3D9FP
 +BhLRho8YLACnyPEruLyRJgly6S2BM0vYEm5HX+BhZqZ/IE3NAp5R9trAO1FzY8FJY6f
 MiCi8krdFF91mcp/Kk4ST41Wa/zhBxBJqElyrSQRluFTJvahaMQuByPsq4Vd6bsB5cZr
 zyqq+t5BUnBc4RhUe6M1v47PoOvhZVwU8hheFE3q5c/wkJlJkOQRwPHb5XJSS76njh8v
 I1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744017393; x=1744622193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFw9f9oORgNP86WG3ObM4nO5VHLeCGsVOu4jzneYOmU=;
 b=ZgnUufSltRqWHZTd3Wl8ZWUohIAoQshAMFiETd/YBkNYhXpi8ri+fhcHPfjCI7YPUx
 3GzlPXGKt4qsZ37sKvvHEPRqgfomNVUtY/aFJNMBWRyJiQ6zXcHgmtmAxP3yJnDIUlDn
 ZDmGbp7XVNA91iX9DzyUjT4v7G1ZRTWzuqcKWYMudZmc26n0JGcuN1HGp9ppN8noHFNn
 APVVAaQVirumVkbi7DFY/RxLFqqVpS5IYHmYyatwwNusdAhi7BoQ9GNMJ2LJNfH7ffOy
 9gVfKgesOx7gADSMvge2GjQSOHijBpBOwehy8sGuls97N4lFHu9Y6mcFxIaaisUqp5Ri
 E7bQ==
X-Gm-Message-State: AOJu0YwgXecCPV9UalOqqApUgYk7UxGmCboEXYu1qBgj7loH/N2PwX/q
 hhmwlvo4HZ/HaTgVWdXYIGaqOv8HVirKZnJv7mEZCKUO6BZhgsL/YWtk/XhHBXDp81d3abMepwq
 u680zf6PASrE6taYJNA3f10GdL64=
X-Gm-Gg: ASbGncvtEaq2NeuXs+vOUT1LmZJLQmSQIqG78m4ehq1b4dTYYzxPjdXCii3cVDcFdlN
 g3QgTSHwZMgOwhy3IVsw87MDD1ZHBGBl3fM9DRh6AyhcItmULVxVZBHyxCE9JFjrhCns6kJNk0Y
 C41QXPraU62v4UXUDs9RRS4iyJp3Nl
X-Google-Smtp-Source: AGHT+IGrXuHP2ZdSv9Uy5u6HiX4X+aNtp0+yJLsreQ/oAbtDkd5XL45WNGMZwc1FdUhwPXuf8d1jL/IfOCWCThhMeMY=
X-Received: by 2002:a05:651c:210c:b0:30b:ce0a:3e84 with SMTP id
 38308e7fff4ca-30f0c02d108mr33461461fa.32.1744017393254; Mon, 07 Apr 2025
 02:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
 <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
 <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
 <pf24mn3twfrc2kfaszovdyj5rhh6d4r4ixawh2dyx5dbi5no3j@ryk4lzslrnye>
In-Reply-To: <pf24mn3twfrc2kfaszovdyj5rhh6d4r4ixawh2dyx5dbi5no3j@ryk4lzslrnye>
From: prashant patil <pmgpatil@gmail.com>
Date: Mon, 7 Apr 2025 14:46:17 +0530
X-Gm-Features: ATxdqUEoqgELP2RAALeMnM3W5h_cK4cinBHTDMYZsgpA01sGQk21M9La9cSjJgs
Message-ID: <CAFvsdYmJFDuQzk6Byu+f4HcTO1EStin3vEMC+twh8P3T2ve6qA@mail.gmail.com>
Subject: Re: Query on the dirty bitmap
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000350c4d06322cb1d2"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=pmgpatil@gmail.com; helo=mail-lj1-x234.google.com
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

--000000000000350c4d06322cb1d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric.
I have a few questions about the bitmap content shown by 'qemu-img map'.
From below sample bitmap data:
1. Why only some of the extents have start and offset values? And why are
they the same values?
2. What does the start value indicate? Is it logical offset or physical
offset of data into qcow2?

root@be-proxmox1:/# qemu-img map --output=3Djson --image-opts
"$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:bitmap1"
  [{ "start": 0, "length": 196608, "depth": 0, "present": true, "zero":
false, "data": true, "compressed": false, "offset": 0},
{ "start": 196608, "length": 65536, "depth": 0, "present": false, "zero":
false, "data": false, "compressed": false},
{ "start": 262144, "length": 105840640, "depth": 0, "present": true,
"zero": false, "data": true, "compressed": false, "offset": 262144},
{ "start": 106102784, "length": 95485952, "depth": 0, "present": false,
"zero": false, "data": false, "compressed": false},
{ "start": 201588736, "length": 145227776, "depth": 0, "present": true,
"zero": false, "data": true, "compressed": false, "offset": 201588736},
{ "start": 346816512, "length": 131072, "depth": 0, "present": false,
"zero": false, "data": false, "compressed": false},
{ "start": 346947584, "length": 131072, "depth": 0, "present": true,
"zero": false, "data": true, "compressed": false, "offset": 346947584},
{ "start": 347078656, "length": 65536, "depth": 0, "present": false,
"zero": false, "data": false, "compressed": false},
{ "start": 347144192, "length": 9699328, "depth": 0, "present": true,
"zero": false, "data": true, "compressed": false, "offset": 347144192},
{ "start": 356843520, "length": 131072, "depth": 0, "present": false,
"zero": false, "data": false, "compressed": false},
{ "start": 356974592, "length": 716767232, "depth": 0, "present": true,
"zero": false, "data": true, "compressed": false, "offset": 356974592}]


Regards
Prashant

On Thu, Mar 6, 2025 at 3:44=E2=80=AFAM Eric Blake <eblake@redhat.com> wrote=
:

> On Wed, Mar 05, 2025 at 03:36:35PM +0530, prashant patil wrote:
> > I was trying to read the bitmap of the running vm's disk. When I follow=
ed
> > below mentioned commands, then I was able to read the bitmap properly.
> > block-dirty-bitmap-add, block-dirty-bitmap-disable, nbd-server-start,
> > nbd-server-add,
>
> Up to here, everything you've done is indeed the ideal way to get at
> the contents of a bitmap from a live qemu process over an NBD connection.
>
> > qemu-img
> > map with x-dirty-bitmap image-opts.
>
> Here, this works, but feels like a hack, because it is relying on the
> x-dirty-bitmap feature of qemu.  The libnbd project ships with an
> application 'nbdinfo --map' that can read the same information as
> 'qemu-img map' but with a much nicer layout.  It's not going to
> necessarily be faster, but because it is a fully-supported feature of
> libnbd rather than a hack in qemu, it may prove more stable in the
> long run, and certainly easier to understand.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>
>

--000000000000350c4d06322cb1d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Eric.<div>I have a few questions about the bitmap c=
ontent shown by &#39;qemu-img map&#39;.</div><div>From below sample bitmap =
data:</div><div>1. Why only some of the extents have start and offset value=
s? And why are they the same values?</div><div>2. What does the start value=
 indicate? Is it logical offset or physical offset of data into qcow2?</div=
><div><br></div><div>root@be-proxmox1:/# qemu-img map --output=3Djson --ima=
ge-opts &quot;$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:bitmap1&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [{ &quot;start&quot;: 0, &quot;length&quot;: 19660=
8, &quot;depth&quot;: 0, &quot;present&quot;: true, &quot;zero&quot;: false=
, &quot;data&quot;: true, &quot;compressed&quot;: false, &quot;offset&quot;=
: 0},<br>{ &quot;start&quot;: 196608, &quot;length&quot;: 65536, &quot;dept=
h&quot;: 0, &quot;present&quot;: false, &quot;zero&quot;: false, &quot;data=
&quot;: false, &quot;compressed&quot;: false},<br>{ &quot;start&quot;: 2621=
44, &quot;length&quot;: 105840640, &quot;depth&quot;: 0, &quot;present&quot=
;: true, &quot;zero&quot;: false, &quot;data&quot;: true, &quot;compressed&=
quot;: false, &quot;offset&quot;: 262144},<br>{ &quot;start&quot;: 10610278=
4, &quot;length&quot;: 95485952, &quot;depth&quot;: 0, &quot;present&quot;:=
 false, &quot;zero&quot;: false, &quot;data&quot;: false, &quot;compressed&=
quot;: false},<br>{ &quot;start&quot;: 201588736, &quot;length&quot;: 14522=
7776, &quot;depth&quot;: 0, &quot;present&quot;: true, &quot;zero&quot;: fa=
lse, &quot;data&quot;: true, &quot;compressed&quot;: false, &quot;offset&qu=
ot;: 201588736},<br>{ &quot;start&quot;: 346816512, &quot;length&quot;: 131=
072, &quot;depth&quot;: 0, &quot;present&quot;: false, &quot;zero&quot;: fa=
lse, &quot;data&quot;: false, &quot;compressed&quot;: false},<br>{ &quot;st=
art&quot;: 346947584, &quot;length&quot;: 131072, &quot;depth&quot;: 0, &qu=
ot;present&quot;: true, &quot;zero&quot;: false, &quot;data&quot;: true, &q=
uot;compressed&quot;: false, &quot;offset&quot;: 346947584},<br>{ &quot;sta=
rt&quot;: 347078656, &quot;length&quot;: 65536, &quot;depth&quot;: 0, &quot=
;present&quot;: false, &quot;zero&quot;: false, &quot;data&quot;: false, &q=
uot;compressed&quot;: false},<br>{ &quot;start&quot;: 347144192, &quot;leng=
th&quot;: 9699328, &quot;depth&quot;: 0, &quot;present&quot;: true, &quot;z=
ero&quot;: false, &quot;data&quot;: true, &quot;compressed&quot;: false, &q=
uot;offset&quot;: 347144192},<br>{ &quot;start&quot;: 356843520, &quot;leng=
th&quot;: 131072, &quot;depth&quot;: 0, &quot;present&quot;: false, &quot;z=
ero&quot;: false, &quot;data&quot;: false, &quot;compressed&quot;: false},<=
br>{ &quot;start&quot;: 356974592, &quot;length&quot;: 716767232, &quot;dep=
th&quot;: 0, &quot;present&quot;: true, &quot;zero&quot;: false, &quot;data=
&quot;: true, &quot;compressed&quot;: false, &quot;offset&quot;: 356974592}=
]</div><div><br></div><div><br></div><div>Regards</div><div>Prashant</div><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Mar 6, 2025 at 3:44=E2=80=AFAM Eric Blake &lt;=
<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Mar 05, 2025 =
at 03:36:35PM +0530, prashant patil wrote:<br>
&gt; I was trying to read the bitmap of the running vm&#39;s disk. When I f=
ollowed<br>
&gt; below mentioned commands, then I was able to read the bitmap properly.=
<br>
&gt; block-dirty-bitmap-add, block-dirty-bitmap-disable, nbd-server-start,<=
br>
&gt; nbd-server-add,<br>
<br>
Up to here, everything you&#39;ve done is indeed the ideal way to get at<br=
>
the contents of a bitmap from a live qemu process over an NBD connection.<b=
r>
<br>
&gt; qemu-img<br>
&gt; map with x-dirty-bitmap image-opts.<br>
<br>
Here, this works, but feels like a hack, because it is relying on the<br>
x-dirty-bitmap feature of qemu.=C2=A0 The libnbd project ships with an<br>
application &#39;nbdinfo --map&#39; that can read the same information as<b=
r>
&#39;qemu-img map&#39; but with a much nicer layout.=C2=A0 It&#39;s not goi=
ng to<br>
necessarily be faster, but because it is a fully-supported feature of<br>
libnbd rather than a hack in qemu, it may prove more stable in the<br>
long run, and certainly easier to understand.<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libguestfs.org" rel=3D"norefer=
rer" target=3D"_blank">libguestfs.org</a><br>
<br>
</blockquote></div>

--000000000000350c4d06322cb1d2--

