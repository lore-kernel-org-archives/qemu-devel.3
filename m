Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022A7C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgsm-0008OG-Do; Tue, 02 Apr 2024 12:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgsk-0008Ng-8P
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:21:06 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgsg-0001jB-ID
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:21:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56df42c2773so923411a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712074861; x=1712679661; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o1peXpmt2C+W5FT88tgPQZyqintO0tvvupH2V4zg3hM=;
 b=BcTXK0S2Q9R52F0ExKJKRnssi2P/k86HquenDANnYFDN4wNvJB3kFecW8Pd/XOZBw3
 Q35Mau7zsb7LXA95kuorxPDqlrLMHQ+G1ZDQXNVWNTgES+2r2CnmG4oF1zdEh2UhrUPA
 uRJJTzZH2kJKSoeX1c79idhGu6uRYxw8YFhUB+/F3WuQ0CcvqzGeSvXiUKiyNDPFVrNV
 8M0x8fqfBycxNAg4tOwaQwzUiOJt2R/3lfKnP7ALxcMQocsU3z71NgDeXXtMSDVZJ+ou
 muMekk9vjthacURTTvNvj4j7PYFgWYTP2QBlNacolc0eo+TzhgQ/fSpmCh3fvJzszyV0
 UmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712074861; x=1712679661;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1peXpmt2C+W5FT88tgPQZyqintO0tvvupH2V4zg3hM=;
 b=TAEahYgWve36MJRqKNJPs4J2MUxuC89vJ7Bpn3jgKdc1uKARovTQ3VLtvWhH1AbATY
 D2FKyzmRb0jU8RhiHu1YBWJR32+f1D4mSBybxf9Vw/BKhs7ZFxlK4SgxIpMUnEdz3syK
 sWFxtv4G3yrLsOlGeXNS/yAR0QGG3vTR6LcBBJy9UREM8/LTjwzj99IgQGizyA6F9mBi
 vwGWVo33gICvLuZS9MtBRzMaFnYYJpi9QmOytEgk+ioirPccFB4SmikvM1BYzlOqA4fI
 rGzx6C80SmU7/JYeXDV8JyK+8Ei24hfU7+3/kl1ihjkyqlJAZwsqK5D09V/+deDFrogv
 37Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGbd0P7WbgYG/UbNyhnu/98yb0Y5f3t85IPZ55EQ+EwRwK0XOs507HNGg54XUGZUruEcTLYD3JYaRsC7nbmjOF/BUMBlI=
X-Gm-Message-State: AOJu0YxrZhTTv4SwA8XJ1XqbvUx6adlMP4ELIEoZaTB/+zLEh/8zQ8xS
 F8ac/+Ecbr/rWfrJsqdfkPoFeMfhb24YnqJPQZUH3PlakGwtiKlOFIB1O4qIQJNMy03ZijZrD/r
 /EYOF+9YoBnbtH+wPmFHC2N3+xz+WVEvaJ7O+kg==
X-Google-Smtp-Source: AGHT+IHb47danqkn7++32MbL0ip0fySSD+lZMVFnm78Deap6/GnJKGF3c4cPPb7IiQxgYeT44VHCZb4HBrPbG0j5s9Q=
X-Received: by 2002:a50:a6d4:0:b0:56d:b6dc:c8fe with SMTP id
 f20-20020a50a6d4000000b0056db6dcc8femr295214edc.0.1712074860702; Tue, 02 Apr
 2024 09:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-15-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-15-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:20:49 +0100
Message-ID: <CAFEAcA-L6T61zSYKDEE22oUxpG6Cc6bTNWBn0Lkgx4xYmUfHhg@mail.gmail.com>
Subject: Re: [PATCH v11 14/23] hw/intc/arm_gicv3: Add irq non-maskable property
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sat, 30 Mar 2024 at 10:33, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> A SPI, PPI or SGI interrupt can have non-maskable property. So maintain
> non-maskable property in PendingIrq and GICR/GICD. Since add new device
> state, it also needs to be migrated, so also save NMI info in
> vmstate_gicv3_cpu and vmstate_gicv3.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v11:
> - Put vmstate_gicv3_cpu_nmi and vmstate_gicv3_gicd_nmi into existing list.
> - Remove the excess != 0.
> v10:
> - superprio -> nmi, gicr_isuperprio -> gicr_inmir0.
> - Save NMI state in vmstate_gicv3_cpu and vmstate_gicv3.
> - Update the commit message.
> v3:
> - Place this ahead of implement GICR_INMIR.
> - Add Acked-by.
> ---
>  hw/intc/arm_gicv3_common.c         | 38 ++++++++++++++++++++++++++++++
>  include/hw/intc/arm_gicv3_common.h |  4 ++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 2d2cea6858..189258e1ca 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -164,6 +164,24 @@ const VMStateDescription vmstate_gicv3_gicv4 = {
>      }
>  };
>
> +static bool nmi_needed(void *opaque)
> +{
> +    GICv3CPUState *cs = opaque;
> +
> +    return cs->gic->nmi_support;
> +}

I think we should call this function gicv3_cpu_nmi_needed()...

> +
> +static const VMStateDescription vmstate_gicv3_cpu_nmi = {
> +    .name = "arm_gicv3_cpu/nmi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = nmi_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(gicr_inmir0, GICv3CPUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3_cpu = {
>      .name = "arm_gicv3_cpu",
>      .version_id = 1,
> @@ -196,6 +214,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>          &vmstate_gicv3_cpu_virt,
>          &vmstate_gicv3_cpu_sre_el1,
>          &vmstate_gicv3_gicv4,
> +        &vmstate_gicv3_cpu_nmi,
>          NULL
>      }
>  };
> @@ -238,6 +257,24 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
>      }
>  };
>
> +static bool needed_nmi(void *opaque)
> +{
> +    GICv3State *cs = opaque;
> +
> +    return cs->nmi_support;
> +}

...and this one gicv3_nmi_needed().

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

