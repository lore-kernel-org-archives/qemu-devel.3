Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB5C61DE7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Feb 2026 12:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtm3q-0006yB-J9; Sat, 21 Feb 2026 07:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtm3h-0006xT-St
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:26:06 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vtm3Z-00052R-IP
 for qemu-devel@nongnu.org; Sat, 21 Feb 2026 07:26:00 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-506a747448dso23464401cf.0
 for <qemu-devel@nongnu.org>; Sat, 21 Feb 2026 04:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1771676756; x=1772281556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MiW1P1ygiJ9vkWtTm4i75ZJiUCNyn0bvJdy4RUdTtog=;
 b=oV0xuRp6p8N5sGVgomGdrK1sz7Hw3TngRuY6q859PnTJvBnKOSp90nxWqx8DQZjiE7
 LnJqbG2l15bcOdLoRFysXlvYxvwDKfSnl8G7PqOtddADPmmepCTp4Zxan5Hgd+Jk77k/
 02VixI5qhud9zfAsFRcFiC1rzyq24BpV51iNbWmMALzZUywqrM7eBHr8cs+XTqVODaRp
 QdQiS3EYLSy5NXCD9D2B7qnr7Ve2Q7o0dgX1DgLXcIFQtUQsm7I2ql699lbF8Wrj7/QZ
 PKI0er4PQQguzYwP88m81nHDqKvJJqOiMp+QRdQyzSOxYwe6lon2fk/gmIxCKrug95jz
 iufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771676756; x=1772281556;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MiW1P1ygiJ9vkWtTm4i75ZJiUCNyn0bvJdy4RUdTtog=;
 b=ArMnQ4eFfUnCsKxXRO+gswBlJMAweEQGlTEf6Htemxi7dYcrASWKzdKlyksAWg+zIO
 AzcR742WF/3ovTTBh0QVVrVVAFX4PE1k/APuDX18ChFE8WRI9qVEsm9v+whbrt9KYfmD
 m2XFHdPOxVHdKokW3ek04iKjIGOqlOKddNDpRWGr/1JJVv6640ERXQkbeZ+nccr40rj1
 yXWd2XtlMExy6IHwcDM9i3DGs7TGEqoB2EJQ5WUKuRij6GwgRfExma+G9RI/Zt4d+w7X
 GfTTu/anGvgZAhbREiaGLiAqeHUg+RUA+/TXqKFO+zu5lc/tte4xHvE/nQh6Xivgc/hs
 5XIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP2joQL9xCLGjHK0jL3dBEP19ZS4sc4PRAek1FvtcbP1mh0XbeyvRpJE4ottoqMAbSr3R2dWVqGLGb@nongnu.org
X-Gm-Message-State: AOJu0YwuSnzCkT883nzKTZuESDuKbau8fdsZ1ef1QsdZ/eb4oxayowU0
 RrD0mAtv/s5uW5FdBoO83YibaoVmahwNzyMTGU7S2Gl0mNGbeY37yJYdhAUVgO7ZR4w=
X-Gm-Gg: AZuq6aLtNyGZG0zldifo/4tda1z1/NU1WR4Ozaf0uOd3aAVDbMPgaA6JLi0VdWlgwbr
 WoUNiy9UQWz9Ev48aWyXe+H5UiTJtC1OvDwbOdl9vp+BeJrn3EsUWcr3+IfmQ73cYuWDbZGgJHU
 2+zKKpkY/8nvkV4tkaSBQAbnCGtG4y/381yWCFnbVjvM9rhK206Yw5jCQyzGkx14ANFkNoc5PWY
 7GKKp/c8Seenl3N+9c9HzTBQe0OKsS4xZmIMroyKFPCDGcQgbtvaXashzQRvRlp6Gnq3DGK3J1k
 gznTvkEFv93yIbQ5ahDjg5hXpJdkV9enB+PeUhUGxbDC3iREVBDYL8cmZSFbPDvOxOupcWSQMYA
 kwnD2714C80LASPLhogIDrsXlw8CPJF6hcfbRbadF/eZJrCJiw/HbVp6bxb5eGrw/pTrWdk3vy7
 t5CYIUr1SWlHQkRXVWafaZ1L3L0lZjkwGLRtD1CmwCUsfhN0pqG2Qdoxr9cRBv
X-Received: by 2002:a05:622a:1647:b0:501:3b8c:7d63 with SMTP id
 d75a77b69052e-5070bbd9f49mr41837421cf.26.1771676755812; 
 Sat, 21 Feb 2026 04:25:55 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d6a2759sm17069611cf.17.2026.02.21.04.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Feb 2026 04:25:55 -0800 (PST)
Message-ID: <51bfa691-5ebf-4ca3-8835-6e95e67b4526@ventanamicro.com>
Date: Sat, 21 Feb 2026 09:25:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/50] target/riscv: Remove empty target_monitor_defs()
 symbol
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-24-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260219191955.83815-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 2/19/2026 4:19 PM, Philippe Mathieu-Daudé wrote:
> Prefer the stub target_monitor_defs() symbol introduced in commit
> bf957284006 ("monitor: remove target-specific code from monitor.c").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/monitor.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index ccb7eb44d02..a9d31114442 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -244,19 +244,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>       mem_info_svxx(mon, env);
>   }
>   
> -/*
> - * We have way too many potential CSRs and regs being added
> - * regularly to register them in a static array.
> - *
> - * Declare an empty array instead, making get_monitor_def() use
> - * the target_get_monitor_def() API directly.
> - */
> -const MonitorDef monitor_defs[] = { { } };
> -const MonitorDef *target_monitor_defs(void)
> -{
> -    return monitor_defs;
> -}
> -
>   static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>                                    target_ulong *val, bool is_gprh)
>   {


