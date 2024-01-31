Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8536BC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 19:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVGe9-0004PG-Ro; Wed, 31 Jan 2024 14:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVGe6-0004P2-5z
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:53:19 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVGe2-0001Yw-Hq
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 14:53:16 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-55a9008c185so175416a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 11:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706730792; x=1707335592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8qP3s69GFGG+7wRWTFq6UgsW7hYMCWK/SDPOknGZqSU=;
 b=ms8rQ1tmj29fXUfAnO8ATBJwKTz8njtJ4NCfH+3rBxLCCW7/bt68uEShTvCXn2WH3p
 SWuWHlAPRcZVJFjuo5kGV6yCAo+8ZFEfvB02nPy0OiaBunSJGQ3UJfgaNomrJmC4Od6B
 3SlMqwDGpXAyUy5qYJO+KvPx/2RRIsDpTrRLG6vKyfjyASiK+qW9KMtiSe9s5QqBT3oy
 IrHSlS4oqYV0uMx/R856OHLhHUY/rZtUO+yML9fbmLZS0q9qXnzKEN3A5yyEtWT4fRUR
 LoaI+sJOhxP+Kn62xZp7qjnFU3K+fLxSthyWn8NGpRVC+GAhM78iNlDQh9VkqujKxQHa
 HB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706730792; x=1707335592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8qP3s69GFGG+7wRWTFq6UgsW7hYMCWK/SDPOknGZqSU=;
 b=f2PNKuMfquuB+SFGIe2VGx0I9cofei5BWPJfA7jup2fOhxxHfyjU2Ijx+/MHYcdOnN
 mkaCBK1oQa/R4pqlklT4frNdtyyQHX+1tNLTxwXgJuMbZ8KbgDfZgU+htizLUHmmVzfH
 0y3AsHLONLiRFNqvDZ+PxXngW6TgMZBNoZiR9X3HbTuwj/JtwWX5vmeaMHqL2Q7dsqY4
 7uYw2NoGs8oTwBaJNPxOvK/y3WIbCFPJ2Lfdf/wTZxhsnUNAfeBiZX2ujzBsFxM6loXf
 rYSIXEwTCtzic/aChHRtoZyLGEeyCNe8QuLDSCUguBaef8m/cnQgm9c6/w9cACp32dIs
 Bc1Q==
X-Gm-Message-State: AOJu0Ywzs2t3ZANOepZ0k8OblkyR/XL7SYYlsfDqp91NhKoFi8kcyUPe
 Ms3oOJqHSYI9jFpzjuk3YR2hIeWiBmgv+XzSsC0NAdHSCAx3rkdym0D4v21bX/co2QdSJpYhbHN
 M+F5vsrJZnZ86auuKVac5BUZGhtbKIqG/4w7pyS6Az6oVFGSd
X-Google-Smtp-Source: AGHT+IFVDb7WaRPnTRqN5muVNpV9A/yFNeYT3sNgQ95/GTwvgxtekgOilXWAxGT5ZAIRqPHVNcD86sz5dyBXFsWt6pQ=
X-Received: by 2002:a05:6402:35c1:b0:55f:957b:318c with SMTP id
 z1-20020a05640235c100b0055f957b318cmr2174648edc.8.1706730792560; Wed, 31 Jan
 2024 11:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20240129230121.8091-1-richard.henderson@linaro.org>
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jan 2024 19:52:42 +0000
Message-ID: <CAFEAcA-r909OPv-2cG4KEspOf1RnVujGw-Ld8ST_sGWiPzDRsA@mail.gmail.com>
Subject: Re: [PULL 00/31] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 29 Jan 2024 at 23:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 7a1dc45af581d2b643cdbf33c01fd96271616fbd:
>
>   Merge tag 'pull-target-arm-20240126' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-01-26 18:16:35 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240130
>
> for you to fetch changes up to ec1d32af123e7f13d98754a72bcaa7aa8c8e9d27:
>
>   target/i386: Extract x86_cpu_exec_halt() from accel/tcg/ (2024-01-29 21:04:10 +1000)
>
> ----------------------------------------------------------------
> linux-user: Allow gdbstub to ignore page protection
> cpu-exec: simplify jump cache management
> include/exec: Cleanups toward building accel/tcg once


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

