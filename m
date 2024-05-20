Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB26C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9439-00077U-8F; Mon, 20 May 2024 10:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9432-000763-9C
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:31:32 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s942v-0006Y5-Cv
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:31:31 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e3fa13f018so36834601fa.3
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716215484; x=1716820284; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQrsIrTGha1sEB4quc4TB9X8cKtObMYxA2+AiK9KBeQ=;
 b=Zxd9beCWjtgk0LPJKqSdNC8aekk0bq9eo59xEq8IobStGJ3ksw+y8l71KHcGr7n+D5
 DwzXBFMYzgU7KxKirToRTpx5SuwP7+qBFQQLuU71qWZRsRjLd3nVlUHmGNv2176CtX91
 2mL28V+LT5dzzHSVhY/nRnqtlgo/wvABDgyRA90a/xZjklk9huxrrGvlXzy8F/LiwAFM
 CsNNKKBREeJaZEG8RIOSA8ZlJCYQGUWGiTuFQbxLhftmJUwjXeB1JVxxboYYvsAI4uwC
 Y9gnRPULDIuKwlxlOtUw0AE7M5q4MKLxkvO/zhja808nvV8Cw20mNo/+iQ4+T4vBARyO
 tU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716215484; x=1716820284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQrsIrTGha1sEB4quc4TB9X8cKtObMYxA2+AiK9KBeQ=;
 b=Xvaqi6lVeaqUZt7igcx2B35e3PyLvTAE2lo6EYQCrgt6xZ4POwE2bp741r5lmvv8O4
 gn2PGhdtfQGlCjG7QmGafHZHcL45apVwhdbK72ELK8yTME5Ge9Ux8LjtEkvy9yLJOBGc
 Wsumy+sEWgplfzANY1v+bv9M2/DmE5xVgni1oKh2q8g4Q+G0VYO76/4WoEIXsRA5UUUw
 yb+QJOiBspbCoIXv+XuqGMk6GpNHJWO42L8AlYeg50IEIBgDUYUt6XV7gR0aivENUQzL
 m68G0bDmuKu71xcfCo9wRbM/vxpgGf6eL2BXP64G7nu1Q003hJQhiwZ8S/H5q5AKdlNE
 22bQ==
X-Gm-Message-State: AOJu0Yw9xKVNTgN8fQbdI1Ncxmd6qaVC8eUw7H2FxPFGJNjSE7Ja9Ope
 FhK417niCYq4bQ9fhN4hD0qKKxAvIvIn7i3kDquzvBFGfsAfUWvyFb091LuzeayFBEl8tasduyh
 pvWaMcWcuyGwPPOdBYS9t1ycOgCE/gNg/pK93Zw==
X-Google-Smtp-Source: AGHT+IG5Sqd4SQHKeOIDeKvdHjYMdX2JoZxBFxR0M+H26EsnivtjXr0XUkAunaslMKZxiGtuRZtwRjuWjFJNUfSotDM=
X-Received: by 2002:a2e:b04b:0:b0:2df:e705:7b4 with SMTP id
 38308e7fff4ca-2e51fd2dc7cmr193284831fa.10.1716215483616; Mon, 20 May 2024
 07:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240512102013.211127-1-ines.varhol@telecom-paris.fr>
 <20240512102013.211127-4-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240512102013.211127-4-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 15:31:12 +0100
Message-ID: <CAFEAcA8T52urOcc9vsPtO5R8ZBTHqGeLJBtmRmZGvRJMwSAyCw@mail.gmail.com>
Subject: Re: [PATCH 3/3] hw/arm: In STM32L4x5 SOC,
 connect USART devices to EXTI
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
> The USART devices were previously connecting their outbound IRQs
> directly to the CPU because the EXTI wasn't handling direct lines
> interrupts.
> Now the USART connects to the EXTI inbound GPIOs, and the EXTI connects
> its IRQs to the CPU.
> The existing QTest for the USART (tests/qtest/stm32l4x5_usart-test.c)
> checks that USART1_IRQ in the CPU is pending when expected so it
> confirms that the connection through the EXTI still works.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

