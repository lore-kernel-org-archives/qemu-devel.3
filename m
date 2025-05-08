Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F9AC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 10:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCyYm-0005k9-7t; Thu, 08 May 2025 06:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCyYj-0005gs-Uj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:32:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCyYi-00063J-6c
 for qemu-devel@nongnu.org; Thu, 08 May 2025 06:32:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e45088d6eso11956465ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746700374; x=1747305174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I+Tibim8Q4APBLsB3Yy7KZpXtD4KpS6syUMFUyzU9U4=;
 b=QSXKRX2XjBGzqfyvHU+Gcf0Lb8RizJL99yOTMdV0m3HQMoAuOJZmfhaUEvt24R64Pb
 PtnjG7e6tPaPyYu3yd/+DvnwquscUX1UZy7Wb+gt5+X/ugp9galD/yx1MOyT+BHXv4q6
 ijfQQgfa0wQhS5Kk4AvPA3SinUkLdkpk6I6Vir49BqNVruSQiL3Rp2CdVfuufiGtvf3U
 LF7V+786hcP5sLyuUbTuJuKTWjPPMLx/k7xO9ab/xLWLB2l49NmGMgrMY4QwJnVSLqCk
 IJvMSPVdVD1qDSVCVI3Xm7o9IR8flfRy/zvassC+sWG3Ai1xer1GTbNQl8e5RKPQJ1pb
 HhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746700374; x=1747305174;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I+Tibim8Q4APBLsB3Yy7KZpXtD4KpS6syUMFUyzU9U4=;
 b=pe/MLNyO3ez6gzB/unAtsXX3030WJPGKtvJ4B8EyuG0vtWarc3HbMI8K9pnvFR3wPE
 KInK0uZMVgueTx7HqrjwiO/N6HusUZLYQPp5qb/eEqYkU/vHEgdNTnMk+3INPmmijFA2
 qlL092G6xGz09PWbg41NjQCSA0c++rygGuVu+62jTCltFj1CSFzZyot47iPV32s0kp4t
 DtaIyI+UmGsRMA08zdL6z9p9nocSNCaHaThSveOOhe+qX8lWHS4b0DN7LRV8Z6hDiY+G
 +wVK+Fauwn+/O1fzx4B6JOU5ztFc/6DcI+dwkxD+E1yKMqOCQNoiSMomQDYuZXl7zgfh
 64uA==
X-Gm-Message-State: AOJu0YzZqINhd8yAeFNYqZ5h99OPintcyNlj0DBpEHS0HspB5f3pq9ZA
 vOfA5CF4R8savkgEZPqJSR6qAlVqLoJalhcJivqC+FIYQShMgw+MhOLep2ykXMWMdGV6Uk6JC+1
 +CgXVaQ==
X-Gm-Gg: ASbGncuW/KQtU+RvUt1Myrp0b7X/qf8JEhnPtHRvze0NOC16vLZpfO/yqEvONGb36df
 SPWRp9RmVI6a3oYjavVCrVkcfe+xwoD1gNdb5AMBuntSJ28KkWZmESWRu5FrP6pJ+zfYf+8gF8s
 9OSfeqhUK4s6pJN4LRuii4XW7EKBKYZVeGE3xFTgJefjWrRKkyQxsAgJN/I//yRw/HhBGE/Nk1u
 UA/HGQoZD3ekSSpSQgMxW01qpmUL9VugrscBVFFOE1zaG3fRMdFDdncN7vmLRaoLpZTMgsC6fvc
 ecDsPgzGPVATF7kzecvvkbAfxh7+LQ62EFbC4r1CYQS8e3POdrWX3kRquyXqLvdwezh0uiSh+7k
 IGvXHkUOwNcagpUFs6xU=
X-Google-Smtp-Source: AGHT+IGb9B7ZIkai1Dip9stDnbhnzk+4NJBq9YsZ0BlLt+TregYC9wLs6ejulzL7qIAwkzJNnIwxaw==
X-Received: by 2002:a17:903:40ce:b0:223:6180:1bea with SMTP id
 d9443c01a7336-22e5ecccb3emr84448785ad.37.1746700374046; 
 Thu, 08 May 2025 03:32:54 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522947fsm109633945ad.170.2025.05.08.03.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 03:32:53 -0700 (PDT)
Message-ID: <b0737130-fc97-40e0-8488-3daaca23552d@linaro.org>
Date: Thu, 8 May 2025 12:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/imx_i2c: Always set interrupt status bit if
 interrupt condition occurs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: corey@minyard.net, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250507124040.425773-1-shentey@gmail.com>
 <aBtavpDt1yfoavj7@mail.minyard.net>
 <8a5893be-7217-4c58-838c-01370db5d6bf@linaro.org>
Content-Language: en-US
In-Reply-To: <8a5893be-7217-4c58-838c-01370db5d6bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/5/25 09:14, Philippe Mathieu-Daudé wrote:
> On 7/5/25 15:06, Corey Minyard wrote:
>> On Wed, May 07, 2025 at 02:40:40PM +0200, Bernhard Beschow wrote:
>>> According to the i.MX 8M Plus reference manual, the status flag 
>>> I2C_I2SR[IIF]
>>> continues to be set when an interrupt condition occurs even when I2C 
>>> interrupts
>>> are disabled (I2C_I2CR[IIEN] is clear). However, the device model 
>>> only sets the
>>> flag when I2C interrupts are enabled which causes U-Boot to loop 
>>> forever. Fix
>>> the device model by always setting the flag and let I2C_I2CR[IIEN] 
>>> guard I2C
>>> interrupts only.
>>>
>>> Also remove the comment in the code since it merely stated the 
>>> obvious and would
>>> be outdated now.
>>
>> This looks good to me.  I can give you an:
>>
>> Acked-by: Corey Minyard <cminyard@mvista.com>
>>
>> or I can take it into my tree.
> 
> I have to respin my hw-misc PR so I'll squeeze this.
> 
> Thanks!
> 
> Phil.

FWIW I noticed the patch subject is truncated to my default git-view
because it is over 72 chars. Since there is no enforcement on patch
subject / description lines length in checkpatch.pl I suppose nobody
really cares about that so I'll merge as is.

