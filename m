Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A79C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5nD-0007gX-9L; Wed, 31 Jul 2024 05:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sZ5nB-0007eW-Ny; Wed, 31 Jul 2024 05:38:45 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sZ5nA-0005O5-04; Wed, 31 Jul 2024 05:38:45 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-492a774c807so1541720137.3; 
 Wed, 31 Jul 2024 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722418722; x=1723023522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOszWx/XhHUXM+Zid7l+V5RX375eUfOYEr09bcjfSM0=;
 b=fLRDUY7JCIdSC/T2hL3TLfZ4O55kvQiRfJUVi49rR0EOB5I61UGZ50saXyzPM74qqr
 EvaMqDyjsgjNbHrJ+e0Y2ebAwUe8GvZoMP0wKDWEkS0IyEb9Bofr9JNb4yyhKTT6xOG6
 pOZOEnZowqAv6/T2bARjhq2aar64Hey3QjvFCz0jnKc7LlwBE1gMddxMKSr7eN76SdhB
 aHZ6YlH0Pk9l6I+KvhqF0lF1iqiu/FiNWUBjCNYT2MWz4itA0UqBw75hwD8SVWMtU7jj
 RcesepkWcPi5yIcwzF2XqNCwtxlenko5foID83T6VnK3BgM1Pd1a0pVB2tTVcu6Go7IT
 yagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722418722; x=1723023522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wOszWx/XhHUXM+Zid7l+V5RX375eUfOYEr09bcjfSM0=;
 b=VWFkGcxDRU1thkkSvmYCvQYWTFqGKoc9usLFYpWdHfIdQ5/tTsDx92DaZvWIj/xWVs
 u7Kv5biNjOP8LR5BYgdWIkGcMqWZSuwOonaBsYlf3VLSJYiDWXj3ZtmrLC2QNKdwDV/s
 m/6FPXymzXJMQiPTlNEnWHsNkDLRKe3bIQBAI2oDmBmtoFe1+rUOstYJFpO+F2yHj7RO
 SKvwSSB1yE2hUX7I/AxNsB4Q/fKR+1WuzCNgngWf6hiB3KkWYqWjA4XHRkFzyCA53qrd
 IUoxpKf2JOggqyo0PmaKmojQd2mMLeUMUzWzSgsZPL4cHTWhRAAWkMrb0wyLnR1xJvY2
 CSsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV5+XTDbN9U2YTnEEN0zuPSBm437G0SZ1IF/TVhX9gqKi0oap70aq2dW88hqiAWHzZT6u+jE6WNzSEBSJATrUgcbYh8wVqPpRltEHzveTjkefz9wB5u2rsaQYsuA==
X-Gm-Message-State: AOJu0YyecdHfrBmcmro450Tytb9Ty7XLGTVMdF4yt6csM249wqAKsoLb
 Ss9WzHn5kUwy4IXIAz/+MT9ZAbR5IWKUynsoPWcPFrfvO7uT4wKQomK1Ll5urxFKzCH/SOstb38
 Uj7/Cv4N9ls4mEzNcaLTGWFfSNmk=
X-Google-Smtp-Source: AGHT+IGdlltPn5yc+kT0NHd9Gxv4Ug5tokZvgme0BRJDA9nriTk2xOH1y+D4pfEsFjh1VtY/Uz82Cip/FY37h81Uj98=
X-Received: by 2002:a05:6102:41aa:b0:48f:de23:14f0 with SMTP id
 ada2fe7eead31-493fa19ab17mr17882871137.8.1722418721837; Wed, 31 Jul 2024
 02:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
 <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
 <8d12202f-7170-4127-a1a6-c23c03835cf6@linaro.org>
 <ca1b9449-f6e0-412c-829a-bc6258f461ff@linux.alibaba.com>
In-Reply-To: <ca1b9449-f6e0-412c-829a-bc6258f461ff@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Jul 2024 19:38:15 +1000
Message-ID: <CAKmqyKMftPJuLDc=8vR5R=j90CPYHxM1NscMB_fXk2SUgfM5pQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Thu, Jul 25, 2024 at 11:53=E2=80=AFAM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
>
> On 2024/7/23 13:59, Richard Henderson wrote:
> > On 7/23/24 15:29, LIU Zhiwei wrote:
> >> The more detailed information about its meaning is in priviledged
> >> 1.13 specification. More exactly, in 3.6.4. Misaligned Atomicity
> >> Granule PMA.
> >>
> >> The specification said:
> >>
> >> "The misaligned atomicity granule PMA applies only to AMOs, loads and
> >> stores defined in the base
> >> ISAs, and loads and stores of no more than MXLEN bits defined in the
> >> F, D, and Q extensions. For an
> >> instruction in that set, if all accessed bytes lie within the same
> >> misaligned atomicity granule, the
> >> instruction will not raise an exception for reasons of address
> >> alignment, and the instruction will give
> >> rise to only one memory operation for the purposes of RVWMO=E2=80=94i.=
e., it
> >> will execute atomically."
> >>
> >> That's the reason why I do not apply zama16b to compressed instruction=
s.
> > Given the non-specificity of this paragraph, I think not specifically
> > calling out compressed forms of the base ISA is simply a documentation
> > error.  In general, the compressed ISA is supposed to be a smaller
> > encoding of the exact same instruction as the standard ISA.
>
> Yes, it's a documentation error. We will fix in the specification.
>
> https://github.com/riscv/riscv-isa-manual/pull/1557

Thanks for getting that clarified

What's the status of a followup patch? We should fix this before the releas=
e

Alistair

