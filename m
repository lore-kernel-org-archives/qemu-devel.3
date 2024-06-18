Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AA5C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJh7k-0007G1-Dc; Tue, 18 Jun 2024 18:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJh7b-0007FX-J5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:16:19 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJh7Z-0004lR-UC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:16:11 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so4105006a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718748968; x=1719353768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZ9HnConCLYss3NPb1usGOnfNoqUrrZd0MsIMaNbkys=;
 b=nagnqh4NbQtYORNeIEtIfzA5EDtNvkA0G59MGwOf9jivA9EsKHaV44+PrQLwEnLQxv
 yUiv7c8pWlEVy3E0UHQx6ZXNixxbrXJbzT82910uBUoLl4qkiLVWGFfUm/9whBmwYv34
 ruNvF9gVPRRDLr+zMUPe2Yu2SaOgeC9kBiZ/J/6dxIDuaroMzA5dz19Cs2sQsx+mMOGy
 SWMFKnO1C/AZ8P1qB7zk0HGqAMEn79wVulOtEVIXWTSqoNBd5r43CHiNkkzN6lOo6eRV
 IF4HVoRj57Tt0npac7WCzNtcybOe9iqjSjPlYqRkzasqs5Grn6Qh2mdlDriQGgfWosnZ
 Ygvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718748968; x=1719353768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZ9HnConCLYss3NPb1usGOnfNoqUrrZd0MsIMaNbkys=;
 b=bxZWZ3tRnsql+K5UHhuWnC48WVmf/zRzN4NTLth3yKsLOYyaaeH/ZLRYvvi8SQmCYy
 nGdbn2QLrnw5FYEmVjjagu+9VW4cdTwqehFZjbqizIfWFpBJPGTRyL3pMzct6BgvHR9A
 ZdgmK56V1QrPVU3NoKDsohJXM6ERpbOtFEeNp3xFVr2NFNlIvJNcfQMMrJJ/Pu3tNKvI
 xOHRdISYsDmfYjREQq2W9K65+Lp5mWZ+PZDclO7PcAK3ZTkhF/oH5qyTbCX1BN0LQ1jG
 QyQKjAM+VZ5EuFtb/JLQyyfQ6GPRj4S+DLV1X5cZXxNCQJmTUvhKBng+gbvAMCHQDyVU
 tipQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZOYNOWZ0gcI5Us16gpVHGtQ+wb/jEzVZ7RlPRCZjCxRSWXbSQrDe6uEWGkXutwXn7OxCfvBngVRLJ45OXapob8v+znKc=
X-Gm-Message-State: AOJu0Yz9xj+h4jyWp6xRWiqXCzP6nfDxiUC6CJzdQb8fuXWwIC3BPUko
 dluoZLNHAypZGpO2sFYyqqqB7IPWNy8NQy2JEa2UHnzj5SBcPK+ynZoKE91wcPWS0LuOeKTZwz+
 p
X-Google-Smtp-Source: AGHT+IFkYKPT/dCDOM3nVfPAziD8XUU1aNGtm9bMx+JZMBR0WeILoWsE/ETw9Xg4cNSpIxu26IbAHg==
X-Received: by 2002:a17:903:1ce:b0:1f6:8be6:428d with SMTP id
 d9443c01a7336-1f9aa471097mr10343715ad.56.1718748967658; 
 Tue, 18 Jun 2024 15:16:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e6e172sm102731175ad.67.2024.06.18.15.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:16:07 -0700 (PDT)
Message-ID: <fbd46496-4bfb-4724-89da-1edf055619c6@linaro.org>
Date: Tue, 18 Jun 2024 15:16:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] Update ARM AArch64 VM parameter definitions for
 bsd-user
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Sean Bruno <sbruno@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-12-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-12-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Defined address spaces for FreeBSD/arm64 and added function for
> getting stack pointer from CPU and setting a return value.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Sean Bruno <sbruno@freebsd.org>
> Co-authored-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/aarch64/target_arch_vmparam.h | 68 ++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_vmparam.h

Acked-by: Richard Henderson <richard.henderson@linaro.org>

> +                /* KERNBASE - 512 MB */
> +#define TARGET_VM_MAXUSER_ADDRESS   (0x00007fffff000000ULL - (512 * MiB))
> +#define TARGET_USRSTACK             TARGET_VM_MAXUSER_ADDRESS

I will note that this may conflict with -R reserved_size,
and is an existing issue with the x86_64 port as well.


r~


