Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2A0C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCdo-0002q6-Hi; Fri, 28 Jun 2024 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNCdl-0002oI-Ez
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:31:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNCdj-0007Fe-TG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:31:53 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fab50496f0so4578545ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719585109; x=1720189909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rglGY1YG+gk25H+wVT+J71pIwe8RBjgWCFs3wbXCF8g=;
 b=LxsOXTpgoTHlrxQ+SEBxL3YNmyyR2ESv3i914mrJOTDZQvOK9YeKj5aC4dr6MAoLPP
 YfPPSvwKoBUPtB4aNwOZfhhnpozLJgu9/kPjEcPsjYT4F3yyGQTuKsS1Kl19yJQyBfwc
 xLsqZJ5wuCA984ZgFOKdcT5H4qV6aJ69+VyP7WtyJg0zdx03zoPOr/RwPNnX84PEJxn8
 zHdzpFFV/wtd7CgeIOhXu8axSl5Er4vhN9e3TR7Ne7jjSDPiZA4JlDCYACRKMkTyHiEJ
 3L4EcLOGEJatvUbq6+ZDwg73Qj4NEG8OMXp3DaEh+FJcXcORyfBzhaRUUrhd31seuS3o
 Juow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719585109; x=1720189909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rglGY1YG+gk25H+wVT+J71pIwe8RBjgWCFs3wbXCF8g=;
 b=soTmUBaWctA+AiLkiNwpDenXp2QSPc4y7b7Mvr28Kfe/V30uKPSYUCXMeevGl00kr7
 R8teN8/q+CjwCbHuKu6ejT3CCBjyegAhi5MYPxSVymDnPc3vXWy9hlbSQ4OMO38aoqIu
 h4uBjUzA9PpScm0LQiDES6xsYsCrscbbvc9mzDev0No+QfRM1NQeyeYM5uc+41uykB8l
 369of51MUyye/Ibkn0wiV1UD4vBSejS4jA3bnBYtACCm4JB0yxTaoB7s+r7usIw7gx85
 9BGtybMOf3DpQRj3T/9+W9GP+eD7f0ak6luwnp/9SPC89mepOX2wlC9w2EEYIHS9aLTT
 sZaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIXXmaeM7NgeqQ9mRrT5/hyGnx2X0bbjDxy/xgkPcOsWNcYfY8K85vUr4M2EUvaSyjn1NeAz//ItBcydJYuWKhIhP8lUI=
X-Gm-Message-State: AOJu0YyO3IbMLgXM5kU4d1Xu+3rvRyFNtCehlecGSxZt8PfAe9MXZ8ia
 aaRESaoNlJ2Gqd5Z5xArgP1abBwRkmrxqdQu4r/VnhpLmTp/0FQfZZi1yX8lKNw=
X-Google-Smtp-Source: AGHT+IHwAI1PT/N4HSmLUpFzMZ2lfgQ92zD/I+ql3HIyL0/oniGzyu7f6uEK6KU0AGwk2Io0nxotsQ==
X-Received: by 2002:a17:902:e74d:b0:1f7:124:b820 with SMTP id
 d9443c01a7336-1fa24082256mr158330225ad.50.1719585109409; 
 Fri, 28 Jun 2024 07:31:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535ea5sm15867735ad.147.2024.06.28.07.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 07:31:48 -0700 (PDT)
Message-ID: <42de8f25-3624-4e7c-b38c-ad8e3b8e61a4@linaro.org>
Date: Fri, 28 Jun 2024 07:31:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20240619124903.56898-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240619124903.56898-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/19/24 05:49, Philippe Mathieu-Daudé wrote:
> Merge gdbstub64.c in gdbstub.c and remove uses of
> target specific TARGET_AARCH64 definition.
> Small step toward single ARM/Aarch64 binary.
> 
> Philippe Mathieu-Daudé (2):
>    target/arm: Merge gdbstub64.c within gdbstub.c
>    target/arm: Always build Aarch64 gdbstub helpers
> 
>   target/arm/cpu.h       |   8 +-
>   target/arm/internals.h |   2 -
>   target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
>   target/arm/gdbstub64.c | 383 -----------------------------------------
>   target/arm/meson.build |   1 -
>   5 files changed, 364 insertions(+), 393 deletions(-)
>   delete mode 100644 target/arm/gdbstub64.c
> 

Are we attempting a single binary for user-only as well?


r~

