Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D8EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOEE-0002IF-8q; Thu, 04 Jul 2024 11:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPOEB-0002HV-Td
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:18:31 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPOEA-0006RI-8D
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:18:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f4c7b022f8so4756365ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720106308; x=1720711108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLCzWgyAAzzMDQGCfRV1PTCC5bLFjvKFeRuUldkJYLA=;
 b=ozdLVAfO2j9o07EtLDXywvCmP61dsr6SMuyJiU1FFaDSouzdZ7ihW8TVjdTjoydf/x
 9RLjGHu8qMcQASJ1Ch4HYHtKSSKMdbYl/2RncmfctRScCGEiTsB0HOozB/7lS0wlUA0u
 9ntFz1hRUnL5OvIvsey8ytLsm0yPqsmRHKlq6CLyW9PgbsRuRwIJ54i9JpUzJnOAJkEg
 9FFwGUEFPVXVXD6oGTTOltFdHj7Y1qsLovugKezWuSchcv9Qk8w6nhXRW1ZhmWxSlM3y
 0OHgrIlmeVeLPGcPCD6SW51ezjwXOENyc+dF54ShiL8qJSCk5F8O1V1K9DVrTrgB/ZMx
 DtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720106308; x=1720711108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wLCzWgyAAzzMDQGCfRV1PTCC5bLFjvKFeRuUldkJYLA=;
 b=Br9DIrzr3+RiXwG/4YdUzXnM0kId5XZSSoMYh/o/stAP2sJjrSPnV74MOztAqBqAn4
 lE2StQaZrfKQyl7oJarodf4rom7kg5YX6q60mgmDshscFMOtvQ4Vso3ijB77VN+VwmpN
 INSBcApuTbHYFdYQxiK24/Hh9IdXjZAnpjWnJsk3WwpYoxY5PjIZ0ginMNKF+E8vJ0Lc
 Fwmxl74b5otKAw9K241FWPQvSWCSrwq/tTkPX7xo200z/kWY/cS0BPs3dBt4SCb0IOo1
 7pd85bvhXwHWaH3O+RwgI1BxJJLQFqlgiMGhm9E5gua3pMK8JQQ/5+Yn2AsEWLVjOknx
 daZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc9ABGOduek02trMudEpTJu8rspx8o2sh8Tu/5BL0zPgyIQ07dWdMRadLBkjAmefhxlsjJsbdk5z5Ido14PLHiBGWIciE=
X-Gm-Message-State: AOJu0Ywup/EzgE72VC8c4stm+zQKx7OddtSeXbCLO1rlywr0Gok86g55
 OoX/hm+CRSkAFdKl+bUrgRV33cupLS/mvIMwzisetkjb6P698YuzjvWC4rXgBFc=
X-Google-Smtp-Source: AGHT+IEnPKvOCSFbNZrciko+h4KORH2CZhfIZ22CyPzWLK7wVzy7U5WhO6i9NXQahw0uG5Lp7r9xvQ==
X-Received: by 2002:a17:902:ec92:b0:1fa:8f64:8b0d with SMTP id
 d9443c01a7336-1fb33df55f9mr16234285ad.4.1720106308380; 
 Thu, 04 Jul 2024 08:18:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb17d8093esm34799395ad.3.2024.07.04.08.18.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 08:18:27 -0700 (PDT)
Message-ID: <9fe81eeb-473a-4ffb-ad6f-f93e40283e8a@linaro.org>
Date: Thu, 4 Jul 2024 08:18:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, david@redhat.com,
 balaton@eik.bme.hu
References: <20240702234155.2106399-1-richard.henderson@linaro.org>
 <13b19a4859e25274d05663bc0ca05621c56af985.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <13b19a4859e25274d05663bc0ca05621c56af985.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/4/24 07:50, Ilya Leoshkevich wrote:
> On Tue, 2024-07-02 at 16:41 -0700, Richard Henderson wrote:
>> While looking into Zoltan's attempt to speed up ppc64 DCBZ
>> (data cache block set to zero), I wondered what AArch64 was
>> doing differently.  It turned out that Arm is the only user
>> of tlb_vaddr_to_host.
>>
>> None of the code sequences in use between AArch64, Power64 and S390X
>> are 100% safe, with race conditions vs mmap et al, however, AArch64
>> is the only one that will fail this single threaded test case.  Use
>> of these new functions fixes the race condition as well, though I
>> have not yet touched the other guests.
>>
>> I thought about exposing accel/tcg/user-retaddr.h for direct use
>> from the targets, but perhaps these wrappers are cleaner.  RFC?
>>
>>
>> r~
>>
>>
>> Richard Henderson (2):
>>    accel/tcg: Introduce memset_ra, memmove_ra
>>    target/arm: Use memset_ra, memmove_ra in helper-a64.c
>>
>>   include/exec/cpu_ldst.h            | 40 ++++++++++++++++
>>   accel/tcg/user-exec.c              | 22 +++++++++
>>   target/arm/tcg/helper-a64.c        | 10 ++--
>>   tests/tcg/multiarch/memset-fault.c | 77
>> ++++++++++++++++++++++++++++++
>>   4 files changed, 144 insertions(+), 5 deletions(-)
>>   create mode 100644 tests/tcg/multiarch/memset-fault.c
> 
> This sounds good to me.
> 
> I haven't debugged it, but I wonder why doesn't s390x fail here.
> For XC with src == dst, it does access_memset() -> do_access_memset()
> -> memset() without setting the RA. And I don't think that anything
> around it sets the RA either.

s390x uses probe_access_flags, which verifies the page is mapped and writable, and raises 
the exception when it isn't.  In contrast, for user-only, tlb_vaddr_to_host *only* 
performs the guest -> host address mapping, i.e. (addr + guest_base).


r~

