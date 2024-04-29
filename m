Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE532C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 23:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1au8-00079N-Tu; Mon, 29 Apr 2024 19:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1au5-00078s-VF
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 19:59:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1au4-0003C9-CO
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 19:59:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so34693785ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 16:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714435163; x=1715039963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uae32er25EK4T/yjcwC8+YBfgcEdE/nbQ9pROih+LNk=;
 b=rby/Ropf53yisQmFnIrE8kkPJc5rHsj5pNNGp4XeV7/Uzl9uFGT/IN0wULQuOrzyRz
 Kbs3nH+rBl54cvtkp6L9V2rt+K7o7X9o8K/3ahHr4yQ5D7C6gezNNEdZFFCj4t13mzSF
 /Usncueq/W+KXyymHvEk6yEjc7rk822/sbW53FVN7uvIAzL4GENpdaa6MSEshjSYmqF/
 pybSrbOHHKYNwxgSnPXKdz9yjfBQ7d8zVGRdJmbr/OB5MUW0ZacjZ6M19pGIShsiAnqS
 OKOab2feCjtJvzOk3cqGKBvXoaLERkv8/aUOPkGSvdYV+A4D0Du04ymaCBJoeLL+/gv7
 X8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714435163; x=1715039963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uae32er25EK4T/yjcwC8+YBfgcEdE/nbQ9pROih+LNk=;
 b=k2Hw2dubLPXrKJwZ7w1cfDjAP4iOxb+hvg569qk/1gy4XtzoC1xSCLjQskzZRO81R6
 cJFq+Ix157t0NcU0pnetd0edeqFU6fe30tGHrlUozPoea0JpePK79CydEleK3XPqIQan
 Jchle8fGzyc5m2qp61P2W6DzYUqQpbjUlTJIjNC7PatP+o/206dOz8EdJFKIit/6mOs7
 5z6js8lmZiyR3R3jQEDs+hyff5UkAHmvK+ZFRiOIQQrDzDUVx0JUF/crkO4Zmy1P+hFs
 orkt4dM1KfX837Re/Dm9q2W6A0BrA6sED7DFMmITkMVuVpqnHABh8LZHl3Lz5U5moKFF
 KOgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsLIG6hnHPkA8ZAfvVch0Wpf0owrXbmQG9UVasWHyMNRFH6D7rnNV8omP3Lcq1BMw/ZF0IqCt6HErlJmTGafe3TNzRDI4=
X-Gm-Message-State: AOJu0YzlkjoTQGf42Xw+xyFLK+8l4U6wZtQZ1tFVTjaEgQuVKZINI13Z
 jV23SAelrwu/MyAGP5nA0Vdv/U/GNHbSrWqkIZGbDg8AYA6xMYQMHJ/+csULrX8=
X-Google-Smtp-Source: AGHT+IEZoTCI8dDfZbaGCFq0R0D2QLJ4G7YS1H/A9T/XAZ4Nbd9CdOI7fvbhZF1ZFK/G9qKCghE/rw==
X-Received: by 2002:a17:902:d50a:b0:1e0:b60f:5de3 with SMTP id
 b10-20020a170902d50a00b001e0b60f5de3mr1651378plg.7.1714435162630; 
 Mon, 29 Apr 2024 16:59:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 ja17-20020a170902efd100b001e3e0a6e76csm21009824plb.99.2024.04.29.16.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 16:59:22 -0700 (PDT)
Message-ID: <79448afb-373c-4ef6-9310-3b5a9f7927aa@linaro.org>
Date: Mon, 29 Apr 2024 16:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] accel/tcg: Move @plugin_state from CPUState to
 TCG AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240429213050.55177-1-philmd@linaro.org>
 <20240429213050.55177-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429213050.55177-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/29/24 14:30, Philippe Mathieu-Daudé wrote:
> @plugin_state is specific to TCG accelerator, move it to
> its AccelCPUState.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> TODO: check dubious include of "accel/tcg/vcpu-state.h" in
>        hw/core/cpu-common.c.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index f2826d0409..0e5ebbe050 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -31,6 +31,7 @@
>   #include "hw/qdev-properties.h"
>   #include "trace.h"
>   #ifdef CONFIG_PLUGIN
> +#include "accel/tcg/vcpu-state.h" // ???
>   #include "qemu/plugin.h"
>   #endif
>   
> @@ -215,7 +216,7 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>       /* Plugin initialization must wait until the cpu start executing code */
>   #ifdef CONFIG_PLUGIN
>       if (tcg_enabled()) {
> -        cpu->plugin_state = qemu_plugin_create_vcpu_state();
> +        cpu->accel->plugin_state = qemu_plugin_create_vcpu_state();

How about

     qemu_plugin_create_vcpu_state(cpu);

and move the store inside.


r~

