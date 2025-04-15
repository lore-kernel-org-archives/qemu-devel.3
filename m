Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE534C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 07:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4abS-0000bd-2Y; Tue, 15 Apr 2025 03:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4abO-0000aI-Cq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:21:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4abL-0003cP-3Z
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 03:21:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so47979055e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744701657; x=1745306457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hH8+sIlY1RoZcJVObMFX4ZA0+K3VlclfSxJRg4vxEo4=;
 b=mb54NNc8pcXy3zX78ETe4gJ7oS7ES5pomR7/ttEWjtBiMZb8J9QdO3yOYzwt5HBYFF
 DC2KgKjmp3L21ZdMdvQ+4r1jLvUISQ5cs8h8d7tLe0aC1e2wVlBpIUM4lwzxyRgrA/cj
 uj5McYvfGEvwfh25kL5rsaxAR87d2Y1eSZ1bhaY9n19qLjscjdVL+YSzOp6zpMHC8E+F
 iIpYkeyXByovdcSADI0PeDObB1iFBLw/Ltxf70p8+hqAJVsSXCuebRHPXyBPbOGADeZE
 iW1xOaKPmgMa7uT4aQCxnKD4YguXhzAi2xI+B1b0oAetcvA8G7gdPRXSJpWMhBCJ93hl
 +TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744701657; x=1745306457;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hH8+sIlY1RoZcJVObMFX4ZA0+K3VlclfSxJRg4vxEo4=;
 b=DbQB5Hj3iW9tpbe/UcZQX7wN17IXLKBG8JGIaAAzKOT38TSbMlniLHKXyapDVt28qy
 qKsCIKVs+v96x8/BkjAV6VHL3YjTESZyR3zBMuyL1n+X4aKYdJy6gVg7UWwJzw7pw/NI
 8OuDDMmiKUGPtSZRZX57O1Eufo7ugdHgrd0hwGIi5TbkyvtDLLZMeVRtPyFVLKQvQkiN
 RsShfkdFNgdaWPrHdUfsWIX8qBySlJN4NDf5efL4hKTf7Me3jFib+SpKNNEz97E1dYjx
 4WlFgHslvr1KJW0Mz2ZXiBz54iV1IdTF/TTFpBV5AcOiq2SUc2xn+LbVTOW0a6ph+RsB
 L0HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCBCZX4+0jpFjyJu8Ez67MjQFvt/greASGcdn2QzuBduF5o1UY+tC2HFOsIbnSrmLhjLZipnl9aZR3@nongnu.org
X-Gm-Message-State: AOJu0YyzKKd48J50b5RjRqyh4tbulQnISfF+ZKRGEqkUWpHWnMptSYh0
 AIvfTLdE5llhzhtYJ/VNDyDeXsoB5PCOYl/jEJMxL63cNsaTdUo9d2laG4BAVjM=
X-Gm-Gg: ASbGncv9kbTSSWnn+qtQ3mWC56qKhxT5fbcfhRWgOVOEfdNonVNgnxsu7dy7NVMxiQx
 K0ZTZf7ijPmkZTmYR9S0idRwDx5QZ74gIppxpXyNHk9gx9nPR/Siy6r4JJ7JWxrSX76enCVgTFh
 AFg1J8sDFuzXJ67gXE09DMtQ4lmfg5OZWb0MlsbQdSV7U7jTlUiDr32M6wmfJGFfE4feFlJ2URN
 fEJyMKmSdt95LSOs+hCNfvCPc4ADuGn5yPJcsGMsrxyTbcsN+E2h4MP/MJyFH4h3GYGtasKVHmB
 eEjC4S/4bDCDMxQNVc9N/ABFiiQbnPQ94gVIy9Q7n4Sjn8I46k+cYYHpTKeYuWVzjbIVrfNccMa
 ZIUCsmgb4
X-Google-Smtp-Source: AGHT+IGMKQVqURwl9R+Cxj7iwnbtFUMFNP8OTb/dvkhY2+jVXZZuTDzVjeEZnPKZQibjq2fpiV5KdA==
X-Received: by 2002:a05:600c:1d83:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-43f3a9afdeamr152724645e9.31.1744701657130; 
 Tue, 15 Apr 2025 00:20:57 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecb20sm201470335e9.3.2025.04.15.00.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 00:20:55 -0700 (PDT)
Message-ID: <823616d0-77d4-41b8-b8b4-a7830cb8d112@linaro.org>
Date: Tue, 15 Apr 2025 09:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] arm/cpu: Add sysreg properties generation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-3-cohuck@redhat.com>
 <0fb4cd74-bcbf-4063-bc3b-0e8359d04117@linaro.org>
Content-Language: en-US
In-Reply-To: <0fb4cd74-bcbf-4063-bc3b-0e8359d04117@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/4/25 09:09, Philippe Mathieu-Daudé wrote:
> On 14/4/25 18:38, Cornelia Huck wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Introduce a script that automates the generation of system register
>> properties definitions from a given linux source tree
>> arch/arm64/tools/sysreg.
>>
>> Invocation of
>> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
>> in scripts directory additionally generates
>> target/arm/cpu-sysreg-properties.c containing definitions for
>> feature ID registers.
>>
>> update-aarch64-sysreg-code.sh additionally calls
>> gen-cpu-sysreg-properties.awk which is inherited from kernel
>> arch/arm64/tools/gen-sysreg.awk. All credits to Mark Rutland
>> the original author of this script.
>>
>> [CH: split off from original patch adding both sysreg definitions
>>   and properties]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   scripts/gen-cpu-sysreg-properties.awk | 325 ++++++++++++++++++++++++++
>>   scripts/update-aarch64-sysreg-code.sh |   5 +-
>>   2 files changed, 329 insertions(+), 1 deletion(-)
>>   create mode 100755 scripts/gen-cpu-sysreg-properties.awk
>>
>> diff --git a/scripts/gen-cpu-sysreg-properties.awk b/scripts/gen-cpu- 
>> sysreg-properties.awk
>> new file mode 100755
>> index 000000000000..76c37938b168
>> --- /dev/null
>> +++ b/scripts/gen-cpu-sysreg-properties.awk
>> @@ -0,0 +1,325 @@
>> +#!/bin/awk -f
>> +# SPDX-License-Identifier: GPL-2.0
>> +# gen-cpu-sysreg-properties.awk: arm64 sysreg header generator
>> +#
>> +# Usage: awk -f gen-cpu-sysreg-properties.awk $LINUX_PATH/arch/arm64/ 
>> tools/sysreg
> 
> 
>> +BEGIN {
> 
>          print "/* AUTOMATICALLY GENERATED, DO NOT MODIFY */\n"
> 
> Should we keep copyright?

(if so, preferably as SPDX tag)

> 
>> +    print "#include \"cpu-custom.h\""
>> +    print ""
>> +    print "ARM64SysReg arm64_id_regs[NUM_ID_IDX];"
>> +    print ""
>> +    print "void initialize_cpu_sysreg_properties(void)"
>> +    print "{"
>> +        print "    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * 
>> NUM_ID_IDX);"
>> +        print ""
>> +
>> +    __current_block_depth = 0
>> +    __current_block[__current_block_depth] = "Root"
>> +}


