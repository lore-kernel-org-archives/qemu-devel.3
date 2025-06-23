Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E18BC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiLQ-0006Tg-4K; Mon, 23 Jun 2025 10:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiLO-0006TS-5l
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:40:22 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiLM-0005Gz-Ki
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:40:21 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-7111d02c777so35207927b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750689619; x=1751294419; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NnUvQGsqcRhLdK6fyf0V+4PEsxOu1B0++Ht0of38zAI=;
 b=iGXG5xUApcy7m/UdCrXPWOyEEhGHA4jub+Bgovy1nEWjNxhhDkS/edD+puLtbY83Ov
 D8/jiYPNO7WgDtkRFcDZFHFbvAZDmApQskSq6M5Lrahu5DTsJ59749YbrXCWq/lsiQhK
 FdJOXMOB79qnCTVFxQWEhp81ITi+U1JFLNyK8xw3bjYYYkUU+bEAXKXoDvJigy44qrNW
 vgN9Zy9y+Qw0LkfAsPMxCvC03y2xllN3/czKGTdArJsrKWihSvP+uckdb1mFsCwszDp7
 igIga8M23VD36kX3jv/uXTdtlBbAJNCCs8CJ0109z9P4G0RegmOcFzaOL2bP+9oZHgOD
 +50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750689619; x=1751294419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnUvQGsqcRhLdK6fyf0V+4PEsxOu1B0++Ht0of38zAI=;
 b=LgfM4WQT6WGVjKQfZA8PGOZkQi8NSv3z5/6jdr36cHlb8ydp6PNr6NaEA8ISGbsabE
 ySTgswVoIK2Np1erenReyCIv7CeB4zoIkIL8NJLvOXvBHt8aexNz9aPdhgq7QMrIVqYn
 o7AYsnzoF+6axacpz2e3QoiKiwCRQD2e72nPUND+3rMOSzDj/hKEu5OGK4R1D3cT0RcU
 RMgkKGEHQxdHg9rCHqXjwIG6fg84TjRgqZEd4l2R/lOggszaoO3Hf4iFhmuhkfrZXwpv
 aNIe2zVFM0fQZ8CtoMvVhWXgU91MuGJWytef8pi2LTNlnibeEV/4A1+somXJ3HnNcbyu
 08dw==
X-Gm-Message-State: AOJu0Yy2Rvm+mjsDOb3iSx7N7O8v67SG0LxrhOKuYJ4eLgODX5rS125c
 qhBao0lXqdMxqnwMcMZprC39jFO2O8QqSpSL/fBT1IgYFQwRRzVhBVUlEKr7BdCkXWr7mqOCiv+
 bS8CU6bjgZxjwkn5cZIEqex5mc8OXgKFCP2oOptp4EQ==
X-Gm-Gg: ASbGncsiPxhwMTdptTx8Jd2qltXX0laO57j0T70AbFilTf5e4k7gnCI1Xb8mJLlms/F
 7LrGNyVssVncBksMyxqiD9RWWUWjCzmg4WI2H7UOp9TbwWKkIEyDKaPmDMGSuKLPHMDqg0hcYXu
 pJz3PW07UjbggKwbHZVZg1dS8YgLO0KbG9r0wIv+9fs6Be
X-Google-Smtp-Source: AGHT+IGOZOGwOWP35eMym9DApbnBokIsBT45PPSDVaYQav7LxUGcvVEXM2r45cegW4VKnAsx9+33SrZVb04yLtSO0gQ=
X-Received: by 2002:a05:690c:48c1:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-712c6511067mr165607167b3.25.1750689618730; Mon, 23 Jun 2025
 07:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-26-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 15:40:06 +0100
X-Gm-Features: AX0GCFs8XVsmrJNVnHngTFFAe1PdLsligYbtQg1DYAJ4MGMmL75x7blcNhtTtAY
Message-ID: <CAFEAcA_pmA0DF_wnuoAJ1-v10Nz1Jb5GUDuzo8FkXEaz=TfMdQ@mail.gmail.com>
Subject: Re: [PATCH v2 025/101] target/arm: Implement SME2 MOVA to/from array, 
 multiple registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.h     |  5 +++++
>  target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 12 ++++++++++++
>  3 files changed, 47 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

