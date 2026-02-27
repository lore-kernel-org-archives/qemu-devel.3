Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5046104891D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw63O-0003Wi-Dj; Fri, 27 Feb 2026 17:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw63K-0003WY-OL
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:11:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw62x-0006JW-S7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:11:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso21902895e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772230253; x=1772835053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XK0XW59bDNLLflIYj82ibjMtV3LfDgwVLwxlCgwNGk=;
 b=agCMUOYtdLb/X3Y4ZUaIvwwTwYVITO8yxe9y3IaXXCGfM4ykHjSlO/EPU4u3nQFGlJ
 gR+c0aOrmwr3+iNQyPmuhbOHFOBrD5Fzp40mwlKXltmtSuF+CTtL82mRHFwSf7eYiGzk
 6taZ1bJWw4QdvbuRmate95OdvcC9oeKyk0tkU+lc51HTxbvhy9u866T/YYaRWn9Ghsl0
 QM/6u/Ee1tyTkqLsYQg2PXRLPBGKeBlVTah3HBY0bXslIHExgUUueejmjyc2J9pr1HZa
 NTdhLYYncIaID+9cgrxuhDXHkGmrZbKbKwDFyQP6EU44sadiaqrPcgiMxpMJPObFhGtP
 rVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230253; x=1772835053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9XK0XW59bDNLLflIYj82ibjMtV3LfDgwVLwxlCgwNGk=;
 b=PmTi+kKLz0ggzyQS/Hqi45yNTgte7uP3knY++4Lvb73LqT6N3+ye489NMgbaDBC8+L
 W24J+D4GFir/rRlVhpbkvHhZjI1tkI0TWDnuPw4o+lgX4bUIb9iqzB1Pd8bscI0LQRrK
 x2Gl1/4bL+Mj9ZMxHLhW7xc5h2xaqY9ddTGu64qTQhuzqd0CwTpXpJDkGNu88yjxaonk
 LmfoDt+XY0h9tMw/AbpIYZGs0vL5N7yZ12mnOqT2IDiJXd9WuvWSMX7gu8znIqn9Q45W
 Wl/3SrtzpryXPUTeNM4gRR0O4ZbfKZYohrQ2F5Y2siwS9I7aJzQo5ZvMt6RgwgDW700i
 QGqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKO9FCFOGkLlKnnXTPhg/nH4Ox5rQif0fpDh9EP3LT/RuQUVsh2fVGmv+YRZSbxUw5l75yaEcTC0a5@nongnu.org
X-Gm-Message-State: AOJu0YxiLHI5b7SbqItmUp+DadkTotF80txh5Y3YASwSwUuFqPlJaoCB
 x2AiYqmH+mOS/ObwaxCd5Mn12pka36sJGK6TBPd6tXFpNAgstHyTTWghbrTnF3Ashx4=
X-Gm-Gg: ATEYQzzSBhtjklldNCB5D+dnKKUmQ5ls06d01tL7Qp0QvfzAaFtpjURXihr8pqU/vIJ
 7qmNgVxYYDlru01zmf5t30VbVjYvqaFlJR62yKW+EVFYC7sLEn0VKsdj9DzerRAf5J3Yy3Asx2i
 eqm/8csSvuL8sN6j6+RPyJ3s4095gvdIjCbM7i3bFC+vUNBjMyvG7BR0zbwO2IUVJvqXPZjyhEN
 pJ34nTfosjgGkLr8QNVSpHup499LT09P9fLrNfHnAkcKki1GLR5m1wd5RIcbZlTMW9uq0ECwrTA
 cjHAwv4MJsIZrBXoFT1/jwAa/vJobgWldw/ILxtrBDLgDvtcE62xo1RQfFFi1AHKIcQTNO8SOS9
 F9ro50adZ6V+sU4eDG3Pkys37PIt2UivDUP0f+JBaKTFydtKWloIrUgVTClR1bXCuuMYhD7finO
 Ssu3ltQxGdhjMXPuHjjgV4lJfa5xL1KFXJus1wzKlLM2WhTKeHtRlZfcgUVRpPvC1mwA==
X-Received: by 2002:a05:600c:1c15:b0:483:6d4e:9811 with SMTP id
 5b1f17b1804b1-483c9c0b6ddmr81771775e9.31.1772230253541; 
 Fri, 27 Feb 2026 14:10:53 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b84023sm133620195e9.12.2026.02.27.14.10.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:10:52 -0800 (PST)
Message-ID: <b3c0f204-bbce-42b2-ab0c-429443177bbc@linaro.org>
Date: Fri, 27 Feb 2026 23:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/37] target/hexagon: Add vmstate representation
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-21-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-21-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/internal.h |  4 ++++
>   target/hexagon/cpu.c      |  3 +++
>   target/hexagon/machine.c  | 23 +++++++++++++++++++++++
>   3 files changed, 30 insertions(+)
>   create mode 100644 target/hexagon/machine.c
> 
> diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
> index 5fc837ae229..cd06ff41d4f 100644
> --- a/target/hexagon/internal.h
> +++ b/target/hexagon/internal.h
> @@ -31,4 +31,8 @@ void hexagon_debug(CPUHexagonState *env);
>   
>   extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
>   
> +#ifndef CONFIG_USER_ONLY
> +extern const VMStateDescription vmstate_hexagon_cpu;
> +#endif
> +
>   #endif
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index c4df7cbe30b..a8f2f9e238a 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -386,6 +386,9 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
>       cc->gdb_stop_before_watchpoint = true;
>       cc->gdb_core_xml_file = "hexagon-core.xml";
>       cc->disas_set_info = hexagon_cpu_disas_set_info;
> +#ifndef CONFIG_USER_ONLY
> +    dc->vmsd = &vmstate_hexagon_cpu;
> +#endif
>       cc->tcg_ops = &hexagon_tcg_ops;
>   }
>   
> diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
> new file mode 100644
> index 00000000000..89a2ca0bd94
> --- /dev/null
> +++ b/target/hexagon/machine.c
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/cpu.h"
> +#include "cpu.h"
> +
> +const VMStateDescription vmstate_hexagon_cpu = {
> +    .name = "cpu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT(parent_obj, HexagonCPU, 0, vmstate_cpu_common, CPUState),

We shouldn't need that (the parent should be migrated by himself), but
I'll defer to migration experts here.

> +        VMSTATE_UINTTL_ARRAY(env.gpr, HexagonCPU, TOTAL_PER_THREAD_REGS),
> +        VMSTATE_UINTTL_ARRAY(env.pred, HexagonCPU, NUM_PREGS),
> +        VMSTATE_UINTTL_ARRAY(env.t_sreg, HexagonCPU, NUM_SREGS),
> +        VMSTATE_UINTTL_ARRAY(env.greg, HexagonCPU, NUM_GREGS),

VMSTATE_UINTTL_ARRAY() is about to be removed (as it doesn't scale
for heterogeneous emulation). Please use VMSTATE_UINT32_ARRAY() instead.

> +        VMSTATE_END_OF_LIST()
> +    },
> +};


