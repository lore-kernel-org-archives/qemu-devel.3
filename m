Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD22DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sSt-00040B-Iq; Fri, 03 May 2024 08:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2sSr-0003zd-RT
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:56:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2sSp-0007FC-Mx
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:56:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so11490645e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714740994; x=1715345794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxaYcWb+xBzcc9VX7AuLafdW78gfD1N26Mu9ghbppO4=;
 b=cEEuEprw8zDr2cAWeXQmatk853HdQ0vfQ6QMkIVoVXVn4rcG87xTFq5QW/PDlTu3L1
 vHOXT8iB4iplujTHs+dWvJkpaN9KRm7mXh5Vcm3GZvOm+tRv3lTf3YjbaF0rY3IUiWMe
 GQihV31mhvxcJ7YKzeyZFN9C4nvbmjhJWOCFrfvljptIJ43xeXGeRPNsfmhC0zFEf9Zn
 S5ZkDOQgTxOAdJCuoex8OF3tiMxOxXZ92Z6T+Pla2XBT1Ww7pRmf5iFcpkmOEdlLEKmF
 2K69bXrj7pn06O/bEVIGTS2gcbBRwta5in+TgMhygC0opCAvkkg5Qac1vkCcELLbjkjg
 YsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740994; x=1715345794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lxaYcWb+xBzcc9VX7AuLafdW78gfD1N26Mu9ghbppO4=;
 b=cD7Q+B7ck80H7vSxI1gHm21Q2UUyYAlHNUh28PCVvcgo2rNxJ0GcBAGvKZPjZCwYeD
 hPdfvcKjRWAyBENSl1gHigTTr/xgmQVx/P/mhNJsk2znnKFeSliqsFSTcf9gpQcV8vvX
 Nv3PFqRgww1FvONdlA0e6UuNzk4g3CJg2CB0e7PAaMEYMW6E/ZVfPc1ZuBC0heoIf68N
 MTZCTpQu9H+7DXIuX/peIcMpVxLayjLSNI64EaM4kZJ/ipnMo9ItRZkA84kjXpC/z3ww
 MKagiX7MimuPCcNw0lEBThmi++KGBeH+GBD5dttTGRRqUN8PiYTcXTGRGHIfF9CzG4c5
 jgVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/mR62rtZnzRc7k0kvhsonUAIiKnmoyJ13UJt5lO6YhrBbyl57SI0HzSW4k3IeOQDDf/mLcnNFfgUQ1Rve8jVilrsxx8=
X-Gm-Message-State: AOJu0YwXYiYJ9CM8K1upijdfMEuquP7iKeGRHbGpedzNBW8PvqCbnrBw
 o05HqusbfGAx/10ESTsPYBxFTArd4xnX4rBD2BbzxlBXmxbuGw+90htMavZSFL0=
X-Google-Smtp-Source: AGHT+IGjgkuM2400IXhyb4mZtHljeXHcKMz8kCvkPdJYwdp7Pvy2eyt9MCWdXupNK/EdbAWDhW7qDw==
X-Received: by 2002:adf:a309:0:b0:343:cee1:cbc1 with SMTP id
 c9-20020adfa309000000b00343cee1cbc1mr4981739wrb.14.1714740993871; 
 Fri, 03 May 2024 05:56:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 m3-20020adffa03000000b0034db974d7a1sm3705170wrr.81.2024.05.03.05.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 05:56:33 -0700 (PDT)
Message-ID: <41d1f49a-5a2d-496e-859c-341b1abc1aa8@linaro.org>
Date: Fri, 3 May 2024 14:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/cocoa.m: Drop old macOS-10.12-and-earlier compat ifdefs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240502142904.62644-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502142904.62644-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 2/5/24 16:29, Peter Maydell wrote:
> We only support the most recent two versions of macOS (currently
> macOS 13 Ventura and macOS 14 Sonoma), and our ui/cocoa.m code
> already assumes at least macOS 12 Monterey or better, because it uses
> NSScreen safeAreaInsets, which is 12.0-or-newer.
> 
> Remove the ifdefs that were providing backwards compatibility for
> building on 10.12 and earlier versions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   ui/cocoa.m | 13 -------------
>   1 file changed, 13 deletions(-)

Thanks, patch queued.

