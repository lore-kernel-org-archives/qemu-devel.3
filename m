Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKfz-0006eH-Ss; Fri, 12 Apr 2024 13:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rvKfz-0006dy-0J
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:26:59 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rvKfv-00030V-M3
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:26:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so6646475ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712942814; x=1713547614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P3DKA10cGVxqOJD5ZVls9Bezx11cg5ENXIVx4Fno3QA=;
 b=CgO5JZaMoTS8mP2TudaZCU7yJmnBPBO5RRp05iIFyGNVVuqnFOEs8O0GWnXWpY/zA1
 Vs5M3VaGG3RWa3bT03X6n3hsKawQ9m8TDDYVrqdFDrqv6uF89/gGGzDv1Yk+I7zR2bRG
 P1ZN0VkKI7nsDFNQzK76zS34wbipojs3Am5IsejeerN4i2YMGSmkxL6dsKk084LmB+uA
 nl9tJg8cqYFx3OwthXrq2zmySVsZVBxI2c3EcGtBnPP+pYVd8GU+hrGx5iEu0Ag+CBDX
 wbkHZ/7yjKO+hhTUJI2mfpgRZWPfKxIYVL3UQ4AyHVWt7hEgBZFMaflKTJMHiYTrUwTc
 dxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942814; x=1713547614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P3DKA10cGVxqOJD5ZVls9Bezx11cg5ENXIVx4Fno3QA=;
 b=E8Jp6fyumyA1nROVbgpKCRvk/4vutPSoYsK0eJk6NvkPf7NxKjqHOLpZxdth8fwrg4
 XwnKdDAroo9MgzYHFXH6wY3IkqMLf9jmAjx5RG+B6nBZNo4YYdjfkESQRXN38Q6tzWDt
 EEYOblEHqNnXczCNrMeiGKHMTtbJ9AA33FDgRLkwl2g48gP/5KRi3aIyY7l9w+pIuwgK
 PI0ozgcGXikc4EeFltaePWMf+vrAlz2WwYEF6bNA9vGLdktoNUXiacdpiT27vg0OkI5C
 ru6Bka+sCT6veYbw4G1QRV2z96/XRpafvBW5KKs1eHL5Q9pFlXe2OLIizphA/xGhN2OM
 W47g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgYGMpmAfvXzhCxG9qGx8PWrMI2/cZS7EwN2ahymvCh95PtVmXr3gewNfIXMo6qYxY4arSzniZKTFB+fgFm8r5P221Afo=
X-Gm-Message-State: AOJu0YzKYZkvZt475htJnqP7ljBhU5ttLuPDquQzfVFFYlSSADNSW0OW
 hoK/zAO3BypxTyZK9FBJJrWf56aCGHsURudx/R/DDNDO/Pw1MlUyF3ROxgusYmT9nwtICXDWXMc
 U
X-Google-Smtp-Source: AGHT+IEAuNi3rKWw6Fpsh+YTeZVBu3QptdUZbQ4LBCOfI1QP03Z/vJ/KMBacI7ReZmdfP6iQuc7TPQ==
X-Received: by 2002:a17:903:22c2:b0:1e3:c186:8db3 with SMTP id
 y2-20020a17090322c200b001e3c1868db3mr8798912plg.15.1712942814001; 
 Fri, 12 Apr 2024 10:26:54 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.202])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170902e5cb00b001e20587b552sm3245046plf.163.2024.04.12.10.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:26:53 -0700 (PDT)
Message-ID: <70b7f011-e091-426a-b4aa-88ed9f112c79@ventanamicro.com>
Date: Fri, 12 Apr 2024 14:26:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Content-Language: en-US
To: Aleksei Filippov <alexei.filippov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, Joseph Chan <jchan@ventanamicro.com>
References: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
 <a8680fb3-8547-4b68-98d1-fd2d2d278375@syntacore.com>
 <6947ea59-ccbd-43b8-b8a0-bc543b9992f9@ventanamicro.com>
 <a4a23a7a-04fb-494d-b13a-933ab1a93ffa@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a4a23a7a-04fb-494d-b13a-933ab1a93ffa@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 4/12/24 13:52, Aleksei Filippov wrote:
> 
> 
> On 12.04.2024 19:00, Daniel Henrique Barboza wrote:
> 
>> Thanks for giving it a go. You're right, this patch alone is not enough and we'll
>> need your patch too.
>>
>> But note that, with what you've said in mind, your patch will also end up setting
>> mtval2 and env->guest_phys_fault_addr in case a PMP fault occurs during the
>> get_physical_address() right at the start of second stage:
>>
>>          if (ret == TRANSLATE_SUCCESS) {
>>              /* Second stage lookup */
>>              im_address = pa;
>>
>>              ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
>>                                         access_type, MMUIdx_U, false, true,
>>                                         false);
>>
>>
>> I think your patch needs to also prevent env->guest_phys_fault_addr to be set when
>> ret == TRANSLATE_PMP_FAIL.
>>
>> With these changes in your patch, and this patch, we're free to set "first_stage_error = false;"
>> at the start of second stage lookup, keeping consistency, because raise_mmu_exception is now
>> able to deal with it. I can amend this change in this patch. This patch would prioritize
>> PMP errors, your patch will fix the problem with mtval2.
>>
>> Let me know what do you think. If you agree I can re-send both patches together.
>>
>>
>> Thanks,
>>
>>
>> Daniel
> 
> Oh, I actually missed that, thx, you are right. I could prepare patch to fix
> this, do you want it in this thread or in previous with only my patch in?

If you don't mind, please re-send it together in a new thread with this patch too.

Include this one as is, then include yours as a complement that fixes the problem
with mtval2 that my patch missed. You can use the explanation you gave me as the
new commit msg for your patch. E.g:

"target/riscv: do not set mtval2 for non guest-page faults

Previous patch fixed the PMP priority in raise_mmu_exception() but we're still
setting mtval2 incorrectly. In riscv_cpu_tlb_fill(), after pmp check in 2 stage
translation part, mtval2 will be set in case of successes 2 stage translation but
failed pmp check.

In this case we gonna set mtval2 via env->guest_phys_fault_addr in context of
riscv_cpu_tlb_fill(), as this was a guest-page-fault, but it didn't and mtval2
should be zero, according to RISCV privileged spec sect. 9.4.4: When a guest
page-fault is taken into M-mode, mtval2 is written with either zero or guest
physical address that faulted, shifted by 2 bits. *For other traps, mtval2
is set to zero...* "


Thanks,

Daniel

> 

