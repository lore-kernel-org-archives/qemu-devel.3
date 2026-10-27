Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF77606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cL8dO4VH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjkq-0005oF-Bs; Tue, 27 Oct 2026 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xLjki-0005jV-Ik
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:10:20 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1xLjkf-0007YR-Uz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:10:19 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-47b47de8b4cso39050fac.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 09:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793117416; cv=none;
 d=google.com; s=arc-20260327;
 b=EQAuVIp8m5Y6aGMbUoQCD7W6Cjbb1xoadfPrQ1ACxf0KR+RXVkXq9hkwX0zTQeb3N/
 GhlPU9qNGVbL/fWZD4g9H4JBC2SJY3KvIC01tRtGmNVlP8YgLGl9DNfyLporwuG05ZO3
 H686fOOX9mKF6eu3ZtIuZRBnCkITAdjooNQuPK6g8cvb4hUdPPVvpuHH4dz/HwHxB8ov
 01WXE3eOiM2cO00j5mr8xi3P07aJGRnAYSMRypU/Lm4DdsmEsVeu5uGfEORbsvsg7DOK
 ihDa9p8Ts6DHqrFOigl2YK7gBWHjwkS2QjgjZ3ois33ZbJCnbPykLZ6nQ0LiqA7d6veE
 lHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=22ZGWv4+9pZrjz0bydQgSEjwCRyyuJev0Z5+29t2P0Y=;
 fh=6czfcAJfDmmN3XL32rileFAc4KWn6CYOehApDowJF/Q=;
 b=sXObdSY0tyAWBxfFiGm8NfF5tjeCsyPhDZmUlZkQpkgVM+B/RU5u6XrWeusPhquHFl
 MF307b9FBDtcQQpwmcXK9bD7hAtGJFtb+2tObWIYNJk3F6kuwAgzsJOTF68/y6+5rlgI
 q34hz7bRL4oL8cUzAvlOqsR3u0aePWQUwPFRjACEwud0wgKFoAnRdrHueVlKoRIxlXfD
 mZ0lyWUeMPGrCKkdqxaQg52JCKur6+1pIRG3jspzj5tTlp5ge7YeXHCdF4alxCQyM62N
 8iX40zLYDYO1rnnf8UFGvChOsNJXUk+ofFOfVA85ABFRWc7qynbXODAUYKmclt+pckJh
 RbPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793117416; x=1793722216; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=22ZGWv4+9pZrjz0bydQgSEjwCRyyuJev0Z5+29t2P0Y=;
 b=cL8dO4VHl12T/RSeDk4ghcmiLrqV7E6hIbQNfo7woYEde8n2LstkNLHZc0EYfRjreu
 EDx9QEzG4XjDG23cDg09TMP9uc/EmSu571d+VlQv4XmRjMckZUSOmnhaZ2ru8DQQNzwk
 0tgy1uMI0sIH40tItkUwQ7fuPxfnHGR3QEKevbZMEFQtp+3p8SpSLYm4+1w3ZRokpU9x
 0mJvBWez9glaR7bX/Ju0gKPhIJpfF9mc8kjIhVYAQUDUHxH8+lNq7tAHdTuesokhNTM8
 bSldyWbz1KBYBbk8JpkIHbD6DyN8YjUQz9sF2TEb9XAWh18oGhCHE5HpQbLOSqux1xDY
 avyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793117416; x=1793722216;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=22ZGWv4+9pZrjz0bydQgSEjwCRyyuJev0Z5+29t2P0Y=;
 b=bjgzKQbXtznFzraTlQXzk4N/cdlHfRcLZgGT5KU9FAIDbakrK69j4tJX1xZYuIxa3d
 d4/5iuu4sJ3I9ro0TDbuxnJ41BDIFOeCYDhjuj242Nd425XMmhsHAn5+LFgzPOW5BU5v
 lsGS7bsP4gd8EFAhGrkuMZSQLKHAfgJgrW2c7w+hcrUbY1AyZwH/qaevPmkbu8ln3qs2
 UEESFLH5OISVmOv1ha8WeElijRViKrT7I+2zowCemapVMwwP+Xpul/sRGLeAlKQEc1Ov
 57NwcWk6TggdzumZtZ5kxVck0lrPcW5urQ+7/K8fcYU205hOOokOVI/cgTwWaOwuM4dF
 ZH7w==
