Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4CAC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXXG-0007KY-6B; Mon, 27 May 2024 06:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXXD-0007Hi-EO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:24:55 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXX0-00055w-VR
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:24:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5238b5c080cso12910833e87.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716805480; x=1717410280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9MKMenTCE2J2BnrIZin+JMaHJt8YZSj8qiit9MGsw0=;
 b=M3vMHKJ7WfNIf2r0DBs4LazqjVKhTHXXQ9+49sKH6iENPNNzt9bqFW9CPm01wRDVqx
 uMW/CIIWYzyHwjF1FS2p3suZM/vi0TOaZ9omlr2mGQwfBG13ffjAAPqGYE9j4D49501W
 CWxmptG3vAo8ZIBFFjcG5ESORxKLN03/5VilQ7xVr0CGu9EDSFBdOx5sPo63zfCRX6pl
 MHhutKBFPjKvfgMP0XRipLNpONQr0BDe9vAypdsF3glRZuVtAPlFpqhpnNOrJhAdcB1w
 EU/tI8o2CCZNMGhTxF3Q5QMZQQq7qKKUEHDvzPxd6GkTM1Q5tvR5gKZpKijh9n81etXv
 6xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716805480; x=1717410280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9MKMenTCE2J2BnrIZin+JMaHJt8YZSj8qiit9MGsw0=;
 b=a24OcDhANJxGJf39rQ+YFGOUDt+IZotDw2A0KAE9srJwExVV1j2GnIblOoSdW0T5Wc
 HMZ0WexUHh0Efv6DBcgo4oIPzL4wQZbY/ugLwOBW8sFsmnlyZOZp1rTh2d3nlQeZccE7
 DlNV+7sr+QFjTCmQG5webna7+0vA/1X4ieh9/3nwPVh6VrO00ffrLSnlGNlPDcK1xheK
 YbS+CTgqc/j7bk7SHB9DHpJSKpL6Xeknl1pUyhBevdBZo8bHSBuHB6R0AWRAWOM5iscp
 C2cpOCdpLCo4busqyhBvQqOiymqqfcVUEP006RaXMuYvW5CYXY1QqtUPIj3xHRE+lKs7
 DoUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdrlnhHb7lyr12AMgtPi87+JBnL60QhsUid7UZvyMJZn6qyZG7iynI3QgF2M5+ET0tRVYkYIs+53KhQhfPjEK+wz71c7o=
X-Gm-Message-State: AOJu0YwSZBoCrxznu4g3UBGjnVRlhfy6+azo9E3w7L9kmpd9FfOyzJ8e
 163HH0phTpd6RBKgdc3HwnygUAPFkzJLcHX8rzqqvfuaTkQbDUSi7oSLmkG9Czo=
X-Google-Smtp-Source: AGHT+IF0QtMPrlKs08+TF+/6vIPc8T/gIwR6i3wjXjGfOPfyYhU6zrATwid+ECv4wpb/NJOrBOWdXQ==
X-Received: by 2002:ac2:495c:0:b0:51b:afe0:3f4c with SMTP id
 2adb3069b0e04-529666d832bmr5543647e87.48.1716805480230; 
 Mon, 27 May 2024 03:24:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5296ee4a9b9sm503475e87.85.2024.05.27.03.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:24:39 -0700 (PDT)
Message-ID: <9476cfcc-5a7c-4b76-a684-1361463bd161@linaro.org>
Date: Mon, 27 May 2024 12:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-6-jamin_lin@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527080231.1576609-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/5/24 10:02, Jamin Lin wrote:
> The SDRAM memory controller(DRAMC) controls the access to external
> DDR4 and DDR5 SDRAM and power up to DDR4 and DDR5 PHY.
> 
> The DRAM memory controller of AST2700 is not backward compatible
> to previous chips such AST2600, AST2500 and AST2400.
> 
> Max memory is now 8GiB on the AST2700. Introduce new
> aspeed_2700_sdmc and class with read/write operation and
> reset handlers.
> 
> Define DRAMC necessary protected registers and
> unprotected registers for AST2700 and increase
> the register set to 0x1000.
> 
> Add unlocked property to change controller protected status.
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/misc/aspeed_sdmc.c         | 190 +++++++++++++++++++++++++++++++++-
>   include/hw/misc/aspeed_sdmc.h |   5 +-
>   2 files changed, 193 insertions(+), 2 deletions(-)


> diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
> index ec2d59a14f..61c979583a 100644
> --- a/include/hw/misc/aspeed_sdmc.h
> +++ b/include/hw/misc/aspeed_sdmc.h
> @@ -17,6 +17,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, AspeedSDMCClass, ASPEED_SDMC)
>   #define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
>   #define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
>   #define TYPE_ASPEED_2600_SDMC TYPE_ASPEED_SDMC "-ast2600"
> +#define TYPE_ASPEED_2700_SDMC TYPE_ASPEED_SDMC "-ast2700"
>   
>   /*
>    * SDMC has 174 documented registers. In addition the u-boot device tree
> @@ -29,7 +30,7 @@ OBJECT_DECLARE_TYPE(AspeedSDMCState, AspeedSDMCClass, ASPEED_SDMC)
>    * time, and the other is in the DDR-PHY IP which is used during DDR-PHY
>    * training.
>    */
> -#define ASPEED_SDMC_NR_REGS (0x500 >> 2)
> +#define ASPEED_SDMC_NR_REGS (0x1000 >> 2)

This change breaks the migration stream.

>   struct AspeedSDMCState {
>       /*< private >*/
> @@ -41,6 +42,7 @@ struct AspeedSDMCState {
>       uint32_t regs[ASPEED_SDMC_NR_REGS];
>       uint64_t ram_size;
>       uint64_t max_ram_size;
> +    bool unlocked;
>   };


