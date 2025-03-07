Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DDCC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcS5-00029o-0P; Fri, 07 Mar 2025 13:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqcRk-0001zg-Al
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:29:20 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqcRi-0003ki-Dq
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:29:19 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so1766524276.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741372156; x=1741976956; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sBGrkrGQHrveYxByS1V88t2AqywCMhHvGJGf9hQE/AE=;
 b=laLOqN4eNFZHgbYzrjvOou12hcUCmGHlJ4KN3iFbiY2WnKtljD7GrmOkCTnJETVeCu
 xlM8qoh887tdYl61xq6hYgmcIjBtmNLk1jt6l3gTwLmgpkQlXZil4GQkg4rArgtHzLgm
 I82oR/ffEF+QiSnexgwzYKCajEK+0DkjuAaw2CvnnZJwt+e1a63tWju6JdTGf1OgapGX
 /U5txjltAGi+XrFhFRwEsYZ6pyRgH8lEonBt1EQDnJqJl9bGBidMk92ysy3U2YAoTjES
 SksmWhPoWzn2w87x5kwj+f6sQwTDtVaraZD/jAp4NxBrJPcrbR8J+ZqQ6hKFtpEs2RWJ
 jaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741372156; x=1741976956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sBGrkrGQHrveYxByS1V88t2AqywCMhHvGJGf9hQE/AE=;
 b=Nm3TPdTZh8j3jY0EGEZhihi2A97TWVZIPaU8vzpSI1KIA4VXyO6hMkdwNJP92lAZw3
 C4nTVIrLpL6HWcY+be1m+rs2lKQBQkEXhRDYC8/mwBCuqheq8BZGr3HEMvhKlabDw7Mv
 Xrd5YmEgGI1u743CoD+m3YGqGKhTI94QNEalj2Qb3YQy3ErFHdcUgljujjBzGCtovvzV
 aVRa1bU5uivrxEyGJ9WGbuBlftriPlyQwFftmaLTiIkIQOalTE7H4b8hcJn/yw97ZWtx
 M5fCQp+DPR1UozC70nEUuYYV/CQArsw+Qtr6aHf+ZVF8/r2XL5KHC/d7VRMnGm4BS+41
 0WXQ==
X-Gm-Message-State: AOJu0YwZZYIuHMq09UR3httpLODOUlT69eAYyV1R20gIExoOrvwROUe4
 LpvDWTibsJsHkylM/7OgNj0yFXzZNc3h8RkRy4HSsd8vvST5cyNg+LyfYv0hozAZgMuX9Ctodh0
 U++rUUl6rFvN6iIjg+f690veUZqxlGOJA6wXlitCzgI2VKueb
X-Gm-Gg: ASbGnctgLAphPLBeQnozZAvGn3Y9RkRW71/iwTjIHEnl3OSZhVlt0pRDJusn9YMuVQR
 qE9BsAlwxsiuZb/K6ecEQK1felmwD/6W7wkMtFThXAZaKtTN73vq3TwuvsslxIbZ6MF3ZIiZsm6
 at25/d3MOmlPysmDIR2LkCvZ+DOIA=
X-Google-Smtp-Source: AGHT+IEkbIC6ZCHxM/lIetStO0gq/vve/kCpxBZXNAZzEB8R8MNROZ0xKzYe4CObh8KQ8NR6ZpJviJyVWtnhAwx/JuY=
X-Received: by 2002:a25:155:0:b0:e63:6f6a:ab03 with SMTP id
 3f1490d57ef6-e636f6aaca0mr678045276.22.1741372155961; Fri, 07 Mar 2025
 10:29:15 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8ozGhFJWc41M6ziB3mPtEQ_bpWcQTCj1Ue_W66-MYf2w@mail.gmail.com>
In-Reply-To: <CAFEAcA8ozGhFJWc41M6ziB3mPtEQ_bpWcQTCj1Ue_W66-MYf2w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 18:29:04 +0000
X-Gm-Features: AQ5f1JqvRelUg0oW2ZIgvMHadTQfZMlCSfGFCY2dH5RfAeE3KCCGBHDBdUzHjc8
Message-ID: <CAFEAcA9iepVWQVAsdeGAWDkXVrOLK_dq1cdiceVdwozGuwsYXw@mail.gmail.com>
Subject: Re: make check-functional failures with --enable-rust: unsafe
 precondition(s) violated: NonNull::new_unchecked
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Fri, 7 Mar 2025 at 18:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> thread '<unnamed>' panicked at core/src/panicking.rs:221:5:
> unsafe precondition(s) violated: NonNull::new_unchecked requires that
> the pointer is non-null
> stack backtrace:
>    0: rust_begin_unwind
>              at
> /rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/std/src/panicking.rs:662:5
>    1: core::panicking::panic_nounwind_fmt::runtime
>              at
> /rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/panicking.rs:112:18
>    2: core::panicking::panic_nounwind_fmt
>              at
> /rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/panicking.rs:122:5
>    3: core::panicking::panic_nounwind
>              at
> /rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/panicking.rs:221:5
>    4: core::ptr::non_null::NonNull<T>::new_unchecked::precondition_check
>              at
> /rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/ub_checks.rs:70:21
>    5: core::ptr::non_null::NonNull<T>::new_unchecked
>              at
> /rustc/f6e511eec7342f59a25f7c0534f1dbea00d01b14/library/core/src/ub_checks.rs:77:17
>    6: qemu_api::qom::Owned<T>::from
>              at ./rust/qemu-api/libqemu_api.rlib.p/structured/qom.rs:741:19
>    7: pl011_create
>              at ./../../rust/hw/char/pl011/src/device.rs:716:24
>    8: vexpress_common_init
>              at ./../../hw/arm/vexpress.c:647:5

The backtrace suggests that the rust version of pl011_create()
isn't able to handle being passed in a NULL chr. This is
permitted and means "don't connect up a chardev to the device's
chr property" which in turn means "you don't have a chardev
backend" (and all the C qemu_chr_fe_* functions happily accept
NULL and interpret it as "just do nothing").

-- PMM