X-Gm-Message-State: AFq9FYJDlh+y9IkQ/iDBBe/SF1tpczdOkEBCFRMG1ujwnE3dYtZRd7pq
 qUkyEMgIaDsr3VWRFA+LfDo93g87WdIIAMh5lk9Ucx/jtSJtW09zPkDiv/jQZCkGYqxzfCq43ah
 Oewsy3TOQgNhoFef2qRUTgD9icOQgXkU=
X-Gm-Gg: AYBFou0HKyjv5a60jaolK3VixCQNi1ZVHHJniZrtZ13NlXcEe1hlC2OjT0mk4lTTgQx
 7YsVAtYPjPguDQZDEiBzCgp5rdKnZpFvTZ6dfQzdRNcLjGGFRJVtifUnjGQ0bQbd8pU0gmqajwz
 UIPe0jUWMLzATD0fXKNAvX8dubo9O6bDTE9QE3OK0/JhIWyLNXqUk+s5LxofUOoyr+JYxhnrQQd
 RjVmhpWaKfDVv5u6Nx+7XDwwux/Zkvxb0iMmTHRfnBXjByMsU/nXLyy4DQyzN1cO4vzZ5QHhVge
 c+/VZhia0sOK+lw+jGA9tQkVotqjLsHNibOHLhzw7R85XDS9xAqDDOTrGtYl+i9dp+hcu8PNGA1
 D2kVdWXm8GG+CDRl/+42r455hCwgOoKQbqd0A
X-Received: by 2002:a05:6870:82a2:b0:483:cb42:3979 with SMTP id
 586e51a60fabf-4a83f4ea50cmr7042118fac.17.1793117415998; Tue, 27 Oct 2026
 09:10:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260903044626.24453-1-54weasels@gmail.com>
 <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
 <8310b400-544e-4ed5-8eb6-e0797a924a8d@ilande.co.uk>
 <CAFWf6u86nFtQNfD=NFwUPamRKpt+EJg0vYhc1AALkGHJwtqZ+w@mail.gmail.com>
 <CAFWf6u-WJu6fh_Kc1aFo+fy4ffJzv7u25F8xVo4ZhtOxv2EgmQ@mail.gmail.com>
 <CAFWf6u-XwAdVNg-1Q5EuHQQSJL-h1qsnzhdgeOYTQGciMu9Gzw@mail.gmail.com>
In-Reply-To: <CAFWf6u-XwAdVNg-1Q5EuHQQSJL-h1qsnzhdgeOYTQGciMu9Gzw@mail.gmail.com>
From: Purr Box <54weasels@gmail.com>
Date: Tue, 27 Oct 2026 09:10:06 -0700
X-Gm-Features: AclHuK8goinjNJM5VZglS4qZMhdcb9BIb8FEvZvEKWD6q3uxBVnSqq1WySW_Olk
Message-ID: <CAFWf6u-3vvjOqkg=0mhNcjgTd0GvT78nyR8n+3B2B+=x5Qr8bg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement missing functionality and hooks in m68k
 to support upcoming Sun-3 implementation
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, 
 BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="0000000000009f0a46065ed4ae35"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=54weasels@gmail.com; helo=mail-oa1-x31.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000009f0a46065ed4ae35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi again,

Is there anything I can do to help get this reviewed more easily? I know
it's a hobby, not a potentially commercial project. I appreciate the
maintainers' valuable time.and genuinely would like to hear from you. If
these components are frozen or in maintenance mode please let me know.

Thanks again for your help,
Dan.

On Sat, Oct 10, 2026, 13:04 Purr Box <54weasels@gmail.com> wrote:

