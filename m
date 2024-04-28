Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B536C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19GB-0007ly-DP; Sun, 28 Apr 2024 14:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19GA-0007lV-D2
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:28:22 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19G8-0001Wo-UZ
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:28:22 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a87bd53dc3so3080697a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328899; x=1714933699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JG5sCKYHg40gbwgymU5TF7Yw66QGynKLnt7miV2vJ8g=;
 b=TCGtxwyJYsITs3QQz/hPMesg5eTydDn1JRnxJdVVQ3U4d9QGe8Fv2UCAU7islAhEei
 WcyhYvqEnmVQlxLcOrHg8iTv8kVgLrSJChLG9yPynthxRt1gGwyTc+Ig3vNcP7yuymtS
 dmZpnapviK0XXtAaqoBcOCfarXRZxliFJbduZdOj6/iclp0CzXLWGr+pZfVUpBaB0b61
 /smSsnFwV8W9Ovor/+V4WgXKTGDN7lOARSMELNvVO+tZIRDB+R5K+sUFZ0ZoNtC8mgdE
 HmrGxdge+wcqczSNd65uwPnldIqBEPNNfEDF60Seco5BCanpka/EgJE4kuv+H4hFu52x
 ZTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328899; x=1714933699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JG5sCKYHg40gbwgymU5TF7Yw66QGynKLnt7miV2vJ8g=;
 b=q1Ckl0D7THTRhYDwDKlSYOUFTbVZVnCHy4fh6DeRtjVcKDT7QW2ckPApqFlHv92r3q
 Y0wpvlGfhnE5pIGIBvGifNZYL1+aJYnnCdExPKiZl+vWLvdEfxwS8fC0je35pYCmLVGP
 BRdFpQsj7nwt+m9jAwRG20gXInacYXck2XP5mStS2sQmOWUtP3v/F4j1WBcXX+HW1ne1
 w4puspr2blMyAam+iELh8RRn6RrZV3I5ajtT/t/GuQ+VHEkaEJPyKC+AQo06zXdjaO1I
 aGKAKJdo/YZcjewxZzf2quK0UWdfXvEt90ouN4YnZFo3WZXKsuysXv7n1r5ynxJulcUz
 4mRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1JCSf4ta/Kfen2kVCxBUUOfg3LVhlkHEXTOlWTDhOs5HyKdmtsL+HwCoas5DCJhmE5+2txbcandVMTnV5SWDtxqPpjXE=
X-Gm-Message-State: AOJu0YwDYZ2YxZp8SMGVfty9emNfAAbLq5Qz0k4U1FCuCM/xmXqEeNpF
 rPOS4aWvLTXfHrKocRGnlge2WEhmVk1Zk302IkLwXSaOyjhF8/jv5JO5eLx3FsM=
X-Google-Smtp-Source: AGHT+IEjem0KVaLuJ9kf8OuoD65P1+EADXv6oz8Kz2aWwXD9dXpuk4rmo91UCtL2q3cVStaUumySLQ==
X-Received: by 2002:a17:90b:2349:b0:2a3:be59:e969 with SMTP id
 ms9-20020a17090b234900b002a3be59e969mr7285883pjb.47.1714328899436; 
 Sun, 28 Apr 2024 11:28:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 db13-20020a17090ad64d00b002b0e8d4c426sm2637598pjb.11.2024.04.28.11.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:28:19 -0700 (PDT)
Message-ID: <dd83ee09-ebce-44f0-b1a4-a510a9db0656@linaro.org>
Date: Sun, 28 Apr 2024 11:28:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] exec/cpu: Remove obsolete PAGE_RESERVED definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
> We stopped using the PAGE_RESERVED definition in commit
> 50d25c8aec ("accel/tcg: Drop PAGE_RESERVED for CONFIG_BSD").
> This completes commit 2e9a5713f0 ("Remove PAGE_RESERVED").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

