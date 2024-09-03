Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9827FCD3440
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 21:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slb5s-00061u-Hr; Tue, 03 Sep 2024 17:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb5n-0005x0-KF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:29:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slb5l-0007T3-Lu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 17:29:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bb885f97eso398365e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725398976; x=1726003776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=imVEL4cgskba59vOS+3eNgoUE+lEXkUrmzqjUrZ3Knw=;
 b=EClkIK+clydgUJ34fCxkQp1n40nachRlYtBOyPbyCYhGGWEctQMw4CdYy2YDJYwqNS
 M9vEd4Jp6oyNa21wv9Uz7RtFybc6Gss5Sy8wIo3xj+r9SOw+8FLVtsE940U8lR7llura
 GHFgP1P2y3kyPNhCrH5QlvnSJTrFbUQiITT3TZsUavHgOZGaM+XyxgswB8EUc3g5hV6C
 BL5gilEt9iP+lIjoSwc9EvjaLBP9HLoGKqUQfHd2t+QzDDvpIBXKOzhb4JgAEc9M+Vh2
 /0vc5tlN72F2T4WnbrlJDAxIWuNN6HB8qxHta6SW+ZSsGJjFBIKGA+Z0a7HGPBlutYBi
 N7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725398976; x=1726003776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=imVEL4cgskba59vOS+3eNgoUE+lEXkUrmzqjUrZ3Knw=;
 b=EH0LsEZQITp5hE0Jj3chkyAvBkwdjOYtyj6k8p5px9ddok8lQIr7pJcT2dMKM80p8F
 qZYNrUo2w5pIOl6BwULRB/0hnqM480EkNZSlcGtVH3pDMtFNqjJ1cLfqJ3KPT2GIBj8n
 +tJ3ErP2w5csADuCeSdCm75Jl5X02qOhq/GvfHaIpUNBm+N6np6jQ8b8QflX6AEeQInU
 tPF5LJuAKgpxCAzgHGdpJTFBqDglJD6cNt7BWR7QopoGesBRgjUgbHxdHbSe8oyjUGTn
 DQ8p748Wmu8pyanquygn0lgMMtXTl4l5cdliUTej3l6D/C6kIDFwG218/qVbxmzdSsoA
 gIbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU74PaIjx4hy3/Gn/RLL92UjaBsffBDHFcsGVVpx79qVhIBioxAIo3DedG2vexccMTkGVTmDkw32Tm7@nongnu.org
X-Gm-Message-State: AOJu0Yx8xDORtFsmp+WlociuLax9QiR+r2SU+qNyj1eEIFrOtvnDTgkG
 vAqotxhJ89V2BajV6EPP1yMn4FnaFLjnQWZdcx7J159cdhSOKM2ViBxL8ZRfyxY=
X-Google-Smtp-Source: AGHT+IFEnD9EnXWvzBCFbOC4cxkILdWa65f31JGE1K7A46m2FSlLGTIVmqYi6VD7HXTmhrsy0eblig==
X-Received: by 2002:a5d:4646:0:b0:374:c4c2:5ad5 with SMTP id
 ffacd0b85a97d-374c4c25b2bmr5521905f8f.27.1725398975959; 
 Tue, 03 Sep 2024 14:29:35 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374ba3da654sm11533165f8f.89.2024.09.03.14.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 14:29:35 -0700 (PDT)
Message-ID: <98c53272-9590-45b8-97e4-efda29fe987c@linaro.org>
Date: Tue, 3 Sep 2024 23:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 01/53] hw/arm: Remove deprecated akita, borzoi,
 spitz, terrier, tosa boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/9/24 18:06, Peter Maydell wrote:
> The Sharp XScale-based PDA board models akita, borzoi, spitz,
> terrier, and tosa were all deprecated in 9.0, so our deprecation
> cycle permits removing them for the 9.2 release.
> 
> Remove the source files for the board models themselves, and their
> documentation. There were no tests for these boards.
> 
> We will move the text describing the dropped boards from
> deprecated.rst to removed-features.rst when we've cleaned up all the
> boards it lists.  Device models used only by removed board models
> will be removed in separate commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                             |    3 -
>   docs/system/arm/xscale.rst              |   35 -
>   docs/system/target-arm.rst              |    1 -
>   configs/devices/arm-softmmu/default.mak |    2 -
>   hw/arm/spitz.c                          | 1284 -----------------------
>   hw/arm/tosa.c                           |  327 ------
>   hw/arm/Kconfig                          |   23 -
>   hw/arm/meson.build                      |    2 -
>   8 files changed, 1677 deletions(-)
>   delete mode 100644 docs/system/arm/xscale.rst
>   delete mode 100644 hw/arm/spitz.c
>   delete mode 100644 hw/arm/tosa.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


