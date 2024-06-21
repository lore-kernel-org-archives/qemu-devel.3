Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4746C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 04:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKW0f-00055f-Ub; Fri, 21 Jun 2024 00:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKW0E-0004y8-U0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:35:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKW0D-0002G8-GL
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:35:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so11377255ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718944556; x=1719549356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sXAhYrdRasbPI5d5sVbUMEXB1QhZEgmjvtjBDp35zS8=;
 b=JNXclHjlfT4zEZiitkT7kbQC5mLKbfq0ynfKGMk7hiO3QGiy9tWzTUmW4WIXPU9LgP
 Gb6yCiP4keqf5acTrH0DdNmE79PZvRGOpZImOInP7vbBePB1Ux/0spdhsxj5eAAGZhGJ
 uc9lDKbMpxjf0r4V1njOBhIDFkjnMOgfc5TNARcMbhh3JvMEiPa2UHv7WJvQ8uoAV0hV
 hReW50fNd/2FcNThHX8cGlmMjIrwhjVtqMR6Tww1LaqyhiP5xvHL0F/bPdNgqxY+p6qS
 9YZBKTgpcm8krJXuj7pgRGetG9wUSSCza5BLnHkmgJMWPxIgSlUXED0dey6LI/trQ3Sy
 maOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718944556; x=1719549356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sXAhYrdRasbPI5d5sVbUMEXB1QhZEgmjvtjBDp35zS8=;
 b=PG7Lb1dSnk3z6HtQVeecACEn4HXlumQ8TYCQ4RcXYhxgs1anzK4X/H4RjNV0cFF1nY
 Lrh6pXCZhzvyF1uRGp3v0HD6HARAYBIJ2lWCAokFSVdnh9ZIPEd6Gc5A6uyoO2R5gDGK
 EFYgkufhDpzGLToQ2tb+7a1wTJjMzRw+xhiG5YoXvdboWoIl9+xZtoW30nrUaxtZg60q
 zuJymNrySPkkOj1bYoQJgWFq2yfV60yvCK2jRTg2wNvc8ZZfzgeIOGT9j28NZq0HNbuo
 WEWNJbg0xRvhYCTRbXm8pO60xwbnbbFbdHxV+yVt7Qoyuk6gKX4DLsI0xyuh5UkHzEXW
 aqWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiuahrywUvCptmUuZgQJEs0YNSvG8qvvZ4vhyyVQxqlLnUv/QY5rZEjfzS8fVssAM+YviE+yxXJjoBhBNXBmEHPVG8WZo=
X-Gm-Message-State: AOJu0YwZ9K9pMN1K4MSNOarCe/3CWc1lP66tSWSf8QddgD+wdNlDpgkG
 auVzqXsFVZVD9VhIEAH1o432Nd6uGLXs0T4T/RL5Cpmgy69saC1plKT6VDDrb6YfScNqWGInteZ
 S
X-Google-Smtp-Source: AGHT+IH97tSfOOeXtEu/3JzOkIADRPCttrgY6hXElQdd9ILNYQuBTXqGtgXSueSFwZeTFXXnl2utdQ==
X-Received: by 2002:a17:902:650d:b0:1f7:209f:ae1c with SMTP id
 d9443c01a7336-1f9a8d4187bmr75218265ad.10.1718944555738; 
 Thu, 20 Jun 2024 21:35:55 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c591bsm4635445ad.165.2024.06.20.21.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:35:55 -0700 (PDT)
Message-ID: <9127eb3a-0a95-4c72-96b9-9a6af6725c2d@linaro.org>
Date: Thu, 20 Jun 2024 21:35:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-7-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617062849.3531745-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 6/16/24 23:28, Gustavo Romero wrote:
> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   linux-user/aarch64/target_prctl.h | 22 ++---------------
>   target/arm/tcg/mte_user_helper.h  | 40 +++++++++++++++++++++++++++++++

I'm not keen on this placement, because this is specifically linux syscall semantics.

I'm not sure what the right thing to do here, because it's not like there are any other OS 
that support MTE at the moment, and gdb is inheriting linux's ptrace interface.

I think it would be less bad if we put the header in linux-user/aarch64/ and have 
target/arm/gdbstub.c include that if CONFIG_USER_ONLY & CONFIG_LINUX.


r~

