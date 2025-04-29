Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289CEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9o4N-0007vc-BY; Tue, 29 Apr 2025 12:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9o4L-0007vP-UJ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:44:29 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9o4K-0008DX-4T
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 12:44:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so6981347f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745945057; x=1746549857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aibllgg3d4RLW0Us/sHqBYj6oK5QHnm+kKAeGEcic0s=;
 b=eCW55seMXu5A6RcOC337jALlqy75gjb+WXIE2B4raTvVp+9g6PM22hbWuIsMNUZZ4P
 DT7EE9NKJykxnpJ91XLSBlD8a/iFhSa1+KrVefm41udHQcYTV4L/izho/cepB6PgQCwh
 pSi/ItrWqcCERulXv/zuGURy4IbMnmyYW6eXM70R0UZmGIguSYPkyBjBozYnFwdmroG3
 8hX156/NJwn9DwPkE9uL1d9bzOqwUmQNzVCvXKhDA8xzASXIy40wZqDBtodzhlFqBdI0
 KzSaNbsOyl+mSHggDFhs4IBlynDnS69gsAIRBGNkl7l/o3e1/+mGqcPKJ8ZN5ZoDHjBz
 uYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745945057; x=1746549857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aibllgg3d4RLW0Us/sHqBYj6oK5QHnm+kKAeGEcic0s=;
 b=lcr82PsrTRs33BO6RKzrsSMU15MGXFTgfiWGgO0JXrrhB6uEBedRlLd+RSE1D0FLSH
 X0ZzjzQxDrEfOwZhPgphcG+EWS36C83Z7lgyuzTZowHFjYITm8zvVspksfBtzGPezY+V
 nqTj8fD6J8sfETQP08TfLckeoDzv9f7ogz83ZndV0d0Q1jyDMDW4WTWkBtgna9cYj+mD
 tXkVfEJEXlT3J4RlwJzlWGhOdL3r7SZtqmNlX15g/JugW9YzP1+H7a3BP4hVlwdBjhC8
 4DeQJ9X0XZcmxgKpJ27SYPGfwgSJNYlEh6Ndoxt4XHjZT6nyzH5xh9ztaAEQ2edOjVx3
 rNWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4QTBSKSRha72nSyZz8OsPF68AjvpWWePSGj7po9dUnNzoL+1873aL896FYWL5sTBi010/aF8q853k@nongnu.org
X-Gm-Message-State: AOJu0YwjBhNWRi9/hlvGPr058iss3lrmxxY3CDiK5eHWJTj2YZtL2JGP
 GnhGDTpShNL+sDpQleVzL0P9lYEY1cNWaB6nRNEsRJNUwCJjdaiJ8iUtVcfC8Es5+QhPnoCVsxt
 q
X-Gm-Gg: ASbGncuo/R196OrGsa00tocPaC7ArsqDM0mtQh6PVFhiGyQEHRqf7otI6VrcPKulteS
 QNVLMTlvP780y9ZxOcLVD98BHwEU5fzdMpelGpZWL8rjgrOkJ1ESHOJ9WsgfhraiUCjCi7A8so/
 B1JK6HoiO6wMgs1CqMaxHSLPf400rY4hVlOI/bI1rykNIdpzUrf2hpl6jfWTvPJ3g2PTFZ5DJ/l
 QgBvW9q89diMtp1wnzU4AeTcvNMDDZbIoZdHK9I1FeXzBU+gTlMXUvergBWGxCMFpYPQxhK/qlq
 M31i4hIowhHewSrGqDA348raQehMEzJa4sDJy2Vo/Zcxgx+EomxPlWzCqs5T0qY3/dMb1qsdNXZ
 I2t1hdijD6eX1Cg==
X-Google-Smtp-Source: AGHT+IGKLPRuRHQYfOOvaw5wEsg1dJ5YMhJgLvy7JkTalCYHw/P2Z3FbT6NazwojEW5+LMxL5COfaw==
X-Received: by 2002:a5d:47c6:0:b0:3a0:8712:f89b with SMTP id
 ffacd0b85a97d-3a08f76123bmr87938f8f.20.1745945057523; 
 Tue, 29 Apr 2025 09:44:17 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbf04dsm14660667f8f.52.2025.04.29.09.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 09:44:17 -0700 (PDT)
Message-ID: <0d279fa6-97bc-4dc1-b594-a8faf33d6485@linaro.org>
Date: Tue, 29 Apr 2025 18:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] hw/hyperv: remove duplication compilation units
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
 <81732388-d0f7-4bdf-ac8a-3537276dc284@linaro.org>
 <174378df-525d-41b1-920f-3797ca300e3f@maciej.szmigiero.name>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <174378df-525d-41b1-920f-3797ca300e3f@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 29/4/25 18:39, Maciej S. Szmigiero wrote:
> On 25.04.2025 01:30, Pierrick Bouvier wrote:


>>> Pierrick Bouvier (8):
>>>    hw/hyperv/hv-balloon-stub: common compilation unit
>>>    hw/hyperv/hyperv.h: header cleanup
>>>    hw/hyperv/vmbus: common compilation unit
>>>    hw/hyperv/syndbg: common compilation unit
>>>    hw/hyperv/balloon: common balloon compilation units
>>>    hw/hyperv/hyperv_testdev: common compilation unit
>>>    include/system: make functions accessible from common code
>>>    hw/hyperv/hyperv: common compilation unit
>>>
>>>   include/hw/hyperv/hyperv.h |  3 ++-
>>>   include/system/kvm.h       |  8 ++++----
>>>   hw/hyperv/hyperv.c         |  3 ++-
>>>   hw/hyperv/syndbg.c         |  9 ++++++---
>>>   hw/hyperv/vmbus.c          |  2 +-
>>>   hw/hyperv/meson.build      | 11 ++++++-----
>>>   6 files changed, 21 insertions(+), 15 deletions(-)
>>>
>>
>> @Maciej, this is now ready to be tested :)
> 
> Tested this patch set on a Windows VM with hv-balloon QEMU device
> (which uses VMBus, which in turn uses basic Hyper-V host support).
> 
> No problems encountered, so:
> Tested-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thank you!

Series queued.

