Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A48CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcvG-00018G-Cy; Fri, 21 Nov 2025 21:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vMc54-0003es-V3
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vMc34-00030S-FC
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763773446;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hmk1UkbUQrbHuF7+FWwHU8sMOi8c7TBNdFfJ6SDMH4=;
 b=Fi6DUh07AXmSTGkkVXLKBf+g9NUQ0xBPT9aQHEoNGF+qNO1gDPbPnkco9AWhxbX/DRqTje
 F6QARdgBDAd1SLnLrv4RgbqyqNuVSRTiM/UCfmaMAPFBnFSYrA9AkibuCxlh0Ttf6U2Qy9
 F2o2FsZx50WRvTOGFFjdIu7S6pzsLNI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-lR2TVJrCOXas9paioedUag-1; Fri, 21 Nov 2025 07:47:11 -0500
X-MC-Unique: lR2TVJrCOXas9paioedUag-1
X-Mimecast-MFC-AGG-ID: lR2TVJrCOXas9paioedUag_1763729230
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429c7b0ae36so1247291f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 04:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763729230; x=1764334030;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hmk1UkbUQrbHuF7+FWwHU8sMOi8c7TBNdFfJ6SDMH4=;
 b=GG1/8Fx8Mm79coHWPGBz7nPH0x2oJQ3ACRrEfC4Khp7gB7E2tUe79kDgvZCmoM6vzT
 Mq3V2QopubcaYqF0RuNO+MmSVzI2zRR1VCJR6AiNUleAr4si/uMurtGkgc3G4BQdXeFW
 o9Y1nuR2UrAw3fKXuGH+q/rlm0bqTd8J4sJwZFD1ymGvMVE7y4k+P++hypp7/sPtYnD7
 x2qnHmHWndmyof4O9J57VS4j590TpwY4CIwAQdnyillyVBttgOuZI4QjyAf/oVwVQcGq
 9JcgDGNHARM5+zxMWUwffxOWO+lgepAL0nmS5ZJhjhfVnewY3wgzun/bVCoVgQPu9rc8
 A43Q==
X-Gm-Message-State: AOJu0YypW1swGh6QspebIBZ8e4gBgwDUGHv0ZRuF+tjgB5C4hO35DYau
 QQiwEcSvvgCW69Rzp3arTg7ABqNxh6bfrciuisJX7rb18cqME8ZTikeK9VFO/5U6aJRS33rVoz/
 4YR9xeUcLZMxnYK48kxnau57MV1AH9AqC4bkQ7qKWAEFXSZypp3aFoVyZ
X-Gm-Gg: ASbGncuvxB4VlTCJIg8EbSFnLoOZCbp9Bx9o3Z5O1yHNJc2BWEX24aH5QIf5h/6N9qm
 p9NLiMQNZYdMdDKSoiwQMLXUC7M4ZPud5HGREIloEwRZFaQvkVAdP83PN71BIE88oUXhWiBtKgt
 gPXiCmVQAoy0b0z92zrS4UPXhabACxYK6LBlHJvLuLWVBNyncWuLXN+mmaXbwPVJD5gNcxi8zcE
 kaOQdOADB6KfQl/hhz8xFCuEelmRG2VYYAM6RAok9gTiJVxMeYJDIuxr+p652InLu2/6/qeKr5C
 l+BnEtrcvlk858MDYEh9Q3Q0lxV0JD7UgJ3T5FGr73XtBy10Ob9ABceOOUyzBCJg8tyxtqVaMQ4
 EqDX1q+3awreKl9AqATHDz0yQRo89Yr1HdfPqT2Epr0alwYY8ftjBqUkeTQ==
X-Received: by 2002:a05:6000:200c:b0:3ea:6680:8fb9 with SMTP id
 ffacd0b85a97d-42cc12f1c7fmr2422741f8f.3.1763729230418; 
 Fri, 21 Nov 2025 04:47:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe5muzpav+Z2O5vbUz4FuuXKebz4WmWQOptMN7DPk37aFFfqCGp4W1ncC8u2P9uq/55pEiqw==
X-Received: by 2002:a05:6000:200c:b0:3ea:6680:8fb9 with SMTP id
 ffacd0b85a97d-42cc12f1c7fmr2422711f8f.3.1763729230033; 
 Fri, 21 Nov 2025 04:47:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa35c2sm10084081f8f.25.2025.11.21.04.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 04:47:09 -0800 (PST)
Message-ID: <759ec110-365f-488b-802d-c7bb1efe30bc@redhat.com>
Date: Fri, 21 Nov 2025 13:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 03/21] hw/arm/smmuv3: Introduce secure registers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012150701.4127034-4-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251012150701.4127034-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

On 10/12/25 5:06 PM, Tao Tang wrote:
> The Arm SMMUv3 architecture defines a set of registers for managing
> secure transactions and context.
>
> This patch introduces the definitions for these secure registers within
> the SMMUv3 device model internal header.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-internal.h | 69 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 8d631ecf27..e420c5dc72 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -38,7 +38,7 @@ typedef enum SMMUTranslationClass {
>      SMMU_CLASS_IN,
>  } SMMUTranslationClass;
>  
> -/* MMIO Registers */
> +/* MMIO Registers. Shared by Non-secure/Realm/Root states. */
>  
>  REG32(IDR0,                0x0)
>      FIELD(IDR0, S2P,         0 , 1)
> @@ -121,6 +121,7 @@ REG32(CR0,                 0x20)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
>  #define SMMU_CR0_RESERVED 0xFFFFFA20
> +#define SMMU_S_CR0_RESERVED 0xFFFFFC12
>  
>  REG32(CR0ACK,              0x24)
>  REG32(CR1,                 0x28)
> @@ -179,6 +180,72 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  #define A_IDREGS           0xfd0
>  
> +#define SMMU_SECURE_REG_START 0x8000 /* Start of secure-only registers */
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


