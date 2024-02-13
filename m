Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0993C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 16:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZvD0-0000tS-PG; Tue, 13 Feb 2024 11:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZvCz-0000rN-C5
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:00:33 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZvCx-0007Rz-0L
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 11:00:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-411a5b8765bso9194835e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707840029; x=1708444829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mu8vViIWUEygbMRgzg14BREK+eY/1nfzwFYTeAU/TNs=;
 b=HyNsfbGtll/NoxDIPCl+yBRu17csw6Px3VseaZOCbRuyB7Gj30L1GDh7plqAfdMGm/
 G5s9eXCcP2YkvH/F6GRZqq+hBPkRekQEErNnWKuQJ4lN0zOwyMnPP9KtxZmJ3OOUIMaG
 RttAaknYPJqkl7PQLwTpWXKPnUP2Pzbq+xZaroATqV/OXjZiCyytZCBBtsjK53/6T7Ul
 vJsrCtgVP4FzIY9YNw0ZMeEP/p5H7ijnJc5QFLUR9cGJApvRBObAU9U0LfkBa/bj5LgR
 o66uYNqlb8BeZKL4YIav+eKFTYNtrjVqgJmEqr4hvj7W1k3y1yD6Avi5JgBw+FAq+J+z
 gLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707840029; x=1708444829;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mu8vViIWUEygbMRgzg14BREK+eY/1nfzwFYTeAU/TNs=;
 b=Y5eAS/9vtILJmKL7HcxgNtC/c3UzKk4yvzl3rNY7hQ/P+pN/aFNxnOz6DVck5xTa7x
 CaPs37Fxew8OPkhj2rGdzhkTGG4UrtcEeymMKOS8CLP7VLTIQN7SB9purqjJtf6Pgjf4
 2gQ9TWnP5LybLzmjEml3GwikcG7zYlyLtQDNQOaFfq27eno79qnwsC7/Q/6xEeVYlPp7
 Gc42yFZy9vtkRH2gztFnsMzPNwJYioOlJBMrZn+WZwFiht/WnSmTVx+YXmJrSg962f/8
 r7AJyIg7ktvvGsLtMnFZAN41Zco7kC5U+QPkdjgVx3MOU3fjmbekNSs1WyxwnjmVGtEf
 nXGA==
X-Gm-Message-State: AOJu0Yyn8r3Jjz7OfS3rmPCyON9NjDlx/orpzZXkUebMcvE44/uNN8UZ
 KYYVmKRtqxKLTwV5cdLSs10pOQ2X0Sw1TpnAsxu6JKxQhT3TsUzfEDQykzXvTCI=
X-Google-Smtp-Source: AGHT+IGgT4E5/llJB1Kb2gyIaJJIKeiRUFIGQfh58Z4QxeFxaXa5+yq2txpwQ8+RkeYZGrRirro64Q==
X-Received: by 2002:a05:600c:1d1f:b0:410:e91d:fa6c with SMTP id
 l31-20020a05600c1d1f00b00410e91dfa6cmr2834277wms.2.1707840029225; 
 Tue, 13 Feb 2024 08:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtcxhjGmbu6jtenvm7ZjEnJvxBW1x5Cjhjnl109YBkRfF4hTMOuCO7EPWKfaOtvKMJMTzvnIYkylDGvLx0/+82Gu4rHv2ix20MMKY1BgRLMiLJDot7y4UhyD6Gtzbit7YMHBKeIDCwnodyD+9Rctea090IybCUJAyyVvQ6Gre+Mmi0xL9OHgYex57kSQPjjlu9hx/R80VdlatA1Q2GT6ry6AO6lMy4p+Z4KYvX3W6V6XftuPJkPCNTkSEEt9KEa/h06HlXzGNjNOIhyVFySeULwfyeUDbrkjkjvfHijUFnO5lAY0a1skRb
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a05600c4f0400b0040ecdd672fasm12217819wmq.13.2024.02.13.08.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 08:00:28 -0800 (PST)
Message-ID: <5e872a94-d4ab-4fe4-afe1-ffc952be8116@linaro.org>
Date: Tue, 13 Feb 2024 17:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386: Cleanups around 'hw/i386/pc.h'
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org
References: <20240213120153.90930-1-philmd@linaro.org>
 <20240213105455-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213105455-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/2/24 16:55, Michael S. Tsirkin wrote:
> On Tue, Feb 13, 2024 at 01:01:45PM +0100, Philippe Mathieu-Daudé wrote:
>> Trivial patches removing uses of "hw/i386/pc.h".
> 
> How did you test that it's indeed unused?

I put and #error in hw/i386/pc.h and built :)
(I'm trying to remove the PC dependency on generic devices.)

The few generic devices left are not as trivial.

>> Philippe Mathieu-Daudé (7):
>>    target/i386/monitor: Remove unused 'hw/i386/pc.h' header
>>    hw/timer: Move HPET_INTCAP definition to "hpet.h"
>>    hw/isa/lpc_ich9: Remove unused 'hw/i386/pc.h'
>>    hw/i386/acpi: Declare pc_madt_cpu_entry() in 'acpi-common.h'
>>    hw/i386/port92: Add missing 'hw/isa/isa.h' header
>>    hw/acpi/cpu_hotplug: Include 'pci_device.h' instead of 'pci.h'
>>    hw/acpi/cpu_hotplug: Include 'x86.h' instead of 'pc.h'
>>
>>   hw/i386/acpi-common.h   | 3 +++
>>   include/hw/i386/pc.h    | 6 ------
>>   include/hw/timer/hpet.h | 2 ++
>>   hw/acpi/cpu_hotplug.c   | 4 ++--
>>   hw/i386/acpi-common.c   | 1 -
>>   hw/i386/port92.c        | 1 +
>>   hw/isa/lpc_ich9.c       | 1 -
>>   hw/timer/hpet.c         | 1 -
>>   target/i386/monitor.c   | 1 -
>>   9 files changed, 8 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.41.0
> 


