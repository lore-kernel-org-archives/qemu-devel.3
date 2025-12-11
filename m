Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA7AD41D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThs7-0001Kz-GQ; Thu, 11 Dec 2025 09:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vThs4-0001JQ-PF
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:42:22 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vThs3-0003Ew-C9
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:42:20 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e898ba2a03so113448fac.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 06:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765464137; x=1766068937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKYBNbIw4QqnnyjhIeBT7xpP+NX3m+wO2y9xDygzoZw=;
 b=ShRjs34IMc89ep1Fze7jqqMtrzqPPbIFTK1J3qDWL94K+HQ/NjIuAC3ppNunPDUoj9
 +oFt/aiZllzTPwpPrGzuAquRAJiNBKNg2CUElvMdFWjLpbWNe49ErADGCs3HkD4AS8iQ
 0yIyXFXV7OXBngw8C++rMN0ZlF6g3z8BdUWHc9Heh/Uz7hG1+O47hDA1SF5ObS0l9Ic2
 +s2iiB5JVRojCE/GZgQ1L3Ee4639g0omthY361mBZ54H8i11aCamzrVR74mld2b9NpcF
 jJCYn88J4NzKrHgPp7JWUjOV0/B67OoOwMjdkRK6QjbWrbqvB1Mmh3x9gp3NaK295Wsj
 jlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765464137; x=1766068937;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gKYBNbIw4QqnnyjhIeBT7xpP+NX3m+wO2y9xDygzoZw=;
 b=SPV8zuV7ZkHshFm/AbuIg1HBqH1ETgSD0feF/o6fhX1UV4mlZ7jm9u8fzypioCS8RN
 22dmmEW8K4A302blQraNtkLaDrwn5qYQQaHrYO4iDFj50601CR/gPPhpFjQpGmD/50sC
 EzCCI/f8hTaaTkaOBrQHdKXjlqrZAOBHBOZs+pWUath/WoauPiEQuCaPIOl2mHdL895j
 yYh1FBjPVFAVICn73iwCc48KU8UgexeWZj8Y8OViYXjon5DTe8AetxL9o3DDKXkJDTo4
 7/Z7AX0sNh/YalIhic+CfPQdPIM5VrTDaCW759yvt25YdQiNJVYhSpKqPhtXHpN4nIVv
 KwBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7j6e5mMlre1MPtDdSGdaIUOO0/zhGmie5FBAODCEI1/piLUtuGVUXmgnRm0yv7nZB+SKTfQUkYoiL@nongnu.org
X-Gm-Message-State: AOJu0YxKIaSfQn8R1CttahRO1s1umjfq89ssOWysll4OV3ndKYePjDSX
 z8uyGw9nh9sJyrZUP90FHttLyUsEMUCWTNR6yBpS+HZKpa8MLPRVQsZxcD+Lbg9dqiY=
X-Gm-Gg: AY/fxX7wrqB39XRprGDjBOby1rvvTgdfcI3KLD16xWqSx3Maor8Ti+QtOJV5SDRBTw1
 5exYkPfguQGd2ReuTLD31NXhUVDuyTywWsVxI5ShyI7Qc9ipLp/I/NgXri5Hih6qU9IDU4pkUpG
 EAkoQgQhE0XRdndT8S0PpNCNoOOjiLxNYRVVPwWnx4rkSVssr5IxBpzDSOde8lupoGEvm4nWaX4
 2qco3a1IXoEJMlcYa51alxEb3P+C/jfO4xLSFYYKr9F2FYbDAuSdObR9e29zylaOpM4fBm40ZRF
 QNR38prLq2f97pOm8P5xM+DUOg3K/qB2YxwCFhn3uWq9jS3hI2voSXMNd/VAv0EukrtoKbzgP1m
 6KkjEoCRALOaF2HSblgDnc8qS147eN9puwbgDSCT/CWTV8i8StOi+WNPBMptzGL2jD/IJ4HpILb
 Hk87dzKPBVuFho+zR1MD2R75CpKbJZPlhgJm5CVXOun3AmcYMIWNl05F+dDzkxxQjx
X-Google-Smtp-Source: AGHT+IHxvkpKClCUx8Lz9PtLqRO9PEwRDG2/SrC22bAV+LdkTg+9RNEaRo8deSSfds3T2CtFDH3OXg==
X-Received: by 2002:a05:6870:8a22:b0:3e8:44ec:3416 with SMTP id
 586e51a60fabf-3f5bdae5eccmr3916868fac.46.1765464137420; 
 Thu, 11 Dec 2025 06:42:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d51a0c8csm1822043fac.20.2025.12.11.06.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 06:42:17 -0800 (PST)
Message-ID: <ff6f7656-ac50-4286-9a84-094721ef4d88@linaro.org>
Date: Thu, 11 Dec 2025 08:42:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] target/arm: Allow writes to FNG1, FNG0, A2
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
 <20251210-jmac-asid2-v6-2-d3b3acab98c7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251210-jmac-asid2-v6-2-d3b3acab98c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 12/10/25 08:50, Jim MacArthur wrote:
> This just allows read/write of three feature bits. ASID is still
> ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
> the ASID, will still cause a complete flush of the TLB.
> 
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h |  7 +++++++
>   target/arm/helper.c       | 28 ++++++++++++++++++++++------
>   target/arm/internals.h    |  5 +++++
>   3 files changed, 34 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

