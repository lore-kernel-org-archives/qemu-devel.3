Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58FCCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 18:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqH3G-0001mr-Lq; Fri, 29 Mar 2024 14:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rqH3D-0001jd-Vk
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 14:34:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rqH3B-0006x3-Ac
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 14:34:03 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso2279191a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711737239; x=1712342039; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P9IeUwOTxA9l2JQjq5zY/8CfNiqhRZdCm+W1m44HM9I=;
 b=cvaW7sLcI14Ie/QAQkt+3oc/33HY0S4aiXiS7n01DF0ROq/rLOQ65NU8hG9VYmHH9F
 mduYmlMjRBzHUbeqp0pGu/5LmkKwxxZ1j71gJh6VUsi7GTyLaK/TFkMhMAOQs7ofGwy7
 o9ZyQxnVxrclltevV5tviJgJCx49L9rUsSuJ2upJSVV507Es4ohYi5WVJhfsb/MylEWp
 V+oDYIHk33O6zrPq84O1gRnyqi8UqhGpNTq3Kg/S9RUZ5gbWWiyPW9c80vxxjZQUopRa
 P57PU6t/A2KqzByYQcYwLwBZf3cBsdVTXBDeJneT6HijODX6nzKIIMQNOegjx8wwaQvc
 0p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711737239; x=1712342039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P9IeUwOTxA9l2JQjq5zY/8CfNiqhRZdCm+W1m44HM9I=;
 b=kzGqn3pvz+NirLgUOijTGHJbS1Y4JPVylKFEPuswEs30NgM4KRWzqC6PUYAKP9qiys
 TGaYThOUtLwPMamPev2yIabHQH2AeejSkPN9VdQXm+nb2/Q4czSVrPPb4tLqdG/DlAJo
 bckzcHRTcyfaMeqTaePGLl1/tKEg7RcD9l4R9fHE62rVZY/5HD12STtCLGH+zJQGS5uz
 0SOJ0kpX2qwFPAlMgPayGETS5bcaWMR/FS2y4b192BamAMj2OxY4TTYj5O7yK6epYOLc
 OGsT4BYBGu7DoFidncsRQTwi0RksI4D0YSObOzUw5ZeKrQycAtWSMy/Nd1zwyc+iGW2M
 H9Hg==
X-Gm-Message-State: AOJu0Yxoknp93J0JL/CqrYxUBh581lb7dUrPEizHvMw95kXTCU+Vk3uQ
 7Fd6pGq7P88Du+2UY2jFCLZeq5vHo0231dlRQqego3zd/7g4/vXDo051xtaFslbR76Ixse5EVRF
 c4VxIDZ0i0eg9LPsD7BX2JR1rhQ+slGnzX9dNLg==
X-Google-Smtp-Source: AGHT+IGv18lR7CkDiGidnOOVS29xLoXEYZv9l8hs8pXQpjecZXP3Xvf/UrmWE0FrcjV7PktLF2p4YX1J+n05S353XkE=
X-Received: by 2002:a17:906:aa4c:b0:a4a:3d08:bd7b with SMTP id
 kn12-20020a170906aa4c00b00a4a3d08bd7bmr2266248ejb.26.1711737238650; Fri, 29
 Mar 2024 11:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
In-Reply-To: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Sat, 30 Mar 2024 05:33:48 +1100
Message-ID: <CAHDbmO1n2EdLD4Ns7sCnGum4_xF90qRw=--KywdbH6KgRehKiw@mail.gmail.com>
Subject: Re: Backdoor in xz, should we switch compression format for tarballs?
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 "Maydell, Peter" <peter.maydell@linaro.org>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000f18600614d0e208"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000000f18600614d0e208
Content-Type: text/plain; charset="UTF-8"

Um maybe?

From what I've read so far it doesn't seem the format is compromised but it
certainly seems like a concerted attempt to subvert an upstream. However a
knee-jerk jump to another format might be premature without carefully
considering if other upstreams have been targeted.

I guess zstd is overseen by Facebook but it's still a mostly single
contributor repo. Lzip's history directly ties to the original author of xz
and we haven't heard from them yet.

We should certainly keep an eye on the situation but let's not be too hasty.

On Sat, 30 Mar 2024, 05:00 Paolo Bonzini, <pbonzini@redhat.com> wrote:

> For more info, see
> https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/
> but, essentially, xz was backdoored and it seems like upstream was directly
> responsible for this.
>
> Based on this, should we switch our distribution from bz2+xz to bz2+zstd
> or bz2+lzip?
>
> Thanks,
>
> Paolo
>

--0000000000000f18600614d0e208
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Um maybe?<div dir=3D"auto"><br></div><div dir=3D"aut=
o">From what I&#39;ve read so far it doesn&#39;t seem the format is comprom=
ised but it certainly seems like a concerted attempt to subvert an upstream=
. However a knee-jerk jump to another format might be premature without car=
efully considering if other upstreams have been targeted.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">I guess zstd is overseen by Facebook but =
it&#39;s still a mostly single contributor repo. Lzip&#39;s history directl=
y ties to the original author of xz and we haven&#39;t heard from them yet.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">We should certainly kee=
p an eye on the situation but let&#39;s not be too hasty.</div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 30 Mar 202=
4, 05:00 Paolo Bonzini, &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"auto">For more info, see=C2=A0<a=
 href=3D"https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@aw=
ork3.anarazel.de/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/=
</a> but, essentially, xz was backdoored and it seems like upstream was dir=
ectly responsible for this.<div dir=3D"auto"><br></div><div dir=3D"auto">Ba=
sed on this, should we switch our distribution from bz2+xz to bz2+zstd or b=
z2+lzip?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>
</blockquote></div>
</div></div>

--0000000000000f18600614d0e208--

