Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9626C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzNt-0000KZ-UD; Tue, 28 May 2024 12:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzNr-0000Js-Oi
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:09:07 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzNp-0008WB-KA
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:09:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5785d466c82so1257877a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912544; x=1717517344; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PdLgBF7+1xlgB7t3G/mTAbvLmebLWALfLrm0ZhBnGwY=;
 b=yPkdYtNnaFKM1SashxHAn2Co0CHH2jY47zDqOV13pxx+yUm07JKHlDYcNXuRIHbaBx
 P+LcequLbCK1bdyw1bxSgyO7KprUpP5P9EprSAPj82PbIH/3wtoul/DW55DLm0YJq51c
 nv+1zWvez196lTUW2ZBbdC1ME8Ob9kbL7vOdR6mkUPfH4HFLQu9IKXSf5C7zfaaZ8pG8
 ANbG3ExV5SbiYN7pG/aZbg/XnPImkdSQLcX7TYuj1K2rnabWS8NR1N5b9eHcdpLMqOmj
 Fpn5/4xTGUskt1ZXhxwL1/vaJjgfEb5LtEq/cAQVDIYBeVTjJVsPEEFm1DgWDUIBn3Rt
 ZIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912544; x=1717517344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PdLgBF7+1xlgB7t3G/mTAbvLmebLWALfLrm0ZhBnGwY=;
 b=H9Z3QZcRIe8iubEwuIOlDMH6mAIkf4P+WJgQ0zGHsiKBcpqcYCxpPm3cK3t9EiCRYq
 eKzVJXusQcEObE7ZpVmMhT4jVz1bOQmYyO61mSU6SdFiwd7b1m/+TCNfwqHJHYDz0+5L
 buy1dkbiCx+BqM2+xSrDVpbNXb94cKzK1gkft33/aC/aIcuR2J5abPARDvtPlN7/fycM
 zq9oMCUNH2GNUb65Nt7hWSpWFf14vSN3Z7ETRqsGcv69pSqlyxb1iTgFgtNH+mD8iHDZ
 KF441Qnqixl0uqVlbD3scY6mX78BEIlttNtCEnnaac4mm7qr+D3ieoPd5C5w7mnN7A9A
 ileg==
X-Gm-Message-State: AOJu0YyUINPV4zDmjwjm7osIbHkUH9U4blzRVYiQTrwcyAcrN5YLUyX7
 MW93SReaAFleoRhb4BHt0+0CXbLSn2oafsID09tcvwEMxtrNo+j9boziwYUigYlzqmDcFhvnoB/
 B+ul14TTzDvNcbMWAcNnhNoDgx/LFZ+R7d9kwnA==
X-Google-Smtp-Source: AGHT+IFwSKK615226NXCbPn/O9MhNg/s2pxHbYHds0HyfCcKNlVMnhHAfvyvF+JGB+0MaSq/U6kVzdhx1CArk5vfLz4=
X-Received: by 2002:a50:d6ce:0:b0:578:3413:3776 with SMTP id
 4fb4d7f45d1cf-578518ef497mr9209703a12.7.1716912543652; Tue, 28 May 2024
 09:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-65-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-65-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:08:52 +0100
Message-ID: <CAFEAcA-yw09ZHPE=VsS3Jkpt6=vF4G=9Eh6G6n=yhko2D6H4Eg@mail.gmail.com>
Subject: Re: [PATCH v2 64/67] target/arm: Tidy SQDMULH, SQRDMULH (vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We already have a gvec helper for the operations, but we aren't
> using it on the aa32 neon side.  Create a unified expander for
> use by both aa32 and aa64 translators.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

