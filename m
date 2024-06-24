Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B85C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLedv-0005Gm-Q5; Mon, 24 Jun 2024 04:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLeds-0005GI-E6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:01:38 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLedq-0006tx-1v
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 04:01:35 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52cd8897c73so2680800e87.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719216091; x=1719820891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B4su9eTFVO62ofnSOXmYeAcO74zsCbTRZI+iUeszDhA=;
 b=KFOTPNYOGWYsssaixq8iz6OFyeltPXarkkaD+737bqVNDnfw8vZaR9dl5rr4AKdHiE
 7dx8H8SS9V456wg2ztW/FftAxjqB9Qh8zztTdxRGyVbxg7cV4e1GySr8zf9NgnsN6Ggq
 jtC0O7ZLuNXA5SaMLhOXY4y+upqtOn22F3k1LNplU9hbPr5YRNsV/1NE0FweVLG4LKYU
 AHZ1G1BP8pGFe8N1b4IZWua1EBse2tDMQgrxKoTrRzp9Nc8yjUS3s48es1ifRb7tmJkZ
 YTyw05zxOyAkOgKEZUfETDTNDiZ8bwGMZzMetso5hIsOWeMzF+OR1OENx2DCHeRsLdxj
 MJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719216091; x=1719820891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B4su9eTFVO62ofnSOXmYeAcO74zsCbTRZI+iUeszDhA=;
 b=mVowTqOWodVKsHXBPPNkVBBwfIwSHgjJ77TMSDbpRUFiYDRtONOVS59rMyQK26+Tyl
 FV1l+MqWbMEoy1+im1xfLw3WCRH7quG2hxUzIIEhB6CNSVAABs2ScGJwsnMlNGoEopVz
 ZhDSCfVFktN7ky0aa0FyDA2OR+Kpb78qA4d7qQ8pKtMLOdE9MZlCOce+CNtiAGSUeocK
 rvUMaObksQsuqLd582lwu7j8gctQzIIwf2VWSMIiPbmHmM+OTscIEtR3KyXu315A+QW4
 +hA9X2VNZqK3tbfAJ3sw9eVdpaot3M1hdhmDpf1K3Y5MXMyxIaEWHrCscP74HvmMOBpP
 VWHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWJvAbhbRFJUTUEfEvmkHm0BVl0I//+B1bGuwzKRcKREuPFqvYfv/zxsaM/C6GkuPSwMh9nKy9Sh2tnmxpi3D02k5NUtc=
X-Gm-Message-State: AOJu0YycZYY8kzQgmP9xP1wx+xLXOigvk0/WGtwgGWDK/emBySKGFZnp
 Vfco+ZknBcB+il7pa3xl3cfnzDM4vLUDB/L6lH1/+6Kyv58nRh/Brcr5KKX7qqBLxZGu1cpz/Rj
 f
X-Google-Smtp-Source: AGHT+IFOibi/5Uj6BMXQ8+jH06LbtbX756HxIcaJAHYIkP/JS1l6NADm+xm1vYCe8i6CuKqTFUE3aQ==
X-Received: by 2002:ac2:5dc9:0:b0:52c:dec1:4578 with SMTP id
 2adb3069b0e04-52ce1864495mr2070407e87.60.1719216091277; 
 Mon, 24 Jun 2024 01:01:31 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910fc9sm124255215e9.33.2024.06.24.01.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 01:01:30 -0700 (PDT)
Message-ID: <63937d18-e330-442d-ba91-7841171ddc55@linaro.org>
Date: Mon, 24 Jun 2024 10:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/loongarch: Modify flash block size to 256K
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20240624033319.999631-1-lixianglai@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624033319.999631-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

Hi Xianglai,

On 24/6/24 05:33, Xianglai Li wrote:
> loongarch added a common library for edk2 to
> parse flash base addresses through fdt.
> For compatibility with other architectures,
> the flash block size in qemu is now changed to 256k.

Why is that an issue / concern?

> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> 
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
>   #define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
>   #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
>   #define VIRT_FLASH1_BASE        0x1d000000UL


