Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB199C07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgH0-0001x6-86; Wed, 24 Apr 2024 13:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzgGr-0001wQ-O0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:19:02 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzgGn-00071U-GP
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:18:58 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c5ee4ce695so66732b6e.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713979136; x=1714583936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GsOCIQKFSyHzRI8PbcW9VcRuxJW59AWgDAEe38Er4SI=;
 b=QEiXX6Lz07YoOYbOXmddMidTty7TygN9qVDPOw3Z1qcegKd+Xga8JdHskcV5G0lgV0
 KIrSj+5QY5hBPWT55AzI9ouDADex82U+5KLgLT5LVuMhIfySNzK/hSVTdNCyOhybl6nQ
 fD6fpy8zkuMtLOKg2Z48afwN6eCSvm36Gs47Hy5x/dp2bSImHgSGG2080OpHwk5ZwQwa
 BjNIFZ+i9cN63NaOVU7kEq4kES2IwdpfWJ0bXx61vddwpsSDC1KkiK2pu91Fp4O5nslP
 pcy3kqAGxCdHc8w1xWU8Xcsy+un0uON3feeQthUPKZR32f16BTsbk/o+aVWxI2Gi4KUQ
 Y9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713979136; x=1714583936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GsOCIQKFSyHzRI8PbcW9VcRuxJW59AWgDAEe38Er4SI=;
 b=GNRD9ACbUFHz9DblXg17y4T5aNq0cBAWJG0CAoZyYTYqHthTwdWWCphQkhXYakodWq
 icFJx4Fn1daCTkeOhpA5aqL24WMabYJ6up6s3X/jLgQPNZIjqSyj/zg+HMqhV488/fit
 O5fQH3xUQ/0W36AyCyOK59F0OcKKM7fkjmYU7qUSv3p9AINTLge/V5jYvYm6IXSdqVTX
 6F3gtskoDCmczwLSd4qZveBjNAfbKuuEXB2XMrzrz72C0AP4igqgHKk48+N023cEHnDC
 yQF1m1Epjmgys+3Mb7v74tGTcsCgwIeK9pwosv2fQR0igS9PLDuiITQqiPdPG4um/bOl
 8K4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOwF3gaZbD+1aTldHRWekL2H0ujcykZ8W7uX88rj+d5X3UIV+4UhNfTYwPtbObKDHIRQsCNo0Z7nntsIDVVP2yNIO7D9Q=
X-Gm-Message-State: AOJu0Yy8aCcwC04wnX2Yi4udNjIqTb/T7jlwVyHhCPrC1BkxVkmHcHiO
 CY5WLFLzuOJNigZ7LcX9Z2w6fGqedQlCf5iU9JljBXX9bEMnQ7QN9zho82SAGVQ=
X-Google-Smtp-Source: AGHT+IHykTZG/3+gty8JFJ0bl7IKuHEPHVwwezTCdbRkivI28Xx4Dw55dXnfVZpjegvbe/zCqoHdYA==
X-Received: by 2002:a05:6870:f10c:b0:222:99cb:2215 with SMTP id
 k12-20020a056870f10c00b0022299cb2215mr3303030oac.28.1713979136046; 
 Wed, 24 Apr 2024 10:18:56 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.121])
 by smtp.gmail.com with ESMTPSA id
 fa19-20020a056a002d1300b006e57247f4e5sm11680927pfb.8.2024.04.24.10.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 10:18:55 -0700 (PDT)
Message-ID: <a619f516-d174-428a-aa19-52664282265b@ventanamicro.com>
Date: Wed, 24 Apr 2024 14:18:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv/kvm: remove sneaky strerrorname_np()
 instance
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, mjt@tls.msk.ru,
 ajones@ventanamicro.com
References: <20240424094700.453356-1-dbarboza@ventanamicro.com>
 <20240424094700.453356-2-dbarboza@ventanamicro.com>
 <82079170-9d82-46d5-81e4-44d3b38b551f@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <82079170-9d82-46d5-81e4-44d3b38b551f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22e.google.com
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



On 4/24/24 06:55, Philippe Mathieu-Daudé wrote:
> On 24/4/24 11:46, Daniel Henrique Barboza wrote:
>> Commit d424db2354 excluded some strerrorname_np() instances because they
>> break musl libc builds. Another instance happened to slip by via commit
>> d4ff3da8f4.
>>
>> Remove it before it causes trouble again.
>>
>> Fixes: d4ff3da8f4 (target/riscv/kvm: initialize 'vlenb' via get-reg-list)
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/kvm/kvm-cpu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 6a6c6cae80..ee69ea9785 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1054,8 +1054,8 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
>>           ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
>>           if (ret != 0) {
>> -            error_report("Unable to read vlenb register, error code: %s",
>> -                         strerrorname_np(errno));
>> +            error_report("Unable to read vlenb register, error code: %d",
>> +                         errno);
> 
> Why not use "%s" strerror(errno)?

It's not exactly the same. For errno = 2 strerrorname_np() gives "ENOENT", and
sterror() gives "No such file or directory". In this particular context I think
just printing a "error code -2" is clearer because we're not mentioning files and
dirs in a KVM reg context.

But in the end I don't mind changing to strerror() if you feel strong about it. It's
fine either way.


Thanks,


Daniel

> 
>>               exit(EXIT_FAILURE);
>>           }
> 

