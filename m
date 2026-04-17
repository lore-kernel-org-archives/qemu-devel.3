Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2847BF8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbEX-0002Wo-2b; Fri, 17 Apr 2026 00:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbEV-0002U3-Ak
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:55:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDbET-0005ZH-Bs
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:55:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so3545525e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776401708; x=1777006508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K2eUsc15FJXvL0oeiNwJM4ny+AUkGpojf3/e1jZx7IA=;
 b=QHM8HC/5TwqOE2AWq5dZnzpYscaNtEGRlVPk6YCUZk8+XyqTKvvUOjPH4gvHIvQ5SI
 EQhWQ9O2Ls5rpob8tzWs7W/LGKr7fxA0RxDAWQce5rV7SpK+bH8LOrUDMVKUs+Wp7lPB
 qKETKpnisXVx/l8sL/sESCArYZNs0OHHhhdqRTQ/GCSTxp4C9JxQpXHi8SnYhSyJapiK
 KVYzBejUZMWNn6ZdSCNrnLnP5FhkfRQugGqXkXsaZIVe4NIfysOLF2khmgBJRG7r6HTs
 KAnnxIAi3hsCOdo/0958B/a4c2xaWKAKwCReXfX8cOEtjT0wUWVeFS8Riy7MWFxeNbv6
 ncIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776401708; x=1777006508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K2eUsc15FJXvL0oeiNwJM4ny+AUkGpojf3/e1jZx7IA=;
 b=MjWXfQewE040EttLQSHn+k1J5/tzFaQ91qhlDIlwPbfBITlicUb1GMAFDtTor3NEJG
 tFzuwXgQyJ2m57p1wyHhkKpYv24Ceqwq1+WdwSsIo9khwJGK8DsGZmXd2R3O2lCdyCig
 JbaJl54+CClw8P7O+Y1HSUmM0rhBQYv9QZLmYj4P7TFCyC1NYOE1lkRu7sHiRfWRR/vf
 1ngkDFXRp8bNP6i4Suw/kqZkXbJy9Sa+DHHWBByk+FYRK3m5SSZW6tNW17b4jRjBMPPF
 Uh8xcyOS7pA3IZR5OsbAK1tngtw0FZNii4XJhTGBoVQWHazRT8OORIjTis5rV8Z3OBCS
 pKoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G0y4TtBazjmmskvfSvPhmezVMbmBDVrX3e2PwPHYcAgLV9lm1JcvcSA7WuJCpdVTCRM2fm8Ik1h1E@nongnu.org
X-Gm-Message-State: AOJu0YxOknGdGcTTWWhNlYMDI4IF+j3nmYaLYaxGHYFSxX/pDd1r/8y6
 H8hSRmY2Z6PjqGYfp4Jzp9fZbLOzl3r/vlHStapNsIZ6ozTDbgfvF2p9/Qp931TtjwY=
X-Gm-Gg: AeBDietDxTd4eB7hqOHfg3mtfnSY9gMNNzp/r8sZMD6+Gcti+ZBhxtGFbAoBY/Dig89
 lHMNpokxUy3NmZye77bZ/S0cIazNA4w+GIQ1InTKFeC6tNUOg8Y+zb2MjQ8QakhlmwkO7U6dEqt
 vBP6riVsosI5fAac8TvSnJ8I85MG+zuHjtqcZGz5yqxrJpgBTz+HwDBm6wYzM2mzZcn1roeF6Wq
 hfxKQdgyDqdqlgMRu50kLY2K0VzNLazn0TZWPyppY8DIlDsyzEtOa3P4aDKh5zPoSIbqksmQhnS
 QdgDP7nj0rOPCE4fU4US8GxzbzsxYwLceRC/JbR4NEkdxpeq9JnATaT+MeRBeemypcDh448//x4
 TRj6zt16hdG6CaotArLn4Dw/1EIb11M9bh8efHSTwx3B/jYHjCJ6VoXMjwP1s6vUqLdiSF39BHj
 /KodJoUSxtCTFJTM0o4sLfoSxMQ1E0pKGaAwsGei9WyLN7OvSUlRKpCMH3bGvdhLVp93nKgmDoh
 /nR
X-Received: by 2002:a05:600c:1da1:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-488fb785204mr17524105e9.22.1776401707685; 
 Thu, 16 Apr 2026 21:55:07 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc14a61asm13447145e9.15.2026.04.16.21.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 21:55:07 -0700 (PDT)
Message-ID: <0801da2a-3970-4021-8e15-679d0c3d6d5b@linaro.org>
Date: Fri, 17 Apr 2026 06:55:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 03:49, Jamin Lin wrote:
> Introduce a new boolean property, "caps-64bit-addr", to control
> HCCPARAMS[0] (64-bit Addressing Capability).
> 
> When enabled, the EHCI controller advertises support for 64-bit
> address memory pointers as defined in the EHCI specification
> (Table 2-7, HCCPARAMS). This allows software to use the 64-bit
> data structure formats described in Appendix B.
> 
> When disabled (default), the controller reports 32-bit addressing
> capability and uses the standard 32-bit data structures.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/usb/hcd-ehci.h        | 1 +
>   hw/usb/hcd-ehci-pci.c    | 2 ++
>   hw/usb/hcd-ehci-sysbus.c | 2 ++
>   hw/usb/hcd-ehci.c        | 5 ++++-
>   4 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

