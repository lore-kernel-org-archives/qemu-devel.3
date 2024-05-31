Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A56C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwfK-0002Iz-4c; Fri, 31 May 2024 03:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCwfI-0002Ic-1b
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:27:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCwfF-0003KW-GL
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:27:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42108739ed8so22715405e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717140419; x=1717745219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ant7jxHVRejyAoPAAXug0LhwHkLSC8vuMIfNaUfNm3s=;
 b=LpqeHYMaIkzP+6jL3gyUn9BHhlClLlUVh4zNV9XVlFaOIE+yum4IjGU7K/B0Th/6wx
 k/9FaIE8ml/QqLkn0cI/DNADujJ/DS1U22C+Snwf1T5P4dPWm1ePr2tXXnOs0RgvhZe7
 ABJVrf/xOLKAXSNQam03sMv3WGnt1eGkjmmeypI1hnSNSdmn1c/Oql1niJGSkhe1lyAI
 GKI/P9gOXSg1wFabfki3o4YxWvPWrzAhXldtrHQYygqSemnxe1toY/h6jLzrKIv+D0a8
 4F0HhGmLk4YlWB3LozPtZv+/v08F82H0PjwWoTDNq0Q60tSAx8aGnJuDyNQkXfMhRrKw
 ldwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717140419; x=1717745219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ant7jxHVRejyAoPAAXug0LhwHkLSC8vuMIfNaUfNm3s=;
 b=NXuTPDhXE9cBh+f1/7HAnnPTSGqjgrWTD3hoKRFG7iT/ISsCEbdtKU2rrCPTHEuFAd
 jjP9ZfmPYiqwsr56+bMsB6A6X4Y+lnI5qxH8gj56TZxaDTY7NN6LrRZYGwhmjOBozRCR
 y6EoWHHCdRmRKuYmV22kv5GYidWuy1cNxSj12BFKyr08U5LFRaBzfnpg8XOrsiWwewlB
 csfajWyq7lkuqaftH69BJe3QmqOrhMdiNxAc6u0HGZRXb3SCkXzWk0QlYkRk86GKu/yj
 nbPErIvfaURhFHRqDVmFri05e4GJdwTcFe7pdWIT+BGFVuVadrg82IYWdmLRjDg/2q7u
 9+SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ZLh47gqecfzHmX8djeOD5UEJNPRG2dzAl2qSMZwwV0uKm3GDfgUe9kmjjbEhcnrz607sDYdAw2fBzCatLzvbpJwsZ8U=
X-Gm-Message-State: AOJu0YzCOy4dhnqrMhdSpHwLwZRKm3TKoBtUaArwkaSIK38BfqKztx/h
 9TWIBtNW+QG0hw7Mfp+QMQ8v6dt9mhNFUqIN4DIhXPpclbA5AYjcmy27KjdhGov5314lx6XdO0j
 P
X-Google-Smtp-Source: AGHT+IEm8tqDLqUjwwHRGtH66f8shMdjDJ8znW1PQcz/gPTM/wAUU0kQZP29ZFwTN/rBEBGKXt44jw==
X-Received: by 2002:a05:600c:198b:b0:420:71f7:9752 with SMTP id
 5b1f17b1804b1-4212e075534mr11152275e9.18.1717140419395; 
 Fri, 31 May 2024 00:26:59 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42127056366sm46039335e9.3.2024.05.31.00.26.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:26:58 -0700 (PDT)
Message-ID: <1c950cd6-9ee0-4b40-b9d6-3cc422046d65@linaro.org>
Date: Fri, 31 May 2024 09:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] core/cpu-common: initialise plugin state before
 thread creation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-6-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530194250.1801701-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 30/5/24 21:42, Alex Bennée wrote:
> Originally I tried to move where vCPU thread initialisation to later
> in realize. However pulling that thread (sic) got gnarly really
> quickly. It turns out some steps of CPU realization need values that
> can only be determined from the running vCPU thread.

FYI: 
https://lore.kernel.org/qemu-devel/20240528145953.65398-6-philmd@linaro.org/

> However having moved enough out of the thread creation we can now
> queue work before the thread starts (at least for TCG guests) and
> avoid the race between vcpu_init and other vcpu states a plugin might
> subscribe to.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/core/cpu-common.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 6cfc01593a..bf1a7b8892 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -222,14 +222,6 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>           cpu_resume(cpu);
>       }
>   
> -    /* Plugin initialization must wait until the cpu start executing code */
> -#ifdef CONFIG_PLUGIN
> -    if (tcg_enabled()) {
> -        cpu->plugin_state = qemu_plugin_create_vcpu_state();
> -        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
> -    }
> -#endif
> -
>       /* NOTE: latest generic point where the cpu is fully realized */
>   }
>   
> @@ -273,6 +265,18 @@ static void cpu_common_initfn(Object *obj)
>       QTAILQ_INIT(&cpu->watchpoints);
>   
>       cpu_exec_initfn(cpu);
> +
> +    /*
> +     * Plugin initialization must wait until the cpu start executing
> +     * code, but we must queue this work before the threads are
> +     * created to ensure we don't race.
> +     */
> +#ifdef CONFIG_PLUGIN
> +    if (tcg_enabled()) {
> +        cpu->plugin_state = qemu_plugin_create_vcpu_state();

Per https://etherpad.opendev.org/p/QEMU_vCPU_life, plugin_state could
be initialized in AccelCPUClass::cpu_instance_init (although this
callback is called at CPUClass::instance_post_init which I haven't
yet figured why).

> +        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
> +    }
> +#endif
>   }
>   
>   static void cpu_common_finalize(Object *obj)


