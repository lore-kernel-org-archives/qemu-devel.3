Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BF7D24444
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 17:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRCk1-0007lC-Tn; Thu, 04 Dec 2025 12:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vRCjt-0007ei-Lq
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:03:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vRCjr-0002L1-Oa
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:03:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso12888915e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764867810; x=1765472610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2GPPHWjlRCVEPWyE1+uFVe/x4iW7ubhqWb0NHit9qE=;
 b=KAWRFcL4pjn9AhVK/8PRUEUP2MfFby8OTpeQKpdwh5aAX2ke4/ZTQUQq80xDAvg6rj
 hhNYPIkhQMFahpJihjmwU4WzQfqUkIDaQDN/zNUzAn6ZHd6OTd1nPMgL5diF/mFEKHqa
 EkIKtex27C/PmJGWo0KMmpBbyRaSkHdUSOYJjnxTH1pESY+cS6jCFLWejzdiRGoh6XkI
 Cq32Cznl/IL68TxnuiEq74mlFEn7uvRsxjtGMTenklPiuJHTL6uGtKz+QKMGNwc0l7pN
 JlT0xxFoVe+8R8DIcIyCjdhRl+a5OHALAbjd+Y7E3/jVLdWC+hq+xd2owF3FuzVOXWB9
 MumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764867810; x=1765472610;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2GPPHWjlRCVEPWyE1+uFVe/x4iW7ubhqWb0NHit9qE=;
 b=IZTja1OuQnkURuIXFDTsCMWyiMhCgpAgSdjq08nNFQnHSJtmB/WAVekOSyHZxHqfir
 kktsg9/4+tNtwPkdd+ZiDfDm/KN2kWYM+qbzwE0OCsIS4K3CW7TH24KUDuzsgzun0kii
 vlYnnETxvdEFCo6nDgqluUED0k1iN/SILgoW/h0nt+kS3r235c52a0qbt6QhWxREMCGv
 iEIgqCi5fYWMhTkj85MLCm+eix4Sj1kOLeAcVHOkpzH+td+/OAx+snVeLcQm+X9XcNth
 UmOb+yhYflR2LTv62ZAyGAqafER1pGBWB27Cg0y4ZQQExwr7HuOa9Zf9PGP05jcBbaoB
 08EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwkHMci5OjKJyA79Mg3sYvJL4hqpIEO/lY6zGCYIBfgV1dCvtRClU7Xfs3UU2KpuctyVXUP9/fGmfW@nongnu.org
X-Gm-Message-State: AOJu0YzfLR7vVaTBJKA1ErqGzCDp/a0npmn4lBMzbvkW/nMGzcgItqk0
 1Jv4aDesbix6i9BfnH2ftP518mrC6TUdVihrPfx4V4sbtMwShYFx6V+WDICktDwdios=
X-Gm-Gg: ASbGncublWIhpyyq/60WZqCgE1XX/S4L6x9PpEqoI8hM2LNpif9bvmLU+K8OSsv8BRf
 zkSLD0o3spw5wote8NnCVrf9lBoKB734MemhHq+on+NKNxjwK/BT3foYQQKc+7Ou7ZIFSGBKBF8
 9E1tDVCm7E6UbRbgb3ehN/FuChHlQgbETQ5FDscIq3eqgrc4W/jGN/YnU/9gkriffNYT8rxTVHw
 50OWU4gdYhhHYMXkys8PDLOQUtFfdLzhzIHNgGXOsEUsXIu2GzeVjV0wwfeOyAUfkcYKFpdpjCR
 kbAte0iWx/ncyu7424o6RDiDqo02wkohLSzmEER8NyiRtmfCVDw+E4cCxii4gYQluaw//Aogi7O
 jloXDdfC8Qw9DAcF5rgh373j3BdGo21dnfjv5bnz5ypWE8Tj9yB6vgedrwKGoWjJDz4N1Kn42Tp
 xR3wZMpkrPdA4F83toUwRVh6ENQOCF+QPfziTpBRgm+iJXYAg5IrkSMCMU9spV0h8T
