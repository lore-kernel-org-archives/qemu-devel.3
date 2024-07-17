Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC4EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1YF-0003h0-Tr; Wed, 17 Jul 2024 06:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Y9-0003ec-2g
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:06:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Y2-0001LJ-Mz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:06:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368313809a4so240549f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210769; x=1721815569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nv05/SBfkonJ7yIeMR0KEzuez05G26cAjEXoMJBx9FM=;
 b=pvroFfTNR+6gJ2dgHt8RS3phB8DP2z+MCj0Pmtmcoo7TNUdJDtd4ra6FobzDbeMlth
 lEMfsFd8Oe1jjrOJ2RhuxUdEIfKfqJKjJJxSOyzee/ZF15LmWBJGDjEVlptGi9jPV2cr
 fcFfdDlX4W6LiESNQgVNnrICwCpOkuJAKuND7IzZNUzDuwDlvz4kYDfo35a4QeP2vToL
 3KAKRDBIpdQESDXkZFrTyq66owkBlzslbgrdtujex/d7rdn7n9JlmPMSEiA16DDEGejV
 Fc6RMKoP+U+oqRPP7mN+fO/C5aMBJXyv8eFVByjSDYnC1qLTdaZ3XIbsfNAvTG0JU4I+
 W9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210769; x=1721815569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nv05/SBfkonJ7yIeMR0KEzuez05G26cAjEXoMJBx9FM=;
 b=m5TTUnRgbkIyDSG0jJXwE5rXu8FdC2h718LsQ/gYwYOmhybjPrmG6USVYdpf1BesZf
 X/K3UYVrJBVVTk2OgFS9vf3s4IVrM7BiC9HoSucZH0uqeo4mCS7jdLGpEys+ZXmmNo8L
 cKrCofWrNt4VJKSze+AtaUbcVMEPyx9KfqL1Vb1OnabRYk4MDPKXU9whiRnQAFp1THkr
 cdUhu4prTozBKURihoF/Ncce6Yf2wCe/BiwWCNdEKPTStnev9chnndXI5R2Nr5LdRM0d
 vEaxYz4F3s9bkcQLoCU3Bw6Fa04B/f7gy3MW3uM854xCEKORKpRg0T4nMV69cRY6+b+S
 NOhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXmeOQhkokUQ69iXqamsB54qU+fsnOpgDav8L0ql4ob3jet1rBQKgv+oAxMG3uAcLGKAlpQ7YuAPhZxyga2+LN3DWB/+8=
X-Gm-Message-State: AOJu0YzME9PX+0esOSja9C+e3ckZv8b8TbGG3XZVJBdMWb5LrlwlXe6i
 Dsu4XpVGO/hhPBhHq338L3+JQct4kI/Fxizm7JgD2ztqlK27Y5KNf+gWRsIUtQq/pi43JlOBgUQ
 a3+PgKw==
X-Google-Smtp-Source: AGHT+IE/9MOcevEr72x7hzKdb3RTRfNlQTiY4oN4FRAA/RYofEFsgbNqlEjmAADJe9ljJpUqWPBoGw==
X-Received: by 2002:a05:6000:1848:b0:366:df35:b64f with SMTP id
 ffacd0b85a97d-36827357473mr4724276f8f.4.1721210769015; 
 Wed, 17 Jul 2024 03:06:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11260251f8f.80.2024.07.17.03.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:06:08 -0700 (PDT)
Message-ID: <a1e73473-d8f3-4103-baab-769d105937dc@linaro.org>
Date: Wed, 17 Jul 2024 12:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] aspeed: Add boot from eMMC support (AST2600)
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240717063022.549849-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717063022.549849-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17/7/24 08:30, Cédric Le Goater wrote:

> Cédric Le Goater (8):
>    aspeed: Change type of eMMC device
>    aspeed: Load eMMC first boot area as a boot rom
>    aspeed/scu: Add boot-from-eMMC HW strapping bit for AST2600 SoC
>    aspeed: Introduce a AspeedSoCClass 'boot_from_emmc' handler
>    aspeed: Tune eMMC device properties to reflect HW strapping
>    aspeed: Add boot-from-eMMC HW strapping bit to rainier-bmc machine
>    aspeed: Introduce a 'hw_strap1' machine attribute
>    aspeed: Introduce a 'boot-emmc' machine option

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


