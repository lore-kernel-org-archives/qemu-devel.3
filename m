Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42963E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFZ4-0001c8-4J; Thu, 05 Dec 2024 12:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFYu-0001ar-LU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:22:48 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFYt-0007U1-A2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:22:48 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0e75335e3so1266305a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733419365; x=1734024165; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KvK6fM6cedGc08xRIHN/JKs4YH6IwlIlR//3KzThG2M=;
 b=t9pSOtkgi2UTyq/QSHAcayErvzwipymsoMbGpdaz6n3SSkzOHODmPDeBFFYlu73kyv
 jJxYYYFDYy0BKza//TG00+yzR+m3DQEJmo6Gaki70f/GoPA3dRq5wphvKOx93x+b6gOC
 zCsq2tg/58hqS+YP/6xyUcL1WPKchP5hw5n0h3accI8lquZImXotY4SpLmyiaCF4YSVM
 YulqsuXuqnDShWUlBPfizXAypxdoLi5DeM6uEedmq/RbmX7mugi8qcAo/v7Lzg4UQJR4
 ucJqktKMdbgU5MPO8IrLaauKTqXFFGW/uCiTpVrSamB5vkGteQwbTTy2ni6NbyEwr35k
 fMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733419365; x=1734024165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvK6fM6cedGc08xRIHN/JKs4YH6IwlIlR//3KzThG2M=;
 b=YU7XyUrIKs+SmhFk0KS4bnW8sUk07rH2nhFkHwEspLEsS6bYenPHr8nPq1+MHB30PI
 sk2QXWPmeaaanS4sQ2W9NL8xc/ZB/ZaqJvIsDtEzzJj42S9gnFmkpZk2unq4Fhjd68HW
 yx4nRvopJ4yOws8QAYQni62Sg0kHSUF142TSMcEL4r0bbVzQKqR2eMCE5kE/irmdP4Sq
 vsdKL+NdLWF8ogzYoEx5sHuIeFu382kPkA4U58a384JVzJO7oax1yzjYpXgrwLWTZmHM
 GFi/e/oQrbqsODda72mP5eK/q6kg+qWUyIHS51s1qGyXvNYGbAgd7xT5tGEWBTmpK/sf
 7O9Q==
X-Gm-Message-State: AOJu0YwjkG53EnW5j+UzbGaVeQrADwXVDLBz9QbXJiTHJd/Xj3lNQR7J
 lvzhvPpmwG4elUSngVeagCNSL/TABHpOzHht3QVLlQMxgDZBHld0E50I9fv8shJetZdmlY24sMc
 UpxmP3ZbR51iGboQ2CLDeby5YbIPJMEfu8K4rjg==
X-Gm-Gg: ASbGncvswQEgXor0dh645v3X0ef2Qllk+5xzqowCtEi8YkriMwdix+UlaLesHYFQmkq
 yz8M0EmY/WDE6O8vltVO9yKBG7zi2r5AZ
X-Google-Smtp-Source: AGHT+IE63xViF4u+0rXCn/gL7GB+wdX93Knp8jgSGuH2oH0AKxMxPOPQlHS5XfejYUYUfJJb6fpKoYnZR0zybWOsTzc=
X-Received: by 2002:a05:6402:274d:b0:5d0:c67e:e26a with SMTP id
 4fb4d7f45d1cf-5d10cb4df78mr9300483a12.1.1733419365185; Thu, 05 Dec 2024
 09:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-8-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:22:34 +0000
Message-ID: <CAFEAcA87Mx45zLTnSGOQDRp0SqP0EtaD3WMzDNLf+TF4xXuY7Q@mail.gmail.com>
Subject: Re: [PATCH 07/67] target/arm: Convert RBIT, REV16, REV32,
 REV64 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 1 Dec 2024 at 15:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 137 +++++++++++++++------------------
>  target/arm/tcg/a64.decode      |  11 +++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

