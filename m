Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E65BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGNJ-000404-4U; Tue, 23 Apr 2024 09:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGNC-0003ow-6L
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:39:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGNA-0006KP-Eh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:39:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41a0979b999so18936465e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879586; x=1714484386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=98uBMQfsm/TRcBA0EmXGhtMMNvZJBIGEEwjWZtcHRgc=;
 b=e1R30xsoMoVQaCG0rIrKCJ4aYFBiU0LVqlhG9HXupz7PCwUVlygFbvWVQzOhtZ/ElE
 qde5ypAL9MMBmX1AmfzczjmpoMkyRPbHrYS9mzG5AlJmDQY5CwS94vID4ulsdoW9oWkT
 qkpuhTcLgWdIdVFkH4BmAC8w+MzItavrYFLv20bWdIAbzUYGQTAKTGdMillZKda7NTTz
 2mC+2kkFHmf59pPuuLTJ+hLJvuyHqyNrQAMu68/Q3BMvDklwY7d0JLXkb3vD7wAmrb52
 LmJ6TdZreVaz/QvHlLc+dWnTnYzmIGxOxZ9/qWH+TeUUnCanB5zJ45QHRVGZKFzYmYek
 /TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879586; x=1714484386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=98uBMQfsm/TRcBA0EmXGhtMMNvZJBIGEEwjWZtcHRgc=;
 b=iBEsWuwjCvOVg20FGjfHnI+YTKqbzLcAWYzwYE3j68Mkch+ha69DYQqaG9RrrDBoaN
 17VwwnfXeTSqWF2W5W5US2s62V16iM+tTCVVerPE0eLCLRXkcyUKMbZaGCH00eQRlxU5
 EWfiW0Q6JzryPfIEEJI1IS2o4ih5EtUZdeKTpe8Idppy6slrCThAngEiWWpWSB22uuip
 tmvTULw9HH5U4pLHw7+S6Pdpkeym2S6BEcNt04RmLASGORtEvEaojdhHASvUEymq0YCL
 Yup6PhSYCWliidF5u4wt5SR0B7vxWsVvyBHQnSm853dxz4kwdo3fi3kvxnRp/h0fC301
 E/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJxdZUGYE+HPLTmJpyDsIKCaql6TXHUYiD9XZVRP5dUuoIkjxSiKu6OeujwsoIDO4g3QLWiYSfzbLghL7WnKsAeXuTrcg=
X-Gm-Message-State: AOJu0Yz/9+RNKyg5l00z4tfkN2t93NlY7v1sVIS8VzYEbHsF9Xl1NdZD
 OIMk34gmYbUINP8/o42BpU/16cTesasbM1sLNnQ9QZnze9tHq1cYyhvBcvQxI8g=
X-Google-Smtp-Source: AGHT+IEV/7SxoQ+ikkJ8Kva/c45d8L0xOtZhbdjIExjPhyZmqzDuaHkWEadhBqiDhhmz1pNR43nIqA==
X-Received: by 2002:a05:600c:4510:b0:418:f184:53f8 with SMTP id
 t16-20020a05600c451000b00418f18453f8mr8442292wmo.36.1713879586112; 
 Tue, 23 Apr 2024 06:39:46 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 k41-20020a05600c1ca900b00417e8be070csm20370975wms.9.2024.04.23.06.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:39:45 -0700 (PDT)
Message-ID: <f8cc02f0-72f2-4c99-9404-9b805189fbcc@linaro.org>
Date: Tue, 23 Apr 2024 15:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] openrisc: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-15-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
> Continue with OpenRISC.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/or1k-softmmu/default.mak | 5 ++---
>   hw/openrisc/Kconfig                      | 4 ++++
>   2 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


