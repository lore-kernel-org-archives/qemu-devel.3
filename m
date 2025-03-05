Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80937C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 10:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpleT-0007AN-3t; Wed, 05 Mar 2025 05:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1tpleP-0007A1-Mi
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 05:06:54 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pmgpatil@gmail.com>)
 id 1tpleN-0000Ge-Gf
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 05:06:53 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-30615661f98so69778871fa.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 02:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741169209; x=1741774009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DCAHDBgtEbuqIEOkImjLMTTMiHEJyTCbH84LYBvTb/Y=;
 b=mTsOKFTxiKNjl6zpIK25VAp3Oy8DrLsTXF3dbgOLqMfQFdbsOxWZ1Awpayy9W3yEiE
 ge6WBFSNPvGLMSddJn3aUFyC/EvHHnNQ1BJjGCivvnvuydVubnosIxQQUklCV3Cym1Tw
 Q37RuXlMdKVWA/ElwvszQXvbBDR/B82Bf1HiohnqCxpLpQY+Re8CRKD5tSz0jMMq3gfv
 ilDNfZVmZOWNEABjfBbTLOVg4q5Pa5lJe0prLvLciFYq4J7AOmuk4hO4GHzprSIPwPMB
 yo/0DAR7f+DWHZhK1chrnN6YUij2V36uOwB9yulAQk9fgKET+C+1txsvc/Vj3xduNZEv
 1FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741169209; x=1741774009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCAHDBgtEbuqIEOkImjLMTTMiHEJyTCbH84LYBvTb/Y=;
 b=qs5iIbDU3jD0toxWzTMzmJrPPnUY7ehTrxiE9Nyx0ZJ/bABM8feToMcQ8PM7aIhteb
 eZafA/KcCx8UFwLN6aOvOTIKWXAsBB2HAQ/KODAr35xxP3c6LW2nFkkXCZIgL6sGo20y
 Qyfuhw/Li5VBwNFJMZxW4HAngtawXaRe+jeO/q6zh5BvPvewdWV3avp1i71U2S+vY5cW
 ZZSTiYoEoSFLYga3bI7mLKpQabGqT4mxot64XExx1wKTZ2dNyuJKSili5JHv5Ct40Ft/
 QVzFE+sXEW/1y00b5kolD9t91YMgv+rE1YZ7sf5i51i8NTFaqv9+81Pmf58uofF2t5l9
 MKCw==
X-Gm-Message-State: AOJu0YwY44J7cbSsqxg5TVMtgwPG37ikMT7qRPflrPes/XhBTkdIRQnX
 a4ZaHCEdjXO8UUEp2TtriMWaXn3eDZzE/jmn4At+W2zG8MktgCsXdDQps1ypQwCZxBB0/Wf1sQE
 8aJDKVFIX/BHcU3f41SZEJhryoCo=
X-Gm-Gg: ASbGncv9LgazeNH6AggV3fBN44Lr+8OVTmiV1T70LESU0xFRmkOiqtTO2YYg59PA04H
 1dS9W095CRXllUd9/kHGDxvDVPe7yqO7Gp/unl3apn0FTi2w0QB8rkuHY2JkMokv7fcaXSLk25N
 Jnf0nSDDEwpaKokPi9RtzWQFELcRzs
X-Google-Smtp-Source: AGHT+IFC9K3ZF61em6IqeUFCfxzG8qglyhELEFXPuhQO7WyCxUQEwIW5gn6mpUUGbAsNrxiJMd5RSAu4BmKZgDTf0XA=
X-Received: by 2002:a05:651c:1504:b0:30b:d187:622b with SMTP id
 38308e7fff4ca-30bd7a53bedmr11306511fa.18.1741169208255; Wed, 05 Mar 2025
 02:06:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
 <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
In-Reply-To: <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
From: prashant patil <pmgpatil@gmail.com>
Date: Wed, 5 Mar 2025 15:36:35 +0530
X-Gm-Features: AQ5f1JqqpivS5m1Qqn-6fjWXPA1DKTlyIhQKm4dM9dKQpeCAfRDm_7iuLrgKefo
Message-ID: <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
Subject: Re: Query on the dirty bitmap
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000026ee09062f958cfa"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=pmgpatil@gmail.com; helo=mail-lj1-x229.google.com
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

--00000000000026ee09062f958cfa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was trying to read the bitmap of the running vm's disk. When I followed
below mentioned commands, then I was able to read the bitmap properly.
block-dirty-bitmap-add, block-dirty-bitmap-disable, nbd-server-start,
nbd-server-add, qemu-img
map with x-dirty-bitmap image-opts.

