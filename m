Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30683F8E4AB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcAl-00071N-8F; Fri, 17 Apr 2026 01:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcAj-000714-4c
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:55:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcAg-0001QO-E9
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:55:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso3560125e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776405316; x=1777010116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+h1YT9hF8lsMJwhvlCp/x+pnYM0VZyZHosj9cINn+sQ=;
 b=a6G7lWR+gfm8eDyz5JFZRy6XJssHwXcFF62pebzTzLZOJNgamAaK5TK9k6RGDs9OJG
 B5bQfe6OGV+4GAX5tbe57/aYZ9P/XKix7nXaYrjhW4XRzHm+xTUud4uVK90/4C//YXpc
 MnitaOD4wnANXX1DTzUbU7RcnxG+pZk6FGSQSQj38Z1NHQdv9Mtdal7y9UpikB1SbKmv
 PVfriW3mNtfr58jqUTe4o5905RJVfNmU6ohIgX2+jAKjNSHxKJg5/JOe+OP7FQkOJ3KI
 9FHDXPNCuvqpVutiENX4N2t2VfTKaMTknHopWMksbzjEcFdmWC36PoGzZ6QV6UmXq1Xb
 Vbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776405316; x=1777010116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+h1YT9hF8lsMJwhvlCp/x+pnYM0VZyZHosj9cINn+sQ=;
 b=emur75NBlcxqjTU5Ph0zdUyCPTNjiE20JilPpRmBGQkOFXjzSHzIJKSxi1x1bJbaWx
 lYX0auQBk6N/Qn57es40EE/hz4KypKfWR/oKHDVlwxfIzgBe/I/M0zL+GgkwmruR4m+P
 Ft1Qw+jQK4FIij7Pc0oxXw+Z8k+pECFn8Hfj1w1IMjMaRXGGejY9sEhUZ7bvNBCY7JGV
 8XaE3aXAvjDeln5bdcH1qeLTsW3ywhKtT4CjY2j8jQ0o9u4A4H1QBy9BG7AuMG7BAQt2
 tzdsuohftDKX0bKUTpx/SDL9tDMspp4G2XnmOqOCOo7qm13bP/ykEMOSNlBM71z2a241
 edTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9otolz8LnHFqT3+vPt0rcAxVQCDYIuagj+cZZmuZLE3KVI3i7tcKXyfI+W/pECxvlJZkTO6Ypc/au5@nongnu.org
X-Gm-Message-State: AOJu0Yz+FW7O7rAF8n0/zeDduOi7cBppgGO/MqAdHvugNwhKObDR2XBE
 kcR47DSC1ak/eUEbVa/Pb6136Xj5aN6GCRAyPk8SkNZOllUpxN8F3R4CENy2A5hfYMc=
X-Gm-Gg: AeBDiesiwxZPC/kzF37BIo6otRPuecblKQy3sgXLprXDipRx9jK0aSFaIbOzd3iEvS2
 n2yPJBHOMHsATG4J5FITdWPf5kVSyOodSZ3v0JT8mcetcBotxbWzHu95Bk05N1BKauhW3GRAEet
 YqFo349pmnLct6et5ts0uRE40zFAjuuguzjjKB8IFT+GBPItjRk4hwzQLnkO/zp2IPRMYwc7Gms
 bdwv/PphGpX3ajaSWlXvAyxpgXYIV3umlwCahfuqRFIIOJZWJD7XggqgLdTyOclL8IADdNrSIR9
 5rjzUvaVHqGFqsLRQpT013vI82qcoGuHdZudAtgkIzaY95wFFyWaQr+D05H0ZUr1206M7mL9mGW
 Pk+7LuBMD4SR+6j5VUk9PFLRSPCCsizFRk271trN7ealoCp+gdfirebOKPvpCE+6jmPc5L1JWgP
 IZieCENBmPo9SquNcelBPJFtnT3Qm6SXi3nJqPL+Mb50/VQCA+r4j9y/u6Wsh4p2kt0h4WSab27
 ckG
X-Received: by 2002:a5d:5f43:0:b0:43d:73d4:b27 with SMTP id
 ffacd0b85a97d-43fe3e1575dmr1847724f8f.32.1776405315621; 
 Thu, 16 Apr 2026 22:55:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm1748058f8f.13.2026.04.16.22.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 22:55:14 -0700 (PDT)
Message-ID: <90529ec8-9f54-43f7-98ed-a161ea1576eb@linaro.org>
Date: Fri, 17 Apr 2026 07:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/37] hw/hexagon: Introduce hexagon TLB device
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-35-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401152657.314902-35-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 1/4/26 17:26, Brian Cain wrote:
> Add the hexagon TLB QOM device model.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/hw/hexagon/hexagon_tlb.h |  46 +++
>   target/hexagon/cpu.h             |   7 +
>   hw/hexagon/hexagon_tlb.c         | 466 +++++++++++++++++++++++++++++++
>   target/hexagon/cpu.c             |   3 +
>   4 files changed, 522 insertions(+)
>   create mode 100644 include/hw/hexagon/hexagon_tlb.h
>   create mode 100644 hw/hexagon/hexagon_tlb.c


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index ab5bfb0ed0e..4da1b01fcd1 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -23,6 +23,7 @@
>   #include "qapi/error.h"
>   #include "hw/core/qdev-properties.h"
>   #include "fpu/softfloat-helpers.h"
> +#include "hw/hexagon/hexagon_tlb.h"
>   #include "tcg/tcg.h"
>   #include "exec/gdbstub.h"
>   #include "accel/tcg/cpu-ops.h"
> @@ -50,6 +51,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>   }
>   
>   static const Property hexagon_cpu_properties[] = {
> +#if !defined(CONFIG_USER_ONLY)
> +#endif
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
>                            qdev_prop_uint32, target_ulong),

Changes in cpu.c belong to the next patch.

It could make more sense to include the rest of the patch
(hexagon_tlb.c) in part 3 (HW/), since the following patches
of this series don't access CPU::tlb.

