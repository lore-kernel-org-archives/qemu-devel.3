Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81582CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7ID-0004jn-Ti; Mon, 18 Aug 2025 17:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7IA-0004j4-7L
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:21:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1uo7I8-0001Ms-9p
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:21:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-459fc675d11so7745e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1755552078; x=1756156878; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jFHquhufFHH30qFdKbaJnC12xlDe8X/GcLn5WrAb8yo=;
 b=PagwHS1kjFcBlfcCNFZcDbo/KXCrneKO4eta47LRkkoiK79Wxe2sxbSy11XsP1RBuG
 BReCNTqcsUV1Yh5oxbk1VqsL58zuylZ41ovQyt2y6a8oVwuhzt4ZYNHRjjp5Su+hywWO
 xgs/43SaSrHXSrx6vVPPf7REVrQ37zhhrLMZFAYoKFwTuTTuXV2dR+kYWcRWq5zOD5nZ
 XtGBWO7KqGEDeDBny6dluDPVq4FUNFkFxAbitC3hHiDXH3d5aZdifu1dtbx4Oh5tCNnF
 uZUqVYPqDn/ZHtKEnle/culPmlDDMHHq/R7sT7U0ZheH2L3S4wVuO57qhoqvOQjkWErg
 q0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755552078; x=1756156878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFHquhufFHH30qFdKbaJnC12xlDe8X/GcLn5WrAb8yo=;
 b=mydyo+3IqrcBe/IwbIFaQCgwcO+2bwypFMpgLJjxVJCyC4tJvKw/+oY6C5DS9n1fvU
 O7qgWw7HhNh6jkSSe39RStfHvUEw8BR1KSVCuGHQfpkCPP5GnfaqXPNLw9v0XZneyJPX
 yvj9Y0H+ka4LZh4T1//YFxRgNAx1N9t4R2Iwmf0AjV39Dl7Yv3fZdwwPA7BHJ/hvpswU
 MD4KksRSdq31qU0WTgIhS1sRJ9R0+lOTVmzWYXXUIyhtBBbGtXnxlH1LxRKl0e84f5cl
 mq+QtSrAWxZltV55HTi8Rv4sUdKRjGL3kIynMenvQWfD+lLJUKxI/wtaTzXCy4qbEbui
 s1EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgbDtwaBtJOfBoNxMal44IWw5X/tYLyzoehGFDSsInaoHNykqYRHRzzlDbk8KQeny+zTJjROnnsg1b@nongnu.org
X-Gm-Message-State: AOJu0YxfZ5Vtg6mP9i/CnNKFW2g56Tv4zxNpsTghlHyfjT7sMSV1GnaC
 Y3e0d6C3u0jsbZZE4ROsljKQ3JAh4OxAm6I3OLRTAg7m+zFumX1cWQOp9ZRzUct/q4kLrLz0q2k
 jPtzQjw==
X-Gm-Gg: ASbGnctdWLG2xmpvPUs1lriHgQ3936eAZzIcXjsm4WxfTTXpM38dwzQ1O3QGzAbTA51
 txI4Ao26bA2w0LXVEgxhx5l0ote9J8/73KM9ULfb8USGei4ybBDPBC9wBSovSDl7e8bgE2YwSnt
 zsfvj0gIqFIkd63i23EsI1yy5iV0g6veS0eWny3g0WUay9Rtu06JmkVEBIWNRcccpVcK2ZohUiA
 tgEzKwQucnCnzGDbLA8rYWjZn17NFrcklaXRgOqfGZ6VQTplOocGDRErm48/Jz64X1mFqB+aGQ4
 hxHV/WN8FDIWEGQTA3tqloSWOfHTbXUbdPtLVcbGF8sJwKEAb1PHoEfoKgD5oZGPuiebnDCuQ4w
 x5676RMCOSMuVCwRcWJQh+EzBBJ1j+ZY1gOs/CpCW6hp7nr5mHzRNx+InXYV2+NScs7jyB4od
