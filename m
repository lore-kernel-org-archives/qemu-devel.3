Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47E4CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsB0-0007fB-GI; Thu, 28 Mar 2024 12:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsAa-00076N-2v
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:00:00 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpsAY-000326-I6
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:59:59 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56c12c73ed8so1462258a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641586; x=1712246386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcldUbAIFy0PkGeg8xYS7bg6xqgF5gW9ha8ipSjrP8g=;
 b=sCG2HIRnVlZl6DF9R0M4WtC5GXFJ6ewJsHYwv3R0xmN0dsIoQ/We2mD39zyd+G2aGj
 /AyZDN/L5QWFXzSKg0Vy5ltem+qquOuiBJSVVc5MNUZn0CYzjSzAc6JcHzGBr2mQFyDO
 Xftd7UrL8PwoVXLBPn8j9OfIxy5QOf2vOPM8pKJrs+DFl36TrbN3CKDK5bYSXZopUi76
 1Ba4E/KLPq2fhAK75YKTJUOrkbYccRRXMLXLq/9jFHISFsqz4Hbx6+qlQmg4jHNZpCaC
 VOIrH0SSg6Kz66t0UtB5TmecqsrIFRtVcN6ksfwwA91s/t5pWT8uZl3wo2vqeQlUi3TE
 utrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641586; x=1712246386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcldUbAIFy0PkGeg8xYS7bg6xqgF5gW9ha8ipSjrP8g=;
 b=eANLxHA/XI79t/sFbqWZEpoGrjRgf3vAsbQyP9+xUcwYzUPQbdjiDqumEsn1FF/joi
 +3g7me8FYsr8/tX4akH7k/ziAzgdoarVv2fb9jywWewE7wsTzQYCOX65RTcsgdX2jt3J
 z4B1TlGpASNu+SEn7S+82irB48huvYPduVBoGxbWmuso2oKx/LrOQBzniHXDj0S7yIXS
 a9en1VGJMt9FwZoCqANdmuBGfxrwb4X0Pj6UeBN3f4OdL7NGuYsBe00FtqKmAwfr0jKp
 Om8kej6wFCA1WfVmKpLRBOG1knsg4QZ4Ma0V6VhajcROdX4svrcxMisFfJ6lncDPbkoU
 hgSQ==
X-Gm-Message-State: AOJu0YwjBAoCwbgj1mXbJYn9QRlF5s9VeYOuh9C2TlwV7KFCi3Rg6MCk
 B+lZ1gSOhOQeUP+/dnq0fzoF8oQadLAeJiEX7oqYyff1WhKaUCUrroP8ANRWGkQOJ88NJAYr2A3
 XA4dwH216iddk9aZvNoe00l1nf6twW3AmKo1szA==
X-Google-Smtp-Source: AGHT+IEmjDAM79HoHLaaQ7ALihkEVl+qkKnYGk1McDPhValat/pzOMyaM+THYZDjPHu0x1OGNi/oRsk69/luq7hF1tY=
X-Received: by 2002:a50:baab:0:b0:56b:d973:3a0e with SMTP id
 x40-20020a50baab000000b0056bd9733a0emr2694348ede.12.1711641586086; Thu, 28
 Mar 2024 08:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240324165545.201908-1-arnaud.minier@telecom-paris.fr>
 <20240324165545.201908-4-arnaud.minier@telecom-paris.fr>
In-Reply-To: <20240324165545.201908-4-arnaud.minier@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 15:59:35 +0000
Message-ID: <CAFEAcA8V9+gbFS=YmwDK7r_e4nXuZOf-z6JaVd+RJPVu1AMvxA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] hw/char/stm32l4x5_usart: Enable serial read and
 write
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sun, 24 Mar 2024 at 16:57, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
>
> Implement the ability to read and write characters to the
> usart using the serial port.
>
> The character transmission is based on the
> cmsdk-apb-uart implementation.
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>


> +/* Try to send tx data, and arrange to be called back later if
> + * we can't (ie the char backend is busy/blocking).
> + */

Coding style wants the opening "/*" on a line of its own.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

