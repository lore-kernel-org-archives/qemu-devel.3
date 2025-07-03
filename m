Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D432AC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIq7-0001tg-1M; Thu, 03 Jul 2025 08:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIpa-0001pc-IX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:14:24 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIpY-0007u5-Iu
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:14:22 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e85e06a7f63so4789273276.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544858; x=1752149658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SJl2l/ctMmpsKlO9p9I1LFFMligMTxXXm3NiBVrJTgc=;
 b=GpEGXgv7pqUqKQ62Flt1i7gZSp7O6p4xgqih4GxzgxNvyqfPqVgni756LE2biqC6d2
 tmvcktfSWliPV5U9vjxfIHutjkeBl4WEI7maESThR67oJ/2WN8TDVcQOc4cskzK6LM7f
 C4yivx5wgWzlLjPR6la8usrRMwCt16HsPtbO8oP8GdFKwwHXTyMEWCZqXBsxynHrMUiX
 CO0Q9BMqwDZz7/WdVZSTpw+PRSmrTvkYhGU7dRnZNsGzeK+4phMVHE0Ai6nOLTQhQkMV
 AVuX3LF43VtQ9oA9AzWoInBbU/jde/QCjfB+A2KuW8O7HNTkFlRxOV+PnTblcXvU/lfI
 4YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544858; x=1752149658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJl2l/ctMmpsKlO9p9I1LFFMligMTxXXm3NiBVrJTgc=;
 b=PewWWvWdIQ+/LVcBkBx0eX89lSTTrsqCmGcMU8dzlpZINIm9cav7XPyd31mW8UnAav
 8iGFppIsB3B5ONmFLMnDnE+SpaqPPswxFFeI7Wqy3rv+1RfZiDbgihs8yqEPDaehkaiN
 FBuiUiNCn3eu64Y9RTmH3JdbZ2cpmp6r64ql+l1PH+/MoVzN+yYJV1XNvyBI1blT8D8v
 h8JQOEY8qpGJGzkNe0oEMSUeG7XzAo2Aui57H3odF5R5iYbRWimHBY3HeMlmB0z8By7s
 uLhUuHtUi4d42Exo/NQ7F8BO7uKxgQ9oTdovq8enF7wMqBPlmbs59bw6AURkIKvfPlQO
 OFIw==
X-Gm-Message-State: AOJu0YwEupi1tZRQEzFumbLoYmeAVjWlGtAliEJwo3B90BACC2fdh+R8
 LWMKOqMukJwoXXsrbllB5mElwYzPEIFlnAsgtYpN0vuFgX1UqgeKa/stmy5fhaYBeRxB5TpqoAs
 75TSZMddm1QLagmciObc+YuW9xf5MdMMEtnAIK6UgIw==
X-Gm-Gg: ASbGncvgq7NSKDRVagB06xYRhlPtbXgxIJ7pDcN0eacmAiO3KcVLSaxf6SrgBciMkYM
 dwH7EMWPvkEsMINPfh9WA5XD3B7ghAcvEA72agc7wNlXD1amjfyuTD1ZsXIrfZ2vf7Yz5Fq0LMx
 0QaFJuArZ4s+STWabkRYGdDi+BvidriCRM7db/HdC/ABA2
X-Google-Smtp-Source: AGHT+IG86D8NflKrMu5lLYjhh6tiG58LnGjZjBVf53rblIKgUkIMHpFJOoQIZAuxHPv5C6nRcjwxtHip8lDGEdeSwLE=
X-Received: by 2002:a05:690c:b96:b0:70d:f892:2dca with SMTP id
 00721157ae682-716590e9c87mr43040427b3.32.1751544858190; Thu, 03 Jul 2025
 05:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-70-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-70-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:14:06 +0100
X-Gm-Features: Ac12FXxAb-np65tku3FriYg4X72GXdar_A1Yr42NQzgV8gpcsZ2XZder-hs7058
Message-ID: <CAFEAcA9AA0Uh=6rh+YVGy1kxp4cUrxtRe-vXqJCdOuW0dKH0XQ@mail.gmail.com>
Subject: Re: [PATCH v3 69/97] target/arm: Implement SVE2p1 PTRUE (predicate as
 counter)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 16 ++++++++++++++++
>  target/arm/tcg/sve.decode      |  1 +

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

