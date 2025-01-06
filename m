Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ED2E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 01:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUcEW-00063L-DR; Sun, 05 Jan 2025 20:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcES-00062a-7M; Sun, 05 Jan 2025 20:48:40 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUcEP-0006L4-Sv; Sun, 05 Jan 2025 20:48:39 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-85ba92b3acfso5786775241.1; 
 Sun, 05 Jan 2025 17:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736128115; x=1736732915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6OxQuQE5pdOxvpIsgDoSh3PMlwl4wSe+1a+NvR11Pg=;
 b=cX5zP/OIYEw1sqH6M/rsl/hyp1fSklw2+g1Ax4Z25xzno84yw4bPDA6Z5y0PBrexSg
 N8s0NwcKsXtnYjIYoDlqytsKTFEXoEtnM4G2X3T/sPJf4I6V6GdCDIvBDwgebdYAv+DO
 WkRbKf58lSjsl5H+s9QbioUURJ5dxSRrVc4VdLIgTueYL8qvh9RnTw/wFDbmnDA6xyLP
 Hmk3/rgIqJ4vKfSnupV1G0QpUxQGFoKUaaH8UOl7DHjCXOiPsmc2FgCAhfwBN8jAuUPb
 M0OEcuLBLxghrNcZvWdX9dIJvI61L42WmM6KJt9d53GzryvAiG8314HV4OJexj6XMdOh
 2OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736128115; x=1736732915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6OxQuQE5pdOxvpIsgDoSh3PMlwl4wSe+1a+NvR11Pg=;
 b=teSeH5nT40xydrz3j3cgWhFFzolmt3ixsVrQ+kVAZS995PeruVuoY/fZGYPtAlCuYG
 FkV01M+juGlFhmGIbez3O01//kKFhnWkqr8tTpxm1lTdrGF2SN07lH2+6ztUPjF2Yi55
 BoF/tBgb8m6BpyK8+Z03a80D18NqyXqhI/Xjjpu8SDqs23HVEhiUuHFpt4zfh5lCka3K
 a9iW1xxYGDbWxxUbiWjhUjg5WVWwigKvaxnTIomzm/STO15JtWtyGbyt8/3tM/2ZGiF5
 MIeeEI5PpUOwrm5ZIXeTTS49U+g7ZuPaRuFIwsxA3eJqZyw81Zg+qPX9CWgeICKCNqIX
 hOoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ9+Ydyotm7cciaxWBVBJA8KqYKUNjZIuIWVZy+Guh+H42okLReLUT0/qEeY35H7val68vFGitt8cK@nongnu.org
X-Gm-Message-State: AOJu0Yw51ESs5tEAghLna9WJPPoMqKKLyN46sqBBrm1w4ElqYMyJjYVb
 6MRjrPBhUOLnR52jEWw5UU0FTjYJbyCjC9yiLs3Yvw2lEAtJChd8Oa3iUzp8bPKAbR8bW/3VSt2
 M1MIAaC2rewYplt0oW6OEbMeEFoY=
X-Gm-Gg: ASbGncvD81EqAhHSrflMBTzF8NTc4iWFB4UJvo73HZPkvZWXQA5oLi18HynjJtGEfRP
 aaz+uxJD1kY0J4p86IO/yCsSAmCcNg46AM/y38uwJRywscEgEWM/1Q/q2A419dDg6gNY=
X-Google-Smtp-Source: AGHT+IFj0sgkkYsAh8KS1XdVzbd5VFQp+lq8eYnszO/XHPxQ6JZtI57aZs2Iw+omP6Jxs7c5Z51QPLg+ZWi9GPW/OX4=
X-Received: by 2002:a05:6102:3f01:b0:4b2:4908:e9cb with SMTP id
 ada2fe7eead31-4b2cc320da9mr48810193137.3.1736128115506; Sun, 05 Jan 2025
 17:48:35 -0800 (PST)
MIME-Version: 1.0
References: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
In-Reply-To: <14dfb7b7-98bb-4e8c-a223-c568512180b7@embecosm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 11:48:09 +1000
Message-ID: <CAKmqyKMqS6BKB3WAUwxo658q18ZXsC-ED_-J3RNeUqfmDe7J1g@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] target/riscv: rvv: reduce the overhead for simple
 RISC-V vector unit-stride loads and stores
To: Craig Blackmore <craig.blackmore@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, 
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>, 
 Paolo Savini <paolo.savini@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Thu, Dec 19, 2024 at 12:15=E2=80=AFAM Craig Blackmore
<craig.blackmore@embecosm.com> wrote:
>
> Changes since v7:
> - Fixed typo `bits` -> `bytes`
> - Tuned threshold for applying the optimization
> - Provided results for larger sizes requested by Max Chou
>
> This patch provides up to 60% speedup on the `memcpy` benchmark from:
>
>   https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/strmem-=
benchmarks
>
> There is some variation in the measurements so results are attached for s=
ix runs on a single thread on an Intel(R) Xeon(R) CPU E5-2630 v4 @ 2.20GHz.
>
> The three graphs are:
>
>   memcpy-594c0cb1ab-128-speedup.pdf: VLEN 128
>
>   memcpy-594c0cb1ab-1024-speedup.pdf: VLEN 1024
>
>   memcpy-594c0cb1ab-stdlib-speedup.pdf: Scalar (to further illustrate mea=
surement variation as this version will not touch the function modified by =
this patch)
>
> Previous versions:
> - v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@emb=
ecosm.com/
> - v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@emb=
ecosm.com/
> - v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@em=
becosm.com/
> - v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@emb=
ecosm.com/
> - v5: https://lore.kernel.org/all/20241111130324.32487-1-paolo.savini@emb=
ecosm.com/
> - v6: https://lore.kernel.org/all/20241204122952.53375-1-craig.blackmore@=
embecosm.com/
> - v7: https://lore.kernel.org/all/20241211125113.583902-1-craig.blackmore=
@embecosm.com/
>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Helene Chelin <helene.chelin@embecosm.com>
> Cc: Nathan Egge <negge@google.com>
> Cc: Max Chou <max.chou@sifive.com>
> Cc: Paolo Savini <paolo.savini@embecosm.com>
>
> Craig Blackmore (2):
>   target/riscv: rvv: fix typo in vext continuous ldst function names
>   target/riscv: rvv: speed up small unit-stride loads and stores

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/vector_helper.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>
>

