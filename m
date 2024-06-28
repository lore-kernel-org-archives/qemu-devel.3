Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477CCC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 16:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNEbZ-0004t1-Fg; Fri, 28 Jun 2024 12:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNEbM-0004pq-Ec
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:37:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNEbK-0007Fl-HN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 12:37:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4256eec963eso5409715e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719592648; x=1720197448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xpw5m5WnfpE8whE4dgDf3nv6xN6hBRVBgVHir/fOwr0=;
 b=suRZibdDp7HQk+WccLxZv9ABhZZANgbssC+yCdckF51XMALv8tx5ccWo1yEsFNpvhR
 PhH+y+PHoy31OVeehezi6X1Vy1MgTTagAbW0YejaeK2wcK8B4lDmJah+yq6ha1gRgA7h
 oZOQKzpoDngwvJNkNLmsJupd1vfaylHW+0Jx70uyVBxj3iyPsXJRUgTjMhuOdPD1ujip
 Wj6VB7+jweWVY74/TEODwg5jQyUsAMmg/kJ3+k9hmcDtUihNw5IMNS1vcIGSUDezQFyQ
 tBCwiL++txmOM68FfwTUrYCp9DTa/goj0urG6Pv70OzIOGUyAMU4aa0vzpWr8br6ja+X
 XeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719592648; x=1720197448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpw5m5WnfpE8whE4dgDf3nv6xN6hBRVBgVHir/fOwr0=;
 b=HrH4gCPYrQ87MqA50Gmq7v4okW7POnklf0G9F7zmr9sVlLoi4FqhoGFJRxkNVdol9A
 wKv4lG48VTYfyBnYOU9KHxEDhO22D9VWsWe9PxZl+B9oh84bflM37bHXqp/VTPmsTESk
 3YDJsICAbb8mT9js3Hv3AdJPKASnJH6LWflATkNTN2stBE5Qrd3bQEVX9YWelGt8c0NG
 0sIVxeq70dumQ2jAshgIzUu8H1XkriH4l64vQop9XoQ0C+bU09zXfZ6BM4eP/7SsVtj+
 1C78WrXPFVZbKP8loatseJqIo6cmQ7WgTubFcWIfzsvDvtKOQBu5NKT23ds7n1wckoZX
 /LEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxXurrxiPOVq1BDP6Aj9Vpm5fqQRf1dRhhHO436g2SyiK7AHG/pU6dO2AGjl8i4BcPn+VJ5CANL3iwHRY9n/HiXsqjCCU=
X-Gm-Message-State: AOJu0YwuW/gLZKSLRJcsifpZzJ9+88tnAw1WdGZCB+EFWrs6NJrHjsy2
 JRQBXx4a4y077h2uFHYt4kKt/V3xn6No3cciipDkucfVYN2Ey5JHv5+PdMzUEDo5J1hHTo+ga/w
 AIl0=
X-Google-Smtp-Source: AGHT+IGF7Bk/LKCwqws+RsfQjhGIQDqBI8TpXVY0fegMFGzp4GenrGJnrqwDYDuTnrHTki3AJk2fIQ==
X-Received: by 2002:a05:600c:5d5:b0:424:a779:b5bf with SMTP id
 5b1f17b1804b1-424a779b679mr74468705e9.20.1719592648046; 
 Fri, 28 Jun 2024 09:37:28 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256f55c4b5sm27770395e9.43.2024.06.28.09.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 09:37:27 -0700 (PDT)
Message-ID: <83667101-daba-43ea-ba33-1df547020cd9@linaro.org>
Date: Fri, 28 Jun 2024 18:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>
References: <20240619124903.56898-1-philmd@linaro.org>
 <42de8f25-3624-4e7c-b38c-ad8e3b8e61a4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <42de8f25-3624-4e7c-b38c-ad8e3b8e61a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 28/6/24 16:31, Richard Henderson wrote:
> On 6/19/24 05:49, Philippe Mathieu-Daudé wrote:
>> Merge gdbstub64.c in gdbstub.c and remove uses of
>> target specific TARGET_AARCH64 definition.
>> Small step toward single ARM/Aarch64 binary.
>>
>> Philippe Mathieu-Daudé (2):
>>    target/arm: Merge gdbstub64.c within gdbstub.c
>>    target/arm: Always build Aarch64 gdbstub helpers
>>
>>   target/arm/cpu.h       |   8 +-
>>   target/arm/internals.h |   2 -
>>   target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
>>   target/arm/gdbstub64.c | 383 -----------------------------------------
>>   target/arm/meson.build |   1 -
>>   5 files changed, 364 insertions(+), 393 deletions(-)
>>   delete mode 100644 target/arm/gdbstub64.c
>>
> 
> Are we attempting a single binary for user-only as well?

No, due to ABI constraints, right? I did a user-emulation
smoke build, no failure, did I miss something?


