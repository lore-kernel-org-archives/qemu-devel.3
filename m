Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142A6C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19Fk-0007TR-Pl; Sun, 28 Apr 2024 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Fj-0007St-91
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:27:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Fh-0001VL-PO
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:27:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ecf05fd12fso3356655b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328871; x=1714933671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UT9jNB/eNsnN4OorQiiZpwg/j4KgEyfmahjMxbpP32E=;
 b=zQlesNdyrA05J7DRtITeim5id377926pkL+oJA5QNaHeOAt/eIMS2wOrE82s/52q5S
 k1PWqSH5v9pYval7hmSPOsZt84XvX800Vn/ppUnaYHXtjI/xIjzjXIk/beU0AnpKGbBb
 4XQbyDo73niIkaRRnjM0IbpOvtAB+fbnf7p19E1agAVUOz/7xVvNFkAMshRZ0o0bdS9b
 vIzCaSzaGWH+kgcFg8Ing7xMT3TuKDnuE7igx3jIL2B8np+qelO+jjqfj+C4xKTOCPGv
 oe3M/wu5Pt0jQB+PUai3LwROM4N0i6bUSTVJGLZZrFsO0hzW2WEvuU9Su2kHnMYx7nRb
 7kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328871; x=1714933671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UT9jNB/eNsnN4OorQiiZpwg/j4KgEyfmahjMxbpP32E=;
 b=S2E0sFWkDPXVc4tBF5gdPcXIQZp1cBCCi8hyHmshRWGfvXIYoHmJ6YY3dGkmLmr9KK
 eQ9I6haUEKCdy2YNqhFiUYYZv2LR07lbL7GLwO3TsjF1a8f6TFhNxUxiii55rddJqDzL
 KLnvvzVFC3I+b/AXiEubnXzQnAvc4gyXQ3RLLa9JORRoGbzkYezbvlmJPLmAGIDdn7Xd
 JjYXtCLq68SkiSAX0xf2WhoQax5ukNdG3b1h3fmOElyCOe4RAD/oRciJcEMB5VVuKNKr
 M8AUsUfrd1IMD82lw9nTmnB7iDwZFutTIMmlzIYB6KXZ8SFNJFCkKHkd+ICtSmsuZ2oi
 KV6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULIvRDJWr2c7dtMoLLM4P9oMUthvklnigKtD5vGXt70W9zXZV9wap67az0024ekdB9wpYEBp8vjYDF7qQsgimqLwXkjdg=
X-Gm-Message-State: AOJu0Ywes39p+rVv1grarp4pVdyTqQsjAMn6fzYhOXKVt1Cr7F15uh0e
 9EdloXmPc2Y/5rvyr4rfvmUHjLQit9BGu79EIMZyDNShyk397ATakPWCt7mfTA0=
X-Google-Smtp-Source: AGHT+IHnK9i+uryTIMG7ngT9Z68OYYdRbM9mQOjrV28Zx2VkJGcmHxBWMAycLkg4dprVkL2jL8VZ+A==
X-Received: by 2002:a05:6a00:6010:b0:6f3:e9bd:62cb with SMTP id
 fo16-20020a056a00601000b006f3e9bd62cbmr5405175pfb.23.1714328871260; 
 Sun, 28 Apr 2024 11:27:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v22-20020aa78516000000b006f03a06314esm17887609pfn.195.2024.04.28.11.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:27:50 -0700 (PDT)
Message-ID: <d5918b43-abbc-46ad-92de-87eff7e646ff@linaro.org>
Date: Sun, 28 Apr 2024 11:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] exec/cpu: Indent TARGET_PAGE_foo definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
> The TARGET_PAGE_foo definitions are defined with multiple
> level of #ifdef'ry. Indent it a bit for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

