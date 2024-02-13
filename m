Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC35C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyrG-0007fD-LZ; Tue, 13 Feb 2024 14:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZyrA-0007eu-VL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:54:16 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZyr9-0000Fe-Hk
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:54:16 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-216f774c827so2247156fac.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707854054; x=1708458854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/rI5Gsfp22v3/J3ZPg24Qnf34rB4bqNS1/T881UR6w=;
 b=S4CQn9URx24QcLX8/gjsaGDqD5o6DW6sNcSeEMi3OatDX4fcIS9z8YhXB3rKy5fNNl
 k7SVc5sqJaLikYVkbBu4gduKiuemgpktt3daw1ev8MOqccAGZ1G1hLi36tmaSsZZF/K5
 UDfz3w1aWofWkPH/1qHSSQ9Il8BvRyHWyvUgQQHwmDp2IANUAPdkfDy0P+U9y2s6Bmxx
 YoeVZqhFw6OBFexQ0uQHISN+tBeWNCxbSSXJAHvQ2qGgLQiIdg1g7ii4/rUwV72Zv58j
 QWVf7XclxQKcwJN7IikmkdYsVy/aMFAJwzzZvZ9XT5M4rDzU5x8AgJijyrnFPidksDsF
 hZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707854054; x=1708458854;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/rI5Gsfp22v3/J3ZPg24Qnf34rB4bqNS1/T881UR6w=;
 b=IRylDES1LUbNmveWiSq6cB/x0CGbzMLC5ibsazDrSX410yO1FVok4ot7g2gIUiF7ps
 JQxRi8YZJSrVzS0m5zv3LiLNa75KogTJzGHldsxJE1KM34ARYZSl1w+slb5cOg4mMYEa
 Hm0LQI9IKC7taKFi/uoYaCw5E8cRtLcAdfdfDTiekzUKa1SXILF8N66KOMb+0KT1aSNX
 jGRUnv3Jgf+3FQSbxfZOQ7kLAx9DxxSFWl897D9OWpVvcBBGoC7pNtc6z7HgNa2A8hdN
 xtVgbOr1JqMSiED2M0171tUFvf3046MaexjnEbGuEFFzQopHfq7oCrDtcDpymnQO/Lkq
 8l1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNnwtqN6LrGfNQauVkhOHZSXnpmoL0KVGcCxHI4V/Rzgc4mfHFM3lM+4XLTc13+v/FHU20FqzMK3gNHMDAbdgvxvACq0Q=
X-Gm-Message-State: AOJu0YwPVtXrTPr53nAYn7Hw5EMfeoEu6Ee1pnnP4qssNqMnjugOLJ26
 ysgtEYHtNA1D4pnYNhukadZeLO43DNggx89hgMmM4OCajIP56JWgzzE7M9fgTDM=
X-Google-Smtp-Source: AGHT+IFgJb79zZxwsIiHWmco+MGAPmJKtmMGzfqRCePbmQzwwCm4AYSz1qcr4jpFD1xYoX5i/cT4jg==
X-Received: by 2002:a05:6870:6b8d:b0:219:2298:57a8 with SMTP id
 ms13-20020a0568706b8d00b00219229857a8mr441680oab.45.1707854054069; 
 Tue, 13 Feb 2024 11:54:14 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV3hwxUz1+OHg84876ul3e9Ao6JRdqd0xs7kJq1BENBcn1XX44vBOWfmRFziAtClFAW1QNYTpANOR4Pd6P3P9icZbDD9PE=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w186-20020a6382c3000000b005dc4ce8d2a4sm2727196pgd.58.2024.02.13.11.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 11:54:13 -0800 (PST)
Message-ID: <c959eb04-a929-4fa6-bdf8-f97cebc4d3f3@linaro.org>
Date: Tue, 13 Feb 2024 09:54:11 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] linux-user: Split out mmap_h_lt_g
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-23-richard.henderson@linaro.org>
 <ogglz7yhvelvrnmfyhvpx7hjdl5rgl5gh3iioomtagi3mlckcd@qaa6w4javinb>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ogglz7yhvelvrnmfyhvpx7hjdl5rgl5gh3iioomtagi3mlckcd@qaa6w4javinb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 1/29/24 05:26, Ilya Leoshkevich wrote:
> On Tue, Jan 02, 2024 at 12:57:57PM +1100, Richard Henderson wrote:
>> Work much harder to get alignment and mapping beyond the end
>> of the file correct.  Both of which are excercised by our
>> test-mmap for alpha (8k pages) on any 4k page host.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 125 insertions(+), 31 deletions(-)
> 
> [...]
> 
>> +        if (fileend_adj) {
>> +            void *t = mmap(p, len - fileend_adj, host_prot,
>> +                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
>> +                           fd, offset);
>> +            assert(t != MAP_FAILED);
> 
> Is it possible to recover here? Of course, we are remapping the memory
> we've mapped a few lines earlier, but asserting the syscall result
> looks a bit odd.
> 

Can you think of a failure mode?  I couldn't.
That's why I added the assert.

I suppose there's the always present threat of running out of vmas...


r~


