Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CBCC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6X6D-0001Ca-OF; Mon, 13 May 2024 10:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6X69-00017D-PH
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:56:18 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6X5r-0007kS-RU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:56:15 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e6792ea67fso13319531fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715612156; x=1716216956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=62S4w0Z9wkpYJ+WWg5k+XTtXPjNHB2Zq3QLdPuxL5i4=;
 b=mH6lelnA21ZMaBZm4dsJict4q0nHcj9RV+HqmXCgkDqk8YicJP0erM73ZpsHv8jCOH
 y/cXXDK3Jvl8sbNs29RsJkjcJHOuuL/ZiW1Y5HmxjIpisWRjoMEZrdV8KoNjZCtOStBW
 k606/sPSYtORF6QB2CbPB5lJJeBGU+jioF9v2CyO9LzPYFC6+R+QnFoTMk44PwZl1Noi
 Dem3tLYAU06ODdT9ruB6qBoYm6h9OXG+Da99e0xhQG32ZCCdEFhqbR9obIVnntFS4k8a
 CLh4ZfOSjWGhBRmQ6yRKy8fCFF9qIVmAUXiRcu04oLwOGK26fHL7wgm7QIEDWxROl+zC
 0nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715612156; x=1716216956;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=62S4w0Z9wkpYJ+WWg5k+XTtXPjNHB2Zq3QLdPuxL5i4=;
 b=FXBleeJOXEIhP76HukSF0cZLFztCVHuw4PAdONA8hlkOmjqlt3263Zs1qE07gDxf1P
 PEdfp6uSAHpnXdONg8QyUNXdHp6iLH9DmdZMb6mnllQwLgYcmvhbRtVo3xraRw0TTRLQ
 2V8eyOhd3mXQr5c6iHCm8MaG5N//YFYVqw31CwIBLqiP1v9EpVcLtK87UMKghVGwfKW9
 OyzDQBPwvGx9+czxgD/mGjZqOsmBf+IMIx41xeXu4UcsAPsGSD8kEOdEWuFEd3iS/Ux6
 tdQo0wag6hu25nOuuOhq/tHtLaF3CaREt2llDu+w0h/JfeQjYEJlKA3Q3zMA+SUABqBT
 OXuw==
X-Gm-Message-State: AOJu0Yy9SlKbcCUiz33tMYboPBZPUJ6r84XcjZjTxuYa+5a82luhBQsF
 crn8s+DYmbyTba9fiP16VHhIvtLoRS3+JFAGfFlUuUhT3raHawR0XnH+qcWSiU8=
X-Google-Smtp-Source: AGHT+IHKyBJxhBro0fRa9nWjFk0bO6c1qT515J8voOW1pmBPr17U3MWmGmt4FIMYJzBftEelWGEaiw==
X-Received: by 2002:a2e:844c:0:b0:2de:cc70:2552 with SMTP id
 38308e7fff4ca-2e51fe52574mr65384091fa.10.1715612156114; 
 Mon, 13 May 2024 07:55:56 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bed0035sm6307315a12.50.2024.05.13.07.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:55:55 -0700 (PDT)
Message-ID: <8bc01410-9e54-413a-83c4-5ce7fea56596@linaro.org>
Date: Mon, 13 May 2024 16:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dump/win_dump: Improve error messages on write error
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com,
 farosas@suse.de, pbonzini@redhat.com, richard.henderson@linaro.org,
 qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-3-armbru@redhat.com>
 <5a74f1af-6068-41b1-b875-6be060369abe@linaro.org>
 <87msot6a4p.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87msot6a4p.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 13/5/24 16:48, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 13/5/24 16:16, Markus Armbruster wrote:
>>> create_win_dump() and write_run report qemu_write_full() failure to
>>> their callers as
>>>       An IO error has occurred
>>> The errno set by qemu_write_full() is lost.
>>> Improve this to
>>>       win-dump: failed to write header: <description of errno>
>>> and
>>>       win-dump: failed to save memory: <description of errno>
>>> This matches how dump.c reports similar errors.
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    dump/win_dump.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>> diff --git a/dump/win_dump.c b/dump/win_dump.c
>>> index b7bfaff379..0e4fe692ce 100644
>>> --- a/dump/win_dump.c
>>> +++ b/dump/win_dump.c
>>> @@ -12,7 +12,6 @@
>>>    #include "sysemu/dump.h"
>>>    #include "qapi/error.h"
>>>    #include "qemu/error-report.h"
>>> -#include "qapi/qmp/qerror.h"
>>>    #include "exec/cpu-defs.h"
>>>    #include "hw/core/cpu.h"
>>>    #include "qemu/win_dump_defs.h"
>>> @@ -52,6 +51,7 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
>>>        uint64_t addr = base_page << TARGET_PAGE_BITS;
>>>        uint64_t size = page_count << TARGET_PAGE_BITS;
>>>        uint64_t len, l;
>>> +    int eno;
>>>        size_t total = 0;
>>>          while (size) {
>>> @@ -65,9 +65,10 @@ static size_t write_run(uint64_t base_page, uint64_t page_count,
>>>            }
>>>              l = qemu_write_full(fd, buf, len);
>>> +        eno = errno;
>>
>> Hmm this show the qemu_write_full() API isn't ideal.
>> Maybe we could pass &l as argument and return errno.
>> There are only 20 calls.
> 
> qemu_write_full() is a drop-in replacement for write().

Fine.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


