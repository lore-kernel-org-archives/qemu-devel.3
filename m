Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BDFC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevSk-0002MJ-9u; Thu, 24 Jul 2025 08:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevSi-0002F8-27
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:54:16 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uevSe-0003pX-VA
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:54:15 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so1633671a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753361651; x=1753966451; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvxplCFa5R9/SzZVgamnNqrx7Mp6/+jZhwXZrw3E/B4=;
 b=ijdEQVTaeb87Cswt6jSjdA5U48G5DK1Sqd4e39RLKeJY8OhDB9cVR6cr1qr5QMXnrY
 To3m5deotDgCfw6OV5Nasy6eHcXOykLyUf5rio/23kJBO1CnqXn/l+pr0vh2Q2BRqN+d
 UhXY1fh/XqfvHtZE0KmxdCrPoRZdK8HVk4fBqOiPW/AzAd6TDyVFl7DYGKKsfhlMD2vs
 seKUedSSgwdN8UJKQKXfz9GQe79I8+kdMvbwo/+M1WdTuqOdh7Tn1Z3Lh+6k2Z3joLh0
 nuFkQgVdq5iILTIVVFCtUJX8JTaR1VfRxjU3WTwIPOwFwAbgKGm4NAhPUKCQvQpw+hGX
 uT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361651; x=1753966451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvxplCFa5R9/SzZVgamnNqrx7Mp6/+jZhwXZrw3E/B4=;
 b=eZT0RCg6MU5c9aYTcWjLfXET7rupqBYa+pKBVPiwnSOogsiZqiGosDahYn98Dwob1D
 +DVZt3o9IDgrujUftTHTPd4/D8U2Lmsc7WUxoP37ERk067YCZL4j6IwyC4C8vilpSRKJ
 BBMrZoPmQqmZowgF2ux4FX7I5n465zX7GriqH4fEfE2OH/ut+lretyZCNHRr0HX35Tqf
 Pt2GR1ePIKf3o5DhZGXWrpeij4NClNxs702SqZyjtm3KH/7QYEzOgg8k3Bbe6az+ka24
 N/4A1HiY5lsV9/1icw1pRTfqXw+STlZDRMT8mmqCAsZSIN/QSs6pMPx91TmCLteyJtjs
 DopQ==
X-Gm-Message-State: AOJu0Yyu9MswDdX1fZKnKvGaJSdGrf0K1Gq1pDKxdipdFe85cfv4Wf+4
 rLxpHN7c9NgYaVy6xcNJM16x4YWgvPF8LSqwJdYsN2jJR+M4g2FmfWFmyV7XY0ssYuH0cTf9KlB
 pIE2laxEvwM/Gglr/vW1OLJRTkJdUz4Sb84hWG0EiEQ==
X-Gm-Gg: ASbGnctN4QCi1/XT0IkS2yNGNeGHBp8SwnIuRknWTyPKTeNrWXpTmxAqP3uB7PF1fzc
 83zBEjtQhz2sMbLsR7BbDjqEODuLr6miD4iy98ffKhqfNr5f8S10J0m6iAxrzM5XEzXNo6nXYTs
 1FHaryS5BZADlxwkMJhuLQw6Rms5U6a6PfnzIvjnI9Sc9DtRC87vNdzXeq6EK1x2pbIi1RLFRnx
 ZuG8w==
X-Google-Smtp-Source: AGHT+IEwryNxtOiSpmYavgISW5Vkn6Q/60sx97+7c7tqa9HnIre0bS4vrwJ810mAg3/Jav5142OU2F0rqPa/HTy8fkw=
X-Received: by 2002:a05:6402:35c2:b0:612:bb19:6d2a with SMTP id
 4fb4d7f45d1cf-6149b594ef9mr5686306a12.24.1753361650433; Thu, 24 Jul 2025
 05:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-12-alex.bennee@linaro.org>
 <CAAjaMXb9-jkDhLA1euY3-90c4q=2my=QuDpJQGGObAZGTy3-xQ@mail.gmail.com>
 <87bjp9vlxd.fsf@draig.linaro.org>
 <CAAjaMXbtw0dw23w2Jx6PmVtZFThj-5w1GzUq0BnzZ7WME-dO6g@mail.gmail.com>
 <87tt31u54d.fsf@draig.linaro.org>
