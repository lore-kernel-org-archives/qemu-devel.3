Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EE2C98302
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgsdZ-0004JX-QX; Fri, 16 Jan 2026 17:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgsdV-0004IV-ET
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:49:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgsdU-0007uW-3T
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:49:45 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a110548cdeso17952495ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768603782; x=1769208582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNDoo/uuZxNmeJ+znfqBny/4DOvQJzon4fHjGV9VJmU=;
 b=mtFxMEc/IwVquxm3M4xIb60osoNvvutj0mvrbKv9fPw9K3ZNIgMAgOrh92LTIlnVMR
 Q7b7lc4aLuz2JhoOlLL8vx4iPLa5qucuNaSHNiumj4L/ATSp/OxfSR2l3xcbATPvTKsK
 ir3i2qcLwKIUTEDGDOQ9c2sMWkvuBxMPu3MgXbF0oxqMEsfIBqb4gLGswthg3QjWmTn9
 LW6HTulw80Di1O9JyMmgDg+mw7b/PnfhS0MCqmbsanLAOuIDEk+3Hvt86mrtq/ZYPpXQ
 dt0ha98loqiuGJfKAswS+HeBBxJKFQl8Kc/7uuMdvRL2W5YGo6oJJtJd+iloWrHdwwAA
 IcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768603782; x=1769208582;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GNDoo/uuZxNmeJ+znfqBny/4DOvQJzon4fHjGV9VJmU=;
 b=YDeiktshabe5FV920uvQh+itnS8ps1F5mtsIDjTuRI6RkzatJY9KmrF71HrNx+IGX1
 H10oTBMNBUclikg9i9UlgtMyNhJplqBQtTCDyJ97z26pTO7FPLb47bIgq1bWsds4Fe+Y
 9R7pY67+BCxO/XLhuWBL+fdfC8EN6cHcBls+9xcKBhOLCo2TWb9wfMMuz2Z/qzhk7q6f
 3dBBQu4r4jvvGZLp0OV/NqUqmwEQRNHunt+4Yvms6D1ZO8ZwuYpa1CzcHjs/ClWaWEHH
 zV6nOyaE0aVbCgEMr/NcCt/SpxcIzivG4CYP+NM5/asouEllPnIDvDHB2W1bmViVWXnO
 xL7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNb1a9k+hGwFudnX+5/z6xK6UOCPaNvFfS9wTyoRYgZ1v2YfjUJipcgBwH/keo4ptA6X0t12caTc1O@nongnu.org
X-Gm-Message-State: AOJu0YzOdaKDbnGwhOvyQPMjVLf9hVyvESyXW4Lq3j58vh84oeAv6Mep
 nMdtpTGdcPI2c+fg3AzkNb1eWjOrVNDnIwga/9X0C0NvVbHG/05cC3qJbsYYbHK3aZk=
X-Gm-Gg: AY/fxX4jo2RpXheJo8Mj/uLAUKSLGbl+o1tcaC6DBKnTJqXZpSVGhhuH11lAXu+jAAP
 UIXCyVAldaAYmnntwv725Jl4OUtlj+tVnFnWleScTDa89aQGNi9Gp6RzbwZ4yJ9LULADgdCzTnv
 T26I+fUc0WFZGUBY2iKJebhiGVCL46fqWUd0hDWYC0teMTJ1siRaeWO9KQE+kjiMKCTobDcpMkV
 5EtSt/+eQYOAurqtk17mgABb38GCUC9BlWsM3Ha2SVeKAyiM8vRnIwwxEgg7SCaqXmXSAJDikE2
 0vtOymUYUk8OdzNKWP6A0J5zUi+EDvN8OQTaAEL2cOUe/wCi0V8lzcwEFkeEUDYj4gbgy5F3kXs
 NOkz+z/8JCLoUbEbRlVchptH+aL5vQNjmEVqZjxl6oNcTRk9mK3H9IoIxiYf+l7rREqH9/h0gAm
 4xVOXZFchP1Bo4PH3FjlFn/Sdy7/CwYpJIBBh3wPcc04NDNYOdtuhsmLhA
X-Received: by 2002:a17:902:eccc:b0:29f:1fb:730d with SMTP id
 d9443c01a7336-2a717552deamr45658695ad.25.1768603781557; 
 Fri, 16 Jan 2026 14:49:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941b915sm30249635ad.90.2026.01.16.14.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:49:41 -0800 (PST)
Message-ID: <b7b0e9e4-b84e-4a6b-82bb-6648e65d5dca@linaro.org>
Date: Fri, 16 Jan 2026 14:49:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] target/i386: Add a _MAX sentinel to X86ASIdx enum
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org
References: <20260116185814.108560-1-gustavo.romero@linaro.org>
 <20260116185814.108560-3-gustavo.romero@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116185814.108560-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/16/26 10:58 AM, Gustavo Romero wrote:
> Add a sentinel to the X86ASIdx enum so it can be used to compute the
> total number of address spaces supported by the arch.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/i386/cpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

