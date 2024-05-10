Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C52C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Iyx-0007Wc-CH; Fri, 10 May 2024 01:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5Iyv-0007MH-5W
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:39:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5Iyr-0002BE-Ss
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:39:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04f0so8014485e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715319565; x=1715924365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oU08mp71qpZCfWhGYmnJPvEEkYcBkIIzB/mbvqGuOos=;
 b=QXBmWGX7tF+7AzwHs+jyQg0/aHipeTVhqnQiEU/UfN5JgkfxLYzCFtMGN6hBkzZFTS
 sCdp4VMAMcLGzwl++05F/N9YqKDUGWakmvZekhxENttols2XfZU/qEeq13n+XlCW9a8R
 uRWUCbwFmy9Mmsyd8CW9nJCqE4UfgcIGtqK8gERcu4yAdIwqQs7AgNCKwdoy3Ioa4taS
 qTG7yDJt+SqH1uStdmFKW69c7/CA+FDwhI5c28VovBY3H/2pWh/sGMPlYQq8yRTNrD9Q
 F85XlfVdrt5GEnIjURAP4g4GEmdrUjS7+VP7KST7JgptoP8GKPgU6hGCcN2WW7H0QCxL
 audQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715319565; x=1715924365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oU08mp71qpZCfWhGYmnJPvEEkYcBkIIzB/mbvqGuOos=;
 b=DTXNCERGHuK3XCbeYOnYY1qmrdxkvxOdiAs/540zIyZ/gi4JWmwGMiWDoibr9Oi89Q
 m3evTERHINZUPUdcluRYx7NlffNnSRwfGQCnjqQeJUt3yLkoSo5ZXQfndZbAzWk6VJ9P
 uvT0FWXSfIIxOE+gs5FtzicSHJV2oCXH+YH6tTac+aWkIju9FlA54QqPmlkc5FyhFXMB
 e+pRIXu9bS5XlJELQGFPuxBGHTt7L8GX2JUdKEWEOm+E7bRVX2snxgMKHnLq5N9Ka4fQ
 vQLLWFKtKU9R5Xz3WpPtnSrQ82BlPoO0DQzi8GeDi6oC7iWzp1iWwa5kNOQduxp2z96A
 bMaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtA9d7vdw2cgsZOwFX57W60S9js5pP1ETlXK2uOxw+aVX6loplkCCHkTFUWCbfXIhphjUCHk4bR10X2TYzgYRCK0++0/8=
X-Gm-Message-State: AOJu0Yw2PqyPXv/WtMDRBrU9DaSkJG9xIcmazViZyL3pwIHsLRFe1g0S
 e7chG6pdF5YO8RmzPZqbDmWTeTt7FGyJ9x4EP2FQUoDVFj/Oq2SjPUNhb48hjJfat0gNFWdBalz
 AR64=
X-Google-Smtp-Source: AGHT+IHQ/OKurkPkzdTDZIK5rcpPwdWqbpcqBSQHp9HEP8R1dL03FUFmNG5sJudrlGdxuVGfQ8mOww==
X-Received: by 2002:a05:600c:490a:b0:41f:dcdd:5631 with SMTP id
 5b1f17b1804b1-41feaa30cfamr16531215e9.13.1715319565022; 
 Thu, 09 May 2024 22:39:25 -0700 (PDT)
Received: from [192.168.51.227] (56.red-79-159-217.dynamicip.rima-tde.net.
 [79.159.217.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8e2fsm49967795e9.3.2024.05.09.22.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:39:24 -0700 (PDT)
Message-ID: <fcd2b731-77a0-4011-b13a-6eb6af74ab3c@linaro.org>
Date: Fri, 10 May 2024 07:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240509080645.457303-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240509080645.457303-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/9/24 10:06, Song Gao wrote:
> The following changes since commit 4e66a08546a2588a4667766a1edab9caccf24ce3:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu  into staging (2024-05-07 09:26:30 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20240509
> 
> for you to fetch changes up to 5872966db7abaa7f8753541b7a9f242df9752b50:
> 
>    target/loongarch: Put cpucfg operation before CSR register (2024-05-09 15:19:22 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20240509

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


