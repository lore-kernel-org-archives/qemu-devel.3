Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFEED339B2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 18:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRahC-0001nK-Oc; Fri, 05 Dec 2025 13:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRah8-0001ks-A2
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:38:19 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRah6-00013Y-IH
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 13:38:18 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8b1f2fbaed7so226467985a.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 10:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764959895; x=1765564695; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxRHYjo+gJDVdO2gBN9rTUg+eIPtWXMtupAQ9r/pIgc=;
 b=fE3hch05QdVxUuIBtKKFD7H4XP7AgYWYED++Tsg8c0RabOllpXSJcsM7yCsfFURxT7
 A0GoxoaGG212dL8d1I0vdUXMc2mT8AO+TeEEX8oc9m2fXg9HGXHRY6yctB5jU4ysly+q
 6NjvLzDHxbNHyVrI8zqCY1eP0FUUqQHQeaehBHtASCXFxL2A0/ryzl7/KG1kVIbW7b1p
 6a2GqLPj6rZB8mUT+cepFt8NzvpC6lHgwz56B7Z9iR3ZbIUHbW+mPMPl+A10wSOoEUSK
 ccunqQpvtsYWnMXZR6uKyd/2LnYHsFWHXfgQSbimqOqSLeVT6+zQPKIhW3SZ3ORqkj4n
 Ga1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764959895; x=1765564695;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxRHYjo+gJDVdO2gBN9rTUg+eIPtWXMtupAQ9r/pIgc=;
 b=xGLbu2hoBJ5PRb9YF29IHwUna0548uSw9kVzP8jv8g6M8kVDtsI7GwlZQa2fsR/RCU
 yV80mUdFXD1UB+O0y/dJFp81P3ZB+CcxiFqZpVql8lAdxrIHiE4kvl4K8eOeychJJphh
 Tc+kYs3xrh+WId0X4YwjtM8UJiX0/6IHoa32/W/QLBFzk3PXfWNtQeVsaRP/kSWOazDT
 vWyrXwSq8TcXtkeYtpRWGfKcNErGF1NcaAuXzqttvPqr3hCGTnCd1bQ7m67JnqX1OUg4
 gh/Hm2Y/HRaEYUGKxCXNgiT3X59VK/EKutkGqcY2lslhCv/fu+xjWH0TxX41PSAY+y33
 Ik2A==
X-Gm-Message-State: AOJu0YzUodD0Jnrl7+4QI+FC33erdncWyWc8XAZTnrprfb1az+qPDG9I
 /UQGy0C2bTFpaseHalusFql3ZVwU3rB5murWBffOC56ytZAp4GUBxJLnMlFPz7MuMCBhtd+MWcs
 ceiTVnzo=
X-Gm-Gg: ASbGnctmIftFWGH3Lb3PXmkoi/gGFQOwtTRinmldGB3D229qZ92vdaGobIOIDPHFJ6/
 xGh51yhjdRpGkiXy/49yRySsv3I5IU19cETGnd7+GUIOC8KVH3XMdrk+vvZDAgQtV9EtSPw++L/
 2jkqCrbDdjz59x/sxhxWmHMABAJgt1BSNu8K/TwKnUBmK77XiiBOFJDbXpChfvOzkYQ+Mr9Q+uq
 fHYvJakaSVA6/ydT1Atr9zbSsT9zMxl8XcPcxgCL50APZVCh8ngJjUvBLSq+C4XNxUiEtook3l+
 wZnGFvkvYCZRIuZaJlXbGMQrQ1sWraU9h4c0Fc3oP4+RcTlcEXE2RqB09wl+Qjmu3OsO2Q89BdE
 WFk7bQSexaHeR3jomSSJH7txhgGt+yVgA6XnJQsntVG9XecU2/FrF8m/IrXRQW3Baz8lG+2zLDV
 h8ClYth9l4ICGJN1PvUgiOBU9vy5vm4P6WWH7qJaI3Sieh8wJ7YalsLRC4sVUVUotAhzwSNt1eP
 PCP/Sqa6kkcNFcn
X-Google-Smtp-Source: AGHT+IHkfhKHMXJiAhoH7w0HLQWpdEzTUXLI9uqltTlSTeawHu6vw5f0bOEBcW/9lCuWaDj68+Bi7w==
X-Received: by 2002:a05:620a:1a1d:b0:8b5:ccd1:1a0f with SMTP id
 af79cd13be357-8b5e782fe5bmr1574337285a.90.1764959894800; 
 Fri, 05 Dec 2025 10:38:14 -0800 (PST)
Received: from [10.152.62.227] ([172.56.17.137])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b6252caba9sm465752485a.23.2025.12.05.10.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 10:38:14 -0800 (PST)
Message-ID: <c5c07a8a-f979-490b-93b4-4c3a79941b49@linaro.org>
Date: Fri, 5 Dec 2025 12:38:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20251205162007.26405-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x735.google.com
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

On 12/5/25 10:20, Richard Henderson wrote:
> The following changes since commit 864814f71b4cbb2e65bc83a502e63b3cbdd43b0f:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2025-12-04 13:37:46 -0600)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20251205
> 
> for you to fetch changes up to ff633bc5d55a309122d306a83d09a4362de28b65:
> 
>    include/aarch64/host: Fix atomic16_fetch_{and,or} (2025-12-05 07:50:15 -0600)
> 
> ----------------------------------------------------------------
> tcg: fixes for tci
> host: fixes for 128-bit atomics


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

