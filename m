Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA81C3DA45
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 21:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSjvL-0003mo-AF; Sat, 13 Jul 2024 17:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSjvJ-0003lx-UR
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 17:04:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSjvI-0003lL-7j
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 17:04:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso18001015e9.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720904690; x=1721509490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPr7FJcVwaRe0rcwhr9Pl5pEzttFJpVfXWxoqmIm0pI=;
 b=tAB4xalmfgrUXUxAOxpN7sWkDvcyxq9K0GGe5P+vCBcv3Z9a0spK0LR2QFODCMj+LF
 p8OUgbH2xABxdmeRi8HiomTlVB/ASA/0R1pjRwDdD+Qg2qW6o3+p/LTT/x8kUYl29yXG
 AjI12tZLFSfxDrEY+FsTqE84xNXXJdrfZpKkN+T3ale73nSRGv0s2trJYI5jL14DsqEf
 IWgDf5/vKbunYY9eJFXq5UrVI/D3FV3mZGabsa1l3MS1teXu+9WJa0qgiWsoGZ6WhYYq
 LgjQj3OKiYNT/d7dILW4YwCB+yoifUoyNzPO6cb7jdl8wLFf3KvYURqZiC6KKFe/P4KO
 V6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720904690; x=1721509490;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPr7FJcVwaRe0rcwhr9Pl5pEzttFJpVfXWxoqmIm0pI=;
 b=ZVq/MH7Ng4uyl8+8xuGHu3fdqL1ADDr0+R5qZ314ezzTi0s2JQgBgL08ZaGqk2L3uK
 sKA4dhg1ZIg1dy+G3F7geTE/JewOBWI6AkbF3MtZJpyp84iI96omE2QNkVsjOzo43/wG
 Snc4rPjAS76zO9ymoqawj9TZmN4Oy/BJrT7Ne6cKY2P0GBIcPJhPec3BaZQlfNdCSXWN
 S9pfc8tI8e/3dyxI8sZZwJ2VCz67fLSc56F03fGuk/BPK4lFLog8HGrStTPB/8e4DU9r
 /rKjWYZe+abiPKNi9Gl+8neIbbHSwbKfqbTAGFp9iP1MXN1LLKGaXrYvz1Wd0BIzNSdb
 oz+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0OJ67BOj95hr2iCgvTm5imLHsnYGlQU44eVxZxNWHdWksOy1g5aYYIqXBcHjas6pLuBage+lYtJratpkTxGbLUxXbClE=
X-Gm-Message-State: AOJu0YxalkkL9hLCgnyTwjn3By5Q0neeyu14BITx955ugeo+68ku8as6
 6pxro7Ro1VkITcQiSmpkelcdZLxNRwMr5Z0v4yoUzMlByi8sJIYsWP555GGaWq0=
X-Google-Smtp-Source: AGHT+IEF7gwGHQ+ixA3B/TZ+R6Qo/IbtWAJVihInS9ovLWNO3YoeAzPwo7fXIyVeufza7mBkf6v4xg==
X-Received: by 2002:a05:600c:2d43:b0:426:5e91:3ff1 with SMTP id
 5b1f17b1804b1-426707dbae6mr94215525e9.24.1720904688839; 
 Sat, 13 Jul 2024 14:04:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb12sm2335732f8f.88.2024.07.13.14.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 14:04:48 -0700 (PDT)
Message-ID: <2ab72e93-ef89-45cd-b2ac-4e39250edf1b@linaro.org>
Date: Sat, 13 Jul 2024 23:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Make cpu_exec_interrupt hook mandatory
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240712113949.4146855-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240712113949.4146855-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 12/7/24 13:39, Peter Maydell wrote:
> The TCGCPUOps::cpu_exec_interrupt hook is currently not mandatory; if
> it is left NULL then we treat it as if it had returned false. However
> since pretty much every architecture needs to handle interrupts,
> almost every target we have provides the hook. The one exception is
> Tricore, which doesn't currently implement the architectural
> interrupt handling.
> 
> Add a "do nothing" implementation of cpu_exec_hook for Tricore,
> assert on startup that the CPU does provide the hook, and remove
> the runtime NULL check before calling it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 4 ++--
>   target/tricore/cpu.c | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)

Patch queued, thanks.

