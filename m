Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1209CC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tugzU-00021H-Am; Tue, 18 Mar 2025 20:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tugzS-00020a-Ar; Tue, 18 Mar 2025 20:08:58 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tugzQ-0004IY-Jo; Tue, 18 Mar 2025 20:08:58 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86dddba7e0eso622634241.1; 
 Tue, 18 Mar 2025 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742342935; x=1742947735; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jyROxbulUHy2fLiVnwa8hnyISXfFdawHvXRCA/ufbA=;
 b=kRD1u8UmkEIeSbqEHyVkowvH2BBljc7Iscg8xa0/QOHMzIJsQrct1iLfe7731MP2ub
 nU9cEmekTTwpCg1wNeSQgWnnkuNCJjRfTfooCwwQ9RgMHsrOQZeYupLYZEZMQHCO41uK
 FW6QcQG4zIbHR2Ol+KUnUq9U7hgX8MIQVIXjTxTEXNBhgQX/CUHDrd+1KUcEhm9/lQcm
 /JALXCs3FfFKuMclqBhsFH6k9m3tSlLkwGPdMEvk8K7tbIdonU+4yrLc0qXZjeZDr5Mg
 XutY/8VAUnzidiTIiG/issf/Ph3m9LST7xRyn5XoAWU7v1uuggE6N+lvJS9s6dbRAZ1E
 zwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742342935; x=1742947735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jyROxbulUHy2fLiVnwa8hnyISXfFdawHvXRCA/ufbA=;
 b=JGEyMd9SwIW6I1FXDGgC4aH+Jhb6IgvW+Z+VeHeYlcpY6dB9krTVBy1LNzapGaciuL
 AYw25pjj/KkQMB6EOEzHLjcJqfbrOBBcVatxhBzFsHy4NYoDUYOEP4ffcuQ2msGn+frH
 7aKapGAaxtQwa/vzb6Zsdlfai1eM04qGauRu6s5TO2X2VphM+dhVY3RjJawlRXMMSUPu
 cIptZeFmFYsszvkwYE2OzY5AJgcNgLtq1DnWE24IqYpMKDr2H+d3CJ7xwWwKIMAtFgYb
 AmhjICZbdcNNZqS1PCfAJILaqvry5cNXMBrJQMrbcAbdpABgire30b29vjKjADASlyRf
 IKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqGJgu8wzSV5BL/MLop/bHUhVjDkOu2hIb/3825iBg0Vt1nTiPgkXjPF+Trc/9bqKw6dzRAT7sCpBq@nongnu.org,
 AJvYcCWrwvLBRIUe9Dpaf/tkmLtLBF2DT2Jt5DJ4RbFihU3vSRC/K5HO/AjZ9a7iHaFfPJYstlhIacfJz3PoOg==@nongnu.org
X-Gm-Message-State: AOJu0Yx3oAYmRQ7f8P4DnHxK/2XQesv5oPpyA2FsO7Vb0GHuykXXHwAf
 pf6m8/YzkhCXVoHo1xybmMvm51eygIG9GfonazBiOlsGx3JcrDpz6n5u08VFcdBoRbJGeHAxTqO
 51L05+b4X/St97CSpHmeewAv5JpRbPJzs
X-Gm-Gg: ASbGnctIKOLXn0fwXuyKBJSzIvW5BSgzmVN2m3ycl/kySLYBN9b5CyfLtk06fEwtFld
 uWC5KOiPGwL7cLx5/nR6thzcK9rdZ6g2BE9CLCT3CTFSGDrG0wuxurFIF6rQwVqPQp4jLFj93AP
 5HBfSDN85Kk6OnGnM7rMlYDD8ga+hwdi8qnSfKX6u7jpUkq6ya1LhY6JM=
X-Google-Smtp-Source: AGHT+IEhxjNFs8G9kdYBw6JYf8SHnRgIhnblTzwfGy9YROb9IfcJ0WPYrzjf+8JdCqwMsDk8MD9/V0U49wz8bHIRxZY=
X-Received: by 2002:a05:6102:3f46:b0:4c1:9695:c7c with SMTP id
 ada2fe7eead31-4c4ec854f11mr661248137.24.1742342935186; Tue, 18 Mar 2025
 17:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
 <CAFEAcA_P3XbJ-H9O=K-U7HtBAU9c=0TngEfV8fpQxcH0JRuGVA@mail.gmail.com>
 <c17a3e7e-9383-4f37-9fc5-b93afbf13bd3@ventanamicro.com>
In-Reply-To: <c17a3e7e-9383-4f37-9fc5-b93afbf13bd3@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Mar 2025 10:08:27 +1000
X-Gm-Features: AQ5f1JpC9u0tOV996i01ns5E3zhV-1AFL7do65-26qtS8XApRbPfbH0T5LUDvAg
Message-ID: <CAKmqyKMLVvg_smq+Mije88C0a5wbMTA8F6XKbmd9gyQBwG9p3Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in
 rmw_sctrdepth()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Wed, Mar 19, 2025 at 5:08=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 3/18/25 1:42 PM, Peter Maydell wrote:
> > On Fri, 7 Mar 2025 at 12:46, Daniel Henrique Barboza
> > <dbarboza@ventanamicro.com> wrote:
> >>
> >> Coverity found the following issue:
> >>
> >>    >>>     CID 1593156:  Integer handling issues  (OVERFLOW_BEFORE_WID=
EN)
> >>    >>>     Potentially overflowing expression "0x10 << depth" with typ=
e
> >>    "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and t=
hen
> >>    used in a context that expects an expression of type "uint64_t" (64
> >>    bits, unsigned).
> >>    4299             depth =3D 16 << depth;
> >>
> >> Fix it by forcing the expression to be 64 bits wide by using '16ULL'.
> >>
> >> Resolves: Coverity CID 1593156
> >> Fixes: c48bd18eae ("target/riscv: Add support for Control Transfer Rec=
ords extension CSRs.")
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> ---
> >>   target/riscv/csr.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> index 0ebcca4597..e832ff3ca9 100644
> >> --- a/target/riscv/csr.c
> >> +++ b/target/riscv/csr.c
> >> @@ -4296,7 +4296,7 @@ static RISCVException rmw_sctrdepth(CPURISCVStat=
e *env, int csrno,
> >>           }
> >>
> >>           /* Update sctrstatus.WRPTR with a legal value */
> >> -        depth =3D 16 << depth;
> >> +        depth =3D 16ULL << depth;
> >>           env->sctrstatus =3D
> >>               env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1))=
;
> >>       }
> >
> > This is a clear false-positive from Coverity, by the way: we just
> > checked and enforced that depth is at most SCTRDEPTH_MAX, i.e. 4,
> > and 16 << 4 cannot possibly overflow anything.
>
> True. I wonder if we should keep this patch anyway due to the better code
> pattern in using ULL when left shifting into a 64 bit var, regardless of
> not fixing any overflows. There's a chance that we might copy/paste the
> existing pattern into another situation where an overflow might actually
> happen.
>
> I'll leave to Alistair to decide whether to keep to drop this patch. Eith=
er
> way works for me. Thanks,

Yeah, I figured it was a false positive with SCTRDEPTH_MAX being 4. It
seemed easiest to just "fix" it to keep Coverity happy though. It
doesn't cost us anything to fix it here.

Alistair

>
>
>
> Daniel
>
> >
> > -- PMM
>
>

