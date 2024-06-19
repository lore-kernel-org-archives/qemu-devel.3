Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016FEC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsnp-0007dq-6A; Wed, 19 Jun 2024 06:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsnn-0007dd-1l
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:44:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsnl-0001ie-DN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:44:30 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6f13dddf7eso790059266b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718793868; x=1719398668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Escto/3lsX072+8yOU4b7IEcoy3oF9CjR5/kV6zYo8g=;
 b=QmaEn8uGeb6u+UR6W8Q+IIomlASwAD+YU1hZ0B51iywOqZB77DcehVwi9yLMO1rAZp
 9gsxZUwhYe58FcyO4rfDxA0oEgDGjJ4k82SFgGGQnuJkNigtVPZfhpdEl0r3FUukGiRH
 y3pOoXlsPv9MkLKp8QQ5J8MRabxI3dS+Q2g2ziOrPYQ2HBgFtUol7zIAMmCILKabNhey
 tWZhDHRqU/XQ0Ij7JRYsQ33hz0NjN9IG/d8WG9p8r6dzv8V1reuM/V/KfpOtrUtQuLxH
 Va5+ayNUNwFKXzNnJcUJ8oFNSx2QxoU3pcZVclBr8qVX+OrR2U7V7IS1C2yzEdqQPG4o
 vdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718793868; x=1719398668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Escto/3lsX072+8yOU4b7IEcoy3oF9CjR5/kV6zYo8g=;
 b=UPXW8uPq2zoPhTHznvn1ik3PR8yQDAKpZb5vC7r1EHegVF6TkCU1xpZn/lV/ijYY5K
 wdJoHGks9UcxajfEZQMV8pofYQ81x0xcpxHB36+yjOTCN9UcuEroR53UyL5cF8iNPMzn
 SgixbwYrSypKI4E4unOPzzOhlbx4gdPyrrdZTTZii0V+dYzxQdEiT7bzh17Ao+rNiNju
 3ZY6pGqHq4EJo/wX94LosvnG1ri+U4Po5ZvqEgpp3Chl/ARGcRDfsztxjFsbtpEidHtI
 MGsomqLn84UUa85K9VSyHTuHI1SlpT3rbX0no//j0p/ZF3z2SImVbn4DKTtF917go51P
 9ajA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiDFwnZ3fUGkI/+EIOE/C3qeLPMKowA1HHe1rvoOBi+bsy+jql9KqpnBeKe5ww14X/BYxf1Kwged+vmcXjpNG/FdZlWCg=
X-Gm-Message-State: AOJu0YzbIRuTD/xWEW17PfW90t9sfRwPZ9jCFJ5xwf3YyR4dPCUXHR3Z
 +y6ZszX/Qr3/pdZZ2jR7DGGZPHZjZt1L770tJV+c3ynuhLhF6DjATdgldtyUkMKO8I4jr768xmz
 q
X-Google-Smtp-Source: AGHT+IGIgy0htjTjfYQ/5qoeVifqBg0RYorRbG/SjEHvzk++O5nWjM3N3MtLjFnJn+agjGI4t/dS9Q==
X-Received: by 2002:a17:907:bd2:b0:a6f:e1f:8190 with SMTP id
 a640c23a62f3a-a6fab648937mr123969966b.44.1718793867703; 
 Wed, 19 Jun 2024 03:44:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f81add1a4sm316357466b.170.2024.06.19.03.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:44:27 -0700 (PDT)
Message-ID: <e3274b41-166f-4600-b631-2013efc4540d@linaro.org>
Date: Wed, 19 Jun 2024 12:44:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] Misc patches for 2024-06-18
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
 <5ae93d7c-0fd2-4ead-b903-6b5838e0c24b@linaro.org>
 <6dfa4bb0-e4c5-46c9-93e5-d30f3a26592a@linaro.org>
 <68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <68014035-47e7-48b4-b11b-83b219f4ef63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 18/6/24 22:32, Richard Henderson wrote:
> On 6/18/24 13:15, Philippe Mathieu-Daudé wrote:
>> On 18/6/24 22:06, Richard Henderson wrote:
>>> On 6/18/24 08:59, Philippe Mathieu-Daudé wrote:
>>>> The following changes since commit 
>>>> 900536d3e97aed7fdd9cb4dadd3bf7023360e819:
>>>>
>>>>    Merge tag 'dirtylimit-dirtyrate-pull-request-20240617' 
>>>> ofhttps://github.com/newfriday/qemu  into staging (2024-06-17 
>>>> 11:40:24 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://github.com/philmd/qemu.git  tags/misc-20240618
>>>>
>>>> for you to fetch changes up to 
>>>> 02ad1f5b04bf2941852f405c87535307365f7041:
>>>>
>>>>    ui+display: rename is_buffer_shared() -> surface_is_allocated() 
>>>> (2024-06-18 17:54:40 +0200)
>>>>
>>>> Spurious warning (3 times):
>>>>
>>>>   WARNING: added, moved or deleted file(s), does MAINTAINERS need 
>>>> updating?
>>>>
>>>> Deliberately ignored in ui/ (also 3 times):
>>>>
>>>>    WARNING: line over 80 characters
>>>>
>>>> ----------------------------------------------------------------
>>>> Misc patches queue
>>>>
>>>> . Remove deprecated pc-i440fx-2.0 -> 2.3 machines (Phil)
>>>> . Always use little endian audio format in virtio-snd (Phil)
>>>> . Avoid using Monitor in INTERRUPT_STATS_PROVIDER::print_info (Phil)
>>>> . Introduce x-query-interrupt-controllers QMP command (Phil)
>>>> . Introduce pnv_chip_foreach_cpu() to remove one CPU_FOREACH use 
>>>> (Cédric)
>>>> . Set arm_v7m_tcg_ops::cpu_exec_halt & mandate 
>>>> TCGCPUOps::cpu_exec_halt (Peter)
>>>> . Constify few uses of IOMMUTLBEvent (Phil)
>>>> . Wire loongson_ipi device to loongson3_virt/TCG (Jiaxun)
>>>> . Fix inclusion of tracing headers on s390x/TCG (Phil)
>>>> . Add few shortcuts missing to readline (Manos)
>>>> . Update ui/display entries in MAINTAINERS (Gerd)
>>>> . Use qemu_add_mouse_change_notifier on Cocoa (Akihiko)
>>>> . Fix Standard VGA screen blanking and cleanups (Gerd)
>>>> . Fix USB/MTP reported "free space" value (Fabio)
>>>
>>> Fails testing:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/7129004955
>>>
>>> qemu-system-tricore: ../accel/tcg/cpu-exec.c:1082: 
>>> tcg_exec_realizefn: Assertion `cpu->cc->tcg_ops->cpu_exec_halt' failed.
>>
>> Doh sorry, I tested but hit a libusb issue on this target and mingw64,
>> tested there and thought this was the only issue and missed that.
>>
>> Hmm cpu_has_work() is defined inlined. I'll just drop the 3 lines
>> I added to Peter's patch and send his unmodified.
> 
> No, the assert is exactly correct, and caught a bug in the previous 
> patch (55/76).
> Without your assert, we will just SEGV in cpu_handle_halt instead with 
> patch (56/76).

Yeah, it was too late here to realize that.

Peter, I'll respin without your series. Do you mind taking your
"target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt"
patch via your ARM tree, that way I don't delay you further.

Thanks,

Phil.

