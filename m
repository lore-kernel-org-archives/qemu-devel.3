Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B01C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxmR-00081s-P5; Tue, 13 Feb 2024 13:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxmP-0007za-G8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:45:17 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxmN-0004w8-C5
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:45:16 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d91397bd22so35957805ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707849914; x=1708454714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gPEGxwpzetP6YAeMwJfMWBW/fTSw1EzuVHcCqq7m4qc=;
 b=dVrrrWFNxBWT+puTz3lRq8ruArc0SSOrl8xZ12ZyX9F7WcQ9QdKTCAGJS8LKF+guzh
 SV96bmKkujLN4V1bpKf2cYupK/sqescz2XnF2jqcRuogY97BYeIRraTPVHvTNwVpQSrq
 ue+Z9xwPuHWSXdCvOq8RuASqEICyqaR0lIJfRGLx6diV0g8VRos5puOTapVbn+Z+jIio
 PA5sC1bXrgLShl85ZIKUwng/NWoAFJF03K64L6gZ7c87dnQMa6XYk+utZtYME9aB21Oy
 ewz7YiaxR3rsa3qxGggrO3/mrhkK6RLsYQTnvg7A2Jvc4vs8m3jMBmfqLCVO0gex/3jV
 hy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707849914; x=1708454714;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPEGxwpzetP6YAeMwJfMWBW/fTSw1EzuVHcCqq7m4qc=;
 b=XB4MViKl8byxkrihqfZLmMo/LjNSGIC7FnYS2mlciDeno1WZFuNWYVAlFMVcpVtc6Y
 K3CxXvTk/novvLlk3tc4LC1BENxLy6raXie7N+iDMF+KC0gZmh2y+MfF2d61L7911pgE
 OYd0UGngv/roe+aALPcNeVc+bMzSwWh0/FFpy9yEUgPHdnTyRLugPwj25nMXFFLE0O5j
 onPTv7fSSABHcov/PDHF23huCi1pZW5kU/uscncGPVhkiWCZU8MYNFUYIgOpJyp7/0XI
 izEUE8PEkaAkS6N5bbjvrrkCrZvYa1GCam1yVAu7AEzArvJcJaGjjP9w0a0iUOOIe66I
 1PqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFWO2UTlbzFCpdqzhq/Fmp3k0VMnY0lDyAk3xn927jKLCmXwRgLiVePZA2XV88Kz9VYsj8uiqkfCp8NstJMNGhDGXY9u4=
X-Gm-Message-State: AOJu0YxnB/w1wKVgOr5TfzhZGQhSy6fJ/nFS9fOLW/IMdSjsuBzh+WQ2
 xUB4TMryjuQ2jDJE+NIbIWRFT9gH44c0m/QVZDtw/WGf5yjUreEICvWjjjgjTKzo5F3RkOTcRHw
 z
X-Google-Smtp-Source: AGHT+IHDI5DhjbcZtLU2jOkvYhch6K4H5Z4x2tjW+ryc46Yw42vPnEu1lg3hjstLpk+41r2FLW/ZGw==
X-Received: by 2002:a17:902:e80d:b0:1d9:7a7a:3d01 with SMTP id
 u13-20020a170902e80d00b001d97a7a3d01mr545981plg.23.1707849913768; 
 Tue, 13 Feb 2024 10:45:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVGM7FoZg3tKsZAFSoc+EK61/opKPxa4GmoHiMnsc4X7ihI+L/ZtdCXPT33wvbHRXFrKOoM190UrrsSjIicJnHm7kuOrHM=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jj19-20020a170903049300b001db5079b705sm233013plb.36.2024.02.13.10.45.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:45:13 -0800 (PST)
Message-ID: <82478511-067c-4472-806f-02273b8b2464@linaro.org>
Date: Tue, 13 Feb 2024 08:45:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] plugins: cleanup codepath for previous inline
 operation
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-18-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/12/24 23:40, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   plugins/plugin.h       |  5 -----
>   accel/tcg/plugin-gen.c | 13 ++++---------
>   plugins/core.c         | 29 ++++-------------------------
>   3 files changed, 8 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

