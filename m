Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424EFC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 10:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhQ9k-0007e5-O2; Thu, 31 Jul 2025 06:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhQ9R-0007UQ-BM
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 06:04:45 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhQ9P-0002ju-4R
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 06:04:41 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-708d90aa8f9so7577947b3.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753956276; x=1754561076; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JIM4iBcaC+VOP4ZgNmX3tkYQOgIFiz2vq6dEgqYM3DA=;
 b=B++/yhl/CMg6dXh+gkgQvwhd4H6hNYAxs9iWMoTWG699f3gFnboAZXdfqIXKRNeii2
 CHDNAhXvoQmrDjI1ctDso+AmO0vehmCjSACnigMt61PiFYhhTX5awQ34bXm5MTb8kWfF
 nupCV5V5gNFxq4Wjt0QcYnVP77II7ilZ+Aj5sF+RWyIwdYyMlJ9L7Y8cfhL+RugBVLs8
 wle9tqvMK5TeNKlbt8OnQ2QmFm76/Iybd+axHvLWwLci9daM9wuyJ+wEzrmtv7QutC0d
 Kar1WmQlLtZfqMSgxwDZOPxCr6LOw+tID4BIdnABiap6llDPsI0KQSmMlzmg7VFCYd3g
 WRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753956276; x=1754561076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JIM4iBcaC+VOP4ZgNmX3tkYQOgIFiz2vq6dEgqYM3DA=;
 b=WJ4mkXbPJh9g6gG9mDRcDvp5426Bsrl9daPeMnOtreJyFlIj0ES3jOxB6+T/X/fjHU
 meNpWX691cclcLyhFddJ2U64BU0s9q5sHTmJPUVcJCvKymCHh70G20JdwjmbYcg6SLCr
 VUnMhpVj/TWUzS3aGQNgjPlxKTisX9TvpAXAfkc0CCo65tw49tsWHXGEdMcJ2uQrywAK
 W5MnKKP5A9Ma0DNXkbtSUYlmYBmtKyLwhgyNI7xIcH4HBMURSH4fJf7GW4M4E7jW1+wp
 Hnive4ydM+qXKW2ozp4M/9Zgswx4ml96R5UbKU53GhifQTj+xzM1vGsbZaD28GeCGZ7N
 Ut+Q==
X-Gm-Message-State: AOJu0YwiaPdROj7BbEe2hFeIJ/aywDxUmDQn0rquGIxghs8NR1O/ZPbI
 TECuS3uu10TYag61JZlq2Ud/aZdRsQw03q/WyEOWBhiwro9tPO3nO9j9qxYDir2VoEjG0E+xT3U
 seFdxWkFrzsB58jpw1b5RLPLNmzO3vCR/aZ77ZxXZQA==
X-Gm-Gg: ASbGncupUjKsFuQLCEf2PiiBW/ysYVkhZpfhr9PglTkuZpaqP7NTNdEtZVJsXGSMuxe
 gEJh0aAIQ+waKsRLLoA+Y2wnLrpsU+cdeT+SScNxJkrHoI1TVm5md7t3rbKspwtUk/hobR8xjo+
 FytJ4p1KdjLtV9keEkisXK16fQkjMdfYNMCcdq8Wlq/S0xB9yExOYrPwJ0aSSNXGjzCGstNWIQH
 P2nfpPk
X-Google-Smtp-Source: AGHT+IGcYAHl6OC2+ql00RLEtCL45TLmCUov1XAJCPlN9tOJ4w58QF2M3fs3PAY7FldVyfmqRWo1pvMJG5aF6/ybAls=
X-Received: by 2002:a05:690c:74c4:b0:71a:1b94:b0c7 with SMTP id
 00721157ae682-71a466983b1mr93231307b3.31.1753956276328; Thu, 31 Jul 2025
 03:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
 <20250721132718.2835729-3-peter.maydell@linaro.org> <87ms8uh7ln.fsf@suse.de>
 <CAFEAcA9kxDdkEyLguTsEV_nDX9L5mAT+Rw_4Rmk68YQq50ee-A@mail.gmail.com>
 <87pldo3x3y.fsf@suse.de> <87ms8s3rpx.fsf@suse.de> <87bjp24iyk.fsf@suse.de>
In-Reply-To: <87bjp24iyk.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 11:04:24 +0100
X-Gm-Features: Ac12FXwkUwvG0jeTlCKTl7MHcgZFY-94qdqyerOIL19wrC7N59xhz8RrwbXPX5s
Message-ID: <CAFEAcA9gK8EFBb2UyCv1B2d7TiK+V07Y9Bw0e_UoiUHP4MCDcw@mail.gmail.com>
Subject: Re: [PULL 02/20] target/arm: Correct encoding of Debug Communications
 Channel registers
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 30 Jul 2025 at 01:32, Fabiano Rosas <farosas@suse.de> wrote:
>
> Fabiano Rosas <farosas@suse.de> writes:
>
> > Fabiano Rosas <farosas@suse.de> writes:
> >
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>> I'm not sure how to handle this, as we have no mechanism for
> >>> "ignore this incoming register value, it is bogus". I'm surprised
> >>> we've never run into this before...
> >>>
> >>
> >> I was thinking the same.
> >>
> >> I actually don't understand what the encoding in cpu->cpreg_indexes is
> >> supposed to represent. How does comparing the indexes implies "in our
> >> list"/"in their list"? Is there some sort of ISA level assumption?
> >>
> >>        if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
> >>             /* register in our list but not incoming : skip it */
> >>             continue;
> >>         }
> >>         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
> >>             /* register in their list but not ours: fail migration */
> >>             return -1;
> >>         }
> >>
> >
> > Ok, I spotted the sorting now.
>
> Turns out the backward migration is also broken because this patch adds
> an extra register:
>
>   qemu-system-aarch64: Invalid value 292 expecting positive value <= 291
>   qemu-system-aarch64: Failed to load cpu:cpreg_vmstate_array_len

Backward migration is not a design goal for the TCG cpreg machinery:
you will find that we add extra registers from time to time in
over various releases.

> We'll need to develop some proper compat machinery that takes the
> machine version in consideration. For the 10.0 -> 10.1 migration,
> something like (messy code, just a PoC):

For 10.1 I was thinking about just putting back this specific
incorrect register. We can do something a bit cleaner once the
release is out.

thanks
-- PMM

