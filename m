Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF7FF4BB8B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 21:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuzbV-0008Fj-Sy; Tue, 24 Feb 2026 16:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuzbV-0008FM-0I
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:06:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuzbT-0000p6-GC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 16:06:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso2069945e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 13:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771967157; x=1772571957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/2lqpZhgmRhDxp+pMZqmirh1bSZYNZelyrwGfa4ezM=;
 b=u58m6gsBfbrND3OpCJRMvkFxH/BBDDcS4/g/v4Yqs9xiX3rvQ4CK/jMael3Q1swV0u
 lgtEHUKpvgLTsERxJ9pdOtFOxvs1NP1tMFAcywpToR1rkjJ+q56n1agUHx9y47AEBHa9
 4a0+xbN2lyydz1iVo3rVmeuBWGiuL5wCqAXD4byGNI9uacCX471aZKACAIeEAC+IbbFM
 Jm+jwmid9EWTvsM3k/oTfx25z2UYmjF0Bu7ZTifD5UxqjQSlO5em0eHAC2ta3RG0kgNV
 3ElOtIoy+A529BzYu9oQY8qnS+MVayDZFLlG2a2gvJrU27hakoF+1oJobnXB93P9YEPL
 QVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771967157; x=1772571957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D/2lqpZhgmRhDxp+pMZqmirh1bSZYNZelyrwGfa4ezM=;
 b=dNTAK1Li2z6+CXj66aopImIEIgnl96vuPQM7LkCoFThvHIwKSbtmHbcB4z436Zbmm8
 AGzb+Lm+tc0x/jh5BZGRxcg57VO4OBnMr2avwO90+sIyKm4+fR9mUPZQxzn5xwi/W1yJ
 vIq4E8PVMy6XA5AEqE2uJHc2R7V/6eupe5JyuEm2PpR6nI+fB3XHs6Hmgw0DUKLtSTx2
 MtUOsqbWbFUMetLLumgBUHLJIGD9PTaWnoehn/L40DH/NaPNoU45d69ChUAtNsCVlD1Y
 K69y/0S4OP0wC0ES1uobb9BarBVfOOMttSDurTzUwIV+8shgXifAFXDucIFxB4scJjmL
 A0MA==
X-Gm-Message-State: AOJu0Yz38PEwIDNIS2Zh6L2EzQ+dpe0JAUvFVSOY/dVATBy7GCtCJxKb
 ruCoovaNIvEKGJ3zu/Pg9MMpN+LvRBibCHK0kAzXl5fUjmYyrk4r2zvdgdplgb3Exin4hmYkKvS
 qU/57md0=
X-Gm-Gg: AZuq6aJHStiXHRZUZLNVdA3ODwCaUxqIP69s482HGf7vt71JVy6jQ04bg+UhrJr5h/+
 AnwLit/LwAQKotiCEx+Qn9Pop8zGz1ZXhcJGRmCvJwFlwFALaFQiytfIC42fQXPF4mFlBYv21xT
 g2uJYtrjoKBVY1vc+UQamJ2W/47XqjhNy9k199lMX+hEnden4oD1hLFPn6eM2qmYvs1tdP6AKzA
 2ubxPEVeaALsVjwGpe3W53D4cedrfqwAu6vH1p1QuqpU+MQpETdQ6c4KaFvpAUYtXUBBaDVNDSU
 ZlWdBdOk6VCUIlLqrRGeLMjH8RFrr5pblTiESeyYGHhydzz+36872pIjIe5VdYQPTLYvZaoY8fL
 K4kcEq1UDmJP9xMPVBiV+wfDnUu5D2s29Z8RBtKxr8yPoRNrpq3Hyu1Bw80hO7EdWuW2zXa2UOg
 NLTpuZr5l61/LgJIArRv9IlCjRJTq2Nw4qk3Q4kdMNFindXJyWVVwI2REcf9zb93pHLA==
X-Received: by 2002:a05:600c:314a:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-483bd7429acmr22256085e9.9.1771967157585; 
 Tue, 24 Feb 2026 13:05:57 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483beb430ffsm3080025e9.7.2026.02.24.13.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 13:05:56 -0800 (PST)
Message-ID: <747ef1bc-68cd-49f4-b93e-a16fba9003cf@linaro.org>
Date: Tue, 24 Feb 2026 22:05:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/20] hw/ppc: Set graphic display dimensions generically
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20260222230602.5756-1-philmd@linaro.org>
 <20260222230602.5756-11-philmd@linaro.org>
 <2671f32a-0881-c2fc-7cd4-5c684a4ac43e@eik.bme.hu>
 <80eace1c-1624-1397-f39a-ca31fe6096d4@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <80eace1c-1624-1397-f39a-ca31fe6096d4@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 23/2/26 00:50, BALATON Zoltan wrote:
> On Mon, 23 Feb 2026, BALATON Zoltan wrote:
>> On Mon, 23 Feb 2026, Philippe Mathieu-Daudé wrote:
>>> If a dimension is not set, have the machine init code set
>>> the default value by calling the ppc_graphic_dimensions()
>>> helper, common to all PowerPC machines. Declare local
>>> variables to avoid using the global ones.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-Id: <20260216213121.47122-8-philmd@linaro.org>
>>> ---
>>> include/hw/ppc/ppc.h    |  2 ++
>>> hw/ppc/mac_newworld.c   | 10 ++++++----
>>> hw/ppc/mac_oldworld.c   | 10 ++++++----
>>> hw/ppc/ppc.c            |  8 ++++++++
>>> hw/ppc/prep.c           |  4 ++++
>>> hw/ppc/spapr.c          |  4 ++++
>>> system/globals-target.c |  6 ------
>>> 7 files changed, 30 insertions(+), 14 deletions(-)


>>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>>> index a512d4fa647..d7b4466d701 100644
>>> --- a/hw/ppc/ppc.c
>>> +++ b/hw/ppc/ppc.c
>>> @@ -29,6 +29,7 @@
>>> #include "qemu/timer.h"
>>> #include "exec/cpu-interrupt.h"
>>> #include "system/cpus.h"
>>> +#include "system/system.h"
>>> #include "qemu/log.h"
>>> #include "qemu/main-loop.h"
>>> #include "qemu/error-report.h"
>>> @@ -1557,3 +1558,10 @@ void ppc_irq_reset(PowerPCCPU *cpu)
>>>         kvmppc_set_interrupt(cpu, PPC_INTERRUPT_EXT, 0);
>>>     }
>>> }
>>> +
>>> +void ppc_graphic_dimensions(int *width, int *height, int *depth)
>>> +{
>>> +    *width = graphic_width ?: 800;
>>> +    *height = graphic_height ?: 600;
>>> +    *depth = graphic_depth ?: 32;
>>> +}
>>
>> Sorry but didn't we say that there should be no common 
>> ppc_graphic_dimensions function but each board should set its own 
>> defaults?
> 
> OK I see there's a v2 with the correct patches.

Yeah sorry I swiched back in the older branch to check something
and forgot to go to the newer again before posting the PR!

