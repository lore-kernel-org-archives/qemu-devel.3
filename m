Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B99C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZH3T-0007dg-8n; Wed, 31 Jul 2024 17:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZH3R-0007d7-Iq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:40:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZH3P-0007dC-QT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:40:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so684745e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722462014; x=1723066814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kVazgtmrr6vvZNnwSjif5VlpnOgs2LS/XWQyP1udH5U=;
 b=u6a5fiBZsJTipvNO2y/ejksvT7pet6SVQygtH/uKSnh2DEr3YvLRUJbZLc1D0aAxoL
 wZvkqyJwIQfWkj9BUyOlzgX9yO78CGC3vY6kCuCdTbPtwSpaegnhYQyiPzIO7rstE3Do
 xGbV3/ntqEpQoUZCYyOejZiDlUl+7YebkjYPWZrpwUrZbh+Dfao9zlfqiYYxao7sqzxG
 8AhiYMshPyxee9RCqYwqOtw/tIxj9yaoKWQ6z8vCuYDsXB5ZWQYhh9QXJvtgaGhOZr1z
 H9nCm2uA9gEMMc2Of04Yd8Lr2I0CAf/1ktacH8V1zH9Z3Tfl/+PMW4tzWiQCBexo9bUS
 3z6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722462014; x=1723066814;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kVazgtmrr6vvZNnwSjif5VlpnOgs2LS/XWQyP1udH5U=;
 b=byCFM3VwVlEkNI0mYOeO+FBV2n2LPvegSbddaBjNBELfDY3kBt41kt3Rsu0U2hNqwG
 qGTEd9FSU/OrlewI2uFeYV3yr/EBUMhvUzrybADc7+4V5Urcqcc+ZBbqq2oQCXKKWBb8
 nSr2E9PUiEruep7ojHZn6hJsMLm7lCDS8yKVEDa8FeH2gslEe4lUuhHRXARQnLtPcq3P
 d4Vg8SUb5gejfYW/h2uJagAYZ2p1TzAgX0w5Gg9rFUEGsnqG9pKy1r1VQPQIJgd9/TXz
 xzDGGS2SXdORaw6WDrTuPCT0qDNvghOKlX5q7g59tFrDYzhUsj3vWguxMn6Hj4vqQHeM
 2doQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPgKhxZH2GHsZDvXYK8OrppUFwcqznToM4RpvHSifn5C7HDLzUI+1dF7HpPYIpszaX7iQCiQQgb/yMqM40WkFl8MoPiSY=
X-Gm-Message-State: AOJu0YwZykLlP35uEg30N9ZP6rL3x4/53EzNcM9tMaUSL/XK/YDXCyUM
 TAIGQPZ/9QCOQiaWb9kNeYwK4m0MyJbbf2d0jDaPPHXy2EM2DFrb46Xnaj4FwyQ=
X-Google-Smtp-Source: AGHT+IExQnbVBEBJpQ/rIjj60oQ53+c5xKQT66fyZdFbKuihGO5ISyWrpezMT67hg44W+n4LPMayEQ==
X-Received: by 2002:adf:f4c5:0:b0:367:99fd:d7bb with SMTP id
 ffacd0b85a97d-36baaf966aemr295079f8f.63.1722462014043; 
 Wed, 31 Jul 2024 14:40:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36858179sm18021531f8f.88.2024.07.31.14.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:40:13 -0700 (PDT)
Message-ID: <a1505c17-2e88-4aab-86ca-49e972b20031@linaro.org>
Date: Wed, 31 Jul 2024 23:40:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add my hexagon git tree
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: quic_mathbern@quicinc.com, sidneym@quicinc.com, quic_mliebel@quicinc.com, 
 ltaylorsimpson@gmail.com
References: <20240731203910.2570047-1-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731203910.2570047-1-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 31/7/24 22:39, Brian Cain wrote:
> Add my git tree for hexagon.  Note that the branch is "hex-next" and not
> "hex.next" as had been used previously.  But I'll keep the "hex.next" branch
> in sync with "hex-next" until this commit lands to avoid confusion.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



