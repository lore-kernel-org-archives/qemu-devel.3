Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6FCC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUij9-0008NK-TO; Fri, 19 Jul 2024 04:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUij6-0008Mm-Ra
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:12:29 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUij4-0004Mu-DW
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:12:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ed741fe46so1703088e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721376742; x=1721981542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BSLFnCwbjWzpwgQAvr2WojVQdnMn+/mKrGrpDZBL9Vk=;
 b=LkXyFlW6/gBF43/OBeFEwoUKz47Bj0XIo3gNTdvVUjl+ZJdQ9Ek96EgGvw8dYbRk7p
 TCIaRkt9NuAZUC3Ew3VmrxoagJfgcvXMBbf8OGErTeqivY1lPm4ehIIilEDCLySThFY0
 f17Hd/XievfwXfYAyYqTWPKS+6ZxZizDCUCGDjYIArjfpmu5aPeyVwzacMz27OW/IJVI
 AiPPsLX06tw/SZ4qjO2BnfFvdEZ7H9aiEOe+YAvxXsFhX0dhCMv6qo3tD4VD5C6xqvW8
 3qOQ6tXOmckq5xNY8G5xjVakoteEBgD28UA1LKqNi9zcvVs7jKXCD9mfAr/JLIoy+mhK
 15YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721376742; x=1721981542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BSLFnCwbjWzpwgQAvr2WojVQdnMn+/mKrGrpDZBL9Vk=;
 b=VzFDukLEbfhV/cL73BGOyqEdXuRNuYrBF9J87NLEUkgu3gNo0TYxWd4VWe9uSgf9op
 dIJxZ53C21hQvSua8NAbJwjdbvzAbRWI2giV5TBX9v/QWn5HNHRhrkMGfmjOuV/nZxH6
 fg7HfCMgHEnlweEwu8fTS17x/Tx2WAOgvwPOUsVo3Nab+iid7+mdEkH+z/Ah43TirumW
 bYt4oetT/gA/xMq0gvQHVLmwvxJpWHlL7n6paGm9999zn1mRNJVxTYs0FQI3+Mi10O6A
 9lJzzAc+ifIVbNT2+CX8F7flXIoir0bml1a8TVAwWPU5g/XksIiKqvAafXBpZLNQDGwW
 A2wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc9ZV/5RsLw4Y6or7iKI6fhvRnPBGPpuBYNUWwG22UmYGjRxB5Z+Z52Y5H8ENvDfJ9N9F56uOPlhVoJfN31oEHcdNaJsQ=
X-Gm-Message-State: AOJu0YxmWTFxuLOuK47sR2aMO7AE15DrWU3aNC724gEfnUNXutMxc5tw
 Z5qnNadh4qf6NvDR2XYnFuXzJjiKdoM7dd7zk7PDF90PV7bB2Jh4C1geGuDHPc0=
X-Google-Smtp-Source: AGHT+IGgFFhPGi6vQypm+tWSEVcPfDsdN0LwErB1m+8nl9F2AxbJ+OtOw5q7zDKJRDsabK5TCakBBQ==
X-Received: by 2002:a05:6512:3190:b0:52d:b118:5063 with SMTP id
 2adb3069b0e04-52ee542720bmr5227943e87.47.1721376742325; 
 Fri, 19 Jul 2024 01:12:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a85501sm22378055e9.1.2024.07.19.01.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 01:12:21 -0700 (PDT)
Message-ID: <a143257f-62c0-4c3a-9031-5f3e510f430d@linaro.org>
Date: Fri, 19 Jul 2024 10:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] hw/loongarch: Modify flash block size to 256K
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: richard.henderson@linaro.org, Xianglai Li <lixianglai@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240719022604.781608-1-gaosong@loongson.cn>
 <20240719022604.781608-4-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719022604.781608-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 19/7/24 04:26, Song Gao wrote:
> From: Xianglai Li <lixianglai@loongson.cn>
> 
> loongarch added a common library for edk2 to
> parse flash base addresses through fdt.
> For compatibility with other architectures,
> the flash block size in qemu is now changed to 256k.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240624033319.999631-1-lixianglai@loongson.cn>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   include/hw/loongarch/virt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 8fdfacf268..603c1cebdb 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -20,7 +20,7 @@
>   #define VIRT_FWCFG_BASE         0x1e020000UL
>   #define VIRT_BIOS_BASE          0x1c000000UL
>   #define VIRT_BIOS_SIZE          (16 * MiB)
> -#define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
> +#define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)

Again, I believe this breaks machine migration. See the recent
example Daniel explained to me:
https://lore.kernel.org/qemu-devel/Zn6EQ39Q57KtmKPU@redhat.com/

