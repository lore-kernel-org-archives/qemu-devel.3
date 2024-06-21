Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE39C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfep-0006yn-7Z; Fri, 21 Jun 2024 10:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKfen-0006yA-0K
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:54:29 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKfel-0003ST-Ab
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:54:28 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57d06101d76so2236240a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718981665; x=1719586465; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3fP49IwYmOmxiZc205wh0d/2qiV14oVeNZDM25aDPE=;
 b=AkU4bzbdXGxPL/A80e0f/5gAFrU6Xn/ik7ZlBO5gyNLYprZ/t0nyAGMILMo6wkunRk
 QHyVQxsRg/D/MEoW9nnHRVmMPfo4MwmeBDQfGn1t8FEHppoGkVUWTfz454Qf0Xn+Q8cb
 9ody7n8F+L2wMY8mQ2zLA6eWCzp46JFJjrKZ337O5Au9XeE25Xu7Sln5u8mSBqCuSV8E
 olMijF6VV5VEyw4ai1hWYfYvXQ+chz921qOXIlMXQgR6rTNq8Wk32Ps5Z4fBIrWrd2Ia
 7QQEpVoRs3tE38DtYqbdJpJIwRGZYiDCl+X4iVHusz1RdRt+xM4nwIYu18aMPhwPW+2S
 YZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981665; x=1719586465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3fP49IwYmOmxiZc205wh0d/2qiV14oVeNZDM25aDPE=;
 b=c/q9GBCyS+GnA7yV58D5/isMPrxIxoYquYAQFwQdNQmL19ZzfYfL58YM6glQKuYHng
 X9slaX0myTePh2BmrMHIPBhV4Iq5UfGwP7bR1SEWPG99Y0jTAG+Jp/kRJq+n9s8wz2sJ
 hFQgWBef41Ggd4eWX+3y4dJU5UEVDxwoqMA7WqeUcp55VVcUkpApNi0gbr/GqyPKWdRa
 tmHDePSbUIto3QzcXSOIEDzfXXgUs/AKIjH99l/Mxst7Fz2RklpPRHmnMwspILYowKK6
 d7Qw2l3cg7+u796iZaEYP+fWasfzewrlA1asHGcf+DgH0icT/xnhePkbiRy94UYYcmGR
 xUSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyd9FyVGseoZ2gqA+1hVZa+iatp5wDlTnWTcKEy4oAeuP6e+EhXTVlfvqB3tT7nQLNQ4yYpa4CFJkCkx8riBFcDb+UINE=
X-Gm-Message-State: AOJu0Yy++lu8rZ7XZQIfXSYrm6aCpHyG3qGt/i9mOiS0RZg3BqKDeIN7
 9hEC3XLW/DIGueCnvJcLDOy8+dCEfqyqdIYCJZtk5UoHwYtkhi4BaOMBiXYMSR1QfglEn99YOUY
 g5+pL4bo1XzJym5DGiqcxo6O8teSM0QH0mzTQ1Q==
X-Google-Smtp-Source: AGHT+IGLpn7AtmYk8Iz16gywzfGX5I7mVF6ZVqdXBkMrsYLqJzSbEHLYBxnsEQ8etozJ46XaPDjlf1w287R+ZhHvt1k=
X-Received: by 2002:a05:6402:1744:b0:57d:105c:c40c with SMTP id
 4fb4d7f45d1cf-57d105cc49fmr4227865a12.24.1718981665003; Fri, 21 Jun 2024
 07:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240618163701.3204975-1-zheyuma97@gmail.com>
In-Reply-To: <20240618163701.3204975-1-zheyuma97@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 15:54:13 +0100
Message-ID: <CAFEAcA_BB7Lw357iLZZbCfvhnH+8G2qyfVrs8dhP_i-mnwnvOw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/misc: Set valid access size for Exynos4210 RNG
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 18 Jun 2024 at 17:37, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The Exynos4210 RNG module requires 32-bit (4-byte) accesses to its regist=
ers.
> According to the User Manual Section 25.3[1], the registers for RNG opera=
tions
> are 32-bit. This change ensures that the memory region operations for the
> RNG module enforce the correct access sizes, preventing invalid memory ac=
cesses.
>
> [1] http://www.mediafire.com/view/8ly2fqls3c9c31c/Exynos_4412_SCP_Users_M=
anual_Ver.0.10.00_Preliminary0.pdf
>
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=3Dqtest, -m 512M -machine smdkc210 -qtest stdio
> readb 0x10830454
> EOF
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v3:
> - point to the device specification

Applied to target-arm.next, thanks.

-- PMM

