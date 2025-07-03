Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25B7C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJIP-0000ze-CP; Thu, 03 Jul 2025 08:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJH6-0006jk-Dy
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:42:51 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJGt-0003Zb-4b
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:42:44 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e4043c5b7so54808377b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751546553; x=1752151353; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnAvfqlFdC/Hotog3YjSC/GOMBzdYbRz/WSMurliVYI=;
 b=ht2gHAHHaz/ELy2Y0oxAvQf6B6rdYL4Tt7sGFvwWyKJPju23uu9B5Iiv8Ol4lvHWJh
 0SAfC5OawLBhVqokbbWpOfTTKhppz2k1erE1vn0rkCQAPE7qmLHVj+gDusHQYybDpKND
 h2SfamWGd50H6L+uQpcRn4cB0S6yWFiMsxkRnnAdiFEk8Hl/l1ZtvmTwvRCRIFP2eXyZ
 0l1dzq8WUa/+XXrYoFl8ZKiXHAYQvYDpgoWF7lHZLaMvkQJUVVLrmAW3ORl8Fi0XToiz
 Go8kj+AAqdxoVmBkCpB6VnwTgjACDGcm/XwgH1QXYAZInxHnoBHM/NlIqcx4ZTOJ6jxU
 PUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751546553; x=1752151353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZnAvfqlFdC/Hotog3YjSC/GOMBzdYbRz/WSMurliVYI=;
 b=hu53I9fqMqziMq7emqJXr3UxhLC3ly+8N8WRyMx4Fl3pbMznJmPJlLgpxJyDnkf6i6
 3TwirZW2jemEejCqS7wla2n07bkYjbxtwDtjmH9l5WumlY/d1bIoxgCuMdegj22zJqEt
 HnU/5Lnq6pWrTiOmfoLBLSoeZuppFJseYJsBlTxjRm9C6kqyQKAv3e6j9g/XDzT+sl7B
 tkbkvJ6diC8CEfzbPwFg6iFREKFxf1D6gHxFMzG/biaoTuXYUz2MCFXYT2DU3ClgJIQu
 G9uCOMGBTEcCDJl6HkrWLJ4QP8c2Qj1/K+X2Kbd+KbxIeX5hke68RBo/FJRvitvW0T5l
 WVpQ==
X-Gm-Message-State: AOJu0YzHd5nUjoz4L+fgp2u0yutOUlu1ZfTT35h1NCVXMY6QrWbrTEzz
 UbRcw4p5W5J5CFDUjmLHDIzyDaHvYoZrjbpn5rQI89ZRpcBOgYBFQhY+JprgU2VXkZhDMP7xr6x
 +W2x2+38fxZbJAWSol+VsT4pPq1qt2ZbNB2FSyJeQIg==
X-Gm-Gg: ASbGnctP2wHuw0aBlKIP37zic0cmD85CLGEx5h3V+YtMgRLY4cfxYGgQCbwx8fJsmAC
 n89SckEKG/28TgK7NSOxyM6bkp/1jvigmV4xnKsQWMFelUiyRK43WrEo/NqKOyK1JxkJR1NMFso
 KWu6XRh4VNNiHf53HjEpWYgjhjLLR+Dea+IfrkBfom+D2Vdjav+fl3rhA=
X-Google-Smtp-Source: AGHT+IGwNu+Jg4o3xPbg1vRLOg0JAh+TwKDwKcChi7o3EA2wWXteyOGAkbnh5Fy803WAdfvg/JyHugEDTV4tQXaK9xI=
X-Received: by 2002:a05:690c:6608:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-7164d467d9bmr87649087b3.25.1751546553274; Thu, 03 Jul 2025
 05:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-90-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-90-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:42:20 +0100
X-Gm-Features: Ac12FXyKa-H0v56oPo_H9mi3YqAWh39rBr-vIxDbeNTlrFsFUf0Mck0yQppJk2I
Message-ID: <CAFEAcA_1+R93TR350TmieVZbYErQ+g34RyPWjd-8rRatJm-Sug@mail.gmail.com>
Subject: Re: [PATCH v3 89/97] target/arm: Implement LUTI2,
 LUTI4 for SME2/SME2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
> index 236927c640..ad3bfabc34 100644
> --- a/target/arm/tcg/vec_internal.h
> +++ b/target/arm/tcg/vec_internal.h
> @@ -337,6 +337,22 @@ bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
>  float32 sve_f16_to_f32(float16 f, float_status *fpst);
>  float16 sve_f32_to_f16(float32 f, float_status *fpst);
>
> +/* Extract @len bits from an array of uint64_t at offset @pos bits. */
> +static inline uint64_t extractn(uint64_t *p, unsigned pos, unsigned len)
> +{
> +    uint64_t x;
> +
> +    p += pos / 64;
> +    pos = pos % 64;
> +
> +    x = p[0];
> +    if (pos + len > 64) {
> +        x = (x >> pos) | (p[1] << (-pos & 63));
> +        pos = 0;
> +    }
> +    return extract64(x, pos, len);
> +}

We added this in patch 79, I think, so we could put it in
vec_internal.h from the start (with the comment).

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

