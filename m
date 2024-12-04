Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6811E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIf9S-0006hd-1k; Tue, 03 Dec 2024 21:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIf9L-0006go-8c; Tue, 03 Dec 2024 21:29:59 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIf9I-0001ZL-DK; Tue, 03 Dec 2024 21:29:58 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5150f63db70so1751459e0c.3; 
 Tue, 03 Dec 2024 18:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733279394; x=1733884194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5glZ6s3P3Jnx1EzTYUoEk7/ps6phwYVaPr+wcWOEpaY=;
 b=fWw18eNoju+Xvv61a9pfo6AdFYtUtsNmdh8reGIkNHKqf4GNDny5b0lTVvYIY1b0BU
 107wcs/uVTftMYQGIB2MFHU5eznd0l5bAlY8Abpzkv6CGryrXXPpmnSGNH/CHtUhd5uk
 XNkwH1zUO2FfGgOY2FDrCPg17yCVYuZH6/1M59b06p0CjKCN3TzAOMhebm1UjFspiZT0
 DFE0nOHIhXrEY5W3rqsWM64GIjVUwCrAtVZKCo+mKUzlQaAF9Zq7OT4VJ9Lv1Vv6Posp
 fLj+214/nVO5Q0mA0vyPo4XC8CrOFtuQKjXCsdXbpHohYezk3WQebq1hVhGPSBJh/8UG
 h46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733279394; x=1733884194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5glZ6s3P3Jnx1EzTYUoEk7/ps6phwYVaPr+wcWOEpaY=;
 b=ZDQAHTGbRIqk74XKLRzf9y/u/zZBrUqpxQjy2SKkcK91apAG8UOkSKGDm3y25GCIRr
 m5EdsjV/DS7u4w33igCLyUn+22il+ddV3ORcqHv0ipE0MyoGRCohLTJKmADjVw6+IDFz
 wRRl4YJMv1r9orAvaTn4RbDd+jF9amJpoGI8T4jeTot7WYP4iS1XH69b5mJgX/SYfpKb
 9wU6oUs9thmBCZ1Ffrxc8fDBYOku/OeVejbK8d5hBomYKQDbk5QLfegcMHBdoNVcXkgL
 nHxQ5+V1DJP9SUlvQJTWRg6q2FMM9I+HIeEFMRPQNtLd5PphIVWWF8vPItpgA537LCB9
 IIyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULcWyfCIBiV8eo5b0hMON7wfX0j4mGSh9HxfZsDtYG+Qolpd9s6c00T46Nqk1wjqs9rn/50DI879Lv@nongnu.org
X-Gm-Message-State: AOJu0YzFxxn8GIaRz7UFQVAvHRZ21rHLE/HeiQ3N46FBULeIXZK9N5ah
 ma1ybG1ieeaphsUNMJMdT4ckr/0q3LBTX8Q1HnWdpIacCCxZqW8frQlPY+tZF+eGTZw1dQ1JYXl
 pvtiKCls4oh9uBlvAZiVbN8dMxo0=
X-Gm-Gg: ASbGnctrb25yPGdWM9UXp0OV7mTfoXPbiy0eNA8YP30Ku2GgvPygesVY/F3EdmiD1ww
 HYJYrHW8TwofZQRBibtVwnmyQVGMvU+XO
X-Google-Smtp-Source: AGHT+IG2+RGk20OabHiMOB10KuLw++/RJRr45mtk61z7dNck7BiIpE+kD4bk6c/3WwntyLQBV9Q6w+TAaoomxkDRXso=
X-Received: by 2002:a05:6122:16aa:b0:50d:5e21:ef39 with SMTP id
 71dfb90a1353d-515bf2ac316mr6642253e0c.1.1733279394145; Tue, 03 Dec 2024
 18:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20241203200828.47311-1-philmd@linaro.org>
 <20241203200828.47311-2-philmd@linaro.org>
In-Reply-To: <20241203200828.47311-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 11:29:27 +0900
Message-ID: <CAKmqyKPEz_H6F_CTE6t3nwaWdmCStXa1UdQFrbVHfW0xyfhmig@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Include missing headers in
 'vector_internals.h'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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
>   target/riscv/vector_internals.h:36:12: error: call to undeclared functi=
on 'FIELD_EX32'; ISO C99 and later do not support implicit function declara=
tions [-Wimplicit-function-declaration]
>      36 |     return FIELD_EX32(simd_data(desc), VDATA, NF);
>         |            ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_internals.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_intern=
als.h
> index 9e1e15b5750..a11cc8366dc 100644
> --- a/target/riscv/vector_internals.h
> +++ b/target/riscv/vector_internals.h
> @@ -20,6 +20,7 @@
>  #define TARGET_RISCV_VECTOR_INTERNALS_H
>
>  #include "qemu/bitops.h"
> +#include "hw/registerfields.h"
>  #include "cpu.h"
>  #include "tcg/tcg-gvec-desc.h"
>  #include "internals.h"
> --
> 2.45.2
>
>