> Hi folks - gentle ping. After the 68k patches it's all other devices so
> the patch train should move easier. I also have SCSI support and others
> pending.
>
> Thank you very much in advance,
> Dan.
>
> On Sat, Sep 26, 2026, 09:30 Purr Box <54weasels@gmail.com> wrote:
>
>> Hi and quick ping if you could take a look at the series.
>>
>> Thanks,
>> Dan.
>>
>> On Fri, Sep 18, 2026 at 8:11=E2=80=AFAM Purr Box <54weasels@gmail.com> w=
rote:
>>
>>> Thank you very much in advance! I'm looking forward to getting sun3
>>> supported.
>>>
>>> Dan.
>>>
>>> On Fri, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Ayland <
>>> mark.cave-ayland@ilande.co.uk> wrote:
>>>
>>>> On 09/09/2026 19:54, Purr Box wrote:
>>>>
>>>> > Gentle ping on this series. v5 addresses Zoltan's review feedback
>>>> from v4 (fsave
>>>> > simplification, NMI edge-trigger rationale, added Signed-off-by).
>>>> Would appreciate
>>>> > any review when you have a chance.
>>>>
>>>> Apologies for the delay: I will have quick look through the series ove=
r
>>>> the next few
>>>> days, although I suspect I'd need to defer to Laurent's greater 68k
>>>> knowledge here.
>>>>
>>>> > Dan.
>>>> >
>>>> > On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels <54weasels@gmail.co=
m
>>>> > <mailto:54weasels@gmail.com>> wrote:
>>>> >
>>>> >     This series adds M68020/030-specific features to the m68k target
>>>> that
>>>> >     are required by the Sun-3 machine (series C) and its PROM/SunOS
>>>> guests:
>>>> >
>>>> >        1/6: CAAR register stub for 68020/030 cache control
>>>> >        2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
>>>> >        3/6: Edge-triggered NMI semantics for Level 7 interrupts
>>>> >        4/6: Function code extraction during TLB fills
>>>> >        5/6: Custom MMU intercept hook for Sun-3 transparent
>>>> translation
>>>> >        6/6: Physical Bus Error and M68020 Format 0xB stack frames
>>>> >
>>>> >     Changes since v4:
>>>> >        - Added Signed-off-by to all patches.
>>>> >        - Patch 2/6 (fsave): Addressed Zoltan's review =E2=80=94 repl=
aced
>>>> redundant
>>>> >          M68040||FPU check with just M68K_FEATURE_FPU, removed
>>>> unnecessary
>>>> >          if/else in frestore, moved Context: below --- separator.
>>>> >        - Patch 3/6 (NMI): Addressed Zoltan's review =E2=80=94 nmi_pe=
nding
>>>> cannot be
>>>> >          replaced by testing pending_level =3D=3D 7. The flag captur=
es
>>>> the edge
>>>> >          transition (level < 7 =E2=86=92 7) required by Motorola's N=
MI
>>>> specification,
>>>> >          while pending_level only reflects the current interrupt
>>>> level.
>>>> >          Testing pending_level alone would produce level-triggered
>>>> behavior,
>>>> >          firing on every interrupt check rather than once per edge.
>>>> >        - Rebased on current master.
>>>> >
>>>> >     54weasels (6):
>>>> >        target/m68k: Add dummy CAAR register
>>>> >        target/m68k: Fix fsave/frestore for 68881 FPU
>>>> >        target/m68k: Fix NMI pending for Level 7 interrupts
>>>> >        target/m68k: Extract Function Codes during TLB fills
>>>> >        target/m68k: Implement custom MMU intercept hook
>>>> >        target/m68k: Implement Physical Bus Error and Stack
>>>> >
>>>> >       target/m68k/cpu.c       |   4 +-
>>>> >       target/m68k/cpu.h       |  21 ++++-
>>>> >       target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
>>>> >       target/m68k/op_helper.c | 175
>>>> ++++++++++++++++++++++++++--------------
>>>> >       target/m68k/translate.c |  30 ++++---
>>>> >       5 files changed, 280 insertions(+), 80 deletions(-)
>>>> >
>>>> >     --
>>>> >     2.50.1 (Apple Git-155)
>>>>
>>>>
>>>> ATB,
>>>>
>>>> Mark.
>>>>
>>>>

--0000000000009f0a46065ed4ae35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi again,<div dir=3D"auto"><br></div><div dir=3D"auto">Is=
 there anything I can do to help get this reviewed more easily? I know it&#=
39;s a hobby, not a potentially commercial project. I appreciate the mainta=
iners&#39; valuable time.and genuinely would like to hear=C2=A0from you. If=
 these components are frozen or in maintenance mode please=C2=A0let me know=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks again=C2=A0for =
your help,</div><div dir=3D"auto">Dan.</div></div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, O=
ct 10, 2026, 13:04 Purr Box &lt;<a href=3D"mailto:54weasels@gmail.com">54we=
asels@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div=
 dir=3D"auto">Hi folks - gentle ping. After the 68k patches it&#39;s all ot=
