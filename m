Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C43C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg580-0008Cd-4j; Fri, 01 Mar 2024 10:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg57z-0008CD-41
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:48:51 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg57x-0005nj-Au
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:48:50 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e12916565so1124000f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709308128; x=1709912928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHuuIrgiXICSKqK8qq6mrlldvq7XTPOBjMp5Ode5tpk=;
 b=X1du9C+rV4kh4t1UZMyQjJnGiBRQK576yvSdzRUfBFdsPEEaEDpRCT3DYFZYKHXU+a
 AgLPzQtoeRqKK5BuFIINJ5R3bPERRhMdOsGZwo/A5QfmXVFTetFlaHK+cL3JAR+ZTupb
 2mWsahB0m0UJTXMPFMAeJ6rzGRFfmn3Sq7v2ayU+ysBzpXb44bPANEOORV8JnDzz8OXe
 Bs7YYGyNsHZG1OEBbtnTuO/9sq+eN5P9Q7RxlDgQupBTFRrbI4J4oYGWk+QZd5+M2NRi
 0KMIP1CtwxYqxwt8f/0oFTYsbrnip2NJPGFAdK/4nAZhj9XilYZQbNpPa9SbvEUEhslz
 hR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709308128; x=1709912928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHuuIrgiXICSKqK8qq6mrlldvq7XTPOBjMp5Ode5tpk=;
 b=QUsrtLdAmCf40OjbnJFCcJ3jVMdFzwI20tl4C3jxzLMCtZdja+thGsKAR+9hho4X0c
 X5H6k3d1q8DBhO1G36ETXiRTiAIGUCdp9E5qcnTLQ6zeD8xnqKCSH2hCs/VHGRgMjlf6
 jvIw8LF052LXOVOvu1NkgAdi7eenzalehKaMhfxnr+RsvDKNGYAecL5La+hMK8VPQNm9
 5NC3DZIsw5K4d2vxfJELX/ooQ3m9XCbhV/pRikV3y8mMOFsnCl6PJiNm0cw8Fa3QoGSZ
 fTcDoQ9vPYsUiYUIHXhwXjT8YBDkXwHQimUmyw0qIRIg5xVSJAgi0BYv/JSl+08wjn+V
 gWMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJi0WxcT1ZLxp0B4Gp7yqkKqpLxk430UgJqjHM6foemWZDTuNOHyPZ2gdQizijVQcpV2ZcYttxPJKhjFuQuppOzFDkBc4=
X-Gm-Message-State: AOJu0YwUEk1ql8l1ENddJNsr0aStELANn7rpgcv+grC//BtiFeGsPbzF
 /J9ojpWOE7RIFMY+C5LyzSpaDx7vZrT9TYAbHgRm8oGtfxtno5KvGVcMj8m+RlQ=
X-Google-Smtp-Source: AGHT+IHC2la2xZTDG3n+mmhpUFfXG73HGlEPwFWLlobqxJWHOQAB4hUYuH/O4YmzrYJrF2M7eF5oeQ==
X-Received: by 2002:adf:f141:0:b0:33e:1ca0:8706 with SMTP id
 y1-20020adff141000000b0033e1ca08706mr2129933wro.15.1709308127614; 
 Fri, 01 Mar 2024 07:48:47 -0800 (PST)
Received: from [192.168.193.175] (232.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.232]) by smtp.gmail.com with ESMTPSA id
 bx10-20020a5d5b0a000000b0033df46f70dbsm5117235wrb.9.2024.03.01.07.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 07:48:47 -0800 (PST)
Message-ID: <eb260acf-859f-4b48-a2eb-2aff8416620a@linaro.org>
Date: Fri, 1 Mar 2024 16:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/2] aspeed: fix hardcode boot address 0
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
References: <20240227125201.414060-1-clg@kaod.org>
 <20240227125201.414060-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240227125201.414060-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Jamin,

On 27/2/24 13:52, Cédric Le Goater wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> In the previous design of ASPEED SOCs QEMU model, it set the boot
> address at "0" which was the hardcode setting for ast10x0, ast2600,
> ast2500 and ast2400.
> 
> According to the design of ast2700, it has a bootmcu(riscv-32) which
> is used for executing SPL and initialize DRAM and copy u-boot image
> from SPI/Flash to DRAM at address 0x400000000 at SPL boot stage.
> Then, CPUs(cortex-a35) execute u-boot, kernel and rofs.
> 
> Currently, qemu not support emulate two CPU architectures
> at the same machine. Therefore, qemu will only support
> to emulate CPU(cortex-a35) side for ast2700 and the boot
> address is "0x4 00000000".
> 
> Fixed hardcode boot address "0" for future models using
> a different mapping address.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Tip for the email workflow: when someone provide a R-b tag for
a patch, please carry it on in your next iterations.

https://lore.kernel.org/qemu-devel/09f9ca34-4e0c-4ada-b808-643a8c578511@linaro.org/

See 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/arm/aspeed_soc.h | 2 --
>   hw/arm/aspeed.c             | 4 +++-
>   hw/arm/aspeed_ast2400.c     | 4 ++--
>   hw/arm/aspeed_ast2600.c     | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)

