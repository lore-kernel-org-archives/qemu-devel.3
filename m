Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41B2C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVfw-0001YI-6C; Fri, 08 Mar 2024 03:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVfv-0001Y2-08
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:33:55 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riVfs-0003AL-Tx
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:33:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33e162b1b71so1660436f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709886831; x=1710491631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLCE2h5YUGnTBXoVesyPEufQxdQajze+z3q0vIza6cI=;
 b=kzkfflScO2NU4bDVvfk9TsvE1kb0RIoPvUcYuEGHCZ2sg+tqJZ3UABuIed2fycXyMB
 6nWycuDdzuyaqEqHhLRUKIHENLraVqUHANQUKFSEtpknENIOqo2rFJbO50Q3HA0Wza78
 jz1kEKpeOW7C4pjKtZFLazaam1GONrHl9ID5UMex+4joMyLR600KmpHgPAnno4uAcqih
 Bkjk2+qZxXM+BESfyw+LNSbm2DXL0uFFhqKQKUHYWvYBdY+7AXQ4Z0lRLSybY4rLyV3h
 zNchc+8XHKBDLzbb3/o6ytYebWrogs+htCY8Qa/0V5Q1TVUegTKMQon4InbqlHrOOFNu
 QDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709886831; x=1710491631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLCE2h5YUGnTBXoVesyPEufQxdQajze+z3q0vIza6cI=;
 b=HeJIrFyjLKC/ye37PgxmZLVR0cAOlvlzyGggZgeGfrK67ylx+pPGJdcmUbUmbN/9iD
 s12pK9oLEoYUplNzMxKJt9496ZVfdSKtWSkIxZEqfCCwkC46u88rSTOMLEGKro0tZvK+
 rOPY/LvHSzbsABIVcrtEbE3Ul/bEb3aqirda5x2c9CB8FvN+V8zqOBWnRUEqlZhPO52U
 cIH6Rg8tf6jglETKFe4Mx0Z3+HIum2bxho0vh8LU0WYVzDNp6frSNLA9PDVr/q5DjDre
 yfn427mQN7uFJL8qIRxRdc4XnPSUTA/c9xM9OyXKYzoSCFOo7bHX+k/avP15M2JS2K7C
 dzIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRhoAkjsiRxMwQlFGOXYEkq7ovD9PR72Rp2K0+wrQ/gh8RFajLVT6FFhkKFlxgim/dbYoiTsV8lpNsnhYLYgzW7SlZsks=
X-Gm-Message-State: AOJu0YxHJ9WxSHV6na7P0A1WiNdWQC5KM4IiPGh8E4ltE6kSbsAd3lcU
 90hQ3OP51zqaQq8u55Ek5phEfgxLVfrOuPdNbDmqtol7Rvb0rCaNrj+H0qtIQl4=
X-Google-Smtp-Source: AGHT+IHhXo62RoBrfXTZfOMIMAuT4iGHvfdly82LLuGYmyFQyzMhdOmMuucdTZbhYu4V7b4wkfeA7Q==
X-Received: by 2002:a05:6000:400d:b0:33e:6d6c:8503 with SMTP id
 cp13-20020a056000400d00b0033e6d6c8503mr2778427wrb.16.1709886831334; 
 Fri, 08 Mar 2024 00:33:51 -0800 (PST)
Received: from [192.168.69.100] (pir44-h02-176-184-37-132.dsl.sta.abo.bbox.fr.
 [176.184.37.132]) by smtp.gmail.com with ESMTPSA id
 bv28-20020a0560001f1c00b0033d70dd0e04sm22659229wrb.8.2024.03.08.00.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 00:33:50 -0800 (PST)
Message-ID: <4dbf337e-1427-4f2a-ac3a-6a80b914d927@linaro.org>
Date: Fri, 8 Mar 2024 09:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/17] hw/loongarch: Init efi_system_table
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maobibo@loongson.cn
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-6-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307164835.300412-6-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 7/3/24 17:48, Song Gao wrote:
> Add init_systab and set boot_info->a2
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-6-gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 22 +++++++++++++++++
>   include/hw/loongarch/boot.h | 48 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+)


> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
> index 3275c1e295..65ad406f02 100644
> --- a/include/hw/loongarch/boot.h
> +++ b/include/hw/loongarch/boot.h
> @@ -8,6 +8,54 @@
>   #ifndef HW_LOONGARCH_BOOT_H
>   #define HW_LOONGARCH_BOOT_H
>   
> +/* UEFI 2.10 */
> +#define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
> +#define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))
> +#define EFI_SPECIFICATION_VERSION        EFI_SYSTEM_TABLE_REVISION
> +#define EFI_SYSTEM_TABLE_REVISION        EFI_2_100_SYSTEM_TABLE_REVISION
> +
> +#define FW_VERSION 0x1
> +#define FW_PATCHLEVEL 0x0
> +
> +typedef struct {
> +    uint8_t b[16];
> +} efi_guid_t __attribute__((aligned(8)));

QEMU_ALIGNED(8)


