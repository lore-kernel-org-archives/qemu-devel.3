Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CA5C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 15:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU58F-00066w-D7; Tue, 24 Jun 2025 11:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU58D-00065l-ED
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:00:17 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU586-0001xQ-Hq
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 11:00:16 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70f147b5a52so41420757b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750777209; x=1751382009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YJPd908XyqpyqYSWA3//csuqfr8sggiRo4ismZTEicQ=;
 b=KgLz7nlWbw/rrv9x4qRIOTCmGgDRe+gCuG23rU7FKzjDZlzaMlV9H5bg/bwtbL1CTf
 A5mjpAq9Diomr+LbSUwc++qmJk2AnlJrkZwsPHrrK9YcmiefFD5ok23gGyvXoSQnNmjc
 sf6OAgcri+5BdYeQ0N9mTXOGnPHSmeX7eyHrhiVUObOUE2sloVwodmlMk5eikj3+rv6i
 1s7FqgHOzGaws5wPBbL3/VgsWV082H5aA2b3N1zTpdbjRs+cCqq1gQEXuXhIpg9YawBT
 IsYa81iOsamirE1ERqGuIdWiSKrRicHXVp0xQdM/x9tWf6mZFOlb5FM0g+8vT1a08P3X
 mG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750777209; x=1751382009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YJPd908XyqpyqYSWA3//csuqfr8sggiRo4ismZTEicQ=;
 b=rxSUUHvzSxAC1NXLFeaa7ijqXqM80HQD9wVUlpoHW/iOBDSYB4NqtTQOXomxCCNFGb
 KMGvCWKpoMTt7G5LcE1fQe/hEc6LR9nCFPtQ/65eJpKMrlnlxZTVhXQE2O2k06mDnzmF
 nzSysPflewYdIavoQpooO7egk8hNLRQnVKD2CmtAgEeCMz+mm19KHArpJU7CT89HX4eB
 NHFjJoQ5AuAjGjxnrnaHg04eM0q2e0iLleSrGV3+JzctLUQAL+bTtHDXcXhm5ZDhpB/i
 /XKKiWmz/u17dmRDG8BQp1sprD4bpsi15PyQ7V5G7b2gfhEoaLd8KNeEefgTC3QNsmxT
 Djzw==
X-Gm-Message-State: AOJu0Yyii0kBT+Kr1yvZJHUF0x3PWGC/uqJCV5djYVxO9BUYaqLB/oB/
 cdXthyvNkm19ALdUheRMEYhObpQnR5/N3AGUQMz98BVEZVo8VQ7gydVmpo5ke6jGdmr+GJ8gHOz
 WMG+LjFw1u2XmsMzkaM+vonAiY/GbjuNAGcSJPzDXkA==
X-Gm-Gg: ASbGncv81cPgSnYl9RQYoipZOZbSVgiDsljKQT9kwPS1sen00MgHBgtoDKHKx0+aq89
 KnNp9pYQl0QNuUGHdUFSFq50EUmaMuWPj+zuhxagryAjBcaA871naeWnhOWojCNLNQUgeyVwsrp
 4o7jYOt9w4Esec5jVJsqouwAQJQFtJ60y5Jd4Tq4Z+EIOX1ST5VBMlH9A=
X-Google-Smtp-Source: AGHT+IHcJWiK8SNCHy4Q2EI9OotZldZZFrY2243eAUAHV8n+OF3EmVR668C6TqDscePvEStBC+gb47CO56cqsCCRFjM=
X-Received: by 2002:a05:690c:498b:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-712c6389c0amr241392267b3.8.1750777208124; Tue, 24 Jun 2025
 08:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250622213509.277798-1-richard.henderson@linaro.org>
 <20250622213509.277798-4-richard.henderson@linaro.org>
In-Reply-To: <20250622213509.277798-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 15:59:56 +0100
X-Gm-Features: AX0GCFvdyeAuuCYLiIyZ0cDUSvMs3QzB55IV-dk2nv5NzlDI5v6aFG1KNfN7eYg
Message-ID: <CAFEAcA_AOqcN0=CQ30vpxsSXG97PUZhoYk8zYKGTuyDn3Vd2AA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] target/arm: Fix 128-bit element ZIP, UZP, TRN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 22 Jun 2025 at 22:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We missed the instructions UDEF when the vector size is too small.

I think this part also applies to FMMLA_d and trans_LD1RO_zprr
and trans_LD1RO_zprr ?

We should also probably put something in so that if the
user asks for a CPU with a max SVE VL of 128 then we disable
FEAT_F64MM.

> We missed marking the instructions non-streaming with SME.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 43 ++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 13 deletions(-)

These code changes look correct to me.

thanks
-- PMM

