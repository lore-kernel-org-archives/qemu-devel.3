Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E42C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg5Ew-0002ko-B4; Fri, 01 Mar 2024 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg5Eq-0002iJ-5j
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:55:56 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg5Em-0006sc-3a
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:55:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412c780464dso6304895e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 07:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709308549; x=1709913349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGjfd67xLecNptvIrHUYbWQz/e0weR4wRxQOimbIicQ=;
 b=SA8uJb9oU1aiKeN9HzfmR8+BL6au5r8F8zJ+JZ0ImelzbJqFKv8lVyrb0aiZmmhjAT
 hDaOGJpv26yJ6hmW2hbPEDg4bln1MZN+qU0QEvmyh1KEIkBvCFR2l5M8ZeNV365fglYg
 2fhvSFzkNXxEvI99/Br3RaFEktIJLnnezx3lA3O5IrRa8/cU5aoUjpzdTvhpfflikGL/
 zZZiUmMPiYntP4aHqF4kMcTkd9F3M2TMKcdYW472VxZpI01Ra8d7tk0medpTde4qVPKw
 O0pNsDtgk9eKMHWmuUswLlvrN79JsfEGyH2lDkvaBKyBtJSjVoHKAM+j4/1OiVCOrjit
 BW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709308549; x=1709913349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iGjfd67xLecNptvIrHUYbWQz/e0weR4wRxQOimbIicQ=;
 b=iM39qdH3ttFcvFX0pM3lmhO3G484sIv0oTE88kfqGqHiZj5qWz0r+G4fHMsx3xJCbs
 NCOhi/tSqB0TdJ107Gw8XZP5d2FMqGj/g255gbP9uAO067OktFHflmkL9xTT4gKJzErE
 N8t3lvXES8jX4X1Ec1Llz45GCidssKjJ98ngZijC4Upa98sRhJ+AmgsZjwRYjb6pGC6K
 CzfOBli9wdPePTSN793E7Rt4vj05z1/d17fAVBFY+S6fUgJMyJIGTeHs5L5aDVMCiCM4
 2Nyzg6uk2coy08sSCPkB9IkzcybPvD0UmF27v4oAZQFtjKh9X2tbF5vB4lfhu8h5pb+h
 AQ4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6r41NupScNApurFVc4QuHyM5Q86MuDEONYlcAhaOl8bfa/dj73xzr9BFI/n+IM6t38ydqEW7pysmpl3/ofkgdyHvL1v4=
X-Gm-Message-State: AOJu0Yxjoz8Z7cbIbPQ4zHNIyW2Fp9Bhk9dscvBB/RXdMmpia5HjdsXe
 F7xKDAZ7tqrmIddH8wcfaI8E8rYwRuUaLWIUsaTB6UaY9M3+M/QMA8RI8NREVFzflsZYjGTlvxS
 uWbs=
X-Google-Smtp-Source: AGHT+IEfE3TUlqi8tVeVtr4X2uory3i5fyUUkqLHJ2iix+3vJG++p/du9Vs37HXgviMC5NtnNULynA==
X-Received: by 2002:a05:600c:474a:b0:412:bf52:9ac2 with SMTP id
 w10-20020a05600c474a00b00412bf529ac2mr1852740wmo.14.1709308549583; 
 Fri, 01 Mar 2024 07:55:49 -0800 (PST)
Received: from [192.168.193.175] (232.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.232]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c021a00b004128c73beffsm8797363wmi.34.2024.03.01.07.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 07:55:49 -0800 (PST)
Message-ID: <e78d9f52-e5d6-4039-a776-f2391afe0799@linaro.org>
Date: Fri, 1 Mar 2024 16:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: Improve error messages about configuration
 conflicts
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, qemu-trivial@nongnu.org
References: <20240301120641.864047-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240301120641.864047-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/3/24 13:06, Markus Armbruster wrote:
> Improve
> 
>     Record/replay feature is not supported for '-rtc base=localtime'
>     Record/replay feature is not supported for 'smp'
>     Record/replay feature is not supported for '-snapshot'
> 
> to
> 
>     Record/replay is not supported with -rtc base=localtime
>     Record/replay is not supported with multiple CPUs
>     Record/replay is not supported with -snapshot
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   replay/replay.c | 2 +-
>   system/vl.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


