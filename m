Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48967C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPe7-0007Ph-Dp; Tue, 03 Jun 2025 07:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPdy-0007P8-0F
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:17:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPdw-0004Qt-Ce
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:17:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d54214adso21227695e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748949438; x=1749554238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uv0+OBaccLNib6p2r+P6dso3IFzK/MmXsYEsuNqzPeg=;
 b=rxIC/ef7NmiG1ez31oIUkNt6LynEh/6b6VtpGl131ibK351uxYiv30E7wev2X4R03/
 T2DFDf3EdFKSAFlNJHuT5bqrzDb2ZCVjOrqQBe8UlKVxNDkZTeiMNBohJP9JUyrslCC1
 qfXwsKxSQyVSSwyRsCpm6s5VxTwQ21bcoNPr+4A+9aL632FtGAbDTyjugtRfa+/faYvW
 MU/OuQv/Dh/cq4kp8X52s4Z1UOKT0wnU6i9RJ4GS0v8zVAeiH5s3NyqK5sWngjqiRmGP
 oxtfdUXCvGXmNRgNu7iRPZp0iFBPqwhJxELBJ/CR1hh0wrbfdnRa7VOWh0Yde30uCCAS
 fFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949438; x=1749554238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uv0+OBaccLNib6p2r+P6dso3IFzK/MmXsYEsuNqzPeg=;
 b=FNYveu7cDNK2rl4sSZDv/SvmJQkS0NYGa00XiJr1ESOxq4MSFNShGhNkA0m5xkVhOo
 H6DeYUfGBUHNOQP6dBc0eq2rJD+0dpg8YcqjTAG9Sm9NcH+8rH2uEgNIpGBldgYE8BhN
 gf3ZWGMtQT8vIsio/6swcGnSLds/O1nCSoImUKZS1hpKYoMFjAEfWP35dyhz946l7Zix
 j0Np/MEzhLkit1Ob6NlXj1auT5ZgllhtRqTkt/ULyqIOE9ce4Wv2IIQyRwpb2durKYkS
 KtwVskotqZMoxPoeaRgxMiP+3BNkfStTE0K7FSOH6cRtKShFzH9zeMwR0R9UFaQFRMSZ
 1Rhg==
X-Gm-Message-State: AOJu0Yyo69hkhNKcw/Eky4KjmLfr3zgsxtsShDXqJppmum4brGjMpXvF
 dn9Yq/v+f9oO3HEMm8IfMKK7lC5nfZm4FfjQD0YnuYI+aLifkFqRIeqO5yz/J0uzpFHyRPLWvlm
 LUeAB97c=
X-Gm-Gg: ASbGncuk9hn4gKcMCEPcWswv4vbve7U4X0vsvj1zGIKpvIp1DJ84FA4C7+3UyXw9nBL
 gWcfb4QpM8HBoMTIzGgrxt2K2dgaFc8vWqzjsZaYv55dDUcLpAc9W/ZlT/XzH8RMINUClaMsbN1
 HHDBHQjGncCTP93j7EQ9839mqSQVOd+GQ98LW3is+49eSFCsKW5Z4/1f9qAaJggFdl1tQfdU2Zu
 QlEaLWxxQdLi0ogUNAQlU5XIj04d5zckb04G4STx/SGE2CXoWQRXVXYcQ8wk/q427jugHNd6EFE
 xi+QTMyhNLhFPGA0cxdsrZcBMOi3RhMD0BnGWeLODuVHt+K9eqKpMK6n+AVUDABrRVWN0wBoZFW
 nKH8i16cPfJrK767Zpyd4PoXU
X-Google-Smtp-Source: AGHT+IHLP9o/948TTWl/YpzApz0KT8KHfoR80KK7mWVjriT4l3U28JwstGZv8YalZSexat7xTALGTA==
X-Received: by 2002:a05:6000:1449:b0:3a4:dbdf:7154 with SMTP id
 ffacd0b85a97d-3a4f7ab1311mr14066855f8f.54.1748949438163; 
 Tue, 03 Jun 2025 04:17:18 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73eadsm17696286f8f.41.2025.06.03.04.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:17:17 -0700 (PDT)
Message-ID: <15c88fe2-ce7a-47ff-a20b-14ceee1e9d6b@linaro.org>
Date: Tue, 3 Jun 2025 13:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] semihosting/uaccess: Compile once
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250526095213.14113-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526095213.14113-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

ping?

On 26/5/25 11:52, Philippe Mathieu-Daudé wrote:
> Replace target_ulong -> vaddr/size_t to compile once.
> 
> since v2:
> - fixed build error when TCG enabled (Pierrick)
> since v1:
> - fixed build error when TCG disabled (Pierrick)
> 
> Based-on: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
> 
> Philippe Mathieu-Daudé (2):
>    semihosting/uaccess: Remove uses of target_ulong type
>    semihosting/uaccess: Compile once
> 
>   include/semihosting/uaccess.h | 12 ++++++------
>   semihosting/uaccess.c         | 10 +++++-----
>   semihosting/meson.build       |  5 +----
>   3 files changed, 12 insertions(+), 15 deletions(-)
> 


