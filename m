Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB580C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesES-0001JD-KY; Fri, 16 Aug 2024 04:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sesEQ-0001GN-P4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:22:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sesEK-00041M-Ev
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:22:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428ec6c190eso12802695e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723796558; x=1724401358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BHGGhtLqzZKuq6qAyVy41on11yVs4LA8g12m/RILl88=;
 b=vHE7of9ZcxdZdv2eWjKIYOUYEjfzRFuqBgKTXYlp3VIcpD+QeXL93RLKKXQUSfIBF2
 wpPVjYSwYTF4Fh/KoP8qLX6O85thYyvnIhzIw6Qv0KSbe1t8NTo4DHswBLZoo8WVQ5WV
 UZ26rRKEfeJMskeh0lGPSBCja3lWyu5xj4yHqhozGcGUJL9XU7UDLs+2SCz5mQIZJ5OU
 ejoQ7QKJs0sDN1JIAKv6NBPN3knCHlVgLnTU1SmSx7Iz2xdEtr9vTLeDhEtT9GJqvats
 vEPWkqHx8T+izZ9aZjPiEEgizIwby2uAh4LudInb9H46gfarTQ195swuv10Ze0e4zPNo
 GHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723796558; x=1724401358;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BHGGhtLqzZKuq6qAyVy41on11yVs4LA8g12m/RILl88=;
 b=wr/pcXfLxcTwEU98/pHNDRBtZ5eGRV9YZLNPmtqnTE3HBAJo+bAsyLOWZVYWlwIZ9S
 nESNtqCLYBDhHOhMK5iRFzOH+TwDx+H/1XpV576yb33damVGgjptZoSkr0GUwsi3s5n2
 5OhRJpnEABo0ljcKp5gjBVe/LDovwKvV6MeOhvbf2VEsU0zk7Pv2wv5JQuZY85EGQ6q1
 PowjKkIK5Mux6TqFWH22D8OGrMrhsgqzU6lgGgFO7V+h6pzgXz/BQoDmO99U6JS7GZgP
 H14ZEsFmeArXzWjWOsrgxkVOMCi74WyJ0w/jqPsUb33ZYE1KnMO1gmI4xn0OMNi2rnpC
 d25A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOUPhRLGQB9BpEQ9o/V7MRXxRku/X4naUGCRt4u7ZyG5Z46DitkE2SQlumpvrT/Us4DShdQEfQRhFDN+xTILSZ49XKU3g=
X-Gm-Message-State: AOJu0Yw++aCgNv5cxqLvcycfeO9iSq+7J2y9Lsv+VR8HVmKF32NC9omu
 XoENk8by6q89b9css6fUyegxQ1odV9VbSHiU4HALCH9qVI8wUYu0b1Qnce4EMGQ=
X-Google-Smtp-Source: AGHT+IGg8W4F3JqiZ8zZQSlNdKCXTTii9iYUsGhtg1uzmlGQ3Ht8sMBugMVBaObx1zl6fiJOIFmiRA==
X-Received: by 2002:a05:600c:3104:b0:426:62df:bdf0 with SMTP id
 5b1f17b1804b1-429ed78d523mr14200205e9.10.1723796558210; 
 Fri, 16 Aug 2024 01:22:38 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net.
 [88.28.5.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed648f55sm16433555e9.3.2024.08.16.01.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 01:22:37 -0700 (PDT)
Message-ID: <fca41463-b835-4958-9c08-dfe7d09654ff@linaro.org>
Date: Fri, 16 Aug 2024 10:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2] hw/i386/pc: Ensure vmport prerequisites are
 fulfilled
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Joelle van Dyne <j@getutm.app>, Bernhard Beschow <shentey@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZb5St7968jHLV0r7NORODN3zHgi_qxpPE=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 16/8/24 10:01, Kamil Szczęk wrote:
> Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add option
> to disable PS/2 mouse/keyboard'), the vmport will not be created unless
> the i8042 PS/2 controller is enabled. To avoid confusion, let's fail if
> vmport was explicitly requested, but the i8042 controller is disabled.
> This also changes the behavior of vmport=auto to take i8042 controller
> availability into account.
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
> ---
>   hw/i386/pc.c      | 8 ++++++--
>   hw/i386/pc_piix.c | 3 ++-
>   hw/i386/pc_q35.c  | 2 +-
>   qemu-options.hx   | 4 ++--
>   4 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..c99f2ce540 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1075,7 +1075,7 @@ static const MemoryRegionOps ioportF0_io_ops = {
>   };
>   
>   static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
> -                            bool create_i8042, bool no_vmport)
> +                            bool create_i8042, bool no_vmport, Error **errp)
>   {
>       int i;
>       DriveInfo *fd[MAX_FD];
> @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>       }
>   
>       if (!create_i8042) {
> +        if (!no_vmport) {
> +            error_setg(errp,

Is 'errp' available? Does this patch compile?

Anyway, I think you want to call error_report() & exit().

> +                       "vmport requires the i8042 controller to be enabled");
> +        }
>           return;
>       }


