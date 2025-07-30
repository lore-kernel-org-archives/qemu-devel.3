Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C08AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEBs-0006eJ-PR; Wed, 30 Jul 2025 17:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE5r-0000x9-JY
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:12:12 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhE5p-0006z5-Mj
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:12:11 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b31e0ead80eso194099a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753909928; x=1754514728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2RkIaqBSYYgRdTLzLl+pwOejxVGip6U34l7rGXnPENk=;
 b=L5Svvb/lbuQputgSi5pPItcCRXHRvXioPuaweNGye1xlPZXqh+M37dEzADa7fzqXjS
 O//vd0NVqrkcIQ1HcowPdZMl8880dSCMlMeXkWH9X3u+sM61GxaXSUSuRJnlHLsFqH9x
 m7eol1SU8bHgUVhaF19dzvJNnfBHhp2pAA1HmW+0a2KApsXYgBlbfTrKV0xKeskLzpCc
 dXdz5xeFQzeGxaH4rVDTsZOUpDXWRlWjrM7BunKqKaIqZpmNI8G2O7cnnbN+l/ovQxsl
 4NR7lnAs9BVtHRFPq32KeZKVOCYTq6drLpy/KWDB6584Q01yOkMzW/B3prJujWzcrSqQ
 0Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753909928; x=1754514728;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2RkIaqBSYYgRdTLzLl+pwOejxVGip6U34l7rGXnPENk=;
 b=NrZkpSqyafLg3qYWf2tOtDINR1NI66DAJVEB0amusCxciW07Ms3xH+70p3iHMnrqDe
 Q4SIQc0tKQpeEEynlmt/xwvQpmxBZr1WKzkfoq4IYnt4G0P5IW7ugmJEsJKMttA+dmSp
 VsJG8Iatx5JO9UcY7MNfWUmG2k/7r7NNzWhmmcc65L3QE/I8VMYD/xoU1sXi0teGIEZR
 lmaQmJGNZvWrm3TnmJfJEPj7uo/YX4Ftl1WWlbunczMvdGZdRzvGw8FJ97X6ZTe3A0xE
 fZuG1T9jvdSTZrb0Xe2SLErGbWr5vcas8Xm1RTbUNQPXF8GFuZ0g0luK7nVGUyvfuNA+
 rKNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/F+OQfHWhtZ71nZ+Q8I83k1B8Ay0GcYSR5bLwMP/eUYnigt4Ww/t4cC7WfkMrvzsP7bU51P4yVy6k@nongnu.org
X-Gm-Message-State: AOJu0YxD9jmQCYncO/omfH3JLLh57S/DDvnKe3999rn38RhzlqAE32FW
 V+qHg45qFP9k/InCwppfipZaZ5T2KpdTLjNSO6ZWRcQBj78AjUGdmR48UpTi4l1ilIjVSvjPxEs
 7QV/H
X-Gm-Gg: ASbGncvaH7ke66NW1WdmkZXNvXbwkwji+U4aCjgdVO/x62/jYZwXCQhri0QgxJP+kGC
 SVp8wzHS0EAuJzOvFRQVoGvKOd/XfP1RN1Zptw+jeyCbeYgyKD/Dqf/8xOfmUj4buBxeZpWihyB
 /38Pp+JtdT2Zm5/chDtcQ9LpcRC0sdxovLDMlmIzKYerFxcLQbnnkvLid2rhEMt4x/wD8fynDtN
 Xukmw0KtR3oLGwVXLC6PwB/wsv+qns2+LQMHKoTvIBQJ8O8GAsy44J0VdwtQb43auOUEg/ObuI0
 m/3/ngArjdXuwO4Rtr4j6LGhG9ztW2jXSSsPX6CfsSL13qswbiIRcMZJhkB0MefATQ6wl7k28Ed
 R6IJrud+xV+aEi3AojZCOu6OLpSjQNZgp5qM=
X-Google-Smtp-Source: AGHT+IGveFdUw2wzwMDL0ZoumG/EYgGSb9QU6lASk3mDVF1CNQCR9wncNSfTDSKlyAEAAgCKDRAtZw==
X-Received: by 2002:a17:90b:47:b0:31f:42cd:690d with SMTP id
 98e67ed59e1d1-31f5dd9e0d8mr6985765a91.13.1753909927999; 
 Wed, 30 Jul 2025 14:12:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6feasm86092a91.21.2025.07.30.14.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:12:07 -0700 (PDT)
Message-ID: <ee5e730f-9bda-4d66-a055-9346e5a18ecd@linaro.org>
Date: Wed, 30 Jul 2025 14:12:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/82] target/arm: Convert arm_mmu_idx_to_el from switch
 to table
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-31-richard.henderson@linaro.org>
 <6963c11f-ed15-42f5-9110-9516ceb64662@linaro.org>
In-Reply-To: <6963c11f-ed15-42f5-9110-9516ceb64662@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/30/25 2:10 PM, Pierrick Bouvier wrote:
> On 7/27/25 1:02 AM, Richard Henderson wrote:
>> In an effort to keep all ARMMMUIdx data in one place, begin construction
>> of an info table describing all of the properties of the mmu_idx.  Begin
>> with the access EL.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>    target/arm/internals.h       |  3 +--
>>    target/arm/mmuidx-internal.h | 27 ++++++++++++++++++++++++
>>    target/arm/helper.c          | 27 ------------------------
>>    target/arm/mmuidx.c          | 41 ++++++++++++++++++++++++++++++++++++
>>    target/arm/meson.build       |  7 +++++-
>>    5 files changed, 75 insertions(+), 30 deletions(-)
>>    create mode 100644 target/arm/mmuidx-internal.h
>>    create mode 100644 target/arm/mmuidx.c
> 
> What's the benefit to explicitely size arm_mmuidx_table on declaration
> and definition?
>

I missed the:
tcg_debug_assert((unsigned)idx < ARRAY_SIZE(arm_mmuidx_table)), which 
does not see definition of the table.

Maybe it would be easier to declare size in the header, and reuse it on 
both sides (declaration, definition instead of ARM_MMU_IDX_M + 8).

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 


