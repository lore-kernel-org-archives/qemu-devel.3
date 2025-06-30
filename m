Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E322EC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGfZ-0005Tg-84; Mon, 30 Jun 2025 11:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGfW-0005T9-PH
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:43:42 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGfP-0001e0-3a
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:43:42 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-714066c7bbbso51187837b3.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751298213; x=1751903013; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tpgMN9h+M63CoPGwNEgkGRr9c5WoBO81ddlM3dhheL8=;
 b=UVuHYTyUFvvCBMDDgr8qyv+hq3PLXcCZWmaqVNlGHVFcWE9LEyYBJhF8rqke+cV0sJ
 cnTKDgtBTtFt3opoCf04ZPL0B35Bd/oXb403KeTjJBrgGQbJLQ2bg8LuSMrUkEwesCBB
 8Zbg8SRkpys6oFgSkA+b7gVxzNESBAIxX5DrS6tQYOUxKzByQLDLyzDgmziUp/9HZfE3
 92u1bX62y8AUNNFOxSfFsazzfcCwsiHOCYOLCqEkHK1jqMMEexg66cqwCGQf5r+uV3wO
 BTMultIdfggpuu8Ms7Rl8cF4LJL95V/3Y5gBDlJqVNQXvQqMSoGXWhr+qApmz61RkbTb
 mNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751298213; x=1751903013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpgMN9h+M63CoPGwNEgkGRr9c5WoBO81ddlM3dhheL8=;
 b=dCaWTOlmXUHFazvsizi6k00BxEenS9UT2vIzbRPUpVuZhF193AAX4IicJ+H5cT/bPE
 WREulQqLqeY6oW15p0HoRO+2PCAQl11MS7+PvhQ6VixU1ocPWow4m+tR7E+Deoop7HnG
 4oY4GYe5ORAn0vrfz0bTROT20ZowyXfu3ytscCB1Oh+NDjc2fizBZFfzRsy9swNkLD8y
 mZMCf47RTzt2KFB9Xz5jdl8k4Wb6hQRKX1iPfvqTL8vfYu5aZd8KU8evpHQlS2TBFI/O
 iCQ33UWSEZNZkLfdJNTJvzmMkD8ouI8o1X7RKuERo88FhSqfFCjtEGz/IDL4pdQtcg48
 iw8w==
X-Gm-Message-State: AOJu0YxytVJHfrF6hO4q3Wb0KkQHqBPhe/4Y+R+ecAmupWi/mKFH8cZS
 27LfrCxV+9MyLBca6zcUomzYz4WPBjCh91OeFW0H2TUJQEPMoWeTOCgs8R+p99ji6vN2BpdvAlE
 MWmVt1ULg0mIf5D0EB+Gf27PzypZD1B1Ta/ftVg9g8MhMof2gN56U
X-Gm-Gg: ASbGncsZTBYc1KxNH9ayFu0i35SKb+tSR8CAwCROl5CPFHMRxadYx6ENPcu5hAkd7eU
 Tj79W6eLd7IcIhYYLBrqiwTibcHJkQkf2INNgf0TvG0Tzr7ggK5dVX1PPV7KUu7OCeuoRqXRXm2
 bw2VQQYxJt2qOWEkGW4+QXralv2fWiuwNRH7ztjxqDUU7J
X-Google-Smtp-Source: AGHT+IEiZM5Wh+E+EOww6Wf0WqooOXE82xa6bcndGhsB51eX9CbAdwXweodGrWiWiIpFOEalLjDhFfkXMbvM1R69a6A=
X-Received: by 2002:a05:690c:8:b0:710:f39f:a2bc with SMTP id
 00721157ae682-715171582damr173292087b3.8.1751298212786; Mon, 30 Jun 2025
 08:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250625105832.1277378-1-kosasihwilliam4@gmail.com>
In-Reply-To: <20250625105832.1277378-1-kosasihwilliam4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 16:43:21 +0100
X-Gm-Features: Ac12FXzRNKfDSUYL9PHn7gSiA3g1lzHF_hkG8ZIGyFqYrUIZA6mRN-US7EuQz6Q
Message-ID: <CAFEAcA9X8B8cUbv2hj8dXEnu5OgBW=mzO47PBO9HEDzAVOnGCg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix M-profile helper loads/stores alignment
 checks
To: William Kosasih <kosasihwilliam4@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 25 Jun 2025 at 11:59, William Kosasih <kosasihwilliam4@gmail.com> wrote:
>
> Historically, M-profile helper functions in m_helper.c and mve_helper.c
> used the unaligned cpu_*_data_ra() routines to perform guest memory
> accesses. This meant we had no way to enforce alignment constraints
> when executing helper-based loads/stores. With the addition of the
> cpu_*_mmu() APIs, we can now combine the current MMU state
> (cpu_mmu_index(env, false)) with MO_ALIGN flags to build a MemOpIdx
> that enforces alignment at the helper level.
>
> This patch:
> - Replaces all calls to cpu_ldl_data_ra(), cpu_ldst_data_ra(), etc.,
>   in the M-profile helpers (m_helper.c) and the MVE helpers
>   (mve_helper.c) with their cpu_*_mmu() equivalents.
> - Leaves SME and SVE helper code untouched, as those extensions
>   support unaligned accesses by design.
> - Retains the manual alignment checks in the vlldm/vlstm helpers
>   because those instructions enforce an 8-byte alignment requirement
>   (instead of the 4-byte alignment for ordinary long loads/stores).
>   References to cpu_*_data_* are still replaced with cpu_*_mmu(), so
>   that the individual word accesses themselves also perform the standard
>   alignment checks, in keeping with the ARM pseudocode.
>
> With this change, all M-profile and MVE helper-based loads and stores
> will now correctly honor their alignment requirements.
>
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> ---
>  target/arm/tcg/m_helper.c   |  33 +--
>  target/arm/tcg/mve_helper.c | 408 ++++++++++++++++++++----------------
>  2 files changed, 254 insertions(+), 187 deletions(-)

Hi; thanks for doing this work, this is something that it's definitely
nice to see fixed.

My main comment here is that this patch is really too large
at 400+ lines to review easily. Could you split it up into
a multi-patch series where each patch does one coherent
thing, please? (For instance "honour alignment requirements in
vlldm and vlstm" could be one patch, and so on.) This will
make it easier to review, and also easier to track down any
problems in it by bisecting to the relevant commit if we get
reports of a regression.

thanks
-- PMM

