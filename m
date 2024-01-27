Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30EDC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 08:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTeJu-0004gm-Um; Sat, 27 Jan 2024 03:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTeJt-0004gd-Ez
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:45:45 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTeJq-0004jH-IP
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 03:45:45 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ddfb0dac4dso940479b3a.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706345141; x=1706949941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=71jY0wFDdVZQzfXzMvGbI13tFXpmd3rBQRPij1mmVV4=;
 b=PURJkNVg0Rxy4Db6Afb2JJwvCAQFKsQFPJmUZqRR3iroMurADTaBTs0xP35mg2dkrJ
 gTkeBv6R+coF24M3UZaB7ZghYbzVTDb5ZnjMPHHtYzOBr97FyirJaSY2Bqup1y0nFGlh
 sROyTROnWH8Tbu1mXmCUYPegX4CEysfMYG+xbonNFd26rBesU5leXEl35OvYdbwUXNqB
 MHjdUWPG4qaofiZb1HimxKb5d8315rwUVjThuIIXHRf8rU0Lem5XE5dU5LpSmkbG3vys
 0D/PoL+mRwhDpCmv68uSmbfbBDdGXOSztMafUl58/Hr6A7Qvy3RN/Ej6kCB1+cX3xkNI
 L2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706345141; x=1706949941;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=71jY0wFDdVZQzfXzMvGbI13tFXpmd3rBQRPij1mmVV4=;
 b=j+7T87acG1crbbUAaCWGIpxehUpmMHWr/VO33IoGdjwDCkQlxFQ7yrT+6a+eS56DCX
 PoQ6ePxxc/bsajAwJaD7kB7IC2n3meFcIyTnVC4kKwRdhhHew1D0dM+g6kQqSzAabsJP
 A+jZDADQnXafamvJ0/2OGQDuU3sHm5uwIxJRvnTR45tXwtIJNfKWSAG2YxAuIqE35mjf
 Njmk1LkyLjKvuOykNmLGGZtEWDXSMsqIdK9GsCFrz+4iZFRWwksmKLabgRGE6d3vqXRA
 lfygRf2uYAT4xHYKjPcqCYxWYyAOYgpy8kWZ2oSHgmMOQh20Vdr6LRtoS01vra3VgHr+
 MdqQ==
X-Gm-Message-State: AOJu0YyFPy3F1QXGb6uCGc0rDAzKGzWQ1G9Fil1rkt2omUDoXb0q1wiS
 Wbf3/eSAeXQUn0wSoCpG5kxJAU8aR4vHLHO4Uha6MdhX8Wy5m+VrB9yc6f9iKgCzgEHsxIFyMIc
 78oq8cQ==
X-Google-Smtp-Source: AGHT+IHEuciEktiGohVYQFZj94axpOwnB0rEaYKJu2/x5oiJjRM2n7X3+c7vH76wxqn8sVTCsN2bOg==
X-Received: by 2002:a05:6a00:6807:b0:6db:e366:53a8 with SMTP id
 hq7-20020a056a00680700b006dbe36653a8mr1148188pfb.12.1706345140979; 
 Sat, 27 Jan 2024 00:45:40 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 lp17-20020a056a003d5100b006d9aa6592d0sm2310483pfb.82.2024.01.27.00.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 00:45:40 -0800 (PST)
Message-ID: <17c1a380-4bac-49dd-aa49-a50adf93a8b5@linaro.org>
Date: Sat, 27 Jan 2024 18:45:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/34] exec: [VADDR] Move vaddr defines to separate
 file
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-7-anjo@rev.ng>
 <a88b1741-21df-424f-8ca5-56950d21032f@linaro.org>
In-Reply-To: <a88b1741-21df-424f-8ca5-56950d21032f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 1/27/24 18:36, Richard Henderson wrote:
> On 1/20/24 00:39, Anton Johansson wrote:
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -14,18 +14,6 @@
>>   #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
>>   #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
>> -/**
>> - * vaddr:
>> - * Type wide enough to contain any #target_ulong virtual address.
>> - */
>> -typedef uint64_t vaddr;
>> -#define VADDR_PRId PRId64
>> -#define VADDR_PRIu PRIu64
>> -#define VADDR_PRIo PRIo64
>> -#define VADDR_PRIx PRIx64
>> -#define VADDR_PRIX PRIX64
>> -#define VADDR_MAX UINT64_MAX
>> -
>>   /**
>>    * Variable page size macros
>>    *
> 
> This patch does not compile standalone, because the new header isn't included here.

Queued with fixes.

r~


