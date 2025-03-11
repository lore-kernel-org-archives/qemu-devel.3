Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5359DC282DE
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 00:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trn76-0004Cq-M7; Mon, 10 Mar 2025 20:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trn74-0004CT-2t
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 20:04:50 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trn71-0004xk-RC
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 20:04:49 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso8127295a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741651486; x=1742256286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ZIq7YtD+IASqWucSgp6OoaVMVqQ+LyKMsGMK/5t0EU=;
 b=b4HVK5611uW3g3RqRc8ux6pWTM8IWm9QxS5PuHUb3EvWe7Y8THcMB0d9BCFDxDVwad
 1PtR/8O0A7w8Fb09YbsUIQUs2khbB/NfQp0NJEuC5Z8jn4NgCT+bxk2Nnu2qNiqevu8e
 KTGmd04sb7mq9ojtrWmy2jM2Rd3CO+NgJk9j9mfYK3EYonigizxp4xs3zW8oukrVhhR7
 Hqm9NTS1FrzMR9P4Y566Z7b1P60YVEBn/YdpczItnqjayZWqMqyWjwSIyBtRqIGQnXpz
 4qaeqnx0Uy/gJzgg4H3euU1JSO8Jv4VOFPDtQ2Mhaoh9R6OshNpEKq/IoiGtrn544k7i
 V2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741651486; x=1742256286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZIq7YtD+IASqWucSgp6OoaVMVqQ+LyKMsGMK/5t0EU=;
 b=apIC5ybyANU50ycX7cxth0mk7B9pVYRnRI+6HVUwu7mzs8t+/UlcOsR5Yfvp3h+vr1
 9LTWo3wwe6q3JlHKIw4aF+baqSUyJMhNXemdWB660KbtpNYam89YUFQl1O6X1ejS9T+A
 /luePnIEZoIJ3pvpEWhfc7OdsEkUg0lENXcKMVslHDKWONahsXsJVUdc2B7dJrD/s6gU
 XDAkBBcX/N+yDN1QTN9z2jm2egsvug1mapHPPMfdust/wh3dOdAPwfZFAPgtS5IaNSXn
 4+uSZMHdseOb8AB/B37hZr130LOq5yI7SF+pvkQ9AuU86JiwB43BdObrxciLO4oPFZsp
 B35A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiyM7+qpW1xcQUFWOMoo8TX4ZX4aF5zvonzwW2qot39gOkjvT6EZr06UFVZCvbla6DRwQ/TomnumQk@nongnu.org
X-Gm-Message-State: AOJu0YzQBLfO0CKKHWVw6up/iri6ID9LeChgnmWGSOwMKQ6C+2rHbsrV
 l1K0JoDRowrsZlTFfizy8pdr2b9V6WRItUhBeRYv0tc0KHqK/uEIkii+vnKMW1M=
X-Gm-Gg: ASbGncsSRVg1O1WYYF1Gx9tvuQZiYAkcWnM+lcIv6wJWNX6SR020kZJjz3hCMWt7Lo5
 SaybwHQ6Z/DTOWQG7EeuUzvzcU9IGbofrl/MnHWeNFbkMwioKIJM7SVHyRac/2TnLLxNIXLnFJn
 xy48TbIq5ytUvZUIQfYOrgLlRIu4HGXC5tBNRQWPcJ8ExhQKI8KANCY95UYbp/qtSCdSKb45WxF
 feoPVxSLQ9ChO1PErO1Y0SdbGODu0nADTrdx/hlm5tbZcfiCPj+6lWmJIJ+Lh9ApdhBKGYAgM9l
 Ml5i58yvQgPDxBNg8qNZEwMcpK7k6s24dmEdHaCAvo/JoS9wSNLfBin+kA==
X-Google-Smtp-Source: AGHT+IEY+foWQDlVBtdlKbW7DwI4snuQ2zJEq0MpvJEokYr9aDSftVtTyhW/QPs+SyV0t4PC4Wb3bA==
X-Received: by 2002:a17:90b:2712:b0:2fa:3b6b:3370 with SMTP id
 98e67ed59e1d1-301005c8b8fmr1738040a91.16.1741651485806; 
 Mon, 10 Mar 2025 17:04:45 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693e73b9sm8660348a91.38.2025.03.10.17.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 17:04:45 -0700 (PDT)
Message-ID: <efde9b68-fd8c-4e06-ab5e-6b1d4cf75332@linaro.org>
Date: Mon, 10 Mar 2025 17:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-2-pierrick.bouvier@linaro.org>
 <57612d65-aec0-4785-86c3-0c8d647af38a@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <57612d65-aec0-4785-86c3-0c8d647af38a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/10/25 08:17, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> They are now accessible through exec/memory.h instead, and we make sure
>> all variants are available for common or target dependent code.
> ...
>> diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
>> index 92ad74e9560..74519a88de0 100644
>> --- a/include/exec/memory_ldst.h.inc
>> +++ b/include/exec/memory_ldst.h.inc
>> @@ -19,7 +19,8 @@
>>     * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>>     */
>>    
>> -#ifdef TARGET_ENDIANNESS
>> +uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
>> +    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
>>    uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
>>        hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
> 
> You shouldn't be exposing
> 
>     address_space_lduw
> 
> to common code, only
> 
>     address_space_lduw_be
>     address_space_lduw_le
> 
> etc.  I'm not sure what you're trying to do here.
> 
> 
> r~

Taking another look at this, I don't see how we can avoid to expose 
those functions to common code.

The goal of those first two patches is to break the dependency to cpu.h, 
which can't be included from common code, and thus prevent any common 
code wanting to do memory op to access it.

All the calls to ld*_phys() and address_space_*() are indeed done from 
code related to a target (some of it in hw/). However, as we now move 
those compilation units to common, they still need to be accessed. The 
semantic stays exactly the same.

 From what I understand, non endian versions are simply passing 
DEVICE_NATIVE_ENDIAN as a parameter for address_space_ldl_internal, 
which will thus match the target endianness.

So what is the risk for common code to call this?

