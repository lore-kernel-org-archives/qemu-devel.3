Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07ADD18157
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0V6d-0005WQ-HL; Mon, 14 Oct 2024 20:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0V6b-0005W7-ST
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:08:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t0V6a-0002xu-FX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:08:05 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea8c4ce232so1212854a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728950881; x=1729555681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iI36SBwilk21muzaU9UyYNR2rpGCp83XYlP9n2plDao=;
 b=DTCx+gmyrDoA7NwEltLRBx/TCKnyh4qzSGAKtfzV2nvAF1tGUkYdCEm+UY0x8JNasu
 l9oRSli6kc0PXFd58HV5MHVQhcAxIrb/s2zDUuz5u+3djl0y2uv1Cb16FU57yMOZOj1E
 yfQs76BYwVbXprRzlM9tVe5eFt9d3chbwcZQ7SbcySVskhM4keWY2b4y/Pei3P/naFzR
 IDZ0kq6auhoJBuQqEScKFlsI3nv43a9oNCNakrJJE4Eao3SPFwg94uhAvPoA3A4HOESq
 s0XV9NRnQm3yqiRLHzW9cGsR87dW5WuJgs2sU0v8HzSTswcuPapYRsUlJVfqI6kEEyNE
 ViMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728950881; x=1729555681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iI36SBwilk21muzaU9UyYNR2rpGCp83XYlP9n2plDao=;
 b=ixL4HIs8eJ8YX9bW3J12wbExIRBIudh2Rs8m37/8AEDqZx0oU31ebNbmhGRvZKy1Ik
 auYXEQYkyPCA9vUgcCaYhnraIRl7UdaRCgPrk9lizOOR1i3CxrObaXuTwqtoPPBb2FJr
 mgjCjAPV159pyHSe8s151LRSwzpSxdcAxqv1UXlvMMIQem2x8X7eH9I3J/ZaOhBAV++z
 E6Zpt9gGHnqjqqIkDuan+YPjnh2WyPInj4MuIsPUvGsolwiEPglMiwD/BMQY129uKDZy
 VA6GtCogf843fOoPPFc+tQ97Su3h/BHUrClpHbPKcR1Hmeicgw9oSF48qdw+jw6y5+GG
 g0Bw==
X-Gm-Message-State: AOJu0YwQyvqDxuwvZT8/ZAOPoJjxYPbc3Rf6vMuzsH+BBRERziMiXuF9
 klFblTZHhWY77AWueCNjW+pluCosiJrVW5FxEfoibf02YGWZR4MewBfY2QCW9gFlaxYVGhSNQeT
 i
X-Google-Smtp-Source: AGHT+IFxfFVMPjkkyw5VFDbGiATfcnqFBlAxu8EvH28rW2tAEGNGWHTnGZLKgdCtVC8JL7GjPjF8eA==
X-Received: by 2002:a05:6a21:3418:b0:1d7:7ea:2f39 with SMTP id
 adf61e73a8af0-1d8c9577328mr12599204637.5.1728950880979; 
 Mon, 14 Oct 2024 17:08:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6c10aesm127785a12.21.2024.10.14.17.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 17:08:00 -0700 (PDT)
Message-ID: <2b3dc6fa-6bab-4339-94ab-7abe24e6f106@linaro.org>
Date: Mon, 14 Oct 2024 17:07:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/23] accel/tcg: Convert victim tlb to IntervalTree
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <2d59794c-ae72-a3c5-85fa-01f0354c1e4c@eik.bme.hu>
 <3e2c31f1-5650-45c6-967a-f13038ba4236@linaro.org>
 <f233d9ea-eeb3-4fe2-9057-1a540b17909f@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f233d9ea-eeb3-4fe2-9057-1a540b17909f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 10/9/24 17:50, Pierrick Bouvier wrote:
>> Eventually fixing the page size > TARGET_PAGE_SIZE performance issues.
>>
>> E.g. with a 16k or 64k aarch64 guest kernel, we still have TARGET_PAGE_SIZE at 4k, so all
>> guest pages are "large", and so run into our current behaviour of flushing the entire tlb
>> too often.
>>
>> Even without that, I expect further cleanups to improve performance, we're just not 
>> there yet.
>>
>>
>> r~
>>
> 
> Does merging pages over a given range be something we could benefit from too? In this 
> case, entries in our tlbtree would have varying size, allowing us to cover more space with 
> a single entry.

I don't know.  I kinda doubt it, because of tlb flushing mechanics.
But we shall see once everything up until that point is done.


r~

