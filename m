Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF09C52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJ2V-0001ac-AB; Sun, 11 Aug 2024 20:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJ2R-0001YR-8z; Sun, 11 Aug 2024 20:35:55 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJ2O-0000ll-PV; Sun, 11 Aug 2024 20:35:55 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4f6d35d59ccso1190126e0c.1; 
 Sun, 11 Aug 2024 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723422948; x=1724027748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzrYYabttT4T0ztN/LBhOT/UhSAY0dsl54ZCAE6alZQ=;
 b=WB3lHVnxAXkTHogc0gx0VDBhMEfb4TR/3IVbAGbGUJeKQheTPL0nSOrs3Vjtz/KjqD
 oAamgxG56yffvMqG+nH5RjD/ZMFgK6yLTcpW8ZslbohijuPWqMGuzmGhy4qacaigkebs
 sqSE0B8+vXqgVx9tb8v+rSGPz7NEe3I05lerbFrl9LY+iINL/znnOEOiqKC0P6inlIB0
 Gmbkjf0tuPLnbLg1kjyGFesBULGqCQ7A3TeZ+wuMWnjNnTkpSstD1536sI+ULFMA0+DX
 ZSPV+eJqZfJ2ErrGz8925VbV38lFYmDFntZeErqnO4Xws8TCSP3J4A2ZoyDJTOvEvF7q
 s1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723422948; x=1724027748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzrYYabttT4T0ztN/LBhOT/UhSAY0dsl54ZCAE6alZQ=;
 b=gBYHk9At+BMn9IGT5D/2V/pYOEq8B7eaYKoUZkBVq4CFRbEPuVAap/6o/HxSDZuuuy
 uGnHCI6rcpAYsdFEVrbGA/ylX5vqQshT25zc9iQpshOT4g3N8njTZv5zfbL8gZPHJ3Bn
 nCfnaLtcCpbC66E2uOioGk42E0woZzQqrRHBV/Gi3yIdR8Ahh87pLhvK4Brx6+xERNld
 y1aYhdj9MlZsxATvXmsia87EZb/wl5U1zzqFryMxdzGcClRmofnDPpqvraqUbec8qhwu
 FKtCIfrdTmYNqcPycbhMIcwcIKDR4QUg5v350KF0HlinoLwUT5bas49SAaWRV0EqTkhe
 ExzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXflo+bzJO1WwEPzB6DQWNEF8jCuVTE41BvCOWbLPhjoKrxQvJC0Sdazp/A4pkrTPMkfAEwu3XQU+KD04fi61rfeHGbSMyR4OwTvcQdpgIvG7W9oHhPlCgpOSuuDIHQxLDP8PtTITX5CxU39K1VRKty7CfH6w==
X-Gm-Message-State: AOJu0YzT4PS7Ex1WyncWa7QjFCtbTpBVHyj9ynV/eJe08w5DBUcEig4e
 3zibjVhAp3B95wzx7uEgA/m+lSsTdptqSfASpWtxr2oUn132F2aQZMSIUi7t+DFmJusAUa7/D2l
 FLGp+bbEki4KMnp+pC9fCrSqu9wI=
X-Google-Smtp-Source: AGHT+IHm0GTgC3wMt8A1F0buXlD4g3XacumzoPqkK6O3iagTTl2Ygs4dwp6bwklEN7joGxTFOuFtuX8TkUYFxsHUy1E=
X-Received: by 2002:a05:6122:46a4:b0:4f5:3048:ee20 with SMTP id
 71dfb90a1353d-4f912bfb3a5mr5482158e0c.5.1723422948293; Sun, 11 Aug 2024
 17:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240419110514.69697-1-philmd@linaro.org>
 <e70bbb7d-7048-493e-b359-88472e73c199@linaro.org>
 <518c457b-1f02-4d19-a3cc-a1fc6ec81170@tls.msk.ru>
In-Reply-To: <518c457b-1f02-4d19-a3cc-a1fc6ec81170@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Aug 2024 10:35:22 +1000
Message-ID: <CAKmqyKM8Y_TWL9568i6qRJ5df3_Muuv-1U+5i0VHKzp9Xa06XQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Use get_address() to get address with
 Zicbom extensions
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <cmuellner@linux.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Zhiwei Jiang <jiangzw@tecorigin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 12, 2024 at 3:49=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 19.04.2024 14:37, Philippe Mathieu-Daud=C3=A9 wrpte:
> > On 19/4/24 13:05, Philippe Mathieu-Daud=C3=A9 wrote:
> >> We need to use get_address() to get an address from cpu_gpr[],
> >> since $zero is "special" (NULL).
>
> Hi!
>
> Has this change been forgotten, or is it not needed anymore?
> It's been quite some time since Apr-19..

It's not needed anymore,
https://patchew.org/QEMU/20240514023910.301766-1-alistair.francis@wdc.com/
was merged instead

Alistair

