Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F23C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzJX-0000jB-Gu; Tue, 28 May 2024 12:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzJ8-0000M1-Dx
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:04:14 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzJ6-0007vf-Kr
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:04:14 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5785161b98cso536859a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912250; x=1717517050; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nFxJYvNldHwZrVCu+fFet6j2GNc53uIscAyjPU2nE/0=;
 b=F4ZV6FRYB+9/PiMeSEmE0DVbFwPkfZIxVy7IMDk5biHHVx16j5mJ1qz/TSQsCBcuaz
 tiMJEUgHpu8DxGV9aTVHQHZ0PG30W75hoyEAq84nrEC27vLMMS6n8LflJc2O1IaHxNlp
 4MkfEtzlTvnx5cjGxGIk3ziS9irY+rpENqnq+1Qk+2M5YMx7Hhei5Z0/tzlIpjFf172A
 shQCrkqNUJ7ImT8HsnlaAlYtHvHNJ30JxygHCs1KOzD1lgUvXi3XrHkhzA8BqJHYYz6r
 94uWZkAEGJmHnGbLQZsywLPZ+OB99pKIYpTbdPaAUrhfgJVr1SDBMMYptSjgq2ylfWWY
 35Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912250; x=1717517050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFxJYvNldHwZrVCu+fFet6j2GNc53uIscAyjPU2nE/0=;
 b=UIfQjoIM7wEG6FkBiy6Is72yWUEN1ZZVNny/fiW0SBa/ueIfk291ZfHpFsLG1G4V7M
 LG3YkdMj8j8MnA6XTq4Llt5Ccp/VGCP8ood8COqMeVMTLjRxmZuwwWIjMWCaCwmQnUMf
 2lNfRCQRIkUUxDUif9PdlVuAtxeuAmSWA6P7RG/w/hams68emWlQJRn9IAYV15DSnDFa
 tbgU6TPBFqrAphAM9poF2vsasmCnmWcyzaKKGex9dtCHRovePvP3aS9rrtGzAe4/RjT0
 E6jxguRaEjuxLNQI9gLbRoE/Vij8Y+r2Gh+nTp4G8Tyz3IHikHcuI78Q5E2STW5O+o02
 83zA==
X-Gm-Message-State: AOJu0YyzttXecBQ5uWI2SuD5WlfAiJ5pTRRGsN90Tly05QTSWArvIGTe
 aWdMpBK0U5WhQ1C5aJsrYyC9DAwPpuFvnSmibKh6A7w40KpIy6X47NDAv1BWo0GQqF6mnv7gSTz
 2++FAq6irbPtQp4c5XZfFENKroKQ52+sFo8oSZwsGFuV45DGi
X-Google-Smtp-Source: AGHT+IH/YrCKkcAzwuxM9h8p6h12tjE/UCfJ3LUxmYpz+LyWAxJO3asqnO5cdXtnXi7K/Hccv0nEE2uxQ9jfFhXWEMw=
X-Received: by 2002:a50:d55b:0:b0:578:631b:3090 with SMTP id
 4fb4d7f45d1cf-578631b3ad1mr8469202a12.33.1716912250292; Tue, 28 May 2024
 09:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-59-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-59-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:03:59 +0100
Message-ID: <CAFEAcA9sNmyL=+oQwvJCf+xUu=5=NHRxgWGZNFgxVyTZM4gpxw@mail.gmail.com>
Subject: Re: [PATCH v2 58/67] target/arm: Convert SRHADD, URHADD to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

