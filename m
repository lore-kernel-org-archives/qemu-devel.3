Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF6FC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5vX-0001tp-KA; Mon, 03 Jun 2024 07:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5vW-0001tT-6p
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:32:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5vH-0001p6-VK
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:32:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35e4d6f7c5cso1727159f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717414337; x=1718019137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zc9dnUNQyUzt2UeUZeAUDqEBBcpVb/Y5MKMH1YkpR4E=;
 b=WsSnhsLpeRVJT5znThSKVi6eKckln3Y8skBag6eVMnUQoKpqIrM4XB89kKq3eMZuOL
 FLQTYYtSle3fxsjwAhNdyPR3q9MFpNi27sNEsRXgTWnhyjITBJmLEtfWGAYR6WDNNZiy
 FLomMZuj5XEWUcJEqhhVV1nPBC5+TepDx+pJth9xt16fPtNhjXSCYJBiuQPijrxwK6PR
 uaOt8U+/8YhtLLLNoC6IVixSv6Jol5Wz6styEElxwbrKV/xJyKySho8dK3/H2lfYOJ5p
 FEq95rW7fmp1erjY82WtBAk30UtBBGw+v6QFdqpFeifJz0wC8qgO4S5yIjXEgGMCmQ7+
 wxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414337; x=1718019137;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zc9dnUNQyUzt2UeUZeAUDqEBBcpVb/Y5MKMH1YkpR4E=;
 b=vc2PxNbZyPjc0pVAtZJCCAP/ifLInSWcadlx8rDmgvNiBLEsP+N31cF9nuEzFue2l5
 jIktVZxvA4MvXKcV87A8XYoAJPrIuQEuAYo9QozRovdxgANKgWdZkFfvLVDO+KronayT
 E1a6IjbgjAQ0yHbFeC8Fo9UqEUrpjvuXZsQsezntgt6vjixgBqTQwPg7qU/PUa7dyFOn
 Crd0z5I9lAM62BE3n72uxR9YleTnIJAvSnZhj+YL8vEcoqBVc/gPuIsSWuEAAH85bGte
 p/qocZ+CUxz91hKzHC0EFNVrh9A9TPzXUA+IkgyqFX7t/pEXzYcpAsMUNEZ5EjfnkbhU
 N2Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzAH4OUJN0WnxSErPxO6HrVro6fDa81/WAa06inr1DxLFA0htyVQtFRlVxtCbRvSRLU+ex5t3s7M2wLVQFSkHmr+6XMU8=
X-Gm-Message-State: AOJu0YzWWVwd1bpfmlxCtIAnqYIroWMIUxLqNlqtxCcmJBMbjSe1A+hX
 iRmdejt1/09pXJUmtEyHCSp3bDhwMrOS3wLjc8XmW3EkvvjQCUXbGO3rMuR1fYE=
X-Google-Smtp-Source: AGHT+IE/YpvUfIOJP5e8RV1C3I7r5Ot4Zty+YzGXVW8+OgUuDk4621Iwh9rhWh0uApX5LDLZgen26w==
X-Received: by 2002:adf:ed43:0:b0:351:d338:d9e9 with SMTP id
 ffacd0b85a97d-35e0f30b2c7mr6556047f8f.48.1717414336741; 
 Mon, 03 Jun 2024 04:32:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04caea8sm8523079f8f.28.2024.06.03.04.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:32:15 -0700 (PDT)
Message-ID: <2e7de177-0bc1-4771-bd90-ee46c6ef2c33@linaro.org>
Date: Mon, 3 Jun 2024 13:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/core: expand on the alignment of CPUState
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530194250.1801701-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/5/24 21:42, Alex Bennée wrote:
> Make the relationship between CPUState, ArchCPU and cpu_env a bit
> clearer in the kdoc comments.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/hw/core/cpu.h | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


