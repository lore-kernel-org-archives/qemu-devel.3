Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4959EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1V7-0001rz-QM; Mon, 05 May 2025 15:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1V5-0001qn-6z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:29:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1V1-0002iS-W0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:29:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2255003f4c6so50126655ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746473350; x=1747078150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yURQyFKz9afRJKAQgVl7CD65mRk3F+jUNJqazHFq1Y0=;
 b=atWnemMhu39S/sym/umWMMff0AwAE82AuION/TqWnXaLjbfmuZl99iz8Iqt1Hx6aEs
 n2yhfV2p84ZjqT+BFLWroMFpHe0dgoaNxLlf1r8lv7uCrfiVyZEwhiT1AbCymjxYcaeR
 Ula6kMULqV5MxfiSxjavSwwt9PMkt+WGPuPklpyULPc4FDR6HLCXUVAhKbg5TFrTD4Zw
 so5hSki0XrG8DjovZJJmbMZQ6lGfYIFoYsTwPQyn+VpL67i5IQoNI8YbSz3AnF4flV69
 iJSWP6YOuN01ZV3/J+ZX6SL4ZQFjAF1W3lNE7kNvgbZaN0TKXuNfa1xdSvdM3lODXbT5
 V8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746473350; x=1747078150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yURQyFKz9afRJKAQgVl7CD65mRk3F+jUNJqazHFq1Y0=;
 b=oCT0eDvF/3NI95NqnBfJQshk824mJVTikiOlNWupbcNMsnMmqfahaunz7Trj0sk3ko
 ZcIKcf1TL6DhmQClpqtTGEyG00M+hfwbn61Q5DcY0wg6quIgUJT6ld9f7+8qINe/V/R8
 3GZ1WJab/VrqNTRUk/fS+Xj/TQpOLDk4kNZpFg2p/pg2XLjhtGt6BW5BgWYOphu2DY2D
 KweoNR89hPB09HjZnro9ykwPr8cgTxcP3LrFCWNxRGsv9li49bJbDjycJlh55IGxACmZ
 RCfY/sGXgUQOKxFiNguzxxgwhapfeIe8ntoDHU2Gasjkk9TwzLsfYJIKvooTBu5AbQt+
 I2Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn2I0FkZ86WaAy0VGeKaCXPtS3dYQMNgYhngVlnRuK7Gf0C+PdfjvpcfhYQiH3eIqRGuVOrHjYL/Ch@nongnu.org
X-Gm-Message-State: AOJu0YzToOhZPtChtX75+V/HggoNxgdPcRAPXRW/+8nBMUCTPqlOYJYK
 rxctVPKZkzifhSLs7GCZ8Cu3OcvbllAoYPSyuGeayucUw/uc1jXTE8pUt9PnSA3yCx0t1ObZNwS
 a/uo=
X-Gm-Gg: ASbGncvAG97SfywTcTh/tVTJyh/Tax0cjyzDuZhRONIgKL1m5irkcExxXbM+7mSJqTM
 oBLe5Aguy+Jm0ea8MKH8qtZww5Z1SeW0Av4FfSXLeKWfJdLTTxlQ88adf9Ne1wY+q2ND1FNeZ5J
 u5KMuruSrQSKDVvTqsFM5VvwDNVZlVDmktIFeZomuw1MaHf43ZSArIqxmW3zM6BlyIqBotG7+Fp
 NkMRLaeDGnmRqXe/Jt6tfoCQqtv8HmrQyfhw2FwmTTuYAI6CT9Li01+pZU1lfl0gWaNlnVsXJBm
 0i9AW9YBHHoI2HH6J0nrcDTn6HRnSAYgIU7bxS3WRUoeVJdME3eEFQ==
X-Google-Smtp-Source: AGHT+IHXcnbWalst4/hE1ZfwwMw+XiyM0HwfWbIZImJe9tYnLocKvZ2N+wRJlZ8k0NpagIhi7EIV1w==
X-Received: by 2002:a17:902:d4c7:b0:223:5c77:7ef1 with SMTP id
 d9443c01a7336-22e102f33afmr235209025ad.21.1746473349941; 
 Mon, 05 May 2025 12:29:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151ebc54sm59439335ad.98.2025.05.05.12.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:29:09 -0700 (PDT)
Message-ID: <afbc803d-204d-4a99-b7ed-18101e6ff909@linaro.org>
Date: Mon, 5 May 2025 12:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 46/48] target/arm/tcg/tlb-insns: compile file twice
 (system, user)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-47-pierrick.bouvier@linaro.org>
 <b381f802-9eb9-40ee-a7de-f3b5c49abfff@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b381f802-9eb9-40ee-a7de-f3b5c49abfff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/5/25 11:49 AM, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> aarch64 specific code is guarded by cpu_isar_feature(aa64*), so it's
>> safe to expose it.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/tlb-insns.c | 7 -------
>>    target/arm/tcg/meson.build | 3 ++-
>>    2 files changed, 2 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> In an ideal world, this would only be included within the system build, since all tlb
> flushing insns are privileged.  However, it would appear helper.c needs more cleanup
> before that could happen.
>

I added the ifndef CONFIG_USER_ONLY around define_tlb_insn_regs(cpu) in 
helper.c, which allows to build this tlb-insns only for system.

> 
> r~


