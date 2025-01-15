Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5496C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8uB-0001hf-Ap; Wed, 15 Jan 2025 14:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tY8u9-0001hT-C3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:18:17 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tY8u6-0008OD-PD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:18:17 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29ff5c75c21so685554fac.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 11:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736968692; x=1737573492;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iodi9xMzlaaSMIUwmP6LeBv/7ifJZOIGLZJp6W0cGBQ=;
 b=XKHZ7ROWB3ZBzV9re/Gs+h/ixZbc5yM8WjfVPNGL1iHfmniriHFPuVGdtbVoUa+NNS
 0SRvFNI3IfEUHxZC2RL9QzxZBPakIFdEmPAT7NV88Pn4WHvEczS4unYYOSL2NVgt78B2
 yS12RtvmIhN3Ofg/UZzsrRxGwVUevghDm1umOTzkOgn3QJJxLscF4ijgB6U6d/s1Tbrp
 px2KzJb9ys/uocOBt07EncSEoCQ5G6216DZSLlqgPFBAW5p/cIKfb95ouMsPFQXQlH4A
 Sp5NWHIt8AlZo81fwE73Qo3HF9awM9gRy8XAxZGRCWOy5S2u2P/S82oGX9JrE7FT9gE+
 7H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736968692; x=1737573492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iodi9xMzlaaSMIUwmP6LeBv/7ifJZOIGLZJp6W0cGBQ=;
 b=R0WRTq4n0ZdnPMuBA1P47UwqSOdSvXywyQKQCf7CLzgsrZdcL95I9BO8wv3s9QAj4V
 16QYV3Ih9kI4DbAhcrvjAsSAYYYkFZ6FLk6XH4wjjFEnAtMcEIRILcZXPRpxsd0h0alo
 JsvwLuAIUhdwLw3nC4xAlR+k/krrj6C1kT6KBWXD7hc+K9uBWc+yAUsymA/zcQ+nm9gs
 gfsWeO5GhhlSbaS6BIY4FjbEnRvo7utLYJ1RRDqzPOT2KNKhJnA56/FwZPson3zKnOwh
 2L4IAQ9TshOqb+d0z/Ih5FfQ7N/DTJ4OqkuVnK94UwoO0MogkTiuKvoBzVocGpfGc01m
 OrKA==
X-Gm-Message-State: AOJu0YwmJovg15CuoEA+oe8YDxYhcE6V0DrZGH5njAlgzuZnHySg0lC7
 8Ol87S0LcmB0QBb4YGaOzd56e4ACc2bCkjj/snWKKdm9AgvE/xB6OZi5bQb/TzJZ7JmS4xdF31I
 Zl4+me/nnAN/2FzvYoKV3Rw1svYVz4cvTN9qZ
X-Gm-Gg: ASbGnctP5qLepXTqMnf3a9wVBj9/Fr4Wb0AF55I5CiYQGclFcz/lVkyt6C81Cx++kSs
 YzFSVbCq5DFy6ZDnntcy95y/Pj9l4qqIM4zeboA==
X-Google-Smtp-Source: AGHT+IGERfV17Ue1a/spIiZOCKkuslHQ87Ce8SnVd5pBxvbjT3Tsn82vKGvqu2qvKCOv8wX19hv1HSURgBdTvDeGutY=
X-Received: by 2002:a05:6870:7e8a:b0:277:d8c3:b539 with SMTP id
 586e51a60fabf-2b186c9b3d0mr2761424fac.16.1736968690935; Wed, 15 Jan 2025
 11:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20250112212609.17996-1-phil@philjordan.eu>
 <8dff3836-1c96-4ae8-a9d8-f86f97d78986@redhat.com>
In-Reply-To: <8dff3836-1c96-4ae8-a9d8-f86f97d78986@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 15 Jan 2025 20:17:58 +0100
X-Gm-Features: AbW1kvZBaa8ZLXOzs4CwaEmZKf9J7qTLi6k4nk5cqdscoi9iuQ3Jxrs70KBXx-Q
Message-ID: <CAAibmn22AxOYRy4yWxcdsX4VooRGiqvpCNG4dRNnKWEcMbtwgg@mail.gmail.com>
Subject: Re: [PATCH] system/runstate: Fix regression, clarify BQL status of
 exit notifiers
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, akihiko.odaki@daynix.com, 
 dwmw2@infradead.org
Content-Type: multipart/alternative; boundary="000000000000cf49a5062bc389fe"
Received-SPF: neutral client-ip=2001:4860:4864:20::31;
 envelope-from=phil@philjordan.eu; helo=mail-oa1-x31.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000cf49a5062bc389fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed 15. Jan 2025 at 20:05, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 1/12/25 22:26, Phil Dennis-Jordan wrote:
