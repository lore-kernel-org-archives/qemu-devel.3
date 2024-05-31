Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE10DC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 13:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2cL-0002Xl-Nj; Fri, 31 May 2024 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD2cC-0002Ws-Pn
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:48:19 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD2cB-0007FN-5g
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:48:16 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5785f861868so2521498a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163293; x=1717768093; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eb5znBWtf5TgiMbGhrKi22eWTbS8zIZMNCUnaSeE6U8=;
 b=KAVfmf+Oso6xSq28u7yJZL241iQQs/ZICJbunVLQHYILu8ZcoAPSbVtG2SXXZhRQk7
 pubH32/C4mdq5Pljm0sacn3GkDXjAmGaQCZUBqzjzmkexHAhyF8ZLMO5Ydwn1lzxJEeP
 X5Y/tdm2zYPOAQZXsOvFkaCT/km1UZvTltVZpGV4MZHtw2jivRyXXAEGpC0ems61LG8K
 6nagfc8mPn/AMYa27eYlm/5twj/LeydMK6CQpihOimyhysOzCBneACRrflxMrMF5kjxP
 P8UtDchuaga99h5deU6zQwc/xwCH0dEjJviQsn/WmxtCuFtTLfntBltzXEygapfmkget
 SibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163293; x=1717768093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eb5znBWtf5TgiMbGhrKi22eWTbS8zIZMNCUnaSeE6U8=;
 b=Jo2QSeFPP1fmtVIVY7hLlxGwrtMAITwEEISiqMiKus6fNa3hj6f+jOValzQMZa0t73
 EwUL7ttGn+otL8ikXQft7z4gODe98nqj/P3RxtknwXNwD4jweLmm39ewIPkXlV7lsMFu
 yHOf0zFigcdoMvjmB/oxC85WF24E1LcShGvJHcwECA1sEMNuEdwEhc1xYzr01v6vyHKd
 COvIDrhHIuQg7qBXczXtG3MwkRzF7ANokKyUT+9edaLt7x1ZGf8Kkbh4DaBIgnSg6kRt
 K9oHgsXLKtkZ6xCQwcdSFlkLnf5CJdm/HL9W3L3e3dIu5DkPKYoBXdKBuVJK2oQGtQtG
 anKQ==
X-Gm-Message-State: AOJu0YzAQ8NknGnQ7D1FbUFYkuatd4njXssj3vatIqGxvf6qkkUJKr0c
 Op7O5E+Iul7+GaERYUk0On7wvqxW8KuJgQ0Zj+BX6im/QmG2FNbZHFMHhNgwITuEd+x6zZ/aRAo
 aZNsY69+cdDOeK2huGuQDfUjXdVzmZvczbtAhhA==
X-Google-Smtp-Source: AGHT+IHDia4FHQY9lfe1/K2d3RH/rRmeJFD8Gzbq3BsyZ5S3YDEkTc9EuVbNUlf5xi20sghJCLI9/js+Q2eTXiWZ9es=
X-Received: by 2002:a50:d4d6:0:b0:57a:2a56:8a37 with SMTP id
 4fb4d7f45d1cf-57a36372cd3mr1544617a12.13.1717163293086; Fri, 31 May 2024
 06:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
In-Reply-To: <20240524170748.1842030-1-porter@cs.unc.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 14:48:01 +0100
Message-ID: <CAFEAcA8-wh=0Fr75ZgepGAywvOhH=UfjkwxbD7=SkwR7Qyf0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Rework x86 page table walks
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, dave@treblig.org, nadav.amit@gmail.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 24 May 2024 at 18:08, Don Porter <porter@cs.unc.edu> wrote:
>
> This version of the 'info pg' command adopts Peter Maydell's request
> to write some guest-agnostic page table iterator and accessor code,
> along with architecture-specific hooks.  The first patch in this
> series contributes a generic page table iterator and an x86
> instantiation.  As a client, we first introduce an 'info pg' monitor
> command, as well as a compressing callback hook for creating succinct
> page table representations.
>
> After this, each successive patch replaces an exisitng x86 page table
> walker with a use of common iterator code.
>
> I could use advice on how to ensure this is sufficiently well tested.
> I used 'make check' and 'make check-avocado', which both pass; what is
> the typical standard for testing something like a page table related
> change?
>
> As far as generality, I have only attempted this on x86, but I expect
> the design would work for any similar radix-tree style page table.
>
> I am still new enough to the code base that I wasn't certain about
> where to put the generic code, as well as naming conventions.
>
> Per David Gilbert's suggestion, I was careful to ensure that monitor
> calls do not perturb TLB state (see the read-only flag in some
> functions).
>
> I appreciate Nadav's suggestion about other ways to pursue the same
> goal: I ended up deciding I would like to try my hand at consolidating
> the x86 page table code.
>
> Don Porter (6):
>   Add an "info pg" command that prints the current page tables
>   Convert 'info tlb' to use generic iterator
>   Convert 'info mem' to use generic iterator
>   Convert x86_cpu_get_memory_mapping() to use generic iterators
>   Move tcg implementation of x86 get_physical_address into common helper
>     code.
>   Convert x86_mmu_translate() to use common code.

Thanks for doing this work -- I like the diffstats for patches 2 and
3 a lot :-)

I have been digging out from under a big backlog of unreviewed
patches, but in an ideal world I might get to this next week.
Hopefully the x86 maintainers will have a look at it too.

thanks
-- PMM

