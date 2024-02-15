Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66025C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 21:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raj6N-0001P5-Up; Thu, 15 Feb 2024 16:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raj6L-0001Oj-RE
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:17:01 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raj6K-0000lr-4s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 16:17:01 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-59a802ab9fdso25108eaf.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708031817; x=1708636617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLIsT3rbTolN5q+VbDJ4IzeLwJ2vj2lgiM32Lz95cns=;
 b=ItLNthA5RY5tywwommuelOBTHx0+exWdVx6NfD8B9xTVwudihdSESZVG6MdAJbkJqP
 uaTCBTsryDLfmGOzZFKJfu19qqLVXxbB1/TB90wGS2tbDzWdgoF3h9HLi20cz4IHSICF
 5MVWZykrCH0znpgSXgbP8oeUphcb5kKyoMNjOfGo2A8ozE8xQsKBFCVgzEawq4JjYtuZ
 lzNQMz/FV0JkFyv+2yZT8C1tn7sF38mWH7IjIeOjNh/9GUQjnYnrTfUnKvnZjIilml4D
 gWfXPNvlyzUWtGYuGCZz988g7pt2ve2ey/GLWqAK0l36l0GU+v3sTQVRJhsfr/m9AW7E
 vFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708031817; x=1708636617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLIsT3rbTolN5q+VbDJ4IzeLwJ2vj2lgiM32Lz95cns=;
 b=nOwA38KvcVyywoXOSW7bPITGT0rpfG0kBG9q4XH2W1az20vvuMXEMIEN4j1ANoaIdD
 yjbsUWKb+caaJWY1tnrzFiw32B7qJ/IxTpMwnViSwquYxZsLi50DJQmvLgIbQqVpCOFc
 Uph+Hb62vFYI3p20yPAaIkCnLsLah8A9YsnhnMZoZ8mgeAf4FqpjWcYP2hbg/Itbrepj
 eF9IVlNZQ6p+lnyTIEx+8jD42qyY/a0fIJZacSjioDhzh6vxmijQYP2H52Hhb0W44rAq
 Cym7CZdMNh6tFZ/cKaTSfWrjsFCRCPmBFMWzlZMlXKG+bt1tWq/BISGv1TCGwfw87G5I
 mGPw==
X-Gm-Message-State: AOJu0Yw49lR6U6fwDwhS4iBwT9Qd2nZxV+5jIsm57gnq2GVfCHLY49sj
 pBp+K/gaC8Sic9CKqoupSsjTZgFdo0gZqT4Kk+wgRMvtvDtDYL30XMdFbjVSEiOuqPru4loa7qr
 q
X-Google-Smtp-Source: AGHT+IGhFVzBs+CjuvdcypRc8It+BlAHX5RQJmD41Cxp1ZOCzxbR3g20zvk4d/I5BPUfGyCYgX5PIg==
X-Received: by 2002:a05:6358:7e54:b0:178:a197:15e with SMTP id
 p20-20020a0563587e5400b00178a197015emr2611302rwm.32.1708031817245; 
 Thu, 15 Feb 2024 13:16:57 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h21-20020a633855000000b005d66caee3d0sm1873779pgn.22.2024.02.15.13.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 13:16:56 -0800 (PST)
Message-ID: <72d0e01e-ca54-4fc1-805c-b8de7175d64f@linaro.org>
Date: Thu, 15 Feb 2024 11:16:53 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Optimize buffer_is_zero
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e1260284-cd5d-7a92-d8fc-21c0aface21c@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

On 2/14/24 22:57, Alexander Monakov wrote:
> 
> On Wed, 14 Feb 2024, Richard Henderson wrote:
> 
>> v3: https://patchew.org/QEMU/20240206204809.9859-1-amonakov@ispras.ru/
>>
>> Changes for v4:
>>    - Keep separate >= 256 entry point, but only keep constant length
>>      check inline.  This allows the indirect function call to be hidden
>>      and optimized away when the pointer is constant.
> 
> Sorry, I don't understand this. Most of the improvement (at least in our
> testing) comes from inlining the byte checks, which often fail and eliminate
> call overhead entirely. Moving them out-of-line seems to lose most of the
> speedup the patchset was bringing, doesn't it? Is there some concern I am
> not seeing?

What is your benchmarking method?

It was my guess that most of the improvement came from performing those early byte checks 
*at all*, and that the overhead of a function call to a small out of line wrapper would be 
negligible.

By not exposing the function pointer outside the bufferiszero translation unit, the 
compiler can see when the pointer is never modified for a given host, and then transform 
the indirect branch to a direct branch.


r~

