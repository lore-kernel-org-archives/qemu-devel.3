Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2382DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGET-0004YG-Lt; Tue, 23 Apr 2024 09:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGEI-0004Td-VZ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:30:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGEH-0004Dc-4Y
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:30:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41a5b68ed5cso22538825e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879035; x=1714483835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MyrBmzoB5o9GAMw9DUFGN7uKVpV5B1OP9FPrtg1cKDQ=;
 b=abGvhHA1t7JY+e3F+ABm/9KTAV2frRDRW8rhOHbAtmtsOjfsAseYlBKDj5Ds9aRz8h
 0a44+UIrn7/ja0OQg6P5GMctBFpNj944/xT8ZMO7SWA226rc/sg5QrgpXdDtyegW7tRf
 AO+TT9GB/F1R44WF+FGrIZh+h6uwJy8Ohy+fN7GdfytgnBJmzeB7venSJcEVRkzWag/l
 bhbq8xIw3XuMnh5oOka0V2sBuwWjb52RYMieeWEZBjIYvXEVGZtoDH08AlqRuE/LY9kL
 5nKz0GBnA7AszaRfLbNkGLYXUVOO65BVwEOe+HR/A0Vt+Ap3Yvh3BcYhjblC/O7BBa5i
 ARkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879035; x=1714483835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyrBmzoB5o9GAMw9DUFGN7uKVpV5B1OP9FPrtg1cKDQ=;
 b=L5rWD3GvWr7Mq59oRbiOZUb0w5efyJ5lV4XvEka7J7M4vtXUaNy7opvD4VLbmrLHmK
 SlYidfnXJm6wKJ+yUYJZIMubew7zdgSBtAIuoAX8JbTT0eCe2T0AZ9hAua2Jtu2u79EU
 NwCTSPYnucIxJ2pqrJvwfCJMkwX3smCBtL0BcY4TTBqSwhK8AQHOOV1xSmbLwHMx7fJb
 28gF1K4X1T8MXq+Sq8/8gmkQv3bhboOa14a3h/jC9T3bbnJStu+7snXJ+SR5K3rgtdgV
 tiBfgjdbf41gJUrTCOQnJBu62nAkP0qxYeBoIuh40xYQWPzp9AW7iNVH03a6/gxzi7+S
 vkoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBX6afY29wDRzTgIiIlq1qDQT5N/omnjbnCmt/1QWtRt6P9xeiiH5VuABRUpHJNhjllx22/ui5PnK2g8DfVJG5N4I4v4=
X-Gm-Message-State: AOJu0YxCmqIRMJS08MfC+qJJ3ALicdbb6Vun0NrbB3Fc60AvidMLA4HL
 T18PXYDdErarvYNf6C3x9LIIkV52UWOe7JkNMMXSlDOIHZTR/z7JY8eyWiKCAe0=
X-Google-Smtp-Source: AGHT+IH/AtE6Xz0Xp0BLRK2J5aYjWndzBVY68WV2AhCKEli+b58eIdXPMNX2c7011yThuk2TbHoazw==
X-Received: by 2002:a05:600c:458e:b0:41a:9c24:8d7 with SMTP id
 r14-20020a05600c458e00b0041a9c2408d7mr3410505wmo.30.1713879034704; 
 Tue, 23 Apr 2024 06:30:34 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adff592000000b00343a0e2375esm14492193wro.27.2024.04.23.06.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:30:34 -0700 (PDT)
Message-ID: <8b6cd951-1ac0-44d2-8c92-06faac1a741c@linaro.org>
Date: Tue, 23 Apr 2024 15:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] rx: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-18-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/4/24 15:16, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with RX.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/rx-softmmu/default.mak | 3 ++-
>   hw/rx/Kconfig                          | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


