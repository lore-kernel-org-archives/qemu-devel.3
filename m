Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EC0E88D63
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8mMs-0002F2-WF; Fri, 03 Apr 2026 17:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mMr-0002Et-RR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:47:53 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8mMq-0006SG-Bn
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:47:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-824c9da9928so1366337b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775252871; x=1775857671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9Vukr9g6qfghWwOduq55GE+RO9Rmk0CHMOoN81TceQ=;
 b=xdJbc3kL/oVzN7D1zLFsLe0A7ho1KSd8WXTmxUAF8R8I49uv5w6enHXJp211JVQlxV
 HnM/TJ3UHviEa+YZzRk9qupEqOZjD+XmW8xv7SRCyzuQ4iGOSeg+XCV7k2AJOzNlM5vK
 aHotC7u/fWvflIa3O0xXPIoqomWWiGNWVkEXEnWHd80fcdT3CGcq1T4yQAg8cZR/nn07
 ZgwQ8dWhVBIcSHktfB1QzrOgpdeOLi+X0svdpEHRB6cho6C1OZHGmSeZzRH6I6SBF3KN
 0abTUkrgRlxaYnjVm4r3ydbY0AYsT3nqm3ksNHKLfDx7ueb7hqussWYCNQbNKvwkp+2n
 ywvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775252871; x=1775857671;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9Vukr9g6qfghWwOduq55GE+RO9Rmk0CHMOoN81TceQ=;
 b=BMfYAP7jOoGHh5ab6iKixmeBUXO+RjF/JXKCR4O0yuUqCyP4Hdw9R4zN/GYLgyAOch
 m002XResGzMEm36WntdUPFkMa1ia7xIMv7NtLCxukDiAf1XCCJ/sQTeSAqMxuX37ac93
 4/xc6dG/xHMlrB515mNr6JNzoqfaSGuAMO9W87p4xKXgIKf0NO2qVVcvRKvX5spT4g7c
 1cjZB9hnrPRQvAc44EAoEh4Xb5QPMrjmVN2XXc6sBIYWFTKbMDcVicnyrVYBoGC6wpxJ
 SwO2Vf+bUzRGIzu1uTjDSTWsYkK8v1I7bD0JrOFqZKMHPbZwlLbZ3jlxlGshnRI5iQeu
 ccBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnANicA5o1H4XXTAWi8oGV+bPaS/vpw1DcrmqyyXcjis1ZTt1nhmLa7ehQ/WlM+vaXJ7atfeAjN5wc@nongnu.org
X-Gm-Message-State: AOJu0YyRY46YGHoKWtWDBtp1VJxEGgIwHhQkBiGpbViYilV/1BfPjwv3
 PCklzj5XWfLpgv4b3ylE/Cfi1cKrAx+YoN8z89KrGF1oZGxId7x8p2Afqkraa1bx++0=
X-Gm-Gg: AeBDiesZSV4fzQYpcw4T2j+dvtuw7C6AwyCTFjkkZbOppOBfppUiFA7xvf/26P0tXrN
 dwfDVRLX5Y0SjpL/cHF9ncbuWjzPQ4AweG5GMf6rNG0jdieulidM+tkVkfum+KZLQYXs3x2Warh
 5fC72v5leLdX4RVq7lp+eZE1ZMHHTz7jHmZ3QnuEnMEEgAVrFG18YevKyn5HrVysq3KRiD5lJs2
 0HhTqs5s9DEZy1XkP/7lQyLxEE6PCMBjzYGAkZgydj5oy6fpMtNq3E8XbezqnAMq7h/urmdvBNr
 iZJ8ALGf2ZN0H61WipX1gTzsApqVU5uRmedrq4Kc1XVUENjWcYR1cyoztDt9t1tVWNOfIAx1Q+5
 NJ0R0YreI19bq7OMih/7grp5WIquQGV4VfGAGljh+5P0n5JcC73KyxbSmlfW3u7vj3qsEYliclG
 3S/xV5VcxmPPSpHbLoO4xYvqYdJ76nnOlPJu2TIhq6tafBYiBBitbyhtweYiy8jaTCk+Q62WuFc
 QVMBA==
X-Received: by 2002:a05:6a00:4fc6:b0:81e:f1c3:89df with SMTP id
 d2e1a72fcca58-82d0dbc0dbcmr4130433b3a.50.1775252870795; 
 Fri, 03 Apr 2026 14:47:50 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c3d67dsm7909809b3a.33.2026.04.03.14.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:47:50 -0700 (PDT)
Message-ID: <051a28b0-a67e-4da4-a13f-ed88a69bd629@linaro.org>
Date: Sat, 4 Apr 2026 07:47:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/2/26 20:47, Matheus Tavares Bernardino wrote:
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.c
> @@ -0,0 +1,69 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hvx_ieee_fp.h"
> +
> +#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
> +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> +                           float_status *fp_status) { \
> +        float##a1t f1 = make_float##a1t(a1); \
> +        float##a2t f2 = make_float##a2t(a2); \
> +        return (op); \
> +    }
> +
> +#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
> +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> +                           uint##a3t##_t a3, float_status *fp_status) { \
> +        float##a1t f1 = make_float##a1t(a1); \
> +        float##a2t f2 = make_float##a2t(a2); \
> +        float##a3t f3 = make_float##a3t(a3); \
> +        return (op); \
> +    }

Why are you using uint32_t and make_float instead of declaring with float32 in the first 
place?

r~

