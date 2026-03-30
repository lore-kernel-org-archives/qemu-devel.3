Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4264C1061B13
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7F6m-0005G6-Ca; Mon, 30 Mar 2026 12:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7F6l-0005Fx-4s
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:04:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7F6h-0004Pk-R8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:04:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b941762394aso695301566b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774886688; x=1775491488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NDD9ZVt+8A7AGMfVIVki6x0PNsmqevbFidp4860JbIE=;
 b=wtJMpgkQFwmdOerYiudD2AXlHUB5PNz0jmUgAeyqk4j3rS5qVbcEJhr6nn57tz5ywD
 QYdNkUv/Vgez4xEawwwRlSvd0o0Z82ahFAZ/yLA8P4iagvfIKvOH4BFxOyt3X4s2RqIJ
 B7rxOj1XO46k930vXJ1ZjNoTbBPg3ePYRbp8zgRtcrgF6a5rPvVzFN9cXBSUIPeFiujt
 Yq6/kFLcNXIlRl6E7V7zSU3TjH+lX+PO0IBvUMTL3HiFnq7rO7Lys0t8QqViY42CZsxd
 Viorh6GxoGOhmr97ZcWlolTGdNHYAEdHerXev2FXuRxXoybcMFqlje5IxvMf2ddwfExW
 Pm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886688; x=1775491488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDD9ZVt+8A7AGMfVIVki6x0PNsmqevbFidp4860JbIE=;
 b=QLxLLd3JQGUyIWpbUUKr8vumsU9bofNFk1tUbOtKoc28RSbbeVLPyGUVMRjT9zZf+P
 hqc5da61eRNH69jlcAQVVj2zuWrriCRY/JOFMaSqRQLYioaKZCBarx1TrNKE6EzVlqGK
 cDn6K68ULz/m49/G655NRl7YNn8fqxbWClRiw+LtE+gt1JWq0IVMMFhb/eqrb5RN7gl1
 CMC6MOH3ft9eiBnhgtd545dbGGCv7MBYqdkb0cEByuHoSW1UCVd3flEsZxJsRomoUpyl
 Ko4Q4EDCRDvcXYDYK5mkAWfHMMzJw+0aT6OR/dg4CSEoR93I3wzEwQCKKNYDOAQiikDA
 vBvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCLbbInKiHTxBkE6T0TuNPr9z8bh5pID31zNulfeXRKctzd2dIP/yYaDJqLG+RGZyVW3jAgK5PM30D@nongnu.org
X-Gm-Message-State: AOJu0YxTea524i4ewcJ1IJ7zsRaCsCHvzzPpj5dSqUwsHyCLHLl2/HnP
 Mk1amXMQM07O7A+UIPc+XBFvT8Yjg36xo9QsMYKDLlojKUymUDWyvrxa6qW9pMGgCTk=
X-Gm-Gg: ATEYQzwnYL/qWp+akePlcI+6WWEwIB2P40qdKH4ArBKbwsuFiIjm9n0hzVG/F+ePv15
 ezFtvWmXDMRsDNd5nvwr/Hm/eKM+s8X9hwmzfOFSHMv/72S4InKefNSQ0fjdj8FVwbfp4n4BLhj
 q7AHjaJU2gXTpPapap2vp/7MUptsQ5guuSuU+3W1vQ2LUZQVc7P24Ddh/xHCT64TaF9+jkuRXUo
 yMjR/AI3aTKXPBU6OyIZQTRw0HMQ6+vZGH0veU3R9CdechaAYYOq4L8Q/rnM8u/k0pJM/KeMy5s
 01WkLNHi9fE5949gmcGdSN+LXGxiwH3CzSPwysoJyQXDLMZro9uH/YgSIv/V7wVfX5lnYy/jd63
 pTQkw3oNt7uD+d0yqBb08JI8g4S+i0R0xQHHDWqtM8YpTQD2zeZmwgUZJ1B6LROLsPCmBtTyI68
 Xu2jG5ypTEjLZKiI/oJUcZYV5DfbmmAkSJCaHDJ4gkmhcq2YIgASkZBUDvp0w4t1KSgm6hxJLM1
 A==
X-Received: by 2002:a17:906:f58e:b0:b73:4d06:bc8 with SMTP id
 a640c23a62f3a-b9b5099f8a5mr801386366b.53.1774886687867; 
 Mon, 30 Mar 2026 09:04:47 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5fa8sm310279866b.33.2026.03.30.09.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 09:04:46 -0700 (PDT)
Message-ID: <91cf6b95-f944-4a13-80a2-e25002b9d599@linaro.org>
Date: Mon, 30 Mar 2026 18:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/cpu.c: Correct minor grammar error in warning
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260330151309.1786787-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330151309.1786787-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 30/3/26 17:13, Peter Maydell wrote:
> Fix a minor error in the grammar of the warning messages
> produced if both MPX and APX are enabled:
> 
> $ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
> qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
> qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]
> 
> Fixes: 91bc4d81078a ("i386/cpu: Add APX EGPRs into xsave area")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> As a side note, it seems a bit harsh to turn off *both*
> the conflicting features if they're both set, rather than
> removing only the older one.
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

