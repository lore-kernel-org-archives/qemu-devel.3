Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D2FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 06:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uceTW-0005yu-23; Fri, 18 Jul 2025 02:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceTU-0005tU-2t
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:21:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceTS-0008Ul-32
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:21:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso1020952f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 23:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752819696; x=1753424496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=J7vYcLwfK3H2c1tSJleUypbU7M3wqbN1e3jpA5zKYtA=;
 b=rpVfnCf+xIXlRVDhmGx5LR/ZsJHQKbsQa3ZqkkmtTOLYSKvKfvNX4v2UJkaLtzZgYz
 fGlfKXx9oAlC4fZE2E2WVPymgGAJ/JzXNs8IORG9pjfC5WJ3HJq1gPcFkcfVRVBFPEHq
 gJp5ZCKXqL9/ZX+icwePiuDMTDjSHdsVQhuqpPjXMWJhV8xcXvlij7C+OJquc7XOvdVw
 NYTj2pL1Ry3YE9czak+UhjvsK9sIYpZmH7/yZFMPyhacT1CKH+fJV4NKshBC0O2qAUue
 IHMyxEb3J+FY2bfnR5yOcks8KWFLsEVDd02Xaezy6Sm8RZT2z3upp8j81oGKpHSt7ilz
 Nl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752819696; x=1753424496;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7vYcLwfK3H2c1tSJleUypbU7M3wqbN1e3jpA5zKYtA=;
 b=OAGpOxoeqEHhkamXh3S/Bt0ENSYYsy/l5tSdrLTafMIict3E+trpWJ5Uw/JZvoP71s
 Xm1vje7Xlq8RFH/WANqHZrNMVmhwOszwXuCN2jKAIIZPO6im6WUPTyY385A9If7+GhRW
 IKKAkP4bSU6K8zivR76/00YHnGpAcMezQ0Md2PsjMUY/QWm82ih7N+BSSrYYyjfAcfSJ
 NeExxWJcG49U5I9So7zyhimf1xk1x5iJixpFL0/i6KCiLCyrLnzKN7cmuHwv1j23fzVc
 oVvlZbpC3Z4Tuk81AhRgCXJ7CX+lugCVgPOog+PPUuDtvIIrKw0R0vuHSzOmmM46BaSX
 4Rwg==
X-Gm-Message-State: AOJu0Yxhc8az1YeLeHlpa60pbdwNufEGgOTQDuoSJqWxA3NKWEeZ+eir
 kPuzD5JCwv0CXBaCYReCQ7gZBngs92RHnrXWG9frZ+tY/NGsn+ZB5WuAy6OLXNnD8nY=
X-Gm-Gg: ASbGncszGaY0j27Iee7O93EcldvLZ7ON4CCXFowBJ7EynSAG9630L3BCDscyI9GvUax
 /9O8BEBQwGIqhehJHsB2E4N9Mcf3OshMrnfGbm+Ttyg5UA9CG/0WdgbnrpV97TCrLjPfsp5zPKG
 Kggr7+ZFbg+9QhCoomgLxNe0CD8LgVNKZ+HBxEZUGhzLdeDwj64WCwjZG4JS+GG0QzLLddNpqJN
 D6mGMf6ug+LwzA4nq36uvBKEMf1gmF6wCBWeihKBqoLOkE4e+Z2VZBuDx+Cf8I1pczkWsh0sjw5
 HK0gRJhbMtxUC3YQ0iVOdr6jyqYU5v5deUg8j/XcWzk+DmhqbUWY38/oy6rhCYQQgjtz+UZcKgo
 GmYE8qhefDErJPBHbns+DXqVCY62xJDt1yQwUiQbtiUajO1sDg4RLMM5j+wvkXz11bW6nCo4i2F
 Jx
X-Google-Smtp-Source: AGHT+IEC5tQgQtwh1CjuHRTa9lNpCTVmoTmlu6n6EV8FHBz3FyQIYyhE/5tBkTAkk2hbHp95Cb0VIA==
X-Received: by 2002:adf:e19e:0:b0:3a5:2ec5:35ba with SMTP id
 ffacd0b85a97d-3b613e984b9mr3705327f8f.30.1752819695582; 
 Thu, 17 Jul 2025 23:21:35 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2b81asm898980f8f.20.2025.07.17.23.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 23:21:35 -0700 (PDT)
Message-ID: <25667aaa-d884-4615-acc2-da230728923d@linaro.org>
Date: Fri, 18 Jul 2025 08:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/passthrough: add missing error-report include
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
 Adam Williamson <awilliam@redhat.com>
Cc: qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250717220207.171040-1-awilliam@redhat.com>
 <87v7nqgk21.fsf@pond.sub.org>
 <2c536b62-1253-4ac2-a549-ce783f8bf5c6@linaro.org>
Content-Language: en-US
In-Reply-To: <2c536b62-1253-4ac2-a549-ce783f8bf5c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 18/7/25 08:05, Philippe Mathieu-Daudé wrote:
> On 18/7/25 07:11, Markus Armbruster wrote:
>> Adam Williamson <awilliam@redhat.com> writes:
>>
>>> In cfcacba an `error_report` was added to this file, but the
> 
>     In commit cfcacbab38e ("xen/passthrough: use gsi to map pirq when
>     dom0 is PVH") an `error_report` was added to this file, but the
> 
>>> corresponding include of `qemu/error-report.h` was missed. This
>>> only becomes apparent when building against Xen 4.20+.
>>>
>>> Signed-off-by: Adam Williamson <awilliam@redhat.com>
>>> ---
>>>   hw/xen/xen_pt.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
>>> index 9d16644d82..006b5b55f2 100644
>>> --- a/hw/xen/xen_pt.c
>>> +++ b/hw/xen/xen_pt.c
>>> @@ -54,6 +54,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qapi/error.h"
>>> +#include "qemu/error-report.h"
>>>   #include <sys/ioctl.h>
>>>   #include "hw/pci/pci.h"
>>
>> Uh, error-report.h is included without this for me.  To see, build with
>> -H:
>>
>> . /work/armbru/qemu/hw/xen/xen_pt.h
>> .. /work/armbru/qemu/include/hw/xen/xen_native.h
>> ... /work/armbru/qemu/hw/xen/trace.h
>> .... ./trace/trace-hw_xen.h
>> ..... /work/armbru/qemu/include/qemu/error-report.h

FYI "qemu/error-report.h" was added in commit 418ed14268f ("trace:
make the 'log' backend timestamp configurable") to access the
message_with_timestamp declaration.

>>
>> Code smell: header in include/... includes header from hw/.  Not this
>> patch's concern.
> 
> Lucky side effect of including "trace.h" a include/ file due to trace
> event being called in inlined function. Bad pattern indeed.
> 
> Back to this patch:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 


