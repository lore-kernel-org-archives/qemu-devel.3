Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594FCE77178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFQj-0007Tf-MU; Thu, 05 Dec 2024 12:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFQh-0007T7-Jx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:14:19 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFQf-0001qS-9y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:14:19 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aadb1so1550109a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733418854; x=1734023654; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LHyw/+HCoHi272pvctLC/N+j10m7JzXddfL1kSJFX5w=;
 b=r8BbEMTV63ammVENXSDnKG3kKiTvnHb0y+lF1uSSH/JnO4tjpqOp+nlwF0vjsaIHE9
 x6TGpcU5gPpotKllm0Qfx4q3KfYoeJbm3UoKas63wDKZz+pJNGRi70IpU3TFyh1sCNXi
 lt/hm+2SXLq4uA6cWEdy8y/15RGbvUpCuhUF96l3EkXf8CtfciTK61Dzat0idxt4MYbi
 xj4xzaY2vcOafPAlpE/cxPhS/BM4sP7As8oDvSbU7qJMec9G5mwid6GJ6u73N7Zt//PS
 4OLZGfCTvY6qHGgyXErUCE4YwNwNMnDOdXTrcJ5Y9GAM9EzPGZxK+Xh7gP0wur0P7LpA
 Tv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733418854; x=1734023654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHyw/+HCoHi272pvctLC/N+j10m7JzXddfL1kSJFX5w=;
 b=mrSjGssuR0mYCss/q8diIt+ZdFsksc0jojLsB/JUvDJb0vkM29JUc1l02VSUv2yreZ
 jDIOb8Zxe4alDzuvxK7oGrEwXHPDvSrlv+aFHvBYt2dznre7WfTpKp6fCa77YFa8yQUO
 Z6uPRoHdVBqQGERIp9+grqzQWbqGn1Im9gU4VknkriElURMuTxZCR600EjNAsY1cmg49
 Mf+znvrRTLXHTYWq4Zg065gSre4e8BQackd9ANg2QSp2Z/ilpxPu+aQGabmYUvryr3Ax
 6gOxAf1Bwz4hWdDgVDGtdNRxMUdcponMBohUysGBewp+ZJLj3mMGirLWaDwMwzDVdCnH
 0duQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeAGywvzcrcrERXlz9gW5snBgN/qXk/2O6yNyxruvDulsMnlJTdr+oB9QjCFOvX/93pjpOL1k2e0v/@nongnu.org
X-Gm-Message-State: AOJu0YzwkMAcCCmtoI1LGoQujZdrxKpJzaGEVeVoBERjgHA6nJ9Nxrxu
 5xS+qTUeGuhUaArCwAhwxxA76ZZ8D8OfRMmcFtzHzByrDh77bdlcJNv/9NTsH76FiJW/g4YBLGY
 o6ZhNF/yADm8FeEqub+8Bgs1QDPsOJ2xPF2ZyCQ==
X-Gm-Gg: ASbGncuUMxN107NFSjAQPvZbklnx8xdBbV6z5sAecwM/g1ZaxRki1XK5k8xokaL9VS0
 sAuIbjw+mJYeCWxNtgHnWW174n4dHJZdDHNje
X-Google-Smtp-Source: AGHT+IEeVLAQ9TFUoSBqH/QkeA8X9DmpsFZV6VFA15VYSgeYAUc+ky+SneH7W1VVJvEUaQLc8YolMjpBV+RUIzxIOXk=
X-Received: by 2002:a05:6402:1513:b0:5d1:22d2:8965 with SMTP id
 4fb4d7f45d1cf-5d122d28b58mr4416435a12.30.1733418854483; Thu, 05 Dec 2024
 09:14:14 -0800 (PST)
MIME-Version: 1.0
References: <20241118114806.1119-1-andrew.yuan@jaguarmicro.com>
In-Reply-To: <20241118114806.1119-1-andrew.yuan@jaguarmicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:14:03 +0000
Message-ID: <CAFEAcA_ZvRJNkv=Xop7fyzJxNAQ_3uLcLxa4w3khQdAoaSH2YA@mail.gmail.com>
Subject: Re: [PATCH] hw/net: cadence_gem: feat: add logic for the DISABLE_MASK
 bit in type2_compare_x_word_1
To: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
Cc: edgar.iglesias@gmail.com, alistair@alistair23.me, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 18 Nov 2024 at 11:48, Andrew.Yuan <andrew.yuan@jaguarmicro.com> wrote:
>
> From: Andrew Yuan <andrew.yuan@jaguarmicro.com>
>
> As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Doc Rev: 1.3 User Guide,
> if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
> mask_value in type2_compare_x_word_0 is used as an additional 2 byte Compare Value

I didn't find a copy of the datasheet to review this patch against.

Edgar, Alistair -- could you have a look, please?

thanks
-- PMM

>
> Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
> ---
>  hw/net/cadence_gem.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 526739887c..7ec5dbaa9c 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>
>          /* Compare A, B, C */
>          for (j = 0; j < 3; j++) {
> -            uint32_t cr0, cr1, mask, compare;
> -            uint16_t rx_cmp;
> +            uint32_t cr0, cr1, mask, compare, disable_mask;
> +            uint32_t rx_cmp;
>              int offset;
>              int cr_idx = extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
>                                     R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
> @@ -946,9 +946,24 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>                  break;
>              }
>
> -            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> -            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
> -            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
> +            disable_mask =
> +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
> +            if (disable_mask) {
> +                /*
> +                 * If disable_mask is set,
> +                 * mask_value is used as an additional 2 byte Compare Value.
> +                 * To simple, set mask = 0xFFFFFFFF, if disable_maks is set.
> +                 */
> +                rx_cmp = rxbuf_ptr[offset + 3] << 8 | rxbuf_ptr[offset + 2] |\
> +                         rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
> +                mask = 0xFFFFFFFF;
> +                compare = cr0;
> +            } else {
> +                rx_cmp = rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
> +                mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
> +                compare =
> +                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
> +            }
>
>              if ((rx_cmp & mask) == (compare & mask)) {
>                  matched = true;
> --
> 2.25.1

