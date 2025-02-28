Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F60CC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwoN-0006aI-1H; Fri, 28 Feb 2025 04:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnwoM-0006X7-4B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:37:38 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnwoK-0004CE-9A
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:37:37 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so1509978276.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740735454; x=1741340254; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0TV/2iQgifIb/lu9qz6E8/WAtyAooa0OGlZSWZw3FZ4=;
 b=tovjtMUyqrnxOT0vYJzl0HFKUF8RBk/5Wrj0muNt3lEBagenWik5wHn2F0OpQJJE5Z
 Mf1s5ZwkUzEpJy02K+QLO2OcY3geyBPes4RF/N4/NmTFzHpBGtITEBlqdbZpKK7OlT+O
 ycNdUVxxIn/AjD51yzGgUovPJpC8QkR2nz2RcqSQzg0+ym0XcxWrvPZttD58WHlEPjvH
 a1l/VuIF2i0x0/0KvOxeJCkF4FRU3dFkPiKtA62un3Csqbm49tk+xRjvCcPelJMxfcTl
 mX/B34J7aH7B9yUDBCzeAZIXa/7qLxtCQC/j1kAACZu9MuUQtQ4F4gqFJwCLwbR6zIsM
 O5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740735454; x=1741340254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TV/2iQgifIb/lu9qz6E8/WAtyAooa0OGlZSWZw3FZ4=;
 b=vtfesCX6rzmvGm4qAK+YgaMijLc2AGGhc94uCOoH6itgL7Crz0pp0C6pCir05NxLX6
 UTaORevpUlH8VBuZOUTj5Yli4JVLi+yCw/h2DUQyRodPOuTpT+Vzh0udNnEsI3DTyqnM
 4O74h5j5aZ92SVC9xHULrfYDQC8A90G0XBXFRskA4nKM/ZyPMqlcMmEi/IB5gs6PNWgs
 21W0l09t1fPIna7MHPBBvZV0G2gns3VaEIAf4YN++1SV92CWtDJB1RzRm8PO+o2VYz/s
 DZOosL1vG+X7cuZqBWBb6z1W2z9TpizwXTfwuGk47VLQbl6C7nS4ZrlMOh8zE6DRyVNk
 agQA==
X-Gm-Message-State: AOJu0YyrmfqI9wHusx8eKb0MmjTjwjvgVLiFGwF/F2Cda48MLRiDFkcH
 8tW1usvYUtCHCVGYgJCVViQoAFx6dZVyX/ZFO7zzPE9FnmyW6wkv53SevyLdoaX+sKMcrDi+bog
 pPEWHGfJ8uGGgKhCgP6ZIN1YhO2X2AxIuulRMu3w6iJPGpxVk
X-Gm-Gg: ASbGncvObi1YCqdsivZyxl9RSv3vtR8gcU9ORQaCC2aUqaqvrb60qjm0h67GFmqfBaG
 Xknh75W6Jnyh4BKJbfMa3usVMtIs2L+V68Avle3zWyXXxANnOo0TvIcJoKmTJ4CkJYNW/aPHFjb
 keHMMm6hGb
X-Google-Smtp-Source: AGHT+IEkCiSXwbwsfaOWkLBbn0CRXni+Cd6/uFDlLTi7k2GlDuBxNENLdhcaShfieqsAlTHiSTe0lckemkfh7Cp/ynw=
X-Received: by 2002:a05:6902:158e:b0:e58:32b4:487d with SMTP id
 3f1490d57ef6-e60b23f79aemr3144148276.18.1740735454580; Fri, 28 Feb 2025
 01:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-2-peter.maydell@linaro.org>
 <69ae459d-90ff-441d-a039-ae3ee15c919e@linaro.org>
 <CAFEAcA8=P0hJz45RFEBQX7QySR6+RiDqFA8BS8HF_k-m9BdZDw@mail.gmail.com>
 <05633317-0484-4595-94e5-c7fddbb2d283@linaro.org>
