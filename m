Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD08C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 21:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv2RU-0000bP-1P; Thu, 11 Apr 2024 17:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2RR-0000Wg-Cg
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:58:45 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv2RP-0007x2-TF
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 17:58:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e40042c13eso2482195ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712872722; x=1713477522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRaUAW5QiBl1bU8OismSAtWfgyEcwWPEktj2dq3sFao=;
 b=QCfGDHMXKjeEV2WL+HWizQ14bPLHsjKI2kY0GO243UEuBfWK96vwjOLCqLgrj4l7aT
 Gdfj42EvRUt0ECYtB+6AZ+hqs4sLQ085jzty0yQ79kxljHOyoPW3ON+W2w52lFA5sTdo
 SXzp5SCNnImGtVCWFsGXv1cy17JTwgVvUj9pCmDt8YPEDzjBTOMDi9/XSbQQxuG8gg6u
 yLkaGjiSYIPtMasDXGuGL1YVcsCLijsRl++NPRL70KAyDv3MePA72/j7AZ3j6oafDV/B
 pqMYRuEOd5UUhx6GeCtSRngR/PXRzb8kjtCicwcC9Czf5btyPmYBh4hHN/gEcyFOBEpY
 /89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712872722; x=1713477522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRaUAW5QiBl1bU8OismSAtWfgyEcwWPEktj2dq3sFao=;
 b=sWrDDx9sWY588/hD/ezoRTkUm3d9YVztLZE04RV8UY5SkygmOwK62liKxHV3u+I194
 i1KC+pJNjl5CRwzhhRMuG2mGfFpKB3ej2ulLZ+OtB6XpaljMTwmVTNWqsj4mCGusAy/B
 eX/CLX/KoS+iA+wqJmdcry0PhmeVBlHXb3YtK+YR6XenncuTg9NGhQH9Y1KJ+7WX2BWT
 GZvloXqBhD8wJvVKSp4TNVsWEU5Zu8OkSllUk8vFGF1oly3sbltEQBBXZ5izwzAJPdIX
 CX/ez6hba8rttbBi1dPsso382IF1bCkyyx3YgpRl0+5o5se0iTe2DY8gwos3ZKXVaUnv
 i1XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+7umGIRU482padXWPczux4+kVV14LPEwTE2+pH4l9xFoaBHWzyNozh+Oxcf22XK0rI3Xa6OThLAASEFOyJKYUZr9sF0Y=
X-Gm-Message-State: AOJu0YzRFa0IFKF+TwD5IIy5yaqqlFbSbp+lDlluJdJAn9vc4lkU2Dyj
 DzLevyxRyVfbY8gXQyP9BDtkx+hcNfLJOpdjRjyuycitCz13qaYooCy+zSVMDpY=
X-Google-Smtp-Source: AGHT+IFn4WFA27ctJHPUlosXMBPyIWnvJHImq/5qG6S0gXy79rGaV2GbUAvKX+gtMQivxeirBSeetw==
X-Received: by 2002:a17:903:230e:b0:1e0:a4c9:84cd with SMTP id
 d14-20020a170903230e00b001e0a4c984cdmr762536plh.60.1712872722351; 
 Thu, 11 Apr 2024 14:58:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902d2c900b001e1071cf0bbsm1643355plc.302.2024.04.11.14.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 14:58:41 -0700 (PDT)
Message-ID: <df7769d1-33bc-4d50-b9b7-d02c92753910@linaro.org>
Date: Thu, 11 Apr 2024 14:58:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/m68k: Remove sprintf() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240411213933.36548-1-philmd@linaro.org>
 <20240411213933.36548-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411213933.36548-3-philmd@linaro.org>
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

On 4/11/24 14:39, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.
> 
> Since they are very few register names, use const arrays instead
> of trying to be clever generating the names. This silences:
> 
>    [2/8] Compiling C object libqemu-m68k-softmmu.fa.p/target_m68k_translate.c.o
>    target/m68k/translate.c:92:9: warning: 'sprintf' is deprecated:
>      This function is provided for compatibility reasons only.
>      Due to security concerns inherent in the design of sprintf(3),
>      it is highly recommended that you use snprintf(3) instead.
>      [-Wdeprecated-declarations]
>          sprintf(p, "D%d", i);
>          ^
>          sprintf(p, "A%d", i);
>          ^
>          sprintf(p, "ACC%d", i);
>          ^
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/translate.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

