Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628DFCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHpj-0003Ae-VB; Fri, 08 May 2026 05:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHpd-00033m-4l
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:49:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHpb-0007XM-F3
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:49:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so11410265e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233754; x=1778838554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Avk8dF5na4Tc3n0Ug62TRElorhJ9gE4EGd/jcz1+Vus=;
 b=QsAMe7CFpRRu1ltajDGZpowdIkeLJR7i3zonBK/9IH13J2Xk0/CsiUN77UEFuhwDbS
 EdfHqcOoOrvtlqfXcG/sfq9cu6vBCn65cH5ZnQmSc2VaF7sF4AwfY/TLj1HoCQ5uuoXK
 T0zqRdJpnWTDqeDXosvVpUXs87MN+LF9fQ6dhrhq6uCLKqBwoq7anPeqzXsc2XQNNkrY
 fzqY7IAUtw6z/AFDd012mZtfmGi/EPql+Do20YJMxM5MhZ6Ni0mVbxIsjKXexfTJ0iHd
 Bz9jR658YhFhSWrQDjjpOHJYXWo11cpYclxbCZR2nAZMwVDKfk+CePPbc4j3NMnsJ29s
 BeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233754; x=1778838554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Avk8dF5na4Tc3n0Ug62TRElorhJ9gE4EGd/jcz1+Vus=;
 b=K6HunIxUXNT7p6Dv8lJvNdJyAI2wVJBxtI6pvzLngG5uwYUa3Lc3K9hQsASmg+sxll
 9xtUQCJ07fi7FT8Z0VQcSow0mXX7+bIPQfO2JmUG6jb/3uthMh/vxK9snmFh7P6l7eoS
 EBT4RE8eO5i91T5RjuAG+6CcwUd4P7KbSmoEseSAI0+BqIZ3CrG1Jzts5GJmR/iNqqta
 zeesw5yTM0FBpQujU5zfoJVmWsc/d+LTjUFPP33SauDL8uNkdBv15fqFsnNgRysPuRYZ
 XzzLJdSXHwgqHM+r8Pct47phAJ36C0pweqG+wY7bA2wzNx1Zc1Lt+gyd5juwqOB4+O1b
 +AKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LJyKECbBNvp+1IoNpFRWeVRYp2N3zIt1WAHlhqvGOB22m7NRxPDp6XWTlUCtzdylaPWK1vxL4sZO1@nongnu.org
X-Gm-Message-State: AOJu0Yx7BSyu5heqCElxLGXextSJkikdzTvejZbJ4MYoqqeSXbUey5LC
 3GFL6p8Kc31qIFzRKDFjoWYQ4iecRHq6k8b60l4jAJB5+f5lj+G0PgqlFE15hzlTlOkx+cCGh0C
 JzVtjDCo=
X-Gm-Gg: AeBDievhqxmcbTp7ATOGt2PlAhG/M/Px2OmEkoDI6HEr1e2pvjEOVK9/ZuwlKL9+Jr/
 sxkFABeWcqkxwlyD8MTIcW2FmJM6+KvWBwARtP9xeRnH21KbQ8mz7ba6UzGQA+gHWvSg2b6vQU8
 xfRyh6cv9co1oLXB9INA1OrkV/JZpVABZ9yrHuMuSM/61whLmFRiT5k+ML499vMpYmac8HljcRW
 l/lQnj/aEmwUc0i2CZaMrpLCvp3VrxtAbPvGmmp3mg+6oBiPRwAdK/sMot2/oouxzOCdu+fpjPc
 MOIimrPqEHAVOOzf3YAyhGG0aN7WKi1u9BrUkSSqpr1Q+ANBq1ECmyJV1o/Bq7PdUhi4IlsrI1T
 nVdVn6PBoSRmjh3l9zuof+US1nYDFqpuiqw5EG05R5XmDQunDw1/8PpQtQLeBZyTNf8+aKI1qGQ
 OBukoWAYojur5/vb9KPdBICe6UpTXzLlGc93DT6zj9zE0llIftrDZIxOdp1X6TRv6c5sZWMg==
X-Received: by 2002:a05:600c:34c8:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-48e51f2f85emr210255815e9.13.1778233753823; 
 Fri, 08 May 2026 02:49:13 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c11807sm14993015e9.23.2026.05.08.02.49.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:49:13 -0700 (PDT)
Message-ID: <3139c3c0-14c8-444a-bc74-b0082e28c17a@linaro.org>
Date: Fri, 8 May 2026 11:49:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/18] fpu: Use get_float_infzeronan_rule in
 partsN_pick_nan_muladd
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Deduplicate the uses to a local variable.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

