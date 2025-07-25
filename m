Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2839CC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMYX-0005hv-SV; Fri, 25 Jul 2025 13:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufMYV-0005bp-9m
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:50:03 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufMYT-0000IN-Ag
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:50:03 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b34a6d0c9a3so3048120a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753465799; x=1754070599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a3ixWOFQSdtnMlAkMQjP55eepzrSw0REYSmNy/7+pUQ=;
 b=T3kXwXEU85G3IVq2zDdHsedep0jW281E43MaqZYZHAm1Pb2ARKdErau7ghPWfeMZ6i
 0ju9XABuYLLMDMeZI+BZA7OQWHR7sSbxe3p5pi66AJ7MBLxmJb9JDI9xqWOthxTxvchl
 T9+a4FJnnB/yLxemfnpBxJ47785prYNCtHWl4Mej+vVRPyHFmJRdJhtBNVlijVBVgSAf
 FwzCsxCZLhQVkyu1fxjqJQ0oQppqnadIDmd52YEIxEUNBS6JkwInXYfbjhmSajWr90yx
 jNMBUFxLYq0u8vRSabqqMZFMLG9gv1OC6MPBQAYFBTh7I1h3FfFYAsj63E3yYRsw52ic
 rnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753465799; x=1754070599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3ixWOFQSdtnMlAkMQjP55eepzrSw0REYSmNy/7+pUQ=;
 b=Yf4AdXhOczM6VDmJ/ajod+N6/5Cd0fJnGwIrugi6cUeZZlkH0TqDAE4gAqNkjeDHZB
 zGrVmgOJR62oC6vubpczE+rjYj5v3gpPe6o2o5zlfGto3mozP46Ty4lk5GsD8c4ArVUb
 jLfyF/EnxdNd+/idAIIybNcukjDeb3iovZ/nKXkFFXwZHXFqdtXQsiyVKr1tVnfugD2g
 RZVO7xWAmMpP66q3mVtHjFJIiEsScD2v+40BcS46MslgP6V0FVkDsQJ/yxeRPBEpjQgp
 EaCAa4tC/t6RWBLkANC+zwzk8dxUU8YWsU29t9wdr+n7PnS+MwAZQ/5+/9GI9zu490Fl
 WHMA==
X-Gm-Message-State: AOJu0YzZ91i07fknNuwl3VEN1WIMbkudYZh2PShedj6Rbb0G06P4fhZ1
 FmgEzJYWarI0sm5PaUQ3fDCFicyJmPU5K0IMRy9xE/FHIDDFFjMHhhLbEMIoojS26nA=
X-Gm-Gg: ASbGnctoIpx2ClrwYuIakSwYe4HHU2a6+DDCxSoUucDLeJaBAP4Gs+CpaMopoU9djb0
 tRaAzRgz8+zowMRqa+xXpougcs1Og2fH9Ehmzd2+udv3UGHwXmWhry2Ai7fcpFIOdohCkZgn6g8
 o3vJVS6aPTlxWF5w2ENnzGN/ENz5LyZMF0q9NqEBe6PmNtCAYynxrl6cs98LRxuu0TcrRb9Nd29
 ykbZkMiOwncMXTbO12xItv9c+KGuUGvY21E7fBiioErJeyKcpvJ6NZOla/eOwlp75YW9DPUm5yg
 Y18pqdbtM5VhcINxIhZ8PgpgcNvkUgf9+xoLyC0d+78hiwPRRA/mmupv/rZX4WT0LI7GfyE6POS
 ws0Xee+snt1/GVfBt+J1iAHJaiGAyOG9f2lY=
X-Google-Smtp-Source: AGHT+IGA6nzBTN5x7ahi8V8FicF2CRu4Ub1bpooNS+QJhQiHtXf9qw5HzP7eA6P6xsTpgfOVT/UE+g==
X-Received: by 2002:a17:90b:584b:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-31e77a00822mr4638684a91.17.1753465799215; 
 Fri, 25 Jul 2025 10:49:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e60969c5fsm2868233a91.0.2025.07.25.10.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 10:49:58 -0700 (PDT)
Message-ID: <5577bfdd-2441-4b6f-a58a-29bc2a6850c7@linaro.org>
Date: Fri, 25 Jul 2025 10:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen/xen_pt: fix missing include
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250725165749.3893240-1-pierrick.bouvier@linaro.org>
 <aIO9SHJkDPnrfAHf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aIO9SHJkDPnrfAHf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

On 7/25/25 10:22 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 25, 2025 at 09:57:49AM -0700, Pierrick Bouvier wrote:
>> FAILED: libqemu-i386-softmmu.a.p/hw_xen_xen_pt.c.o
>> ...
>> /home/user/.work/qemu/hw/xen/xen_pt.c: In function ‘xen_pt_need_gsi’:
>> /home/user/.work/qemu/hw/xen/xen_pt.c:783:9: error: implicit declaration of function ‘error_report’; did you mean ‘error_report_err’? [-Wimplicit-function-declaration]
>>    783 |         error_report("Cannot open %s: %s", guest_type, strerror(errno));
>>        |         ^~~~~~~~~~~~
>>        |         error_report_err
>> /home/user/.work/qemu/hw/xen/xen_pt.c:783:9: error: nested extern declaration of ‘error_report’ [-Werror=nested-externs]
>> cc1: all warnings being treated as errors
>>
>> Fixes: 012842c ("log: make '-msg timestamp=on' apply to all qemu_log usage")
> 
> The problem pre-dated this, so this should be
> 
>   Fixes: cfcacbab38e (xen/passthrough: use gsi to map pirq when dom0 is PVH)
> 
> See the prior posting of this fix last week:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04831.html
>

While true, this was not a problem as error-report.h was still 
implicitely included (as Markus pointed). We can debate where the 
regression comes from, but from git bisect point of view, this is the 
trace one, at least with the simple "./configure --enable-debug".

I don't mind changing the fixed commit, or even removing any Fix line at 
all, but we just need something upstream merged as soon as possible to 
not break everyone build.

>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/xen/xen_pt.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
>> index 9d16644d82e..006b5b55f24 100644
>> --- a/hw/xen/xen_pt.c
>> +++ b/hw/xen/xen_pt.c
>> @@ -54,6 +54,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>   #include <sys/ioctl.h>
>>   
>>   #include "hw/pci/pci.h"
>> -- 
>> 2.47.2
>>
> 
> With regards,
> Daniel


