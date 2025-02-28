Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C952BC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 06:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tntVV-0000HT-AG; Fri, 28 Feb 2025 01:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntVP-0000E6-OH; Fri, 28 Feb 2025 01:05:51 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntVN-0002zF-MZ; Fri, 28 Feb 2025 01:05:50 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86714f41f5bso760500241.3; 
 Thu, 27 Feb 2025 22:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740722748; x=1741327548; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg7hB5uJ8x0x1bf8b2DSG7wac6hL0se4MZFJrcQ9+H4=;
 b=HKEJst4cZm09418QDAQ6OVEp9r3RH8qZcjWhpmOXCGpsjrmtVokTAokrHW3My/3hPA
 bNKCFPUq2BXsG5bn5J4eHiSq5HXWzJgt9t/ng5yAaDErvQlp7h4ey8ekcgTImjjHhwYG
 OS4hIHtlML3y7L3btdB2mBD219M+SxvQS2gYQgGj1NLoVUsoCDkCieJttOBkiUgkUX2a
 aHoCOACexwj/kgfyNV173QpMLjkSnGI8Y1q/B19hhU4LfiKswSIBruVreBC8Wk3mJd8s
 FTaC7DF1b9SLvV7RzLXQ6jnUWWGw5uTxnwwkBHt+/RbsRDA88H9brMQRXKW0EJd7gJSX
 sHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740722748; x=1741327548;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wg7hB5uJ8x0x1bf8b2DSG7wac6hL0se4MZFJrcQ9+H4=;
 b=Tv3/Kkhz6cfo5Ory3bNK2gbFd+BFxViJnnVUmqagJXkltNzES753tyOKMS2R+qAv8W
 TlasDzAQmoGsAyRZ3ri+GuXxQjUIe7XAQ2BoEqrB2hb6tfLpuvF1Sdi2521FygijsWDc
 7/OsZHl9DFMaHwmSg/N4n5rqh8558jm6tNjlewY9iwkaOCse65uumNt0zBpcBwOJaLa3
 JIlHmuUsuY3zxZtXOS/8yzIZ7Pw+oQ+fyAR5Q1RzXbIw5+94Kz7+WA6Pb41LEfPsWirW
 J47+Ts4ibdvd7R9zSk+GXumY7lEfXxbmk55FzL1wih1D9RYRhZYH7+Qm067zWAVOEavJ
 2MNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrnpYezGK8Q80GNCTL3yySjHTDIEFT6Rbd9grcAqXEV1arXDM3IkGs64qecJN0vmC4Fw2Glytg88G9@nongnu.org
X-Gm-Message-State: AOJu0YwO80TSbzdah4jvYYw+fLnWOKxNglFsUIQJlNL01RNAFxFDEWtu
 ua1SJZok3C6nxjWqjXVQO4lZypsVTCM/5WsrJpJ7okGV0gF3fSAXu+9Da3lGv1yptZF+T11nTpn
 5jnRr357/R40+h/HGxwwIiuBLi3leePMK
X-Gm-Gg: ASbGnctLJkDQWbriPNQ6OvT9SzcJPwdM5ubYm1D2bzbPRu5v2rZVFa06ouEz+OkIvJq
 pBmSm56MS8HDKBWZP34cbRdM5xPn9W9Jtxd3MqS3QEQgS4DJBqZN84zWXfDXVeVm57cQSV2mrdP
 XxtvRUXh1GYTmwLve+207Z6Aun4/cKiQ0eOrcy
X-Google-Smtp-Source: AGHT+IFHiShRgW971wDdGPcImRIHXIpfD1XJ3CnZmraJqXzInUHORzVejLB5Q50uyqF4lvzZ7Y7NVXuD/Wb+FyOxInY=
X-Received: by 2002:a05:6102:e13:b0:4b9:ba60:ec85 with SMTP id
 ada2fe7eead31-4c044d3f50bmr1549619137.15.1740722748185; Thu, 27 Feb 2025
 22:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
 <20250225005446.13894-2-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250225005446.13894-2-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 16:05:22 +1000
X-Gm-Features: AQ5f1JrrDv8El4L2Q-pBqFB9jz3wjDB90Uzzq-81Gt7tvP-eAGE3uDnxUlWqlnw
Message-ID: <CAKmqyKOifHYfGiEbQmQCfK+N3ZLHuV5PuJqrujChspy2FHtzzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] hw/misc: Add MPFS system reset support
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Feb 25, 2025 at 10:55=E2=80=AFAM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/mchp_pfsoc_sysreg.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
> index 7876fe0c5b..08196525aa 100644
> --- a/hw/misc/mchp_pfsoc_sysreg.c
> +++ b/hw/misc/mchp_pfsoc_sysreg.c
> @@ -27,7 +27,9 @@
>  #include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "hw/misc/mchp_pfsoc_sysreg.h"
> +#include "system/runstate.h"
>
> +#define MSS_RESET_CR    0x18
>  #define ENVM_CR         0xb8
>  #define MESSAGE_INT     0x118c
>
> @@ -56,6 +58,11 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwad=
dr offset,
>  {
>      MchpPfSoCSysregState *s =3D opaque;
>      switch (offset) {
> +    case MSS_RESET_CR:
> +        if (value =3D=3D 0xdead) {
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        }
> +        break;
>      case MESSAGE_INT:
>          qemu_irq_lower(s->irq);
>          break;
> --
> 2.43.0
>

