Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257D3E6C5FB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 04:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIKsO-00038Q-Mv; Mon, 02 Dec 2024 23:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIKsN-00037e-97; Mon, 02 Dec 2024 23:51:07 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIKsK-0004bh-G7; Mon, 02 Dec 2024 23:51:07 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-51514257e57so1286667e0c.2; 
 Mon, 02 Dec 2024 20:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733201463; x=1733806263; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odV2vuKVPf68vpESp2woAnSjZVs92TQQ9NfTXPrEWYY=;
 b=a6Fh/Vwpm8uFQmeqGDl1NqN/V6jitJqkZ7qJmFzNl+NS39YXY/Ktjj8hGNuVUEgiYa
 CHjRCOz42kneTLwkXaJIffNA6eSbxpe/u810adG8B22ZM09uHYYBS+QDz1AL3+k2DRiw
 nWZL11wQopuzw1K8ic6vVQn0Xz+MXYvdAkc1qR6sK80JE4jp52hVWJixveymUv6ttf0N
 D62L8W5eWXpbI6SfPHaKQie1lITvxVSiX5nAjmPfyg3pmKwpHuG1eq1VIhkc5oT4ja91
 i5Imb6sSHYCBPR7GU7SfPS9v2oggaeuheBWrbnvA29/5qljlY4iSiQjGilsviPBiQgNX
 Ei6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733201463; x=1733806263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odV2vuKVPf68vpESp2woAnSjZVs92TQQ9NfTXPrEWYY=;
 b=RD6zKyEyL/V0Ng42lQBjpfGutd8H+W+VrOTzLGLjZ8oAs1fJLniyYDKEr3gyXqM+Z+
 8e1V6AlolQnNBKJ1aT7tWxOkss0/hyKFzA/IPXglV/zW5jPSxK5Pif98Vap8JYRwUYXr
 nTQ1eCO2xuO08B8ANctdkanQBnBWQpP8avpiHN7jZgHVkpBcDe8kHvzpguzwE+uyHjwi
 mjwJA55GNWRbZEMjIeeqJjC6IQJy8ztn7nD7FNMt1IDPAaTQI2vi7mZXRg/KVakfyS51
 TZ88qN15meo1Yo0Q60x57UBV6tdg5EPYh2a6/U6Sg7wCVH/0pBC9mS/Gx50llulyIdF8
 2LkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB3m0VCEMldEH9/LYsaRAdRGiZlVimi25QTCLPpBz+ArhSCH6si1yGIIPYApkVUDOrh64QSJk1m+Of@nongnu.org
X-Gm-Message-State: AOJu0Yw1Lch1A+nb83PbZMMkfjehveY9oeRI5rkbOk4s6CKv79TNLm6f
 oJvt+HD1Is0qYAGl2182zWVGkIXCjpWpmpmLuCaZULbznvI6V7oZQBBZa2cKQXnpChejcSzgCg9
 nRPAYgUIu6umeSOly5yHkUOTL6I0=
X-Gm-Gg: ASbGncu9P8lwTFxnDY/LR5gGehs30rD09q0h4dlGkMNki297L7sfbab7TCNcNdUZnxw
 qPRQ3wjZD83ldCOFqmxZOsQ4vecbWp1N+
X-Google-Smtp-Source: AGHT+IHV2Lezwz9U1hNHJBlQzs+MoZQV0i4KhNWC6eWa12KNx4Nap9S2xBbOGA+6+hHNqpbcyqHbNmE5qKZPKOOUNQE=
X-Received: by 2002:a05:6102:3f13:b0:4af:98c6:bc98 with SMTP id
 ada2fe7eead31-4af98c6c2afmr1344348137.20.1733201462760; Mon, 02 Dec 2024
 20:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20241129154304.34946-1-philmd@linaro.org>
 <20241129154304.34946-2-philmd@linaro.org>
In-Reply-To: <20241129154304.34946-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 13:50:36 +0900
Message-ID: <CAKmqyKPPrzo47ePZhNtrA3byVoJ48CCXpVgV71m3106ct-fYQQ@mail.gmail.com>
Subject: Re: [PATCH-for-10.0 1/3] MAINTAINERS: Cover RISC-V HTIF interface
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Nov 30, 2024 at 12:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The HTIF interface is RISC-V specific, add
> it within the MAINTAINERS section covering
> hw/riscv/.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> IMHO 'RISC-V TCG CPUs' should cover target/riscv/ which are
> the accelerator-facing implementations, and each machine or
> device in hw/riscv/ should have its own section. Not going
> to clean that in this patch.
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1c4abed65..046e05dd28d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -324,8 +324,10 @@ S: Supported
>  F: configs/targets/riscv*
>  F: docs/system/target-riscv.rst
>  F: target/riscv/
> +F: hw/char/riscv_htif.c
>  F: hw/riscv/
>  F: hw/intc/riscv*
> +F: include/hw/char/riscv_htif.h
>  F: include/hw/riscv/
>  F: linux-user/host/riscv32/
>  F: linux-user/host/riscv64/
> --
> 2.45.2
>
>

