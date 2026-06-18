Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A39CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJkT-0000NB-4v; Thu, 18 Jun 2026 16:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waJkP-0000Mp-P8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:54:01 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waJkM-0003W8-5u
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:54:01 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-37cae9b7536so871241a91.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781816036; x=1782420836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyj+Jj8HP5Pl04BY707iVQtk5HhO1VYZ4BWCeO5StyY=;
 b=zlvsM53Np9r8XlAt+CkFOvAQgbaqCVVwnoaI/kX98Su4+Qr6uTHGwB4d85o2IJOKHz
 zcUYw1K/zMRr2kJdGpN279UKAfyZWKSuxvHokteduaDWdz1sbLM6W+Bgjvf0OSmx8Ek7
 jPPC4z/Hqeal/Fa2/Oect7coLxYIo1iyikmzPaKfvMp2CicmtXH5/n4MQP6pZKHz+idy
 39vhR6zWPAV0sO26NWIw8fP9pPFkZV5gMLg1+gmjlTLqKtsvk7G2QpHz4qKDuAf+5Jsl
 xxiR9tHQ9rEDIvl/xr2eNTR1vWdrkm5zb1elDd5JyY/QIwJ/bEbwBKsxx2+fLwFnNHF5
 wHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816036; x=1782420836;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yyj+Jj8HP5Pl04BY707iVQtk5HhO1VYZ4BWCeO5StyY=;
 b=NwAaEmulkhqNT3DW26/7ONprHmLMxmrxf0cTDvCB9+NgzB3vaZ/71HkbCpJAloLqGc
 wrbvAQ3eXPQNSAo2K55+03W1TVq5S+ekNruxNNgTjn2JgVV9Z1qL2lDcUcqT7ouS1me4
 uTuBr1w3hgKSueh9BEb0i4d+enwNCjTv48QeN7H8YAsCcsEIIDz2KfFBtzAu0QqhvNLa
 nXEBRBs05+n6c4JE9sBl9+ya5sMsWkNHksZpXhUgg7y0U+/DI9XN+buNIOGWRjPd438n
 P19rOYHEftAGTeU+9UvLSKhfKxEinsxw8iDDH6Nb1Syzog85HACb69IdwlDg89l1TL8C
 inDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qhy7FhkHVM/ox7Tc9TjEWrfLJN2zJJZ1y/6vghbebk091FXaN7eiro1wKXgR5BuaXQezuWOBZzlV4@nongnu.org
X-Gm-Message-State: AOJu0YzSgVanth24RPNNEajfcDrJheJdNCNAmUyXThblwSO8X1uYxMZv
 OskXXQWsofGw0NvNymUMP0UdUE7zFc7O0c27CRSBERPp91yjr/SAi5ttDvhX0VebA8U=
X-Gm-Gg: AfdE7cnUmonM14Arlf9Z3ISouOi3vxSC9bKa8RWxRcFxdaMROy1glwAGDKezbFMLiZ6
 3RuyIEYdecdHHLy79l2qnGOxibD6G8je0hjy+QyoY6abWXyBfs6k0qWKF5sXNGHcYRomWI1h3yx
 ufbS1eT5VN2keZRmSI3/lSM51ol0DB/L1w9be18Mk5uHb4C62GFrj/GQkie498m8aTHLQSgHX0x
 mthtFUbwz20iRNEFUTAZ7dLKSTKgQglKKpjyBxLrwsA6AJrli1OdQ4fYQ4IIF+Pt4UPTNTznU+p
 bPvJw8PPVevDgB2Ja73iIfKD9iBZe1v2CBFluIGHGHsv+EVCeZoojE7jPCzEkwocO3GPeO5W5aX
 LcsIQO6o/q2VxrrHFgx+zQ6iBvzAUz0yiNXbZ2RqrgyTAsbPiY26UQwjXZfMhKqUaL0JyF3MDt3
 ON/KllQnUE17nS7HnBmvKdyBzAPT4gWuaJpfJQiEwNpPzlnDKJ+MyCwTuwRg==
X-Received: by 2002:a17:90b:4ec6:b0:36d:7b62:4767 with SMTP id
 98e67ed59e1d1-37d15688cd4mr1200652a91.5.1781816034774; 
 Thu, 18 Jun 2026 13:53:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d154897a7sm607439a91.5.2026.06.18.13.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 13:53:54 -0700 (PDT)
Message-ID: <96e2d15a-c427-44c3-88f5-e42acd23a322@linaro.org>
Date: Thu, 18 Jun 2026 13:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] bsd-user: Use probe_guest_base
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260618195520.589907-1-richard.henderson@linaro.org>
 <20260618195520.589907-13-richard.henderson@linaro.org>
 <7d9acb4e-d1da-45da-a42a-60340d0dfb58@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7d9acb4e-d1da-45da-a42a-60340d0dfb58@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 6/18/26 13:11, Philippe Mathieu-Daudé wrote:
> On 18/6/26 21:55, Richard Henderson wrote:
>> Merge the PT_LOAD loop with the PT_INTERP loop, as the XXX
>> comment suggests.  Pass the probed range to probe_guest_base.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   bsd-user/elfload.c | 37 +++++++++++++++++++------------------
>>   bsd-user/main.c    | 39 ++++-----------------------------------
>>   2 files changed, 23 insertions(+), 53 deletions(-)
> 
> 
>> +    /* Ensure that mmap_next_start is within range. */
>> +    if (reserved_va && reserved_va <= mmap_next_start) {
>> +        mmap_next_start = ((reserved_va / 4 * 3)
> 
> Is that ROUND_DOWN(reserved_va, 4)?

No, this is reserved_va * 0.75.


r~

