Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4EBC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uObed-0005w7-5T; Mon, 09 Jun 2025 08:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uObeZ-0005vP-Bx
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 08:31:03 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uObeS-0000jq-V3
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 08:31:02 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso3575805b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749472253; x=1750077053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/azUsPlgQ0qnNuRghzS6BtLGc4+GWDUgZUUWcnIh2vo=;
 b=mkRfHxd+0qX4jn+TY46OpSD2/9f2BU1JAF2ulMrSQpaJOSrCIPcdA54T9cR0oIkEYN
 8NRNjvcI11q9lF2/SGw9SWVMuHCwuQmMo2SJi91lrnJbt5p5WwC01gzH8PpmgWrX3YKO
 qxfX3ds5eAFXWPrbCo0vAc83GAohbUGc60yFWi29mKAwsBaWEZCl8HiN4US727uA8Nnt
 4I+JhQTm+7KPEt5LLLAqWY8BBiAjg45WZb4x+OKebGED/p6YXWTze283sNMOdcR9ww8u
 LdSVRR2EmxN5xBgN+i9I/9NsYwU/AKP3rxXAQvSqzsZ0VF3o6iT6z0IEZ0pWpePrBgYr
 FKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749472253; x=1750077053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/azUsPlgQ0qnNuRghzS6BtLGc4+GWDUgZUUWcnIh2vo=;
 b=tzDRgje8nYrAOjuHSK+7fihR9j0jrG/QyC/26kXjhFvh9au7eUCE/5D1ShPTs93pY4
 HFbZhYiLvNCHQpHWV2ekYbqUSGhdTgDMSAsvqRodIjVNzrMGjjGX7rrE47AOkrjEu1IV
 0QGe04K7h3rBQ8hTzICa5Nmr86YFat1AT8F7z0nliwF9H3aEp38ndFm4hKMW3ADubvxF
 8dWs3xshS5K8M6SmBYv3FmV2nlST3Zo5VoygoZSh/gTgsIEbb0FoplVdleQp54t9KPJN
 mTjjxsg+7WOWVfvfJQYEgHlkUU7iWeyqGDo/OHyZ9XUzNFpWwuNQ/iwyCKM9YQLosOCf
 idwQ==
X-Gm-Message-State: AOJu0YwiQ994HLJLNaitu7KCILA1ySfpOrzYzzQakEp1vbiXFwzUl2kv
 iG7QMvRwr1ZRpxXEsKc7gO+FaAhIhLaaJJXw88amTMeeBHEK6F0HtRWpU3knIcmQxUw=
X-Gm-Gg: ASbGncs7qRKRE/b4QC/A3ZIX0onFmg91T1aAr55DdJ6SKXC+x68Fuihv3G4T1EGWUcY
 Lgei2gHted2VbqF1Qjuwpp5fRVho66xY72KVVel0ZKomIJF5r0f8T/JjVYcge5CWnWuxvJ/IRB7
 uV/SnmGbCN0pJkbINIMX9r8cQv6L/bnrcYaJwtY61T9A6fDfxXJ5NsnwX05nmktPiS+bGDgOgMV
 VTVTHTBxzIDOdOeosvnb8ppGB/rnVbtVjbUfl+k3yrki4i6Bjn/U4k4A+3krpEwsLpAiKFaP1fD
 1waLpnoTDNgyLrsPmZWYDPsgEJSQ4iU5H7QR9aa1gHYIjRmYDhmnKmaIXRT8lVaW
X-Google-Smtp-Source: AGHT+IENljqOWWZNwNJwClbgGMOmjfoluvhx3ZbH5nVIU4gChRFrYhJ86MbLwEOXuElijfLRH83ZVw==
X-Received: by 2002:a05:6a00:22d1:b0:742:3cc1:9485 with SMTP id
 d2e1a72fcca58-74827e9c914mr16024452b3a.12.1749472252711; 
 Mon, 09 Jun 2025 05:30:52 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.21.192])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0c00d5sm5573765b3a.120.2025.06.09.05.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 05:30:52 -0700 (PDT)
Message-ID: <f6a3a6d7-6a3b-4d90-8bd1-6954b90c9fe0@ventanamicro.com>
Date: Mon, 9 Jun 2025 09:30:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: add cva6 core type
To: Ben Dooks <ben.dooks@codethink.co.uk>, nazar.kazakov@codethink.co.uk,
 joseph.baker@codethink.co.uk, fran.redondo@codethink.co.uk,
 lawrence.hunter@codethink.co.uk, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250527112437.291445-1-ben.dooks@codethink.co.uk>
 <20250527112437.291445-3-ben.dooks@codethink.co.uk>
 <ef6c7b15-04a7-42cf-a89b-c2674388810f@ventanamicro.com>
 <06323162-66b9-4165-ab2e-86ec6272aca8@codethink.co.uk>
 <341224e9-d335-40ac-af98-6395b3aede84@ventanamicro.com>
 <5663397f-e1b6-46fa-953d-fb21d1a700df@codethink.co.uk>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <5663397f-e1b6-46fa-953d-fb21d1a700df@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 6/9/25 8:59 AM, Ben Dooks wrote:
> On 09/06/2025 12:30, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/9/25 7:40 AM, Ben Dooks wrote:
>>> On 07/06/2025 21:17, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 5/27/25 8:24 AM, Ben Dooks wrote:
>>>>> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
>>>>>
>>>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>>>> ---
> 
>> The README states right at the start:
>>
>>
>> "CVA6 is a 6-stage, single-issue, in-order CPU which implements the 64- bit RISC-V instruction set."
>>
>>
>> So this means that CVA6 is a 64-bit CPU only. This means that we want the second
>> option: the CPU declaration is fine, but the CVA6 board must be built only for 64
>> bits. In patch 1, this line:
>>
>>
>>>> config CVA6
>>>>      bool
>>>>      default y
>>>>      depends on RISCV32 || RISCV64  <------------------
>>
>>
>> Should be "depends on RISCV64".
> 
> 
> I think given the confusion, let's go with the RISCV64 for now and if
> it turns out there is an 32-bit build option we can always add it in
> later and change anything else around.

Just sent a reply making this same suggestion. I agree.


Daniel

> 
> 


