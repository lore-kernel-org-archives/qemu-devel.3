Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39ACBC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMiGE-0002hU-8k; Thu, 27 Jun 2024 02:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiGC-0002hC-EW
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:05:32 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMiGA-00038t-L8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:05:32 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so84908581fa.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719468327; x=1720073127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QygVF7PSMf+g4VaR9guPo01BBtYeGxWuteFQX9jRnV4=;
 b=eOtLvYQ9ROc6eaaVt0fzc+l5Zjhedrr/wI6vMvlbDwB7nqXkTIlzd+eiuKYOc2uEm3
 CJnHQLFkI18EQ9UPGy5AyjgndzQIwPW3zEDunqMYN5PtLqROiGPo+6P8PW9n5pW+EQdS
 NuqUoMscaMzsF/YofsVh7o5fyWBlBHD6pqmCWQmf834Z9h/lXQubbf3GjJZYlOVWBx7v
 dZT3n4eh22u1rnyVqaMB7Zbwszemmrv8ETqUR1LNsoOAITyUbdXya3L0YWmNePVCkA9y
 myqJIA0SiAN/iqML1hey6OaNSYVAnYMcdDQpwv2EqzAFDG7943mK3IYnqhaaE/mElhFj
 wwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719468327; x=1720073127;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QygVF7PSMf+g4VaR9guPo01BBtYeGxWuteFQX9jRnV4=;
 b=BKkk/4XxIMUHbOXnL5mp0EeijuY7+ybXhpUMroKhZ3h0azB6vaiIF8ioPJWWO/FCm4
 p2y9g3dVOnMgnEU95MqHHKmYoFgH/PdHpm9miTC67z834NxvvE9bZbyBqKbbWatupCZG
 DTLWbNwCA6kx9JrNbu72lwRvhB+KwVJXdZUbu1hH2aVotSAyMU2FU+fx0gyBOeeecLHw
 Qsdxpek7bNYXCg1c6zMOVNVAVrFfw3iPtC/X3DjCayPBgak9onYzBrnpcIGHiMJxExaE
 PrAAvYLroy6wvHWOIP3qSqYa9E0gd8P0YdUma+zKbdpySp6bjo3bKDbRFIYT8YhhjINc
 MGBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeiCtuWze2ye4e2G8IQJpPwrqQFLOD+T5f17MFDTSMfbiRkjrg8xqNlMDy4AXmriGXZXbgb2Ta2TyVtSbHPEw+patk2Ko=
X-Gm-Message-State: AOJu0YyUsSgESmfq6vCtlUL3mUMWf6HYSnFZOTl35MnuPAOCp28eNZTn
 XbihHWYxNGpGs68b152HqtxhGOTcdlt96pOnkMZnTrnZsOJMH0QVq458SUGIhiE=
X-Google-Smtp-Source: AGHT+IEHqv9/SMkvGuRwDKg8VS2UsNzBLVpGMOCNsLQofiAUcmDVSPuD0wt1bk0lfPfBw23bwKYRDw==
X-Received: by 2002:a2e:8ed0:0:b0:2ec:839c:b659 with SMTP id
 38308e7fff4ca-2ec839d37a2mr32387811fa.41.1719468327417; 
 Wed, 26 Jun 2024 23:05:27 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8246828sm50129025e9.5.2024.06.26.23.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:05:26 -0700 (PDT)
Message-ID: <50ff9c9e-39a6-4be1-b6d5-42ff0dee7232@linaro.org>
Date: Thu, 27 Jun 2024 08:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627041349.356704-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 27/6/24 06:13, Gustavo Romero wrote:
> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/aarch64/meson.build       |  2 ++
>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>   4 files changed, 63 insertions(+), 20 deletions(-)
>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>   create mode 100644 linux-user/aarch64/mte_user_helper.h


> diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
> new file mode 100644
> index 0000000000..ee3f6b190a
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.h
> @@ -0,0 +1,25 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef AARCH64_MTE_USER_HELPER_H
> +#define AARCH64_MTE USER_HELPER_H
> +
> +#include "qemu/osdep.h"

https://www.qemu.org/docs/master/devel/style.html#include-directives

   Do not include “qemu/osdep.h” from header files since the .c file
   will have already included it.

> +#include "qemu.h"

"qemu.h" shouldn't be required neither.

Conditional to removing both lines:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