In-Reply-To: <05633317-0484-4595-94e5-c7fddbb2d283@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2025 09:37:23 +0000
X-Gm-Features: AQ5f1JrskvVFRAs43Skfrd-WYQLK2RpXDE8LyzIGEdcbTrvrecd0GssLAY546mw
Message-ID: <CAFEAcA9=rjjjV0qXhPoQktE_qa48MAEedU6kjc_t_ngnp_o42Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/arm: Correct LDRD atomicity and fault behaviour
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 28 Feb 2025 at 00:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/27/25 09:58, Peter Maydell wrote:
> > On Thu, 27 Feb 2025 at 17:41, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 2/27/25 06:27, Peter Maydell wrote:
> >>> +static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
> >>> +{
> >>> +    /*
> >>> +     * LDRD is required to be an atomic 64-bit access if the
> >>> +     * address is 8-aligned, two atomic 32-bit accesses if
> >>> +     * it's only 4-aligned, and to give an alignemnt fault
> >>> +     * if it's not 4-aligned.
> >>> +     * Rt is always the word from the lower address, and Rt2 the
> >>> +     * data from the higher address, regardless of endianness.
> >>> +     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
> >>> +     * so we don't get its SCTLR_B check, and instead do a 64-bit access
> >>> +     * using MO_BE if appropriate and then split the two halves.
> >>> +     *
> >>> +     * This also gives us the correct behaviour of not updating
> >>> +     * rt if the load of rt2 faults; this is required for cases
> >>> +     * like "ldrd r2, r3, [r2]" where rt is also the base register.
> >>> +     */
> >>> +    int mem_idx = get_mem_index(s);
> >>> +    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
> >>
> >> The 64-bit atomicity begins with armv7 + LPAE, and not present for any m-profile.
> >> Worth checking ARM_FEATURE_LPAE, or at least adding to the comment?
> >>
> >> Getting 2 x 4-byte atomicity, but not require 8-byte atomicity, would use
> >> MO_ATOM_IFALIGN_PAIR.
> >
> > Definitely worth a comment at minimum. Do we generate better
> > code for MO_ATOM_IFALIGN_PAIR ? (If not, then providing higher
> > atomicity than the architecture mandates seems harmless.)
>
> We could, but currently do not, generate better code for IFALIGN_PAIR for MO_64.
> Currently the only place we take special care is for MO_128.

OK, in that case I'll just add to the comment:

   * For M-profile, and for A-profile before LPAE, the 64-bit
   * atomicity is not required. We could model that using
   * the looser MO_ATOM_IFALIGN_PAIR, but providing a higher
   * level of atomicity than required is harmless (we would not
   * currently generate better code for IFALIGN_PAIR here).

> > For the comment in memop.h that currently reads
> >       * MO_ATOM_SUBALIGN: the operation is single-copy atomic by parts
> >       *    by the alignment.  E.g. if the address is 0 mod 4, then each
> >       *    4-byte subobject is single-copy atomic.
> >       *    This is the atomicity e.g. of IBM Power.
> >
> > maybe we could expand the e.g:
> >
> >    E.g if an 8-byte value is accessed at an address which is 0 mod 8,
> >    then the whole 8-byte access is single-copy atomic; otherwise,
> >    if it is accessed at 0 mod 4 then each 4-byte subobject is
> >    single-copy atomic; otherwise if it is accessed at 0 mod 2
> >    then the four 2-byte subobjects are single-copy atomic.
> >
> > ?
>
> Yes, that's correct.
>
> > I wasn't sure when reading what we currently have whether
> > it provided the 8-byte-aligned guarantee, rather than merely
> > the 4-byte-aligned one.
>
> I was trying to highlight the difference between SUBALIGN and IFALIGN, and perhaps didn't
> do adequate job of it.

I reviewed the comment patch, and presumably wasn't confused
at the time because I'd just read through the corresponding
code changes :-)

I'll send in a patch adjusting the comment to expand the example.

thanks
-- PMM

