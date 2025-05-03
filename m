Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647D4C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 21:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBKAR-0001ev-EO; Sat, 03 May 2025 17:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBKAQ-0001eJ-7E
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:13:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBKAO-00058R-NW
 for qemu-devel@nongnu.org; Sat, 03 May 2025 17:13:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2295d78b45cso43586045ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746306779; x=1746911579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FxSfhsCEDNJtIfclTFmU04xWQhYR9A6GsTGzarhRRY0=;
 b=zsFaYV/o1Fht4uj0DCRiNxzFlWNTUm7EP3beTUNBUYeC6T6TxwswF7mmd0cLH2+ZHw
 yjjLc/tim/UjimlXDaJVPEmgNOXt+DhbcuM9E2ZDoYaEb6Va3qdGlAnhymf4mrrUw2JY
 ltk4en2ruTM7quJ7pwBgWfUILfZin0sm+6LqulwK0YQOuEVrVp3Dh8qrFjngOFLHQghS
 IEgX/OF/4NYULJP/WIdaVrwIo09jY1DhcicI5dP3VnrjGr1vgkP7n0trE8n6MFtvICAG
 Av7Aapj3v1eczZG4JfabUtLluPS9Myf4EbCNzT90YnKPHBrOmMvJvSDPVQZlOrtkyiRv
 6RyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746306779; x=1746911579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FxSfhsCEDNJtIfclTFmU04xWQhYR9A6GsTGzarhRRY0=;
 b=wj+QmaB4NFBpejxDx0WwX5EtNe0WJX/Oiq6O2XIC5KuaP6x4LKqgicDq+uUbbiccVc
 0g8xQsZ0czByqtChYNFC7Ys8Ny6u2Yr67cBRBr8eOb0qirNgrmNVSfw4lvJzt65TFU3P
 myMuiGGJDpFb8gKgw8bjTiDHdExYu4SJjtin4BdmSf/h2/figXv3gu9CNKc4lowz7Trj
 3PiycjbEuxCbZ5q6Km6KGt8IoUH+o2ueyME6Ed/dkbOZanIlMO5uOZNMszsVlokk5shZ
 Owzj4cvSAqb+/lKHyoSaHbjTgOkplSAwKrB/t5Fgx2s+YJS8HKeRNLwzl7MrZ5xAwbjx
 21Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxSfMj5T9Wd8txmBA248I6wdTQ8eIL7KhwnjyDRQDuGX2X4HrF/7zkKRSmDaHwenlgFgW13bd/l42D@nongnu.org
X-Gm-Message-State: AOJu0Yw3v8OWJBCxWugFQE14+TASgXFwiC9fKiFWjN1LzQ/BzJT4IZVp
 m3pnMNseZW/lOk0jhL3CC6IPDtW8FDxe9y5smOHXuArNShhVpR6i/DJEvJgIRh8=
X-Gm-Gg: ASbGncv0MCHB8Bb987SA0FWBPhn2mouUrjf9cNV4uY5FqJDmYx0iwssZer+Rz8vqV+j
 o2EXgsFFp8k9u3y6giIKlhEAGWIArJ7sJqpcT+fvX3bzyr7FgHHfHMWz6nBZZ2YRGxVba37lc9C
 NEnuLpDf7TDHpyJQbmYQjabaOTaUMx8ZvCM7+HzjY39m1WQXpSAzXAu8898tgz6VXcvx1KJDJcE
 eObodbd3ccV+Y38SIIF0FUgWR83SccGvFZ9jYmtVpIcykg/7PgK0xH4QAKqe+fqK+Rjo5OEyqbQ
 M/2KGvWauXclpbcY1wlpSPEryHWGIU42uBFZ3L1pt2MJ6WG5fRQKbA==
X-Google-Smtp-Source: AGHT+IHHbxgpklJE0pRyZPQFcgtWhZTRnAvHKQ0lglf6LsP44nmUvYmM78Y0ePXBX3qPyZfyfd04cw==
X-Received: by 2002:a17:902:e5c7:b0:22c:36d1:7a49 with SMTP id
 d9443c01a7336-22e1eaeff29mr35613615ad.53.1746306778976; 
 Sat, 03 May 2025 14:12:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a225sm3775538b3a.23.2025.05.03.14.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 14:12:58 -0700 (PDT)
Message-ID: <20fd4d83-4026-4cee-9d41-9f0ffb8ac75f@linaro.org>
Date: Sat, 3 May 2025 14:12:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/33] target/arm/cpu: move arm_cpu_kvm_set_irq to kvm.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-7-pierrick.bouvier@linaro.org>
 <e8976a2f-b050-415b-912d-3f2231f20fa8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e8976a2f-b050-415b-912d-3f2231f20fa8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 5/1/25 12:04 PM, Philippe Mathieu-Daudé wrote:
> (why?)
> 

Allow to get rid of CONFIG_KVM in target/arm/cpu.c.

I'll update description with it.

> On 1/5/25 08:23, Pierrick Bouvier wrote:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/kvm_arm.h  |  2 ++
>>    target/arm/cpu.c      | 31 -------------------------------
>>    target/arm/kvm-stub.c |  5 +++++
>>    target/arm/kvm.c      | 29 +++++++++++++++++++++++++++++
>>    4 files changed, 36 insertions(+), 31 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


