Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25A9C9EC64
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfF7S-0006jA-DV; Mon, 12 Jan 2026 05:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfF7K-0006dP-LY
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:25:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfF7J-0000nN-7b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:25:46 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso49474915e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213543; x=1768818343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UoNwstrdF7vtBrLj6PnEAh1upb7Sxj/6PImopWRW6qI=;
 b=HQ2fd/m8mGSwLM/Q+23LvQFMnaYNc2sKk9x+e4XbHTFFABvM5YpAtOCYWRHj0aTvVt
 VytLEOT/YpvQJwOkk8sgW9skHIf6KoTesohGKaQLJMjSmwL9wqKlJz5X0ZkMKIm+pO7c
 79Kpmf1rxtt6aepql8+Vt7sWru6aTYoVymv1xBORKlL2U3zEc01NNKfGdzYRsgSsRIPc
 P3ExFdeMp5uRZU6wVME4OqVjMiJGKHPzgk+rmRJE1hKZEV9uaFhnZm91f/9T7C2nmDmS
 zmiiTOLfbZ4vairPIjncQusrXFBOgrUNssAIDFBIDYY/IcqypuhMxEKDNybg2XC8qMPO
 7ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213543; x=1768818343;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UoNwstrdF7vtBrLj6PnEAh1upb7Sxj/6PImopWRW6qI=;
 b=HtUwdb319oO7v/V7JYW+RYpjsQFv3qJSnrNiQGmRhiJBOO3b0ivS6KvYY7m/HeADli
 zGpTWdlBtfHHAyMVauDMqEyQ1UJNBttyk7C0yOldZF8u6uqOHeiv288sjrddkGwNb5QZ
 Wf7uKit5l53gz97VrxjoBCW+0LucQDMYm05Z+H9Q03kX+aJsw3g862a5XCHjRtOQ9Y/0
 7ElIpHpQt2tuOE4nJWzh7VeDSib+nn+1deiadnmHZhhsAmvPtnIzCc0ny2zO6HoxwdPQ
 Os/CpXg69Cj6AgciErF8KkcCdRNnf8HxAZWRjd8JG8DuFjasLWJg5LGxezbYTRB1VMB2
 6njg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqbDhMZnFC3qx95gN8u6f6BvsP4Zr6di1A5woBLs+VzA4V2B8yUOSbbZvEUVYwJlxrFIJP+U3O9gqm@nongnu.org
X-Gm-Message-State: AOJu0Yx+O0zoJF3dbtZOUwEYsTTO0duAk5HtSlRBd5S8n/gpUSdF1Rd/
 XulHkE1ZNfh3sq5B8BahBwJXqRFGK7PCT4Bzll5JgtJFhXwJ+LQ1scRBrGtDFiAx2xQ=
X-Gm-Gg: AY/fxX6wcKZ/VndTs8LQqco/lyPamr2M8VYnr1L53mjgAexw09k9ro8galZMZHjD2Er
 j4VgA4EiIpt5fgjxTx2YIjFh2nS531NFe9qI9pRE+LbL+p1WJHExiz2rVWzfiZgFiK9FDcGWdj9
 plqiWU82rsavkfWTp+xz+qYgeZq7Dq1xJd1cZFGWik6cuTwUgGyRDNawHOTzkVQN4gKv+8SkuM8
 Rcm4YOgNtEbkZP2sQZGOmo5ohBrysYt8VyqVi+wRpLenCwLa3W2+piiIWJjMHP+fIU4iZGT0oZO
 mB7Q15yQmfImTLVuRLzcGg2MxTIHkMsgzqSfqbVH/ucZOiTAfgg3APhvmbIZDJzhuj7RK/fAFBQ
 03tgQ/puKJB1VGyBDMYsqwrUileb871BffwXa8rDZA8NaX8nTi+bgow2KRdlbGdPg6BdAYvZSuY
 DH945EXqbTyUUGZd0tguhR4iJHstW5jXRWoYWvuE2d8rd+G0kD1JljDOCIpOIxn1z8
X-Google-Smtp-Source: AGHT+IGv7f1Q063LuiWtAGkjY9ISI9RINmveX09Kx3EjJcY5YExxV4pxwjdBIPjnrvfiwjPamZz1mg==
X-Received: by 2002:a05:600c:8706:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-47d84b407e4mr190492065e9.36.1768213543540; 
 Mon, 12 Jan 2026 02:25:43 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8715b5d9sm131940945e9.5.2026.01.12.02.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:25:43 -0800 (PST)
Message-ID: <166abd3d-7f04-4b92-91ac-458d98f5bf57@linaro.org>
Date: Mon, 12 Jan 2026 11:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: allow slot size to increase
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
References: <20251203035847.94102-1-j@getutm.app>
 <75b1bf03-1f65-46e7-bbd2-0fa106cf8fae@linaro.org>
In-Reply-To: <75b1bf03-1f65-46e7-bbd2-0fa106cf8fae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/12/25 07:59, Philippe Mathieu-Daudé wrote:
> Hi Joelle,
> 
> On 3/12/25 04:58, Joelle van Dyne wrote:
>> Instead of having a fixed limit of 32 slots, we allow the number of slots
>> to expand. Currently there does not seem to be a need to add a limit, but
>> if the allocation fails, we will abort. The KVM backend was used for
>> inspiration here.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>> ---
>>   include/system/hvf_int.h | 12 ++++++-
>>   accel/hvf/hvf-all.c      | 78 ++++++++++++++++++++++++++++++----------
>>   2 files changed, 71 insertions(+), 19 deletions(-)
> 
> See first 12 patches of:
> https://lore.kernel.org/qemu-devel/20251114200422.4280-1-philmd@linaro.org/

Maybe you could add yourself as reviewer (R:) on 'HVF' and
'Apple Silicon HVF CPUs' MAINTAINERS sections to be Cc'ed
on patches in this area.

