Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED0C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 22:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s46uG-00037K-Dg; Mon, 06 May 2024 18:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46uB-00036a-5q
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:33:56 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s46u8-0008BM-KM
 for qemu-devel@nongnu.org; Mon, 06 May 2024 18:33:54 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e242b1dfd6so27343081fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 15:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715034831; x=1715639631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKZK7GhS22Ca4xYjYmBUZmlou/jP7ZyWM7qv7q9Fwhk=;
 b=UjR9zyofrSg2lflP+V1qug56Nb7aMiJYM2ltUt5nMzKOaLq3PYat1PwacFMW2s5owE
 7nHu+tu7BxXuad8Isegq8HmtCuu0vXon7kEDwaPFmy82F/Yuw3lAWbA0lNUY5uQ9358k
 //gx+AErIpG8OKnGEMQJRvZACOSSrFQCJdRiHI84x4pBfO5mPPmBVBYfIgExoS3CBZJ/
 PpkU7WsWSs5qHET8oZ+pmoCiK6zzD9Mws96J9yj7CDxEkPpmwWObHTND42hSRGrMuKtm
 yPtuLYWYgsxDoVaMXH3WfwyUfYB2GZi5cUt+1BMdJd1ecrbCOrwdNHb8qltYvpAp55y4
 iUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715034831; x=1715639631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKZK7GhS22Ca4xYjYmBUZmlou/jP7ZyWM7qv7q9Fwhk=;
 b=UKbaYnoaeWt+35cpTdp0VbZ5AqF2vjqnJ6gjeeFQtsc7zWU+5HoQWOtsN6h92EPKUX
 3EX+ssj4j2ObqQtp8pBvrNyt5auHk9I/OdFc+eH4wq7d7UiBobuFY9tOVcw8Pnux9z+p
 uVILYWfgnUD9/eJiW8v0O1hRyV9MQFL1WWQTs0FzcGn+gWGEZsEwtpAa8Ri4W0+5wU3u
 t16YPSR0WkGgtHaeWCykB/fQ/6CYVJQVi3f8jJGkELRdPuXkAAkrb4xYKTOlQxmPSAHo
 UPUju5hRl9jlp+izgm6IxVHFWC5BsWgLF8oWrkDFUNcYHYnrTNehC1pnqZaXYatJrb2X
 4XGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViMzK/cMTtpBhamfPUT1bI11ZcZLL/yijGo5ctb0w103uWRCBstzlTxP4yxMOZIduwJhlSiiXnLKR3FKAoYuwOS2m4epM=
X-Gm-Message-State: AOJu0YytcfwYEaQQVz2xIWkV2QJs765V1VyFkfiXw/BjSIsEZGx+Kzgu
 ydMKBfGgh+KP3zafj5wu7ygJAji/bTsABqMyTBzIBBA/LYmXG23BbYbYcs/Nweo=
X-Google-Smtp-Source: AGHT+IGiTJT9x2U8Hcyn95hUme9j/2Uvosw8QjwWGLrqhq/JL+XYxH92nK6euvCavwE43gYg385o5A==
X-Received: by 2002:a05:651c:553:b0:2e2:12d1:bd6f with SMTP id
 q19-20020a05651c055300b002e212d1bd6fmr8181066ljp.46.1715034830749; 
 Mon, 06 May 2024 15:33:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a05600c355000b0041b61504565sm17609419wmq.28.2024.05.06.15.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 15:33:50 -0700 (PDT)
Message-ID: <3b612068-e407-4e3d-b344-6623268f262f@linaro.org>
Date: Tue, 7 May 2024 00:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/57] target/arm: Split out gengvec64.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506010403.6204-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 6/5/24 03:03, Richard Henderson wrote:
> Split some routines out of translate-a64.c and translate-sve.c
> that are used by both.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.h |   4 +
>   target/arm/tcg/gengvec64.c     | 190 +++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c |  26 -----
>   target/arm/tcg/translate-sve.c | 145 +------------------------
>   target/arm/tcg/meson.build     |   1 +
>   5 files changed, 197 insertions(+), 169 deletions(-)
>   create mode 100644 target/arm/tcg/gengvec64.c

Reviewed using git-diff --color-moved=dimmed-zebra

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


