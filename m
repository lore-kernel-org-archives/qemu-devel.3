Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C94C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdn1y-0003pS-8y; Tue, 13 Aug 2024 04:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdn1w-0003oF-Uh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:37:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdn1v-00072u-7t
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:37:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so583651366b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723538241; x=1724143041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vV6z8N+8tdskD7I0r2oxLb8s/tD0+mUHbOGVlZruiKM=;
 b=w6ucRuLePOmGVv8invAXv8UbRAP6ltrFem7owux6ijZmTXXD34NkFUavM65zQolrzW
 F7TfqRMs5SFqVlgM7LY44jxVTkV8aZTI3DYTavczajdkn4clUbxtgH30zzt8A3NJGiaa
 CZj5RdnnTpxdl47k2dPQITeqIqQMzuP3phO8ITQxHLiH2AoDm8Otjn1Z7n14IhLQB+Pk
 sL5GKUqJ+0gPMngwso+lOikCQssGKOUlCZWCh4tGeo0ALvE1MQCM3tYGorrifxBCVhaI
 lHnVZm6YByFPgGBrrJZjYotZULESNiUtRrMHJmeFQNERyNYTSwrBChzrHReI0+p2HggS
 Gh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723538241; x=1724143041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vV6z8N+8tdskD7I0r2oxLb8s/tD0+mUHbOGVlZruiKM=;
 b=nkBTFrEDk7HfQSdKkmoiKb66tVG8xltqC+cK2nnC42XRPFoM7oWGwSNo09f3ptfcJd
 Kg0i9IzLqMWf2je4tahoFhKd8Cs9yv6t5VEgB2NgYLmDie2T+Xq9ThBLvB/pBJmf9RCW
 vsuQfAbBVugGUpVV+DeNmZFsc9q65qiJ78I9K2/8wQHZ2RkWYIfEF3vVCUKtb5k0ABJu
 h19gXD2ufd0luVI/6t+7KJtMnIcyrEHzGG6XKqJCwPgSUPT7QxES4miFPCdbuL8RQkhW
 PWbSTmpJjXNac2grJfy17qcPHY6FLOU7XLAzWhmOuaKHjn+vVEa8PXRd8CCC3EsWgpFU
 vBcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7gLuRCGeMeD4GqabG/8OnBKMRr+MDE1WO+KAbVueMPpKhPxnMFMDMtfZmehmXXTlMGw1bZ7T8wlaJ787i67coQgyA9Jg=
X-Gm-Message-State: AOJu0YzO73y2m9BK7IiEiCqppEIFY7OPh5+JzzD9xo5UxSYOdkXaAE6F
 HSwMNiEvwEcHk/LlkFCRAyqA78j+O2Jhaccjjd2v+/7v8vxQAfAD5JqKqwQ7qBw=
X-Google-Smtp-Source: AGHT+IF586vRCNsHBskR4QN8Zx1G6K3M7LhR51oeaD64zpHbvCk9erlOW98bnz7UmouBst1w4Cm7pw==
X-Received: by 2002:a17:907:7f14:b0:a77:af6b:d1a8 with SMTP id
 a640c23a62f3a-a80ed2d76aemr197299566b.64.1723538241017; 
 Tue, 13 Aug 2024 01:37:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3fa782csm49835166b.60.2024.08.13.01.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:37:20 -0700 (PDT)
Message-ID: <55ab8f41-7ac4-4a41-8e2b-3720302bd3ee@linaro.org>
Date: Tue, 13 Aug 2024 10:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Add a description for the i8042 property
To: =?UTF-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 12/8/24 19:23, Kamil Szczęk wrote:
> While working on exposing the i8042 property in libvirt I noticed that
> the property is missing a description. This adds a simple description
> so that QEMU users don't have to dig in the source code to figure out
> what this option does.
> 
> Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
> ---
>   hw/i386/pc.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



