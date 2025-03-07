Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425DAC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 09:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqU95-00037Y-99; Fri, 07 Mar 2025 04:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqU93-00036l-77
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 04:37:29 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqU91-00040o-JF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 04:37:28 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e636585c375so197342276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 01:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741340246; x=1741945046; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9vAVCjbBtm1hrRkIItvVnS/zutr8mShW6qHS0Mb2eYM=;
 b=w/MNoNSxE2/Yj9szd0WvDKmaGpRdvR6dSO7aPcbHem0ae7ce6GpSQltTJsZieUqYoS
 RFe0F7+/krtkkjXHqtI6gWTqLPXJ0fY9XtjimGFdgiw+N5qAKtsst7/5BKaoIU4k6Iua
 49Xdq1JWos4350+CshmnYFSHBzYL/4UWINbC6YS7cUCWDPKXD2FwT21WpqHdn7cEpDZL
 XeZJy3PlOTVLn6Chv0TJF8ZEJQpBOUoyLkNRrqruiUODTZWcvsB+jWE7e7+T6HQZVRFr
 cAVnG0d1zGfjsWcAtuO8/0j93FiS1MBqIKP0Apt7ll3QJ2XbM/1KRpleVViLgBiWcvxX
 TTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741340246; x=1741945046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vAVCjbBtm1hrRkIItvVnS/zutr8mShW6qHS0Mb2eYM=;
 b=dOmbasmBx1XLkc9pgkhrJNBU71kAp2T98id72fpILs2pbmzbhIakPlE6Z3CTVaxVMl
 SuuHkTiCk/HrmuwtSib2o5Er5sgx4kapVOS536O/2UPyWCAGWRlfCS/b4M6+BXyb8K1V
 GFsB5dF2xLXLVZEX3gNJeIy58IlcCk4IaDgtZCgWxO5uxApc0w+cXOIw3ArVDLtOBD85
 b6SMh35dvXsKrfT7WNNqsUL8mpj3aepSt9Dho6KT14DEP8NuLvmebdGAiUo8mB/C+tm7
 bI20CKknndh5o0CmOAeg84Qmu6g9f+YsnFpyWZfzr1EsWWVLqCRat7hKDEaT2yv89j/U
 8Vmw==
X-Gm-Message-State: AOJu0YwnKj9yHoA9TzSoeusnGjvnJrdT+r6Tl9F9tCMtlnz4tMqDL+f7
 +7r6Gi6NzLZpMxGl68bKYu7zQ9SJLws5D/UUY40n7MIYYZm3mSEjcbkk1A3Pxi79GcUwL0biyMQ
 UrdWC+muYSUmBDsBnYjdBjaVs7Ubhz0ZtV5ygog==
X-Gm-Gg: ASbGncubia5iiNZ+gC4WrlUDXXe5UBEVu7klUixn1grqIDQvZSdVsswxZ7xqyekH/1f
 txQYrHvFTnM7V4GS7UmWCYhrxNMXSpTBdyj8zdm8ZXJqkY1wBm/HQXnnrzXMdqUyS6TPHPU2NsQ
 3d8d4uU2HnsnvSh/CZkyf4VAGI4r0=
X-Google-Smtp-Source: AGHT+IGXqFrKO20rbgIu1/d4jBClYgd/7INXKG50C1g0zsGiSIHA2Uoth96gOwMDQvxQo34uTpCQG6arvlSnyyTQnTQ=
X-Received: by 2002:a05:6902:e0e:b0:e60:9821:3a with SMTP id
 3f1490d57ef6-e635c101784mr3481295276.6.1741340246072; Fri, 07 Mar 2025
 01:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-6-peter.maydell@linaro.org>
 <300563a6-a37f-47a7-bb94-74cdcd6256b3@linaro.org>
In-Reply-To: <300563a6-a37f-47a7-bb94-74cdcd6256b3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 09:37:14 +0000
X-Gm-Features: AQ5f1JoyQBk6TPd3AIAM-dVPJ7gqBjCZuZ0rpYM0eHhkTA7EBITWAzB_VMD_5rI
Message-ID: <CAFEAcA-BFbV=YyvKTHLeJZNtY7gDvyLyiK67-9v897BM9-ZLXA@mail.gmail.com>
Subject: Re: [PATCH 05/10] target/arm: Move arm_cpu_data_is_big_endian() etc
 to internals.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 6 Mar 2025 at 22:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/6/25 08:39, Peter Maydell wrote:
> > The arm_cpu_data_is_big_endian() and related functions are now used
> > only in target/arm; they can be moved to internals.h.
> >
> > The motivation here is that we would like to move arm_current_el()
> > to internals.h.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/cpu.h       | 48 ------------------------------------------
> >   target/arm/internals.h | 48 ++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 48 insertions(+), 48 deletions(-)
>
> Is there a good reason to keep these inline?

Not particularly -- I was just going for the minimal changes
that would let me do what I wanted to do in the later
patches...

-- PMM

