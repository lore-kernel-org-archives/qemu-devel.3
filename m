Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D0AC36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 06:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzUjV-0005Vu-St; Tue, 01 Apr 2025 02:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzUjU-0005VX-Eh
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:04:20 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzUjS-0007K3-RQ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 02:04:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso49067145e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 23:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743487457; x=1744092257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YYQZPKrin10s1SzM4YPppgefqBxNl0fndOtyNy2BPLI=;
 b=sy0/aZDfGbIZ2LWwx1Ir1slQamXGUH2QqP+oy/HZfFl/RWODkqKda7/yoGgg30MUMA
 jMUsVJHLYb5J00DfAChrS8I8SOvHTvesALMuRsWrJyxAgnQ6WuRHWkRCDVQHBB1tzFDD
 HVntT2lDyCEBnKGbioRTKGbn8x7wIKhEuwOrr6nTUXv1UphtchkzP18YzBfNbV/mgubF
 sGgR8GyaQFU/sUy0LJI4d8ai/m1mhBZjvCBzTsv1NViOiJ6matGDM9j3cAwy8zLw0nKC
 Cz7qZ6uZw4XDHkFmNvHkzxmPFodaDHYuYSfUwKFh3+LBySbWNQ4zmsospeDMTeo3jBm3
 kwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743487457; x=1744092257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYQZPKrin10s1SzM4YPppgefqBxNl0fndOtyNy2BPLI=;
 b=dvU6Zb18OcsOuBD2LBK6bUKRwoydp1u5O7eiwcHqapPjGCY4i2BR5U/R7Oou8qwL2f
 GLIo4EsAiOb6wCixH30JV3C2FAOgfZAsXs83jTs9Cqb5CmR5kaXS7iM+wn8WjLlY7zMy
 qE5BkEczo4jyYMzXZX8YBnm20LqFUIG0OuWv+1mVK8s/bv8gTayEOZhnIgEWo708l6pj
 zwY/Z6oc3vA9c8N9DYt0TNEG9sNHloeR4bxFGxGkL4/yKNSAHUQulS8aBYC8UPiR4cBt
 b73quZS3UB4f9xgwGTge+njo+JAUYjSBlcFXAEJDSbQwWlR9YydS2Dsvn+3qGUo9Yykl
 tpSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJiIkpZYJJYjlKSEbIesngG9jlBkiUgSf8RnQLowMdYYTI17M/2fmYS6Z6oWW7FqVPfPhhMFHYP+Ei@nongnu.org
X-Gm-Message-State: AOJu0YyuL278qN/zpUooChz1JEK+u3YH3X+QDcc2QA7MrHgBBQIPm/ye
 7urAZgT/5RnoA+hkJf6sVjOtW6+7Ye6nuuMfChuaqJ9f73gW8KJYtUEaWaxZ8/Y=
X-Gm-Gg: ASbGncuDO9txtHxdyVhdK1wxe40KKw+YELxzCO1CMRq7DG3qR/DOrAx6x5EdGIafXF+
 azOL5lGs2S0TuApQ0Q7qXuIIoUOv5fdzV4A9kV1FLoSUW7oUiBJVSXhFdneMEtIMp0NguAQKZKS
 3KPpP7+Jjtqr8b71bwig6sJ2OgFmbyx+IKjNiHJM6F7Vl/Y5MnDKgHiClU5iEfYkP4ZR6/ObqJL
 QdVRYZdPqhsXwrpDNb+ucEPj/Rkr72AX2Xq1goUUX9VRLydoCRjPvPvxRPRdFbP6dSW2pkAtbf/
 rvHLW3lU7gDGYZP9twt/8hll3/nPkXR3DG9zJWtgeeGcPgDRULMqIT2TWsjuGlJKPmLbsVxFthU
 yQvlPazQHG537
X-Google-Smtp-Source: AGHT+IHllcB/2dsKVjZDcvLxmBkDjZ8uyuaake6PXKKuPR6MSLYF+PjP4pq7S8PKh75TyRAiXIaw/g==
X-Received: by 2002:a05:600c:4705:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-43db6249861mr105285445e9.15.1743487457029; 
 Mon, 31 Mar 2025 23:04:17 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fbc1889sm144364965e9.16.2025.03.31.23.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 23:04:16 -0700 (PDT)
Message-ID: <261d4adb-c497-460e-9050-ed15a252ec9a@linaro.org>
Date: Tue, 1 Apr 2025 08:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] hw/core/machine.c: Fix -machine dumpdtb=file.dtb
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
References: <20250401041509.719153-1-joel@jms.id.au>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250401041509.719153-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 1/4/25 06:15, Joel Stanley wrote:
> In commit 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb
> option") the call to dump was moved with respect to the init of the
> machine.  This resulted in the device tree missing parts of the machine
> description, depending on how they construct their device tree.
> 
> The arm virt machine is missing some PSCI nodes, while the riscv one
> is missing most of its content.
> 
> Move the dump to after the notifiers have been run, allowing
> virt_machine_done to be called and the device tree to be fully
> populated.
> 
> Fixes: 8fd2518ef2f8 ("hw: Centralize handling of -machine dumpdtb option")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/core/machine.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


