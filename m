Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DE6C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF9W-0001pB-D8; Thu, 07 Mar 2024 09:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1riF93-0001WC-C9
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:54:55 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1riF91-0004JJ-89
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:54:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso732600a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1709823289; x=1710428089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oms6NqjkzEUyYaiJ7fG+Vq3lEerqyjhlXE29cWwJoZ0=;
 b=PP5BnBjG3sjxwhEVN36G7PQoprnmLZWZnpRCYi/lI6T4zD+mVLSUo6aLGKivXWGLcz
 E0pqqQuqGX5opKpMvnrwCKo5UUbEtUvcmwRo5oXLgX6FkCi2sRI5s8l3ax10J903FfUJ
 sHkT2Rnst7oFdRp2mVo0TFPgZCOr6uoN5p82quAz9wHIVlr4qeuN69uG02W+JuRFDuAs
 DvErJ3ifCRuuVAvqtOWb7tO6knp98zc5XtxhUGxMkS1faKF039u/4coX0kZAIsqvmh0/
 hUQ3K9yDQ6mvhLCJ574BHRjaY4276ovNkUuWQaeSAHrcr+LPj1EMVhmDbpf/k/rlrOc6
 94tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709823289; x=1710428089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oms6NqjkzEUyYaiJ7fG+Vq3lEerqyjhlXE29cWwJoZ0=;
 b=RwwJR81mHlTzuNSWM92FYEINxK49XhN5Lh9CwwMlJYr260saoJEuIOfcPTExBcbBQl
 TGWBg0HuqX2Ba1eQgcT72hRMlwy9MIc1l7uCO/lap4lp+gcvnpeWt9gvKBfj7PyIb5yL
 KCYJURO+RBju7RwM7yE0jz9Gb927dg+lrae6IM692jvSsnx6tAgqFTQSTNfqKkl2ZhXG
 9FShuUDH0X4pJTlbtkD7rmX1feMyXpnJ0ct3pmsZIjoQ91xhbu3mTuW8Fsew6obVVc9w
 GERo8hfQqrt86SnbiDk6xnPY1whHTsgGcD4ijsw68KZ3qf8GCaSHA3r7EoHfc5BxJWfT
 85JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjYLJsf1GtVpUDup6jzpfEmefrlrelaE7emOEiqwzV/3jEqY4UV+QHADVPlg9L7Ly3PHbu936aMC6IyIzkvy6NOc+J6dk=
X-Gm-Message-State: AOJu0Yy0af1ca2JMhqYHlw4eBA9QJleku993XOLu8uD84CXH5e0Qu9Tn
 IxvcksHGzNqAlJWykO4VjsuAc2qqvmJKafil/24RNbjwDWbdZPW6mQfFd8rUnLpRdxrpN/qx9g3
 LjMlvce/C
X-Google-Smtp-Source: AGHT+IGWe13Bj6DO8kJXxNG28L7AF4P0SccTo8h7CKv7i3Q57w/Kp+gxIZ706eaVo/nag6PmGJAsTw==
X-Received: by 2002:a17:90a:d996:b0:29b:3527:8c1d with SMTP id
 d22-20020a17090ad99600b0029b35278c1dmr13279502pjv.15.1709823289576; 
 Thu, 07 Mar 2024 06:54:49 -0800 (PST)
Received: from [100.64.0.1] ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 jj21-20020a170903049500b001d717e644e2sm14683488plb.247.2024.03.07.06.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 06:54:49 -0800 (PST)
Message-ID: <60931dcf-5dee-628f-f5ab-b3f148500e25@sifive.com>
Date: Thu, 7 Mar 2024 22:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/riscv/vector_helper.c: Avoid shifting negative in
 fractional LMUL checking
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240306161036.938931-1-max.chou@sifive.com>
 <99a59762-105a-4982-9c93-ce3e3e242152@ventanamicro.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <99a59762-105a-4982-9c93-ce3e3e242152@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.08,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Looks liked that I missed this one.

Thank you Daniel

Max.

On 2024/3/7 1:17 AM, Daniel Henrique Barboza wrote:
>
>
> On 3/6/24 13:10, Max Chou wrote:
>> When vlmul is larger than 5, the original fractional LMUL checking may
>> gets unexpected result.
>>
>> Signed-off-by: Max Chou <max.chou@sifive.com>
>> ---
>
> There's already a fix for it in the ML:
>
> "[PATCH v3] target/riscv: Fix shift count overflow"
>
> https://lore.kernel.org/qemu-riscv/20240225174114.5298-1-demin.han@starfivetech.com/ 
>
>
>
> Hopefully it'll be queued for the next PR. Thanks,
>
>
> Daniel
>
>
>>   target/riscv/vector_helper.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 84cec73eb20..adceec378fd 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -53,10 +53,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, 
>> target_ulong s1,
>>            * VLEN * LMUL >= SEW
>>            * VLEN >> (8 - lmul) >= sew
>>            * (vlenb << 3) >> (8 - lmul) >= sew
>> -         * vlenb >> (8 - 3 - lmul) >= sew
>>            */
>>           if (vlmul == 4 ||
>> -            cpu->cfg.vlenb >> (8 - 3 - vlmul) < sew) {
>> +            ((cpu->cfg.vlenb << 3) >> (8 - vlmul)) < sew) {
>>               vill = true;
>>           }
>>       }

