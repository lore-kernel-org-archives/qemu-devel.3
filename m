Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1578DC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tni9j-0001Qf-QF; Thu, 27 Feb 2025 12:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tni9S-0000xT-NW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:58:27 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tni9R-0004ig-2I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:58:26 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6f666c94285so11657637b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740679103; x=1741283903; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wzmFJFg/3Xt6bqgdO90cXYu9Kxx2CEGVHGvrYvWq0cc=;
 b=bpbTIVYp1Fwdc0LFv+d30n9bVEIqu9sH0xVgCSAeP4QLJwvFOzvQtE2GIgNPXkdYNO
 Swz3w09OWiRZKs7erOKQS5SHOLlrXLzVweT2bZQ+DgZUso8rNIfVFvB1WOQx6lBsOKcE
 x/nUEUU3q9nOTFucgW/ApOc0wKIhTO1mEVb4Vnv2j6gnZdgF5ko+4y/hRRS8im26/OoQ
 RDbiwMBuC8CWpxucQWiOmFQrcPpESsqbNUkgoBqx4vvbo8XsxHQ3c7ON4bcAJtoPaDu4
 CK04kVCBMDSnzYKXAblwHHAznh4RY6m0zxcTTtmOhxcHyvXDi2+QESqa9rnsNc8L6GQF
 qTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679103; x=1741283903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzmFJFg/3Xt6bqgdO90cXYu9Kxx2CEGVHGvrYvWq0cc=;
 b=clVbhKUn2igtWVA0SYR1J8ev4YMIcHhz8EWjhxK+t06Pxv8MMDPmfc3WpD0uJMa7Hg
 uI4eXJszSrmkcvaDB1S+8XKRrnDSOpcekcdg6b2ZvwdAROjby9hR0W9Ib3/CeQIEMGPY
 6t4rNok9F5hommjTWfNg2CKqt6lURGb/M0q0lIjxdcJyoyRmlOZ9Zmxv2bSQfE3+YvXg
 EGZT0pYT8iz3didBNRFmTfpOpkgvfwGVCwC+z9Tc16RMukZZksW2BnI/IBqjZu6IAwxs
 OFtUiGePXbe8yBSc7WVsF0rJ/pTFkfetvNx19MdiZaGGpqC4EUBk8wxXnBwUsYTzCgGV
 hLhQ==
X-Gm-Message-State: AOJu0YyIMFGKx0Crt9Nt0AWPFHCTPQxSyroxB5AvR4T3IxEVyjMqQpp6
 +R6N4ohqRQXNaRGZHDzjtyXXsDsquzTBqkB6AICGwkKjcBpItJIM/+6FeJ1nstPfBzseBYO6i9O
 I3Hjw0rdwBRJkZGVdWv+EAKSrORzxTuX/8aKYOA==
X-Gm-Gg: ASbGncvhzaZmlm/k39w7DoCn1OmZH8QQUjznTlTAtkYG9SYPUA4PhQxFdNMjEweyAt1
 fO9FAzT0449yFZAXvTvbl8rGcB9LUrfzxsCEEEDSLzCT+40RMPzq0F0LZMykdniAV9mD7AVylNJ
 8hPs0DgH3y
X-Google-Smtp-Source: AGHT+IGl2IP20UokPZVUUQ0Abb+7Hu8DNIDNGMLgHzW4EPceMFwFt/n7mz7qfunVuz+IZbI6BCOTZ3a+PRwXw6Nmq5k=
X-Received: by 2002:a05:6902:138b:b0:e60:9fd4:bdb9 with SMTP id
 3f1490d57ef6-e60b2f1cf43mr14354276.44.1740679103362; Thu, 27 Feb 2025
 09:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
 <20250227142746.1698904-2-peter.maydell@linaro.org>
 <69ae459d-90ff-441d-a039-ae3ee15c919e@linaro.org>
In-Reply-To: <69ae459d-90ff-441d-a039-ae3ee15c919e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 17:58:11 +0000
X-Gm-Features: AQ5f1JrW3uo3UWBJLAozTFWRlXUBh9eb58WYczCCOjWoEzuxMrAXiPMps1pywCc
Message-ID: <CAFEAcA8=P0hJz45RFEBQX7QySR6+RiDqFA8BS8HF_k-m9BdZDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/arm: Correct LDRD atomicity and fault behaviour
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 27 Feb 2025 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/27/25 06:27, Peter Maydell wrote:
> > +static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
> > +{
> > +    /*
> > +     * LDRD is required to be an atomic 64-bit access if the
> > +     * address is 8-aligned, two atomic 32-bit accesses if
> > +     * it's only 4-aligned, and to give an alignemnt fault
> > +     * if it's not 4-aligned.
> > +     * Rt is always the word from the lower address, and Rt2 the
> > +     * data from the higher address, regardless of endianness.
> > +     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
> > +     * so we don't get its SCTLR_B check, and instead do a 64-bit access
> > +     * using MO_BE if appropriate and then split the two halves.
> > +     *
> > +     * This also gives us the correct behaviour of not updating
> > +     * rt if the load of rt2 faults; this is required for cases
> > +     * like "ldrd r2, r3, [r2]" where rt is also the base register.
> > +     */
> > +    int mem_idx = get_mem_index(s);
> > +    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
>
> The 64-bit atomicity begins with armv7 + LPAE, and not present for any m-profile.
> Worth checking ARM_FEATURE_LPAE, or at least adding to the comment?
>
> Getting 2 x 4-byte atomicity, but not require 8-byte atomicity, would use
> MO_ATOM_IFALIGN_PAIR.

Definitely worth a comment at minimum. Do we generate better
code for MO_ATOM_IFALIGN_PAIR ? (If not, then providing higher
atomicity than the architecture mandates seems harmless.)


For the comment in memop.h that currently reads
     * MO_ATOM_SUBALIGN: the operation is single-copy atomic by parts
     *    by the alignment.  E.g. if the address is 0 mod 4, then each
     *    4-byte subobject is single-copy atomic.
     *    This is the atomicity e.g. of IBM Power.

maybe we could expand the e.g:

  E.g if an 8-byte value is accessed at an address which is 0 mod 8,
  then the whole 8-byte access is single-copy atomic; otherwise,
  if it is accessed at 0 mod 4 then each 4-byte subobject is
  single-copy atomic; otherwise if it is accessed at 0 mod 2
  then the four 2-byte subobjects are single-copy atomic.

? I wasn't sure when reading what we currently have whether
it provided the 8-byte-aligned guarantee, rather than merely
the 4-byte-aligned one.

thanks
-- PMM

