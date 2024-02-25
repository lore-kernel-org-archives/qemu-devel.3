Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840CDC54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 16:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reHVY-00036O-6j; Sun, 25 Feb 2024 11:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHVV-00035h-W1
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:37:42 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHVT-0003D0-GT
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:37:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33d7b8f563eso1988988f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708879057; x=1709483857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HH9ZVJjU3ny/yCgfzCsl80z+BCOkPFPDedDjPZ3RTXI=;
 b=BFT+vMvWOvwEBr7yZp8jLfdnYUt05o8dQyv7gXAk/6/rxB4DOXAvJbTBCrGN/CUC8g
 1g7YvKfGLgwGr9oZoKG0vk+MeVnxkz9DBk2xfWRaSyAL7fX2fDeN/VKBeXCIL7iMll81
 /DW7gkbuEgo7/2PNMM00FkqKnk3X3qXoIueT6i9D5OklJp75Ghct5DIdAfCKEjOUzGlP
 1uREB82WAEf+t6VkJgmhUIZE0xbFNzSHfldkOa+vor4P34ki8XDQ2XGgXgYkCc/bfXyN
 tPzSW2CynzFRHANbxWNgSzMSxLIVaCGraJuN97S0jZhJwofULqehjWgc/ws9ZHQZg79t
 r1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708879057; x=1709483857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HH9ZVJjU3ny/yCgfzCsl80z+BCOkPFPDedDjPZ3RTXI=;
 b=naeHwivcsc26oUDQFIgKfmypTlkkBZrUvRjuYzGbUwmDBls4KIPgQWC4Ua3jpVIYDT
 /4pLd3yGDe3vEuprLFOLLEQrqYRS3VjR1PzP0AZGF8bPnkRMsPjZKH6Uw9B32zRycgn1
 1fZqBn94Lt3EBQxBMv6dLD5x7gndmpJI1x8b+WhdK2xZwNsxljtDZ/jxRR+Rt7yubCL3
 JFYahKvbz1yvIx2J1pL+MDlpXx/MAZtwqHPFG3aRfijDG11vDk+tZ7vOERUlcSZ95p8Y
 zm7kLdedYkFvB+IaWTl44A8nGlIBKkppkRgF+zh8XWEiDS/UH1VwCzdieuRRL/8TUlo+
 qzaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4cVKqWjqQNTHuZ+4m9LkNBALlffH00r5p/FHgmycC1sgBvQIeI9NlKwl/3bkwXpiWs5hn6GBGEJUx3gjYFqBKCPZcopE=
X-Gm-Message-State: AOJu0YwzWrzir5f+7dIqOa/1BddpjDqh8wwRLm5h5GfaL4BOOKDonSjd
 0Pzye4++hllSRj1eON2oDxW8eyQSGz9nfB+Ceea12eo0r8OzW1XA6vVPI7CLOvA=
X-Google-Smtp-Source: AGHT+IFn3l6IwLvtB1HQkTZ5j1gheKUOOR7Q731E7UUHftKh8PxdeMiS9n3qh5TU/bWf8yj4Eu96eQ==
X-Received: by 2002:adf:e6cf:0:b0:33d:67f5:a3a4 with SMTP id
 y15-20020adfe6cf000000b0033d67f5a3a4mr3739569wrm.67.1708879057367; 
 Sun, 25 Feb 2024 08:37:37 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 v15-20020adfedcf000000b0033ce727e728sm5438196wro.94.2024.02.25.08.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 08:37:36 -0800 (PST)
Message-ID: <1154e495-b1cc-4de0-a107-51fb3627e6d5@linaro.org>
Date: Sun, 25 Feb 2024 17:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1
 and I2C2
Content-Language: en-US
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20240224191038.2409945-1-rayhan.faizel@gmail.com>
 <20240224191038.2409945-3-rayhan.faizel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224191038.2409945-3-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 24/2/24 20:10, Rayhan Faizel wrote:
> BCM2835 has three I2C controllers. All of them share the same interrupt line.
> 
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   hw/arm/Kconfig                       |  1 +
>   hw/arm/bcm2835_peripherals.c         | 45 ++++++++++++++++++++++++++--
>   include/hw/arm/bcm2835_peripherals.h |  4 ++-
>   3 files changed, 46 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


