Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982B9C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmJy-0003N8-7k; Wed, 24 Jan 2024 18:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmJv-0003Mo-GW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:06:11 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmJt-00085G-LG
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:06:11 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-290a55f3feaso2819905a91.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137568; x=1706742368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T3NiYG52z+57CnBGm9UZ73JyhValXWnn0MFiG1bhKYA=;
 b=G4aFNvLk2RN/+UBqll4wneQrJOjG+4GsZtCOhelMJIYJGcbtWnoa9OIZSUEYcBsWvP
 WyHcjnIvTefe2gc3Egnn7GhvxfxTI9oKsU3tn1qd52e3SYyL4Yjkcvz0uVD5kyV5UtkG
 iDWLD3w9SfX8qr9Qbo7dAg24kQz5CS6FJiGgimmE0oaPqPDHTEqLHSukwwMdIr769s0a
 DUdFHWKMXNQjyNweiLpFYZRp0mxjUqitg/+1qBTUidyMksML2nhCX2IwPETSTG0ASOhK
 g3uPuTw4nECkWXyviDj2gWNfk8ytmYvTjQd8Mg2dE+JFmImX5lGBdsKoqydpzsSBVyKt
 E6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137568; x=1706742368;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T3NiYG52z+57CnBGm9UZ73JyhValXWnn0MFiG1bhKYA=;
 b=UFJmLU8Fw9g+9yGm9UM3Z0jh+IkyMV4am/xQi3yMXj858MgjJdB/3MMA40cz52KqJm
 /uRRnbwP6Yd/aVOuvpJCqysPXKCZbsjPX0nU5zklKjhVlKZbOQPMUhzPQj+4QvkS5DAK
 hgqo7uKNqpKR0Lh2oSsT8HQtXUnc3NGo+ZGoy0k2AcmL9Q9DL7/wn6FvW39xeu7TtdHx
 EyHqXZcTsj22cT2Gbz/g6rbY62y2+Ul5adNIrc44QlD5q/CEz6ptzl+A9jc9qF4YYWyv
 QCciJy+Q/yC4pk8u83RHBx5bACqJBUfqKizJj2Cg7TMW7m6VVdcXOwStmeeTbfaIYqN7
 Qy3g==
X-Gm-Message-State: AOJu0Yx7ZD6zVh8whT7dz5uttQLREVakZrlOkPtrSDg1wb+GXJvoO3oF
 cn4Y10v12rNEQyQtyxpCAa27u88oJCpCMAou86C/psIFsRAt4hBxxg6hJ9BzEGw=
X-Google-Smtp-Source: AGHT+IGjFMYLb8f0gfMxRcq9/flCsz12jNSaC+wF8r5OC+CobVXeS9f8yJl9BIxhweH4HV5IU8Ra4A==
X-Received: by 2002:a17:90a:a89:b0:28c:bd2c:b3b7 with SMTP id
 9-20020a17090a0a8900b0028cbd2cb3b7mr87687pjw.54.1706137567915; 
 Wed, 24 Jan 2024 15:06:07 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a17090a2bc200b0028be1050020sm180008pje.29.2024.01.24.15.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:06:07 -0800 (PST)
Message-ID: <b75610b4-ffd7-4fd9-913c-5434c7e3d443@linaro.org>
Date: Thu, 25 Jan 2024 09:06:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/arm/exynos: Check for CPU types in
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
 <20240123222508.13826-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123222508.13826-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
> valid CPU type.
> 
> Instead of ignoring invalid CPU type requested by the user:
> 
>    $ qemu-system-arm -M nuri -cpu cortex-a7 -S -monitor stdio
>    QEMU 8.2.50 monitor - type 'help' for more information
>    (qemu) info qom-tree
>    /machine (nuri-machine)
>      /soc (exynos4210)
>        /cpu[0] (cortex-a9-arm-cpu)
>        ...
> 
> We now display an error:
> 
>    $ qemu-system-arm -M nuri -cpu cortex-a7
>    qemu-system-arm: Invalid CPU model: cortex-a7
>    The only valid type is: cortex-a9
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/exynos4_boards.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

