Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F725C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts9Z-0007yO-Gj; Mon, 08 Apr 2024 12:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts9Y-0007xT-2x
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:47:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts9W-0002P2-Lo
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:47:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dff837d674so40373325ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594845; x=1713199645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vflhTgusOZn6PFE81id3f/CfyzWRzCHzi8F++BzbPE0=;
 b=Th32qrjQ0f3DmJZc4+bgY32lm2LqCi8jfZPRcNs7U2xLLxIUTzkiMr7tPax/cE4IE1
 hGrirJNGAQc9lM4SG48zq3L8J4ODi+WT1z2QmeECQuGK5MTKd1it4ETbB5X7v4DVqXlC
 UitC44yw3ctsC0GSbdNEHS1vR5k7bKUIDmgnmjyKd4dGre0DSkK5Qkp1gDpxTkVOAgSm
 2INTXbOzvX+t55k+3wgaxyVWcy17ush/k3GEHTssDsSbAOs5c/ISEyUErfDSQA5vvARs
 yecJ9Fkll4DKgcXG2pgK34htE4JYECSx2aizBpt+41kPkCGT4dV1zly27hBSSMcyQOYi
 LP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594845; x=1713199645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vflhTgusOZn6PFE81id3f/CfyzWRzCHzi8F++BzbPE0=;
 b=QfmCjWqM8bIp2RI+yNFd4tresWPhyQgc2xBgofAPjIdE4EJP/orPpkA+WKsG/Mj+IM
 DSY28/WXcSk+TmwRbSjoZCGzJ13J7dj7Zd3zNGDl3Zm8yS2kKi2v87AKfsZZ/l44sIt2
 uX0eqAeVGjXMEXxFSqMLmxpLfNwky0rOgBGcgKFvwE+Wt1KNqEZXXMtngcteqCBLpbQ3
 m+5lWrQKTwpQTGWMRNJ7auWwjzA+N0kGs4sOJ0MNoFx0kEPYm5uF3OJTUNEujDqret7x
 /wYeoKv7+B/NJA260fR7+CHsGBoPeYLPooTVJSerT0fOKqZKcZ0vea32IHm+Cn3Nc/a6
 CL8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpknFLXm3aklyor2NSlns54lCt2lQcqvq81NfQ5VPGzaRBNw5vGo1FG9eIFoPbMLOnbOSPnUxu5om+Kmdyr+OoQvVfJAA=
X-Gm-Message-State: AOJu0Ywf9/BAoP5zQsivB02leFYX7W3QmGNFdEfOYC6a6HhT9dAtSsQK
 aT1A0tTrWtMsUYygZ8xoEivrvVQUTmmwlKnu6Ffrsi9Cg67W8AXTYqOgKUQJP8fGfrzUQbBXQgV
 W
X-Google-Smtp-Source: AGHT+IG3MqSp89zEW/ZoqsjZQV8muo9R7BH3GHVMdKCk98UdLtO+aUjz1nfXne1DjPQZ9zHskIZplQ==
X-Received: by 2002:a17:902:d386:b0:1e2:8eea:8a83 with SMTP id
 e6-20020a170902d38600b001e28eea8a83mr9899376pld.22.1712594845255; 
 Mon, 08 Apr 2024 09:47:25 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a170902f0cc00b001e002673fddsm7223183pla.194.2024.04.08.09.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:47:24 -0700 (PDT)
Message-ID: <7d1e32c0-107b-4d72-ab50-349a23b0a10d@linaro.org>
Date: Mon, 8 Apr 2024 06:47:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] hw/usb: move stubs out of stubs/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Since the USB stubs are needed exactly when the Kconfig symbols are not
> enabled, they can be placed in hw/usb/ and conditionalized on CONFIG_USB.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   stubs/usb-dev-stub.c => hw/usb/bus-stub.c | 0
>   hw/usb/meson.build                        | 2 +-
>   stubs/meson.build                         | 1 -
>   3 files changed, 1 insertion(+), 2 deletions(-)
>   rename stubs/usb-dev-stub.c => hw/usb/bus-stub.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

