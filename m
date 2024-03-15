Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C0C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 07:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2H4-0001gI-RP; Fri, 15 Mar 2024 03:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl2H1-0001ew-8e
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:46:39 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rl2Gz-0000Mh-MF
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:46:38 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29c75e348afso1378992a91.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710488796; x=1711093596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h4G+k4zp14YJwMEPi5ZQCcNopcHt0CmjddtathBYE9s=;
 b=djFln5+dZ9SFNXNwWnobhvnZ9YQv7bS4XRsWw8P4o6fLIpeqbf7f/k/EBz9+fDxqyO
 rIfNlg2oeM1I75BmZ0QrQ2lJp56R129mOiKr7B/Z9S0NkyDM98BDc0jf2DTHWHJrEfQN
 egcfXhqnstizTDVghDB1cHQiPQAIRmTG8wI3WLVojnRSWfuVy4nW5IMBtd8d34EwUS7i
 eJRNcmgxY29stByXY1GYEORZ1EDpKKG/Ztu/FsRZnptlxiKCT0HON+Jcl0tWn/5+V7EY
 zBJMj0FgozqoOzxR6sZdxT6PkChAe+73KtCd6Qtx/U9Gs4nWOASXvH+ljkmpYDXTh/Tf
 onig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710488796; x=1711093596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4G+k4zp14YJwMEPi5ZQCcNopcHt0CmjddtathBYE9s=;
 b=alFpPZm3P8fYDl22MxipijwxBvNnVcsv4ZiWSRTM1WqnHqEX/ArG9sMFuO36Suix+L
 kZEJjrE56/ftaPBvZqs0y68+3QHEXPkUnnLeccXGHUeZ9Bco0UMouWb3FeArKus1PDAm
 l9B2hW7ubpDgmHGewCAjG00RvPe8zn3Pqp6zZip/z2cuCd5jDdCjbYiXDhlGOVbwhJMu
 4gxK43wOQq5qk972h2zE1p0EzZ8uyOsAJ4Z8bgV06b2hbikghEHhCiasxrmF6VYqeC9S
 POMoffhT1SqH4tmfE44fBhpiyirmwr/r8CKqGTsrzENvHwsvm1eOP5JHn/PvNfVrkruQ
 XdGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDmnmdCgheSncOHus2x5a+1lXgd14d9F5jLhnyzQAZz9N0Jo9vyyDxlUtR8Fr5MhfZQ8MREHcv4lXsszDxhT15dJZQd+U=
X-Gm-Message-State: AOJu0Yy61ti35O4pu+loSWa4GmyEvy8qhoAk02ET81/Q844r8dodIUIy
 uduHvT+xtzBpKWqz6nw1wnw+bNGaDmtqUneavAz2OmlxxySFXRhO6hkGUfavCqb7ex3lc4d+V21
 k
X-Google-Smtp-Source: AGHT+IGkiKovaFR2eUYGIn7WQGRQX4WnE1u3GV6imofm5V/JoiabUtrN3lefNNaVwRyJn977dpvSNw==
X-Received: by 2002:a17:90b:286:b0:29d:32cf:a60e with SMTP id
 az6-20020a17090b028600b0029d32cfa60emr4211799pjb.0.1710488795644; 
 Fri, 15 Mar 2024 00:46:35 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 o7-20020a17090a420700b0029bc9c34a39sm2220521pjg.50.2024.03.15.00.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 00:46:35 -0700 (PDT)
Message-ID: <90bde2c9-46fd-458c-9c32-22dac25bb069@linaro.org>
Date: Thu, 14 Mar 2024 21:46:31 -1000
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
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <05a4b109-6e86-6ecf-4399-c0f9d5fd1a6f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/14/24 20:22, lixianglai wrote:
> Hi Richard:
>> On 3/13/24 15:33, Xianglai Li wrote:
>>> +    if (unlikely((level == 0) || (level > 4))) {
>>> +        return base;
>>> +    }
...
>> Perhaps it would be worthwhile to add another for the level==0 or > 4 case above?
>>
> A normal level 4 page table should not print an error log,
> 
> only if a level 4 page is large, so we should put it in
> 
>      if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>          if (unlikely(level == 4)) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "Attempted use of level %lu huge page\n", level);
>          }
> 
>          if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
>              return base;
>          } else {
>              return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
>          }
>      }

A level 5 page table is not normal, nor is a level 0 lddir.


r~