In-Reply-To: <87tt31u54d.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 15:53:44 +0300
X-Gm-Features: Ac12FXzGZ6buAibQP22E87ohCzyY8ZYj44PlExAqpHfSxEjMIt-ngr0FMcbfZ-Y
Message-ID: <CAAjaMXZXiaBs=9pn-ESxB5MaVum1H-wK4WWLY5+3uvX0p6qCBA@mail.gmail.com>
Subject: Re: [PATCH for 10.1 11/13] tests/tcg: reduce the number of plugin
 tests combinations
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jul 24, 2025 at 3:48=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
> > On Thu, Jul 24, 2025 at 3:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> >>
> >> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >>
> >> > On Thu, Jul 24, 2025 at 2:00=E2=80=AFPM Alex Benn=C3=A9e <alex.benne=
e@linaro.org> wrote:
> >> >>
> >> >> As our set of multiarch tests has grown the practice of running eve=
ry
> >> >> plugin with every test is becoming unsustainable. If we switch to
> >> >> ensuring every test gets run with at least one plugin we can speed
> >> >> things up.
> >> >>
> >> >> Some plugins do need to be run with specific tests (for example the
> >> >> memory instrumentation test). We can handle this by manually adding
> >> >> them to EXTRA_RUNS. We also need to wrap rules in a CONFIG_PLUGIN t=
est
> >> >> so we don't enable the runs when plugins are not enabled.
> >> >>
> >> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> >> ---
> >> >>  tests/tcg/Makefile.target                     | 23 ++++++++++++++-=
----
> >> >>  tests/tcg/multiarch/Makefile.target           |  8 +++++--
> >> >>  .../multiarch/system/Makefile.softmmu-target  | 11 +++++----
> >> >>  3 files changed, 30 insertions(+), 12 deletions(-)
> >> >>
> >> >> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> >> >> index a12b15637ea..18afd5be194 100644
> >> >> --- a/tests/tcg/Makefile.target
> >> >> +++ b/tests/tcg/Makefile.target
> >> >> @@ -173,14 +173,25 @@ PLUGINS=3D$(filter-out $(DISABLE_PLUGINS), \
> >> >>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
> >> >>  # pre-requistes manually here as we can't use stems to handle it. =
We
> >> >>  # only expand MULTIARCH_TESTS which are common on most of our targ=
ets
> >> >> -# to avoid an exponential explosion as new tests are added. We als=
o
> >> >> -# add some special helpers the run-plugin- rules can use below.
> >> >> +# and rotate the plugins so we don't grow too out of control as ne=
w
> >> >> +# tests are added. Plugins that need to run with a specific test
> >> >> +# should ensure they add their combination to EXTRA_RUNS.
> >> >>
> >> >>  ifneq ($(MULTIARCH_TESTS),)
> >> >> -$(foreach p,$(PLUGINS), \
> >> >> -       $(foreach t,$(MULTIARCH_TESTS),\
> >> >> -               $(eval run-plugin-$(t)-with-$(p): $t $p) \
> >> >> -               $(eval RUN_TESTS+=3Drun-plugin-$(t)-with-$(p))))
> >> >> +
> >> >> +NUM_PLUGINS :=3D $(words $(PLUGINS))
> >> >> +NUM_TESTS :=3D $(words $(MULTIARCH_TESTS))
> >> >> +
> >> >> +define mod_plus_one
> >> >> +  $(shell $(PYTHON) -c "print( ($(1) % $(2)) + 1 )")
> >> >> +endef
> >> >> +
> >> >> +$(foreach _idx, $(shell seq 1 $(NUM_TESTS)), \
> >> >> +       $(eval _test :=3D $(word $(_idx), $(MULTIARCH_TESTS))) \
> >> >> +       $(eval _plugin :=3D $(word $(call mod_plus_one, $(_idx), $(=
NUM_PLUGINS)), $(PLUGINS))) \
> >> >> +       $(eval run-plugin-$(_test)-with-$(_plugin): $(_test) $(_plu=
gin)) \
> >> >> +       $(eval RUN_TESTS+=3Drun-plugin-$(_test)-with-$(_plugin)))
> >> >> +
> >> >>  endif # MULTIARCH_TESTS
> >> >>  endif # CONFIG_PLUGIN
> >> >>
> >> >> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multia=
rch/Makefile.target
> >> >> index bfdf7197a7b..38345ff8805 100644
> >> >> --- a/tests/tcg/multiarch/Makefile.target
> >> >> +++ b/tests/tcg/multiarch/Makefile.target
> >> >> @@ -189,6 +189,10 @@ run-plugin-semiconsole-with-%:
> >> >>  TESTS +=3D semihosting semiconsole
> >> >>  endif
> >> >>
> >> >> +test-plugin-mem-access: CFLAGS+=3D-pthread -O0
> >> >> +test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
> >> >> +
> >> >> +ifeq ($(CONFIG_PLUGIN),y)
> >> >>  # Test plugin memory access instrumentation
> >> >>  run-plugin-test-plugin-mem-access-with-libmem.so: \
> >> >>         PLUGIN_ARGS=3D$(COMMA)print-accesses=3Dtrue
> >> >> @@ -197,8 +201,8 @@ run-plugin-test-plugin-mem-access-with-libmem.s=
o: \
> >> >>         $(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
> >> >>         $(QEMU) $<
> >> >>
> >> >> -test-plugin-mem-access: CFLAGS+=3D-pthread -O0
> >> >> -test-plugin-mem-access: LDFLAGS+=3D-pthread -O0
> >> >> +EXTRA_RUNS +=3D run-plugin-test-plugin-mem-access-with-libmem.so
> >> >> +endif
> >> >>
> >> >>  # Update TESTS
> >> >>  TESTS +=3D $(MULTIARCH_TESTS)
> >> >> diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/t=
ests/tcg/multiarch/system/Makefile.softmmu-target
> >> >> index 5acf2700812..4171b4e6aa0 100644
> >> >> --- a/tests/tcg/multiarch/system/Makefile.softmmu-target
> >> >> +++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
> >> >> @@ -71,8 +71,11 @@ endif
> >> >>  MULTIARCH_RUNS +=3D run-gdbstub-memory run-gdbstub-interrupt \
> >> >>         run-gdbstub-untimely-packet run-gdbstub-registers
> >> >>
> >> >> +ifeq ($(CONFIG_PLUGIN),y)
> >> >>  # Test plugin memory access instrumentation
> >> >> -run-plugin-memory-with-libmem.so:              \
> >> >> -       PLUGIN_ARGS=3D$(COMMA)region-summary=3Dtrue
> >> >> -run-plugin-memory-with-libmem.so:              \
> >> >> -       CHECK_PLUGIN_OUTPUT_COMMAND=3D$(MULTIARCH_SYSTEM_SRC)/valid=
ate-memory-counts.py $@.out
> >> >> +run-plugin-memory-with-libmem.so: memory libmem.so
> >> >
> >> > Hm why wasn't this needed before this change?
> >> >
> >> > I see the make `memory` target sets CHECK_UNALIGNED but where is
> >> > libmem.so target coming from?
> >> >
> >> >> +run-plugin-memory-with-libmem.so: PLUGIN_ARGS=3D$(COMMA)region-sum=
mary=3Dtrue
> >> >> +run-plugin-memory-with-libmem.so: CHECK_PLUGIN_OUTPUT_COMMAND=3D$(=
MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py $@.out
> >> >> +
> >> >> +EXTRA_RUNS +=3D run-plugin-memory-with-libmem.so
> >>
> >> Because we add it to EXTRA_RUNS so we don't want that if plugins won't
> >> work. We could just wrap EXTRA_RUNS but the rest of the recipe is moot
> >> at that point anyway.
> >
> > I am asking about the line
> >
> >> +run-plugin-memory-with-libmem.so: memory libmem.so
> >
> > Which adds two make target prerequisites `memory` and `libmem.so`, I
> > don't see where they came from, or maybe I am not understanding the
> > makefile logic here correctly.
>
> Originally we generated the pre-reqs in the:
>
>   $(foreach p,$(PLUGINS), \
>       $(foreach t,$(MULTIARCH_TESTS),\
>
> loop. Now that doesn't cover every combination we need to add an
> explicit prereq for the test case we know we will run.

Ah thanks, that clears it up. The equivalent is specifically this
deleted line: $(eval run-plugin-$(t)-with-$(p): $t $p)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> >
> >>
> >> >> +endif
> >> >> --
> >> >> 2.47.2
> >> >>
> >> >>
> >>
> >> --
> >> Alex Benn=C3=A9e
> >> Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

