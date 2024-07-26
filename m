Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58902C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXJe4-00077v-3c; Fri, 26 Jul 2024 08:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sXJe2-00076Z-P2; Fri, 26 Jul 2024 08:01:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sXJe0-0005ZK-Uq; Fri, 26 Jul 2024 08:01:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fd66cddd4dso5511025ad.2; 
 Fri, 26 Jul 2024 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721995314; x=1722600114; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAwlAMtC6lyMxcsq9oZZ0OuPeQxkJ0Q0qbSE0KE2rxw=;
 b=IW8rrgrGavLNiaSJEbOaGYsldObrfmYYVWHZQYWbnhX/mIwmd2BFfDUD6aQ29ijQvJ
 Im/JTs/SIzYNsGC+9pNwCl1lErqmsa0/2gUKSO+1NLFceeD8w8FClHvvxEkhveNRkmf9
 +Z3fjx0IuvoLyZl4rPa/ZmP6SCL2q2dcDya4wj2m4B+OQ56tA9yPdMyqmWHDKCFooAYA
 FMZsgeEH5PG8kLVmrYrNCgE46X6/egkn/qy5UxyOkszb+FFO3HJld0PaviUeklg1btY+
 tsRfzSzHUUlFF5edr2WniSSR4AESuNP6jQe2hMYT5AeYIq0PVFY6mujnq8kYGFMcB/rw
 7z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721995314; x=1722600114;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CAwlAMtC6lyMxcsq9oZZ0OuPeQxkJ0Q0qbSE0KE2rxw=;
 b=qWrSubpGMgXFHftboDuPCyrWkH1g+0+JMtk4LX6EljYgm/3jqUfN0eF1K8FfZ9y2PT
 tjAzF61isimKcBrY4vsJ/IAovNv4bbeTGptm3FnG52Q9fezKvyWggpP4qnW556SbdL2j
 3aBNcHO3iUon5XB7ZdBPRVSID56DQv7xcuiU74Fq0F+JjUV/9VL7TLAlmRNeMlopl+bi
 cjbm11xi3uNygVDZ3j6ijkNQqqiCaDAHFF1sv2Ny8FNUEL+hYUX3MTfxJC8t92gArIb9
 7sTGxEoUtZRvgHGMNqAiMOSsAx51xECdjI6A4XPeG4toTFsZecPGIQ0OHjVmivdEZL4K
 4v3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuULAaJeK6LQM4YRFnXdngnEAArMZdeOSMtX5gi6saa5rW+TOcxdKzICiOrUneoAc1jKBFsu9X/5nCCXoVX8bScvAT/5s=
X-Gm-Message-State: AOJu0YynEHSDqGEnH5aAnF0lNzVHvXhP2EzUTLugT3lItP1s77uTk1FZ
 HdwBP0Fge/tzMFnADvF8FgcePOh1H8lwDwvZ32A+pc+WSZDTr/Lw
X-Google-Smtp-Source: AGHT+IGGNsglkmwoW1lTGp0kC02gl37BfopGoDNnmVm/Uf5cLsd2BoTIkT24VmDdVwxWCahbyIe+6g==
X-Received: by 2002:a17:902:d2ca:b0:1f9:f1e1:da72 with SMTP id
 d9443c01a7336-1fed3bf8233mr81593915ad.63.1721995313410; 
 Fri, 26 Jul 2024 05:01:53 -0700 (PDT)
Received: from localhost ([203.220.44.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ff622asm30536415ad.301.2024.07.26.05.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 05:01:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jul 2024 22:01:47 +1000
Message-Id: <D2ZGE3CV8U1Z.F2X8658K3F45@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Peter Maydell" <peter.maydell@linaro.org>,
 "Richard Henderson" <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
X-Mailer: aerc 0.18.0
References: <20240725154003.428065-1-npiggin@gmail.com>
 <3919ac75-1cce-4fad-a0eb-4ec11865c011@redhat.com>
In-Reply-To: <3919ac75-1cce-4fad-a0eb-4ec11865c011@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Fri Jul 26, 2024 at 7:11 PM AEST, Thomas Huth wrote:
> On 25/07/2024 17.40, Nicholas Piggin wrote:
> > In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
> > clang-user job with an assertion failure in glibc that seems to
> > indicate corruption:
> >=20
> >    signals: allocatestack.c:223: allocate_stack:
> >      Assertion `powerof2 (pagesize_m1 + 1)' failed.
> >=20
> > Disable these tests for now.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >=20
> > diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile=
.target
> > index 8c3e4e4038..509a20be2b 100644
> > --- a/tests/tcg/ppc64/Makefile.target
> > +++ b/tests/tcg/ppc64/Makefile.target
> > @@ -11,6 +11,18 @@ config-cc.mak: Makefile
> >  =20
> >   -include config-cc.mak
> >  =20
> > +# multi-threaded tests are known to fail (e.g., clang-user CI job)
> > +# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
> > +run-signals: signals
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +run-plugin-signals-with-%:
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +
> > +run-threadcount: threadcount
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +run-plugin-threadcount-with-%:
> > +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> > +
> >   ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
> >   PPC64_TESTS=3Dbcdsub non_signalling_xscv
> >   endif
>
> Could you please check whether this is already fixed by Richard's patch:
>
>   https://gitlab.com/qemu-project/qemu/-/commit/8e466dd092469e5ab0f355775=
c57
>
> ?

No, doesn't seem to unfortunately. Here is the same fail -

https://gitlab.com/npiggin/qemu/-/jobs/7436325582

I did build it with clang and using the same sanitize flags on
my local system, and could not reproduce. So not sure.

I might try run the clang-user without any sanitize flags.

I sent this patch with ppc pull request already, I think we
just do that for now to get clang-user passing. Simple enough
to revert once fixed.

Thanks,
Nick

