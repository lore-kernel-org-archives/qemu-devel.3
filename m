Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C959C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 22:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX6ru-0001oH-Gy; Thu, 25 Jul 2024 18:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX6rs-0001kw-Mi; Thu, 25 Jul 2024 18:23:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX6rq-0007zx-Ul; Thu, 25 Jul 2024 18:23:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d1a74a43bso309046b3a.1; 
 Thu, 25 Jul 2024 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721946201; x=1722551001; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ls4eb2wVQZLkflT8WyV+pZAykwNS+sGjlzEPUl3vt6g=;
 b=J4KTjwISRwAWE6YazoekAccl2KCkBeGjNk0zdkkjNX9602nMGOoBH7g/UqUmyYJmfB
 DH5cQeS3d2FxqluH77OaK4wbMCwtC5gTmRVEGUJSmwFLKdvgGXHerNUbVnk2rQkiGfon
 OETLbVW+A2RPglUsguuX/U4cn5SowLp8mMA+6NDIiK1FbpnRkMo5TzcmUZlpLhsnzTn4
 1FLBy3FuY5w8R3R/UXj07z0gNLP0CfFlyQy8yYOhB2LDxULuLkvXMJCPlMf0jj6050xC
 rPP4Tr3gdwMv/q9SJwWBLrDL0T3xfpdLEc/vS2rPhWlRXfshCFfW9XxkBkeva0ObolMn
 DYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721946201; x=1722551001;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ls4eb2wVQZLkflT8WyV+pZAykwNS+sGjlzEPUl3vt6g=;
 b=O09IEFjwKA/tc0mBUT4jL8vi0YP9wY4uRm9oQgCEfpoZQz4b2bqDXGSF2SzjHg9do4
 Lwl2x7oPBCBkHCJjUMlvrE+W2S2paKYtXSruEEDhLSg9PQg58FS4B8nrHKTDaKnIxKGN
 IAce6aHQx9zIF4G7cgd+FMQEwF5H0smGA7HAWdtWUlC0UyTHkkpsXSz9R0/KvZwInwdL
 cVsIeoyrtfNXVY2Hq8AWycKAJF0kCIAHLqAou7X3hOojB70UEpOTOOJ6Iz2DRnnb3uNW
 nGseJMwRU8Ip2wNd6qoVNLnjW/6CW/zVzYRLmi50TBFKCLKy/hWOdnd/4+ryuKSXLCLo
 B/IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRTPCqvOPnE6/5qA1b+hwMeniyBs6iKgBFdwStV//7E9Or81bxBQBsRM+TUz4qqSwW1ameivYQ+/N6KrcggTYbcvWM
X-Gm-Message-State: AOJu0Ywr8AC48e4tqO00iAXwBXxX6M+FHocYNWjJMRw4pPkcD8zX2idj
 i6RFr1trFkNrD8G2lRBZXeNB8bV0jfzkCz3t88qbp5ObVu1RuOak
X-Google-Smtp-Source: AGHT+IH4VuKDeDbt06N1ho3qYshhzGlHlHQCLGen/CCR19Dh6Qv9xV+GBv6/DPcER+MT8tQZPAnAcQ==
X-Received: by 2002:a05:6a00:2313:b0:70d:1e20:1c1b with SMTP id
 d2e1a72fcca58-70eae97ce57mr4069413b3a.27.1721946200646; 
 Thu, 25 Jul 2024 15:23:20 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead81272esm1630410b3a.97.2024.07.25.15.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 15:23:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jul 2024 08:23:15 +1000
Message-Id: <D2YYZDFM3W49.11FAITK46IW30@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, "Peter Maydell"
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: aerc 0.18.0
References: <20240725154003.428065-1-npiggin@gmail.com>
 <87wml9mdbf.fsf@draig.linaro.org> <87sevxmczx.fsf@draig.linaro.org>
In-Reply-To: <87sevxmczx.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Jul 26, 2024 at 6:29 AM AEST, Alex Benn=C3=A9e wrote:
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >
> >> In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in th=
e
> >> clang-user job with an assertion failure in glibc that seems to
> >> indicate corruption:
> >>
> >>   signals: allocatestack.c:223: allocate_stack:
> >>     Assertion `powerof2 (pagesize_m1 + 1)' failed.
> >>
> >> Disable these tests for now.
> >>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefil=
e.target
> >> index 8c3e4e4038..509a20be2b 100644
> >> --- a/tests/tcg/ppc64/Makefile.target
> >> +++ b/tests/tcg/ppc64/Makefile.target
> >> @@ -11,6 +11,18 @@ config-cc.mak: Makefile
> >> =20
> >>  -include config-cc.mak
> >> =20
> >> +# multi-threaded tests are known to fail (e.g., clang-user CI job)
> >> +# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
> >
> > Given this is only a problem with clang can we only apply these
> > workaround if we detect "clang" in $(CC)?
>
> ifeq ($(findstring clang,$(CC)),clang)
> ...
> endif
>
> should do the trick

I did try that, but unfortunately the target CC (ppc64 in this case).=20
I'll just send the big hammer to CI unstuck, and I'll try to work it
out later.

Thanks,
Nick

