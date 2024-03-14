Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466FDC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 09:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkhhC-0004Zd-Qh; Thu, 14 Mar 2024 05:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkhh7-0004ZT-So
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:48:13 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rkhgz-0004BP-4b
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:48:13 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5a467dae51dso15099eaf.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710409684; x=1711014484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UkHUxYPI2dZFHxkr8oO6zxZLSGowwUek3In1UIeTNZM=;
 b=TAr0Ra5FtlPMh1GaijK/zV/JztmhE+Xsi4rDS/eTwHHaJDdPv4RMKFEGTCtNbq7Nrg
 vDRpvU+c+1k9OlhxrwYuwE20bzaPnRV+2C326DTr9aMs7OohHa0v9HjWiDsMO95ixIwh
 WDdBvF1XmfI9Y3eLMKHUs1zr6a7DgszZPzhZjPuk7ESv1WffIFgzaPeU06IjB1DzabP/
 hWIKZResXdBtvCwdZr+eQ/MbzTtNGAFqcbSwFRLVQzkUuDngGPSdEytDCQZci0FKd3OS
 uXq42p7xoRjyzoyAM+uq3oN0iUVqVz2/zYIZmYK6HEATYLQILgOc29yutHQz+45Sv23r
 pW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710409684; x=1711014484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UkHUxYPI2dZFHxkr8oO6zxZLSGowwUek3In1UIeTNZM=;
 b=hXz59CRsMVrKV7odF6RYs3MgTsQtwE8J7b5NIL3Xeg4L1vkp6lNRSLinqCtGh4cMMN
 UiaCXvXQzEFSbAAJaPkoyaWpkf9rCp3jIYLBQHvyBSInWF4klIoyTX70Q835YJPJvk9p
 DSwjfHIMYZ3tymhuvnvrxOi8gdsH7h4HI2qAs4lRi6lZR/tcsSpibMRM0IZ8Tb0LROJF
 4U4yDowgXlTlR1q+7zssqC/dOTBWp9Xkge1JL4aCim55Gw9RrV7wWkXznuv7RP1vn9R1
 nmqpvCf9IT47oitXGofZR2OM4Q9I2IZx+T8kUoDw/qnmNLeYdKb+B2N24Xy7PtstYXyD
 3Bkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3WfkPo7mHL6lnBvYKcwNgEbKQq2BmSAIHpqEua7xOykO1PzwUPVG/uItgqiQ+i3GRI8yZg19Regl7i9unXsdSBR3X2Fc=
X-Gm-Message-State: AOJu0YwWx0pYWZo29yTLtk/ZlaxZKcXJqStcwu+zj1KmjxnHhxPbu+IX
 Y8hdS2C+ZaaMdXYIjoNGGXu5DrlEG/scjcKNZLnE6KkH+aWEhUgghx4LmUaXxDQ=
X-Google-Smtp-Source: AGHT+IFDdRAgivjHn/vqUUfn3LRaoVwA7EQPvSukMLeLQDiz5N9gF/bw6layj63H50nk8fCeX5PfGQ==
X-Received: by 2002:a05:6359:4584:b0:17e:a368:441b with SMTP id
 no4-20020a056359458400b0017ea368441bmr1663418rwb.0.1710409683798; 
 Thu, 14 Mar 2024 02:48:03 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a63fe48000000b005dc36279d6dsm306636pgj.73.2024.03.14.02.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 02:48:03 -0700 (PDT)
Message-ID: <5fa68b7f-9eb7-4817-ad63-7f8e9ca09d7e@ventanamicro.com>
Date: Thu, 14 Mar 2024 06:47:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v14 4/8] target/riscv/vector_helpers: do early
 exit when vstart >= vl
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
 <20240313220141.427730-5-dbarboza@ventanamicro.com>
 <9c04593a-3909-47b4-92f7-4195582a8e83@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <9c04593a-3909-47b4-92f7-4195582a8e83@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
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



On 3/14/24 00:52, Max Chou wrote:
> Hi Daniel,
> 
> According the v spec section 15.2 & 15.3.
> 
> "The vcpop.m instruction writes x[rd] even if vl=0 (with the value 0, since no mask elements are active).
>    Traps on vcpop.m are always reported with a vstart of 0. The vcpop.m instruction will raise an illegal instruction exception if vstart is non-zero."
> 
> "The vfirst.m instruction writes x[rd] even if vl=0 (with the value -1, since no mask elements are active).
>   Traps on vfirst are always reported with a vstart of 0. The vfirst instruction will raise an illegal instruction exception if vstart is non-zero."
> 
> Both the vcpop.m and vfirst.m instructions will raise illegal instruction exception with non-zero vstart.
> 
> And currently both the trans_vcpop_m and trans_vfirst_m translate functions check the vstart_eq_zero flag.
> So I think the early exit checking in the vcpop.m and vfirstm helper functions may be redundant.
> 
>> @@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
>>       uint32_t vl = env->vl;
>>       int i;
>>   
>> +    if (env->vstart >= env->vl) {
>> +        env->vstart = 0;
>> +        return 0;
>> +    }
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (vm || vext_elem_mask(v0, i)) {
>>               if (vext_elem_mask(vs2, i)) {
> 
> According v spec section 15.3
> 
> ""The vfirst.m instruction writes x[rd] even if vl=0 (with the value -1, since no mask elements are active)."
> 
> If both the vstart and vl are 0 here, the early exit checking will return the wrong value 0 (the return value should be -1) here.

Let's just remove these early exits from both vcpop.m and vfirst.m functions then.

Thanks,

Daniel

> 
>> @@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
>>       uint32_t vl = env->vl;
>>       int i;
>>   
>> +    if (env->vstart >= env->vl) {
>> +        env->vstart = 0;
>> +        return 0;
>> +    }
>> +
>>       for (i = env->vstart; i < vl; i++) {
>>           if (vm || vext_elem_mask(v0, i)) {
>>               if (vext_elem_mask(vs2, i)) {
>>

