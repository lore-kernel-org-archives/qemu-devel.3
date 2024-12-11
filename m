Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLP86-0006yQ-5N; Wed, 11 Dec 2024 11:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLP84-0006xX-JD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:00:00 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLP81-0004RV-SF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:59:59 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3a0d2d15adso4711678276.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733932796; x=1734537596; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y/RdKbIPxXQfkG4w/uwXfArJcfPvT3aj5+LIG+su2pE=;
 b=D6CwxB9OVQkcPQfXa4KgAH0YHbUsgpLcQX79/FFACJoRXVdl3K6ECcLFWCXfr3shwp
 Qy+Iv0VHiHHn4bfVzYs7r54TFylMt07ys2Fo3yVmrcSjHBSyyidASXrbNUWv8WScxmsC
 u3E0feumcTkC/FxWTeWZHQmzLNChlaDLmruf7fBvj4c65/vL290OXh+2vuoRkziw6nGZ
 SVUg6lBHWbutop49gEsRycdidQcqyUtnRX0lHgcE6WJFY2pEDW9QfZ0P+a3+7gxfW12+
 8dAK4zuEJ+MjaK3apvQ/puTQAsG2Z6MltGAHzHKXGdiTRUnmXATVGxXJj0M16e+0n77R
 TZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932796; x=1734537596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y/RdKbIPxXQfkG4w/uwXfArJcfPvT3aj5+LIG+su2pE=;
 b=PNtD+edshZSsr/ssVmgAlKmgw2QklcWXpqBoRpzjMsfCVvFEX01j7p71dQu8swSypo
 bqxUZ9Q9rmJaoCMSLvZcVQ2weU0NqU2PKEeS9od0pO3tAq2rznlSk5PnSuT1ovckdyCk
 F/Wt3QiuzmCVCqOCXfQ4NtwN1S2QJXN0U58aiPHjZS+dBSmwCIgdZXdH+EZy/Fh0jTZv
 LFyNyy4SZCRyvQxkn2QWGMIlUowX1koJkYkCHv9i0zvEj9bjlR1lNqZl5C0T1V8gfYMV
 IArgKZDgzhPlv9ss6ODhDaEJUrjU0Ra4hV+1VVCgSeKthpCnHd+EllPlntCwAOa1pcmf
 iuyg==
X-Gm-Message-State: AOJu0Yxp6Pc6dcUGo3rwyIGu6GAkbxtpGR/JUR8mc+5EPzJtLORP9AEU
 H5c0b5sSLyW4BLliQH2bZsfZ0yX/FguItLveqfr840d8w9XfWC1dBL4dgi5aqnT9I+NEQFKi+0u
 +adR56e7ze5bDF3Z1dgklAJCsuxdFSNRU8FxJaOM5M+2TIZH1
X-Gm-Gg: ASbGncv8D2J09tcmJcdueYfZHC2m/eBGKNJwt2BTYIt1oA28U5pbvmIbKCWRJuz0LUc
 dNMV35ok6VkR7hm14xrD9YYTVKs1r0dvJGuP5
X-Google-Smtp-Source: AGHT+IH9cqkXSekiHH951We8i5iKNxJPAb7vTV5XHvKJ7dfi0p51EeL/olYjxI3CQnYQe0th2hsDM3q2wQ5k3zpBwkk=
X-Received: by 2002:a05:6902:2584:b0:e38:16ae:8477 with SMTP id
 3f1490d57ef6-e3ca0480e74mr438023276.23.1733932796660; Wed, 11 Dec 2024
 07:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-54-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 15:59:45 +0000
Message-ID: <CAFEAcA_Akf0FUWY+U_qa_ay-KU7d_h3crd=+z2d_s9qGP3B=iw@mail.gmail.com>
Subject: Re: [PATCH v2 53/69] target/arm: Implement gen_gvec_fabs,
 gen_gvec_fneg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 10 Dec 2024 at 16:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the current implementation out of translate-neon.c,
> and extend to handle all element sizes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.h      |  6 ++++++
>  target/arm/tcg/gengvec.c        | 14 ++++++++++++++
>  target/arm/tcg/translate-neon.c | 20 ++------------------
>  3 files changed, 22 insertions(+), 18 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

