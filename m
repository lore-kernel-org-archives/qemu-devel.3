Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38B6E83848
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 02:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsB67-0007lL-Km; Mon, 16 Feb 2026 21:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsB65-0007ka-L2
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 21:45:57 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsB64-0004rn-0H
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 21:45:57 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35621aa8c7fso2023213a91.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771296354; x=1771901154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EqLUB8cOMzih/3XqWDNORqwTLvCyMLzydKDopUwUmiI=;
 b=Ovp4gzWQ+ITLDqiws/riIlvk1BAMhLQ6WhCNMJu28yGvt7mKAyQrps6ZAB8ZfwVuyq
 AoH3M3YtdLVL2Eo1QmbtiHDv3dsKJT+JMTTIBg/HyW/uemGu8rIWa8uDLVcqDiT4gzJB
 1qD4SZxNcd11mNgOo62/jub81o1zLza1vHHbpo6z87PBhKJhY6RpmJ0y5Yg/oUFTMs4S
 8duyrFmaRoG71p3XRLCSr6XVt6so4wp5dpE9bCNNbB02lfKFuRXlvams2md+POa3hxfm
 Jy/wXBZAhIMV2txFr7QLUD2bXxIhVxTSC/7xXTGq6OU3EMVl9YQbUBljTVCQZb5iMlZW
 b6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771296354; x=1771901154;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqLUB8cOMzih/3XqWDNORqwTLvCyMLzydKDopUwUmiI=;
 b=dOLkirq5RhTy+4jDsMtG76rOSrD42cfLPE1/zw+phWWTPhoz2jNwVKPn1KUiahlXgY
 5eRsDi2f9WrBbmFhIXopcWkK0m07OSQY/88VbaqhxmPuSgPwNux2dZgRJXC3ok0rOQar
 l5TRNptifGoaXIhC1kdQz3aK9g/F3VO0Jll1iYj9lmbY1f17JRWZ4DIg2hXJe+Tvcvhi
 PN01D5hXab9F5EMpe7X9J9anaP+vMPPky1ZmhNJ10eWdSMxTCaVHUJLuMeFgEhCmjQOM
 3rDpzmT+IOp3+Nacwvm9WR62QhsNISlfydObctn/ugJxuGNKKfnDEeAfYLgN6QShnL1X
 DG/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeaxrrIjghqlOrzBtNF+yCypF10GjW5W+XgfSDq2L1UH4lGWrs1NerwbcGiRGqNg9VTFGNgDkCdD3R@nongnu.org
X-Gm-Message-State: AOJu0Yw6JNJ1PLY5lP2zmPVXQgfjJrTH6k6wlJhh8be/WhMjR8NGGGg/
 9biaI2dgu1/Kh0vcre3uz7OzcLKYhs5L++iMCcfYgJH6g96SyjPpOO5YuiiQMVlN+K8sAbO5/7k
 hxaqP
X-Gm-Gg: AZuq6aLN4Gaet//RVLHSkzGE6DMeJ4y2NGi4G/WCNu2sABvDo5QKe6/7PjUhm83rz3D
 3GKtktK0NuMjxRPDDrtSCQMvh9Cow36uZ2iDNsJMteA0Z7nMaBV5Zt/Y2xLTjl4vMQvm8AeXQsG
 oDO8t4oeX1XK8z//QqH73x/DshfCCaUxOTloKynMgPXSyrERRay3iv5ydG9ihWo4nqOokmwEl61
 ccuwX6WpY0CdaUed25bIl/HBsVC7yvkKUOAW70t+gWDOSMepXktuX8Yae6Q4um7JLB9kjlJcoUM
 Vo/br7pOapE1DtSTIyEtnOuupggwZ/vvDJeGHvJ9I3snYUUMi+ndNR5f6JgiExu0mW7oScy0GPE
 U9y7d3NjFKcSxMitFYD+QMNxe1cLFmcbbWaRqxf16G77uTpxVNwwV2rXtKSAKB86qhMQMaaWP6i
 Kl8a3VgHmRw+KADQEPkozETkI5gOY/bw2hhiJzSenQH3dWCnZLHiDEq/pITYcmSzDTDJJ9
X-Received: by 2002:a17:90b:288a:b0:34a:8c77:d37b with SMTP id
 98e67ed59e1d1-35844a4ec0cmr10479338a91.16.1771296354058; 
 Mon, 16 Feb 2026 18:45:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-356a6ac65bfsm8785433a91.1.2026.02.16.18.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 18:45:53 -0800 (PST)
Message-ID: <87d4ef3a-5648-494f-88a1-c8e63e54b5b5@linaro.org>
Date: Mon, 16 Feb 2026 18:45:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Don't use HELPER_H in non-tcg files
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260216160349.3079657-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260216160349.3079657-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/16/26 8:03 AM, Peter Maydell wrote:
> This patchset gets rid of a couple of uses of HELPER_H to pull in the
> TCG helper function prototypes in files that aren't in
> target/arm/tcg:
> 
>   - debug_helper.c has a lot of TCG only code that can
>     happily live in a new tcg/debug.c file instead, and only
>     the CONFIG_TCG code was using the helper prototypes
>   - helper.c was calling exactly one TCG helper function
>     directly, and can be made to call a different function
>     instead for the same effect
> 
> Pierrick: these might be helpful for you with getting the target/arm
> single-binary series to compile when TCG is disabled.  I think it
> might be best to avoid having a single helper.h that gives both the
> helper_foo and the gen_helper_foo prototypes, though: even if it
> doesn't cause compilation failures, only translate*.c need all the
> inline definitions of gen_helper_foo. If you take that approach
> then it would fix the compile errors without needing these patches.
>

As mentioned in original commit, having helper_foo and gen_helper_foo 
was done for convenience. If we want to duplicate that in two different 
sets of headers, feel free to add a comment on concerned thread, I'll be 
happy to do it.

It's just include machinery, so it's not really important to be honest, 
as long as everything compiles fine.

> (I did wonder if we could move target/arm/helper.h into the
> tcg/ subdirectory, since it really is TCG-specific, but it looks
> like the machinery in include/exec/helper* assumes that the target
> has a helper.h in its top level directory.)
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    target/arm: Move TCG-specific code out of debug_helper.c
>    target/arm: Don't require helper prototypes in helper.c
> 
>   target/arm/debug_helper.c                  | 769 ---------------------
>   target/arm/helper.c                        |   5 +-
>   target/arm/{debug_helper.c => tcg/debug.c} | 542 +--------------
>   target/arm/tcg/meson.build                 |   2 +
>   4 files changed, 4 insertions(+), 1314 deletions(-)
>   copy target/arm/{debug_helper.c => tcg/debug.c} (53%)
> 


