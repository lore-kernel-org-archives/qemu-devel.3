Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28549D6EBF1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGxvM-0008Fq-H7; Fri, 29 Nov 2024 05:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tGxvJ-0008A2-Hu
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:08:29 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tGxvF-0007bc-G7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:08:28 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71d3e506981so645851a34.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1732874901; x=1733479701;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dEPCOgIK6HyZDUPkNY8dkYwh9clQfbQpgKA6KXMQQU=;
 b=MjXywpRu9ogj+SFcz9lrLzAISq5Zgtey08B04YuClU0DAoOErv7M86mU8yFkDj0Sjs
 Ri26lDTV/SmX/oXQHIlbx2xVWKxAM+6nyPJeUyUCT+8y0ZlE6yyHyrTVueDiI6NqaW79
 GYL7hFsY1AprdIhmOCpqB5PYESGOo3nwsIMe4YML20zAPBdMoEj4TjpveN2ABOUMubE5
 I3eFd7A36T+4vwqFL6RKMGIYOO9m9AaRZ8Am21ziGle5nnapgS8Tw4Jm1lr9sEhoXr88
 2DHiwRroPxuLA7nMqJ3gUV7kgNJAoVOG9Mu2yZZBrDoy4o6VGBUxhVfRIPt5xcVJP6F0
 z8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732874901; x=1733479701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dEPCOgIK6HyZDUPkNY8dkYwh9clQfbQpgKA6KXMQQU=;
 b=uc8bRpVd95Kc3fZeLJS7G27Mt4sEMdDVjInjQfXjkk5Q3cJvhCyWkkMCjNhbpRvAbC
 hKDgYO6VrdJcgnuB7J6QRWwaD5u1L9/sj7Cdjecbk7Ncz2hyKvuTNYYhsxWOwmoblR6R
 2kFVkQs2SA1xC7wisU2M0UqRQFHw3DCQyhsCqyJVROsxxbqXgWTFbt1lBUG0L/7UbICS
 Lo7b449WlhQwwlmVM6W0O3WGXG5FJbO6pYKrjFeXbh3shvENu5D+UPcqYf3QMivNGD0u
 loQoDvHrvOo0lfdXIBDSzkPG+ZzxFZOoodpqY5GhD6WYaSszvCXK+8PzAKCaXV7UC11T
 1a5A==
X-Gm-Message-State: AOJu0Ywmi2BVKTcd6IAVL1GEuiZ+OAkFmbPAHNDZfPjSdQ4TPxmEm/Sd
 ZeLkdI2h33DYAo1Hx/ABvNSmXF1WWCf9bq4uSMIGbdGPqqRuHyjzZ9xz+BGZR4T1p+N2YWgrWhp
 3gTya9KdMZ+sDS1z+lPs4XuHpz+k13VMsA2Hdlg==
X-Gm-Gg: ASbGncstjEz5xdWGaj6cydGIuf5yH6hKXPJ7We51XN4JGI8a3yRMvFBej/wY1ZOzARX
 2+lyW7f0/kfzhtinTT/Cm0+nIK+2B6j8n
X-Google-Smtp-Source: AGHT+IGpF+HPqApUtNELq1+JO58Qnv9DDT9+HgFP2HFl7YXXkBuDsS6+Q5AOpXoqlGG2GCfRmSPoUqll/uOCIs+Nm1A=
X-Received: by 2002:a05:6830:7318:b0:718:19a9:434d with SMTP id
 46e09a7af769-71d65c7dfb6mr8490377a34.1.1732874900908; Fri, 29 Nov 2024
 02:08:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
In-Reply-To: <87sesmdfl4.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 29 Nov 2024 18:08:05 +0800
Message-ID: <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e8c1dd06280a60b6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000e8c1dd06280a60b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wr=
ote:

> yong.huang@smartx.com writes:
>
> > From: Hyman Huang <yong.huang@smartx.com>
> >
> > v3:
> > 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by
> Daniel
> >
> > Please review, thanks
> > Yong
> >
> > v2:
> > 1. Update the MAINTAINERS section suggested by Fabiano Rosas
> > 2. Ensure the dependencies when build the initrd-stress.img suggested b=
y
> Daniel
> > 3. Fix some bugs
> >
> > v1:
> > The previous patchset:
> >
> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx=
.com/
> > does not made the necessary changes and tests for the upstream version.
> >
> > This patchset works for that:
> > 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
> > 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
> > 3. Make the necessary changes to adapt the latest multifd behavior
> > 4. A nitpick for multifd migration
> > 5. Support multifd compression option
> >
> > Hyman Huang (5):
> >   tests/migration: Move the guestperf tool to scripts directory
> >   tests/migration: Make initrd-stress.img built by default
> >   guestperf: Support deferred migration for multifd
> >   guestperf: Nitpick the inconsistent parameters
> >   guestperf: Introduce multifd compression option
> >
> >  MAINTAINERS                                   |  5 +++
> >  .../migration/guestperf-batch.py              |  0
> >  .../migration/guestperf-plot.py               |  0
> >  {tests =3D> scripts}/migration/guestperf.py     |  0
> >  .../migration/guestperf/__init__.py           |  0
> >  .../migration/guestperf/comparison.py         | 15 ++++++++-
> >  .../migration/guestperf/engine.py             | 33 ++++++++++++++++---
> >  .../migration/guestperf/hardware.py           |  0
> >  .../migration/guestperf/plot.py               |  0
> >  .../migration/guestperf/progress.py           |  0
> >  .../migration/guestperf/report.py             |  0
> >  .../migration/guestperf/scenario.py           |  7 ++--
> >  .../migration/guestperf/shell.py              |  3 ++
> >  .../migration/guestperf/timings.py            |  0
> >  tests/migration/meson.build                   | 30 +++++++++--------
> >  15 files changed, 73 insertions(+), 20 deletions(-)
> >  rename {tests =3D> scripts}/migration/guestperf-batch.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf-plot.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/__init__.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/comparison.py (89%)
> >  rename {tests =3D> scripts}/migration/guestperf/engine.py (93%)
> >  rename {tests =3D> scripts}/migration/guestperf/hardware.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/plot.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/progress.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/report.py (100%)
> >  rename {tests =3D> scripts}/migration/guestperf/scenario.py (93%)
> >  rename {tests =3D> scripts}/migration/guestperf/shell.py (98%)
> >  rename {tests =3D> scripts}/migration/guestperf/timings.py (100%)
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
>
> Thinking out loud a little bit, it's still somewhat obscure from which
> directory this script should be called. None of these invocations work:
>
> $ ./scripts/migration/guestperf.py
>
> $ ./build/scripts/migration/guestperf.py
>
> $ cd scripts/migration
> $ ./guestperf.py
>
> $ cd build/scripts/migration
> $ ./guestperf.py
>
> Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D: =
open() failed:
> No such file or directory
>
> This is the only one that works:
> $ cd build
> $ ./scripts/migration/guestperf.py
>
> Maybe we could improve that somehow in the future.
>
>
This patchset could be queued now,
Or after refining the documents mentioned above later?

