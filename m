Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D958DC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfET-00040u-DM; Tue, 18 Jun 2024 16:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfES-00040m-Kq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:15:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfEQ-0000wC-Nx
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:15:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-421bb51d81aso44830405e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718741705; x=1719346505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nJA/kqdEwzKX8aphyk/8vbD2ONyXpFAT/PLQNLW/yCo=;
 b=ZUzs820teczH0yXq9lmrQwXBo030FTFFPUak2wzTIjGhqsRM4z2PLXh+lFlzhJQCfN
 n5YzAwTYXfmsdALjV/yNnZXVouxEZGUrwv7KtDQmHrKEl0DCN9WUD4EWHgJTtrVZR1PX
 6ZmY8QABC/uHEkDroKwn+xQuuzNpVvlfK1LvwF76rME4Uk4JO6Yw+3+RL4o2wzsbro+h
 RPrFh6uXRBRD4xD/v1Snp0YITxiYsGhaeT5z3LRWI1rAIYkgxmI8sqQ4iFzze1idNytt
 a0fVikgyib/uMkcyy8P4RrF4o0Kod+IIQ+Vj0YTDAgpwHzW239yqD++NU00w+r94FClb
 sb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718741705; x=1719346505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJA/kqdEwzKX8aphyk/8vbD2ONyXpFAT/PLQNLW/yCo=;
 b=l6uYs3QcuwTZ/xWB1DgCDfCQAvI/Oo5BKVvJCct4FRiawMdwvaxkkkEZe45zOqq/cx
 y49XOHfjGy2yqBFtSagQ1Jo6Cprzz+qlHMFQi+c5mnKGASAfWCLwshc6FvTbUvE9TYW5
 FwvVnxp15ijDJknyfmzI/M3YSyVvBLHj9j0TOTcwOfwg4E7V0ACzMch/qp+/jxw/RD2Y
 dCL4txpU/zqG3HKVk+LKsYPWU0VmQulpQmpBoPzRbO57hRAQAAn11MzdwJfUHlGcPkY3
 gNFQ20U1ksL/Qt1Gw1adzw+9rGiFK2oxNI+uhTPKpp5sq1zBPNlCI6ZEVEceAs7ocS3E
 wt8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvpRN1bSgYkVvOaB1lGtd/SNV/ux4cNdJ4VTwUpFw9xZ9MiIJ2XukWXFDFAld9BUlWJJ/OURIfC+h6oAQfOwFurcy0C7Q=
X-Gm-Message-State: AOJu0YxyqHvsHiWjDDv1IQ29WFyLpt53ys0pjiiHsHLlMEK35ndk8sMB
 SkV47MmxmK95QXwhTGSwU9kicx1hxKjeCRQbvqH4BySy8IYrzrsvjFjMa29JIrQ=
X-Google-Smtp-Source: AGHT+IFD12Kn+AjUUecTOX2/dDvBAWPwPxGDVmyqeCbrfucxKUHXs4SZWIZvCG6D7t4h6cGgfgo0Wg==
X-Received: by 2002:a7b:c348:0:b0:422:97d:43d4 with SMTP id
 5b1f17b1804b1-4247507a8c2mr4131985e9.6.1718741704774; 
 Tue, 18 Jun 2024 13:15:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602efc4sm201526195e9.15.2024.06.18.13.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 13:15:04 -0700 (PDT)
Message-ID: <6dfa4bb0-e4c5-46c9-93e5-d30f3a26592a@linaro.org>
Date: Tue, 18 Jun 2024 22:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] Misc patches for 2024-06-18
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
 <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18/6/24 22:06, Richard Henderson wrote:
> On 6/18/24 08:59, Philippe Mathieu-Daudé wrote:
>> The following changes since commit 
>> 900536d3e97aed7fdd9cb4dadd3bf7023360e819:
>>
>>    Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' 
>> ofhttps://github.com/newfriday/qemu  into staging (2024-06-17 11:40:24 
>> -0700)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git  tags/misc-20240618
>>
>> for you to fetch changes up to 02ad1f5b04bf2941852f405c87535307365f7041:
>>
>>    ui+display: rename is_buffer_shared() -> surface_is_allocated() 
>> (2024-06-18 17:54:40 +0200)
>>
>> Spurious warning (3 times):
>>
>>   WARNING: added, moved or deleted file(s), does MAINTAINERS need 
>> updating?
>>
>> Deliberately ignored in ui/ (also 3 times):
>>
>>    WARNING: line over 80 characters
>>
>> ----------------------------------------------------------------
>> Misc patches queue
>>
>> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
>> . Always use little endian audio format in virtio-snd (Phil)
>> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
>> . Introduce x-query-interrupt-controllers QMP command (Phil)
>> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use (Cédric)
>> . Set arm_v7m_tcg_ops::cpu_exec_halt & mandate 
>> TCGCPUOps::cpu_exec_halt (Peter)
>> . Constify few uses of IOMMUTLBEvent (Phil)
>> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
>> . Fix inclusion of tracing headers on s390x/TCG (Phil)
>> . Add few shortcuts missing to readline (Manos)
>> . Update ui/display entries in MAINTAINERS (Gerd)
>> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
>> . Fix Standard VGA screen blanking and cleanups (Gerd)
>> . Fix USB/MTP reported "free space" value (Fabio)
> 
> Fails testing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7129004955
> 
> qemu-system-tricore: ../accel/tcg/cpu-exec.c:1082: tcg_exec_realizefn: 
> Assertion `cpu->cc->tcg_ops->cpu_exec_halt' failed.

Doh sorry, I tested but hit a libusb issue on this target and mingw64,
tested there and thought this was the only issue and missed that.

Hmm cpu_has_work() is defined inlined. I'll just drop the 3 lines
I added to Peter's patch and send his unmodified.

Regards,

Phil.

