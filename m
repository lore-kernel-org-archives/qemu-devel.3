Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134ACCF8842
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swjEo-0006cT-Ge; Fri, 04 Oct 2024 10:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swjEn-0006cK-Ic
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:24:57 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swjEm-0003fa-3k
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:24:57 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7db0fb03df5so1502321a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728051894; x=1728656694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DsmHLym1d32y6Bluz2G4DVn2l53NvdPQ/1+3YEoFmOk=;
 b=Y4/wrDlJ57ROIrUIhv7Bl3l45OLS1B6PdI7HPslv1S6ARHxrY3H2qvrArj+oQMr1F/
 tmiMvQDNm6vNhEfWZu1a2bRyiFsgiesp8at00dG8r+qe0lkO6Qtx5LIB6gPGjnSxhMhV
 2iz4+gmeAQqqbSBFC7DYm7irtPIjCnmX0Dz0V5dWE341jd52eB3JbGGkXQnkgDJyD7Ph
 0p6IqKTD2ZT/FOKcbCMJ0tkraOtgGMgfHQPC7l/Gg/tf9+mr0BRSr6/qcM/eueJ80B2d
 tHQsVYG93lW8JnbJ8q37AgbBTW6TN8HC5UG0W9fdio+f379FzDLIvTW04cPu7Er8qqQa
 Ibtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728051894; x=1728656694;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DsmHLym1d32y6Bluz2G4DVn2l53NvdPQ/1+3YEoFmOk=;
 b=UbUeHGg2sGa4bb7F18heUA26F7ITiKSR5yWUmSL0L3HpqVudZxyVHbSDHtQ1pEyTEk
 wAAuxlUS4hI+Ra+rQaWfweYyv2lKIJbHSDbpQ58wkg7yC1ynufE7fkRrbedfkmIKmi3m
 EG4TwXKpX3Ix+9EIuNriOM7DqTK0a31lN+yFfmFRDjXSMCGZx/yPmk1xh/kFp4W8PqKj
 NEbARNh4Wm9qTFv4HJgA1AcmpPUPOkQ9CTB0rkKSthlo2jKTwc6b27vOKW7TKP2CKvHV
 Gvvp7xjBmVNYumomDywGp6nsEELg15ZBliePxHijD5k2rnuF9dazK01EL4lBi7rxtPuq
 /Zqw==
X-Gm-Message-State: AOJu0Yznmt2++4CXthlWB6OGhEyV0l2VRGbKLLnwRSW8Y3WRgzQc39Dw
 bpTUj/TS62cgE907UO0ZZlRj801mwiYJiN3Y652ZkTYGE+E8L+Vo3XUKVXXHpls=
X-Google-Smtp-Source: AGHT+IEmdwP5lRe7W6JADtq6JvljlZ8pFVbjzKfOdvVyWhmp1/RoXe+2hTSPkS1iDDUyl7+AD3ZXRQ==
X-Received: by 2002:a17:90b:4a4c:b0:2da:61e1:1597 with SMTP id
 98e67ed59e1d1-2e1e636f476mr3872402a91.36.1728051893979; 
 Fri, 04 Oct 2024 07:24:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85d9ac9sm1652563a91.28.2024.10.04.07.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 07:24:52 -0700 (PDT)
Message-ID: <c05823ff-47dd-40b1-a363-0c4b9cb47713@linaro.org>
Date: Fri, 4 Oct 2024 07:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: {PATCH] accel/tcg: Fix CPU specific unaligned behaviour
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, linux-parisc@vger.kernel.org
References: <Zvyx1kM4JljbzxQW@p100> <87cykimsb9.fsf@draig.linaro.org>
Content-Language: en-US
In-Reply-To: <87cykimsb9.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 10/2/24 08:35, Alex Bennée wrote:
> Helge Deller <deller@kernel.org> writes:
> 
>> When the emulated CPU reads or writes to a memory location
>> a) for which no read/write permissions exists, *and*
>> b) the access happens unaligned (non-natural alignment),
>> then the CPU should either
>> - trigger a permission fault, or
>> - trigger an unalign access fault.
>>
>> In the current code the alignment check happens before the memory
>> permission checks, so only unalignment faults will be triggered.
>>
>> This behaviour breaks the emulation of the PARISC architecture, where the CPU
>> does a memory verification first. The behaviour can be tested with the testcase
>> from the bugzilla report.
>>
>> Add the necessary code to allow PARISC and possibly other architectures to
>> trigger a memory fault instead.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=219339
>>
>>
>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>> index 117b516739..dd1da358fb 100644
>> --- a/accel/tcg/cputlb.c
>> +++ b/accel/tcg/cputlb.c
>> @@ -1684,6 +1684,26 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
>>       data->flags = flags;
>>   }
>>   
>> +/* when accessing unreadable memory unaligned, will the CPU issue
>> + * a alignment trap or a memory access trap ? */
>> +#ifdef TARGET_HPPA
>> +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  1
>> +#else
>> +# define CPU_ALIGNMENT_CHECK_AFTER_MEMCHECK  0
>> +#endif
> 
> I'm pretty certain we don't want to be introducing per-guest hacks into
> the core cputlb.c code when we are aiming to make it a compile once
> object.

Correct.

> I guess the real question is where could we put this flag? My gut says
> we should expand the MO_ALIGN bits in MemOp to express the precedence or
> not of the alignment check in relation to permissions.

I suppose that could work.

I was hoping for a reorg of the target hooks that could allow the target to see 
misalignment and permission check simultaneously, then the target chooses the order in 
which the two faults are presented.  Given how complicated tlb_fill is though, I don't see 
that being an easy job.

I'll play around with something and report back.


r~

