Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC0AC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBt4t-00019r-6H; Mon, 05 May 2025 06:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBt4s-00019Z-1V
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:29:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBt4p-0001n9-8g
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746440973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98+niTqY62qg8EJapl96jlCaj8jKHPwFxwJjWhai2tI=;
 b=KPb8eeh/rlygUKCJcNnijwA/Wu2OYCSOIE9tIEavXl1F58trKMVsWAP3Q5Ec3HstlmyzLT
 sWYl3j9IsFDc4aG4XoD0Ur5jN5vkvsp4HTRqKFt95HSLD+A22DyHIEhlLqRmYLVRiS5Y3E
 M9slIre/IDznuVPgsAJ+/MkBoS2JIko=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-_jIk5rtJMBimx4g_uXRq6Q-1; Mon, 05 May 2025 06:29:32 -0400
X-MC-Unique: _jIk5rtJMBimx4g_uXRq6Q-1
X-Mimecast-MFC-AGG-ID: _jIk5rtJMBimx4g_uXRq6Q_1746440971
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so2505048f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746440971; x=1747045771;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=98+niTqY62qg8EJapl96jlCaj8jKHPwFxwJjWhai2tI=;
 b=IHxKuC85IG3ILWuFvrdYH0/09l8dvPaoBHIi4ILfAQCA5b1TJ5k59DNDPCLFL26H8q
 SHdKzaCksXH1bPdduZTSGzwlYZpzuGFIPHqlwKOBhWuRvmenSTFtOE/0hqggIYZLyyku
 HlX8w9puKjP7M4XAOGRFxFK4eoaZfBcZH28cXtJrdvux1odK3tQ0X+aN/LZdvRCvyj3k
 7K9PQuJ6BhB2sNyYKOiU7lEIzivlU0GCvDTJ0hI1Qdnn7T8wtg2xrgomDoWtXv8AL34t
 HTeHcV8sg45Qbho3tmUluJdta6p09/AMiOAugvLYMp9LfSQUIkqROaSvtwk2uwKG7rvY
 49UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfEPKkwKR3bKTwhe2cjgOzSxF8vNQf7Yhbh3P8SmtFzChkK0o3htRKP8mqAAL1nZz5CvGq3b3pZ9o9@nongnu.org
X-Gm-Message-State: AOJu0Yws0KAQ3nApPVWRZAaffxyHpYdFDwbb1+SaxZPU04KmX2Eb4zqu
 z+R8uUSwc6hlboojrbDjv2AFAoPVWw4/5Hl/u598d5dkp+ZutFo8DnqIg87IB/G2pY4iIdiYqqm
 mU1Ouqf31NslYn55vwMPSWmp8ootiam+cRKuvXPfc649lnkVNqRVrTFWFU2hr
X-Gm-Gg: ASbGnctB4LC342Ct6iV2m867xZHbjh9tcFiyQM3999l3wucXkC8OHfGY2poTx9AR6Hj
 GLKei6Leb7eCt7G8eg1JOSHIkXI3dNQbZouHZmX8aWcQmmrM37yaY57irIC4qFnFYkg9I+oak5J
 iR9a+lM4+/XPnAiiFL6VVVNnO7/zvFxiHV67pqvHbct+UqB0tNwuSuZug18wXg4pVKlN7cFkf4B
 EQSAnvpQH41M2jo7e/TmZJTbFEd62Kl9AzZp8rZyuCiHyrZDq6wdageGZkKZoHFNP/EkZjuqkmu
 cIKxnminJ0bphb7+SybUOyH+URF9SWYXHuyv07YU
X-Received: by 2002:a05:6000:1a89:b0:391:3f4f:a172 with SMTP id
 ffacd0b85a97d-3a09fddec9emr4403567f8f.49.1746440971157; 
 Mon, 05 May 2025 03:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeHyE2s45q0pPjNVWRynyiFdK1RaIX09GqkyFWmD5gj2MAjqKJPWJWMSs9/b1gD9JBIWpz6A==
X-Received: by 2002:a05:6000:1a89:b0:391:3f4f:a172 with SMTP id
 ffacd0b85a97d-3a09fddec9emr4403548f8f.49.1746440970723; 
 Mon, 05 May 2025 03:29:30 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16ec6sm9748103f8f.83.2025.05.05.03.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:29:30 -0700 (PDT)