her devices so the patch train should move easier. I also have SCSI support=
 and others pending.<div dir=3D"auto"><br></div><div dir=3D"auto">Thank you=
 very much in advance,</div><div dir=3D"auto">Dan.</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 26, 202=
6, 09:30 Purr Box &lt;<a href=3D"mailto:54weasels@gmail.com" target=3D"_bla=
nk" rel=3D"noreferrer">54weasels@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr">Hi and quick ping if you could take=
 a look at the series.<div><br></div><div>Thanks,</div><div>Dan.</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fr=
i, Sep 18, 2026 at 8:11=E2=80=AFAM Purr Box &lt;<a href=3D"mailto:54weasels=
@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">54weasels@gmail=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div dir=3D"ltr">Thank you very much in advance! I&#39;m looking forwar=
d to getting sun3 supported.<div><br></div><div>Dan.</div><div></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri=
, Sep 18, 2026 at 6:32=E2=80=AFAM Mark Cave-Ayland &lt;<a href=3D"mailto:ma=
rk.cave-ayland@ilande.co.uk" rel=3D"noreferrer noreferrer" target=3D"_blank=
">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 09/09/2026 19:54, Purr Box wrote:<br>
<br>
&gt; Gentle ping on this series. v5 addresses Zoltan&#39;s review feedback =
from v4 (fsave <br>
&gt; simplification, NMI edge-trigger rationale, added Signed-off-by). Woul=
d appreciate <br>
&gt; any review when you have a chance.<br>
<br>
Apologies for the delay: I will have quick look through the series over the=
 next few <br>
days, although I suspect I&#39;d need to defer to Laurent&#39;s greater 68k=
 knowledge here.<br>
<br>
&gt; Dan.<br>
&gt; <br>
&gt; On Wed, Sep 2, 2026 at 9:46=E2=80=AFPM 54weasels &lt;<a href=3D"mailto=
:54weasels@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">54wea=
sels@gmail.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:54weasels@gmail.com" rel=3D"noreferrer no=
referrer" target=3D"_blank">54weasels@gmail.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This series adds M68020/030-specific features to th=
e m68k target that<br>
&gt;=C2=A0 =C2=A0 =C2=A0are required by the Sun-3 machine (series C) and it=
s PROM/SunOS guests:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 1/6: CAAR register stub for 68020/030 cache=
 control<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 2/6: fsave/frestore fix for 68881 (non-6804=
0) FPU frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 3/6: Edge-triggered NMI semantics for Level=
 7 interrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 4/6: Function code extraction during TLB fi=
lls<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 5/6: Custom MMU intercept hook for Sun-3 tr=
ansparent translation<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 6/6: Physical Bus Error and M68020 Format 0=
xB stack frames<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Changes since v4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Added Signed-off-by to all patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Patch 2/6 (fsave): Addressed Zoltan&#39;s=
 review =E2=80=94 replaced redundant<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 M68040||FPU check with just M68K_FEA=
TURE_FPU, removed unnecessary<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if/else in frestore, moved Context: =
below --- separator.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Patch 3/6 (NMI): Addressed Zoltan&#39;s r=
eview =E2=80=94 nmi_pending cannot be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replaced by testing pending_level =
=3D=3D 7. The flag captures the edge<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transition (level &lt; 7 =E2=86=92 7=
) required by Motorola&#39;s NMI specification,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while pending_level only reflects th=
e current interrupt level.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Testing pending_level alone would pr=
oduce level-triggered behavior,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firing on every interrupt check rath=
er than once per edge.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 - Rebased on current master.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A054weasels (6):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Add dummy CAAR register<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Fix fsave/frestore for 68881 F=
PU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Fix NMI pending for Level 7 in=
terrupts<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Extract Function Codes during =
TLB fills<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Implement custom MMU intercept=
 hook<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 target/m68k: Implement Physical Bus Error a=
nd Stack<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 21 ++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/helper.c=C2=A0 =C2=A0 | 130 ++++=
++++++++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/op_helper.c | 175 ++++++++++++++=
++++++++++++--------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0target/m68k/translate.c |=C2=A0 30 ++++---<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A05 files changed, 280 insertions(+), 80 delet=
ions(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.50.1 (Apple Git-155)<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--0000000000009f0a46065ed4ae35--