> > By changing the way the main QEMU event loop is invoked, I inadvertentl=
y
> > changed the BQL status of exit notifiers: some of them implicitly
> > assumed they would be called with the BQL held; the BQL is however
> > not held during the exit(status) call in qemu_default_main().
> >
> > Instead of attempting to ensuring we always call exit() from the BQL -
> > including any transitive calls - this change adds a BQL lock guard to
> > qemu_run_exit_notifiers, ensuring the BQL will always be held in the
> > exit notifiers.
> >
> > Additionally, the BQL promise is now documented at the
> > qemu_{add,remove}_exit_notifier() declarations.
> >
> > Fixes: f5ab12caba4f ("ui & main loop: Redesign of system-specific main
> > thread event handling")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2771
> > Reported-by: David Woodhouse <dwmw2@infradead.org>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>
> I'm worried that this breaks for exit() calls that happen within a
> BQL-taken area (for example, anything that uses error_fatal) due to...
>
> void bql_lock_impl(const char *file, int line)
> {
>      QemuMutexLockFunc bql_lock_fn =3D qatomic_read(&bql_mutex_lock_func)=
;
>
>      g_assert(!bql_locked()); // <--- this
>      bql_lock_fn(&bql, file, line);
>      set_bql_locked(true);
> }
>

BQL_LOCK_GUARD expands to a call to bql_auto_lock(), which in turn defends
against recursive locking by checking bql_locked().

https://gitlab.com/qemu-project/qemu/-/blob/master/include/qemu/main-loop.h=
#L377

I think that should make it safe?

The only safety issue I can imagine is that exit() is called in a thread
where the BQL is not held, but a BQL-holding thread is waiting for that
thread. But I=E2=80=99m not sure such a pattern exists in QEMU though, and =
it would
have triggered the assertion in the original code. (before my patch causing
the regression was applied)

>
>
>

--000000000000cf49a5062bc389fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Wed 15. Jan 2025 at 20:05, Paolo Bon=
zini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;bo=
rder-left-color:rgb(204,204,204)" dir=3D"auto">On 1/12/25 22:26, Phil Denni=
s-Jordan wrote:<br>
&gt; By changing the way the main QEMU event loop is invoked, I inadvertent=
ly<br>
&gt; changed the BQL status of exit notifiers: some of them implicitly<br>
&gt; assumed they would be called with the BQL held; the BQL is however<br>
&gt; not held during the exit(status) call in qemu_default_main().<br>
&gt; <br>
&gt; Instead of attempting to ensuring we always call exit() from the BQL -=
<br>
&gt; including any transitive calls - this change adds a BQL lock guard to<=
br>
&gt; qemu_run_exit_notifiers, ensuring the BQL will always be held in the<b=
r>
&gt; exit notifiers.<br>
&gt; <br>
&gt; Additionally, the BQL promise is now documented at the<br>
&gt; qemu_{add,remove}_exit_notifier() declarations.<br>
&gt; <br>
&gt; Fixes: f5ab12caba4f (&quot;ui &amp; main loop: Redesign of system-spec=
ific main<br>
&gt; thread event handling&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/277=
1" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2771</a><br>
&gt; Reported-by: David Woodhouse &lt;<a href=3D"mailto:dwmw2@infradead.org=
" target=3D"_blank">dwmw2@infradead.org</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
<br>
I&#39;m worried that this breaks for exit() calls that happen within a <br>
BQL-taken area (for example, anything that uses error_fatal) due to...<br>
<br>
void bql_lock_impl(const char *file, int line)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0QemuMutexLockFunc bql_lock_fn =3D qatomic_read(&amp;bql=
_mutex_lock_func);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!bql_locked()); // &lt;--- this<br>
=C2=A0 =C2=A0 =C2=A0bql_lock_fn(&amp;bql, file, line);<br>
=C2=A0 =C2=A0 =C2=A0set_bql_locked(true);<br>
}<br></blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">BQL_LOCK_GU=
ARD expands to a call to bql_auto_lock(), which in turn defends against rec=
ursive locking by checking bql_locked().=C2=A0</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div><a href=3D"https://gitlab.com/qemu-project/qemu=
/-/blob/master/include/qemu/main-loop.h#L377">https://gitlab.com/qemu-proje=
ct/qemu/-/blob/master/include/qemu/main-loop.h#L377</a></div><br></div><div=
 dir=3D"auto">I think that should make it safe?</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">The only safety issue I can imagine is that exit() =
is called in a thread where the BQL is not held, but a BQL-holding thread i=
s waiting for that thread. But I=E2=80=99m not sure such a pattern exists i=
n QEMU though, and it would have triggered the assertion in the original co=
de. (before my patch causing the regression was applied)</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,20=
4)" dir=3D"auto"><br>
<br>
</blockquote></div></div>

--000000000000cf49a5062bc389fe--