X-Google-Smtp-Source: AGHT+IGbN1B+txJbHRL4gH2uTdIkYMztQMnEhlGr5UIe0FKJGWnDY5kJzlA9i+RURxJgxQAtTzBixA==
X-Received: by 2002:a05:600c:3f05:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45b43d4eb3cmr49235e9.1.1755552077935; 
 Mon, 18 Aug 2025 14:21:17 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com.
 [146.148.121.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c61a66esm186240545e9.0.2025.08.18.14.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 14:21:17 -0700 (PDT)
Date: Mon, 18 Aug 2025 21:21:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
Subject: Re: [RFC 01/11] hw/arm/smmuv3: Introduce secure registers and commands
Message-ID: <aKOZSRzy2M80xFeO@google.com>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-2-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806151134.365755-2-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=smostafa@google.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 06, 2025 at 11:11:24PM +0800, Tao Tang wrote:
> The Arm SMMUv3 architecture defines a set of registers and commands for
> managing secure transactions and context.
> 
> This patch introduces the definitions for these secure registers and
> commands within the SMMUv3 device model internal header.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3-internal.h | 57 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h  | 23 ++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b6b7399347..483aaa915e 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -179,6 +179,63 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> +/* Secure registers */
> +#define SMMU_SECURE_BASE_OFFSET  0x8000
> +REG32(S_IDR0,               0x8000)
> +REG32(S_IDR1,               0x8004)
> +    FIELD(S_IDR1, S_SIDSIZE,    0 , 6)
> +    FIELD(S_IDR1, SEL2,         29, 1)
> +    FIELD(S_IDR1, SECURE_IMPL,  31, 1)
> +
> +REG32(S_IDR2,               0x8008)
> +REG32(S_IDR3,               0x800c)
> +REG32(S_IDR4,               0x8010)
> +
> +REG32(S_CR0,                0x8020)
> +    FIELD(S_CR0, SMMUEN,      0, 1)
> +    FIELD(S_CR0, EVENTQEN,    2, 1)
> +    FIELD(S_CR0, CMDQEN,      3, 1)
> +
> +REG32(S_CR0ACK,             0x8024)
> +REG32(S_CR1,                0x8028)
> +REG32(S_CR2,                0x802c)
> +
> +REG32(S_INIT,               0x803c)
> +    FIELD(S_INIT, INV_ALL,    0, 1)
> +
> +REG32(S_GBPA,               0x8044)
> +    FIELD(S_GBPA, ABORT,     20, 1)
> +    FIELD(S_GBPA, UPDATE,    31, 1)
> +
> +REG32(S_IRQ_CTRL,           0x8050)
> +    FIELD(S_IRQ_CTRL, GERROR_IRQEN,    0, 1)
> +    FIELD(S_IRQ_CTRL, EVENTQ_IRQEN,    2, 1)
> +
> +REG32(S_IRQ_CTRLACK,        0x8054)
> +
> +REG32(S_GERROR,             0x8060)
> +    FIELD(S_GERROR, CMDQ_ERR,          0, 1)
> +
> +REG32(S_GERRORN,            0x8064)
> +REG64(S_GERROR_IRQ_CFG0,    0x8068)
> +REG32(S_GERROR_IRQ_CFG1,    0x8070)
> +REG32(S_GERROR_IRQ_CFG2,    0x8074)
> +REG64(S_STRTAB_BASE,        0x8080)
> +REG32(S_STRTAB_BASE_CFG,    0x8088)
> +    FIELD(S_STRTAB_BASE_CFG, LOG2SIZE, 0, 6)
> +    FIELD(S_STRTAB_BASE_CFG, SPLIT,    6, 5)
> +    FIELD(S_STRTAB_BASE_CFG, FMT,     16, 2)
> +
> +REG64(S_CMDQ_BASE,          0x8090)
> +REG32(S_CMDQ_PROD,          0x8098)
> +REG32(S_CMDQ_CONS,          0x809c)
> +REG64(S_EVENTQ_BASE,        0x80a0)
> +REG32(S_EVENTQ_PROD,        0x80a8)
> +REG32(S_EVENTQ_CONS,        0x80ac)
> +REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
> +REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
> +REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
> +
>  static inline int smmu_enabled(SMMUv3State *s)
>  {
>      return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..72ad042514 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,29 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +
> +    /* Secure state */
> +    uint32_t secure_idr[5];
> +    uint32_t secure_cr[3];
> +    uint32_t secure_cr0ack;
> +    uint32_t secure_init;
> +    uint32_t secure_gbpa;
> +    uint32_t secure_irq_ctrl;
> +    uint32_t secure_gerror;
> +    uint32_t secure_gerrorn;
> +    uint64_t secure_gerror_irq_cfg0;
> +    uint32_t secure_gerror_irq_cfg1;
> +    uint32_t secure_gerror_irq_cfg2;
> +    uint64_t secure_strtab_base;
> +    uint32_t secure_strtab_base_cfg;
> +    uint8_t  secure_sid_split;
> +    uint32_t secure_features;
> +
> +    uint64_t secure_eventq_irq_cfg0;
> +    uint32_t secure_eventq_irq_cfg1;
> +    uint32_t secure_eventq_irq_cfg2;
> +
> +    SMMUQueue secure_eventq, secure_cmdq;
>  };

As Philippe mentioned, this would be better the secure state is separated
in another instance of the struct, that seems it would reduce a lot of the
duplication later around the logic of MMIO and queues... in the next
patches.

Thanks,
Mostafa

>  
>  typedef enum {
> -- 
> 2.34.1
> 
> 

