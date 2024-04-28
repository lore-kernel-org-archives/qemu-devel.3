Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F808C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19YC-00075i-SX; Sun, 28 Apr 2024 14:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Y8-00075T-E6
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:46:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Y6-0004Yp-TB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:46:56 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2b12b52fbe0so497358a91.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714330013; x=1714934813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCUkI7ZUbbMeCgLNCkbhFiUlaBnO925CSgfsQILQh+w=;
 b=OLGZXxvNtBW2olbJuhSC3UCwJiZ/4BUj/toCT/i73cdQjgE6+eP20yuQUh+QDBN54X
 1Jm69hJ0Ic/nC7yDNhdpcGNbL9hjcWW26o4CP3pQMqdtI8zvkZzJ7E3qG6+JTnYOAQ7G
 s9qO8WiLmo+RVuLw9JqZ43fJg4uRGdkcraEvx6wOPOHlErjbv2Wk7CLqUZivX3nCQOUl
 y+p46xdy49gnN/9Mhsfd9sFxb/XusXM84qZqLzjBuquI9wRHz0H69H095my1is+2Nb5v
 7ZDNrIDJrHfSRfbdCFXgRHJVEP2FbJFKldhBhIPz917vX5IwDWSwrLXDyiF0bo9cPvhQ
 u0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714330013; x=1714934813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FCUkI7ZUbbMeCgLNCkbhFiUlaBnO925CSgfsQILQh+w=;
 b=t3pnz1enYzSZEmjIDHxR3DBjDQyV8sMpM1f+dzCPJUEm5wVFejekkvp5eh4JVLTo+y
 oakDc99hkjo90ULPMkUYDYcpo3EQ7Sk+c7AWhKglmXXSq7EJqeKJFSKuEcbSh0+OQOgT
 WV9hUMKSOI5oWR1mqmNcMJgByyqj5k+mr0yJ7Dcy5PyRPjsKZTQ1MMELRWgP07o9zCiw
 Ij3U/Il2PhIiEaSdMuXjzzx9rjMabzRnZeiRXsZOEvSDoPlfLnKcKj6FS6/aC8wdqn+6
 iBLex2wfFsKGSF9sVPWtOrHUyvzBIweRReV4fmi+CzzBbedvvbaSGakKufIR6gXOvFGk
 gxKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnFdiWpkfjCIO31jhZmwYjL03WDsqNZZkXLoUookjdqt8BsGcWZz/Cvx9taD0hkdXQyQkNzgJG0wgbEkiMCgsx2NiBno8=
X-Gm-Message-State: AOJu0Yxjb7F2H7DwugmCoAM+Zk3EIqWjyqjGqxLfEZUYPsWwnkUVLTa6
 MLDHXiNbUGV61Oo9wQUmRo6zMEsd0MJjo4Cxs6IierJHz/BeuPkvlSXqznCL+1M=
X-Google-Smtp-Source: AGHT+IGjeQFPpsB2E534jYLx97eYvrL4vXkxBU1GLL7dPIljj17CybgrIjZCohg9tW1suxksihJJ8Q==
X-Received: by 2002:a17:90b:1006:b0:2b1:50:cad4 with SMTP id
 gm6-20020a17090b100600b002b10050cad4mr3581800pjb.1.1714330012964; 
 Sun, 28 Apr 2024 11:46:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a17090ac00400b002a3a154b974sm17755549pjt.55.2024.04.28.11.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:46:52 -0700 (PDT)
Message-ID: <6ce25ae3-f5d9-42e5-a7c7-2ed92ffe06dc@linaro.org>
Date: Sun, 28 Apr 2024 11:46:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] accel/tcg: Reset TCG specific fields in
 tcg_cpu_reset_hold()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> Rather than resetting TCG specific fields in the common
> cpu_common_reset_hold(), do it in tcg_cpu_reset_hold().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 3 +++
>   hw/core/cpu-common.c      | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

