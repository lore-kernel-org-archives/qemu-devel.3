Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6093C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmNM-0005Kb-UA; Wed, 24 Jan 2024 18:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmNL-0005KL-Ga
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:09:43 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmNJ-0000bi-QP
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:09:43 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso3451356a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137780; x=1706742580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fs98+CSm2qHFGAbUGWSmkx0Im2D+up7RQ785kU9wWUw=;
 b=I/b3sFYvtbG/V2uLFcv1AZVL57gzl+B7PpqvPal7owZnNp+ge7YsC0gq9zppWFf3J6
 l1fgK3lOcePCNSmYIPSsNtmUc3x677nsnb2Kdxr1yOI98TyL9+kde2E61gI7rOERdyaJ
 01z1CHEF6QSxL87rP0C4MXS74tYQrFu2KCULoKuvHfXjrfhxjZoYdHrurX0vPL2cdfK0
 kJi1Byd4VzCql7tuNOlxI+9wFjBsyD1XeqKjPiAAfk1zohLPVhECJvoaAO/P3SmoBlAI
 o1LkIq2O84sYJtpOIDjiTyrazcaC5puxNAR/jb/E5g0sx0of3Uhu+XokefiTMurW/ZLP
 lBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137780; x=1706742580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fs98+CSm2qHFGAbUGWSmkx0Im2D+up7RQ785kU9wWUw=;
 b=QYlcEgVucKVE/Nk4qxYJzoIcTSy9MKBwH3jdUJJE5ROO7EXvK/1HVayq4APDMeHzLJ
 JKw5T2HLsq05dfbNfL4/GVNyLaFUheM1/7y8XnR0MwtBy4FGJi+HO5q9GTYFP9uLFcFS
 bbhWTkEDZGPruT6CICgi9HPrXfwAZVNicIcYe9pMhe+VC+rIJi5QbxD0yBw2J0p/stpv
 2R4nLNHHR357AP2LkTZUnYUfGgBBRXjoJF3Bt3xpqLPO1+QSAMlOdXQFHtdEIE6NuMIm
 yDtkoTuu2ihFI/IxkbFQQj7CmBEeUmBbiFQsI/nFCUKO7an9CVsyDp30hJFoaW3jF2ue
 K3Zw==
X-Gm-Message-State: AOJu0YxLsyNYSUz/5cCZb2Z/AXEUFVzvUyPfhqVbBrEHvn9N/YWqYPDP
 O5C96Dz9J1z3NUY/ZkYPtNSKu42V5pK3yVc3muEqOSRpYbVmTi7sVq6LHn6Wrtw=
X-Google-Smtp-Source: AGHT+IGBNofYYoTBDMksevxinLmi5s+JLsPtIr1CJ/1oFnVP2upFoV5yXWf11RLSYr1tTMZYfiGmQw==
X-Received: by 2002:a05:6a21:a581:b0:19b:435a:a139 with SMTP id
 gd1-20020a056a21a58100b0019b435aa139mr188840pzc.11.1706137780185; 
 Wed, 24 Jan 2024 15:09:40 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a056a0010c100b006dbc750ea5asm9684090pfu.196.2024.01.24.15.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:09:39 -0800 (PST)
Message-ID: <264a79c2-7aad-468b-b53e-a269b524bb11@linaro.org>
Date: Thu, 25 Jan 2024 09:09:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/arm/vexpress: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123222508.13826-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU types.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/vexpress.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index f1b45245d5..a3561a1b56 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -783,22 +783,32 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
>   
>   static void vexpress_a9_class_init(ObjectClass *oc, void *data)
>   {
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-a9"),
> +        NULL
> +    };
>       MachineClass *mc = MACHINE_CLASS(oc);
>       VexpressMachineClass *vmc = VEXPRESS_MACHINE_CLASS(oc);
>   
>       mc->desc = "ARM Versatile Express for Cortex-A9";
>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> +    mc->valid_cpu_types = valid_cpu_types;

Repetition of the cpu type here.  Do you still need default_cpu_type?
I didn't see it in the highbank patch, but it might have been outside the patch context.

If it is needed, perhaps "default_cpu_type = valid_cpu_types[0]".

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

