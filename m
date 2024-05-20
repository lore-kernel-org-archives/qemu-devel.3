Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1072EC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s942n-00070y-6l; Mon, 20 May 2024 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s942h-00070T-Ai
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:31:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s942f-0006Wz-Rs
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:31:11 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-574bf7ab218so8030060a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716215468; x=1716820268; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgF02fbQr9/mZN29egUpXZwL8PXdvcdglJ0V3IEev0E=;
 b=ooKOybPMM2vLGFKQ96JkUwHTh0nK3IT+Kf69IcXeq3CkVzaSRqfeCUkASvMqRDNuoH
 tOfuTWvfANmIEiPskRuFyE6h3xKDyZ6wwxvLVTr7ql5iBqRUqlwn0YLKwAbaJsrrs9QS
 cXDL1+H5pFT4rPazYKlwbXmUbC/G8M+vaGxm0O+T0PUym5iCbJz59nkXwWjpu4V46Iif
 OhHRIaFSg4H0oylEAGAcU8MYc+KkkOCDYd5dA2osJzhPbLDBvAvUKmo4kN7/p0/6K+NN
 hWkabTu2x/4Lo9BR+uKQw54JBhPFkPOQy4MeGhUgQDD0sZt3zXVmZB/uHZ9lmrqI2d+i
 VIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716215468; x=1716820268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KgF02fbQr9/mZN29egUpXZwL8PXdvcdglJ0V3IEev0E=;
 b=LQmv778Pwu7k9WCsei49m24IltNOQqcacEq8Lg+SG5ssx3KYUGbUs9SRb0O2a8yYPD
 4HNIWjiN6KTIp4rgYJJUNk/4stt4x+dUSdGIz0PjtdK4KJ18ffZwGT1uOsjZU3o2KRkw
 K6QGcx6Mjq8MF894sQsAH6oVMpap9wsgP4WzvZhgKs7aGWO4Br7f3625d3yPMcHpLixA
 nyUNIx4KgWQubw+oKZBxjBQgsoxMiOFf0pxoSZ1vGhHmN/n3xXwQubbBtKusbcHa3OdS
 GLbRWxcZaUVqqAehJ+VJ7X/cg7+Huua64p1Mjclxun9q3K2RNR6o76y3G65bp6Vp5o3R
 pfug==
X-Gm-Message-State: AOJu0YzX2BNWNcB0SVoTq3jHybLq65uOOuzW0BUdA56gML9aKFKpDm5B
 Tx0mizC2JjjKs/I6Ti1Nf+Tsxvfy9gpWRlZ5uIky4EaN8kaj9XdY6z9xlaNou7Q70NMiFh1szeC
 O209wpRQPcPkd1aLJIvp+udNPL0LD61fEbR5Taw==
X-Google-Smtp-Source: AGHT+IFstigdyLDAE5UycZJQXH3wfX20r+M/XzONBBJLG8oGHN/GeTDPnpEJfDvzC30jNj/42gzipOYq92Aovl+BIVs=
X-Received: by 2002:a50:b410:0:b0:574:f657:e0e with SMTP id
 4fb4d7f45d1cf-574f657198bmr10211328a12.25.1716215468377; Mon, 20 May 2024
 07:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240512102013.211127-1-ines.varhol@telecom-paris.fr>
 <20240512102013.211127-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240512102013.211127-2-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 15:30:57 +0100
Message-ID: <CAFEAcA9hcRYi9R_amp047UtJi_ieS-Ga9ZJH63WkTxAy+rdc2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/misc: In STM32L4x5 EXTI, consolidate 2 constants
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Sun, 12 May 2024 at 11:20, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> Up until now, the EXTI implementation had 16 inbound GPIOs connected to
> the 16 outbound GPIOs of STM32L4x5 SYSCFG.
> The EXTI actually handles 40 lines (namely 5 from STM32L4x5 USART
> devices which are already implemented in QEMU).
> In order to connect USART devices to EXTI, this commit consolidates
> constants `EXTI_NUM_INTERRUPT_OUT_LINES` (40) and
> `EXTI_NUM_GPIO_EVENT_IN_LINES` (16) into `EXTI_NUM_LINES` (40).
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

