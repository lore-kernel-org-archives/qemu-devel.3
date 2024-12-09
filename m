Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E17CE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 01:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKSoE-0008Kw-5A; Sun, 08 Dec 2024 20:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tKSoC-0008Kj-Gh
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 20:43:36 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tKSoA-0000dq-NG
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 20:43:36 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2eb1433958dso2722003a91.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733708613; x=1734313413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=koi3c9HHgXj9b++VLF2OIEjaR1CmcKhhcRm/xXYePAs=;
 b=HWLW6X4tBFl1PrQ4xfS3bJMhJdynEwDuRl+iczVGxVzvGJMyHZsOAylFcQgEwfNUrx
 MFbJrffLfrLwndohCfEM53tvgJJF+wrnIyOfpm4d79v8pLxSa+iz3PM+mzimdFifAqk3
 X6/3IK0L/B03V6SnoEHlyGwkOIkWFOAUfjaKeKPSTgtUyoQzgffnNSvSTrAuK8qTfxcM
 6NqjF1W3NPKfhOHSTZwh3IBUa802BX75OoqIiWYljSane5rD9T7rJd/svWlobGJTmKM2
 XYa3F0hGuYdMsM7T8xbOm5Ae5dnCwxDnVZj8Fvk3Q2BCKT8Zn5hoglz9Ov3PPcOBOrCM
 AOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733708613; x=1734313413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koi3c9HHgXj9b++VLF2OIEjaR1CmcKhhcRm/xXYePAs=;
 b=OyMmiKRxQaUvOF2gAwrH10qtlaDYk8YsHSI2Ih88NprmjXl/TXpoXm96fs/Q1tKpJC
 c33MmXFcxz/hkHcFFbFdMkAuCvqBULMLQaMbXGlyJR6j+jxOnSLKhOH1uZ5e1Hvd1N1t
 N+DhA70XqKDTo/mnCAne1gyREaPtKU50e07UVOYZINU5nFwuMCSw3ZRNDwoqcAXlf+bk
 7UCNXK6wymb5owJlm0OfeRQ9hkH8l/GHjMO3bwoV+Sda1nQjDd0NX79ZaqkisfXAUUCI
 +NLyu8H7SSwyUoDRXtqCjLBNDs0zur4AY1tNJrn9fsZQf0PvWqkk+m1s5NIyc9YJI0iR
 ijRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYIZ5FYHIJp7rl2YBfeZXsp4/i2RvP0fz75iXK0qBvgKyuelCEZR8YB2QcaXAUgwgdINKDiteXXp4V@nongnu.org
X-Gm-Message-State: AOJu0YwqSXjj4uOQx+ESSNO2cJffNqVAgWZFpMDFEohUdGip1WGgB3JD
 JrP7cueULKNWykmcG0U96B0T7t5IRoj3qsGHZVDtOaVggkQP6BV5zG8YcNKhc3mbmvXNSBYGmUq
 TH//PpAdpM1h9hFZIVDGAFbnGuxA=
X-Gm-Gg: ASbGncszao1dqS0uMHN3/QS01Q100/0DKPp1egutoB51kDTt4h/c4NBzU31WQ/hSZMu
 mvqfbOqTH42AfN5n3hnfSlIMKpapOftc=
X-Google-Smtp-Source: AGHT+IEFpSBgA4+ECBkl9bzfR19CjuBbvw6miuIbLX2RWbGmhHzC+335qdIR1UYPr38riLakLvo7189ywlWt0/k9dEY=
X-Received: by 2002:a17:90b:2246:b0:2ee:f653:9f8e with SMTP id
 98e67ed59e1d1-2ef6ab29349mr17380647a91.35.1733708612573; Sun, 08 Dec 2024
 17:43:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1DJroYiKUwK-kMY@x1n>
 <CAK3tnvLsfe2FJ-zVkJRCk1xKDJ0ULP8DFaDMOFgDFCF4d+0j2g@mail.gmail.com>
 <3c40ff15-0b7d-40bc-a11e-c1cb2efd7785@maciej.szmigiero.name>
 <Z1N2yc18MNFcz2uN@x1n>
In-Reply-To: <Z1N2yc18MNFcz2uN@x1n>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 9 Dec 2024 09:43:21 +0800
Message-ID: <CAK3tnvJV7KFzjXftqtPv6mQAnpj453ENnkcVXE3xp5rMTJcqFA@mail.gmail.com>
Subject: Re: [PATCH v3 05/24] migration: Add MIG_CMD_SWITCHOVER_START and its
 load handler
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabiano Rosas <farosas@suse.de>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ff2eb40628cc7d08"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102b.google.com
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

