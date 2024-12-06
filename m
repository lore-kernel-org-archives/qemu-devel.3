Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1063DE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYKp-0007GW-S6; Fri, 06 Dec 2024 08:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYKl-0007Ft-0X
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:25:27 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYKj-00024V-0b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:25:26 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ffc86948dcso21609581fa.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733491523; x=1734096323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh2kmXKx7DBmmLuNdd/kPr1NgTRTLmZ5J03mhylEpiI=;
 b=H7SYa5jQsbmrCys04HlXMsaJquZSBdUVNW9wQDZWb16z+cEsrGCTXksLiAfJ3jRF8X
 ke+ndCBYsontq2h8KzeqtvNQCeG6LQ29dGX3Sn5Z/vlAjZGXCf5e6CpnCwHq7J2nqXSg
 Rh0pzHk4wJlrFykibpeAUwhTdSStlo1n0xBmKnKeVsIcanqf13y0LPPIlLtN3LJ6SRog
 mM07e4Kjmtvcp4c/73j9doyzNEYumhYqhgQoekQPe6WIZXhZ7lcu0D7zjM3xx0omiMDK
 Zz4Oyl4l/8rqrCTzn+3LGBHxzmGSg/q++XesHDM3thAf0XWIchRWASldS5YYcMoedjyg
 Hg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733491523; x=1734096323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vh2kmXKx7DBmmLuNdd/kPr1NgTRTLmZ5J03mhylEpiI=;
 b=px9rpQZA74rZZSx24V3kd9C5fFuoKQnf035CR3Q923PwmvFWfFMHzfhM8Y4pQQWtlp
 /TgUmoD5Kwdd7lhqUKqv0BPn+oWL6cmD6eEOwXYBQwJAcW1q7wUsUHJL+R7sBtpFZJZD
 Axop1KOBOj6Tt2o4ShCjmXolqYxbqTvDqzC6zPIxep2EwnqgJHCZt3UOdDKE/xHZW6YP
 ejxuJ7/eimqgYhgEuBf1xX/wqST0F/UhEsk0BfiyzRBIW6ZFAPKD6nOmzDz0P6Ul6LWV
 M85IqO369LChtAR99gUejgRj6c6YdAv9lcwM/BDj6XiU5gmUTOjYzZJKOce05y88UEwS
 V5+Q==
X-Gm-Message-State: AOJu0YwfLSoGpkCMKNTwK51EJdoTPKIqCS3IxiGl1TrlYsXHlpnldlv6
 jOZ0bawntNiBXL9zT925AnkhlvkX6KZHhBZPni8v/+Bj1qf+6Zu8je3nhvA23+Xf1wuxv7Sqcq3
 NR2feMtB3oK+RpLTJEMoHfsLIKHnJzmkX1ZX94A==
X-Gm-Gg: ASbGncugh0ia013jxhVvObquiGGJ6M8NoBls6Nfk6NVn8euV+SWODtewiot+XtBAq4h
 buNwLvbWRSbrvO+DvJtJJbWfK4JVsvSRh
X-Google-Smtp-Source: AGHT+IFH3uKB3TAhqyuGE9vEqsqKJ1Q4P4on1nROFdpgnyGeZ37qVQRIDektEKHAXisbjrjiLfqc2d7ZjGN67u3bHW4=
X-Received: by 2002:a2e:a888:0:b0:300:8ff:d93f with SMTP id
 38308e7fff4ca-3002fc46122mr13436491fa.22.1733491523069; Fri, 06 Dec 2024
 05:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-30-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 13:25:12 +0000
Message-ID: <CAFEAcA96o0NPtgeRGCdKYML_k0S5OqZJ6pU2PGcB7OzOFVG5+g@mail.gmail.com>
Subject: Re: [PATCH 29/67] target/arm: Convert FRINT{32,
 64}[ZX] (scalar) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Sun, 1 Dec 2024 at 15:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_fp_1src_single and handle_fp_1src_double as
> these were the last insns decoded by those functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 150 ++++-----------------------------
>  target/arm/tcg/a64.decode      |   5 ++
>  2 files changed, 21 insertions(+), 134 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

