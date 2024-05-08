Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76498C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4jKa-0002vt-A0; Wed, 08 May 2024 11:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4jKY-0002tN-MC
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:35:42 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4jKT-0000vY-V2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:35:42 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59a9d66a51so1047165266b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715182536; x=1715787336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eW6kSTLOre21DEqB615sttBeEAYXhHxTWwDwZie1p6c=;
 b=vpx/Aq10NdMuMCJ9ApHQEGvLN0ZNaZ/gyW0no9I0Gg/sxCbniAMgsrMrwEybHVBm6U
 iEbk32klxtkb/I88bAir6aw+rcf/Nyqoj+1Z9p3+yPb7g7JSiG+YsDHfrtqwZj2jSEy6
 2DFmGbkn0G7LYKFFUmWHkQHxatWA+teyTtTjo6D8eS3y2y7g9h2F25d854g6b/9VK61m
 YKzVEwSLb47WqVBnRfKLttOMTlUhZ52KXxPe6yFvpK1PbSZQOKiZb4nh2xcUElXLQJRq
 X39sF5EmYPMZHYll6RLoOezjE0dwfXPz0PUNi5isU655bm84PlmCPPSqeiWPDILAKGCq
 4xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715182536; x=1715787336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eW6kSTLOre21DEqB615sttBeEAYXhHxTWwDwZie1p6c=;
 b=fEmPuN9zo5isszy7H+68ILVugdxl4IPYMl0Er5vH4Pg7e3oZuzekNfle0AmcjtBBBk
 m0lCdRcyJxtfiHj7MhY5A6bGmjYsyS8ecnnkiSoyF3MVDPGM0qJecnDlqTQJ6NGVQ42L
 tKSDM+C1z8X4pF4Ke9x2SMcbQ7YmUwq3b7VEIDMaqxOc+AMtjXfDeTk2+yVVknIe/ezH
 A1GnZJnQspK2BSAQQ8qVRkCl9tJpNbunOGZuW98S65V7Pi9oKKPYpRt+hsojDs8ShGPj
 w+08w4uJztWAomJ6fKWaAm0OFQsKwH8/+7yt/j+ymzToBHZZ8fqFk8Xsw3IfR/2Rr8PS
 s9iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqqB4w0Px/yPu26Iw7MUyUEAQ/jsLXBilc4lU52xj5frwbui7Vr9f7mEQCISpU1lNmc8PjPsxCnLKeymJ0m47JKVLO9D8=
X-Gm-Message-State: AOJu0YziiCSavvAqfoziWZrtXWrOJKrNYtJ3d5nK7XYoSwKOgOTmaanI
 wGv6lzlHLdACIAhi5KtOx6iMMYgOA4EsmWb0M8PeorEJh5J+pRygnPx7hMmv8Os=
X-Google-Smtp-Source: AGHT+IEAPNjbqyPgTfTzUMS84dVaIea6fwnQSg6HB+Py4LknQ2xnH0ItkjcheAR5FJVjMjDv82VdOg==
X-Received: by 2002:a17:906:6017:b0:a59:9c4d:da3c with SMTP id
 a640c23a62f3a-a59fb95d828mr167213366b.40.1715182535977; 
 Wed, 08 May 2024 08:35:35 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 cm31-20020a170906f59f00b00a5a0f358528sm144272ejd.189.2024.05.08.08.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 08:35:35 -0700 (PDT)
Message-ID: <30ac6d1d-6bda-473b-b212-25443efcde03@linaro.org>
Date: Wed, 8 May 2024 17:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/loongson3_virt: Emulate suspend function
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>
References: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 8/5/24 11:31, Jiaxun Yang wrote:
> Suspend function is emulated as what hardware actually do.
> Doorbell register fields are updates to include suspend value,
> suspend vector is encoded in firmware blob and fw_cfg is updated
> to include S3 bits as what x86 did.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/mips/loongson3_bootp.c |  1 +
>   hw/mips/loongson3_virt.c  | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)

Thanks, patch queued.

