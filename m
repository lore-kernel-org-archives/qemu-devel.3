Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3216C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 11:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPUp-0006Pv-KC; Thu, 18 Apr 2024 07:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxPUo-0006PR-26
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 07:00:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxPUm-0004oF-AD
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 07:00:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-344047ac7e4so1168211f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 03:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713437998; x=1714042798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EtlfdY6Xf58huJb37ZJOJ9IVtzcXeK+XEq/SP6G01VM=;
 b=v0o/zSozvoGZ0hgTNrkFIkTo0VVcI04keUxXZqpZE6md5sJo+KsQWJicUjXIQjiYQQ
 Rk7RtPrcqIO0s0hGZ1xN24rHKGDAy3yGi6V6aE+liBrTO0k5AYd0GugDTcVhNuatEead
 YxheIfA2nu/tzCdpqvyVmeI76bx4mcFrsFDn097c23XyT2GDznAIaRcPw+D9Kjm2El0+
 v3WCIoSXKH2o5fn+D5wfxdhZupF6L4+sLBIBXRKdUrTS8cS1dm/XEodiG8sqBP5oXdQ6
 xc88UqHLVGdamJrmCgmW8ybps9meEPfgxIoRG6EUBHM84IlCWM15qQrR8Hy/G22HOaPO
 /GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713437998; x=1714042798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EtlfdY6Xf58huJb37ZJOJ9IVtzcXeK+XEq/SP6G01VM=;
 b=HiKv8fGv/0ydL1sFiw1mX4ipdp7CYCiHV9qo26cMSUibw2zLfC2wDmR4+zvyoEM73/
 JeG02b86zX9QDM+h31yJ2C7JapKuCYEvIj5tTpO8FlnPHgPLtH6DpfEMGEnRqUYmFT+Q
 mnTBiWOAOe+JfJDLiHj47b2FQs6ydFdU4VDLVho8wNXfDIUOFLuCeba9Duzy3Nso5o3e
 FnlTElW5+4JCH5kXELhvI1VnAx06A/JqS/v8H/aDrqoHG+157BSYRGyGRp0i40388dH6
 1pRL+3JNDTehrAhvBZMVd19U3MdVYXQbnAE3K7qCqWlR/YtyYSUSElYTGLvqBiJfpMdl
 RGnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeGN0wg/w71o5/uz/FhDJEzuxJfVYW2W/+yqRcwD1nH0AHknBVUoNxCZ+qvKfEPiUOSnQaK26jtItgK9gUuc4QAi2GZkA=
X-Gm-Message-State: AOJu0Yzj246egDXunsEcvvcKLMwdmFcPR9Auhz0OMxUlzA7QRQwCAAse
 4dZ8HNoy9MkPuoNWPbB4VeROBhj8r8NGA0PhuwlGJayIuoMlIW0HbGHu6ioafts=
X-Google-Smtp-Source: AGHT+IHxAh80/DRFywZr5Rw5ewY5dVTHIgBMnPM754hpUtPw8urvYNrtVZBw/Q75NR2R8oHNXOiV5Q==
X-Received: by 2002:adf:ff82:0:b0:349:cadc:62eb with SMTP id
 j2-20020adfff82000000b00349cadc62ebmr1531656wrr.28.1713437997909; 
 Thu, 18 Apr 2024 03:59:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 u26-20020adfa19a000000b00346d91ddbe3sm1589858wru.9.2024.04.18.03.59.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 03:59:57 -0700 (PDT)
Message-ID: <42c6471e-8383-45e0-85ee-e20ca32ecbad@linaro.org>
Date: Thu, 18 Apr 2024 12:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] semihosting/uaccess: Avoid including 'cpu.h'
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-10-philmd@linaro.org>
 <48f21287-d741-4936-9395-88356260c93b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <48f21287-d741-4936-9395-88356260c93b@linaro.org>
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

On 17/4/24 21:14, Richard Henderson wrote:
> On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
>> "semihosting/uaccess.h" only requires declarations
>> from "exec/cpu-defs.h". Avoid including the huge "cpu.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20231211212003.21686-6-philmd@linaro.org>
>> ---
>>   include/semihosting/uaccess.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/semihosting/uaccess.h 
>> b/include/semihosting/uaccess.h
>> index 3963eafc3e..6c8835fbcb 100644
>> --- a/include/semihosting/uaccess.h
>> +++ b/include/semihosting/uaccess.h
>> @@ -14,7 +14,7 @@
>>   #error Cannot include semihosting/uaccess.h from user emulation
>>   #endif
>> -#include "cpu.h"
>> +#include "exec/cpu-defs.h"
>>   #define get_user_u64(val, 
>> addr)                                         \
>>       ({ uint64_t val_ = 
>> 0;                                               \
> 
> 
> Does this actually need anything besides exec/tswap.h?

Actually what is needed is:

#include "exec/cpu-common.h" // cpu_memory_rw_debug
#include "exec/cpu-defs.h"   // target_ulong
#include "exec/tswap.h"      // tswap32

Fixed locally as:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Wed Dec 6 16:11:15 2023 +0100

     semihosting/uaccess: Avoid including 'cpu.h'

     "semihosting/uaccess.h" only requires the following headers:

       - "exec/cpu-defs.h" for target_ulong,
       - "exec/cpu-common.h" for cpu_memory_rw_debug()
       - "exec/tswap.h" for tswap32() and tswap64().

     Include them instead of the huge "cpu.h".

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/semihosting/uaccess.h b/include/semihosting/uaccess.h
index 3963eafc3e..dd289af8dd 100644
--- a/include/semihosting/uaccess.h
+++ b/include/semihosting/uaccess.h
@@ -17 +17,3 @@
-#include "cpu.h"
+#include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
+#include "exec/tswap.h"
---

