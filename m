Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474ADC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 15:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5S4Y-00020L-PJ; Fri, 10 May 2024 11:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5S4U-0001zx-ME
 for qemu-devel@nongnu.org; Fri, 10 May 2024 11:22:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5S4R-0000WA-Aw
 for qemu-devel@nongnu.org; Fri, 10 May 2024 11:22:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59b097b202so514637966b.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715354521; x=1715959321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hJZX7JTzkHkYEiGhOikmFsatxqAtjRBirBrAoa8hgA=;
 b=Deec8uayfI5TVRUYHynReG58FPXUl1CixCC4gAiZpqoiHg+YYj/0N76pbmV0vql6q2
 sZx34TtuzwXRsy0gg5aYcKdrF/R0nXw5PH6foXdP4Owv6DhkhFfwtV0TIIjuhCMjgnJc
 C1LvEygpmjIfKuZw90P/pOpLhgi8GXxF6F+rHP1veD+H+SH8r6TmiS2mKQN5z+IVE/vV
 +wua69ITHzCnSvRAtthpRsQq3Vz+Vxu5AbhjDnb4A3/mnELPH62fQuC9r/7O7uoimIJr
 dh25229Khdb/Uckm9nsIqDyPr/wc55UYJPM22/fH8JMdQtHnauBB/YurOQr6d8Ok2hlm
 ptlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715354521; x=1715959321;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hJZX7JTzkHkYEiGhOikmFsatxqAtjRBirBrAoa8hgA=;
 b=jSXWNQ3e87ze8FvRLx/tI9W458X+5NB73gUIn3o3BWLAomUHdnJY3stUef9JJL+9Ft
 IRa7Pq/8aAx5a0JX86D65nwv550Z7NweHTPgAN7XT1l3Vv2te5nBSLPa/vuTt0/CLKMc
 hcU4ZpFEf0EN9U9mYkw76fEvmiA3q/OTA5VO9pPkT3+hquicBQQIlrZVcBsqLgMnFZ3k
 8Y4ZFUhxsLx4kfAcYiz6S9vD+6HOzxDsOVdUjTzLxcKiprNrfJ0bGuNnApZEI2GgVHlf
 +nWsRBlaZ3x8W7c0lONVRYaFEFM+n8SI5RmbcmmHKrNNzDD75corD2X6zeqSeX7jf2yo
 b3Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY8iHXe7YCPffa7NafzbcnNahpWQVH71tiT6ShDddYfnSf/RLvlw8nMXAyPaJ7BxD+lWC8Gdi0Bfw3kyd3fFDBjJj/Jdc=
X-Gm-Message-State: AOJu0YyOcWdh8G4t6w5v/FwtDF9blIdrqOUzrjForcOeW+t4v1AweWgW
 lawdzNfUz8LnaV0X2EFYb5sqFNp3M4QmmJRKSYvLRaUOVI3Mg0fpc9qaWfKLvIgeWeykUPMt5SO
 P
X-Google-Smtp-Source: AGHT+IEmaNv8bSJ3UlTY2pDgCowoq8KYKpqhbthFtiT/LOslxagHVaPcjgaHniosuR1p/q5DzLuINQ==
X-Received: by 2002:a17:907:36f:b0:a59:ba18:2fb9 with SMTP id
 a640c23a62f3a-a5a2d534e9cmr187455466b.12.1715354521162; 
 Fri, 10 May 2024 08:22:01 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b1770esm194069866b.193.2024.05.10.08.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 08:22:00 -0700 (PDT)
Message-ID: <1eab285d-5303-48b1-aa75-1c822652385d@linaro.org>
Date: Fri, 10 May 2024 17:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/41] target/sparc: Use gvec for VIS1 parallel add/sub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