X-Google-Smtp-Source: AGHT+IHAqhLq5cXqPnsiqTD8wC+Emtn+oecoV8PAEzmgZ+SvmMaTHf4gM4jdYxLisX2eue3opFyYwg==
X-Received: by 2002:a05:600c:3b22:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-4792af2fe93mr66794345e9.21.1764867809274; 
 Thu, 04 Dec 2025 09:03:29 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47933aef61fsm5226625e9.7.2025.12.04.09.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 09:03:28 -0800 (PST)
Message-ID: <38f73101-4f2d-4e62-8ea3-fc42cc90e8f3@linaro.org>
Date: Thu, 4 Dec 2025 18:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: reduce files included by block/aio.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-4-pbonzini@redhat.com>
 <bbbf42c5-98c6-4f24-929b-7bbb2853f5c9@linaro.org>
 <19f01d31-01f5-458e-873b-4859e2f8b3d9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <19f01d31-01f5-458e-873b-4859e2f8b3d9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 4/12/25 10:25, Paolo Bonzini wrote:
> On 12/4/25 09:35, Philippe Mathieu-Daudé wrote:
>> On 3/12/25 19:51, Paolo Bonzini wrote:
>>> Avoid including all of qdev everywhere (the hw/core/qdev.h header in 
>>> fact
>>> brings in a lot more headers too), instead declare a couple structs for
>>> which only a pointer type is needed.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>   include/block/aio.h                |  7 +++----
>>>   include/block/block-copy.h         |  1 +
>>>   include/block/block-global-state.h |  1 +
>>>   include/block/block-io.h           |  1 +
>>>   include/block/dirty-bitmap.h       |  1 +
>>>   include/hw/core/qdev.h             |  6 +-----
>>>   include/qemu/job.h                 |  1 +
>>>   include/qemu/main-loop.h           |  2 +-
>>>   include/qemu/mem-reentrancy.h      | 10 ++++++++++
>>>   net/net.c                          |  1 +
>>>   util/async.c                       |  1 +
>>>   11 files changed, 22 insertions(+), 10 deletions(-)
>>>   create mode 100644 include/qemu/mem-reentrancy.h
>>>
>>> diff --git a/include/block/aio.h b/include/block/aio.h
>>> index 59c56d695ee..8cca2360d1a 100644
>>> --- a/include/block/aio.h
>>> +++ b/include/block/aio.h
>>> @@ -23,9 +23,8 @@
>>>   #include "qemu/lockcnt.h"
>>>   #include "qemu/thread.h"
>>>   #include "qemu/timer.h"
>>> -#include "block/graph-lock.h"
>>> -#include "hw/core/qdev.h"
>>> +struct MemReentrancyGuard;
>>>   typedef struct AioHandler AioHandler;
>>>   typedef QLIST_HEAD(, AioHandler) AioHandlerList;
>>> @@ -211,7 +210,7 @@ struct AioContext {
>>>        * of nodes and edges from block graph while some
>>>        * other thread is traversing it.
>>>        */
>>> -    BdrvGraphRWlock *bdrv_graph;
>>> +    struct BdrvGraphRWlock *bdrv_graph;
>>>       /* The list of registered AIO handlers.  Protected by ctx- 
>>> >list_lock. */
>>>       AioHandlerList aio_handlers;
>>> @@ -393,7 +392,7 @@ void aio_bh_schedule_oneshot_full(AioContext 
>>> *ctx, QEMUBHFunc *cb, void *opaque,
>>>    * device-reentrancy issues
>>>    */
>>>   QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
>>> -                        const char *name, MemReentrancyGuard 
>>> *reentrancy_guard);
>>> +                        const char *name, struct MemReentrancyGuard 
>>> *reentrancy_guard);
>>
>> I suppose these changes were before you move the declarations to their
>> own "qemu/mem-reentrancy.h" header?
> 
> Yes, but also qemu/mem-reentrancy.h is not included here.

We want to also include it instead, right? (No need to forward declare)


