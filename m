Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F27D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ7w-0005fv-An; Fri, 11 Oct 2024 13:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szJ4X-0000wP-VE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:05:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szHTj-0005sV-Tp
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:22:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c803787abso15159725ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728660174; x=1729264974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1CogMR7I7WuqqzE6cNx48xEoXofErOXlHnvljTI0ZmU=;
 b=vYIg4B3GEeJQQppUtlecq2fVGVtvUZz/O+yYJ4+l+u55BxWWhFo4v2uj09ueV30CZn
 Ixcaqg5KnAAJH1SGFvTFlYWPihcX3EAJBjXuZb5yexJPPUZKJVW1nr+b/K3dWqSqIrK4
 eAM9kQjbmdmDybtqDFzkA8ORs9k5wLc0TMxe/1T3hpwyCrYXey1MtRvc2zHDBJsJMYTh
 8/nQF5UIWpzHUPNh4zSbCAslGPtrLLrYsKGc0HTXF0uh0wlHOMlOt2UFawpwSfsR2G6w
 QtbIRjIrryBZ/xVY+8YWa4deEKT2i5zgYYsmFTf3BV3inrH7UQr7YIm8v/kZWaU1Gp9p
 Q8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660174; x=1729264974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1CogMR7I7WuqqzE6cNx48xEoXofErOXlHnvljTI0ZmU=;
 b=KIIlANwb7UBFtJrW3Bm3MQEgwBpGmDo38RSSW6NqnFfQCjlZRQZmnxvnMemTOhAMZ4
 uAkVNO6+YyydhjbBlIdPa0ZIVZuzDJgX3TrxbgB4iZoNLHLd6ML/bDcWRaKHmln8cG8B
 cKYy2tv3jPtsr+ZfiGNFMsE7hBEVCc7LjR+35XkRCQg2GqeWg8pMz/fxW8KHOhJNdLqx
 dwcymrY6BgyiKdzTYLg7G6ChP56NwUEfYW4GBXS9UbZ2+m0JBBB4AXoPDV0q8A+xoiN8
 EJkOWJnr8EYaEgAM6LJlx7LFDdF2dhpytp61xmoqJfhoyqbV0sIdJlB2f84nPvbuTEPp
 rGhQ==
X-Gm-Message-State: AOJu0Yx3522eTuh6p1u58Njoufy9UEeADpodHvValW4gq920ZZZfq6BY
 wcfXM/GVmyzRLfx3HBVdDrEG+cy6ZZfOVBzkX4uj+pYIVCmKX4zeoNWbGi6sY4efaSoml3/D9xo
 d
X-Google-Smtp-Source: AGHT+IGtuBfJ5Y8/O99TVzmcr+ylQwPmRJHu4yyYUgnd8FAVtIUhSM+5WEIdXBhH7Jp50Bxnudz0dA==
X-Received: by 2002:a17:902:e88a:b0:20b:5e34:1842 with SMTP id
 d9443c01a7336-20ca03ff886mr53673925ad.25.1728660174181; 
 Fri, 11 Oct 2024 08:22:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c348986sm24499055ad.258.2024.10.11.08.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 08:22:53 -0700 (PDT)
Message-ID: <b5bf5d17-2451-4d6e-9a4e-6fb4e94ad308@linaro.org>
Date: Fri, 11 Oct 2024 08:22:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] accel/tcg: Use the alignment test in
 tlb_fill_align
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-7-richard.henderson@linaro.org>
 <CAFEAcA-mSsFgjoBWi13dXqZUbys2N81YVXLD_ZfuuGo+Xfy-gQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-mSsFgjoBWi13dXqZUbys2N81YVXLD_ZfuuGo+Xfy-gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/10/24 03:44, Peter Maydell wrote:
> On Wed, 9 Oct 2024 at 01:05, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> When we have a tlb miss, defer the alignment check to
>> the new tlb_fill_align hook.  Move the existing alignment
>> check so that we only perform it with a tlb hit.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> @@ -1754,8 +1767,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>>            * Lookup both pages, recognizing exceptions from either.  If the
>>            * second lookup potentially resized, refresh first CPUTLBEntryFull.
>>            */
>> -        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
>> -        if (mmu_lookup1(cpu, &l->page[1], l->mmu_idx, type, ra)) {
>> +        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
>> +        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
> 
> Is 0 the right thing here ? Given that alignment-requirements can
> differ per-page, what happens for the case of an unaligned access
> that crosses a page boundary where the first page is "memory that
> doesn't care about alignment" and the second page is "memory that
> does enforce alignment" ?

I can't think of anything else that makes sense.  The access to the second page is 
"aligned" in the sense that it begins at offset 0.

Anyway, alignment as a page property is unique to Arm and...


> For Arm this is moot, because an access that crosses a page
> boundary into something with different memory attributes is
> CONSTRAINED UNPREDICTABLE (per Arm ARM rev K.a B2.15.3), but
> maybe other architectures are less flexible.

... as you say.

> Also, the comment does say "recognizing exceptions from either",
> and we aren't going to do that for alignment issues in page 2,
> so if we're OK with ignoring this we should update the comment.

The second page can still raise page faults.  How would you re-word this?


r~

