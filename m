Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABD8C54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu5l-0007uO-2S; Wed, 21 Feb 2024 16:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcu5c-0007ZV-Ps
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:25:19 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcu5a-00031l-MY
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:25:15 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso856594a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550713; x=1709155513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8rTpqcFY6RIbKXI6WMmNyepei8T7VjsWXfq+i09mnA=;
 b=nh6PZyH/2U+g9vsU8GTYpLd3SNyW3tuRkgaO/F4A9ImjjLF9iB5XaDuIGpm+6cCC/n
 Wvh8KRFF5Mq+CLin8p5kBszFlSYY3gT3YMG4AYfrrqf/RFCjHAe6EKB3CXMFoSqM29hX
 c1jbK4HkF9319POQi4UlxReo0iUiHLiv8OTWDWMVMC971dxS1EuocFdwL1XsCdZcEBWP
 ryDbyYsoWH2s+uDUJA6CrsP5qsRuxyYP1QqZh/rDRnBV/iyyuE3TBUcqcwqh+oIaZkck
 GiSDQv5ponftpdRyH3dullkF45+vgKMPjtsvirykGVR7pwwIdk8waW16CeW4U7E0NxKt
 UCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550713; x=1709155513;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8rTpqcFY6RIbKXI6WMmNyepei8T7VjsWXfq+i09mnA=;
 b=uKFh0RNafQE6hbcEyz6PAafPUYaO+sVH7sSRoQRQUVU7un8kvWyCoPDlOyKZZqVlV/
 ngMLe43gX5MUjfbyHO35Hb4ic0jhxowC6r1HJPv9cLKfbJaXVK7mIycapV1jJlJ7dNCB
 C5JR1I4EA2hgkiLrXBtAK8fMerHbuQEs3KgcZDPdP3Xg/Y11kqjRg6l2hJqpc4kx5vjJ
 4opcJTPbR8CS2vYW7bq8u0wduZtTdwpPztG+tV0Im/ebSwQdQ1Qra8oGDaqYjjiskwcX
 QY0GHqQdxVfh42I5N5N0VH+5MLD64rNumUK20RG1pSNHcCXet7vJJUzIlHs2lL38nOke
 WWnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtFJOpwBumiwVrCWBt2RMQj0p+AtH7ODk2MucFm2PWOWGUqm87YcKqtdYyBY4mV/70FnT29/YEFWT09tS/H+9OYtnn19o=
X-Gm-Message-State: AOJu0YyYCUssbKWObyYpuxxEfc1qMHf2ESCT5dellvBNFStDRBxPwLFo
 44x+miKq3kecXx+LLXg8VA227cFpbp7AIfJ/a2F6OpFzfc+PdXbANiqxKR64vHg=
X-Google-Smtp-Source: AGHT+IEw9XuilwyEf7JcruSDIdaFc1VcfRwpGAF32MydgV0YuGbNNQ05iUBoyfL9V6DAmluL8wPKoA==
X-Received: by 2002:a05:6a21:2d06:b0:19e:67b0:9ac6 with SMTP id
 tw6-20020a056a212d0600b0019e67b09ac6mr28379760pzb.1.1708550713369; 
 Wed, 21 Feb 2024 13:25:13 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y4-20020a056a00190400b006e1463c18f8sm9369983pfi.37.2024.02.21.13.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 13:25:12 -0800 (PST)
Message-ID: <a4c733be-450b-4d28-b869-fd80630f3ecb@linaro.org>
Date: Wed, 21 Feb 2024 11:25:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/22] target/arm: Add support for NMI event state
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-8-ruanjinjie@huawei.com>
 <c02228ea-4f24-46f9-b6b3-34cba3059d69@linaro.org>
In-Reply-To: <c02228ea-4f24-46f9-b6b3-34cba3059d69@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 2/21/24 10:10, Richard Henderson wrote:
> On 2/21/24 03:08, Jinjie Ruan via wrote:
>> The NMI exception state include whether the interrupt with super priority
>> is IRQ or FIQ, so add a nmi_is_irq flag in CPUARMState to distinguish it.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   target/arm/cpu.h    | 2 ++
>>   target/arm/helper.c | 9 +++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 5257343bcb..051e589e19 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -603,6 +603,8 @@ typedef struct CPUArchState {
>>       /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
>>       uint32_t irq_line_state;
>> +    bool nmi_is_irq;
> 
> Why would you need to add this to CPUARMState?
> This has the appearance of requiring only a local variable.
> But it is hard to tell since you do not set it within this patch at all.

According to Arm GIC section 4.6.3 Interrupt superpriority, NMI is always IRQ, never FIQ, 
so this is never required.


r~


