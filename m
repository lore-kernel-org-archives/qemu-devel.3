Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F427C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPkz-0001bu-Kq; Mon, 27 Jan 2025 09:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPk9-00011R-NL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:05:38 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPk3-0000Re-8P
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:05:35 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso6804757276.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986728; x=1738591528; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0f/+bc0kd6n9shuuZMp6H7ri9BWeXQE2RqF5LIcHtr0=;
 b=CCdYfZdIlZwI74cnpVG6PvFb3ZkWMBKERh09FvzYNLkV6/m1IuQwB65ujx4CCLiDgo
 86pPvNVdlvu1RGXl5jK2QX/dktDycRfbdw9WbIETPlH35D2/MbljoGpGMXa+2AsqOrF8
 L/2/LdV4WSgs2fJXwj/QiaKK9T8kznDF1sLVsbdkVbqJzVaLUGEcBlsE0CsE96lxEGrR
 Rx8wGHl/rsrqFDFHYWTfYQUpXgGGaZaE4F3K2um+SvnNI1LvR1qJEmYYEBcl83bGXxHd
 VnIlI1hlpVn+nT7R1Z7MzX+iDJAW/QN4hUirWSgQpLCJ6vjsSshZXspFhj2egDnl81rW
 cRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986728; x=1738591528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0f/+bc0kd6n9shuuZMp6H7ri9BWeXQE2RqF5LIcHtr0=;
 b=Fa0UfLAHIAk/dYhRZu+NDJV/ZU9CnG9jtQZbeWL1brHavfK/stZiub7z5N4uSULH6f
 /7zcCGyi8sW5YQvrJ36bm27nYJh6yaPII4qqY9KYnVlVGX17o7fE1/bKxM1KUoEHzrcn
 Hf79JU6gmXzYt7EKXFulgRc36zL+p1uL6PpZ1bDjCt+dwRDO4qG11dgZ+OaYG91qtN2K
 NGKOqaVa7prk+FxFUGlR3tuvlUy8ej6pk7Lan0dntX6qWnRS6on+SCLjSAw5ciozk5FP
 p7dnO5CiKcAfXuJL3VR6vQVe7aYpgp3I7ahBpJ53HgeZtF16Oi+OP8D348WGKyON1zWp
 f1qA==
X-Gm-Message-State: AOJu0YyLeNdIc0vHpRooYvmLXccVh3EKr9KmIp+p5dWFDIbP3qgGvJOy
 ftfKpQLJmsB2LdXjfKtWCn+kaPIOWIpIuPV1cd44ljxhlChYPFSWt9zLgV/iADg9gnOv29Al8lW
 BaFTevY0eKYyMHNAS7k+AtnQw0YwDIlFs9ehqrg==
X-Gm-Gg: ASbGncuG5t/S0NiUfvlUTbIJYmmRGtR0l+CkoLHrEf50H2PNEj3dbV422b9MDpoejuR
 rQNvvT1P8OOhiF8j8LCYRu3NAA7fHhR+z8mFvoM/tN05rIeR2fTHSruqxQ0SPOd4=
X-Google-Smtp-Source: AGHT+IGIgQBJPIIW7DZ3QNrLxEHMFwGrTzK3TEE4sVx+xxZPcVrcPETCaw0E0pMW5s844bbH5wOpbEaFSrChAbHg6yA=
X-Received: by 2002:a05:6902:2e01:b0:e58:141d:b6d3 with SMTP id
 3f1490d57ef6-e58141db753mr15722459276.16.1737986728483; Mon, 27 Jan 2025
 06:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-7-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-7-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:05:17 +0000
X-Gm-Features: AWEUYZlLgtIT2NpJoGkfIArakE_T3vp17KcCkow5g2Jv9sBxZMDSq4BZh342iUo
Message-ID: <CAFEAcA_u17=F2bE42bAfHkpq_ffLPaeEZ+0i6QitX=huMVB_pA@mail.gmail.com>
Subject: Re: [PATCH 6/9] hw/arm/stellaris: Map both I2C controllers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> There are 2 I2C controllers, map them both, removing
> the unimplemented one. Keep the OLED controller on the
> first I2C bus.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 21 +++++++++++++--------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

