Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A159CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5W8-0006yo-EE; Thu, 23 May 2024 06:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5W5-0006uo-DX
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:17:46 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5Vz-0007T2-JV
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:17:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-572d83e3c7eso11971904a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716459456; x=1717064256; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hY5ZzASdIn6WgyN33yvSIaRnpfXfnQ0jO7ZBv/7e21o=;
 b=kFypkYwTnj5iKMYYu1UC6t5HpxYtEXzjc3F3aT+NtNyjCsUXkiR0aM6jN3A4SFzSqT
 ggZIxISj8Fd2gOO82y7UKnIYZCDa6Km7hhpPSfQODcWDL7J4gClatsmwcPHkoGlu17Zt
 HDkvVtgugQnFN4INLaZMtcLts/OYL9EZV1JQCURDUfZz6mstf3SXfuRD0QkwB7aLlmHJ
 D2AkAUhOa19RLrMb7cWi9Q6cxHFwaNUz3an31UzH5Rzh8uImPx1b8NYAd96r4RC0b8QK
 gzrYuz0bDmtmn8c4ExRaY9R/S5+GU7tJIEAsKpmJJZ2uyzTUpozfkmjuKue2Mk6QqbHh
 kk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716459456; x=1717064256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hY5ZzASdIn6WgyN33yvSIaRnpfXfnQ0jO7ZBv/7e21o=;
 b=gwsAlX2GmCIGjNlfK/Zmoj//TC7gQM53MDsRoyzVVKAo1nFK260Q3mYRjUnW+FFqmW
 TidRY6F3/4uWNy8cFsUlqSPRi7FssNx68orVftGwkzC5+LZZZy9JHLB4x+rmEgTYKb2e
 Z5Cc0ZIXqvlnf/r4bD5RkD14Afey6tIfyEjmdmNUKt4apd7MeQ8GBzVgjJI0DU8ia/ok
 JJvU510Vbdj7n39CFyXbDjgzxIK7UJDZmzEB4Po6aP0fjEv+gN3a86zdd+87rcJFJJS9
 3Dtk2OP5zxIyruf+jO0pmzm1Dehdhbm8a+COLPhh9k8XRL49lFAIYtLscnJeQdhaPXYe
 fkhA==
X-Gm-Message-State: AOJu0Yy4+MSYTjaWHddwEhdPsBJsRrhFZT2Zlcj88RgLOSotPrOzkboM
 nylyN4Q76ow33sszD+xI7xXAzHGrh4xTfV/IeQmJgTr2KRc40HBkV9E8YTkP91vufy0Y8vEBS04
 GkCuPdsNDZuciWnGXPzjD+mg/tT7wQXZ3b50mgg==
X-Google-Smtp-Source: AGHT+IEwb1eosU4UkfIxFFcvojebUqQ0rdL97UjpMWuWG1HbfLwtpeZ4N9lZRRv8lGSk752v1mHQLqhUFZ+j10D346w=
X-Received: by 2002:a50:96d2:0:b0:56b:8153:54f7 with SMTP id
 4fb4d7f45d1cf-57832c65159mr3225216a12.30.1716459456071; Thu, 23 May 2024
 03:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-9-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:17:25 +0100
Message-ID: <CAFEAcA9i=KYsMoRBf1exVQeODCrHhVTjSr7ey59jd7F_+08TDw@mail.gmail.com>
Subject: Re: [PATCH 08/57] target/arm: Convert Cryptographic 4-register to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |   8 ++
>  target/arm/tcg/translate-a64.c | 132 +++++++++++----------------------
>  2 files changed, 51 insertions(+), 89 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

