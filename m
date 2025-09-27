Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6BCCAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 10:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2SBs-0001vk-MR; Sat, 27 Sep 2025 06:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v2SBo-0001ry-Ed
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 06:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v2SBh-0006ON-85
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 06:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758968991;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bQHZu6GlGZIaEO/g2TQ5pA3RwL4++khsqBPkzJ9RYw=;
 b=eIDcIeybHerxAR8vKfJM4U0uKlTat5DuY6vqhOU5YuZx5hlpo7rFq9BHtrErqCNYD89TT1
 DCAnTtXHIMQDpRASF7fRLQEt/5UbmOetIgabXNr6FhAOkUda55sUXWsyTN1N3PO0MALsIB
 1jv+Gzq7m7jsU6rY+L9/lubGr4SPf2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-3BvK7Af-Mnqg9gluc-e4Bw-1; Sat, 27 Sep 2025 06:29:49 -0400
X-MC-Unique: 3BvK7Af-Mnqg9gluc-e4Bw-1
X-Mimecast-MFC-AGG-ID: 3BvK7Af-Mnqg9gluc-e4Bw_1758968988
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e23a66122so20652035e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Sep 2025 03:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758968988; x=1759573788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bQHZu6GlGZIaEO/g2TQ5pA3RwL4++khsqBPkzJ9RYw=;
 b=tSFq/slUqfzTE+JXdyq84tS2bbfDaTQScfkoTkvM3WQhpLKb0lPQ10yAHRR/d7GPr1
 GMrlNFuvvjjL4iydkx3+V00rr3N2j8jNhg0Wco0vm2bWg5nHaL6QHjey7zhZOx8avuOY
 eDvi2W/jaSmO/5xJ4P9zF6wizK6228iUzHBe9meFrXwLaGiYVyRA/rgNvvEvExHE9zYi
 VJij+8wLRH703jNBI7PtqsspDy3IvRyNzOKUDQT2H5ehpVqebAq/q5hFR+sikTU5E/+J
 RT8gD9MsO8bCp3Q7vDhHy2BKOexHc4ry6I5VP7PgyyB0JeoKL5hPsn10T0KUzuuwyR/f
 cE/A==
X-Gm-Message-State: AOJu0YxhCR7lB7gF9iOosyW3MmdDsc2P5fNWh3ASFWdoXtMRnBsDUjBw
 1SSltYaKiG1QT5mgD1akdsUGuc3kleEou21csdIOKig9CrpB5xt/8L+1pRZmV7xmlsPaX26t3yt
 vBqkN5LADfEdnfAm+ZeEgIEnqv30QWew2HgAefOxXAW+l6GqCZV+tNdxD
X-Gm-Gg: ASbGncuZeidfLaAVNyITPoDYXzFJQU2yX+5Qw1GHPPPRKeCHzW5ZKcin54Ay2WOKHcD
 4arcHZMuqbw44MXXOZKlgECaUNogL4ND3sPeuxtgWnTmLwMS0hk1etz01yWwBhMP+dYGoRNjUk0
 TgYbxdgjgQTd3ueyVc26SipmXWcsrux6Yz4+yGhID6D/zSb/nP0hddtoTFzmP5G0R4AJkw1+9Pl
 xU0B28krvPeOzwYk2dUBpVCszzIGeFFP3LGCPF4kyrvsZtO6irjsGgSyU+L5ePcwyHz/RXtfUzS
 wCu1JShsA/XWO0GM0acSlxpIFMi9Giqi6enWMKzd7UidPKSyEFy3YZCPUFELU8A1ApPwFItH2MD
 ocmFVvtj8e1Q=
X-Received: by 2002:a05:6000:2404:b0:3ea:e0fd:290a with SMTP id
 ffacd0b85a97d-40e458a947bmr8625067f8f.12.1758968988296; 
 Sat, 27 Sep 2025 03:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF43skDECWCDsSuBQyXxKN+KuDHCaU0Aby5YaJcdfOBRMBDLVMQulDg04FAKD8N254Smgxhig==
X-Received: by 2002:a05:6000:2404:b0:3ea:e0fd:290a with SMTP id
 ffacd0b85a97d-40e458a947bmr8625054f8f.12.1758968987895; 
 Sat, 27 Sep 2025 03:29:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a7c8531sm150036945e9.0.2025.09.27.03.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Sep 2025 03:29:47 -0700 (PDT)
Message-ID: <7161c00c-c519-4e90-9dca-99bcf7518d40@redhat.com>
Date: Sat, 27 Sep 2025 12:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] hw/arm/smmuv3: Introduce secure registers and
 commands
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-4-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 9/25/25 6:26 PM, Tao Tang wrote:
> The Arm SMMUv3 architecture defines a set of registers and commands for
> managing secure transactions and context.
>
> This patch introduces the definitions for these secure registers and
> commands within the SMMUv3 device model internal header.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3-internal.h | 72 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 71a3c0c02c..3820157eaa 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -38,7 +38,7 @@ typedef enum SMMUTranslationClass {
>      SMMU_CLASS_IN,
>  } SMMUTranslationClass;
>  
> -/* MMIO Registers */
> +/* MMIO Registers. The offsets are shared by Non-secure/Realm/Root states. */
s/The offsets are shared/Shared ?
>  
>  REG32(IDR0,                0x0)
>      FIELD(IDR0, S2P,         0 , 1)
> @@ -121,6 +121,7 @@ REG32(CR0,                 0x20)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
>  #define SMMU_CR0_RESERVED 0xFFFFFA20
> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>  
>  
>  REG32(CR0ACK,              0x24)
> @@ -180,6 +181,75 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> +/* Secure registers. The offsets are begin with SMMU_SECURE_BASE_OFFSET */
Start of secure-only registers? At least it deserves some reworking.
> +#define SMMU_SECURE_BASE_OFFSET  0x8000
> +
> +REG32(S_IDR0,               0x8000)
> +REG32(S_IDR1,               0x8004)
> +    FIELD(S_IDR1, S_SIDSIZE,          0 , 6)
> +    FIELD(S_IDR1, SEL2,               29, 1)
> +    FIELD(S_IDR1, SECURE_IMPL,        31, 1)
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
> +/* Alias for the S_INIT offset to match in the dispatcher switch */
what is the S_INIT_ALIAS purpose? At this stage of the reading I don't
understand above comment. This it does not match any actual reg, I would
move this defintion in the patch that actually uses it.
> +#define A_S_INIT_ALIAS         0x3c
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
> +#define SMMU_GERROR_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
> +#define SMMU_GERROR_IRQ_CFG2_RESERVED   0x000000000000003F
> +
> +#define SMMU_STRTAB_BASE_RESERVED       0x40FFFFFFFFFFFFC0
> +#define SMMU_QUEUE_BASE_RESERVED        0x40FFFFFFFFFFFFFF
> +#define SMMU_EVENTQ_IRQ_CFG0_RESERVED   0x00FFFFFFFFFFFFFC
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
> +    FIELD(S_CMDQ_CONS, ERR,           24, 7)
> +
> +REG64(S_EVENTQ_BASE,        0x80a0)
> +REG32(S_EVENTQ_PROD,        0x80a8)
> +REG32(S_EVENTQ_CONS,        0x80ac)
> +REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
> +REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
> +REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
> +
>  static inline int smmu_enabled(SMMUv3State *s)
>  {
>      return FIELD_EX32(s->cr[0], CR0, SMMUEN);
Besides other definitions look good to me

Thanks

Eric


