Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6358D149E7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4PvV-0008E4-UK; Fri, 25 Oct 2024 15:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4PvU-0008Dt-SX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:24:48 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4PvT-0004GA-7N
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:24:48 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7db90a28cf6so2263987a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729884285; x=1730489085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y5LVtIeT5NcYZHzsC3p86uvBJjN2DUE9T4e1FCYL0vk=;
 b=RMm6/oqR0hkeNP0AQNpdpWhIEuz8nc6wtvHrRaey24kjA2uK6vOTQ3wyhoG9DjZs9i
 UbEnKAPEf4iImmZ3dISwwrgebwflpvMOGPc41fwg18P2Ix2bnf/wzQR2FhNY/TyUU8IQ
 OBe2NUZkpHtUVxXVzq/2lKWFnemvLQl384wjQjzovHTk56leRgPq99SxYyd81NyGUiAO
 gcvmgYYUy1vFoKSMIr5yDiwCRKvtGkbNUaXgKHKmGN+kasWgCwZiB1fBauaxFU5xey24
 EWMbksi9k0JvZSvPGJ67R5Do5daFiCP/sXdA+9+LeYoQrP9hpd6h8EECdLH29uTBZkjo
 vC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729884285; x=1730489085;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5LVtIeT5NcYZHzsC3p86uvBJjN2DUE9T4e1FCYL0vk=;
 b=M7JE2gTtitmYas//MgEZRA4rtkvS949rsoEuMXU57zI0mJtx5kppj9aE7Ah10aDgB7
 nm2TEs7sl2KiKqCfJUFRwMaGwURlpOJnRjYONbfZsvCbrUmEFtwDJyg14sbvkeluXUuf
 d8ZtE+QGsqPlmlKMi1kXXvmNCeJSkTOfaO//XiV5ReXEELxLjHXVlulTdGvMYTmxH7CN
 /BtXDviBba/ZFJ0u2w1MT/1JzRgWmebEfGnrN9jwqatBuqATO+vKW10cmbDgxMwv3vJ0
 PlkeADBRu3i0B6+D/heWnVEV4k8qj8W0c9/Lz6DmDeL9Gv4ga8JXKBoJeQbElucnuCgo
 r7KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ7pC97Sn/HEYmvpSp3LEBcPn6qGBdUzAsdAOVHtI8J5QD9M/KR+/zWdI0oeCDgQ9rfTatcFeN7+e9@nongnu.org
X-Gm-Message-State: AOJu0Yw6F1ZV+3wMBd30kgVtW2/LCdKiOrElZFrE8i+pCQ1cpEPSoLe6
 cx/Ru7I/POkIpiony8AGFT7lduZ/Tm5VzwCSWCY3XfVrEVdF1f4fRSSnSQWceeQ=
X-Google-Smtp-Source: AGHT+IFd2Zaie8VDB5vm4hyrMAPUN8o2KZrJ1x8UiL38B5vU2ejqwwKj/8UiC/1sdr73MiGDTbluDA==
X-Received: by 2002:a05:6a21:394b:b0:1d9:3acf:8bdd with SMTP id
 adf61e73a8af0-1d9a767bdfamr995200637.22.1729884285461; 
 Fri, 25 Oct 2024 12:24:45 -0700 (PDT)
Received: from [192.168.2.252] ([201.190.186.93])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057a0b8e2sm1428279b3a.102.2024.10.25.12.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:24:44 -0700 (PDT)
Message-ID: <50dd60b2-f789-4828-9a7e-3becc6721964@linaro.org>
Date: Fri, 25 Oct 2024 16:24:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] target/mips: Enable MSA ASE for mips64R2-generic
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <AM9PR09MB485141F5613A7EBFC5A4A08884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB485141F5613A7EBFC5A4A08884402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x532.google.com
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

On 18/10/24 10:21, Aleksandar Rakic wrote:
> Enable MSA ASE for mips64R2-generic CPU.
> 
> Cherry-picked 60f6ae8d3d685ba1ea5d301222fb72b67f39264f
> from  https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   target/mips/cpu-defs.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index 19e2abac82..2b707cc5a7 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -678,7 +678,9 @@ const mips_def_t mips_defs[] =
>                          (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
>                          (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
>           .CP0_Config2 = MIPS_CONFIG2,
> -        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
> +        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA) |
> +                       (1 << CP0C3_VInt) | (1 << CP0C3_MSAP),
> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn),
>           .CP0_LLAddr_rw_bitmask = 0,
>           .CP0_LLAddr_shift = 0,
>           .SYNCI_Step = 32,

We already have the I6400/I6500 which are R6 with MSA.

Why would we need a non-R6 core with MSA?

