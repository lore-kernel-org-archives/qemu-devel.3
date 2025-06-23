Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77159C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeUJ-0003Qe-T7; Mon, 23 Jun 2025 06:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeUI-0003QA-9i
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:33:18 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeUF-00020Y-NI
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:33:18 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-711756ae8c9so33333847b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750674794; x=1751279594; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ky0S+H7p4aHmEr8g8IEVTHuts35H2ogACNTRcNUzIIM=;
 b=R3HQyu+A82kmY9Kk4jAbPxO8xlEb9ChxvPVZQxuGG53c7OYVaAfMnuPTbOEJzJyyOF
 4tSPtYSKzNYKV7UujpwpAa9rDTYkKa4Sx2TfhqRK2iK+qv/K6zpKVkJs+QnbOl+UIFii
 yyCQfKh4V8F1YTUT+3AFiB+EOI1mJBe05jVhyZ1G4/ApBCXDtvjenyrhDRqBiH/qST7b
 M9fmW8mY8tcc5UBiCi4L5SlVzU/s9J14mKgZC0z7p1ax+TkJnfp4qxg6nwcelMopMlDl
 41s9RnphoExDT1hU/4VvHCfPFLaLpxXTGp6FKz6Pl9asoM19VknRTkzMUw4M4o542Caz
 s/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750674794; x=1751279594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ky0S+H7p4aHmEr8g8IEVTHuts35H2ogACNTRcNUzIIM=;
 b=Khen8rn/8yTDNI2Itd2v0x2+WJyYvvWOQmTey6cFTd1UdFLh0uFpETICHucD3QVCNt
 NdXpPF18VJARQm9RPVXORxPdLuAhFED9q8N0fKXR9lkeSwfx6rgPzSmDgSEQe7ExY7nK
 5MjhNnOOqHSEt4VeXdnKcw3F1B+LeMz0TajJwkAzo8gkSgwykSUm39h9bqIqHFjL9br2
 VZlZyggjYVk9HrTh0j4BLcw+onBNh/8hvETH/Ok9KVV1SnTLzEsEBrsmzuS8IjUIUR5I
 YkDdj1Jt1CwL2j3s6ep13VqmxabNAqyhHPpjfyzpYLbeaSQ85wY1jbKxBFPkiT41OfZ4
 kmkw==
X-Gm-Message-State: AOJu0YxZQSYk/tTBatLFRghxGdLfpkV72AP6PLJ2M9Yy8g4ELJ0xAW6o
 TR9fyuUeapByCs6bOh/9KUuRclMSQUm6MWGudW3dLnPKe4oPRcJIC9uqELFFOMxsakfZ2FarA2D
 reES8rcy5M4WVuPTMAqm+yJ8z+YbbHImPZbOudsmHPBvxdcm9uqBG
X-Gm-Gg: ASbGnctedzUgapKanjIVbcyM7iVYz78UWN/fm2yxeKUaqApoyRV0UJJ3YTcrBydWkKJ
 3WtCJNpIWrZjLqmL7h0qqc7CLsdoqq0PJngtbhp0x+3BKl3Zc/W/FkSxpDXoFmjL5mFnoDUzZPQ
 qXa8qsFT3oko3o89W5KtyvewNuwlVTYpQpc1Gu/auTR/jE
X-Google-Smtp-Source: AGHT+IELHOjIceJg07MwUX5P4W8OUOIKQ8meVGEFLT58GE++qjw5MzlUuBHRGpF8O0xpdjLqM+5xsfpOmZk7RqRLlGA=
X-Received: by 2002:a05:690c:7248:b0:70f:9fcd:34f1 with SMTP id
 00721157ae682-712c654c974mr162538157b3.25.1750674794261; Mon, 23 Jun 2025
 03:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-14-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:33:02 +0100
X-Gm-Features: AX0GCFtP_WST-I0CbGhk-S5zE6Qp3EpjSrF96MKrwhpYHCGAA9wdrvGFxCDa_w4
Message-ID: <CAFEAcA_X4DAQRj2VZHjtpc0rWWF0rsuwsJrq8ojNkBnORT06SA@mail.gmail.com>
Subject: Re: [PATCH v2 013/101] target/arm: Use FPST_ZA for sme_fmopa_[hsd]
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sme_helper.c    | 37 ++++++++--------------------------
>  target/arm/tcg/translate-sme.c |  4 ++--
>  2 files changed, 10 insertions(+), 31 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

