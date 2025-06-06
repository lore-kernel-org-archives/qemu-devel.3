Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A715FC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWvU-0004Tr-Nn; Fri, 06 Jun 2025 09:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1844144@gmail.com>) id 1uNWvS-0004TT-PI
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:16:03 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <1844144@gmail.com>) id 1uNWvN-0002DX-8Z
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:16:00 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso1184599a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749215752; x=1749820552; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VNCBkpCYOSzJPoJlmhakWTqjTJ5UMwxILOrOTVeY9y4=;
 b=PlQiQ1S+wWYrm9EAi3Wgp6OUyAxqnmWo+ZZNyGmVSpZr0ucnDlmrLi/yMMPCzpGNPt
 3Z2T5H6fZdHheSHs5PQojiDcBt6n58YKBcts1+LPsuiRGICPnH+lMOdTKhB4Nm+Zbxa/
 Jy4m+MqallqiDKzKbwmpGyaWw7Pc+IPS/9+Sj2Hg4476R3JmBO9XjbNlGl5ghgvWQy/X
 BfqQd9drveOGvnSgW6DW1VtiVUARoyDfyV+JzGOwodpMVo6kkn3idkmzKRBX19tnPxBI
 bZ+ut1Mhvq415aKCmwS2nZRwwnW961D0jMUr8ZYtmTMKNRX0f3JyEqAswryhNMFBkNuJ
 UFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749215752; x=1749820552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNCBkpCYOSzJPoJlmhakWTqjTJ5UMwxILOrOTVeY9y4=;
 b=IuCZf5R01bApgbhvwD7BnVMsqxIgxlIi5emZDmCtPW6O38FsmANAaAr+ikDd8wfd0x
 6Vr2M5FKimgSbUD2w9s6ulk72TOpWJOZ9cSNGvWgBhhaHVENfqjaGXyzDv+qbx8kfwHy
 GH3D1bB9qsFk+CYKTcaFCrzDHN61JD4lIvQaO1TGOzUEbLIAaaNBRij1aCuJ4PVH0Nte
 v4lZvdfr1bJKTWT+1OSrmDMh3/0X+e0BAYPm/5quLG6iwJ5ErFdHZBiUh6tommY/kSxZ
 4S2yrNVqZ7y7KqM3JyM6LTJKiXPevcNKW2Y7Y5QbKdx0ZiQUZ+DtGat0phvpf/XPpYQO
 MThg==
X-Gm-Message-State: AOJu0YxKz2/syy0042if1VrsV0aj2TdHjjyT2sDnAuUQonNjMkohXqgB
 UFjphm6RexhQVTT2Ox8NjLHAdHs7IPdjPQ9hrfn0MFoRFLRjc31l83RS/7BpRVL2DOZEXd33Vmy
 AGAVmmNxdzXWN2I0r4zcRF6AFXfNFqpc=
X-Gm-Gg: ASbGncscfA/3d87c7lPuEiwtFBna/Y217yrszpYhEZCajI2gv4Jf4SvdFf+eqI3pM+v
 qpvys715XRAvEaR0vbFZCcZNu43AolPAZ0cIAdw138XAfy7YmTIXhDQZPQFbvAtJZMohQVCZqsY
 MqTNfnXlEtUKOj4A3+CbxufX41BIYzk7wdHZw=
X-Google-Smtp-Source: AGHT+IGs41t76FQLEgV5oWcBV71vkwO9k5noxOdNYwxW4LKw/ciA4t+LGxM4lDzi/24U2UCIQY7vRDQha2Kh1p7p2gQ=
X-Received: by 2002:a17:90b:4c52:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-31346af99a1mr4700885a91.5.1749215752046; Fri, 06 Jun 2025
 06:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250603125459.17688-1-1844144@gmail.com>
 <87bjr15his.fsf@draig.linaro.org>
In-Reply-To: <87bjr15his.fsf@draig.linaro.org>
From: =?UTF-8?B?0JLQu9Cw0LTQuNC80LjRgCDQmy4=?= <1844144@gmail.com>
Date: Fri, 6 Jun 2025 15:15:40 +0200
X-Gm-Features: AX0GCFuPTafcOpPnzbyfcG8cHeEKcyuEV_fKcHHY_AVfcd3vJlQMeZMiwzxregg
Message-ID: <CAEROef0Xu_2m51U-hvPkwQZsD27hjr8XcpJ6DnNnCXCD-mUHyA@mail.gmail.com>
Subject: Re: [PATCH] record/replay: fix race condition on
 test_aarch64_reverse_debug
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000894be40636e707ae"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=1844144@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000894be40636e707ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for responding!
Usual flow was
    source build/pyvenv/bin/activate
    export PYTHONBREAKPOINT=3D"ipdb.set_trace"
    export