--000000000000ff2eb40628cc7d08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 7, 2024, 6:12=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Fri, Dec 06, 2024 at 07:24:58PM +0100, Maciej S. Szmigiero wrote:
> > On 5.12.2024 20:46, Zhang Chen wrote:
> > > On Thu, Dec 5, 2024 at 5:30=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > > >
> > > > On Sun, Nov 17, 2024 at 08:20:00PM +0100, Maciej S. Szmigiero wrote=
:
> > > > > diff --git a/migration/colo.c b/migration/colo.c
> > > > > index 9590f281d0f1..a75c2c41b464 100644
> > > > > --- a/migration/colo.c
> > > > > +++ b/migration/colo.c
> > > > > @@ -452,6 +452,9 @@ static int
> colo_do_checkpoint_transaction(MigrationState *s,
> > > > >           bql_unlock();
> > > > >           goto out;
> > > > >       }
> > > > > +
> > > > > +    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
> > > > > +
> > > > >       /* Note: device state is saved into buffer */
> > > > >       ret =3D qemu_save_device_state(fb);
> > > >
> > > > Looks all good, except I'm not sure whether we should touch colo.
> IIUC it
> > > > should be safer to remove it.
> > > >
> > >
> > > Agree with Peter's comments.
> > > If I understand correctly, the current COLO doesn't support multifd
> migration.
> >
> > This patch adds a generic migration bit stream command, which could be
> used
> > for other purposes than multifd device state migration too.
> >
> > It just so happens we make use of it for VFIO driver multifd device sta=
te
> > migration currently since we need a way to achieve the same functionali=
ty
> > as save_live_complete_precopy_{begin,end} handlers did in the previous
> > versions of this patch set.
> >
> > Since adding this bit stream command to COLO does not cost anything
> > (it's already behind a compatibility migration property) and it may be
> > useful in the future I would advise to keep it there.
> >
> > On the other hand, if we don't add it to COLO now but it turns out it
> > will be needed there to implement some functionality in the future then
> > we'll need to add yet another compatibility migration property for that=
.
>
> There's one thing still slightly off for COLO, where IIUC COLO runs that =
in
> a loop to synchronize device states (colo_do_checkpoint_transaction()) to
> the other side, so that's not exactly where the "switchover" (in COLO's
> wording, I think it's called "failover") happens for COLO..  Hence the na=
me
> qemu_savevm_maybe_send_switchover_start() may be slightly misleading in
> COLO's case..
>
> But that's not a huge deal.  At least I checked and I agree the code shou=
ld
> work for COLO too, and I think COLO should need something like machine ty=
pe
> to work properly across upgrades, in that case I think COLO is safe.  So
> I'm OK with keeping this, as long as Chen doesn't object.
>
>
Thanks for explaining the details of this series. I think it's OK after
rechecked COLO code, feel free to add my reviewed-by for COLO part.

Thanks
Chen


> --
> Peter Xu
>
>

--000000000000ff2eb40628cc7d08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Dec 7, 2024, 6:12=E2=80=AFAM Peter Xu &lt;<a h=
ref=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Fri, Dec 06, 2024 at 07:24:58PM +0100, Ma=
ciej S. Szmigiero wrote:<br>
&gt; On 5.12.2024 20:46, Zhang Chen wrote:<br>
&gt; &gt; On Thu, Dec 5, 2024 at 5:30=E2=80=AFAM Peter Xu &lt;<a href=3D"ma=
ilto:peterx@redhat.com" target=3D"_blank" rel=3D"noreferrer">peterx@redhat.=
com</a>&gt; wrote:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; On Sun, Nov 17, 2024 at 08:20:00PM +0100, Maciej S. Szmigier=
o wrote:<br>
&gt; &gt; &gt; &gt; diff --git a/migration/colo.c b/migration/colo.c<br>
&gt; &gt; &gt; &gt; index 9590f281d0f1..a75c2c41b464 100644<br>
&gt; &gt; &gt; &gt; --- a/migration/colo.c<br>
&gt; &gt; &gt; &gt; +++ b/migration/colo.c<br>
&gt; &gt; &gt; &gt; @@ -452,6 +452,9 @@ static int colo_do_checkpoint_trans=
action(MigrationState *s,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bql_unlock();<b=
r>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 qemu_savevm_maybe_send_switchover_start(=
s-&gt;to_dst_file);<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Note: device state is save=
d into buffer */<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_save_device_stat=
e(fb);<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Looks all good, except I&#39;m not sure whether we should to=
uch colo.=C2=A0 IIUC it<br>
&gt; &gt; &gt; should be safer to remove it.<br>
&gt; &gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Agree with Peter&#39;s comments.<br>
&gt; &gt; If I understand correctly, the current COLO doesn&#39;t support m=
ultifd migration.<br>
&gt; <br>
&gt; This patch adds a generic migration bit stream command, which could be=
 used<br>
&gt; for other purposes than multifd device state migration too.<br>
&gt; <br>
&gt; It just so happens we make use of it for VFIO driver multifd device st=
ate<br>
&gt; migration currently since we need a way to achieve the same functional=
ity<br>
&gt; as save_live_complete_precopy_{begin,end} handlers did in the previous=
<br>
&gt; versions of this patch set.<br>
&gt; <br>
&gt; Since adding this bit stream command to COLO does not cost anything<br=
>
&gt; (it&#39;s already behind a compatibility migration property) and it ma=
y be<br>
&gt; useful in the future I would advise to keep it there.<br>
&gt; <br>
&gt; On the other hand, if we don&#39;t add it to COLO now but it turns out=
 it<br>
&gt; will be needed there to implement some functionality in the future the=
n<br>
&gt; we&#39;ll need to add yet another compatibility migration property for=
 that.<br>
<br>
There&#39;s one thing still slightly off for COLO, where IIUC COLO runs tha=
t in<br>
a loop to synchronize device states (colo_do_checkpoint_transaction()) to<b=
r>
the other side, so that&#39;s not exactly where the &quot;switchover&quot; =
(in COLO&#39;s<br>
wording, I think it&#39;s called &quot;failover&quot;) happens for COLO..=
=C2=A0 Hence the name<br>
qemu_savevm_maybe_send_switchover_start() may be slightly misleading in<br>
COLO&#39;s case..<br>
<br>
But that&#39;s not a huge deal.=C2=A0 At least I checked and I agree the co=
de should<br>
work for COLO too, and I think COLO should need something like machine type=
<br>
to work properly across upgrades, in that case I think COLO is safe.=C2=A0 =
So<br>
I&#39;m OK with keeping this, as long as Chen doesn&#39;t object.<br><br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks=
 for explaining the details of this series. I think it&#39;s OK after reche=
cked COLO code, feel free to add my reviewed-by for COLO part.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Thanks</div><div dir=3D"auto">Chen</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div></div></div>

--000000000000ff2eb40628cc7d08--

