Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C82C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEJT-0005ms-VM; Fri, 28 Jun 2024 12:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNEJR-0005mZ-57
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:19:01 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNEJP-0004Hw-23
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:19:00 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ec002caeb3so9362451fa.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719591536; x=1720196336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TI3IEG/Ds7652VsL902eP2jJbMHKzbkG7DasuYXH1Sc=;
 b=mPr1kmbKUycc5qniHjzb0PprCmguyURx3/ZYqcuhUp5S0fEEa96w/ciYfxF8Zik2vz
 hV6FtgNAfqA9uwO8pVL97/JAnbD00Y88AN//7REVIwQVEGysV55EnmF5YiTIFWsaVYaE
 nETtb8ihHHJeQ5lTLQnwW+Rzx7TmrBgidlPTxdN7N/DNjTlcLdYCHlwlBSwe9sdvqHU6
 dAcQMWBUq3OHFcVxJ4WncMNE62HD0GOlPPQVxF/41oiBPTzixxDdyKHcmE+eNVCjSptF
 eXqNJEnQUTxYkbRU+OFtfxRjB8PxUAHv/QYMXcf7kfsMFLFYccNiSXSeU/z9NLqqSRfD
 sZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719591536; x=1720196336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TI3IEG/Ds7652VsL902eP2jJbMHKzbkG7DasuYXH1Sc=;
 b=qSnlnjCioQvI3RqSPZCX0x5eBICgU5dp7kIpPc6QPkHkzbE2OsfaqgTuEwzRRzbxDn
 g3scZs6n2Z8a+Egwp5cYGpxTwKIrINHp/J4acn0FxOLEli+ldSPo/un2HGXEL3FQurwH
 dZ4bRSYmoEmya7WFJ4bjF6pHuE37EEKzEco7dAxvPKsT/tbVBdm5Q+NfjmlUztPkYjci
 FEgby+EJN/nsou/knZMHnWVljD9V2NO5sY1GG4DESXhTWqCnA2S1Ck2MBKkR2JM+gjDj
 iD5r/xM1UXSiqB4admrhKvwJJI+jSKc2cA5RSprpWjfETq8y2dH8uJ6rJhIUEBB0sgKg
 nPkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOYUakufCmY7cb1P2PQ8ulNr0POdRdhGjIHh0XgWzk+tSNJW9c+sxY9gS4ENoj3S1uFblnMeg01rtx2Ak1+MkidqvYLpo=
X-Gm-Message-State: AOJu0Yxvm0MC9/0BOo99iiAklpZ6BctRCa5EEmVAzHWbjjhdfSCIx5uu
 EXNfTeEMpVpR9LtVGMFrXkGaZP9gT0TWaSCbOonrdHDAKLWo4aTkNqeqxMW3Gkbrmd9dedXJfao
 MGwI=
X-Google-Smtp-Source: AGHT+IEGq6T4I81lnrsZPg+5JFgKgikopJE41i+ywyC9Wf7/PVEoveFeFx72TmQ2IXuDu8jl+n+irA==
X-Received: by 2002:a2e:a167:0:b0:2ec:4ef4:199a with SMTP id
 38308e7fff4ca-2ec579fefbemr112686341fa.43.1719591536526; 
 Fri, 28 Jun 2024 09:18:56 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0fb3sm42922565e9.40.2024.06.28.09.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:18:56 -0700 (PDT)
Message-ID: <ce27c2eb-2dc3-498b-ae21-46933eae0407@linaro.org>
Date: Fri, 28 Jun 2024 18:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE TCF0
 field
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
 <18343152-c677-4075-8c55-9a2802742a79@linaro.org>
 <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <790bf46c-bf01-b8db-2030-af669cd98c49@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 28/6/24 17:49, Gustavo Romero wrote:
> Hi Phil,
> 
> On 6/28/24 4:08 AM, Philippe Mathieu-Daudé wrote:
>> On 28/6/24 07:08, Gustavo Romero wrote:
>>> Factor out the code used for setting the MTE TCF0 field from the prctl
>>> code into a convenient function. Other subsystems, like gdbstub, need to
>>> set this field as well, so keep it as a separate function to avoid
>>> duplication and ensure consistency in how this field is set across the
>>> board.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   linux-user/aarch64/meson.build       |  2 ++
>>>   linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>>>   linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>>>   linux-user/aarch64/target_prctl.h    | 22 ++----------------
>>>   4 files changed, 63 insertions(+), 20 deletions(-)
>>>   create mode 100644 linux-user/aarch64/mte_user_helper.c
>>>   create mode 100644 linux-user/aarch64/mte_user_helper.h


> So, how about:
> 
> diff --git a/linux-user/aarch64/mte_user_helper.c 
> b/linux-user/aarch64/mte_user_helper.c
> index 8be6deaf03..a0e8abd551 100644
> --- a/linux-user/aarch64/mte_user_helper.c
> +++ b/linux-user/aarch64/mte_user_helper.c
> @@ -6,7 +6,9 @@
>    * SPDX-License-Identifier: LGPL-2.1-or-later
>    */
> 
> +#include "qemu/osdep.h"
>   #include <sys/prctl.h>
> +#include "cpu.h"
>   #include "mte_user_helper.h"
> 
>   void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
> diff --git a/linux-user/aarch64/mte_user_helper.h 
> b/linux-user/aarch64/mte_user_helper.h
> index ee3f6b190a..07fc0bcebf 100644
> --- a/linux-user/aarch64/mte_user_helper.h
> +++ b/linux-user/aarch64/mte_user_helper.h
> @@ -9,9 +9,6 @@
>   #ifndef AARCH64_MTE_USER_HELPER_H
>   #define AARCH64_MTE USER_HELPER_H
> 
> -#include "qemu/osdep.h"
> -#include "qemu.h"
> -
>   /**
>    * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
>    * @env: The CPU environment

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


