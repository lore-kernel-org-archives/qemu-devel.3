Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1BEC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnL4T-0001SD-3u; Wed, 26 Feb 2025 12:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnL4M-0001KU-3i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:19:42 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnL4J-0007jQ-PI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:19:37 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-471f9d11176so446621cf.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740590374; x=1741195174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G2o4KeiRue3272yfTehS/59McCHgrlJBh20j4BB/08w=;
 b=pllZjmBch3QWxD8JkYjepKHu97MyJreNxin6NbvqBb4YNELxE2752V8Cvzm50SWcWR
 8hIF3/3UdQATFzyZ9cBzRW7VYT9jQWRfUwOjXisBi58x1OzpMBIPF5LZ+i7FgoqDW/Ww
 NOjwHT1If88aPvueOW7nxJVWS5yQedFswM1Q8WWZWscPH28x/cWh/cJyI0yOjUerr2ZB
 Y7UaEArQ9J/+TgwmPH870fpJRWtYIk6T8hobWQl3KMA85rEPHyf+YOse/Y//qnAijZmU
 b7zH2472WNkfvcdP5sBqL/K7VK3dkDYhfFn4mF5iSAJHtISgbwTPcgLLhovkgPX1Gd9C
 gCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590374; x=1741195174;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2o4KeiRue3272yfTehS/59McCHgrlJBh20j4BB/08w=;
 b=lr8UIT5Wb2LVA9tRkRDYETUXFgHW/odKPoVfl4SmznFqoqkP0nLIF/Xa3sEFPSEQYU
 XIkFHMrRukM1ZBFAQjIrqhsOqSU7P28JaKEJRq/dXBLAlZutzo41dSSpSyjyI0BAcdhV
 fSs5nFg1tzuL1fajYHFiW/86edA+JNuX4A3tKbdvJeTDHVtyOzCBimW9Wv6w3E+JfDIK
 FJ81TPaSq3AFt1Zc5DpB9t0Vthpxr2JlXPB26FryNooDt9qJaGYhsDb0T4zEuan/m7Xo
 rUm2Rii8oX+gtgbokIMar21KqqmwSOgdPF2oMfXvr4Z9HCoGD2JolsDwAzZJbH/1hSks
 VWww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuvCwvF8OES1prASfeRZa9EyaLcrYYWDgWsJPddxIMmpIRyDHOV9kJfDwvv8IDB88ukybEGlpFnCpV@nongnu.org
X-Gm-Message-State: AOJu0Ywl42rxR3OC6hHaqpGAR3S+X1mY0515AkyoTiZ2DMy5uJIW8atc
 bz8YxUtiURVd5dWQEEutoVsOZe8ai9KJ00ZXYt5wFE0GiOmjqrmQrM6Gjc2yuYvFq4gmJzWyeEj
 O
X-Gm-Gg: ASbGncvC2VfqVXDBvFdhhVj6nBq+xrd/TjOoE3xmH4OEzzpz0R/KOielyXHNfXPTWDn
 sHhegtbCPgbPeLfi2ktoym12U+HfUmDDLC56ygHjO/qsujxfPjACHB6WPoH5xRRUv9adVgd/sBg
 ROB5IIN9A29iVnA3yGHwZOIuacUmATrF3fnSTK42x4DJj4vp4FZEWEyNr+lLxrNizYR7A/vay2l
 UYqkJedeDFEAubbcfHgJr7ph6awJfxJnw2JDYwV7mKd+YAIgZq44PrNomoaeZpdfryZ9PmVo8Ym
 Aw068KcIHvdEVrrchu6HJgPzrQj/yX8FYDhwb08HoQTgNU+x
X-Google-Smtp-Source: AGHT+IF7rhlVikVTaXJJYshG3FEArOtpRDYJi8b2ZQz1actjSqq2o80w0Z+53R3EFH6UYynK/wvhZw==
X-Received: by 2002:a05:622a:6201:b0:472:13f8:a974 with SMTP id
 d75a77b69052e-472248f4723mr301105801cf.41.1740590374373; 
 Wed, 26 Feb 2025 09:19:34 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47377e238d9sm27255651cf.46.2025.02.26.09.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:19:34 -0800 (PST)
Message-ID: <f1e231b7-3d91-4efa-a2d9-32e731481c90@linaro.org>
Date: Wed, 26 Feb 2025 09:19:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] tests/functional: move aarch64 GPU test into own
 file
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250226140343.3907080-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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

On 2/26/25 06:03, Alex Bennée wrote:
>     'aarch64_virt' : 720,
> +  'aarch64_virt_gpu' : 720,

Does the split mean that we can reduce the timeout?


r~