--=20
Best regards

--000000000000e8c1dd06280a60b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas &lt;<a href=3D"m=
ailto:farosas@suse.de">farosas@suse.de</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:=
1ex"><a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yong.huang@=
smartx.com</a> writes:<br>
<br>
&gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=
=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;<br>
&gt; v3:<br>
&gt; 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by=
 Daniel <br>
&gt;<br>
&gt; Please review, thanks<br>
&gt; Yong<br>
&gt;<br>
&gt; v2:<br>
&gt; 1. Update the MAINTAINERS section suggested by Fabiano Rosas <br>
&gt; 2. Ensure the dependencies when build the initrd-stress.img suggested =
by Daniel<br>
&gt; 3. Fix some bugs<br>
&gt;<br>
&gt; v1:<br>
&gt; The previous patchset:<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/cover.1722957352.git.yon=
g.huang@smartx.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/</a><br>
&gt; does not made the necessary changes and tests for the upstream version=
.<br>
&gt;<br>
&gt; This patchset works for that:<br>
&gt; 1. Move the guestperf to scripts directory suggested by Fabiano Rosas<=
br>
&gt; 2. Make initrd-stress.img built by default suggested by Fabiano Rosas<=
br>
&gt; 3. Make the necessary changes to adapt the latest multifd behavior<br>
&gt; 4. A nitpick for multifd migration<br>
&gt; 5. Support multifd compression option<br>
&gt;<br>
&gt; Hyman Huang (5):<br>
&gt;=C2=A0 =C2=A0tests/migration: Move the guestperf tool to scripts direct=
ory<br>
&gt;=C2=A0 =C2=A0tests/migration: Make initrd-stress.img built by default<b=
r>
&gt;=C2=A0 =C2=A0guestperf: Support deferred migration for multifd<br>
&gt;=C2=A0 =C2=A0guestperf: Nitpick the inconsistent parameters<br>
&gt;=C2=A0 =C2=A0guestperf: Introduce multifd compression option<br>
&gt;<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 5 +++<br>
&gt;=C2=A0 .../migration/guestperf-batch.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf-plot.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 {tests =3D&gt; scripts}/migration/guestperf.py=C2=A0 =C2=A0 =C2=
=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/comparison.py=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 15 ++++++++-<br>
&gt;=C2=A0 .../migration/guestperf/engine.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 33 ++++++++++++++++---<br>
&gt;=C2=A0 .../migration/guestperf/hardware.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/plot.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/progress.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/report.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 .../migration/guestperf/scenario.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 7 ++--<br>
&gt;=C2=A0 .../migration/guestperf/shell.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++<br>
&gt;=C2=A0 .../migration/guestperf/timings.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 tests/migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +++++++++--------<br>
&gt;=C2=A0 15 files changed, 73 insertions(+), 20 deletions(-)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf-batch.py (100=
%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf-plot.py (100%=
)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf.py (100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/__init__.py (=
100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/comparison.py=
 (89%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/engine.py (93=
%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/hardware.py (=
100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/plot.py (100%=
)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/progress.py (=
100%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/report.py (10=
0%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/scenario.py (=
93%)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/shell.py (98%=
)<br>
&gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/timings.py (1=
00%)<br>
<br>
Reviewed-by: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D=
"_blank">farosas@suse.de</a>&gt;<br>
<br>
<br>
Thinking out loud a little bit, it&#39;s still somewhat obscure from which<=
br>
directory this script should be called. None of these invocations work:<br>
<br>
$ ./scripts/migration/guestperf.py<br>
<br>
$ ./build/scripts/migration/guestperf.py<br>
<br>
$ cd scripts/migration<br>
$ ./guestperf.py<br>
<br>
$ cd build/scripts/migration<br>
$ ./guestperf.py<br>
<br>
Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D: op=
en() failed:<br>
No such file or directory<br>
<br>
This is the only one that works:<br>
$ cd build<br>
$ ./scripts/migration/guestperf.py<br>
<br>
Maybe we could improve that somehow in the future.<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">This patc=
hset could be queued now,</div><div style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif" class=3D"gmail_default">Or after refining the documents=
 mentioned=C2=A0above later?</div></div><div><br></div><span class=3D"gmail=
_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"=
><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</fo=
nt></div></div></div>

--000000000000e8c1dd06280a60b6--

