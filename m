Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C849D73604
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 14:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHO35-0006fQ-2O; Sat, 30 Nov 2024 09:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tHO2z-0006ek-UK
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 09:02:10 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tHO2w-00069G-Cf
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 09:02:09 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-296c237a121so1677191fac.2
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 06:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1732975321; x=1733580121;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QOj0Rpo+xPE6R2mMCfYl3o5FNz3TtlkydvfKu1XUPaQ=;
 b=WE1XKDriXeThJzsfX+DZsMkdnTlYOBAPDrDwvixPJRHr3B7w0aWMVgzSat1XAQgOPi
 dkEZHQgQK/gGg0cEcSKFPPWXaP+a2ODfFj3Igne1LFmj6mq3c+2NZUv1BaB3IY30+XM6
 OyaTHKhuCUEa44ATfrTHmbPPIrPzgsewFr5p2VXFwni5t51w1fDHP2nDSa6nM6pWLY+d
 y2b8XmRrm08ZHmJohWaQrw5bfbzwLKNOYauHShmwOZ1XFFqykkeN7rbuZKxEJb4ZlrsZ
 NxQ2FdH4DkFcIJYQIGuHwOIIsu0vJS2SkKHMi6v8cgPF+X9AwG5CZo/FeKhFpxk8+Tr3
 AfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732975321; x=1733580121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOj0Rpo+xPE6R2mMCfYl3o5FNz3TtlkydvfKu1XUPaQ=;
 b=BgKvpaA5jz7QyRv+DwF197Dw4+ekrjcO567fyRbzk9wPrKYYmUjFgtzmsuf0jE1rIW
 dAwlVDqvsG1tWyLPHrWXnjAu/KzH4L4MMDAQurtUtWs/kl8p7zn0TtrAwIGfFhdisUMd
 lF+hlQFhOheEid3eoRM2B9GhZrT05mfZ/4m7/rrdjgCn1gccskEAXQwiNPPUfu9n5uCa
 rfQfpxWJtvuXnoBLFjcas2RohOH9abNvXLs6zdj9TwzHnMGZi9YgZYAOJUzybQagnbj0
 yqqAFlvc5iNOjMSNzxQgOB7+rgtnsvMJGLw6Dh/EiWFFqvL3RaaaHR7RtfJWiQ0AXE7D
 YB0g==
X-Gm-Message-State: AOJu0YwhUKJ03uQg1xpVxaNA/OmRA1ZfIknu3QtN7ag1mcjxVrlbMnP4
 r8vkjZDZqCUaC73FDwU0oNA27VjPHxb0FsiCkUrpqKjOkSA4WQ+QW4cid7KE2onhG1H/pnQv6oh
 b8R9EojmvKKFO6B9nqBPTq57KAcTlHmww9FIkJw==
X-Gm-Gg: ASbGncuP/2Fp+/T3y20dNA+4KSKsNZzyndRzReeLVnuJ77VqsoWA8bULBvGguDH/vjE
 PPYANINhCDZd4Vv4/TBDxEilDMgxDFsHC
X-Google-Smtp-Source: AGHT+IFUT9dHLxrrllN+0jeRyHjPvWLUAQCSwz88oq8pQtv9QRVqJTQXqVPelFHR315pTPvRWhGL+MW0LVcWib8s5Sk=
X-Received: by 2002:a05:6871:799f:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-29dc4012c99mr11053373fac.12.1732975319259; Sat, 30 Nov 2024
 06:01:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
In-Reply-To: <87plmejgtb.fsf@suse.de>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 30 Nov 2024 22:01:43 +0800
Message-ID: <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004f8c03062821c2b9"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2f.google.com
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

--0000000000004f8c03062821c2b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 9:44=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:

