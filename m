Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D994C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pRy-0002pG-Kp; Tue, 30 Apr 2024 11:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pRt-0002hN-CY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:31:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pRl-0005IY-Ml
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:31:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so53851265e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714491068; x=1715095868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bdtm7jw5pqIT0WEXkL/hHZZc043bd2TJw+8tXSem2Jg=;
 b=kI1i7LQQZdA6Iu50WjUkCC1eMFhQZqmSKszaJ/MvvQKIzJMFLctD+YTOkkZWedYtuJ
 NbO4pwt+h1zUdNfb67Rq70XTPZSGrZnQlnJ/8aVKxF3ihIaqZfdd4v3ofi5L2vpjWjv2
 cu5cjfERxFJ78BQ2RmaiKeNO87tkuEzmu9+2sqqnPTWEn+wB5bAdgPxwIxlfHWrbhnrz
 VJ72j7xCnHn6UypIyo0RVDHE6twJQLu195wkOSuXfFQRtFv2+bPcztamzJGpSkI0IB5i
 pNSBbI9s/Qb8pEov9q7OJ8GVphVayjGfDik+qWaPg6ywhmea4Ly/FUhe856fYgjnTVpP
 jONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714491068; x=1715095868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bdtm7jw5pqIT0WEXkL/hHZZc043bd2TJw+8tXSem2Jg=;
 b=LnWnlBKAq8DJz5uR7RNGUgEUTPj1a+xPbia7SFu1tPyOFPF7Lz8IJcJ3M9WZY92Hy+
 RTorWj7aCknfuEwMOY3ccbHlAzEjIsBH7A5uSDtTGRGXarqw6bA1Ds3e/aRDikklosX1
 OOymA2ab+FIOfwgBx6PTVFq85mgYtpeLvwE4vJYLhnFWkwSBynryCKXsOxwtWljIeJoI
 b8ZXvEIJezSE8rTh7cDEHfmkF2UtwVZcCV9Vjb+f9NGcpMzHO2KJ3W5A0eyPqZf7uQ8V
 Z1RCXwaYBbiv/0XNCFlQ6rta2+eeaj5MKzR+4/GogUT9eUNr2rHcjQajYXYePkVKtCBV
 vrfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjt/gUWKCWSAGCSIikKAkagzUFifud6o+iNW46botZc+5WctFwNqxsHGdGUIlsf3/gqEpy4ji88DlxJGs3jHGlyrY3zwM=
X-Gm-Message-State: AOJu0YwaIYDWTx+4XpfkHokXl4BIXlZXv5qHahLZbFJG8tKirWg70YRA
 BhdTQNJSRqpnoeXFqvdB3MvhjC1Q8Jov4OAYWm/AHAbCTgkXZk7UtxugREIjpiw=
X-Google-Smtp-Source: AGHT+IGvN2Tk/VhlBNs3JhqpN1QOhyAnYUFxUpn1Oa+nDCsiuck1YeBjM5DfCsQBNvvLmCg7mxS9bA==
X-Received: by 2002:a5d:5960:0:b0:34a:9adc:c364 with SMTP id
 e32-20020a5d5960000000b0034a9adcc364mr49220wri.8.1714491067961; 
 Tue, 30 Apr 2024 08:31:07 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 d15-20020adffbcf000000b0034b1bd76d30sm22537266wrs.28.2024.04.30.08.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:31:07 -0700 (PDT)
Message-ID: <bf952a4c-282d-4d4f-883e-8d97258e12c9@linaro.org>
Date: Tue, 30 Apr 2024 17:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/i386/x86: Don't leak "pc.bios" memory region
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-5-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430150643.111976-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/4/24 17:06, Bernhard Beschow wrote:
> Fix the leaking in x86_bios_rom_init() by adding a "bios" attribute to
> X86MachineState. Note that it is only used in the -bios case.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/x86.h |  1 +
>   hw/i386/x86.c         | 13 ++++++-------
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 271ad50470..fb41263b9d 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -52,6 +52,7 @@ struct X86MachineState {
>       DeviceState *ioapic2;
>       GMappedFile *initrd_mapped_file;
>       HotplugHandler *acpi_dev;
> +    MemoryRegion bios;
>       MemoryRegion isa_bios;

Do you mind describing what is each in a small comment?

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


