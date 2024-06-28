Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9655AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNG6X-0001hk-Gv; Fri, 28 Jun 2024 14:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sNG6R-0001hD-Cj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:13:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sNG6P-0002XI-O4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:13:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70699b6afddso757992b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719598417; x=1720203217; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6TxPGn1+CCKIDi3YOB3bw7ZE7fThuAwAX/M5uGuDM0=;
 b=Bh/1FYMjoMib/QAbTuBqu4SJ0eDrdOC7PDuQTrqDrKmZZhMpJ0vCFTINFFf95W5tkw
 3zKNgOiQiELDf8iaGU1XCkvOOHAC3ju6k133sXKLiMhIHFK6cDup1CFKiGxFXlZjQMd3
 hbtYCANggJ4jbGPW0nH1K3EkYLnG+0QloCe4N0N9rn/RPXbHEoktOiSVmkOZ4h5fRK6U
 oJg/d9CLWdw2LZRXu74liB8ln4+zrA+o7UdUMwJzC46JNxIZod30z0YmNFeTtBdtvtpT
 y5LtUCyR/Ewjoq85lWB0o3XhlbyxfCJQ0zmj3Kks55bB8P1RICsZefHvCdRzsGVBGTqk
 0A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719598417; x=1720203217;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a6TxPGn1+CCKIDi3YOB3bw7ZE7fThuAwAX/M5uGuDM0=;
 b=Cqs1P60L37ex+nn1oZq+DzlHbDwlmp6Vf95HlY9n7IP9u9lWLGfiOys+3QpXI/Udoh
 +V6v+Bi2EG9pNpqZjBb70YuReF6O6zt2d9jSCA3eRoo7u0Oc0JINjlyy/oNfe9U9+fBI
 hoxghjWce45wWk2eL6q94NwdgQV8EWDh9zxJOpeenLIX/PZzbkdRevvql836/g9dF/o4
 1ZrlhI1fKmc6oINAU3enPzN4HaEk7It+3Wi9YYPX4u+FwtzsQHjherBPiMooomWBQHF/
 5Ie2+SmTn6vM7q2zmOornrwXclridoCql3USaYleym8NanHMApqZ71bOaKkTichMmNIv
 YUOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDJm2+vjisn8B2Kt8Db/yKgoFAsjgZ5Trcw0P4Yl4JjI5WR+uSoelaup0XqBKPFzUoSAkh81o8g4eLyn/lnb0rCB5R+ow=
X-Gm-Message-State: AOJu0YxkniFRAWEt/bDewuN5xtonNHkVtcitAH431Rx76gP2bUST7b9X
 /SzcJVTkofd6kX6/gHIO1F8ElKVP7YSnoj+zo/KHk+SnxtqeJNAFKIZOXiBI2hw=
X-Google-Smtp-Source: AGHT+IGPWdpvR9aitv1uy5uKFjn34ekIL1qWKc1R0DWpX67wZh1nlGDc9mk+nIHoAKlTcEzcCJSu7w==
X-Received: by 2002:a05:6a20:3257:b0:1be:bfee:87b6 with SMTP id
 adf61e73a8af0-1bebfee8e74mr8766862637.45.1719598417182; 
 Fri, 28 Jun 2024 11:13:37 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044adb21sm1977634b3a.141.2024.06.28.11.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 11:13:36 -0700 (PDT)
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
 <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
 <ea688598-b4a5-40f4-a749-c155ecc0988c@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <d9812dd0-6f72-56ef-f52c-2f879bf2bf36@linaro.org>
Date: Fri, 28 Jun 2024 15:13:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ea688598-b4a5-40f4-a749-c155ecc0988c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.965,
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

Hi Richard,

On 6/28/24 2:00 PM, Richard Henderson wrote:
> On 6/28/24 08:49, Gustavo Romero wrote:
>> I thought you meant osdep.h should not be included _at all_ in my case, either
>> in mte_user_helper.h or in mte_user_helper.c. Maybe the wording in the docs
>> should be "Do not include "qemu/osdep.h" from header files. Include it from .c
>> files, when necessary.".
> 
> Not "when necessary", always, and always first.

Got it!


> See the "Include directives" section of docs/devel/style.rst, which does explicitly say 'Do not include "qemu/osdep.h" from header files'.

Yep, Phil pointed out this doc when we were discussing it in v5.
I was actually referring to it about the wording. Maybe then it should
be more explicitly that osdep.h _always_ has to be present.

Re-reading it after your clarifications makes it clear, but the first time
Phil pointed it out the phrases:

"[...] since the .c file will have already included it." and
"Headers should normally include everything they need beyond osdep.h."

weren't enough to me to make it clear that osdep.h must always be included
(present) in the .c files. "will have already included" sounded ambiguous to
me, more like, if necessary it would have already be included in .c (but not
always). But, well, that can be a falt in my interpretation..

Thanks a lot for the clarification.


> 
>> I think we agree osdep.h is necessary and must be put in mte_user_helper.c. But
>> that left me wondering how it would work for sources including mte_user_helper.h,
>> because it can be the case they don't have the declarations for the types used in
>> the function prototypes, in this case, for CPUArchState and abi_long types in
>> arm_set_mte_tcf0.
> 
> CPUArchState will come from qemu/typedefs.h via osdep.h.
> 
> For this particular function, 'int' would have been enough,
> since we only care about the low two bits.

hmm, right. I'll send a follow up patch to improve it since Alex already picked up
the series to gdbstub/next. Thanks!


Cheers,
Gustavo

