Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4575CE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 10:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUyt-0000nT-Tj; Tue, 17 Dec 2024 05:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNUys-0000nC-Mc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:39:10 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNUyr-0008At-2G
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 05:39:10 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6efea3c9e6eso36955247b3.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734431947; x=1735036747; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6eIxnqCtDrzYV8NrJJpVsr7m0UqjADBHZfxpQylbP4=;
 b=Tn/0aCq4OntuoEqSybyo8PH3RTX26KMDEq4f9QeggPGTH2oylbOnHWsgo6um+V6Xzl
 AcY970/0iFc2+C3A7RifkBy10mPnKvQAKOO74Fkkqmt6vbw119mqVq9i0ihpi7l1U5Vw
 aPwuyhdoEaAFNiDNpOO2DkkwYbbMtLBukl/uTr1SB1Y8RryDvZm5qK3/UIMRjzVbVWu0
 Eq89DuAPFWsS9cZ2BHTD5hQQ7OTW1eLfqt4bVcX+qEdwaz/lt76+hng0u1AaBdr8xREB
 qMoS6L3pMuwtUmm1u3BuoinDMFWj/lD9rKEDUkjss5NkjnyPAXkQ7CZ60A8d9kB8TSex
 vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734431947; x=1735036747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6eIxnqCtDrzYV8NrJJpVsr7m0UqjADBHZfxpQylbP4=;
 b=dYWUtbVneIMxexY1K87kbjq5X3S6Qb/j+mt343DAWhnigLA4S304r1MkrTp3nTx4QD
 sK+2HhkCsp+mnGjPkkvYZufs8WWjdGfefjBwsa6HkGgiUgePVUyvbmWb4GtYe+3HxPXQ
 4rRA97LmOetFHU1FNcxN7O+u3O5+zgZ1BJ2cVSQhbN8IbisfVcnjdy2zAMyYzVRodKTy
 eLFmXCjm0JKY3gEYNkemoYmRo8meM+Oe3v6isgnSsbrHhs8zKAprgV+IzwX+8cs+Q9V8
 Z1SKKVqcoailc/6ZhsfyqKVx9v187JHPY6NdgupG7dHCT5Gz29kdFR096itqs+GmdeSM
 ngNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfkV/kWq1Vj6XcLeG8znUPn182og8pdJsPCNckcJh2XJ54BksCYGtIwFz2vN1BDEwFM7G+Iopz468S@nongnu.org
X-Gm-Message-State: AOJu0YxB2/kgSQ7DR5d9L6/NkJzzWTNw2ATZqp9SiyJel5m3i3IblyFo
 jOkMf4cns6kjiKgRLTVu+4wu5n2/SZ/Y6lVTVeV8Q9+7/88erElb7FkLl5eTBTqKT1dodZB7HRt
 +1ZeRG+A6JfoeICaRafzMqoF0EGh8vH8N9AMFMQ==
X-Gm-Gg: ASbGncvyEMxY831EmnuquPSipH6xqAX2ZZIXvjGr81nu5ZACo8TotPu0nuMUdqQ7Z6Y
 UqbHcn5cazps52dTX+mx+SEKMxYK5OK3X/mgZFl4=
X-Google-Smtp-Source: AGHT+IEtHJjW+dfTAA2dYgeekMy0SqyzY0XVWWzgpbZlGup+GeQJaI17e2w47ZHkT3K8Nz6vXW/oPNEvHsDUj3eifS4=
X-Received: by 2002:a05:690c:f12:b0:6ef:5c57:904 with SMTP id
 00721157ae682-6f2bb2e7fe6mr24412387b3.7.1734431947643; Tue, 17 Dec 2024
 02:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
In-Reply-To: <87pllq69l6.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2024 10:38:56 +0000
Message-ID: <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 17 Dec 2024 at 07:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>
> > On 12/16/24 11:50, Richard Henderson wrote:
> >> On 12/16/24 13:26, Pierrick Bouvier wrote:
> >>> On 12/16/24 11:10, Richard Henderson wrote:
> >>>> On 12/4/24 15:12, Pierrick Bouvier wrote:
> >>>>> qemu-system-aarch64 default pointer authentication (QARMA5) is expe=
nsive, we
> >>>>> spent up to 50% of the emulation time running it (when using TCG).
> >>>>>
> >>>>> Switching to pauth-impdef=3Don is often given as a solution to spee=
d up execution.
> >>>>> Thus we talked about making it the new default.
> >>>>>
> >>>>> The first patch introduce a new property (pauth-qarma5) to allow to=
 select
> >>>>> current default algorithm.
> >>>>> The second one change the default.
> >>>>>
> >>>>> Pierrick Bouvier (2):
> >>>>>      target/arm: add new property to select pauth-qarma5
> >>>>>      target/arm: change default pauth algorithm to impdef
> >>>>>
> >>>>>     docs/system/arm/cpu-features.rst |  7 +++++--
> >>>>>     docs/system/introduction.rst     |  2 +-
> >>>>>     target/arm/cpu.h                 |  1 +
> >>>>>     target/arm/arm-qmp-cmds.c        |  2 +-
> >>>>>     target/arm/cpu64.c               | 30 +++++++++++++++++++------=
-----
> >>>>>     tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
> >>>>>     6 files changed, 38 insertions(+), 19 deletions(-)
> >>>>>
> >>>>
> >>>> I understand the motivation, but as-is this will break migration.
> >>>>
> >>>> I think this will need to be versioned somehow, but the only thing t=
hat really gets
> >>>> versioned are the boards, and I'm not sure how to link that to the i=
nstantiated cpu.
> >>>>
> >>>
> >>>   From what I understood, and I may be wrong, the use case to migrate=
 (tcg) vm with cpu max
> >>> between QEMU versions is *not* supported, as we can't guarantee which=
 features are present
> >>> or not.
> >> This doesn't affect only -cpu max, but anything using aarch64_add_paut=
h_properties():
> >> neoverse-n1, neoverse-n2, cortex-a710.
> >>
> >
> > I think this is still a change worth to do, because people can get a
> > 100% speedup with this simple change, and it's a better default than
> > the previous value.
> > In more, in case of this migration scenario, QEMU will immediately
> > abort upon accessing memory through a pointer.
> >
> > I'm not sure about what would be the best way to make this change as
> > smooth as possible for QEMU users.
>
> Surely we can only honour and apply the new default to -cpu max?

That was what I thought we were aiming for, yes. We *could* have
a property on the CPU to say "use the old back-compatible default,
not the new one", which we then list in the appropriate hw_compat
array. (Grep for the "backcompat-cntfrq" property for an example of
this.) But I'm not sure if that is worth the effort compared to
just changing 'max'.

(It's not that much extra code to add the property, so I could
easily be persuaded the other way. Possible arguments include
preferring consistency across all CPUs. If we already make the
default be not "what the real CPU of this type uses" then that's
also an argument that we can set it to whatever is convenient;
if we do honour the CPU ID register values for the implementation
default then that's an argument that we should continue to do
so and not change the default to our impdef one.)

-- PMM

