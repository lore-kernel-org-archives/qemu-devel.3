Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8FEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uLV-0003qw-Al; Fri, 03 May 2024 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2uLS-0003pu-TC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:57:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2uLP-0003gh-2I
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:57:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so91493295ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714748219; x=1715353019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLX1EpLepR6jPESgXBFSn2SlHVmWjXY9QLHhdTdk4Do=;
 b=DfPw/0MGZXrIN77wnU/mCmQxbeiow3Rr7HbbtcOYOZhLrmyXdudGn2NeznKIPqlaB5
 3WncHuoZ2pZACjZYW4h5R3ZQL7I/hpzeESh7cyngu+BRssqbHDdQWS98CKTeYyqUsz9r
 TyXsVMxaL0QimsmKT6jyjDTkEm/jcewjN4+0T0G85N4pM5+DobLtvgWebivf3Y99TyK2
 d8Hc3eqRkNYnZ+3d2DAZH6kt18q32qqUOi+hvVA0nj/LzJQXP6riBcY1GdlP3kS2+CGv
 kvt47fMbvRrMT+aaYO+MZkeqAbu6lBPxn+N6sf2nZplhrLwI27ynpqiVyrNtJ0ODGReE
 niFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714748219; x=1715353019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLX1EpLepR6jPESgXBFSn2SlHVmWjXY9QLHhdTdk4Do=;
 b=fNiHzrbczbgWQykRIjcnQZJlhFb/9v1XUpMSxSypd76U0+YMEdEH3SsUmxBVYvagC5
 f/y6s7fMMnIVjTOVSryGPpP1QRe9Uc/ngr0iCdttgSigJdvAlXIg3pWGbhNnZGqIrKmI
 PnLaVILYpt9Cua/tyknYe1qEzKe9WbpLLH2nQYA2E84FY0Kv7M6h+4omVp1gZpGUqN5y
 v6ZnQDpl9JVD8SzWmiw7IuSbl2BqqqXgBCjtwdQOHrJ59Fn/0Hc888WMDcC38+x4Yn7W
 SQknGtwlAheT7GKY57mB5/FRDGU6bo3YeRBMq+ORqI35aF4wEP+fwgMfpPWsMGNS+Gt7
 BOMw==
X-Gm-Message-State: AOJu0YxaP6NMJdHJXsW654+MNwtWDMLBiqXVcRHTkwu+sExfZj5qXvHb
 WG8qPIVcXQJcaayUoaYDlXrIq9mQVIKFg9q9Vxwr/SH9thjKaJfkIlf+Ms1e070=
X-Google-Smtp-Source: AGHT+IH0zpfBXYxQ3A5Fhd8+caeiMXLEisvJMVTazD9FKm5zJForMcu+gIXqATOrtNMCY265NPjFKQ==
X-Received: by 2002:a17:903:2349:b0:1e0:ca47:4d96 with SMTP id
 c9-20020a170903234900b001e0ca474d96mr3063243plh.3.1714748219273; 
 Fri, 03 May 2024 07:56:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a170902d4c500b001ea02c8412asm3329500plg.119.2024.05.03.07.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 07:56:58 -0700 (PDT)
Message-ID: <d394161d-9e88-45dc-9f72-e07e4d8803e2@linaro.org>
Date: Fri, 3 May 2024 07:56:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Hexagon: add PC alignment check and exception
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: qemu-devel@nongnu.org, bcain@quicinc.com, sidneym@quicinc.com,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com, laurent@vivier.eu
References: <c5613f05-5cfe-4f8a-b5b2-0d62ea1cf808@linaro.org>
 <20240503134635.78067-1-quic_mathbern@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240503134635.78067-1-quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/3/24 06:38, Matheus Tavares Bernardino wrote:
> On Thu, 2 May 2024 13:00:34 -0700 Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> On 5/2/24 12:20, Matheus Tavares Bernardino wrote:
>>>
>>> +
>>> +void test_multi_cof(void)
>>> +{
>>> +    asm volatile(
>>> +        "p0 = cmp.eq(r0, r0)\n"
>>> +        "{\n"
>>> +        "    if (p0) jump test_multi_cof_unaligned\n"
>>> +        "    if (!p0) jump 1f\n"
>>> +        "}\n"
>>> +        "1: nop\n"
>>
>> Does it work to write "jump 1f+1" or something?
> 
> Unfortunately no :( The assembler will align the address when encoding the
> instruction. The only working examples I could think of is using a separated
> file, like before, or manually encoding the instruction with a misaligned
> address and place it with a `.word` directive... Any preferences, or other
> suggestions?

Oof.  The assembler is being too helpful.  :-P

Perhaps using a different section could solve the fragility issue:

asm("
	.pushsection .text.evil
	.org 3
	...
	.popsection
");

(adjusting syntax as necessary for correctness), then it doesn't matter where in the 
output assembly the fragment lands.


r~

