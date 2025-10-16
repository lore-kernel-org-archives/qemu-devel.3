Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DBFCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XFc-0001ai-HC; Thu, 16 Oct 2025 19:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XFa-0001aF-1e
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:19:14 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9XFY-0008QV-06
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:19:13 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-634cef434beso4322584a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760656750; x=1761261550; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn1SKXqU2GgVQqeVJZiCNGpwDPwjR1lZDaQsabD5eYU=;
 b=CQSBmnJeKeRVZ7Up3ys1FrJlw7MsxK7YQTAZbH5SwO//A9HGmTFHGRjY1ZzfDsUiGd
 34jlUFeAi1HNA9pxpX1mxLLDyjh9JpZzinc4dlOzzKGvO4hmokcJ4euWiY92P3HeV6jD
 5foB9cvhdxy29yc8PtkGDcLtIntC3GoJMSME+vPf/h7DmC1RIsLEyGjy+BL+Ev708dBH
 DDiZQzUy6ym9FcKjTn2oypCoYKW0SOuI1gHfJKme1ON7DUT69FpDK+6KJimro+GCnKD6
 vthmO8NtNuM2/hKhUT/n5PXfmUhWbyJ9QtAM04WuSYz4ZMrbnNNCfDDIrRk1F4Iht/e0
 O5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760656750; x=1761261550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xn1SKXqU2GgVQqeVJZiCNGpwDPwjR1lZDaQsabD5eYU=;
 b=gcHVCXB0nmqi8Wkq63YOPh0mwqEvSsRuFY99V5wUmmcC8kQxw0y7TtwyXlbfuBzprS
 YBZpmFpf+5o0N+zmZBT3yBXozbDNqorLXnyh3a/gFGcUZcaQX7RQf8FL3wyvKXSxqshi
 04xgy/j21dr5pAvCOSn/gVAkUQ97RMOMTn63I0BBUzcOJSEEEnEQs1BY5X7jVkNrV/fa
 Hh2ItI7bpRv0o51RNPuogLoy4Kw3Q2ZmNe5mH0A7XYs0HiYZqRJmbI0pdlDveuqUYKZ4
 k9RanEz6EEXTSeEwvb75dCmzZBIvnpZYJXQnMLA0NPj41owcxBUHLxOnZ6ExUB0D4t5R
 tpjg==
X-Gm-Message-State: AOJu0YywY0U+rJAXAoSPvQPZaBtthv6XSJdvas105HP5x8xMgD+ozk7P
 EZ02cpYNl97O8xjA6zxcOjUplt8UkccaxJyhitS7exmE7AaxbgnZYdjx+yvgRtZ3lU8Yw1cDkfH
 5vW2Bt4opall6MqseJOvmeRJQo2MX+e0mHA==
X-Gm-Gg: ASbGnctzXfTfYppID8X8a78TmDc1hjJm5IuLxNRIzxvJ4NV16cf09HH8d3WrcUnutnQ
 n937sGG3zVAnfZtsj7JLkMah/rkesZjmtuKV7QNsfrDeMIin+ChKt87kOQDUBbei8FJF/7YVLFu
 upszdeE6UCHphjFvp58nrbY61JqPP9ZBp3XpE6nouxSA41MYdhKzk3NB7cFZoPl7oLgQKwn88Go
 1ybqdPe2Uw6u5WpbvUO5IDMELp+RPttIJ7uufX5ILqawDmLJG0GtKbhHMSyS8WDeNXvbq78jYQE
 HdmfjcFdNHGYfFwC5r/nbXS+TwHpcZObjbUv
X-Google-Smtp-Source: AGHT+IGoLs9k37BlEIcQ1KMxICzoY0vpJ+w4HTIY76P+u4a+O8A2FF0bh22hwhDDMPYUecBIFakXIpt9cClntQi9rP0=
X-Received: by 2002:a05:6402:1474:b0:63b:dc3e:f024 with SMTP id
 4fb4d7f45d1cf-63c1e2a8ab1mr1876671a12.17.1760656750273; Thu, 16 Oct 2025
 16:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-32-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-32-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:18:43 +1000
X-Gm-Features: AS18NWAXdE1S70sAYvNJgG2Ed0D8aBYqhxQsUUhjMAHrIxLhuFPVaqlo2dJOdkk
Message-ID: <CAKmqyKPZwH5x0g61TrBBeNYQasGjPAmTCGs_KRReWOtS2LDa0A@mail.gmail.com>
Subject: Re: [PATCH v3 31/34] target/riscv: Move debug.h include away from
 cpu.h
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Wed, Oct 15, 2025 at 6:38=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> All debug.h definitions except for RV_MAX_TRIGGERS are internal to
> target/riscv.  Move RV_MAX_TRIGGERS to cpu.h and include debug.h from
> all translation units which relied on the cpu.h include.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         | 2 +-
>  target/riscv/debug.h       | 2 --
>  target/riscv/cpu.c         | 3 +++
>  target/riscv/csr.c         | 3 +++
>  target/riscv/debug.c       | 1 +
>  target/riscv/tcg/tcg-cpu.c | 1 +
>  6 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5e9fa0ab10..c02c813259 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -185,12 +185,12 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_imp=
lied_rules[];
>
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
> -#include "debug.h"
>  #endif
>
>  #define RV_VLEN_MAX 1024
>  #define RV_MAX_MHPMEVENTS 32
>  #define RV_MAX_MHPMCOUNTERS 32
> +#define RV_MAX_TRIGGERS 2
>
>  FIELD(VTYPE, VLMUL, 0, 3)
>  FIELD(VTYPE, VSEW, 3, 3)
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index f76b8f944a..d3aae619db 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -24,8 +24,6 @@
>
>  #include "exec/breakpoint.h"
>
> -#define RV_MAX_TRIGGERS         2
> -
>  /* register index of tdata CSRs */
>  enum {
>      TDATA1 =3D 0,
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f169eb4bba..f4dd3b48d5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -37,6 +37,9 @@
>  #include "kvm/kvm_riscv.h"
>  #include "tcg/tcg-cpu.h"
>  #include "tcg/tcg.h"
> +#if !defined(CONFIG_USER_ONLY)
> +#include "debug.h"
> +#endif
>
>  /* RISC-V CPU definitions */
>  static const char riscv_single_letter_exts[] =3D "IEMAFDQCBPVH";
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 491186d9c7..da3c24fa6b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -32,6 +32,9 @@
>  #include "qapi/error.h"
>  #include "tcg/insn-start-words.h"
>  #include "internals.h"
> +#if !defined(CONFIG_USER_ONLY)
> +#include "debug.h"
> +#endif
>  #include <stdbool.h>
>
>  /* CSR function table public API */
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 5664466749..f5b2043405 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -27,6 +27,7 @@
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "debug.h"
>  #include "trace.h"
>  #include "exec/helper-proto.h"
>  #include "exec/watchpoint.h"
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index db3cbc1625..f24c4128c9 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -37,6 +37,7 @@
>  #include "hw/boards.h"
>  #include "system/tcg.h"
>  #include "exec/icount.h"
> +#include "debug.h"
>  #endif
>
>  /* Hash that stores user set extensions */
> --
> 2.51.0
>
>

