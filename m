Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1ACC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 12:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh6KM-0006Dg-Jt; Wed, 30 Jul 2025 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uh5Hn-00069l-AB
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 07:47:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uh5Hk-0007oe-PR
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 07:47:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so2896469f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753876067; x=1754480867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HCXiMskQBFCtQvPhBONgIvSNxHYl3hKDTQKGalogzZQ=;
 b=dI7aSagCVF4kvFBsV6vw+zdzOwamebV/BZeOCspEgT7x3wNKiO/Bmv9qAq8a4+Fe0+
 bS602XfraTxGEmBrxfJqW6ufIV8L3+Egdv9oagjPuacBa3WIgQjVSd473vlP1tOzNkIx
 K8iFErgCcgnpsUD0uo3DxelpPBZnd36vT4l6e1R7xlnyh5LjLcW6enXLESFnbM9J24tu
 DU+swut9uwNi+C07zFEarkeu5yj6LdK26mqSx750LPuhOMQ/jtdyBWO1F5NmjC8d5UmM
 fHG/BG4y6NoOz95tQ/nzZFjGW6XydpIwyT0w/PuoRia1VPFxByNYpKX3LK87NcT2bpVB
 28tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753876067; x=1754480867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HCXiMskQBFCtQvPhBONgIvSNxHYl3hKDTQKGalogzZQ=;
 b=XL824qoRFMdAqBXfjRQ9rqL6eL388b/fG709PKfrN/hR4JmcSDr5sOR/MAHN6KXszk
 42T8Xk8WyzymlIwpDgw4qFEwSWJMMDbnmOTV22xFJofNYIWUsyW1EOlywyZ3AynLXZer
 n3PVpNB8dNmmw+QxIJ0vHxuuQvILrhVl7lEf2SlKVJtl5liCFuIVNYyoGFCFXNAhckxx
 /vVlkAtHMlwgokLIjwKk1k33tupo8qf4gIELQWyDWknN8vpjXPnikh+T9FjLhsBOfgao
 ya1FGEIqHR5Lr5O857SWgPf6w+q7F3ub3Rk205FYkR58qCY7qbyFEUUKKc48n9MXqfXl
 AVWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlGqdBi1MT/65Zt+3JdDvX2zp50u7SnrDqF8cWyjSKzCfM8px661D9qJsEVh7hyixLlHG4sHunAIWV@nongnu.org
X-Gm-Message-State: AOJu0Yy/ftwSq/lxbNoQoHgIanSCLm8BE7OQjWWom/erfMxisviE/1Ox
 2s4BM1A8Tt0VzD+qGRGk7R3AlPDWvF+qDDfAI1wcy+w2uefAbDCA62yr2luikUzTeRY=
X-Gm-Gg: ASbGnctPotJNxIlC8kME8kLZgnoY/QdRXj+XhhdQ75gigXaC/HG1uSapz+NnmqDpyrD
 heaV2Pc+sBnlLWQdj+dg50C/JWr7ysxLSfip3fPIqSPZa0Q50bymeCUbnPNcU0/5KTeTnMlfmkA
 Egif3WlNum3UrrMjz866nXcFuyzJyq39hPZLS1b8DUq11UmeOA662Zguwf+0N6EZIybGgqVyT1f
 TXxSkM3TrsqccAKxWS1/4d9RGbTH3rXlXpFe0EXLbD/nixlXnMoe7RbpWvJR4yckBm1/E3MlO09
 ge+ijwUQ8gpaxeTxvd7dby3Ve8siaK5ypAfk2srnonWFD6Hfo8KSXKRFa4DdmsVaOzmECzCK2XY
 wN94XEb9F2arrzLrWaC14HvAaaW1axiRyzKfhM8FoexYNnhC+Lg4MpNjesnnnokMADSCTAP07bW
 rf
X-Google-Smtp-Source: AGHT+IGbZqAH843+BtkMikig/HG/pzb+f0TtXRZY1uvCfwpAkbiDA5ZvpBrMsAvn6dht0xy5lOYPgQ==
X-Received: by 2002:a05:6000:1a8a:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3b79501ee17mr2092830f8f.29.1753876067119; 
 Wed, 30 Jul 2025 04:47:47 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f034a6sm15736163f8f.47.2025.07.30.04.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 04:47:46 -0700 (PDT)
Message-ID: <3db87420-ef95-4548-a74b-be38f0794a90@linaro.org>
Date: Wed, 30 Jul 2025 13:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] pc-bios: Update vbootrom image to commit
 183c9ff8056b
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>
References: <20250730045813.822132-1-clg@redhat.com>
 <20250730045813.822132-4-clg@redhat.com>
 <SI2PR06MB504176530DEA90C6B261758AFC24A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SI2PR06MB504176530DEA90C6B261758AFC24A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 30/7/25 07:08, Jamin Lin wrote:
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Wednesday, July 30, 2025 12:58 PM
>> To: qemu-devel@nongnu.org
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>; Michael Tokarev
>> <mjt@tls.msk.ru>; Peter Maydell <peter.maydell@linaro.org>; Hao Wu
>> <wuhaotsh@google.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Cédric Le
>> Goater <clg@redhat.com>
>> Subject: [PATCH v3 3/3] pc-bios: Update vbootrom image to commit
>> 183c9ff8056b
>>
>> Full changelog since last update (1287b6e42e83) :
>>
>> Hao Wu (2):
>>        Automatically search for UBOOT location for NPCM8xx images.
>>        Dynamically detects NPCM8XX UBOOT destination and size.
>>
>> Jamin Lin (5):
>>        Add initial support for AST27x0
>>        ast27x0: Show build date and git version
>>        ast27x0: Initialize and enable SSP/TSP using SCU with reserved-memory
>> from DTB
>>        ast27x0: Fix missing SCU module reset for SSP and TSP initialization
>>        ast27x0: Fix Makefile to unconditionally set CC to support correct
>> cross-compilation
>>
>> Compiled with gcc version 13.3.0
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
>> pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 672 bytes
>> pc-bios/npcm8xx_bootrom.bin | Bin 608 -> 672 bytes
>>   3 files changed, 0 insertions(+), 0 deletions(-)
>>
>> diff --git a/pc-bios/ast27x0_bootrom.bin b/pc-bios/ast27x0_bootrom.bin index
>> 0b9b3a2360e375bb6007ecdf13b39d931870f6fa..a4c94d64da55ade9b4beb2a4
>> 09132f315fb51347 100644 GIT binary patch literal 16408
>> zcmdUWd3YSvmGAG?Ew$Q`aJ00R*#4rDmwcu%c#|v{oT#)wAWjC;^aI9_QMaTv
>> G7^%t
>> z7#v%{W#gGF;=SjJ+O%;1$%f3JddwRh$cdXFgK$V5!Q?$7%xVlR*=DnoQM{@_(tY
>> 2#
>> zRV}s5GMPVL^P#S;I``aj&+<Fxo?EU2JgI=k4R~e%o;1J%0Q8*>cr+M;rGQ6=F<1h4
>> z0x$-b10Dm$;8MUd0Ap}5;EBN)ywVx_|I=ry#$Ojg<O9awUX;CFr0PGfVCYv;a9b7
>> h
>> zcpb36M&qxK36bAZ&R>7OoWCAG;Tva!$S=B`-ByX-!Ac#kmIvl`J;rg{iyXI|<hZQ|
>> zDW@#Jzph$8@DD(AM<&eAgvhVvxGj|Q+y%pz{QP<#JeT1%9f<dQo4?+p@z)dc
>> 0)=lJ


> 
> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

Did you meant 'Tested-by'? =)

