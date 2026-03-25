Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4321099B44
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vx7-0001pa-5V; Wed, 25 Mar 2026 17:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vx6-0001pK-HT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:39:48 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vx5-0000mp-4R
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:39:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2b04d051664so2814695ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774474786; x=1775079586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=liPTQ5jqLXjb0AAZGb9Wf6SLWrvx/VMWhzdZf2Fb6Fg=;
 b=wRBc1PU0DKa7ZXcYAatBs0EpYBsDNQkqMSKbbDj0nrKTZWpJDPXOscTcaH15RGz/p4
 l4QS/OztUCYbHtKTQu7BRJTRFoTW6TQXab+oZsIUSVVNQsKycC9T3q9JjE0g5b7z27Ff
 e0qL+H8tCGKnAxNZC+n2ELaSC6VOwrEmGPILr0bM0DsebOA5p7hQb2YOR6d+/WWXPiqK
 wGH+YcI8bSCKty+vvjCL+TUhBWoK8rrPaSdMr4aWY05AdtfUm7IXzxrT3GkhGofN4veF
 8XeLFV5Y1+CBopYVTTcDyfymX+QtnGCExYSCwAueIkAwV+MMnMiMNfg2U27PqQ/JIVd8
 Lceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774474786; x=1775079586;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=liPTQ5jqLXjb0AAZGb9Wf6SLWrvx/VMWhzdZf2Fb6Fg=;
 b=Kw10oorMzgIHc6Yqs9uspcSeDbcMWCxqug5LhvEFhmc+7ggAovKUOR/kgmA8CfsNkl
 182JxI6/TZNcqlg/dxw7qZwmFtHDbFNuEXgOhtGFsthBhS3Lm+M3xSbv51YyOs4uMQKA
 KrpZ6hV1MMvMBJ49BGxS1+QFxk+umvhdbW/vq42VCyv5o3BHhgswO0LdRrmEqKTWf7uo
 vaPyZ/7bJIGW81pOraMFY2BY7Cexk3qFkJxR9dHmzwHRq0JjUSNFQ86gYoe6gV6yfBkG
 k6V4266rdSLjImX5is5Fqh0Yc461yhFNsWcMnuv1n4j6jEMMXKkn0odZlA/RLCv4Fs/D
 Uylw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvB3BdMARMEbf0Wk8bIXQQAb5y5FWdu4E/oK5z2l3F0JEd9TrqVYRFsuB7WOVB6RGeZbwO5NjJo3/g@nongnu.org
X-Gm-Message-State: AOJu0YwJdgiqCCrDLuqVYYMGPKMfgTypo+z9C/1CAvoGPixqdAl9ollm
 sRrLsb6j2Zwp3+1Qh/59iT4WfdEYxcjsncEt6mL9a6zovtxuPvWVIxrZdR7LE034Cf4=
X-Gm-Gg: ATEYQzxXNtSFmp/3ZDqqnEEVb+VDrPa32Yj8qplGYNY+nk4wPHCCUAz0ATzss1qRaJ/
 jeJ9ARVNX/93dA9nJ3piWlv6rrTL2gmr8U4cK/OsRiM267UqMMYQiS2Prdr/kInUMPJeqKVBou9
 OF9xf8TdWCGbTjRE/Cmhz7Xr+1QhhNTaAjmjSaMRM85VJ1srSSiY2Tr1nzeqygpYCGPJZV8qNYX
 YvqrOozU7GcpOpe0EvremADpFwkynfwkZUtWa1JDCi6mwS9/4V2Pe0r/0StWLnZlceD1EjzFBNE
 MjzSGOE/fX+jhXXQ72zTer/z4wjndvoEleZo0Div25HL6wevTPrFPqO5EYKauIZacnnG3OddwUI
 xVv2fZa1Ogue/VNZTdNxxSThXYJ7T4pFkp96m0YPVkbUF3GiEQg5z8DXroDULyPJKu4s5Jhl1Aj
 7UDQKdZpy8l1CcdoX+Xb0bsutIpYLrFcYFfbNWMmKlYrfkxu3H5cjWXH6D5W9DapXSdM4gyrzv5
 Pxbk/s=
X-Received: by 2002:a17:903:1aaf:b0:2b0:4f9a:b794 with SMTP id
 d9443c01a7336-2b0b0aff6d8mr52841075ad.37.1774474785690; 
 Wed, 25 Mar 2026 14:39:45 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7847acsm8626935ad.19.2026.03.25.14.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:39:45 -0700 (PDT)
Message-ID: <4b0684e1-09ea-47ba-a207-ee6f0c264d47@linaro.org>
Date: Wed, 25 Mar 2026 14:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 02/10] target/loongarch: Avoid target-specific
 migration headers in machine.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>,
 Song Gao <gaosong@loongson.cn>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> machine.c doesn't use any target-specific macro defined by
> the "migration/cpu.h" header. Use the minimum header required:
> "migration/qemu-file-types.h" which is not target-specific.
> This allows to build this file as common object.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/machine.c   | 2 +-
>   target/loongarch/meson.build | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

