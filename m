Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E4EC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 17:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlB1N-0002hr-P9; Fri, 15 Mar 2024 13:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlB1L-0002hS-RI
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 13:07:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlB18-0002pj-9K
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 13:07:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd9568fc51so21078805ad.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710522409; x=1711127209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9hvNEHKYocJXVS6DZWoo0lVrV4z+PRQ7ThPFtL6LXaI=;
 b=bLo9lBUvYnxF8xAYgfIzJMcXD84UwJtXClDkz2Lpn9ZKPdp0rzbKlbhMy/j1qpfPZg
 BdtDa7ZfK5Ishs4ghculcILjgVatFARXkzfXRVWWWxys9MAYc44MB55/jReuQWR9UEeE
 00vq5ZgV9eOOSbiyIP0zQZBmpdweLkJ+u5R506/SKlcQLFM13wojjaK7BIKWJ4focxzF
 NXAnlavqO84Atep1PtTMnFT3hes2bTTVk1Oo61LR7D9h6VKTWQKG9x2NYqUx3mLJvwPN
 d2mgrUc5D7QsQ0yozt2tKRgesQVNJTO0ZHWnJj5+T8PFgblHqkZ7D3q9NKxvSc0OfvKq
 eBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710522409; x=1711127209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hvNEHKYocJXVS6DZWoo0lVrV4z+PRQ7ThPFtL6LXaI=;
 b=iqaxz1RxxAvZqJ1Hp9tQx62OW87NzWrcc0IjhE31vx5nxC3OSVVWKoxDtEg4MDCfHL
 tHhCzb08wIA6QGoFkIJfsDUPMiS/X7KFJtZiFqpTQrowkVlcm/YxlOWREKgWDKMp5dG3
 ms7pOjWPjT9cX8OG0SY4jkQ8Z6uYlQiDWEWvydXo+pmpArfgnSv8YTmfGwSTXrHLgQwD
 9XM2whs1lL3XaHStA1ysSkOJwieH7LfDIFKhlBOgt/9I/avwjzh/b4ibdTdVvedlVc7O
 EVPaXhCy7FYT3a9SVC13rbh7854JpaAtfT5E01t6U7MlgRLjkFd+Q4+BmxyLnobiKf3y
 /fpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE2fkKxZvXJpKJFQjg2sq7ZTcpDH4NLQU0YwWXK1LJdKhcbKto/ffdnKxN3oZd8Exp/x5Yq0jQLhAMheRfzqo41+y7gjc=
X-Gm-Message-State: AOJu0YxppvISlvgwt4tiIVqO5OzNWShbL5ZizaSJmJwIAIeDbAzQankD
 EyCGd/XjbljrXm3Oj6Q9OaIyhsN9dmbu7NA7fPZw8aQopGZjlJqTJwudcq05EcHeblpvhW5aPjG
 W
X-Google-Smtp-Source: AGHT+IHgEwsHsFQ5frUn5lb3N73YiYY/YWixAycP+c8lsc/2wTxGbnBIJDFyr2ZY/PX3c5rFsQryoQ==
X-Received: by 2002:a17:902:f68c:b0:1dd:d41e:2cd8 with SMTP id
 l12-20020a170902f68c00b001ddd41e2cd8mr6735068plg.61.1710522408753; 
 Fri, 15 Mar 2024 10:06:48 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 km12-20020a17090327cc00b001dd5ba34f3esm4066180plb.278.2024.03.15.10.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:06:48 -0700 (PDT)
Message-ID: <553e5eee-7af5-4ecf-b994-1bdd6ca8a820@linaro.org>
Date: Fri, 15 Mar 2024 07:06:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/1] target/loongarch: Fixed tlb huge page loading issue
Content-Language: en-US
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn
References: <cover.1710379781.git.lixianglai@loongson.cn>
 <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
 <60733d71-daba-4f4a-a184-357526a3b3a0@linaro.org>
 <05a4b109-6e86-6ecf-4399-c0f9d5fd1a6f@loongson.cn>
 <90bde2c9-46fd-458c-9c32-22dac25bb069@linaro.org>
 <874eb7af-d1a0-0777-bc10-555381b85118@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <874eb7af-d1a0-0777-bc10-555381b85118@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/14/24 23:01, lixianglai wrote:
> Hi Richard :
> 
>> On 3/14/24 20:22, lixianglai wrote:
>>> Hi Richard:
>>>> On 3/13/24 15:33, Xianglai Li wrote:
>>>>> +    if (unlikely((level == 0) || (level > 4))) {
>>>>> +        return base;
>>>>> +    }
>> ...
>>>> Perhaps it would be worthwhile to add another for the level==0 or > 4 case above?
>>>>
>>> A normal level 4 page table should not print an error log,
>>>
>>> only if a level 4 page is large, so we should put it in
>>>
>>>      if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>>>          if (unlikely(level == 4)) {
>>>              qemu_log_mask(LOG_GUEST_ERROR,
>>>                            "Attempted use of level %lu huge page\n", level);
>>>          }
>>>
>>>          if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
>>>              return base;
>>>          } else {
>>>              return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
>>>          }
>>>      }
>>
>> A level 5 page table is not normal, nor is a level 0 lddir.
>>
> 
> We communicate with the hardware guys that the behavior above level 4 and lddir 0 is 
> undefined behavior.
> 
> The result of our test on 3A5000 is that it has no any effect on "base",
> 
> however in future chips the behavior may change since it may support 5-level page table 
> and width for level[13:14] may change also.
> 
> 
> So in this context,I am not sure which level to use to print logs,
> 
> which content to print, and where to add these prints,
> 
> any more detailed advice?

Yes, right there in the IF that I quoted at the top.
What I was trying to spell out is

     if (unlikely(level == 0 || level > 4)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Attepted LDDIR with level %"PRId64"\n", level);
         return base;
     }


r~

