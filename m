Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8685C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 20:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOMW-0002eT-HP; Wed, 26 Feb 2025 15:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnOMS-0002dM-TS
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 15:50:32 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnOMQ-0001qV-JU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 15:50:32 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e53c9035003so149274276.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 12:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740603028; x=1741207828; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U0A6IXzS8YnKUNw5E47iu+Kpl2ECdYRHrLl8CUekn60=;
 b=JWtCvJ0tr6Yqn6UAZhRIld6KVpkm7VX8metW2iXtpG8mVwlNdLLsmM3LQnWPsi+nqE
 C9Qu+dj7kfMM4NK86zmHRtmKV+MBcrf9wZ6TwLpO2LqEPwuBa5skuUKbDwbIJWjBaw4O
 LMzkJV4SBWOejNfmLRZwdDuqhnXlyCJy/E3m9ZAKN9HwN5Ejq/Va5mi7m6445J760yjG
 28whrj+rGMoiStA/j38JtxMB34MSyQqcIL0sAGRGCTdOEWpBWo7QBk7L5SfnfXuvJyTv
 kkRYZBAv9VNEusl7VMNoxwr2hX/CxPDjvvqOGhGgubBtx5vSbjDtFWO0HXCONhIm0h7g
 nj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740603028; x=1741207828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U0A6IXzS8YnKUNw5E47iu+Kpl2ECdYRHrLl8CUekn60=;
 b=rfC0Hhy6GmI3yY2uPqXaaQ5cW/tPttGkChK1p7FChXO9nGtydq7pw9diY0iI44ogFl
 yF1NLoo40g2Oe9JycL/tUjqY2dFoEeQBG4xJ64aKaKXMG22alGMwZdHzgHSTyW5MJw7k
 BrUgCArVjFp2s+egB2qmIilWHYV9nGD+XmAEcNGqIQq0BolbiDa1Xy6jLdMXyf39EJqF
 cZhDjLVZUwb0+4IEafuL8pYyzj0R2FmG3wupiGIg9695ykgwRa7p+pXCyPZc60ueTgJU
 j4+yUxvwXX0l93dODxfPm6cSWx0QV6xyLoSn/Ltompn01GJUWz7p6KBBzd4K5sss9JPc
 Gqag==
X-Gm-Message-State: AOJu0YwpR+HEUCUR35P7mgdiYGrpxigZY5suOieuLmyVWBbF3vyE4pyu
 Sp43ruiRAVwzRRA8vUi6retGnGEZkOYdyotE/9wFs06En8btz06qbsBvvJaXc7sq+fl6diUU/fE
 dHVPXwm7yuwUCFUe2dwmpCaILnfUxiudEiZmLxQ==
X-Gm-Gg: ASbGnct/8viI80UrkySJCHoaxPbzqyLSoeSzZDJXdYHyGPnqhAtPNwOkxUS9+cG+yVN
 3ZlvCsMi8IBOQooaGBd/3ZwWUPJYeoSE486bLEdX8s1k7ln78P3PZVeehw7v9vbW0JUALDRWvWB
 U7TGY8IyQV
X-Google-Smtp-Source: AGHT+IHoFDfXFDkKvKd/9g73u8XvGlp/4BA2Wc5UatF4PvcjyDLQZfDJeunjO3E4VCX1PcY5ZvTSu0dL4gLWffnYFiQ=
X-Received: by 2002:a05:6902:2748:b0:e5d:d6b8:2318 with SMTP id
 3f1490d57ef6-e607a54eb03mr7771616276.34.1740603028638; Wed, 26 Feb 2025
 12:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
 <829e9fd0-2d0f-45e6-ab89-d933d344cfe2@linaro.org>
 <CAFEAcA8BHzA_P7yX+cDMb1WiyGTzkh6xjvam4RHs5aoM1X6mkw@mail.gmail.com>
 <5c25f67a-2677-4162-9477-f51f230403b0@linaro.org>
In-Reply-To: <5c25f67a-2677-4162-9477-f51f230403b0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2025 20:50:17 +0000
X-Gm-Features: AWEUYZlSUyybVdgAACEr0gQtv_ujFwhK5De7RqbKJE6ZH21vOsXfQ1pZGzHtdVw
Message-ID: <CAFEAcA8jzYvCLxDTybE34K5DxQqOG4-m8_-oNwiATVBHYbEV9A@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(edited cc list since it's moved away from a discussion of this
particular patch and on to a testing/ci coverage issue)

On Wed, 26 Feb 2025 at 19:03, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 2/26/25 03:50, Peter Maydell wrote:
> > On Tue, 25 Feb 2025 at 20:57, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> On 2/25/25 05:41, Peter Maydell wrote:
> >>> (Looking more closely at the cold_reset_values handling
> >>> in npcm_gcr.c, that looks not quite right in a different
> >>> way; I'll send a reply to that patch email about that.)
> >>>
> >>
> >> It may be a hole in our CI right now.
> >> Would that be interesting for CI to run all tests (check-functional +
> >> check w/o functional) with both ubsan and asan?
> >
> > We do have at least some ubsan tests in our CI right now
> > (eg the "clang-system" job). The problem with ubsan coverage
> > is the usual one that we already have too much CI going on,
> > and it takes forever and we don't have that much headroom
> > for adding more jobs.
>
> I understand the problem behind spending more minutes on this.
>
> However, looking at our CI, we already duplicate functional testing a lot:
> buildtest.yml:functional-system-alpine:
> buildtest.yml:functional-system-ubuntu:
> buildtest.yml:functional-system-debian:
> buildtest.yml:functional-system-fedora:
> buildtest.yml:functional-system-centos:
> buildtest.yml:functional-system-opensuse:

I think that these are mostly testing different target
architectures, e.g. functional-system-alpine tests what
build-system-alpine built, which covers avr, loongarch64,
mips64 and mipsel targets; functional-system-ubuntu
tests what build-system-ubuntu bulit, which is alpha,
microblazeel, mips64el, and so on. So there is less overlap
than it might appear.

(Some of them complete pretty quickly because we have very few
functional tests for some archs; some are slower where we're
running more tests. e.g.
https://gitlab.com/qemu-project/qemu/-/jobs/9213571833
is functional-system-fedora completing in 7 mins because we
only have a few ppc tests, but this is functional-system-opensuse
https://gitlab.com/qemu-project/qemu/-/jobs/9213571852
taking 27 mins because it's testing x86 and aarch64. The
corresponding build jobs take about 30 mins each.)

> Would that hurt so much to have one configuration enabled with ubsan and
> asan, which catches *real* bugs, and potential security issues?
> Yes, it adds overhead, but it should not be x10. Around x2 to x3.

You'd need to have a duplicate of all of the above
functional-system-* test jobs if you wanted
to test all the guest architectures, I think. So it's
30 mins build * six configs plus 60 mins total for testing.
Or we could convert (some of?) the existing jobs to use the
sanitisers if we needed to economise on CI time.

> I guess CI minutes are cheaper than engineer ones those days.

You could make an argument that it's the other way around:
from the project's point of view engineer minutes are cheap
because we never pay engineers, whereas CI minutes are
expensive because we must pay for them out of our project
donations :-)

-- PMM

