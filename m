Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F004F99378
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFscG-0003Lj-8J; Thu, 23 Apr 2026 07:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFscD-0003LB-Kt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:53:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFscA-00031F-BG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:53:03 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35fb166b0c6so3788014a91.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776945181; x=1777549981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doYdWC4A4Gb2eiHvPcEGmKPVqNIR7fKnURBPKpG67h4=;
 b=lab634AQG9njkuux9sizRTpBM5CrtmW09yrPRVc/9vrchjkafNDq9eaMVjUpIo5Zxb
 xoFVBt+ZDuLFPKvqCf3hinNvLPL37OSSI+PV2ieMB/eSYsfQ/DKmEFiouO5jqEydzvFG
 poIcT0R5LTYZpdleOW5bp09M3DBKF52GPPR8SEcCVBhbYkD5JVoqaBFdxKldl8YO5XeS
 ne78jpLo3D1bFstU6ujHxPz7B2M2XdBaF47V7BP+EG6ukMMh7XYk/keKkK1+qMxmtyW2
 Lnpkfe5fI5AVTg3LsBFmUdlozoUIGnVW+hAthL2jyp3xZxoZ9I/B6Fh92HHsooVpghqn
 S8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776945181; x=1777549981;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=doYdWC4A4Gb2eiHvPcEGmKPVqNIR7fKnURBPKpG67h4=;
 b=O0fQaoXCt/KLieU9xDr1X1Lq2f8ZBK8pWQNBeTRIJmqKIAIH5w+LxKO3acds9eqSFd
 SdZYPa+fEw/yyGzNAxOX4w+D76P0uuvFtsCj1iP1hg6QeWxnEJFWIWt5PPTq1NIhJ5RH
 VvwMTroaZt0rPgihzBBqGsNo/gU4paKpDS5vGzXWJTRzbBM7ms3uA863U1/gzABSyNlI
 jJgDUCDsEC4OgrUMLWaFev/6W/85YLK1Ak1dYobw0qvlJOva2fc9CWQ+17VuBcnJFvR8
 ajjslMt6O7GJ70ItWWz6gLZGWSO0IVYi5qZ6xKyCGMZsLNgRzoRG5ZcERnI1Wi1zOAW3
 cW8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RqOd2uGVc0W1rEXvu3DpqFcqjNnoR5zOJ9GJQKW2bb/VqQi84tU8/uTkgU74JmheCK6lmRJTa7xIS@nongnu.org
X-Gm-Message-State: AOJu0Yx4oKUaU7oGv/RdJo3YXdjBns5wOwVHbIwb3870/jfJojqISjKM
 SqnlCFWtYW/k+UCOMiU/p1WGubr6pFKg+lniAK63nG9b/o/rRblaVApT7lCjyhrrvKE=
X-Gm-Gg: AeBDievxLF0wBc1k85lBJz7UqSyF7wJaXb88JeyECy1XuvFOWROYxLWV+xiCHJqYPHz
 SXsSI1auDbkbWtxPjo2Nf9x9CBatS0ngC9HgZN9elH29IJj5NemWyvo8RavodmH616fK4oE/HiR
 6IY+dOmSp5j4QfWINXvKN2BtJDDnDUlEZxB0voEmMcfnajgrUISaPUEw9pEictNn0bNAb1isfxo
 hzJbcXf5jo+9C1K3ZSqjhrQTEHBoI7+GKtyq/edPcA7Cm1UDSKWikrWE2xBOSDQe79t9KsVpJs/
 uTgL8OD2gyNyCwBicLpaktaKm6BmfGRu3k4QFdaS+zuycsoiV6ivVYM//uOoZx+qu/wBtll/Wei
 Rj1O3iICY0ZDdalQldbDzMnzeg+lJiFxuwpJVEGk3DvHjXnsbrSowKJKowPSgLfwsAu1KWoVYe3
 8SXefS929R++BBUPhA/mo02+uiXRistMT7GACYoiXhvCRUZYsL5w==
X-Received: by 2002:a17:90b:17cb:b0:35d:aa02:d776 with SMTP id
 98e67ed59e1d1-3613ffce5admr21136719a91.2.1776945180645; 
 Thu, 23 Apr 2026 04:53:00 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361419739dfsm20986453a91.13.2026.04.23.04.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:53:00 -0700 (PDT)
Message-ID: <157fc016-e7bb-4e36-85bc-a73c9039830a@linaro.org>
Date: Thu, 23 Apr 2026 21:52:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/microblaze: Include missing cpu-mmu-index.h
 header in translate.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> translate.c calls cpu_mmu_index(), itself defined in
> "accel/tcg/cpu-mmu-index.h". This header is pulled in
> indirectly via "accel/tcg/cpu-ldst.h", but since we'll
> remove the latter in the next commit, make the inclusion
> explicit, otherwise we'd get:
> 
>    ../target/microblaze/translate.c:1620:21: error: call to undeclared function 'cpu_mmu_index'
>     1620 |     dc->mem_index = cpu_mmu_index(cs, false);
>          |                     ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Another solution would be to expose mb_cpu_mmu_index.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index af6a30b7760..6321b739ab4 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/cpu-mmu-index.h"
>   #include "tcg/tcg-op.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"


