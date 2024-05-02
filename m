Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87475C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dFG-0003jy-IC; Thu, 02 May 2024 16:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2dFD-0003j9-O6
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:41:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2dFC-00062f-9e
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:41:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f30f69a958so7300934b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714682487; x=1715287287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGr5QKFKQFwONddBFWKxjfgRAWmjWFd1tP9q1rdl3iQ=;
 b=AiMjgKaf6oK0WEg9pGP1W2KhnSgIrGXkJ2/LMusmuJrxkq8tULPjTHbfQTD4Yw2GH9
 kpcV7l2BdSTqFip4RBawfPz/8jVekgc816vEI6c0kHZhQWrfi9te2Kw0DfyiTJ4byfAu
 6f3ha21sMsTuvkVUNQSKMUBNT26KMDHJDozMAtubW5+xBKWIY4H8nL9BZbbFAMjwrmll
 FtAnybH6OiiHexvB9rWahyZdz0N4HN0Mcmhcx+3EcNHCKlwmhkSY2J+1SpnaHed+QfTg
 qlk6ThP8mGFAqF8O+nBtk93inOUb5JwABJix8BxJyV4fPtVOVlwZCQ1Jv/iFMRqCwjB2
 725A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714682487; x=1715287287;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGr5QKFKQFwONddBFWKxjfgRAWmjWFd1tP9q1rdl3iQ=;
 b=eaZuXA77taYQW30eYwDiM/T7bSpxS+cTEYQpYNih2yawpIbErmZamoqepngKl6RkqD
 BjmwHnwanJa1ZDKGjWUCkl8U184sUFCOCBQfofzQcGGqCuAe8m+3d1L9bXkDEURaL0wf
 0r6vXjXZnHP6l6l4DKnS8f9YC++kL4dA4Dy0angsEC7cP4OB662OEKw/ZseMV9IYo/vv
 bAYMjMZajnaCHoiKQThnLAEFnecOId+n55odqtYNsZUCOZFnrcM99jfo4Pu9z4qnvXpw
 N6b82DwiVTUrUY+vvC+NoGpJ76tOxCGfGlGd/+bQPvid69gqhWMVrejtUIRzK3ILTWDv
 Z79A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP73adqLpcQwD4+kTFUte9EV5QRKg+a0Ux6795sNprYI75FKYDdK1PSHEGgPAThDO7eQa2yOuxItEUDu8/zPUOdtPCTqk=
X-Gm-Message-State: AOJu0Yz1Pu3gcLKkWSsV1mwXYhF3vkqSQN1YNA2GPgthAMHj47TgzozO
 +ItU55soIv+umMldyr9b+j1yV3EoTrZOwXaYnHXBcTYkSh3GjwdBO0WKwnCTTOc=
X-Google-Smtp-Source: AGHT+IEUPPbngYl2q4IhxI7jjEVfqqt9TWQQlxcoXVh89FouW2vACjaxjrr6wfhMczAxQCGMHS2LCw==
X-Received: by 2002:a05:6a00:2287:b0:6e6:970f:a809 with SMTP id
 f7-20020a056a00228700b006e6970fa809mr810459pfe.20.1714682486954; 
 Thu, 02 May 2024 13:41:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 k22-20020aa788d6000000b006edcceffcb0sm1683563pff.161.2024.05.02.13.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 13:41:26 -0700 (PDT)
Message-ID: <2cdaeac2-d57b-4daa-826e-d57d55d5dad0@linaro.org>
Date: Thu, 2 May 2024 13:41:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Re-enable riscv64-debian-cross-container (debian riscv64
 is finally usable again!)
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240502194046.830825-1-mjt@tls.msk.ru>
 <3ce937fb-afb9-4ea2-97ab-b8dc0952e9be@linaro.org>
 <9969663a-0f00-435b-b507-fb6a429cb4db@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9969663a-0f00-435b-b507-fb6a429cb4db@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/2/24 13:08, Michael Tokarev wrote:
> This thing works now with sid/unstable, this is what this patch is about.

It worked when first introduced, then failed, then worked...
Sid is too unstable for our usage as a gating test.


r~

