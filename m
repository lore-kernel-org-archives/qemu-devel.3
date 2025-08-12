Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ABAC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 03:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulg7s-000180-Vh; Mon, 11 Aug 2025 23:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulg7o-000178-7r
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 23:56:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulg7h-0001wy-46
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 23:56:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so4845735f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754970984; x=1755575784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pw5E3/UIlT9ju7vyfNF/DK7vRng9dgsMA8rb/tBm3Y4=;
 b=KWAZwy2nXdXQFJuMfou80EfOHjmCmUITIHsd3kB5FIfuWHPicg8R4GFDmpuVuOdaO3
 SQnDVxNjOk7OfyJWeUT2mMzYTs+lIBRTC4dxRmzuSqySN3BLY9OLJcMC/7apz6GjkGI8
 /yIOeDzNTVKicCP+f7VcVDmLhO0VbW9IA2yW50t7Hg5xBUplXdo1czO0pvSu63Y6jFGw
 o+t3Ws4+HSp1ojwmoXXN2Lk0QvukH6D9NgtgaLo6I44UwjP9VQcAf+336KpndyoeOgBN
 mjsDCvbvQM8ShTsm9WzNypYpzZ7rPEOBsSqnYhhf7wke8zzUaHRD8UEIYvAn4SDH7fA6
 we1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754970984; x=1755575784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pw5E3/UIlT9ju7vyfNF/DK7vRng9dgsMA8rb/tBm3Y4=;
 b=DrPA8V1TCPPEFGpTPfWx0b8ZwT7UKvsmnbu3TETh780fSkBBf1BCcAnXRJPxwKGgdt
 vkKJFZPwmAmhncXkXKTBOAvwRA1r+DldGWuIthdaLUxRevlflHQrmGnX0RQcJcXFJINm
 ylFiCz+SLuFbyRfl6G3PAGL8PVF7wbPgEfvo8c1ci7I1CFN4tlMc2WeIpSdKs2wb7Nr0
 Q7myyWB1JC02lWKrr03yMIQiyWPkUyoNhYv2blguhaj1JkpLQRzQaQzMdtUbfNnc6Doq
 0bL1JZx8iu07Hd64TgRvCYAyya1t4rQHCbH9h/3CP9LThyIam2pQiMkI0Py30QXPZ5f7
 f4rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeM43iBoBBhtVU29IN4b9t1RYwJOzVtx6mRnzg1WAytPW8B1amjz0HCOTItbHID95Xxt61s5O7gVFD@nongnu.org
X-Gm-Message-State: AOJu0YxyT9mFlJ9MJa6708A2x4a/8XlZkOMfJITnxO/hKbs40Ta5T/m4
 cD2qYhnviQnsrPJlAU8PTxL9HeEbxxZb9sCutJ+rvgBmlmg0gHr4vvHqXvm34qE/OzA=
X-Gm-Gg: ASbGncvxVZdDqdG7FL02iDBA3UdvrTsTBZUfm26YCnbqHlFQfrBrI76HcIBsCUarJ4f
 KLC51T8ocozBepJuNkZRVCj5dBZggeAOaQBK7b16K8bL5m7edXOhyix/ruCwyOpfxCNyp1ZtP2G
 YWiEl/aDejFkD9U7Hbp3489hB8dXeabPP7jb46pXasMJLQYLDlUVh2hqIKFxth5xvz3/R6RhmUS
 cD72AfwBqwzl6Oy+q7Mr1XxVq5JDJLXx3FwasIjn88d9K709WsScvcmhcl+Rsrw4JNOi3oDZx7/
 qoAx5bxVkBFigG1qHQRGUbkWTTezp/bjhqcVRQmWWZf0efQ9m/2E5QtL++QVChlDqweEpIUtJxa
 4yOiXpMQlVCTz1Wx2WgnXXG/FvN2NJVlbMGhowQKoIaPNcRWU3X263ojAf338HNXlfA==
X-Google-Smtp-Source: AGHT+IH7sxAokkpZ2cRgczX57mRo7dWlUIfLtN/ffo3VLShq1CjUdgIQy6sY78GTm1LWgkXNslSCMw==
X-Received: by 2002:a05:6000:4203:b0:3b8:ff3b:6437 with SMTP id
 ffacd0b85a97d-3b900907947mr12487528f8f.0.1754970984480; 
 Mon, 11 Aug 2025 20:56:24 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ee17535bsm241503735e9.16.2025.08.11.20.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 20:56:23 -0700 (PDT)
Message-ID: <97e463d8-bc99-4a9b-872a-179b3d28f350@linaro.org>
Date: Tue, 12 Aug 2025 05:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/11] target/arm/hvf: Allow EL2/EL3 emulation on
 Silicon M1 / M2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-12-philmd@linaro.org>
 <99d1910a-2572-4cd4-b6e1-e874a0992bbb@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <99d1910a-2572-4cd4-b6e1-e874a0992bbb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/8/25 02:23, Richard Henderson wrote:
> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>> @@ -1014,11 +1015,14 @@ bool arm_hw_accel_cpu_feature_supported(enum 
>> arm_features feat, bool can_emulate
>>       case ARM_FEATURE_GENERIC_TIMER:
>>           return true;
>>       case ARM_FEATURE_EL2:
>> +        if (can_emulate) {
>> +            return true;
>> +        }
>>           ret = hv_vm_config_get_el2_supported(&supported);
>>           assert_hvf_ok(ret);
>>           return supported;
>>       case ARM_FEATURE_EL3:
>> -        return false;
>> +        return can_emulate && tcg_enabled();
> 
> Surely the el2 portion needs the tcg_enabled check as well.

Oops, indeed.

