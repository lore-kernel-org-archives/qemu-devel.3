Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9F0C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVqZ-0000fw-Lm; Fri, 07 Mar 2025 06:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqVqM-0000ZW-77
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:26:18 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqVqK-0002Ei-D0
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:26:17 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so1315411276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 03:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741346775; x=1741951575; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOK2wMqRHr6/hSzcqXdcXJAdXpuECsfBNMO2ReS3m/Q=;
 b=UITdE6sWNnoKtLsjXOGwgsjSC1NvpY7aVLtaS/G6q/PfnrA1D1X/FdMR2T7T/2sNAQ
 dYV00uknl/fTQhY4RzO4Kj0gvJ/ChRPy66dDoI1KdS63GTYw3bc/kKEYOuM9TgvdMyRP
 uce6Ecvlbubj26dvqpLKMlB75WAnkCesqgs1DB/XxeklpFu4zfUOh6pXbQ3Hl4pE37z7
 vvikzW7XMIryIQs9/YJffgcru98I93vpEWnScIy63d7aLmYXtMq2BU4xq6WWq8OKmmqU
 t4Sllsg5uWe1Ip1oMHCBgA9SaCDKrUEJ264c0ZOhYEBcoIx8syXbN3/LY55LY+1WpiDG
 o28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741346775; x=1741951575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOK2wMqRHr6/hSzcqXdcXJAdXpuECsfBNMO2ReS3m/Q=;
 b=RYuUYgKZJg3jgvk4PIYPS2RMVkAX9j72Ky7OsAu5mqglV36BhLujxBmaKhgyx6KabN
 d2T4Lj1ztkNG8otliMyCYlWgvaCrwgBECRwF9jJLHpFKKtEmyvyR8msXhbAQ2GMDCheX
 XMJN+rth5v2ongFmAtXjVdwgJvxHRQXVEqkwbXN1IJ3Dj1pJ3TslpeASCgDbb0e69aXm
 D6zz/cK58Z07oM6jC2tI42Eje8a58/u0gbH/EjQbpPzuJrwbwR55JHiuS3JgQ5714Snq
 k4XiECAkMyFrzjEpqW/72tBZ+fZnjswqF4eDzlyFt6RPDhoo9y8I9WIiBf5w/BSETZZm
 tMbA==
X-Gm-Message-State: AOJu0YxzZNZ3v1Csmzb1rM54YGXpt6dDRHlpG/NMiD/qhk11sE3OKgsg
 WLpfQm3TnBd8gC0kLYfNxK6iK54WB5oOcJ4/9ZrUdgD5rLDAU4zReDVX/PoA41dyDig280u3IYE
 OCUjMB4TlfOZtRGqGAtdMhfiv7FynPvZTFpNjTcJxLcEXWIK0
X-Gm-Gg: ASbGncttLpw6tizDZ5bn1tzcJGGUBlAxZcfSShPAR52q8e+CG81O44k3GDOObyT88UV
 4QpVC/Qn9BEZqG4RYBDNJ1eC3PnZXNjrNhuAklgSxE2GS6mWGGtco1mI3LAKmgRQ+yXt2nav5RG
 sScodmQvhKFWIsf+VWGcd5JzgpWe4=
X-Google-Smtp-Source: AGHT+IHuN8MkL3OWTWUn+aYE/rrev7J+Xu/CJO/P2GJhXLqYamKUCRuGJM0CuPe1CtpIapzl2IBCuVnLI0K0i/mR5JM=
X-Received: by 2002:a05:6902:e0f:b0:e5d:cdc6:7acf with SMTP id
 3f1490d57ef6-e635c1d7c51mr3390272276.31.1741346773551; Fri, 07 Mar 2025
 03:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
 <20250218212103.2024039-2-keithp@keithp.com>
In-Reply-To: <20250218212103.2024039-2-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 11:26:02 +0000
X-Gm-Features: AQ5f1Jr9PBIWCN2WTL0UbbcocRlynuJ8GTjttUXd3DIvA7tnT4X0y9ww01jRB8s
Message-ID: <CAFEAcA9zrjdDoJ_ag+8QCkET4b+MTvnTjzXY_wurYT1KPZAmdw@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/rx: Set exception vector base to 0xffffff80
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Tue, 18 Feb 2025 at 21:22, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The documentation says the vector is at 0xffffff80, instead of the
> previous value of 0xffffffc0. That value must have been a bug because
> the standard vector values (20, 21, 23, 25, 30) were all
> past the end of the array.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/rx/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/rx/helper.c b/target/rx/helper.c
> index 80912e8dcb..55e2ae4a11 100644
> --- a/target/rx/helper.c
> +++ b/target/rx/helper.c
> @@ -90,7 +90,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
>          cpu_stl_data(env, env->isp, env->pc);
>
>          if (vec < 0x100) {
> -            env->pc = cpu_ldl_data(env, 0xffffffc0 + vec * 4);
> +            env->pc = cpu_ldl_data(env, 0xffffff80 + vec * 4);
>          } else {
>              env->pc = cpu_ldl_data(env, env->intb + (vec & 0xff) * 4);
>          }
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

