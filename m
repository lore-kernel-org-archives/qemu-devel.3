Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA5BC19F53
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Rv0-000349-Ly; Mon, 29 Apr 2024 10:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Rux-00033j-TO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:23:43 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1Ruw-0001nj-72
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:23:43 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ee4dcc4567so292942a34.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714400620; x=1715005420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LYyXOFg0p8apARfX+pC2B3snbTJhjKCNRZ3qj9ipkRg=;
 b=eDBVqV2g8F4YTW2qabUD2QJSueFvucP0fFsBG8JttBHlYoBMQtuetBPx14u3R7v20o
 uvj4ttJSP1lzT134V5SMkDHf5qoICSf+su3NOnoBnD4k+MKMn48if5o3MecIRCk/4c2k
 GPmzDL6YDcLgcjDNboalZkfXqI96ViiRi7ds/LYGPxRR1NzpFHGpPFayeF9Syf7nu/7J
 gRjcdFcuiQ8ZoK2ySJpcO8D57qbsWnXSMJ52/bYikxksAyCgP9Zd1gemyTtP38a9qkwt
 uvs27TDvd3OE76a11nkv1fAayh+l+Prhb9Xjsn4WsXGGT2+PKj8acJ2Isr0Oab1wfh5a
 oGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714400620; x=1715005420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYyXOFg0p8apARfX+pC2B3snbTJhjKCNRZ3qj9ipkRg=;
 b=GVggMam30etWFsCvP4Gof+TE0UD0iso+WrAVn6GtCaeBGBd9k0UYA497lUQl0csV9E
 PPRfEnyW+7KEat4i3vfyA5milT6PX/GHPKwi1tPwD6vhr+A9vIGmeLT0UNk+J9U2xhFM
 nN0DYYICMosrWOgPxJIpoYlpRmvEWdHkJO5jWIZPVCDWhDA1V0ebOjVFUEdgFI06OYtv
 5Gnzz0qyraK97Ipw2TVkNcu2SPWviTfK8O9FBEpyUPJUANRXtonNVcnTiYvKgu9YslSk
 vTmZWK2oK5T/wol5uEjwW/3TA+g+nfjnsT1Kt7r3Gk1ly9Tf00+M1S5zmG3IWs7BP8Od
 G8fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfR5xMMIe24qgsSbUUzmCXYMzB2t4ksx8VHw3MWCz/73a4kY6AMN3CWiuKvB7Hx8i0TtP2OB6rdlI3qZJ+C/Ak7wphzWQ=
X-Gm-Message-State: AOJu0YyrDMOuZWj/j+T9O5lC9zHAwwlN1DwzDklfOVfAA6RESA0ERrJY
 kUMPRVdaiWOjesbc2nxFAuCbSxrNakZ7m6FwjsK9bOssFpmjz/8tmE1QkdN9j7Q=
X-Google-Smtp-Source: AGHT+IF1cOMcl85gnnAmGpnAzpWDF3KZUwkoN9mRMLkaFQVZxuq4P2Zj6u5hXUzSaWOs/7cuF0FbsA==
X-Received: by 2002:a05:6358:5694:b0:18a:b820:40e2 with SMTP id
 o20-20020a056358569400b0018ab82040e2mr8217789rwf.13.1714400620490; 
 Mon, 29 Apr 2024 07:23:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a63c003000000b005fe2f66f89fsm1321114pgg.75.2024.04.29.07.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:23:40 -0700 (PDT)
Message-ID: <6562083f-9358-4ced-b33b-072d34cfbe25@linaro.org>
Date: Mon, 29 Apr 2024 07:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/24] accel/tcg: Allocate per-vCPU accel state in
 create_vcpu_thread()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/vcpu-state.h          | 7 +++++++
>   accel/tcg/tcg-accel-ops-mttcg.c | 2 ++
>   accel/tcg/tcg-accel-ops-rr.c    | 2 ++
>   3 files changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
> index e407d914df..d0dd1bbff8 100644
> --- a/accel/tcg/vcpu-state.h
> +++ b/accel/tcg/vcpu-state.h
> @@ -8,6 +8,13 @@
>   
>   #include "hw/core/cpu.h"
>   
> +/**
> + * AccelCPUState:
> + */
> +struct AccelCPUState {
> +    /* Empty */
> +};
> +
>   #ifdef CONFIG_USER_ONLY
>   static inline TaskState *get_task_state(const CPUState *cs)
>   {
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index c552b45b8e..767b321a0d 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -35,6 +35,7 @@
>   #include "tcg/startup.h"
>   #include "tcg-accel-ops.h"
>   #include "tcg-accel-ops-mttcg.h"
> +#include "accel/tcg/vcpu-state.h"
>   
>   typedef struct MttcgForceRcuNotifier {
>       Notifier notifier;
> @@ -135,6 +136,7 @@ void mttcg_start_vcpu_thread(CPUState *cpu)
>       char thread_name[VCPU_THREAD_NAME_SIZE];
>   
>       g_assert(tcg_enabled());
> +    cpu->accel = g_new0(AccelCPUState, 1);
>       tcg_cpu_init_cflags(cpu, current_machine->smp.max_cpus > 1);
>   
>       cpu->thread = g_new0(QemuThread, 1);
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 894e73e52c..419b94f786 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -36,6 +36,7 @@
>   #include "tcg-accel-ops.h"
>   #include "tcg-accel-ops-rr.h"
>   #include "tcg-accel-ops-icount.h"
> +#include "accel/tcg/vcpu-state.h"
>   
>   /* Kick all RR vCPUs */
>   void rr_kick_vcpu_thread(CPUState *unused)
> @@ -314,6 +315,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
>       static QemuThread *single_tcg_cpu_thread;
>   
>       g_assert(tcg_enabled());
> +    cpu->accel = g_new0(AccelCPUState, 1);
>       tcg_cpu_init_cflags(cpu, false);
>   
>       if (!single_tcg_cpu_thread) {


