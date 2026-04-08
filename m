Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A3F10F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYHN-0005my-BC; Wed, 08 Apr 2026 15:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYGA-0003n2-FB
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOQ5-0001ef-OA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:37:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso7357935e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775637472; x=1776242272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rYvIoV64UzXrtoITOOTHknJ6ZResgG8x/xuVEBwW9Yw=;
 b=IwVLNYb8oveekigxcPRwBLBRWrpKVRGYwEyUbmaXa7Ohfu2I/d7t8DkDlLq92lVs3B
 EF3eVcc05XaQZB4eXI3KnunIjVmArVk4Js9vLPxzFEput5T5QVdY+IGIO1fO5OjGPi/i
 zELvZh+TLnh/5TTwRF4+au4pe8pK0MKqOuE2EOVWn2odlZfIhEHMzFnhXS1jp2ekiwTX
 xvzHgAqH5bOFHf4Hivwu0LkdvtDUgfGaT9rF0j1Nf4gBEa0XfXzgsIcMSP/R5SkZ1ZP/
 N2sQHJWIc54XzeEj9hacbrbR11DTeMpIIhNK6WZ09e44Ku9xkN0f2kPP+5rBIqDKa87x
 CMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637472; x=1776242272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rYvIoV64UzXrtoITOOTHknJ6ZResgG8x/xuVEBwW9Yw=;
 b=Chzd3SQ0BdT4FIej+05f8UzfXW0yyrNJlhEr0999g4I5M6+BMwfOuzMNoJ5+AI4BZ7
 8fKiGU3JPidT7MU/nwyNkRDM/aUNQCWAYCvvLAWngR4Ye45QV46uBjWhDpen3umSRakB
 1xK4JGEIIYUrktlJQFX65iYevl3lfcu7dxleoeaA0oFvSCqEb19dVUqznA/wE69gSXPs
 XRY5wVfVqLl4xrlF8TI5NP6VatMLRCsgkn8kuCYZTNtFJ5QQnNeYIW3RG0FAlc8OH94w
 yI7hBl6q40WNwc47VfRAFNk8NELDvIoNO7OG57KjwjsA5FAVDoP0kn/h0AcwARGahE6j
 SLbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU99eX3e7crxtGRVQc/nPWDEFwbHiHdk59exz4YuTIHiRZC9GHeM3NGjKitnodin7Ox6A/TKEZTtX+m@nongnu.org
X-Gm-Message-State: AOJu0YziXQeGAJpdWXGbhMtDddJpzu3X6OaLo2ewq3kq+ifvbqNCPVQI
 e84wAoimykZk8nYIi8P6ZsoCB2P35ATtxXHdEF82BteiH27JHvHmQf1If7bRDQhfiqs=
X-Gm-Gg: AeBDieuzJliLr1BWRdNAeULO0NRUSbE1s1HvkReXRUmVHOi39nKY//3G7lupnKNu/LT
 dV6P8Amnm+Ff9AVsdTh9Ei6Sr1LVSE82kXJdXIw0v9yxOR/VDT07r08Kkz/B17V7Ib14U5Pou7U
 s53GpDRDtI4hfyt+MGhlBIIk6nOJiP2tZh/C98Mpa6C2HjcWeJrOtv84XwV5EswOA7s1IuaNTcE
 rz3NSdLpJfOoU9sVvBZ4Wnb/rgn8s2bBKo0zeFMjbJGrvPgNTnwLVksUCvwCAKVxac33VqSuxhe
 NCOPs2BtjKanjEVnDxyIF33np/6UodW6wCSuU6nz4q4Jp+66EC0OYYtY6HKd6lsARQ54cViX4Ms
 wEGfeEKTm+o+SV9MBUGzKJWwCY+9kz2ha+vjakmn5aY6Jiz+c27z95Zr2QqdrWl1UdUQ3a4cK4A
 6Gwiv/mLrnEu3P3ShVouxNl5Ka+UuhDKRQv5KgwpQqAvM5fXoxpZPXrg9xDklqTCRa0w==
X-Received: by 2002:a05:600c:8288:b0:488:b47a:908b with SMTP id
 5b1f17b1804b1-488b47a92e3mr142534175e9.11.1775637471887; 
 Wed, 08 Apr 2026 01:37:51 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e5890sm55800959f8f.31.2026.04.08.01.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:37:51 -0700 (PDT)
Message-ID: <9846560e-9074-419d-9d06-9b949f6372ce@linaro.org>
Date: Wed, 8 Apr 2026 10:37:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] linux-user/strace: Add a wrapper for read and write
Content-Language: en-US
To: Chao Liu <chao.liu.zevorn@gmail.com>, alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-3-alistair.francis@wdc.com>
 <adUycpyM7bUjmC_7@ZEVORN-PC.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <adUycpyM7bUjmC_7@ZEVORN-PC.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/4/26 18:55, Chao Liu wrote:
> On Tue, Apr 07, 2026 at 02:36:11PM +1000, alistair23@gmail.com wrote:
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> The stack pointer is being truncated as 32-bits for qemu-riscv64, so
>> let's add a print_read_write helper that ensures all of the bits are
>> printed.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   linux-user/strace.c    | 14 ++++++++++++++
>>   linux-user/strace.list |  4 ++--
>>   2 files changed, 16 insertions(+), 2 deletions(-)


>> +#if defined(TARGET_NR_read) || defined(TARGET_NR_write)
>> +static void
>> +print_read_write(CPUArchState *cpu_env, const struct syscallname *name,
>> +        abi_long arg0, abi_long arg1, abi_long arg2,
>> +        abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    print_syscall_prologue(name);
>> +    print_raw_param("%d", arg0, 0);
>> +    print_pointer(arg1, 0);
>> +    print_raw_param("%d", arg2, 1);
> If TARGET_NR_read and TARGET_NR_write support 64-bit targets,
> abi_long is int64_t, so %d will be truncated. We can use
> TARGET_ABI_FMT_ld to replace it.

With the 2 "%d" replacements to TARGET_ABI_FMT_ld:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Otherwise LGTM.
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> 
> Thanks,
> Chao
>> +    print_syscall_epilogue(name);
>> +}
>> +#endif


