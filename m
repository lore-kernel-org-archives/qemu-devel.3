Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C150D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t347Y-0000F6-Rs; Mon, 21 Oct 2024 21:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t347W-0000Eo-LN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:55:38 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t347U-0008B3-Vy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 21:55:38 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e56750bb0dso2351849a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729562135; x=1730166935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AfD24UjBdzAMpAk5WlUbzZ09XBO9B+ThB2CdtUkPbP4=;
 b=zW13koUAMF7t5Lck86pr/VwqXhkGz/TN8kRc65wYQmBQp/g3/54J9U3XTz4UDr0ldK
 KcrYoMsAvouWoMbTVKpHgHTs0oNEkaBqp/2HlLtnFlmsfrP2w+YUTyOlV1cyGDE2NuhP
 LXHvZ3h/++Bcbc4o3h0sK5mjC/lGfV2U/okJRDmaFvqrRk9B9FAGSgMgCaNyvovq9/XL
 sZufkX7XzmUAUu18JovIBE4purHqFwtf3IOuPXwJn3kpRwW0Nt95y7rmwJTDM7NztmGS
 ea5JkuGXbKkKTYPCiYD86oeEoZO52rq9Tbc3WutyOpjCcG4hnTFIexeIDdn6If2+SyDw
 yEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729562135; x=1730166935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AfD24UjBdzAMpAk5WlUbzZ09XBO9B+ThB2CdtUkPbP4=;
 b=HruMUyfcF36t0LiDYZQt7smsHCp7+fw+5hMRUzmQoVtJttWZWYL64eFZ5QkzkSc5aR
 O1DX3Nt2uSg6Rn+whmju+m0PEmO2kfdUsPNPp8h9TuauiUqiwrJCSiYe3I8S7rony+lo
 6N0WvMlwB9m4BUcNN9i1xu+gfRje+kH4KjfISNhKZwaEZpc/2TEM6qJkhKWLKupsg81/
 10xTj2NBXZ5haJo+pfxdRxPBhTc6eaz5aZeoSSRu107ByzcCqiEtziyJAxE+t7B3P9hT
 Y2X1kvg5BwCLdCUuhVI7Rh9NcdnN66fMOjcSq/v1+25gExBnahZsmEE83J/inChj1CDh
 pYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgvh2OKR1sJxtgJiSxURi2WXDCbpFDmJ7IJ3XP6utBinapwW3mHRe4tX73J8q2J4oEHY6Q+DXaYack@nongnu.org
X-Gm-Message-State: AOJu0Yx1EvatE4v8uDF4kDS+hPXF8mRes0+9evq3ovAkVZKMCGQH5oPL
 jQyFO/e8joRjgXWSAL9cI6HbtXKLcy/WzGPqUIoL2recfu7hkWWF6M3/291A3JM=
X-Google-Smtp-Source: AGHT+IGtJXdj3/T0hNN6NCh1hw0TitZmiTlt58qZn9HQ5/qv9WS6qImIOsTo60tRPVEAnCU0mpyDSA==
X-Received: by 2002:a17:90b:120c:b0:2e5:5ff9:bee1 with SMTP id
 98e67ed59e1d1-2e5618d0e13mr14205445a91.29.1729562135500; 
 Mon, 21 Oct 2024 18:55:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad4ed277sm4723915a91.39.2024.10.21.18.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 18:55:35 -0700 (PDT)
Message-ID: <f8d1d219-5597-437e-b8fd-18ec4737a3b5@linaro.org>
Date: Mon, 21 Oct 2024 18:55:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target-i386: Walk NPT in guest real mode
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Jan Kiszka <jan.kiszka@siemens.com>,
 Eduard Vlad <evlad@amazon.de>
References: <20240921085712.28902-1-graf@amazon.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240921085712.28902-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 9/21/24 01:57, Alexander Graf wrote:
> When translating virtual to physical address with a guest CPU that
> supports nested paging (NPT), we need to perform every page table walk
> access indirectly through the NPT, which we correctly do.
> 
> However, we treat real mode (no page table walk) special: In that case,
> we currently just skip any walks and translate VA -> PA. With NPT
> enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
> which we fail to do so far.
> 
> The net result of that is that TCG VMs with NPT enabled that execute
> real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
> the guest accesses host code and data. This typically shows as failure
> to boot guests.
> 
> This patch changes the page walk logic for NPT enabled guests so that we
> always perform a GVA -> GPA translation and then skip any logic that
> requires an actual PTE.
> 
> That way, all remaining logic to walk the NPT stays and we successfully
> walk the NPT in real mode.
> 
> Fixes: fe441054bb3f0 ("target-i386: Add NPT support")
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reported-by: Eduard Vlad <evlad@amazon.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> 
> v1 -> v2:
> 
>    - Remove hack where we fake a PTE and instead just set the
>      corresponding resolved variables and jump straight to the
>      stage2 code.
> 
> v2 -> v3:
> 
>    - Fix comment

Thanks, queued.


r~

