Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CE5C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 19:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv05O-0003Zh-4z; Thu, 11 Apr 2024 15:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv05M-0003Yq-Dp
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:27:48 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv05K-0000V7-Uw
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:27:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so1397985ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712863664; x=1713468464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDfFMBcnV9jSdKar7lujziopZr97R5f685OZFBgNJrs=;
 b=b9HzuiBFrbP8OBkDQqrUakWdCjodeIAZJsJXLb95BAUIdHUqxAoRSL54L5yok/KXz/
 GGiL/XfAw9anix/HPmZuF8CjhVt1ih7Fa3c798fDf51yE9vutQF23Qg6dTdUT0AZi7Iw
 /K5yrmg3rKIWebl6F+kGmuPTeEolhcTrWMPgqA2LMl3hBr+pVlu9JEZiw3X8T1OBF6jz
 AKonuvqDdtaPI+idpXiUofLX2C6nXdh6AXRoRs0iWF0sFUmDcuyF//ErjdA0tROGCM+p
 qUU2ZPoLISIiQyhgNAowIXlC3FozC+MItenTx1/2tnmNRiL5MmpKVLzK7GdGviZXYi9H
 m2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712863664; x=1713468464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDfFMBcnV9jSdKar7lujziopZr97R5f685OZFBgNJrs=;
 b=dYyggYOvGgeHep5oFLgU5RuFZEPYZ6GefZZiBT5PWTV0cXZLCI9tPhX6eUggBr/Foq
 BBSjBGmNq4QRIO8S8MYdAI+drViPJh2iXDFGd8VzKU1n4ZjRkWdhkxVKKp4ataysP9IV
 +p1/j/wCb8BiAWduNuO8kPAvnD3iOb/XDWOf2wRw5BO3tmu/vtGlwR3XhhHAVxxzR2WX
 y8WdFoLbnb1stOiyBZAtXOpj9q/3wB5zXtR6m3f0cDSv3Bpy55qHbiiWwkkoIuK7y7V6
 z0v0JBDpH9Hh4eKB40JPTO3KiP+TbrhfLzxrovyq65znbUYXM0ghV3efZrcflU4NrSuF
 9WgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGOCgVq+Imy5GufWm0PQWvQOkACHNCONZuxKfmk/w7B7wJOwO49WJXiJLOp4rM5IG3MWNPFuq1945xsX2bkfiBMySU0SQ=
X-Gm-Message-State: AOJu0YwAiZA4POf338WL/21Iqq11RUAypVlP+hQQ8sGnc8XlAwVslf2K
 gIlEY7yNuSbzxGFiEG28frXzsrqD5F/NaYZorRuIDPPhGOcpiB6ogOuWKMamimU=
X-Google-Smtp-Source: AGHT+IFStkTojydHJTye2l7uO7y4nQ+A8aBttYtbvj9GS+Z82PivhZdRp2RwSo1z9UgTPPnEK9g5SA==
X-Received: by 2002:a17:902:d492:b0:1e3:c610:597d with SMTP id
 c18-20020a170902d49200b001e3c610597dmr404078plg.60.1712863664117; 
 Thu, 11 Apr 2024 12:27:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a170902f69000b001e29c4b7bd2sm1518901plg.240.2024.04.11.12.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 12:27:43 -0700 (PDT)
Message-ID: <5f6f8b74-5093-4b9b-89ad-2f03feeada0c@linaro.org>
Date: Thu, 11 Apr 2024 12:27:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] ui/console-vc: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
> 
> Replace sprintf() by snprintf() in order to avoid:
> 
>    [702/1310] Compiling C object libcommon.fa.p/ui_console-vc.c.o
>    ui/console-vc.c:824:21: warning: 'sprintf' is deprecated:
>      This function is provided for compatibility reasons only.
>      Due to security concerns inherent in the design of sprintf(3),
>      it is highly recommended that you use snprintf(3) instead.
>      [-Wdeprecated-declarations]
>                      sprintf(response, "\033[%d;%dR",
>                      ^
>    1 warning generated.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   ui/console-vc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

