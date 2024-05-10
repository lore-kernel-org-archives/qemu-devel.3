Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE0AC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5LoL-0003Nx-UO; Fri, 10 May 2024 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5LoE-0003It-4K
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:40:55 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Lnz-0007g1-Fw
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:40:53 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59a387fbc9so452804566b.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715330436; x=1715935236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ahdgPeTC9Hwr3TC1O0u/KNWYwdxKjBdaHdY7nGI1DA=;
 b=XHA57Nysdv0S3kCyra9RX4Ms+emngYXHp40gJcOPFITfKElcQARUv2W5jyPsNWQvYl
 PymZ6hJfMPnZ5SmmgticO5CAX+xF6ioz6QAG8bo5l/VKrFCHfIZ7qqFrFn0jrY6drIMr
 akuWX9IICBNaKl0uUB3PmUkNMWO+aqXDvpqlC+DHJbluQJtCjLRuwsMBYRZwMi9GkKs8
 gQMtKEYqGHjLua0UMJRFI1VmKG4JOZQjspQHjQ37LrwS4nr9fbSqMHnejDu6jIo73kuT
 mPS79T/sYl0hbAniCCTplRLXcNfs5fL0aA4M4PP/sAcvrnDS7Lt0HHsP6xOqos+1TwXY
 BjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715330436; x=1715935236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ahdgPeTC9Hwr3TC1O0u/KNWYwdxKjBdaHdY7nGI1DA=;
 b=rHrvitE8o6guB3BjlbvROCSm3n/0hkMxfvA/MeJVcx2AXGsLfNMWztZKyqYHm8rCHV
 Lfa1JoPJ2MdLWu+J/JzE2e+kPoIdVdba1gPVRXOrEv1GSpWrT3TwVIAlJYS53lbsBCCE
 ML6qkJrT135847hPxNbGUgwRtH/f28cfHWGa3jo2qnIre2H+ndN9X0mUrEyTioKciknO
 2F8u46xl4xcc9Du54a0kYOlggpNH31gRlTVqwPdYdh/a4+3XHGSdnye71RbI6clxEvBe
 EMez8Ur4X/w+AFJHplaUtd7RMQa+iNxRFtkRjO0/K0AhTN1OarRXJgmXB59m0g1/YWhE
 AoGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPPxvcG9Zme6nwZpZ2UGIuL5VHeZnCDS4PJzk5V+MB8mercJrddJmDHFVLVboVfnxpnQjurJNuCpM7VUJzY/OcRdOJ6mA=
X-Gm-Message-State: AOJu0Ywdx+xZ11ybaaGxEwN9Qn7ZaUyXDnmaDGkflFVkDg1EwndFOSl0
 rc1oJsHESHD8jeGFtA6ge/eqx3Zk+jp+cmKsaqsVKX+DGSH5+5OHp/u8uSswaK4=
X-Google-Smtp-Source: AGHT+IHqnfVXBxdrA/r/ELf5OLgR6n3iErrmK64+q7KrbiKgDeiLAZKp+LO4T/XNz2iA7D9sBAs8yg==
X-Received: by 2002:a17:906:b79a:b0:a59:aa69:9790 with SMTP id
 a640c23a62f3a-a5a2d54c87fmr125899566b.8.1715330436396; 
 Fri, 10 May 2024 01:40:36 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c822fsm159662866b.138.2024.05.10.01.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 01:40:35 -0700 (PDT)
Message-ID: <7ec09843-2560-4c73-a5c1-9049dea19870@linaro.org>
Date: Fri, 10 May 2024 10:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch/virt.c: Fixes memory leak in ramName during
 loop iterations
To: "R.Samarasekara" <rsamarnz@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, gaosong@loongson.cn, raj3sr@gmail.com
References: <20240509132802.247147-1-rsamarnz@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240509132802.247147-1-rsamarnz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi R.

On 9/5/24 15:28, R.Samarasekara wrote:
> This patch fixes a memory leak in the ramName variable within the
> hw/loongarch/virt.c file. The leak occurs due to repeated calls to
> g_strdup_printf within a loop, causing memory allocated for ramName on
> previous iterations to be unfreed.
> 
> Signed-off-by: R.Samarasekara <rsamarnz@gmail.com>
> ---
>   hw/loongarch/virt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index c0999878df..1fe02f8501 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -954,6 +954,7 @@ static void loongarch_init(MachineState *machine)
>           fdt_add_memory_node(machine, phyAddr, numa_info[i].node_mem, i);
>           offset += numa_info[i].node_mem;
>           phyAddr += numa_info[i].node_mem;
> +        g_free(ramName);
>       }

This has been fixed recently in this commit:
https://gitlab.com/qemu-project/qemu/-/commit/54c52ec719

Regards,

Phil.

