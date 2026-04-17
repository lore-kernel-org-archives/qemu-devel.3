Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65969F8E491
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcU1-0005ED-O0; Fri, 17 Apr 2026 02:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcU0-0005DB-GZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:15:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcTy-0004co-Lh
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:15:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so3751215e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776406512; x=1777011312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GukCC62Ain8Ts8PFPTvU58zWf7+hRlJKZxr9+ckB/+4=;
 b=MBJnYiSd1cz33Ar0hO+jZ0VhwLqvTB8mKnOCANXKEX7ZUjEfCzB4M6vSWwuqqs9zxb
 RL59+XuITwQZ3LVyz7B/cgUFhB6nEgGicdZXM8arY5EzGq8pbvt2QYjlEfMHwpYpL+g2
 MnP1e8w1YM7Pj+NiIp9S2a5oTnBKq+Yr77cqc14kz7FRHTa5oqLabTonaCfTmaRCUBrT
 y/BwY6wfUNY6IAAx9egqmxpJSC66S2yPBPTVRIXHUkUR01csu2hM8ObwfuBGfg7rrUji
 vLvwAWq8OAi55lSVILQOYHdiRRsQ9JcrbWIT0cQIzZzmL4HpsJj8ta7tOUH5i8BPuU1K
 Cx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406512; x=1777011312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GukCC62Ain8Ts8PFPTvU58zWf7+hRlJKZxr9+ckB/+4=;
 b=kKfL8ByqesaiizdIFcZuGrEGj3rRUg3HFvxqmQPBnRXAb+m7t3RD6tJvN92/km4Cf3
 swhwL5tFMD2jZCh+SzmPxmwQ4dOv2iXFJ6q4IltjjboL25/1m8M8qS9ogFZ0sdYu6kkG
 EmAd3u9vmNYiQDPO5qJc9lccclZAYKT8elf7FLFrUIQ33LLajtkjESalNUrz9uiEA6yE
 IM5Q+9PVIo4j2Rt1zhdxJUkwTh3mCaMUw8p7fidGCNDswgYKRaxb+8GQixabiSaJELbO
 1qz8NXzhFwSklF6CB3pvQndBh2UyfyNm/ONLXCj4FHlbIxWYqY6ySmnbqOfAZVBwm92u
 PAzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P9keQ4wNV4t8R6ky5HrEbrFtnCfKhITqGNanypZpDp1E0rp0XzjLLjLaUwNJQ+KTXCKtwtKfSzadO@nongnu.org
X-Gm-Message-State: AOJu0YykilxkQBZOVEYEJ0DgNnsv+IYbHg6wiHRxR3ByKl2J6mf1VRPW
 ROgsZzSiMLotdfm5HuWMIIFnIAKx522IuTKctPSsqnIcF2XnxorIJdjuq6zqfI6UVG8=
X-Gm-Gg: AeBDiev8xGjA9QSP6wPNnOQ612IHrgA0T9kSiZ/bJXIe/oGLY/sO40mUP2UDc9PtR2E
 9tzsKbLiyCcHEU1eUyn0z4wo8UWBc4WiU4avCJCGhWILc4qcBH24TNn+SNr3r38zYYXHDF8aUI+
 OvFnWJoQ9dp9j7Rap2S3stn29YssjnhDAdUhZxrvXoy4RjC5twa1mBKA3MIkpWbcHfob3PmJcu7
 LRgbSsNN3yhPDdIvSWu1Ib3j7nCScFr2nr7i39LQWuawN/nOY3CT9i2y8yAv9PrUfBgCIAwypT3
 RavkIb5ewa8CLEer7H3//1xmuaN2XWy1QK1VGunLz2OHzH3KUNompJHNyX6yXgOCb6z43zk6H2q
 EOaTOJXvzwlf8blSSFHvYgw7JNKy430vgKGLuN+ckx7wdjrrPd24JCNmNUH4/HnLNe2vf7Sk1Vg
 l55eREbddUVyj+dfsN1VI+5wn71T4VIM+K96gS1gRx7ZTy6sCiA/czR3F0YrQ9vruX0fcaYmgRS
 4nOiuedd/0mmOM=
X-Received: by 2002:a05:600c:c09c:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-488fb78c1efmr13889525e9.26.1776406512400; 
 Thu, 16 Apr 2026 23:15:12 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb6e16b3sm12758585e9.0.2026.04.16.23.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:15:11 -0700 (PDT)
Message-ID: <a42e034b-3a70-4e8f-96c8-9fd70db06400@linaro.org>
Date: Fri, 17 Apr 2026 08:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/17] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-12-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-12-jamin_lin@aspeedtech.com>
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
> EHCI supports 64-bit control data structure addressing when the
> 64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,
> the CTRLDSSEGMENT register provides the upper 32 bits that are
> concatenated with 32-bit link pointer values to form full 64-bit
> descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).
> 
> iTD link pointers are stored as 32-bit values and must be expanded
> to full 64-bit descriptor addresses when 64-bit mode is enabled.
> Update the iTD traversal path to use ehci_get_desc_addr() when
> following link pointers.
> 
> Appendix B also defines high dword fields for iTD buffer pointers.
> Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct
> full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields
> when processing isochronous transfers. This allows buffers above
> 4GB to be handled correctly.
> 
> When 64-bit capability is disabled, descriptor and buffer addresses
> remain 32-bit and existing behaviour is unchanged.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/usb/hcd-ehci.h | 1 +
>   hw/usb/hcd-ehci.c | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

