Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA1EE7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIf9o-0006pB-Gd; Tue, 03 Dec 2024 21:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIf9k-0006ob-Bd; Tue, 03 Dec 2024 21:30:25 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIf9i-0001p0-SX; Tue, 03 Dec 2024 21:30:24 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-85b88a685e6so1463158241.2; 
 Tue, 03 Dec 2024 18:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733279421; x=1733884221; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeXIAjXIdhxBNsW8W5MSBW1uXhalWp3geveLsyPNOUU=;
 b=NJ/Um3Dwe5GOboIgaVIK/aL7lGGPCsN6hTk47lKDHjGlLjevZy2TM2IofOrZKh4UNg
 Abs4CcNiEhDNifB24i+Z4dsb0d04VT++eWDP7djdT0sOJ0juIFimPPff9nL6IqgnJv1n
 aE9WbRkWCfePNg32l3RqmPeJYJH7eZUx+OqkTNMsmgh5kAGtz+kVvIxRgUMu5d9m0fF3
 +w4Gj/G+QmAZj2L6mx4j1yIcy/YOpnH7AckpeEfd8eJIqAjVBQpzmAaEQSaqet0a/MJV
 Pbup01ITiQ56ATJVkFaFD+Ol73FVv/BTNZKPVahPgKyrFSdCkGESHnuI35x8G3XU5SWd
 av6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733279421; x=1733884221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeXIAjXIdhxBNsW8W5MSBW1uXhalWp3geveLsyPNOUU=;
 b=PoIo/p9R6vIfXsA/kxtnv/tDbJDLozoehbgEHE+wyv/XnWhULSkT+LvXGk3CVVMqv7
 vbvU88TolcvQ8s4IuTw1Y1DyEGPoHc9geoE6Z77wcAuFZHeFMuH4hR9xMPwuIqskfOWm
 wUgRri4jWWrqOjquncB9KqXxmtXRTOSJww85odShMx/HIq0N7fq4X6YajOrTSZLztI0Y
 STS2pVV5s+ZsAgrG4LxXVR5ClotZlFmTzstbQyovzesT9vW5/gRFwLOZ6EAa2Pg92TxC
 E9ADruD1rylgI20v5f4KdY1hntEc0lr+u74SbgY20bIGq/xVs/M6cwtUYet5PGIDhnJo
 F/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbrmaRwC9Jc8yCh2/0W897repv4IONEGv5xeBuL5Z1HxyMNcdLe0+EwZUn1ipYIWWoNn/16RdHGNjk@nongnu.org
X-Gm-Message-State: AOJu0Yx/wIoutdyW66Z7DRFNyz/9zSn/c+C+SqI8F/RRBpTH/EbqpBnE
 6f3T417+mBgCTxtxWd1P9RtZ+qPhq+y/vCTPlOnkTH4XYzj1/J6n+NnidNRmyybmGBSBo2uO6ge
 NydDA3RtqOSpu1Zeh83f1PlL6VPs=
X-Gm-Gg: ASbGncsrBWxNlspVnjZRiJERrE1N+gX4KOpC9topTsTk2BLc6WMBTGBbTKqjOLRIVW9
 Ok4G9L16Vn88TUVac/Jh9yfi3ZQ/ULsW8
X-Google-Smtp-Source: AGHT+IG8v9Y52At7cIjfzhaff0LxXI0qaSHRCoqrqmOLnwMSv/ORM87jbDzXC+8y9SUHk1zglI9p2E7vB9QUzbVhN5M=
X-Received: by 2002:a05:6102:508c:b0:4af:5d05:1f8b with SMTP id
 ada2fe7eead31-4af971afc2emr8156215137.12.1733279421191; Tue, 03 Dec 2024
 18:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20241203200828.47311-1-philmd@linaro.org>
 <20241203200828.47311-3-philmd@linaro.org>
In-Reply-To: <20241203200828.47311-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 11:29:55 +0900
Message-ID: <CAKmqyKPTcDsHpcc9Y-JNf3BgZ2sUNqfMA+-h3uUzQmGmqdnmbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Include missing headers in 'internals.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Dec 4, 2024 at 5:09=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Rather than relying on implicit includes, explicit them,
> in order to avoid when refactoring unrelated headers:
>
>   target/riscv/internals.h:49:15: error: use of undeclared identifier 'PR=
V_S'
>      49 |         ret =3D PRV_S;
>         |               ^
>   target/riscv/internals.h:93:9: error: call to undeclared function 'env_=
archcpu'; ISO C99 and later do not support implicit function declarations [=
-Wimplicit-function-declaration]
>      93 |     if (env_archcpu(env)->cfg.ext_zfinx) {
>         |         ^
>   target/riscv/internals.h:101:15: error: unknown type name 'float32'; di=
d you mean 'float'?
>     101 | static inline float32 check_nanbox_s(CPURISCVState *env, uint64=
_t f)
>         |               ^~~~~~~
>         |               float
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index ddbdee885bc..76934eaa7b5 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -19,7 +19,10 @@
>  #ifndef RISCV_CPU_INTERNALS_H
>  #define RISCV_CPU_INTERNALS_H
>
> +#include "exec/cpu-common.h"
>  #include "hw/registerfields.h"
> +#include "fpu/softfloat-types.h"
> +#include "target/riscv/cpu_bits.h"
>
>  /*
>   * The current MMU Modes are:
> --
> 2.45.2
>
>

