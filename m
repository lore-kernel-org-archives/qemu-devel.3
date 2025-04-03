Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80651C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OWO-0004kf-Hp; Thu, 03 Apr 2025 13:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OW2-0004Oo-Li
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:38:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OVz-00016k-Mi
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:38:09 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so970608a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701885; x=1744306685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o9EuqQtYpLg4lIXORYIGrJX1K1wuSbWz+CAPZKxHIMA=;
 b=sdHMm9f99BBFdLUWLp9AySDNb99EaaZsu+POs5KX1PVtqUUFmIn4ArBfxWt85VASex
 TGRMeiHzvpbNs9ut4ubSD8blYpao2Vl7olCVbl40V43MX/Qo5yPtN2P8dUlYfptrOfoE
 SLJfOoq3F54GReP6Wg1/E4MNEJ/UwKYKNUlM9Td1suaa7411RlYTFp/G6QNncQLJSutS
 oBtaSddvrcPajsv+RFBhfahTqLbLVqIvmyKHYUIE/tjQfwvJbHfr/4cAnwpnxG6p/yIc
 nBy5zrHSvRGZWzhAqDe97RXqfq7TAt60UZsDF3fP4DKBZoAaJXCZtCO4i14FcmDdmDTa
 IwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701885; x=1744306685;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o9EuqQtYpLg4lIXORYIGrJX1K1wuSbWz+CAPZKxHIMA=;
 b=bFUbeWJx+q89AaP3kDulJRnYgZ69MiSUCCdHuNsiCB1uap76yxoOXTO4s9y8GrmrGs
 v8RT2d0PWWCvgYzbdzNUGyndOvpY2i10mG02Wl4lAUf6p9NlpvKdeRe86EeUi33bE4M+
 afEsKVmboE1KcNs6uNDwC68FN+UE8g5Xlq5Se+aJtA9m3IFY33HgZ8CYhij2z8oDIX4N
 mfR1mw0VrsIUbkZR1Ur2Vi2AwYMcF1fBZMi/X232SenF2qOac5Bi0xh6rZLrkoxaROan
 mXfQDtkhxSz2mdLLxTLhAlfZm9UB4g3AH8++Qm8N5KW2gHXJ/UDSgqu8YxXVsNFOBto3
 KrHA==
X-Gm-Message-State: AOJu0Yz+2o7QMvfMFCs46lH4VnmSPYBzlUZbPGXXFYhFVQEeFNZsEBp7
 n3rHZSnzlf3caA8CuQ8XpjGMLpLzvuSL/2xFcQuWpa2vfdiUuJ2tmLHMhzZLaqpmLrUM1y9q90V
 w
X-Gm-Gg: ASbGncvN9kRiuoIzDoo8Y2v3+GI86gm5beAPcPn88oYFwEokF2P7aVBqxIhMy4/T7Rs
 yD/TT1NgbyB3+I2zNRB24TKjo0Cs2ALO9dLDEbIqLoyFeBmkn2DYCqR932nOGqJLJHGa+mL2c5h
 rySpAuztN6meRPrEycM5cyL5mtAFnlxW7J8AhPy8apULxqhUMfXyndBv3B7HYWbQS7dn3M4h7gx
 H9F59VRxkeEfrA7ewPWXMAmGDix2FKZSwXwVD1KR33VaG/vWvBzZcsYieWuY/aHaK5PPdom9NRP
 gtF/6R+FokHd+WdHxKohli5pYGXWWuhZx0qPI4YrckvH20uw7QlhzXGXU8+Bvjvaow3aHsJu5jY
 cxPUsWCSm
X-Google-Smtp-Source: AGHT+IHYofMZ65CKTEjnlUqaxjWi5gpsWPlWxqUr+P2BbKLwX5SFYTwIKd2CGziseKk8X2Z2lrgeJA==
X-Received: by 2002:a17:90b:574d:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-306a4975c0cmr548476a91.27.1743701885349; 
 Thu, 03 Apr 2025 10:38:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca7f5e0sm2194925a91.21.2025.04.03.10.38.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:38:05 -0700 (PDT)
Message-ID: <32598a37-9f31-45be-9336-8372f74ae2b7@linaro.org>
Date: Thu, 3 Apr 2025 10:38:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0? v2 08/14] hw/arm/virt: Simplify create_its()
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> No need to strstr() check the class name when we can
> use kvm_irqchip_in_kernel().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

