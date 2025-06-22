Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1708C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9yu-0004tc-3z; Sat, 21 Jun 2025 21:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9ys-0004sr-0P
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:58:50 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9yq-0006fa-Jo
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:58:49 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b31f22d706aso1585262a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557527; x=1751162327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=blwCMcWb/7knsA4nLMbsoAa2XinEMxgCEbhK3whzSXs=;
 b=bZkiB8Hh7/LamcQntLG7YYUkYJqss+/i54Cgb+zEasKOTad71DSLkcgu9SHyUklIPH
 GUNk90mt0DcXmPxxj6LGGAj43NmS9dm+TPvEx6d19GQPbaioBaiz+ArBKwKKyG8aZXB7
 LdRfI3rESHOg+bPdqlYuRxr3kNjIBpfEpbtAG6tHXf4qvksEy2k2sxjVVsLHABqrEd6m
 cbvnKTfLVqpdroxCFU0xKiQ4TaWvD1T6gaC1QANj6Na2Xyv3YR6XZBwrkij8oBMxPvRE
 AuLqIeaw424L/lkLGYZz1RvCJDSpEtXyAg76XkK+qiheFDQPLXpQaVkuqfmCzTGHXEiG
 vmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557527; x=1751162327;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blwCMcWb/7knsA4nLMbsoAa2XinEMxgCEbhK3whzSXs=;
 b=ktFuvLleH5yjesQnav7VnXebRD8ZpENgUnaf91yazM2CXKFbKWLakzZoyCI9ZwR38v
 hR35G5NeO0oxbyD7+6LsoV7wBK0szZz/rO+9+lAY9NLLnf5YxQvy3II/thZo+W27dPuQ
 wQ16q7POt1bgdo0X9RudbYIsoE/7pi34uUy/K/Xg7uATJ40NTo9ZlWwYiPWDFXIaQntU
 ZSIcfHVBebHRkLJPqqqERdDeemAKXT04KVV7RhfiqWVgaP3LFVRIsrpOR4CLmBLLkEsp
 TmtbCBWZouW6alY9CNp4b0fqIKrUjSf6DNWsHM/VH1izO1XQgzgJh7CiC8XorzY8Bv7w
 yeJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+UmlTAZvLG2CaUJeTl74A3xvCVNo8ZSDWU1GU8XUJREQBWjfUAZisA/2w+Pv+AV8NX0UC/gF6xU/8@nongnu.org
X-Gm-Message-State: AOJu0Yxjc5corb/l3sNbJEB2k7BfCl+UCgPoxHLIcv5o928LEtkaxqCI
 KJYf+DQhspOf6QoNIUN7A7nTsHL1B/WgqfmWUw5jR8f5Sx8OmSu3U52xqr0Ipp42i59VvOwGBp/
 yWlpPbn4=
X-Gm-Gg: ASbGncvJ4pxQWqjplMZ8wTHonhEj92cikBWsw9zS2SM/bOzFx0QBMC8nL4DtJBQd2Gh
 y6ypiuQbKjQDjOrjdzevZ3FCavOAkAxrNjnXWOqXXGt8P8TGd9SDB/Q292zVcvnQmmoylTw1mSk
 X6/0yilNFIVZyyAPVg63By0egUunXy2VtBeUKv/bXLIMs7LnaytTp7CP162G07uTVpEpSoRvT6e
 YL40uvLRcq2hh3MoLwWC4EguaEe8m6uEiIhCNyXeVRJcAWJLZZRx5bf/9N683ngAL+PfwIZyBGf
 RggrrFxUNUUYefrFKnZpQOHKm2BYn1wbj/iEZcT7P6ipN5S+SeC/mGwep2/iJJdI3fwaFwxTeEe
 WII2Lc4HERWF9WTdR4E7y7vS01pm2
X-Google-Smtp-Source: AGHT+IHawbDU2Go1nPjGQyxsKAnw25xJn/NQpOMNO77rNjVvemv/7GMANoFXKDe0jJ4UFcfqzbO1tg==
X-Received: by 2002:a05:6a20:144f:b0:1f5:97c3:41b9 with SMTP id
 adf61e73a8af0-22026e6113amr10896175637.5.1750557527234; 
 Sat, 21 Jun 2025 18:58:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49f3a8sm5258322b3a.62.2025.06.21.18.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:58:46 -0700 (PDT)
Message-ID: <80de9182-8dda-4afc-818a-f0631d0c4ad9@linaro.org>
Date: Sat, 21 Jun 2025 18:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 27/48] accel/dummy: Factor dummy_thread_precreate()
 out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-28-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Initialize the semaphore before creating the thread,
> factor out as dummy_thread_precreate().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/cpus.h |  1 +
>   accel/dummy-cpus.c    | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