> Fabiano Rosas <farosas@suse.de> writes:
>
> > Yong Huang <yong.huang@smartx.com> writes:
> >
> >> On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas <farosas@suse.d=
e> wrote:
> >>
> >>> yong.huang@smartx.com writes:
> >>>
> >>> > From: Hyman Huang <yong.huang@smartx.com>
> >>> >
> >>> > v3:
> >>> > 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested
> by
> >>> Daniel
> >>> >
> >>> > Please review, thanks
> >>> > Yong
> >>> >
> >>> > v2:
> >>> > 1. Update the MAINTAINERS section suggested by Fabiano Rosas
> >>> > 2. Ensure the dependencies when build the initrd-stress.img
> suggested by
> >>> Daniel
> >>> > 3. Fix some bugs
> >>> >
> >>> > v1:
> >>> > The previous patchset:
> >>> >
> >>>
> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx=
.com/
> >>> > does not made the necessary changes and tests for the upstream
> version.
> >>> >
> >>> > This patchset works for that:
> >>> > 1. Move the guestperf to scripts directory suggested by Fabiano Ros=
as
> >>> > 2. Make initrd-stress.img built by default suggested by Fabiano Ros=
as
> >>> > 3. Make the necessary changes to adapt the latest multifd behavior
> >>> > 4. A nitpick for multifd migration
> >>> > 5. Support multifd compression option
> >>> >
> >>> > Hyman Huang (5):
> >>> >   tests/migration: Move the guestperf tool to scripts directory
> >>> >   tests/migration: Make initrd-stress.img built by default
> >>> >   guestperf: Support deferred migration for multifd
> >>> >   guestperf: Nitpick the inconsistent parameters
> >>> >   guestperf: Introduce multifd compression option
> >>> >
> >>> >  MAINTAINERS                                   |  5 +++
> >>> >  .../migration/guestperf-batch.py              |  0
> >>> >  .../migration/guestperf-plot.py               |  0
> >>> >  {tests =3D> scripts}/migration/guestperf.py     |  0
> >>> >  .../migration/guestperf/__init__.py           |  0
> >>> >  .../migration/guestperf/comparison.py         | 15 ++++++++-
> >>> >  .../migration/guestperf/engine.py             | 33
> ++++++++++++++++---
> >>> >  .../migration/guestperf/hardware.py           |  0
> >>> >  .../migration/guestperf/plot.py               |  0
> >>> >  .../migration/guestperf/progress.py           |  0
> >>> >  .../migration/guestperf/report.py             |  0
> >>> >  .../migration/guestperf/scenario.py           |  7 ++--
> >>> >  .../migration/guestperf/shell.py              |  3 ++
> >>> >  .../migration/guestperf/timings.py            |  0
> >>> >  tests/migration/meson.build                   | 30 +++++++++------=
--
> >>> >  15 files changed, 73 insertions(+), 20 deletions(-)
> >>> >  rename {tests =3D> scripts}/migration/guestperf-batch.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf-plot.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/__init__.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/comparison.py (89%=
)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/engine.py (93%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/hardware.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/plot.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/progress.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/report.py (100%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/scenario.py (93%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/shell.py (98%)
> >>> >  rename {tests =3D> scripts}/migration/guestperf/timings.py (100%)
> >>>
> >>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >>>
> >>>
> >>> Thinking out loud a little bit, it's still somewhat obscure from whic=
h
> >>> directory this script should be called. None of these invocations wor=
k:
> >>>
> >>> $ ./scripts/migration/guestperf.py
> >>>
> >>> $ ./build/scripts/migration/guestperf.py
> >>>
> >>> $ cd scripts/migration
> >>> $ ./guestperf.py
> >>>
> >>> $ cd build/scripts/migration
> >>> $ ./guestperf.py
> >>>
> >>> Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=
=9D: open() failed:
> >>> No such file or directory
> >>>
> >>> This is the only one that works:
> >>> $ cd build
> >>> $ ./scripts/migration/guestperf.py
> >>>
> >>> Maybe we could improve that somehow in the future.
> >>>
> >>>
> >> This patchset could be queued now,
> >> Or after refining the documents mentioned above later?
> >
> > I think it's ok. Let me just rebase this on top of the other series tha=
t
> > touches the tests/migration/ directory. I'll repost soon.
>
> Well, not so fast, the CI doesn't like the addition of stress.c:
>
> https://gitlab.com/farosas/qemu/-/jobs/8504697373
> clang: error: argument unused during compilation: '-pie'


> https://gitlab.com/farosas/qemu/-/jobs/8504697378
> undefined reference to `_DYNAMIC'
>

OK, I'll fix that once I have time.

Thanks,
Yong

--=20
Best regards

--0000000000004f8c03062821c2b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Fri, Nov 29, 2024 at 9:44=E2=80=AFPM Fabiano Rosas &lt;<a href=3D"ma=
ilto:farosas@suse.de">farosas@suse.de</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1=
ex">Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D"_blank">=
farosas@suse.de</a>&gt; writes:<br>
<br>
&gt; Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_bla=
nk">yong.huang@smartx.com</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas &lt;<a href=
=3D"mailto:farosas@suse.de" target=3D"_blank">farosas@suse.de</a>&gt; wrote=
:<br>
&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank">yon=
g.huang@smartx.com</a> writes:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt; From: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx=
.com" target=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; v3:<br>
&gt;&gt;&gt; &gt; 1. Remove the two redundant assignments in [PATCH v2 2/5]=
 suggested by<br>
&gt;&gt;&gt; Daniel<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Please review, thanks<br>
&gt;&gt;&gt; &gt; Yong<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; v2:<br>
&gt;&gt;&gt; &gt; 1. Update the MAINTAINERS section suggested by Fabiano Ro=
sas<br>
&gt;&gt;&gt; &gt; 2. Ensure the dependencies when build the initrd-stress.i=
mg suggested by<br>
&gt;&gt;&gt; Daniel<br>
&gt;&gt;&gt; &gt; 3. Fix some bugs<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; v1:<br>
&gt;&gt;&gt; &gt; The previous patchset:<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; <a href=3D"https://lore.kernel.org/qemu-devel/cover.1722957352=
.git.yong.huang@smartx.com/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/</a><b=
r>
&gt;&gt;&gt; &gt; does not made the necessary changes and tests for the ups=
tream version.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; This patchset works for that:<br>
&gt;&gt;&gt; &gt; 1. Move the guestperf to scripts directory suggested by F=
abiano Rosas<br>
&gt;&gt;&gt; &gt; 2. Make initrd-stress.img built by default suggested by F=
abiano Rosas<br>
&gt;&gt;&gt; &gt; 3. Make the necessary changes to adapt the latest multifd=
 behavior<br>
&gt;&gt;&gt; &gt; 4. A nitpick for multifd migration<br>
&gt;&gt;&gt; &gt; 5. Support multifd compression option<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Hyman Huang (5):<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0tests/migration: Move the guestperf tool to s=
cripts directory<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0tests/migration: Make initrd-stress.img built=
 by default<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0guestperf: Support deferred migration for mul=
tifd<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0guestperf: Nitpick the inconsistent parameter=
s<br>
&gt;&gt;&gt; &gt;=C2=A0 =C2=A0guestperf: Introduce multifd compression opti=
on<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 5 +++<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf-batch.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf-plot.py=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 {tests =3D&gt; scripts}/migration/guestperf.py=C2=
=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/__init__.py=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/comparison.py=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 15 ++++++++-<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/engine.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 33 ++++++++++++++++---<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/hardware.py=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/plot.py=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/progress.py=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/report.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/scenario.py=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++--<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/shell.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++<br>
&gt;&gt;&gt; &gt;=C2=A0 .../migration/guestperf/timings.py=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;&gt;&gt; &gt;=C2=A0 tests/migration/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 +++++++++--------<br>
&gt;&gt;&gt; &gt;=C2=A0 15 files changed, 73 insertions(+), 20 deletions(-)=
<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf-=
batch.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf-=
plot.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf.=
py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
__init__.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
comparison.py (89%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
engine.py (93%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
hardware.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
plot.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
progress.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
report.py (100%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
scenario.py (93%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
shell.py (98%)<br>
&gt;&gt;&gt; &gt;=C2=A0 rename {tests =3D&gt; scripts}/migration/guestperf/=
timings.py (100%)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Reviewed-by: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.=
de" target=3D"_blank">farosas@suse.de</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thinking out loud a little bit, it&#39;s still somewhat obscur=
e from which<br>
&gt;&gt;&gt; directory this script should be called. None of these invocati=
ons work:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; $ ./scripts/migration/guestperf.py<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; $ ./build/scripts/migration/guestperf.py<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; $ cd scripts/migration<br>
&gt;&gt;&gt; $ ./guestperf.py<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; $ cd build/scripts/migration<br>
&gt;&gt;&gt; $ ./guestperf.py<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=
=E2=80=9D: open() failed:<br>
&gt;&gt;&gt; No such file or directory<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is the only one that works:<br>
&gt;&gt;&gt; $ cd build<br>
&gt;&gt;&gt; $ ./scripts/migration/guestperf.py<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Maybe we could improve that somehow in the future.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt; This patchset could be queued now,<br>
&gt;&gt; Or after refining the documents mentioned above later?<br>
&gt;<br>
&gt; I think it&#39;s ok. Let me just rebase this on top of the other serie=
s that<br>
&gt; touches the tests/migration/ directory. I&#39;ll repost soon.<br>
<br>
Well, not so fast, the CI doesn&#39;t like the addition of stress.c:<br>
<br>
<a href=3D"https://gitlab.com/farosas/qemu/-/jobs/8504697373" rel=3D"norefe=
rrer" target=3D"_blank">https://gitlab.com/farosas/qemu/-/jobs/8504697373</=
a><br>
clang: error: argument unused during compilation: &#39;-pie&#39;=C2=A0</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,20=
4,204);padding-left:1ex">
<br>
<a href=3D"https://gitlab.com/farosas/qemu/-/jobs/8504697378" rel=3D"norefe=
rrer" target=3D"_blank">https://gitlab.com/farosas/qemu/-/jobs/8504697378</=
a><br>
undefined reference to `_DYNAMIC&#39;<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">OK, I&#39=
;ll fix that once I have time.</div><br></div><div><div style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks,=C2=
=A0</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cl=
ass=3D"gmail_default">Yong</div></div><div><br></div><span class=3D"gmail_s=
ignature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font=
></div></div></div>

--0000000000004f8c03062821c2b9--