Message-ID: <08323a18-a480-430a-8ba3-90617c319aa7@redhat.com>
Date: Mon, 5 May 2025 12:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Replace TABs for spaces
To: Santiago Monserrat Campanello <santimonserr@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250503201322.141948-1-santimonserr@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250503201322.141948-1-santimonserr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/05/2025 22.13, Santiago Monserrat Campanello wrote:
> replaced for arm code
> 
> Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/373

  Hi!

Thanks for tackling this! Some comments below...

> 
> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
> index 91d7e3f04b..58b2a27533 100644
> --- a/hw/arm/omap1.c
> +++ b/hw/arm/omap1.c
...
> @@ -1592,22 +1592,22 @@ static inline void omap_clkm_idlect2_update(struct omap_mpu_state_s *s,
>   {
>       omap_clk clk;
>   
> -#define SET_ONOFF(clock, bit)				\
> -    if (diff & (1 << bit)) {				\
> -        clk = omap_findclk(s, clock);			\
> -        omap_clk_onoff(clk, (value >> bit) & 1);	\
> +#define SET_ONOFF(clock, bit)               \
> +    if (diff & (1 << bit)) {                \
> +        clk = omap_findclk(s, clock);           \
> +        omap_clk_onoff(clk, (value >> bit) & 1);    \

Could you pease align the backslashes here?

...
> @@ -2244,39 +2244,39 @@ static void omap_uwire_write(void *opaque, hwaddr addr,
>       }
>   
>       switch (offset) {
> -    case 0x00:	/* TDR */
> -        s->txbuf = value;				/* TD */
> -        if ((s->setup[4] & (1 << 2)) &&			/* AUTO_TX_EN */
> -                        ((s->setup[4] & (1 << 3)) ||	/* CS_TOGGLE_TX_EN */
> -                         (s->control & (1 << 12)))) {	/* CS_CMD */
> -            s->control |= 1 << 14;			/* CSRB */
> +    case 0x00:  /* TDR */
> +        s->txbuf = value;               /* TD */
> +        if ((s->setup[4] & (1 << 2)) &&         /* AUTO_TX_EN */
> +                        ((s->setup[4] & (1 << 3)) ||    /* CS_TOGGLE_TX_EN */
> +                         (s->control & (1 << 12)))) {   /* CS_CMD */
> +            s->control |= 1 << 14;          /* CSRB */

Please also align the comments here.

> @@ -2962,9 +2962,9 @@ static void omap_mcbsp_intr_update(struct omap_mcbsp_s *s)
>   
>   static void omap_mcbsp_rx_newdata(struct omap_mcbsp_s *s)
>   {
> -    if ((s->spcr[0] >> 1) & 1)				/* RRDY */
> -        s->spcr[0] |= 1 << 2;				/* RFULL */
> -    s->spcr[0] |= 1 << 1;				/* RRDY */
> +    if ((s->spcr[0] >> 1) & 1)              /* RRDY */
> +        s->spcr[0] |= 1 << 2;               /* RFULL */
> +    s->spcr[0] |= 1 << 1;               /* RRDY */

dito.

...
> @@ -3064,27 +3064,27 @@ static void omap_mcbsp_req_update(struct omap_mcbsp_s *s)
>   {
>       int prev_rx_rate, prev_tx_rate;
>       int rx_rate = 0, tx_rate = 0;
> -    int cpu_rate = 1500000;	/* XXX */
> +    int cpu_rate = 1500000; /* XXX */
>   
>       /* TODO: check CLKSTP bit */
> -    if (s->spcr[1] & (1 << 6)) {			/* GRST */
> -        if (s->spcr[0] & (1 << 0)) {			/* RRST */
> -            if ((s->srgr[1] & (1 << 13)) &&		/* CLKSM */
> -                            (s->pcr & (1 << 8))) {	/* CLKRM */
> -                if (~s->pcr & (1 << 7))			/* SCLKME */
> +    if (s->spcr[1] & (1 << 6)) {            /* GRST */
> +        if (s->spcr[0] & (1 << 0)) {            /* RRST */
> +            if ((s->srgr[1] & (1 << 13)) &&     /* CLKSM */
> +                            (s->pcr & (1 << 8))) {  /* CLKRM */
> +                if (~s->pcr & (1 << 7))         /* SCLKME */
>                       rx_rate = cpu_rate /
> -                            ((s->srgr[0] & 0xff) + 1);	/* CLKGDV */
> +                            ((s->srgr[0] & 0xff) + 1);  /* CLKGDV */
>               } else
>                   if (s->codec)
>                       rx_rate = s->codec->rx_rate;
>           }
>   
> -        if (s->spcr[1] & (1 << 0)) {			/* XRST */
> -            if ((s->srgr[1] & (1 << 13)) &&		/* CLKSM */
> -                            (s->pcr & (1 << 9))) {	/* CLKXM */
> -                if (~s->pcr & (1 << 7))			/* SCLKME */
> +        if (s->spcr[1] & (1 << 0)) {            /* XRST */
> +            if ((s->srgr[1] & (1 << 13)) &&     /* CLKSM */
> +                            (s->pcr & (1 << 9))) {  /* CLKXM */
> +                if (~s->pcr & (1 << 7))         /* SCLKME */
>                       tx_rate = cpu_rate /
> -                            ((s->srgr[0] & 0xff) + 1);	/* CLKGDV */
> +                            ((s->srgr[0] & 0xff) + 1);  /* CLKGDV */

dito

> @@ -3703,25 +3703,25 @@ static const struct omap_map_s {
>       const char *name;
>   } omap15xx_dsp_mm[] = {
>       /* Strobe 0 */
> -    { 0xe1010000, 0xfffb0000, 0x800, "UART1 BT" },		/* CS0 */
> -    { 0xe1010800, 0xfffb0800, 0x800, "UART2 COM" },		/* CS1 */
> -    { 0xe1011800, 0xfffb1800, 0x800, "McBSP1 audio" },		/* CS3 */
> -    { 0xe1012000, 0xfffb2000, 0x800, "MCSI2 communication" },	/* CS4 */
> -    { 0xe1012800, 0xfffb2800, 0x800, "MCSI1 BT u-Law" },	/* CS5 */
> -    { 0xe1013000, 0xfffb3000, 0x800, "uWire" },			/* CS6 */
> -    { 0xe1013800, 0xfffb3800, 0x800, "I^2C" },			/* CS7 */
> -    { 0xe1014000, 0xfffb4000, 0x800, "USB W2FC" },		/* CS8 */
> -    { 0xe1014800, 0xfffb4800, 0x800, "RTC" },			/* CS9 */
> -    { 0xe1015000, 0xfffb5000, 0x800, "MPUIO" },			/* CS10 */
> -    { 0xe1015800, 0xfffb5800, 0x800, "PWL" },			/* CS11 */
> -    { 0xe1016000, 0xfffb6000, 0x800, "PWT" },			/* CS12 */
> -    { 0xe1017000, 0xfffb7000, 0x800, "McBSP3" },		/* CS14 */
> -    { 0xe1017800, 0xfffb7800, 0x800, "MMC" },			/* CS15 */
> -    { 0xe1019000, 0xfffb9000, 0x800, "32-kHz timer" },		/* CS18 */
> -    { 0xe1019800, 0xfffb9800, 0x800, "UART3" },			/* CS19 */
> -    { 0xe101c800, 0xfffbc800, 0x800, "TIPB switches" },		/* CS25 */
> +    { 0xe1010000, 0xfffb0000, 0x800, "UART1 BT" },      /* CS0 */
> +    { 0xe1010800, 0xfffb0800, 0x800, "UART2 COM" },     /* CS1 */
> +    { 0xe1011800, 0xfffb1800, 0x800, "McBSP1 audio" },      /* CS3 */
> +    { 0xe1012000, 0xfffb2000, 0x800, "MCSI2 communication" },   /* CS4 */
> +    { 0xe1012800, 0xfffb2800, 0x800, "MCSI1 BT u-Law" },    /* CS5 */
> +    { 0xe1013000, 0xfffb3000, 0x800, "uWire" },         /* CS6 */
> +    { 0xe1013800, 0xfffb3800, 0x800, "I^2C" },          /* CS7 */
> +    { 0xe1014000, 0xfffb4000, 0x800, "USB W2FC" },      /* CS8 */
> +    { 0xe1014800, 0xfffb4800, 0x800, "RTC" },           /* CS9 */
> +    { 0xe1015000, 0xfffb5000, 0x800, "MPUIO" },         /* CS10 */
> +    { 0xe1015800, 0xfffb5800, 0x800, "PWL" },           /* CS11 */
> +    { 0xe1016000, 0xfffb6000, 0x800, "PWT" },           /* CS12 */
> +    { 0xe1017000, 0xfffb7000, 0x800, "McBSP3" },        /* CS14 */
> +    { 0xe1017800, 0xfffb7800, 0x800, "MMC" },           /* CS15 */
> +    { 0xe1019000, 0xfffb9000, 0x800, "32-kHz timer" },      /* CS18 */
> +    { 0xe1019800, 0xfffb9800, 0x800, "UART3" },         /* CS19 */
> +    { 0xe101c800, 0xfffbc800, 0x800, "TIPB switches" },     /* CS25 */
>       /* Strobe 1 */
> -    { 0xe101e000, 0xfffce000, 0x800, "GPIOs" },			/* CS28 */
> +    { 0xe101e000, 0xfffce000, 0x800, "GPIOs" },         /* CS28 */

dito

>       { 0 }
>   };
> @@ -4025,18 +4025,18 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
>                                 0xfffbd800, omap_findclk(s, "clk32-kHz"));
>   
>       /* Register mappings not currently implemented:
> -     * MCSI2 Comm	fffb2000 - fffb27ff (not mapped on OMAP310)
> -     * MCSI1 Bluetooth	fffb2800 - fffb2fff (not mapped on OMAP310)
> -     * USB W2FC		fffb4000 - fffb47ff
> -     * Camera Interface	fffb6800 - fffb6fff
> -     * USB Host		fffba000 - fffba7ff
> -     * FAC		fffba800 - fffbafff
> -     * HDQ/1-Wire	fffbc000 - fffbc7ff
> -     * TIPB switches	fffbc800 - fffbcfff
> -     * Mailbox		fffcf000 - fffcf7ff
> -     * Local bus IF	fffec100 - fffec1ff
> -     * Local bus MMU	fffec200 - fffec2ff
> -     * DSP MMU		fffed200 - fffed2ff
> +     * MCSI2 Comm   fffb2000 - fffb27ff (not mapped on OMAP310)
> +     * MCSI1 Bluetooth  fffb2800 - fffb2fff (not mapped on OMAP310)
> +     * USB W2FC     fffb4000 - fffb47ff
> +     * Camera Interface fffb6800 - fffb6fff
> +     * USB Host     fffba000 - fffba7ff
> +     * FAC      fffba800 - fffbafff
> +     * HDQ/1-Wire   fffbc000 - fffbc7ff
> +     * TIPB switches    fffbc800 - fffbcfff
> +     * Mailbox      fffcf000 - fffcf7ff
> +     * Local bus IF fffec100 - fffec1ff
> +     * Local bus MMU    fffec200 - fffec2ff
> +     * DSP MMU      fffed200 - fffed2ff

Could you please align the addresses here?

...
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index 2e45266e74..9333bf7cdb 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -55,16 +55,16 @@ struct OMAPI2CState {
>       uint16_t test;
>   };
>   
> -#define OMAP2_INTR_REV	0x34
> -#define OMAP2_GC_REV	0x34
> +#define OMAP2_INTR_REV  0x34
> +#define OMAP2_GC_REV    0x34
>   
>   static void omap_i2c_interrupts_update(OMAPI2CState *s)
>   {
>       qemu_set_irq(s->irq, s->stat & s->mask);
> -    if ((s->dma >> 15) & 1)					/* RDMA_EN */
> -        qemu_set_irq(s->drq[0], (s->stat >> 3) & 1);		/* RRDY */
> -    if ((s->dma >> 7) & 1)					/* XDMA_EN */
> -        qemu_set_irq(s->drq[1], (s->stat >> 4) & 1);		/* XRDY */
> +    if ((s->dma >> 15) & 1)                 /* RDMA_EN */
> +        qemu_set_irq(s->drq[0], (s->stat >> 3) & 1);        /* RRDY */
> +    if ((s->dma >> 7) & 1)                  /* XDMA_EN */
> +        qemu_set_irq(s->drq[1], (s->stat >> 4) & 1);        /* XRDY */
>   }
>   
>   static void omap_i2c_fifo_run(OMAPI2CState *s)
> @@ -74,25 +74,25 @@ static void omap_i2c_fifo_run(OMAPI2CState *s)
>       if (!i2c_bus_busy(s->bus))
>           return;
>   
> -    if ((s->control >> 2) & 1) {				/* RM */
> -        if ((s->control >> 1) & 1) {				/* STP */
> +    if ((s->control >> 2) & 1) {                /* RM */
> +        if ((s->control >> 1) & 1) {                /* STP */
>               i2c_end_transfer(s->bus);
> -            s->control &= ~(1 << 1);				/* STP */
> +            s->control &= ~(1 << 1);                /* STP */
>               s->count_cur = s->count;
>               s->txlen = 0;
> -        } else if ((s->control >> 9) & 1) {			/* TRX */
> +        } else if ((s->control >> 9) & 1) {         /* TRX */
>               while (ack && s->txlen)
>                   ack = (i2c_send(s->bus,
>                                           (s->fifo >> ((-- s->txlen) << 3)) &
>                                           0xff) >= 0);
> -            s->stat |= 1 << 4;					/* XRDY */
> +            s->stat |= 1 << 4;                  /* XRDY */
>           } else {
>               while (s->rxlen < 4)
>                   s->fifo |= i2c_recv(s->bus) << ((s->rxlen ++) << 3);
> -            s->stat |= 1 << 3;					/* RRDY */
> +            s->stat |= 1 << 3;                  /* RRDY */
>           }
>       } else {
> -        if ((s->control >> 9) & 1) {				/* TRX */
> +        if ((s->control >> 9) & 1) {                /* TRX */
>               while (ack && s->count_cur && s->txlen) {
>                   ack = (i2c_send(s->bus,
>                                           (s->fifo >> ((-- s->txlen) << 3)) &
> @@ -100,12 +100,12 @@ static void omap_i2c_fifo_run(OMAPI2CState *s)
>                   s->count_cur --;
>               }
>               if (ack && s->count_cur)
> -                s->stat |= 1 << 4;				/* XRDY */
> +                s->stat |= 1 << 4;              /* XRDY */
>               else
> -                s->stat &= ~(1 << 4);				/* XRDY */
> +                s->stat &= ~(1 << 4);               /* XRDY */
>               if (!s->count_cur) {
> -                s->stat |= 1 << 2;				/* ARDY */
> -                s->control &= ~(1 << 10);			/* MST */
> +                s->stat |= 1 << 2;              /* ARDY */
> +                s->control &= ~(1 << 10);           /* MST */
>               }
>           } else {
>               while (s->count_cur && s->rxlen < 4) {
> @@ -113,26 +113,26 @@ static void omap_i2c_fifo_run(OMAPI2CState *s)
>                   s->count_cur --;
>               }
>               if (s->rxlen)
> -                s->stat |= 1 << 3;				/* RRDY */
> +                s->stat |= 1 << 3;              /* RRDY */
>               else
> -                s->stat &= ~(1 << 3);				/* RRDY */
> +                s->stat &= ~(1 << 3);               /* RRDY */
>           }
>           if (!s->count_cur) {
> -            if ((s->control >> 1) & 1) {			/* STP */
> +            if ((s->control >> 1) & 1) {            /* STP */
>                   i2c_end_transfer(s->bus);
> -                s->control &= ~(1 << 1);			/* STP */
> +                s->control &= ~(1 << 1);            /* STP */
>                   s->count_cur = s->count;
>                   s->txlen = 0;
>               } else {
> -                s->stat |= 1 << 2;				/* ARDY */
> -                s->control &= ~(1 << 10);			/* MST */
> +                s->stat |= 1 << 2;              /* ARDY */
> +                s->control &= ~(1 << 10);           /* MST */
>               }
>           }
>       }
>   
> -    s->stat |= (!ack) << 1;					/* NACK */
> +    s->stat |= (!ack) << 1;                 /* NACK */
>       if (!ack)
> -        s->control &= ~(1 << 1);				/* STP */
> +        s->control &= ~(1 << 1);                /* STP */
>   }

Could you please align the comments in this function?

...
> @@ -214,41 +214,41 @@ static uint32_t omap_i2c_read(void *opaque, hwaddr addr)
>               /* XXX: remote access (qualifier) error - what's that?  */
>           }
>           if (!s->rxlen) {
> -            s->stat &= ~(1 << 3);				/* RRDY */
> -            if (((s->control >> 10) & 1) &&			/* MST */
> -                            ((~s->control >> 9) & 1)) {		/* TRX */
> -                s->stat |= 1 << 2;				/* ARDY */
> -                s->control &= ~(1 << 10);			/* MST */
> +            s->stat &= ~(1 << 3);               /* RRDY */
> +            if (((s->control >> 10) & 1) &&         /* MST */
> +                            ((~s->control >> 9) & 1)) {     /* TRX */
> +                s->stat |= 1 << 2;              /* ARDY */
> +                s->control &= ~(1 << 10);           /* MST */
>               }
>           }
> -        s->stat &= ~(1 << 11);					/* ROVR */
> +        s->stat &= ~(1 << 11);                  /* ROVR */

Please align in this hunk, too.

> @@ -351,14 +351,14 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
>                             __func__);
>               break;
>           }
> -        if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
> -            nack = !!i2c_start_transfer(s->bus, s->addr[1],	/* SA */
> -                            (~value >> 9) & 1);			/* TRX */
> -            s->stat |= nack << 1;				/* NACK */
> -            s->control &= ~(1 << 0);				/* STT */
> +        if ((value & (1 << 15)) && value & (1 << 0)) {      /* STT */
> +            nack = !!i2c_start_transfer(s->bus, s->addr[1], /* SA */
> +                            (~value >> 9) & 1);         /* TRX */
> +            s->stat |= nack << 1;               /* NACK */
> +            s->control &= ~(1 << 0);                /* STT */
>               s->fifo = 0;
>               if (nack)
> -                s->control &= ~(1 << 1);			/* STP */
> +                s->control &= ~(1 << 1);            /* STP */
>               else {
>                   s->count_cur = s->count;
>                   omap_i2c_fifo_run(s);

dito

...
> diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
> index 0157c9be75..b32d55dc54 100644
> --- a/hw/misc/omap_clk.c
> +++ b/hw/misc/omap_clk.c
> @@ -30,170 +30,170 @@ struct clk {
>       struct clk *parent;
>       struct clk *child1;
>       struct clk *sibling;
> -#define ALWAYS_ENABLED		(1 << 0)
> -#define CLOCK_IN_OMAP310	(1 << 10)
> -#define CLOCK_IN_OMAP730	(1 << 11)
> -#define CLOCK_IN_OMAP1510	(1 << 12)
> -#define CLOCK_IN_OMAP16XX	(1 << 13)
> +#define ALWAYS_ENABLED      (1 << 0)
> +#define CLOCK_IN_OMAP310    (1 << 10)
> +#define CLOCK_IN_OMAP730    (1 << 11)
> +#define CLOCK_IN_OMAP1510   (1 << 12)
> +#define CLOCK_IN_OMAP16XX   (1 << 13)
>       uint32_t flags;
>       int id;
>   
> -    int running;		/* Is currently ticking */
> -    int enabled;		/* Is enabled, regardless of its input clk */
> -    unsigned long rate;		/* Current rate (if .running) */
> -    unsigned int divisor;	/* Rate relative to input (if .enabled) */
> -    unsigned int multiplier;	/* Rate relative to input (if .enabled) */
> -    qemu_irq users[16];		/* Who to notify on change */
> -    int usecount;		/* Automatically idle when unused */
> +    int running;        /* Is currently ticking */
> +    int enabled;        /* Is enabled, regardless of its input clk */
> +    unsigned long rate;     /* Current rate (if .running) */
> +    unsigned int divisor;   /* Rate relative to input (if .enabled) */
> +    unsigned int multiplier;    /* Rate relative to input (if .enabled) */
> +    qemu_irq users[16];     /* Who to notify on change */
> +    int usecount;       /* Automatically idle when unused */

dito

  Thanks,
   Thomas


