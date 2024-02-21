Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26126C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcouN-0005RG-50; Wed, 21 Feb 2024 10:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcouF-0004lX-43
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:53:12 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcouC-0003ka-O5
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:53:10 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41278553215so4337035e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708530786; x=1709135586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=miTX8Ft8lx0FOfvhh6Kzngy4bFsa5OAExlzmetUdYTY=;
 b=yKBGDg5QjsZcVpUg2HvA9f+dRxg8jNE06IHo1tnBWDvgxumVAQyKCoA///cbdWR4kj
 MRr3fhy0QUuYu6grByNGWCEHEL62KqKnp3dqylY2f91WTW9A39Zod5YpLIWuONOPepYO
 0QEMAah9ahnfBgHdwmIrn4xOWgb6/d4tmipk3yfaxSPn2Bdz3bdy9FIGqVoag2Pf/6Up
 uXNQ9rAUFOP+0yIniNvstcZjNUbuQ9Bro4n3eINphFbu75CHUarWvfYm1RBLcgEdPhQ+
 BIOf5QsXpA5ROxDOn4CDhGDVoVY9c+CB8i6jlqoaKQqmZtNr3cnozcoJCERHM2Mf+TmQ
 yKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708530786; x=1709135586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=miTX8Ft8lx0FOfvhh6Kzngy4bFsa5OAExlzmetUdYTY=;
 b=WBETHfJnIrp0BeI39PtcbIVRV+5Vb3mqp1ic1egBDXTueUi3NatmPfwV6ZrFZgli/e
 ze+J3jXCXjVgc4GraIIERKOS3JG7oRTZ7obXSlfRTIU6kd7b5FWo6pR+4ic6FmqiP1W7
 4a4W+msPUrZFjTfBPsUUeA5i8cpsc0KxnI4xHegFyq1x3C89r3U7wwzJstms66rdeQAH
 tHFcCvxEBXZtAdvrnHYGBhbPqxMc7ObqcjrPCWxB9w8nJZzb9I/o75gpRa/LfK3/oZ4p
 0Jqmp+UnKZQPMTUksCgya0G37vaej+fn0pKMOZcWj+GwWlo9NzXz3Drz8MqtvMciP1LL
 S2ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW74lL0u96SCyzIk9Hq6zfZqGKkDe1CjrVenGhbkainKunDCQd5Qxi4zVkUKo+H1wzpBpJ5oq2vqn5Rq/Dhean0WaMA9/g=
X-Gm-Message-State: AOJu0Yw9up0FAFG5CZ3UvZHmOkGY3kupHWEc0+xilywcve10TBR0YpzG
 tcPiI8bTmMLX9F167jWs5J+tSPbL4mjy/SG6dj9Ci1LveL2a/l6a2w4cJpeMRB0=
X-Google-Smtp-Source: AGHT+IH3N860ye4oTMSB7E9K/CNTd/IzONO3/Twhkz/rSbaEbPuUqXfsZxsk9sxeBnqr6hmLe9aIUw==
X-Received: by 2002:a05:600c:35d3:b0:412:6c30:59ff with SMTP id
 r19-20020a05600c35d300b004126c3059ffmr4460984wmq.0.1708530785970; 
 Wed, 21 Feb 2024 07:53:05 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 fs14-20020a05600c3f8e00b00411a595d56bsm18338787wmb.14.2024.02.21.07.53.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 07:53:05 -0800 (PST)
Message-ID: <4244146b-9ce0-4a59-962b-4bfe2be1bb3e@linaro.org>
Date: Wed, 21 Feb 2024 16:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] hw/i386/pc: Defer smbios_set_defaults() to
 machine_done
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-6-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> Handling most of smbios data generation in the machine_done notifier is similar
> to how the ARM virt machine handles it which also calls smbios_set_defaults()
> there. The result is that all pc machines are freed from explicitly worrying
> about smbios setup.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/fw_cfg.h     |  3 ++-
>   include/hw/i386/pc.h |  1 -
>   hw/i386/fw_cfg.c     | 12 +++++++++++-
>   hw/i386/pc.c         |  2 +-
>   hw/i386/pc_piix.c    | 10 ----------
>   hw/i386/pc_q35.c     |  9 ---------
>   6 files changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> index 86ca7c1c0c..1e1de6b4a3 100644
> --- a/hw/i386/fw_cfg.h
> +++ b/hw/i386/fw_cfg.h
> @@ -10,6 +10,7 @@
>   #define HW_I386_FW_CFG_H


> @@ -22,7 +23,7 @@
>   FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                                  uint16_t boot_cpus,
>                                  uint16_t apic_id_limit);
> -void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
> +void fw_cfg_build_smbios(PCMachineState *ms, FWCfgState *fw_cfg);

s/ms/pcms/

Otherwise, nice cleanup:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 7362daa45a..98a478c276 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -48,15 +48,25 @@ const char *fw_cfg_arch_key_name(uint16_t key)
>       return NULL;
>   }
>   
> -void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
> +void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)


