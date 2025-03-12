Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7798DC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsM2x-0004qX-Ng; Wed, 12 Mar 2025 09:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsM2r-0004oi-RB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:22:51 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsM2p-0001ct-Bl
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:22:49 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so4648655276.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741785762; x=1742390562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dwurYr+CoRnMe6GaDPX6Uf5o7D8qKAwzdfDd9VBfJBU=;
 b=bXTCi4XuuMIMNcphslZExfDULbViheeIbLWdHXhblUpxhj/kX3jwhXfUqZB4LtoDnM
 f2uM/cn92CPtf+1jO7DMVSrmDXyzyGT0BrACgjuQ6Llgz22flED1vQgdeZ7YjejZBfl4
 Z1r6X+t7DCI2tu9tzfcKwepibIgwS3fhm0XrpGE9AN3hgxTgPbPCY9hYxeJmUg042bO7
 Tz6aHeiQKPu3vThWEy+V2eL1G4K8bsbb2jXJM8A5xTpvLX6fjXpcNmr4Tmf91RauZCNI
 3Uuy/9oRV2fDedus5cgDkkvkq9auVlWpVYEXA/CPogGAHitJKDG1xYtK5PqQ2E/Fok15
 rLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741785762; x=1742390562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dwurYr+CoRnMe6GaDPX6Uf5o7D8qKAwzdfDd9VBfJBU=;
 b=EK6KEDiJ+LnpAoB/T3nScpCcWGsf/yWfCqfh1F6cNZlc6T5Wv7QL5CUldlCu5OgXf1
 xmTzJfDEkH/9pnw2wKtmNmps5UlSvMtXksDtiLpurL+4ic8n+0ZjP+WeAStYNRNuzmzp
 Y24fgiwxbmi5WzH2tF+Pa4THMpxz/ylMOkJ7uVUUIy2eUPuvLHBdTNoJOuBOW/YC8g8J
 /8BXBU4TAY2fSQGLZCqGTjDrKecw7dWC9dFYje/NzrVYwvR4U7qnn+2P08LvrXAdbszG
 j1rgkbtfJ4wlm5BESKyp8K2eXg26XmxzL3d370Wq9Gvuci8sNf5SV4Xkgg4zmps33GgZ
 ky7Q==
X-Gm-Message-State: AOJu0YwjDehX8tL6DPNObmn9LRD0uPrXQWjVv5K9/7cHxuhF0n3H/xkt
 r89NHKqyGyr84i5dyOw+BmDowfP1Zxqr5efQ3TSrk2za9XQZ+E86TmR7+pXiKJGqPap1L7y2ilM
 hpaZV3WozK539GLqgIPSXn4MCV1pb2k9uiYTebq6G+C3VGmTk
X-Gm-Gg: ASbGncvAnI9Wf0AnZpbuNf90ZgXY3B4e1Dk4sOJ0qJRTpCkxy6+EhhF/J+3cJy45IU1
 AO5ftxHlTHbj/zgpF3pV0KbZ60ggR/40jF5A4c9DoT8XWhL3oGIVUYOVanXrqKOMBSPIKGHqsY1
 OwFLwKg5YWBZkAEeMxFvNp3vtH/QA=
X-Google-Smtp-Source: AGHT+IEHYYdk3XbVH7lXYzJ5Eh5wiY0ZtbgsvCXxGGedbGjypWYTarF8mZse2/ZLIPMjQNHDB4EFSuYSdWRWD9gpLhI=
X-Received: by 2002:a05:6902:3488:b0:e5d:cd08:12f0 with SMTP id
 3f1490d57ef6-e635c1ee39fmr23658488276.44.1741785762215; Wed, 12 Mar 2025
 06:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <CAFEAcA86t=uc_XZd0s1yOFsop68XN2HK7c5MUJNfn7kcDoMsxQ@mail.gmail.com>
 <CAFEAcA8CWFsxK6u0gg_pwCokGmzHe0=TRyf=9560APLX1DezMA@mail.gmail.com>
In-Reply-To: <CAFEAcA8CWFsxK6u0gg_pwCokGmzHe0=TRyf=9560APLX1DezMA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 13:22:30 +0000
X-Gm-Features: AQ5f1JpoYFkqDE9a5WKfsR7Bo13lqFGHxMfle8Cgg6Gs9cLd7-ImbdLSn9sXIB4
Message-ID: <CAFEAcA8Z7KcMkELkO42SfLQMi=ctdVWhp7C150_RkM9b-LF=bA@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/i386: Emulate ftz and denormal flag bits
 correctly
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

Ping^3 ? Anybody home?

thanks
-- PMM

On Fri, 7 Mar 2025 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping^2 for pickup of reviewed patches.
>
> thanks
> -- PMM
>
> On Mon, 24 Feb 2025 at 14:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Ping? Would an i386 maintainer like to pick these up?
> >
> > thanks
> > -- PMM
> >
> > On Thu, 13 Feb 2025 at 14:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > This is a set of four patches to target/i386 which use the core
> > > fpu functionality we just landed for Arm FEAT_AFP to correct
> > > the emulation of some corner cases of x86 floating point:
> > >  * when we are flushing denormal outputs to zero, this should
> > >    be done after rounding, not before
> > >  * the MXCSR.DE and FPUS.DE bits indicate when a denormal input
> > >    was not flushed and was used in an fp operation; we previously
> > >    weren't implementing these semantics
> > >
> > > All four patches have been reviewed by RTH. Testing is a bit
> > > light (make check-tcg and make check-functional), because AFAIK
> > > there is no freely available comprehensive FP testsuite for x86,
> > > and risu doesn't support x86 currently so I can't do the same kind
> > > of random-instruction-testing I could for Arm.
> > >
> > > thanks
> > > -- PMM
> > >
> > > Peter Maydell (4):
> > >   target/i386: Detect flush-to-zero after rounding
> > >   target/i386: Use correct type for get_float_exception_flags() values
> > >   target/i386: Wire up MXCSR.DE and FPUS.DE correctly
> > >   tests/tcg/x86_64/fma: add test for exact-denormal output
> > >
> > >  target/i386/ops_sse.h        |  16 +++---
> > >  target/i386/tcg/fpu_helper.c | 101 +++++++++++++++++------------------
> > >  tests/tcg/x86_64/fma.c       |  17 ++++--
> > >  3 files changed, 68 insertions(+), 66 deletions(-)
> > >
> > > --
> > > 2.43.0

