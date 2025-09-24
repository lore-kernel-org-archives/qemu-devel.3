Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB496CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Tea-0008Jf-UF; Wed, 24 Sep 2025 13:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TeZ-0008IO-8B
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:51:43 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TeV-0004PG-VR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:51:42 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so152362a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758736295; x=1759341095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ1zYOZAWEZLMIyPt44ezC8+l9O09YARq98WFp17SXg=;
 b=SmVllo6WDLptMV26NEYfcVdOMTehl80DLxttYW+XKXuX56ItnlSpfOPGt6AYtN3HkC
 tHSM0h9UWKVaKrKYcijcWrQLKU/a/HPycwmIpjiObK53CS9vpq+3M8r8SrNaOY/R4Nmg
 x7cLWVhkwqaYJ6pHO+5hDjFxO4O7qE5qiyCgsVMTdWcklvBWk+F9bqb2gtI7aUk10ifR
 6VL1IPSdtijj9az68v8v1QigcaLeOCspFituWmGZbzs6fZ4C+xbibBWCKoZ5GL54Y7ij
 qlxeP+6q247Zb+MxE+KlpOSlRK+Jk2S0OrUbT7Gys6Zqb6OAZr/j4vI4D3XQEAHMvD9i
 F//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758736295; x=1759341095;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJ1zYOZAWEZLMIyPt44ezC8+l9O09YARq98WFp17SXg=;
 b=t0nJud545R8c3RQS2lHdaKMuubMuwAYBuGWN01Sgkw0AXwdfHaa6OjrpXfN3un52uK
 TlMsaTzuVQRBamxvZCRgbW21Uf4FXfWxbvHCjDjHaIkJWSm2tXg0yOFaqivTaKWWoVuw
 M//PQuw5oEJ1Qm+6R84moEoebBFwbQ1a5d40lUsaJWOmY8P4A+MInraM6Z15JLIG0S8k
 S3mIHmbxAbg0tSTuyVZYPGHZ5upoT18yFs+2wLWzeP7voGjp5HF7oAtrUdJxUhsykG8h
 1mlC8BhF5y4P+6FPa2BLsbO9SsJzgLjpXfXTHU80iZzEx0s4zRTTsz7CE9u0ebBQakqo
 K0Sw==
X-Gm-Message-State: AOJu0YzM2ElqGF3JzKY98FCVvQvsm0ULzMheS+AsVhqEIKliArkbG7UC
 P+5V0xZtWsrgHXXmre09567B9Ohx9PBiON3UoBol1mHrfFNlceMfwh4+8OHlMMG9x6T4qf2EuG9
 tR0ro
X-Gm-Gg: ASbGncuGQLc3kk2BieOp+wWB1p3DSk0Xtbk3ZgPdHkd1cRyvGgcenIv98AQlm3Nwn+L
 /iiWgGpA9MLbaeXC75cziFvxYAHgqiYOKcPWF98++FJsCTv0U8a0Kb5BGwQ9GaoVZLEaowOloaC
 nd/Q/ieV6yJ46ABEP7mfytdtpTL829npcDRzpe3O2fpJ8NMn/jkz/D3T6TZ67QC+MIxv9yMxaAx
 vmtLEoKgX00vFitiMAzE1lX9SvrjndENLHyIlKodANs8Pfe9AZpamRDygJ7aRWfVYA+beJwvv0n
 V/e0XXDH95y8Jl23Cq+/+Qdh53JTY71QCt8V41AIMfg3jBr/jN0CUzFRf0t3BGS8namjbOXsG6S
 Tw1YkJ9lUoIUdZGhmGhaBC2Yd1wypwC25LAr1
X-Google-Smtp-Source: AGHT+IGLmhteh52tmcM6UuVgGvQuxXl4apMfyF6sCsBsWNCeBKze8VFWgw30JafOCHbvYrX0VdprVQ==
X-Received: by 2002:a17:90b:2684:b0:32b:94a2:b0d5 with SMTP id
 98e67ed59e1d1-3342a318acbmr576508a91.37.1758736295188; 
 Wed, 24 Sep 2025 10:51:35 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341be36bdesm3023337a91.24.2025.09.24.10.51.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:51:34 -0700 (PDT)
Message-ID: <b66e966c-dabd-4b48-99c8-9d786bc9f651@linaro.org>
Date: Wed, 24 Sep 2025 10:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/xtensa: Replace CPUXtensa:runstall by
 CPUState:start_powered_off
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250924174045.54241-1-philmd@linaro.org>
 <20250924174045.54241-3-philmd@linaro.org>
 <d9109c47-6452-401f-94a6-784949d5f421@linaro.org>
Content-Language: en-US
In-Reply-To: <d9109c47-6452-401f-94a6-784949d5f421@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 9/24/25 10:50, Richard Henderson wrote:
>> -    cs->halted = env->runstall;
>> +    if (cs->start_powered_off) {
>> +        cs->halted = 1;
>> +    } else {
>> +        cs->halted = 0;
>> +    }
> 
> This would of course be
> 
>    cs->halted = cs->start_powered_off;
> 
> though I'm a bit surprised that such generic fields must
> be handled in target-specific code.

Indeed, this is done by cpu_common_reset_hold.


r~

