Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC953D1D480
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdthE-0002UQ-2X; Thu, 08 Jan 2026 12:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdthC-0002SM-MA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:21:14 -0500
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdthA-0002QA-QL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:21:14 -0500
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-12056277571so3585443c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892871; x=1768497671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKY7zfOX8dnGIsGUpR41IksPWXL7wIQaGWD76R8zAMQ=;
 b=msrNH3VJVX1G9ZedyV2e4fxIwRsgQ4oy5zxc2rKbjXhyWTYaBxh+wMaUqFfqk216un
 DyprcOPYmjYbJjlDVzcpkACSxltU/NJ3Vom+xO2Ac4n7+Le4sFNHBteB9D4p78WycfxM
 dan21HcGvWw/3xp/IChI1TYZDgWywpX6ufyhKS5rOlS00ywHxhcq01zFhq2CKVJyk1KN
 NQyJG1blDiF0qNK0KM/IxPhluCxGILmO4BxDpRPZycNXNj/BT3dgxzxNp2Gp4aLV/Li9
 mr5PDZE6krq+0wTj9YqvA0rVx+rxPfCetSyk0KLMa4chsniMJfIQrBla9wLCYt45x8M4
 Vh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892871; x=1768497671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKY7zfOX8dnGIsGUpR41IksPWXL7wIQaGWD76R8zAMQ=;
 b=sMh3EZZeoU+h3Lyu0ddUe7tYL37av7Y5+7KgOipJp7pV0iQ9IsqW5J3w7aY3+IQCnj
 z9igCQ+VWjmV/Dnspdigkwig/NLxzsRDvKNcLR1NTX3xF45LHdcn1RM/jkPqu4lGFOOf
 hhQe3oukmP1XrtEv8KlJMI3fMKuDv39GKkROsW05GCddykmnFIpf3duESmwgXn0Sgw1Y
 J9ecsOQord23lO7dtxJnEF5mz4g8slNEZS79TWh0poeEJHKQZtDeZDfKBrEL7le+OFCx
 V5+2BR8xstAJQ6VD5Zx0lih1wu5qXgMDidHodDI3+cIIo+snMFmZLxUKLNeNq0iTCNDo
 0seQ==
X-Gm-Message-State: AOJu0YxAWfgce2Z+HfMpb8g93jJb8a3Y/fSd4bcJ5kQmhuzFEhURXiy6
 a9peCPKCS2JTChu6r7Exe65WfUaqomkltu8ilxtlfTDKoGuywMqK+2ahG6xGcmxrhyt5aJQrCJi
 HF2usOJEz01j6rL6gOS79cULFD/dQ6Is=
X-Gm-Gg: AY/fxX7ST3PFIpS4UilCuNfwl6JFp4wpAd6noh4LQoajk+T6IebnqSF5400toKJvQfZ
 eiGN9Tb856JDdqF+Ru3FzzFiXpHOo+LJpUzYylkwZpjiuDkMDWQbC32h38b1dnaDqxKKBE+fZR2
 sNCzgdL1sTBNZQlFsMFgWEHdZHOw8YHZC0MVLV5dmUax1moyslwlKE7778dL/ffHxva6UiNcepS
 QXRQb+sns/11FelAHMbRytw0L9VuwPgA+VpdyGax6PtZQcNt4UvCaDVm7p4OPqN49AtB/XPCE1t
 3SvdCNr/mO9Dw5ogjnZ78TYn0mrNFp3pXDtw
X-Google-Smtp-Source: AGHT+IHhwu6u7Q68lno27j1bQ6pSR7pPWGxmJmKntZ+K8ytFYfuH66seTzBH9yhaNxLRs6CPeoNBhemLID9HlN5fo8g=
X-Received: by 2002:a05:7022:258a:b0:122:a2:ffcd with SMTP id
 a92af1059eb24-12200a304bfmr2098239c88.23.1767892871014; Thu, 08 Jan 2026
 09:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-2-richard.henderson@linaro.org>
 <aV9y9b2-XRvNOYTG@redhat.com>
 <4df07fa5-f12d-4df5-9b59-0a2fce44b236@linaro.org>
 <CAEDrbUbqV3Zev8sfYvW1uCBF-4ONVqPvJdCgNDepHTXu2LzFCQ@mail.gmail.com>
In-Reply-To: <CAEDrbUbqV3Zev8sfYvW1uCBF-4ONVqPvJdCgNDepHTXu2LzFCQ@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 9 Jan 2026 02:20:59 +0900
X-Gm-Features: AQt7F2pVxkGstogGtRrGuBJQsSmuy-qbIU57WzwdCdw4-VYnIM0llR1yM4S30Ts
Message-ID: <CAEDrbUYgiLKq3hNWXkt9RWS7AASniy9cHB9qFm7MMfsvaaVWEQ@mail.gmail.com>
Subject: Re: [PATCH 01/50] gitlab: Remove 32-bit host testing
To: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000093eac70647e3a22c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1233.google.com
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