Please let me know if there is any other better alternative to do the same.

Thanks
Prashant

On Fri, Feb 28, 2025 at 3:53=E2=80=AFAM Eric Blake <eblake@redhat.com> wrot=
e:

> On Wed, Feb 19, 2025 at 04:23:26PM +0530, prashant patil wrote:
> > Hello All,
> > Hope this email finds you well.
> >
> > I have been trying with qemu for a while now, and have come across a
> > problem specific to dirty bitmaps. I have enabled bitmap on the qcow2
> disk
> > image using 'qemu-img bitmap' command, exposed the bitmap over a unix
> > socket using 'qemu-nbd' command. Now when I try to read the bitmap usin=
g
> > 'qemu-img map' command with 'x-dirty-bitmap=3Dqemu:dirty-bitmap:{bitmap=
}'
> > option, I get one single extent which shows that the entire disk is
> dirty.
> > Note that the disk size is 5 GB, and has only a few MB of data in it, a=
nd
> > had added very small data after the bitmap was enabled. Bitmap output h=
as
> > been pasted below.
>
> Can you show the exact sequence of command lines you used to create
> the image, dirty a portion of it, then start up the qemu-nbd process
> to inspect it?  As written, I can't reproduce your issue, but I know
> it sounds similar to tests/qemu-iotests/tests/qemu-img-bitmaps which
> does what you're talking about, so I know the code works and have to
> suspect you may have missed a step or reordered things in such a way
> that the entire bitmap is reading as dirty.
>
> >
> > [{ "start": 0, "length": 5368709120, "depth": 0, "present": true, "zero=
":
> > false, "data": true, "compressed": false, "offset": 0}]
> >
> > Can someone please help me understand why the bitmap content shows the
> > entire disk as dirty?
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>
>

--00000000000026ee09062f958cfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I was trying to read the bitmap of the running vm&#39;s di=
sk. When I followed below mentioned commands, then I was able to read the b=
itmap properly.<div>block-dirty-bitmap-add,=C2=A0block-dirty-bitmap-disable=
,=C2=A0nbd-server-start,=C2=A0nbd-server-add,=C2=A0qemu-img map with x-dirt=
y-bitmap image-opts.</div><div><br><div>Please let me know if there is any =
other better alternative to do the same.</div></div><div><br></div><div>Tha=
nks</div><div>Prashant</div></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2025 at 3=
:53=E2=80=AFAM Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, Feb 19, 2025 at 04:23:26PM +0530, prashant patil wrote:<=
br>
&gt; Hello All,<br>
&gt; Hope this email finds you well.<br>
&gt; <br>
&gt; I have been trying with qemu for a while now, and have come across a<b=
r>
&gt; problem specific to dirty bitmaps. I have enabled bitmap on the qcow2 =
disk<br>
&gt; image using &#39;qemu-img bitmap&#39; command, exposed the bitmap over=
 a unix<br>
&gt; socket using &#39;qemu-nbd&#39; command. Now when I try to read the bi=
tmap using<br>
&gt; &#39;qemu-img map&#39; command with &#39;x-dirty-bitmap=3Dqemu:dirty-b=
itmap:{bitmap}&#39;<br>
&gt; option, I get one single extent which shows that the entire disk is di=
rty.<br>
&gt; Note that the disk size is 5 GB, and has only a few MB of data in it, =
and<br>
&gt; had added very small data after the bitmap was enabled. Bitmap output =
has<br>
&gt; been pasted below.<br>
<br>
Can you show the exact sequence of command lines you used to create<br>
the image, dirty a portion of it, then start up the qemu-nbd process<br>
to inspect it?=C2=A0 As written, I can&#39;t reproduce your issue, but I kn=
ow<br>
it sounds similar to tests/qemu-iotests/tests/qemu-img-bitmaps which<br>
does what you&#39;re talking about, so I know the code works and have to<br=
>
suspect you may have missed a step or reordered things in such a way<br>
that the entire bitmap is reading as dirty.<br>
<br>
&gt; <br>
&gt; [{ &quot;start&quot;: 0, &quot;length&quot;: 5368709120, &quot;depth&q=
uot;: 0, &quot;present&quot;: true, &quot;zero&quot;:<br>
&gt; false, &quot;data&quot;: true, &quot;compressed&quot;: false, &quot;of=
fset&quot;: 0}]<br>
&gt; <br>
&gt; Can someone please help me understand why the bitmap content shows the=
<br>
&gt; entire disk as dirty?<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libguestfs.org" rel=3D"norefer=
rer" target=3D"_blank">libguestfs.org</a><br>
<br>
</blockquote></div>

--00000000000026ee09062f958cfa--

