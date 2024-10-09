Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECA5CEE330
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 17:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syaDN-0000BW-N4; Wed, 09 Oct 2024 13:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syaDM-0000BO-9q
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:11:08 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syaDH-0005vX-Iw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:11:08 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7e9f998e1e4so3602720a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728493862; x=1729098662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/gmR2iOxZdJatvi77n/jgss54CrDVgrCdoex4kroOw=;
 b=sQjPbHRzmmeSn9G9Q9gtFhBIfjgC67BlEs1Ptx70s+LA3MOaRvnSYuO92Ix3i4Bq8S
 QhNKGKu1rvKG8zOA0W9iFUSDmfV2k3k9rk3Wjd7UUD06TKhlXt+XucUEDRwUETVKZu/z
 /dX5kdNOepmUCJx2/Sf+p99Ow2g6UNHRrcd9qOOw2ZIcVIF4wIVCHMAtWBs+xPtATpze
 lfcktA3/l8pr+tlye4TMIYwi4HnvXhuwqkIL+XbIbZghFnVDwkZk7sRrMSdBhKOW7+iA
 75Bg0vpySQoOJBy3Z2SWdvX+6qg5aXqe+JrEweOgsjHF7FzsuAMj0mlVNE/qOopOEnHp
 PWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728493862; x=1729098662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/gmR2iOxZdJatvi77n/jgss54CrDVgrCdoex4kroOw=;
 b=FH98UNeeYBIgDWNFdXFAdkFjbBMitOXMrkXhlWdkamNbALPv8jFaTIC82KVpsYTzwO
 wVMJHHgP1bqMpVeRpXFnnJjyCXBQX1SwqTfaaGsa4vKTk7MYiIHgqiwoN6ZvKtERsRNT
 AVwUix2wXeu0k4BHOpuImfAPweJ8lyG8b+1Wo2EWsQaxSKSZbONT2kFl7S/h4fOIOnPa
 2ofvLxvJiNhUxPxT8L4rumFm3R5YxKT3HGlj33RLtMZWT6W4qjWo9mWp/KcSL0kO4W/2
 taLP5u6l2AYah3/KcXSzhH3cVOvOra7xWYheEyx5uIkJCUVaFk+HUXCuzOVBJWXPIu3q
 lC3Q==
X-Gm-Message-State: AOJu0YyNHIUHJNv7j47ou9wc1yx7SkzbkIG5jwKDJHUbSLE4pG4eDL/f
 Ee8W7QARqYWVCRZ/08yR40Qb+Iln92ksexzPz4y6NzhmHEMkD/g/7Ec7uxFYMpU=
X-Google-Smtp-Source: AGHT+IEsdQvXWZzw2ixWSTRzd+JijkEYDk8q+isjZ/BVLsAXLBbGGEwTrKtO+NRTxs/B5Y3mrquC1w==
X-Received: by 2002:a17:902:ce88:b0:20b:9f91:c461 with SMTP id
 d9443c01a7336-20c637551aamr44683935ad.33.1728493861621; 
 Wed, 09 Oct 2024 10:11:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c77812e73sm7036085ad.110.2024.10.09.10.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 10:11:01 -0700 (PDT)
Message-ID: <3e2c31f1-5650-45c6-967a-f13038ba4236@linaro.org>
Date: Wed, 9 Oct 2024 10:10:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/23] accel/tcg: Convert victim tlb to IntervalTree
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <2d59794c-ae72-a3c5-85fa-01f0354c1e4c@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2d59794c-ae72-a3c5-85fa-01f0354c1e4c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 10/9/24 09:27, BALATON Zoltan wrote:
> On Wed, 9 Oct 2024, Richard Henderson wrote:
>> Based-on: 20241009000453.315652-1-richard.henderson@linaro.org
>> ("[PATCH v3 00/20] accel/tcg: Introduce tlb_fill_align hook")
>>
>> The initial idea was: how much can we do with an intelligent data
>> structure for the same cost as a linear search through an array?
>>
>> This is an initial installment along these lines.  This is about
>> as far as I can go without first converting all targets to the
>> new tlb_fill_align hook.  Indeed, the final two patches will not
>> compile with all targets enabled, but hint at the direction of
>> the next steps.
>>
>> I do not expect large perf changes with this patch set.  I will
>> be happy if performance comes out even.
> 
> Then what's the point?

Eventually fixing the page size > TARGET_PAGE_SIZE performance issues.

E.g. with a 16k or 64k aarch64 guest kernel, we still have TARGET_PAGE_SIZE at 4k, so all 
guest pages are "large", and so run into our current behaviour of flushing the entire tlb 
too often.

Even without that, I expect further cleanups to improve performance, we're just not there yet.


r~

