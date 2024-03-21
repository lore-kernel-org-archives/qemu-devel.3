Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBAC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 13:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnIJC-00070m-29; Thu, 21 Mar 2024 09:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnIJ7-0006yd-Su
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 09:18:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnIJ4-0004Wp-Jp
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 09:18:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56bcbf40cabso758784a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711027085; x=1711631885; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nnG5L9F/+cQzw4vKRYiCun9aRHIZliQRrI9DJfbrDXE=;
 b=xXk5v+//hA64cSEGtmSUuGi0czW9j6zAxdJwd6j/Pz/idX+J+9/l5R2FGke/nDbi2x
 OHdGPscvq+8s+Zzv+r2s3A577nvZ5ZNibR8ytKem/RMb/yoJQiTNd/Xs8ubEH1Y280qy
 TjzRp7mGpV46l0lhdroyY4OL/kEArAw8/xEVapi1gS6j+Ibo7xPlbWD5/fTqIvzJ8/Cb
 tTqTXvMPe/u4wV4DXGjsBicoMIaCpIlu3fmlS5juHBsY3kKEkZ7IgMR0rxKNXFzhC32F
 Um5wEwZHtafoH89aqJH1tOk4kwitCBruKrYkXb0bKkMQHiF/84eWVZlBU+7tRggcBlAs
 pZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711027085; x=1711631885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nnG5L9F/+cQzw4vKRYiCun9aRHIZliQRrI9DJfbrDXE=;
 b=NNIA0gRG1zqRAqvwPYZM+f5QMSG0UboDPdXdgtES2jSyN0CDYT7SfRxLzoh+rF+v42
 JrVICZ4OUFX6sWXp4+WrLneDvEM2M4tA4tETfB9Xf12iTv6j/mJ4k226kiUOMdjWeWkq
 CAt1lYtfYFUTE8Ay4B+4qrMROMljex2QLx3iOA6kYOhPElVcoONhSiECqFmHlTyQ1fvz
 Al4ej9KeaC1lbzbkC9Bhe8lCA2O8dz6Yb2hTfLDhhTHeSLMgJLtX3+QMH0saHCP/Uwuq
 kRGmzk99Vxq2CwI1/CejVI3WYwVnb+sRB7VrgRBUZ172TXEotPTnovECfZvP525fENPS
 7ZRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa6O/FvkQAqoRxfB/rCCjulcOuUUllJnI8bLLhSxlPN1KhUyMjbUsGFOjPEMDcAg1Hp49VLW1RfjiZmwyXipxpsRCJq4k=
X-Gm-Message-State: AOJu0Yzr6gvMnUuIF2s0zTR9RLJCFRR+gY4gitz8eWbJENXqe8lGJNM3
 7azzQUaeEwoD+ZandTGT1Xn2CqV/n7GFereN30KIL9PwjtprBfPjaY+Atc95haYjHOqdcqqWu4d
 WHub6VM+ToIK8gb9YIdBHd7GDKexVoFkfZ/Rt8w==
X-Google-Smtp-Source: AGHT+IGNZIeITnin7wx+HvywAJw8setb8J3OVT7FhYVcawI7RqM2TeHPbi+RG3CFW6xl4b5aAvhRqve/UW2RGFQEltY=
X-Received: by 2002:a50:c04e:0:b0:568:93f:36c6 with SMTP id
 u14-20020a50c04e000000b00568093f36c6mr1290283edd.22.1711027084764; Thu, 21
 Mar 2024 06:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240318093546.2786144-1-ruanjinjie@huawei.com>
 <20240318093546.2786144-14-ruanjinjie@huawei.com>
In-Reply-To: <20240318093546.2786144-14-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Mar 2024 13:17:53 +0000
Message-ID: <CAFEAcA_VWko1zNvbdGNBgHJ3TiC1duiQ0wZLJUnDhLomULVayQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 13/23] hw/intc/arm_gicv3: Add irq superpriority
 information
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 18 Mar 2024 at 09:38, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> A SPI, PPI or SGI interrupt can have a superpriority property. So
> maintain superpriority information in PendingIrq and GICR/GICD.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3:
> - Place this ahead of implement GICR_INMIR.
> - Add Acked-by.
> ---
>  include/hw/intc/arm_gicv3_common.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 7324c7d983..df4380141d 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -146,6 +146,7 @@ typedef struct {
>      int irq;
>      uint8_t prio;
>      int grp;
> +    bool superprio;
>  } PendingIrq;
>
>  struct GICv3CPUState {
> @@ -172,6 +173,7 @@ struct GICv3CPUState {
>      uint32_t gicr_ienabler0;
>      uint32_t gicr_ipendr0;
>      uint32_t gicr_iactiver0;
> +    uint32_t gicr_isuperprio;

This field stores the state that is in the GICR_INMIR0
register, so please name it that way: gicr_inmir0.

>      uint32_t edge_trigger; /* ICFGR0 and ICFGR1 even bits */
>      uint32_t gicr_igrpmodr0;
>      uint32_t gicr_nsacr;
> @@ -274,6 +276,7 @@ struct GICv3State {
>      GIC_DECLARE_BITMAP(active);       /* GICD_ISACTIVER */
>      GIC_DECLARE_BITMAP(level);        /* Current level */
>      GIC_DECLARE_BITMAP(edge_trigger); /* GICD_ICFGR even bits */
> +    GIC_DECLARE_BITMAP(superprio);    /* GICD_INMIR */
>      uint8_t gicd_ipriority[GICV3_MAXIRQ];
>      uint64_t gicd_irouter[GICV3_MAXIRQ];
>      /* Cached information: pointer to the cpu i/f for the CPUs specified
> @@ -313,6 +316,7 @@ GICV3_BITMAP_ACCESSORS(pending)
>  GICV3_BITMAP_ACCESSORS(active)
>  GICV3_BITMAP_ACCESSORS(level)
>  GICV3_BITMAP_ACCESSORS(edge_trigger)
> +GICV3_BITMAP_ACCESSORS(superprio)

This is the state behind the GICD_INMIR<n> registers, and
the GIC spec calls the bits in those registers NMI<x>,
so I would call this bitmap nmi, not superprio.

This commit adds new device state, so it also needs to be migrated.
You'll want to add a new subsection to vmstate_gicv3_cpu which
is present if the GIC implements NMIs, and which has an entry
for the gicr_inmir0 field. Similarly, you want a new subsection
in vmstate_gicv3 which is present if NMIs are implemented and which
has a field for the nmi array.

thanks
-- PMM

