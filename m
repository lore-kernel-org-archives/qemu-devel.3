Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE45C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahSt-00071J-BD; Thu, 15 Feb 2024 14:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahSq-0006ov-SI
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:32:08 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahSl-0005Pz-OV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:32:08 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e0cc8d740cso1057923b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708025522; x=1708630322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J74btSBxazv6J2r+dLJAGzTw0cISGopBJUtERAZfl2s=;
 b=JIfaOdwy9e4mAAFIBoLc41CvoPUC0fD9eaKmFxmd5yRbFpTdpHaeKIuCZ9N8uQgHxh
 /eKJpuqfM2ZLWVOgY2TI1se5GrmgP/XgETi1JFK71QsiLU1HScQa3jvlOjGSOeAUKcxl
 0ixGIgT6FgZUUEyW94PtmezDPdDMLVUuuKdRhSZfN98bgsHso8p9sNTCuh90EjhIPYIL
 AuFDD92+voPNYr0MfWqFxa+QDu8g6eVpMZ0tl6zaQq2RKGtJwtDsJXG244KU6v30EqU9
 EEIqSwmazcsR+D9Y0cyQmBa3MG+LzW0KqKQUlOxs8j2Ix3wfLNuCsba5jmMYOOqLe8YG
 3f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708025522; x=1708630322;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J74btSBxazv6J2r+dLJAGzTw0cISGopBJUtERAZfl2s=;
 b=MRynq08iekvcSKDAlqI0Dr03PCBUC9aQ3eZN3gYGkpc18EH1tpgkOOhgdNr9POu/pU
 URb4YmLy7/HqU8qNwGZC95IkYpQYSBHtEQCcoGUiL7bhqdNDhtORW0v1ko/TLoIgyAra
 7nPvVHmvfMiy+KitZ55cBhx4EpzDMBwHg79mbbh3Yt6OUMUcyEkjXkqeiE/F+l7tzDmG
 2vHP102mHMvZDZoZ4opoyQFy91zxP5ImPqrx9sYNzvKLgOaNYD+2Tiy8TBoPCRTLsExx
 9VzSTs0yxtYr0p19nV5rzwE8Dd5A2iSH5qtCefs3IRvlLoYcXA/crF2YMap4nDH5vfWp
 JGoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgvDOzkvp0fO10BWeRRj7b2snOlY7c+2b72Q7Hci+XCMNHyb3xsFTo29Q3f8vpAk8QpNiTv98szlOXnqhKAKfC25qMIAo=
X-Gm-Message-State: AOJu0Yx1ANA8NqwWB7MYlysVFIVR1XchIvWsz9AJiqNqvQL+F2DYqSLL
 Khwpvn3Cu1DOl2zS4Ozg+1GgNPFvtTVEOGiTX1gJ2sQg4yfStu/sao1Isx2uBDw=
X-Google-Smtp-Source: AGHT+IFccsrWtc7EyQAUASxzlMRnbGMmXkZtPTQwZgipLpC3c7rV0pdb+m2i/RFsiyndMlD46m08ig==
X-Received: by 2002:a05:6a00:2344:b0:6e1:1144:b49d with SMTP id
 j4-20020a056a00234400b006e11144b49dmr3267868pfj.10.1708025521846; 
 Thu, 15 Feb 2024 11:32:01 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ka19-20020a056a00939300b006e050c8f22bsm1679320pfb.207.2024.02.15.11.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 11:32:01 -0800 (PST)
Message-ID: <8d7469f6-9858-41ba-8056-c6a2de15c422@linaro.org>
Date: Thu, 15 Feb 2024 09:31:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/i386: Enable page walking from MMIO memory
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Sajjan Rao <sajjanr@gmail.com>,
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Cc: linux-cxl@vger.kernel.org
References: <20240215150133.2088-1-Jonathan.Cameron@huawei.com>
 <20240215150133.2088-3-Jonathan.Cameron@huawei.com>
 <cde1076c-d4bc-4e2f-9319-9eb37d24eef5@linaro.org>
In-Reply-To: <cde1076c-d4bc-4e2f-9319-9eb37d24eef5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/15/24 09:21, Richard Henderson wrote:
> On 2/15/24 05:01, Jonathan Cameron wrote:
>> -static bool ptw_translate(PTETranslate *inout, hwaddr addr)
>> +static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
> 
> You do not need to pass in 'ra' here...
> 
>>       flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
>> -                              inout->ptw_idx, true, &inout->haddr, &full, 0);
>> +                              inout->ptw_idx, true, &inout->haddr, &full, ra);
> 
> ... because this                                 ^^^^
> indicates a non-fault probe.
> A return address is only required for a faulting probe to raise an exception.

Bah.  We can always recurse and hit the load case too.  So:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
>> -static inline uint32_t ptw_ldl(const PTETranslate *in)
>> +static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
>>  {
>>      if (likely(in->haddr)) {
>>          return ldl_p(in->haddr);
>>      }
>> -    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
>> +    return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
>>  }
> 
> However the loads do require 'ra' for the io_recompile, as you saw from the backtrace.
> 
> 
> r~