--00000000000093eac70647e3a22c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi Daniel and Richard,
>
> Thank you for pinging me.
>
> > On 1/8/26 20:03, Daniel P. Berrang=C3=A9 wrote:
> > > On Thu, Jan 08, 2026 at 04:29:29PM +1100, Richard Henderson wrote:
> > >> These deprecated builds will be disabled.
> > >> Remove testing of armhf, i686, and wasm32.
> > >
> > > CC'ing the wasm maintainer.
> > >
> > > This patch is removing our only CI testing of wasm.  Is there any
> > > 64-bit container image that can be used to test wasm instead ?
> >
> > Ah, right.  Yesterday I remembered that I should include this in the
cover letter, but
> > then today when I actually posted it I forgot.
> >
> > There are two sets of wasm64 patches; the simple one uses TCI, just
like the existing
> > wasm32 code:
> >
> >
https://lore.kernel.org/qemu-devel/cover.1754494089.git.ktokunaga.mail@gmai=
l.com/
> >
> > I attempted to incorporate these patches, but there were too many
conflicts.
> >
> > The complex wasm64 patch set includes a complete tcg backend:
> >
> >
https://lore.kernel.org/qemu-devel/cover.1756724464.git.ktokunaga.mail@gmai=
l.com/
> >
> > I really need to study that more before I'm willing to accept the core
tcg changes required.
> >
> > Anyway, I meant to cc Kohei about this, to see if he would revive the
TCI patch set in the
> > short term.
>
> I'm rebasing the wasm64 TCI patch series and will post it to the mailing
list
> when it's ready.

I've just posted the rebased version of the wasm64 TCI patch series.

https://patchew.org/QEMU/cover.1767886100.git.ktokunaga.mail@gmail.com/

Regards,
Kohei

--00000000000093eac70647e3a22c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; Hi Daniel and Richard,<br>&gt; <br>&=
gt; Thank you for pinging me.<br>&gt; <br>&gt; &gt; On 1/8/26 20:03, Daniel=
 P. Berrang=C3=A9 wrote:<br>&gt; &gt; &gt; On Thu, Jan 08, 2026 at 04:29:29=
PM +1100, Richard Henderson wrote:<br>&gt; &gt; &gt;&gt; These deprecated b=
uilds will be disabled.<br>&gt; &gt; &gt;&gt; Remove testing of armhf, i686=
, and wasm32.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; CC&#39;ing the wasm maint=
ainer.<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; This patch is removing our only =
CI testing of wasm.=C2=A0 Is there any<br>&gt; &gt; &gt; 64-bit container i=
mage that can be used to test wasm instead ?<br>&gt; &gt; <br>&gt; &gt; Ah,=
 right.=C2=A0 Yesterday I remembered that I should include this in the cove=
r letter, but<br>&gt; &gt; then today when I actually posted it I forgot.<b=
r>&gt; &gt; <br>&gt; &gt; There are two sets of wasm64 patches; the simple =
one uses TCI, just like the existing<br>&gt; &gt; wasm32 code:<br>&gt; &gt;=
 <br>&gt; &gt; <a href=3D"https://lore.kernel.org/qemu-devel/cover.17544940=
89.git.ktokunaga.mail@gmail.com/">https://lore.kernel.org/qemu-devel/cover.=
1754494089.git.ktokunaga.mail@gmail.com/</a><br>&gt; &gt; <br>&gt; &gt; I a=
ttempted to incorporate these patches, but there were too many conflicts.<b=
r>&gt; &gt; <br>&gt; &gt; The complex wasm64 patch set includes a complete =
tcg backend:<br>&gt; &gt; <br>&gt; &gt; <a href=3D"https://lore.kernel.org/=
qemu-devel/cover.1756724464.git.ktokunaga.mail@gmail.com/">https://lore.ker=
nel.org/qemu-devel/cover.1756724464.git.ktokunaga.mail@gmail.com/</a><br>&g=
t; &gt; <br>&gt; &gt; I really need to study that more before I&#39;m willi=
ng to accept the core tcg changes required.<br>&gt; &gt; <br>&gt; &gt; Anyw=
ay, I meant to cc Kohei about this, to see if he would revive the TCI patch=
 set in the<br>&gt; &gt; short term.<br>&gt; <br>&gt; I&#39;m rebasing the =
wasm64 TCI patch series and will post it to the mailing list<br>&gt; when i=
t&#39;s ready.<br><br>I&#39;ve just posted the rebased version of the wasm6=
4 TCI patch series.<br><br><a href=3D"https://patchew.org/QEMU/cover.176788=
6100.git.ktokunaga.mail@gmail.com/">https://patchew.org/QEMU/cover.17678861=
00.git.ktokunaga.mail@gmail.com/</a><br><br>Regards,<br>Kohei</div></div>

--00000000000093eac70647e3a22c--

