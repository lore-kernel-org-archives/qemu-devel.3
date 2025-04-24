Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690EEC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tkf-0000Qd-D1; Thu, 24 Apr 2025 06:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7tkd-0000Q9-Ob
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:24:15 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7tkb-0006Vx-TL
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:24:15 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86ba07fe7a4so854791241.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 03:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745490251; x=1746095051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIvXCwz0H73zN2wCH4NZVKVADj+neyMALVCPPkYeCcA=;
 b=O7LcM5TnW0osNJix7M8ZGeCkBIMz89S6oWGChX5P0CRENL3Th16ugCtn8sJTzX2NZl
 kJoHFJiDy9p4eONXVmVMzX6Sia6j8J1TL9p+CBKfNfnST6dDotKbo4FV1jrsIJ/SBYmE
 UKjygJszZm9IWt0NflDGx5yNu4iwNBI1MvPmJT4mjWAygJjg537uLxfxwUkxppClebnr
 zwFLWiM3wYuqkIII1ms2bmTy85xq0nAb5nmHRp2cYr1+AbWYP9a/1voifswWlIWV00RH
 asJOEjsBs9hhY1F59lKM4JC8wgGDg9xLkYZjMqFNvngdhxZLj/4HQugGWLB4tmQrU4K2
 qjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745490251; x=1746095051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIvXCwz0H73zN2wCH4NZVKVADj+neyMALVCPPkYeCcA=;
 b=ty7aRcn5+4OBQEm/ttb7SlAYOI6Wo/T7m1Oih51jiodOg2iR6H0rMtS9Jz0YebFQN3
 9cu2ysgJVeyKTPq6/lGfUTjuqhFIEOJjzIvpadZdsfcJcSsp1TQjereCA29aMZ6k0ujx
 B5nBGZRPMyUAscnrhkVP7cJXSfEbCBklYhYR/jEICCKYX8hSXkHMH+u/79p44j0kxT9A
 f0BJO0ASvrWB+qaxb9Ai2JDATNwKl9FKhwq3EJ2SJE4QXLVhATjlYApVs8WIctWPDyEC
 WO507hk0AlKPWHWhgtrG3PSW+4bQdOeoKNqm+KOx63puCyIe3jV3SxRwQH4MCy+w+qtx
 c4YQ==
X-Gm-Message-State: AOJu0Yz4jyhhoVeVceul6XYt/XRImQJR+LY/AhTJUExb0BNyNAVVPKdG
 zrfUZaoqTdt44aHg8ZSGfdghByXKwlBb60UlYGdDER2qvSdO70KStuF6kEjBwhzEo9q1rKcakgB
 oTPQhQH4faG7LQqNe38IMvf3fiORtgQ==
X-Gm-Gg: ASbGnctwW1EXzj1QVksf81XKkwXBIUsCwmh9ULoRkfTHMKWOk32Nn34LmpUKSmvnyQQ
 Oo4k0S980wVQB0TofoiLemoBEUtkgJQhNycehEPXDSfwjz7TH6KXzB7VEVBZk6I1FLnV+4DhlB9
 zaET1DUxNkeZGJWjFdPURAy/ZyPqVvkv17DhCadBHlWmxownxkDMI0
X-Google-Smtp-Source: AGHT+IF6G/rQwnVgTUbSVJE36t1MQpV17LSA8bODFGKFz7u75UXN2QiNR7gBFr9hv3dYUen10aePrIDzvFMCxEqvSZk=
X-Received: by 2002:a05:6102:4188:b0:4c1:b3a5:9fa with SMTP id
 ada2fe7eead31-4d38ebe79bemr1445952137.16.1745490251524; Thu, 24 Apr 2025
 03:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-8-philmd@linaro.org>
In-Reply-To: <20250424094653.35932-8-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:23:45 +1000
X-Gm-Features: ATxdqUG_khQxLDvfSm7QoUIDZVB9nZ_eBiDQ-vgu0vOQ8GEhGZUaP_tqZLpHkl8
Message-ID: <CAKmqyKPF68O4XkTqykqmN6TO7gb6vRt+Q5pHKyop9px3QddXLg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] target/riscv: Include missing
 'accel/tcg/getpc.h' in csr.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Thu, Apr 24, 2025 at 7:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> "accel/tcg/getpc.h" is pulled in indirectly. Include it
> explicitly to avoid when refactoring unrelated headers:
>
>   target/riscv/csr.c:2117:25: error: call to undeclared function 'GETPC' =
[-Wimplicit-function-declaration]
>    2117 |     if ((val & RVC) && (GETPC() & ~3) !=3D 0) {
>         |                         ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c52c87faaea..13086438552 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -28,6 +28,7 @@
>  #include "exec/cputlb.h"
>  #include "exec/tb-flush.h"
>  #include "exec/icount.h"
> +#include "accel/tcg/getpc.h"
>  #include "qemu/guest-random.h"
>  #include "qapi/error.h"
>  #include <stdbool.h>
> --
> 2.47.1
>
>

