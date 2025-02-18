Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E347C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkRx2-0006Ns-6J; Tue, 18 Feb 2025 13:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkRwu-00067y-HT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:04:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkRws-0005FQ-Qs
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:04:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43989226283so14909765e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739901837; x=1740506637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdkLmF3I8muLI0sY/3TezjdXKigIj6KwAQBVfv9Ix6g=;
 b=YGZLXveOlkEAICfKzGz99ncqoh4ha4TEIdarjQ7IEfsqrCNUP/6+/qUZVPFXQ00QUD
 rJunr9xomCCLdLVu+CUE9Ruw+GPggdgQHrcPDfxRyNb18MKZhvCGXMsFkSl3pgZM34XT
 rnsRNoUwROv2rek7HDsWk3dxuhe5f4C8uT/VbeTAvIgCtBQ2lsA15lpfoYXQK+QNEuws
 XUyoDZMo/cafCmb6MXttb39wcDWvFPXg+94iE5GutwoNrxd9nK/NNY4O5Gt/T0L7QVVe
 LO4tSgzedilPPbe1yUvGQKAkAGGj14PNjPa8djND9XAaA8YXNROgNe/4STSl4/uzXyH8
 UeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739901837; x=1740506637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WdkLmF3I8muLI0sY/3TezjdXKigIj6KwAQBVfv9Ix6g=;
 b=pd/0dQqPYd62NDNBg3HJoqNpHgI2NsaiqfAlwNKbS+4KITdld0+S8mL77FJcfj2g6x
 j+Gz+FHrU0udlt0HC385r1JrMac2oyQf8wckuryjJNELglKf915sQnAJnRj/N6h93rpB
 87h5lvj4AEMMTXg8kTgN4iTouLUJYZrWH3D329kUnTPjuh1ZyZRLHz54H0Zc8JpDfZ40
 BJTPdA8EPJM0Z+kKt2kwRREBLqJrHANe8pqc/meC/NYcqeI+byuwRlYzE4AtBl2oJhAf
 l/QqOX+VvTWDGqYUfVOeJUfv/Z8yhlZUC9vlnXZzQ5Q0HBh0URHQlHUK/mhB644LYq8A
 /IUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQNqj+atSCpIBt96Om55k5jJFUeDBBaNacgITC5RW/WJ9ktLsV4nBI7WCEsmm6SZ3y6ZiHKUjBNv68@nongnu.org
X-Gm-Message-State: AOJu0Yz0xkOdrVyu5b4aY/sfrY6I4TjnGPL28nUX3tIULXNM62QUR/AK
 cIlOGDJi5yPULumLCAH4VFkU3DEaIggKUDdS59oUnWuT1KrSdVlAwTsOzhs9ltl30hW3J4OZ22M
 yg1g=
X-Gm-Gg: ASbGncsCwZcD5vThbY4fQ4h+lQpOwGtzn2aPVnZSxQvJTdHhPe56B/QF9SaKxSHSm9B
 qdKlWs7QiGcuo8KeIugLMLN9F4QU+aLWWaooUtZGpG6P1oX/XCni0STvZmNmZdU1EVDwTrvLs2l
 36+RDgft/vi5635yGBSdM7czBeKTkLa2PTYg55j25Ovhz6hhYT6FkTjmMzNRRT1ZPKYTAoKmB2m
 M7eEo+y2CtwrlvwkAZtkzFu3kbJEq0KhDjYLn/UIHN9W84F7bUNhLCc12/K7Ku7MS2yLujJKn0K
 YgvjOBty4mjv7aeFYyUGC8XxCb+aREA3562gNAQpGVRYIKSCbRYiGoenHOI=
X-Google-Smtp-Source: AGHT+IHZ8G68UdcqxChjF5EYtQBC/YdmXtBT8iRAaMEBbOrvtEimGtKtr2iUsIIFA2tvujF8gMNkew==
X-Received: by 2002:a05:600c:19d0:b0:439:66ba:bc07 with SMTP id
 5b1f17b1804b1-4396e5bae17mr175622915e9.0.1739901836704; 
 Tue, 18 Feb 2025 10:03:56 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc8b4sm15830655f8f.50.2025.02.18.10.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 10:03:55 -0800 (PST)
Message-ID: <e87a7704-d414-4683-8ae7-0418ddcf61d4@linaro.org>
Date: Tue, 18 Feb 2025 19:03:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/28] target/mips: Use VADDR_PRIx for logging pc_next
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250218170839.81501-1-richard.henderson@linaro.org>
 <20250218170839.81501-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250218170839.81501-2-richard.henderson@linaro.org>
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

On 18/2/25 18:08, Richard Henderson wrote:
> DisasContextBase.pc_next has type vaddr; use the correct log format.
> 
> Fixes: 85c19af63e7 ("include/exec: Use vaddr in DisasContextBase for virtual addresses")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/tcg/octeon_translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


