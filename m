Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1833E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJb8F-0002UV-Hl; Fri, 06 Dec 2024 11:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJb8D-0002Ql-H7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:24:41 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJb8B-0004yd-Mh
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:24:40 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so3416927a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733502278; x=1734107078; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jeg8gEIFGwtRxqg29I8ok6MAXCgiF7d+5z6yZXoNI7c=;
 b=yPhDCISXFHumXqBPWXHzBDTvt/oWgKR3zxDUPv4R4mePuiZ3f7dCnZ5DNZs4hBkjV0
 NsvO25swBs/v76c+gI6ly0ZmEN15kq6W/wsF5/3QXDu5eih94pPocAoeNTLdOKr+dI4H
 5Ho8DbFgpvjzRBRwFvvvXtYNukn8ToR/xEZGLQpKFgHVDB0C7ejz44y75JGZTNKCqlek
 HSLF/uXlKkP6vyKgEtRgAeIjn2HLjMKatNgfKEHJNsOLNqZglRRlF4gQkhmIAsq+elkC
 YiVzPGtzIKiDvT88Poj4qJRGVVOgDEYMmGUJzn6sgBhICajx38YrlGXizGTiuYg7HGKa
 8cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733502278; x=1734107078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeg8gEIFGwtRxqg29I8ok6MAXCgiF7d+5z6yZXoNI7c=;
 b=naiERVKw1ExyqUYKno3kABrowrtK6ix5NWTxRpP0l0iKaFw6LmCv0L4WsFPTH97KVT
 9fcf22W7mGOVkWc3roZR5xGQeZsWtvXP4iJfXHnpco6Uh0KxjvNPi8UbR7Js6zGIeDv0
 ZVnBi9wjrUO767rAo+YgE04AId7LtxLgxvdF8vHpCLEQ5w39/4kNPWQk6dLWbDv8I8LB
 l+axCcDOnQ4HKOFSvoOUDj2/LI5JwssU5BG3e7ju6iuR+GSY88rKoCc0cbigBSVS9HT1
 JyLD265B5wBG5wxg7PxWng3tZ7bm1X48o5wwQm5tAoTxMzckCme4mu2BPBKBanJwNz0L
 X6wg==
X-Gm-Message-State: AOJu0YyH+xROVcCgvGySdj4EpzA2dlzG4ZxFVV2ZOgerLxtR872STcLF
 yGIHBzqRGWrHpBmxuJTz9EWFs4iLP/PjgJct7RdPAVSb2EIoh+T3l1AQ+HnaigaNe+J8EtK5Mx1
 f0mO27lYBOic/2T8rx8r2/t2hkR6cj4gFBzDPhw==
X-Gm-Gg: ASbGncvMyc2VpheVDB04gE9T57+saoKfvCHgvmVuNFNITfTzaMD8ikjolRqmuBFzFxC
 SkQS+V12cKtilcq4G0kX2Se98YnP8EksLqrY1
X-Google-Smtp-Source: AGHT+IE8BNiikdD722CeLPV4h5XAbmLChcgeS6hvteCuuklvo6se7IBQLv+yZ2knu6P4Bu9qfC55HuzEzWMxYzyDuz0=
X-Received: by 2002:a05:6402:2349:b0:5d0:f904:c23d with SMTP id
 4fb4d7f45d1cf-5d3be785c74mr4398892a12.28.1733502278008; Fri, 06 Dec 2024
 08:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-58-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-58-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:24:27 +0000
Message-ID: <CAFEAcA8EFbW3QTz4-DeghL_f3nTU=jJ3cGbLPy7eQGazRHkrRg@mail.gmail.com>
Subject: Re: [PATCH 57/67] target/arm: Convert [US]CVTF (vector, integer)
 scalar to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 1 Dec 2024 at 15:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++----------
>  target/arm/tcg/a64.decode      |  6 ++++++
>  2 files changed, 31 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