QEMU_TEST_QEMU_BINARY=3D/home/lukvladimir/dev/qemu/build/qemu-system-aarch6=
4

If missing python packages / avocado

    pip install -e python/
    pip install avocado-framework

Then

    QEMU_TEST_FLAKY_TESTS=3D1 avocado -V  run
tests/functional/test_aarch64_reverse_debug.py

Or
    QEMU_TEST_FLAKY_TESTS=3D1 tests/functional/test_aarch64_reverse_debug.p=
y

On Fri, 6 Jun 2025 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

> Vladimir Lukianov <1844144@gmail.com> writes:
>
> > Ensures EVENT_INSTRUCTION written to replay.bin before
> EVENT_SHUTDOWN_HOST_QMP
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2921
> > Signed-off-by: Vladimir Lukianov <1844144@gmail.com>
> > ---
> > During the record pass, test_reverse_debug writes a sequence of
> > instructions to replay.bin. Presumably due to a race condition or
> > host's async implementation details, the resulting file looks like:
> >
> > ...
> > 12: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
> > 13: EVENT_INSTRUCTION(0) + 59 -> 44298
> > 14: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
> > 15: EVENT_SHUTDOWN_HOST_QMP_QUIT(12)
> > 16: EVENT_INSTRUCTION(0) + 5587988 -> 5632286
> > 17: EVENT_SHUTDOWN_HOST_SIGNAL(14)
> > 18: EVENT_END(39)
> > Reached 162 of 162 bytes
> >
> > Here, SHUTDOWN_HOST_QMP_QUIT is written before the last instruction
> > event. During the replay pass, QUIT is executed before the last
> > instruction, which causes the VM to shut down. As a result, the QMP
> > and GDB connections are broken, and the test cannot execute its final
> > steps.
>
> Seems reasonable to me.
>
> >
> > Adding replay_save_instructions ensures EVENT_INSTRUCTION is written
> > before EVENT_SHUTDOWN_HOST_QMP_QUIT.
> >
> > Tested on my arm64. This does not fix the bug on x86_64. The x86_64
> > case seems similar, but slightly different.
>
> Hmm I can't run the functional tests due to missing avocado bits. How
> did you run the tests?
>
> >
> >  replay/replay.c                                | 2 ++
> >  tests/functional/test_aarch64_reverse_debug.py | 1 -
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/replay/replay.c b/replay/replay.c
> > index a3e24c96..b2121788 100644
> > --- a/replay/replay.c
> > +++ b/replay/replay.c
> > @@ -263,6 +263,8 @@ bool replay_has_interrupt(void)
> >
> >  void replay_shutdown_request(ShutdownCause cause)
> >  {
> > +    replay_save_instructions();
> > +
> >      if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
> >          g_assert(replay_mutex_locked());
> >          replay_put_event(EVENT_SHUTDOWN + cause);
> > diff --git a/tests/functional/test_aarch64_reverse_debug.py
> b/tests/functional/test_aarch64_reverse_debug.py
> > index 58d45328..0ac1ccb0 100755
> > --- a/tests/functional/test_aarch64_reverse_debug.py
> > +++ b/tests/functional/test_aarch64_reverse_debug.py
> > @@ -26,7 +26,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
> >           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
> >
> '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
> >
> > -    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2921
> ")
> >      def test_aarch64_virt(self):
> >          self.set_machine('virt')
> >          self.cpu =3D 'cortex-a53'
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000894be40636e707ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, thanks for responding!<br>Usual flow was<br>=C2=A0 =C2=
=A0 source build/pyvenv/bin/activate<br>=C2=A0 =C2=A0 export PYTHONBREAKPOI=
NT=3D&quot;ipdb.set_trace&quot;<br>=C2=A0 =C2=A0 export QEMU_TEST_QEMU_BINA=
RY=3D/home/lukvladimir/dev/qemu/build/qemu-system-aarch64<br><br>If missing=
 python packages / avocado <br><br>=C2=A0 =C2=A0 pip install -e python/<br>=
=C2=A0 =C2=A0 pip install avocado-framework<br>=C2=A0 =C2=A0 <br>Then <br><=
br>=C2=A0 =C2=A0 QEMU_TEST_FLAKY_TESTS=3D1 avocado -V =C2=A0run tests/funct=
ional/test_aarch64_reverse_debug.py<br><br>Or<br>=C2=A0 =C2=A0 QEMU_TEST_FL=
AKY_TESTS=3D1 tests/functional/test_aarch64_reverse_debug.py<br></div><br><=
div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, 6 Jun 2025 at 11:46, Alex Benn=C3=A9e &lt;<a href=3D"mai=
lto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Vladimir Lukianov &lt;<a =
href=3D"mailto:1844144@gmail.com" target=3D"_blank">1844144@gmail.com</a>&g=
t; writes:<br>
<br>
&gt; Ensures EVENT_INSTRUCTION written to replay.bin before EVENT_SHUTDOWN_=
HOST_QMP<br>
&gt;<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/292=
1" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2921</a><br>
&gt; Signed-off-by: Vladimir Lukianov &lt;<a href=3D"mailto:1844144@gmail.c=
om" target=3D"_blank">1844144@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; During the record pass, test_reverse_debug writes a sequence of<br>
&gt; instructions to replay.bin. Presumably due to a race condition or<br>
&gt; host&#39;s async implementation details, the resulting file looks like=
:<br>
&gt;<br>
&gt; ...<br>
&gt; 12: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data=C2=A0 <br>
&gt; 13: EVENT_INSTRUCTION(0) + 59 -&gt; 44298=C2=A0 <br>
&gt; 14: EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data=C2=A0 <br>
&gt; 15: EVENT_SHUTDOWN_HOST_QMP_QUIT(12)=C2=A0 <br>
&gt; 16: EVENT_INSTRUCTION(0) + 5587988 -&gt; 5632286=C2=A0 <br>
&gt; 17: EVENT_SHUTDOWN_HOST_SIGNAL(14)=C2=A0 <br>
&gt; 18: EVENT_END(39)=C2=A0 <br>
&gt; Reached 162 of 162 bytes<br>
&gt;<br>
&gt; Here, SHUTDOWN_HOST_QMP_QUIT is written before the last instruction<br=
>
&gt; event. During the replay pass, QUIT is executed before the last<br>
&gt; instruction, which causes the VM to shut down. As a result, the QMP<br=
>
&gt; and GDB connections are broken, and the test cannot execute its final<=
br>
&gt; steps.<br>
<br>
Seems reasonable to me.<br>
<br>
&gt;<br>
&gt; Adding replay_save_instructions ensures EVENT_INSTRUCTION is written<b=
r>
&gt; before EVENT_SHUTDOWN_HOST_QMP_QUIT.<br>
&gt;<br>
&gt; Tested on my arm64. This does not fix the bug on x86_64. The x86_64<br=
>
&gt; case seems similar, but slightly different.<br>
<br>
Hmm I can&#39;t run the functional tests due to missing avocado bits. How<b=
r>
did you run the tests?<br>
<br>
&gt;<br>
&gt;=C2=A0 replay/replay.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
&gt;=C2=A0 tests/functional/test_aarch64_reverse_debug.py | 1 -<br>
&gt;=C2=A0 2 files changed, 2 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/replay/replay.c b/replay/replay.c<br>
&gt; index a3e24c96..b2121788 100644<br>
&gt; --- a/replay/replay.c<br>
&gt; +++ b/replay/replay.c<br>
&gt; @@ -263,6 +263,8 @@ bool replay_has_interrupt(void)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 void replay_shutdown_request(ShutdownCause cause)<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 replay_save_instructions();<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (replay_mode =3D=3D REPLAY_MODE_RECORD) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(replay_mutex_locked());<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_put_event(EVENT_SHUTDOWN + ca=
use);<br>
&gt; diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/fu=
nctional/test_aarch64_reverse_debug.py<br>
&gt; index 58d45328..0ac1ccb0 100755<br>
&gt; --- a/tests/functional/test_aarch64_reverse_debug.py<br>
&gt; +++ b/tests/functional/test_aarch64_reverse_debug.py<br>
&gt; @@ -26,7 +26,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;releases/29/Everything/aa=
rch64/os/images/pxeboot/vmlinuz&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;7e1430b81c26bdd0da025eeb8fbd77b=
5dc961da4364af26e771bd39f379cbbf7&#39;)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 @skipFlakyTest(&quot;<a href=3D"https://gitlab.com/qemu=
-project/qemu/-/issues/2921" rel=3D"noreferrer" target=3D"_blank">https://g=
itlab.com/qemu-project/qemu/-/issues/2921</a>&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def test_aarch64_virt(self):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.set_machine(&#39;virt&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cpu =3D &#39;cortex-a53&#39;<br=
>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000894be40636e707ae--

