Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD62C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDth-0007az-1Z; Tue, 25 Mar 2025 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txDtZ-0007XO-A2
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:41:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txDtX-0005Cm-Ot
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:41:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2241053582dso53005855ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742946078; x=1743550878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XUzJIuxjMbXzAsCAnk5pcQ4QJkVjYTgF9gs+iq/UVE=;
 b=IxJJJDJ1JwDkF6EIwO8NyQA735fLmQdHa6q5xXcvZApsiXmG7+/cViQhVp4OPy1Gk/
 mI/zNHmj5m4Q07fOzDZC25LwNseheFRxV+8889mQzsDsY/m3HB59uePJqGEMB/Ez/ntC
 NIf+5VorirsftHOAXmz/2QXGOzb3+I84BNSAGSDPI8wkRTVBLkF6NXj3F5aBLAENM/qR
 nUYFOYwDzYzvoTg7fWh6uQVq4Y2WbgFX0oLJ6JkvbjLdTLteZI5C0iNLLF0eaCy8dhGf
 XNzObPRIEKk5FvSNflzXg/zS7lnJd6FEYIH+krZdD+ZiH1eYQrqUJCkAC0bKrL3iWK6N
 TPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742946078; x=1743550878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XUzJIuxjMbXzAsCAnk5pcQ4QJkVjYTgF9gs+iq/UVE=;
 b=tCWx43jvWgYYaQBCiRK6WfrWThtbSLxMSgi36Yyg2e+Dp1SQMWIw3s+97KX0mzqtUe
 gL05IoVv8cfUoIyfGTsaLosch9hNY1YmnZ4REFWbT015JVmfaeYbDnFpv27CXxTzQvBc
 7Rvy37AGUI/KcZfOZ1oOJ7DCLuXECOHq2yInh5MvH4+fXRgFwEhdZaTE21ZHaeUyvnRT
 2gLi8o87SgxT/MNEe0bT81MfdKcdKa5zBR2en+ZEmlZ+KsUxomu/uw0rLL0jHS4+JkNo
 68X2ENiemUBiha2SpgIcJlxrGWtbSGEbBYLoZyJSicTIEDqK5/ZnqbmZMu3JtDKOpfJv
 Qxqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE+d4Y1C5vMe/K9UpPALcl5aOivf2s6x3X/zQ02BdtEY8Me8XH/KBmF/lsOOBv7fzJBm2FJueiM+I7@nongnu.org
X-Gm-Message-State: AOJu0YyscDBbEkOFYEI0YhwHtdVw0K088sv9gITZsRAQboto4BkJ+6i2
 os48f/Jm780uXGVIf0lbwm0akz1/b9AB6k8NbwNm2hPC8aXyT+KB6XifBgSbO/PV87IrGXJ+bHJ
 S
X-Gm-Gg: ASbGncuEhr00ZZPHM3jSYrhAREdpk7e1VRK3bdRSl2kcN4zilAP1HafuSvJ6ZO0avR7
 iuA0Rs2T6LEMpfZhITAj3fgexN4FG1DwuJMi4C5OJGERXjfHq6XIdMKKVb+ji8pdszBFDqB3xBr
 i/z2vYsxdMKXiGqu3oG37IGFg87zGMvAW2mRm7CKOzDFSiLg1m9xuksMs/heMfmaBjdbyA6Bdif
 3E1b0LX/jNSHug9rGALGl/PQ91cEWnUV8c6hHbB9hlCorUPvttTrihJdfgHojYqkXcwgApHSBoL
 dkJO7DgoYr9mBOvhu2ObbvH3oWUJ/GmAKwBomLzO72l/IZygRUKytMWk+5v7h1H1dSaWPbEp552
 zCn4VvIgR
X-Google-Smtp-Source: AGHT+IFDjWVzTSWWZjfSOZhezqiRtuh1FFL5UehR9eCT3Vrj63F/u5Hmb8pkZ8kNqSnNlFtZyVKzEQ==
X-Received: by 2002:a17:902:d58b:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-22780c52283mr313737355ad.11.1742946078043; 
 Tue, 25 Mar 2025 16:41:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm97354845ad.59.2025.03.25.16.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 16:41:17 -0700 (PDT)
Message-ID: <c6698ad0-f977-4cce-96c5-434b95a6f2b3@linaro.org>
Date: Tue, 25 Mar 2025 16:41:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] target/avr: Remove NUMBER_OF_IO_REGISTERS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-6-richard.henderson@linaro.org>
 <292760a4-da56-43e4-b542-01631af347ec@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <292760a4-da56-43e4-b542-01631af347ec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/25/25 16:03, Philippe Mathieu-Daudé wrote:
> On 25/3/25 23:43, Richard Henderson wrote:
>> This define isn't used.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/avr/cpu.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>> index 84a8f5cc8c..b49e7a7056 100644
>> --- a/target/avr/cpu.h
>> +++ b/target/avr/cpu.h
>> @@ -44,8 +44,6 @@
>>   /* Number of CPU registers */
>>   #define NUMBER_OF_CPU_REGISTERS 32
>> -/* Number of IO registers accessible by ld/st/in/out */
>> -#define NUMBER_OF_IO_REGISTERS 64
> 
> It looks used until patch #7 of this series which remove
> the uses.

Oops, I must have re-ordered the patches.

r~

