Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFEDC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmXr-00087D-3p; Tue, 13 May 2025 06:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmXp-00084e-0x
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:07:29 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEmXn-0007sR-C6
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:07:28 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0af41faa5so2994269f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130846; x=1747735646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5vSQjcPExIVnRx8sVx5D2ET1Pw3X75NisVy3+k6Mfg=;
 b=J8A3jBD0IR9idhlUWB+OXX6DDz30Nai32gazgjOnAuobMJAu9hCFEEbD7IMb81F0vE
 TWk5GKyqc0pWKy00kX3/Mhj518kSAetlKTfBB6jpIVVMLmDuJyA1W/fxtxUkystcdLJe
 Urx7P6BRJut1G+z8toNrasWvp/PhlEGXdhIdcv9ue/GaNw58MfPmBFcYd50WPQUxA4Ar
 JM5kL1YbAECCThlK+lLXXRzD9S38AxiK0sA8mre6bQBsrqSKpgGVfU0Wym7inBR4ZlBK
 jdAIyvhu23ur9bPc+r9p5uZV085iZdIZWUGjUvcBhWQEDbIinM+D53YjyHONl+4P797X
 NX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130846; x=1747735646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T5vSQjcPExIVnRx8sVx5D2ET1Pw3X75NisVy3+k6Mfg=;
 b=uiI5rZpZFOglYhtz9PgTxBqdGiICXBarnwz5xfOXdxWXzrtkuFzYKtkwu7iNtioq7w
 NBdNtGeAXRKTj72EpMP47/2W2/QfcEuE4zvX+2erH1CVz+DitVqjO85RoVKXkCFIaB1k
 yA2Qhuf+dWmeAy/np3qT8FvsNNul6qzGivJY5cL4Rn4c5AgD/tRB0hlRouZjCWVX7JgC
 PkI9av8u5y1UFyAfSIj6fiP7c8uU7TIAc1Xl0apHDCcRytzb3fEU1mQr1TXjMK6m0VZQ
 q8aqxVMRy/AG3wVlbmtm33UzrGmynEsZZJfQW5JXIYS8t4eQxN/q1a+scYjeJz4oNsJ+
 7Bmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvNrppKktdBBysadjLxLBhHjUfPOYm+AD7V8JUbEMvht+r41bVejRc1UHkzCd9xOXi1eeBlXr4hl0B@nongnu.org
X-Gm-Message-State: AOJu0Yxl6bjwwjMjgaNYhIY3lc7Nwe02Xaa0x5TVMrQGqnopAMlVuToq
 lTIQq0sxg1fdYQkkziW1dZ9d+DCBU36Edpja7x7F/yc8c1vATOa3DRRnI5PzB9I=
X-Gm-Gg: ASbGncuAlYzwOGwcEC7oSiALLfUtjiz30+mny+fPGERgUa2kSlojUaUwXrOsadKZSEn
 1kaZOWXlPkS0ZESGhk0O3V5uHOwx0C60qZ4xGoPW8HhoOkYIcUwvtj0vVMTcLdMqH2cLUr1M0Y9
 sw7Xnn5EwzsTKhT5GSMuHVB0PiICjIYnefAzB0oH8leWC8SvOlRdAu3tpdXYjKyeTkOOJMiuw+f
 98FUpSG3LB6jyjM/IJB78+BXN/k6VftQkzJbMtgzlDADmAyx4H5LNqWnU25qnFxRaaRvzHR6T91
 UVkhNQ7JQZPtVV6vTG1QahET1XjKbpJQPJyCFbGRjrQoICIe85kD6UMpBHF+zOG6EO5ZEcTTs07
 b2aIS0RZwlPL2OubGqA==
X-Google-Smtp-Source: AGHT+IGR+hSqCpg5XZTqgxaXNn0FphVU6ZKFnDYfOWg97FAe0KPokbedUpX2+fZVdhEHBwHFkB+7zQ==
X-Received: by 2002:adf:a304:0:b0:3a0:bcb0:f69c with SMTP id
 ffacd0b85a97d-3a1f646d9f7mr10195760f8f.3.1747130845709; 
 Tue, 13 May 2025 03:07:25 -0700 (PDT)
Received: from [10.61.1.197] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d2ffsm15808904f8f.66.2025.05.13.03.07.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:07:25 -0700 (PDT)
Message-ID: <4a2fd091-fe87-47ad-a5f9-cd47076cdabf@linaro.org>
Date: Tue, 13 May 2025 11:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 24/48] target/arm/vfp_fpscr: compile file twice (user, 
 system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-25-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250512180502.2395029-25-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 12/5/25 20:04, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


