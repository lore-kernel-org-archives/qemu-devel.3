Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0EBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5Zt-000861-0v; Wed, 31 Jul 2024 05:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sZ5Zq-00083F-VX; Wed, 31 Jul 2024 05:24:58 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sZ5Zo-0002lj-P6; Wed, 31 Jul 2024 05:24:58 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f887be28e7so382714e0c.0; 
 Wed, 31 Jul 2024 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722417895; x=1723022695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Jayg4YpesIUFmSzOQx8yfPxf2EaIc/yAu+YPnYVDyw=;
 b=bfmG57hBWzlZLLITVhxXlthRRcLnElKnH3BFIWTZBaGoSXC+y7CEAIO6Ls2LfMlT6n
 yLFyupNJEfdAw8YZL6nAqRkEXFlHDURWTKB6dmO+J2e+Eub3XjvdeMAerTLXS5+/7IZP
 MjgmpKLK8E5RELqvhihQF+TB1NaIiw6lZ858Y8NRv/C/m2SPqHbKy5RWIzC53p8usGZD
 cTC/pLqOPtAYtMT69A7PZvpZUjuvZy2L7vxN8jjWwSXsZlYNAXk0W4tO3AGIMC3Hj9F9
 vZs3hWOSlBHfjc27cbIm+LY3NJn/YwrN+qkF7LihecZg8ZIfGmicetD1n9QBSMC3+3t1
 hQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722417895; x=1723022695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Jayg4YpesIUFmSzOQx8yfPxf2EaIc/yAu+YPnYVDyw=;
 b=Y1HHuzbdYTnKVQWm2PQ5Nu5giJWHEocf2VevUrlCg5+yCB8MVEXJJ/+Pg4RuZiXYFG
 m5vRo3q9UnWHwuNmGbnYNakb8455EAseGq2RQ7fjOz4CN1Y7q+Gpk4+E+rVgKDvd0qCe
 FYLJ+n1SAJ313k95HEjRDZoqG+BKaM3+qF5NxB7lQRjeQTdvtFVeUs24ukITNYKGgzBs
 S6fIKr8mB7+zbYhf7XpNxRbntY4ohCCZtxFkL5f8hYaJgl1FM8aSlq0CZAiJJuXAM210
 +PfQs2jT/Yp6vpelaXbQ0Nn4bs/nCb+qyLxyCaaTl5+rMv4+oM6KEV0hjqbbHMRiN/KH
 pYMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCc+CCy5m2449ydPfVb8QbJjXJah3sLDsPljO2IR+UO3A9bsMMlK5IViq9+54x0WhZ2OkJDJYd4uL12qHZBzh/dmEZu4w=
X-Gm-Message-State: AOJu0YwtWMdshiD8kRVe5zXrar4m/xazMy54a1wAQap2QznRYOITTP25
 /5UIFAmC9BAQHocRzSC1GyIifriRha0U023tceE79UJK2njsK5oyAPNmrtXvmoHgKi9NQeulOMl
 vW29YmHLIhl6MRW1jomOasDzrtjU=
X-Google-Smtp-Source: AGHT+IF/YWppTpdxJMj9A6BiL4tBBYHN4lBA4coQy86v5jvgdznXotR6VWuqRTS4bbi6+Uc1BMLZ3m/2AyYYTDc55NU=
X-Received: by 2002:a05:6122:3bd1:b0:4ef:65b6:f3b5 with SMTP id
 71dfb90a1353d-4f6e6980cdbmr15392943e0c.10.1722417894758; Wed, 31 Jul 2024
 02:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-1-c4170a5348ca@rivosinc.com>
 <CAKmqyKPEWgA=s5sokPG2_v2qdbuaHwdGf6RJzqFfL15Htq=vBA@mail.gmail.com>
 <CAHBxVyGzogwFhFu+kF=PvVEJ+Mm_1EYyaHD+6NR=mh9WrrEBBw@mail.gmail.com>
In-Reply-To: <CAHBxVyGzogwFhFu+kF=PvVEJ+Mm_1EYyaHD+6NR=mh9WrrEBBw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Jul 2024 19:24:28 +1000
Message-ID: <CAKmqyKOc0GmuSXK1PZi4CHSVDJcyNG7wP+m6TD8faFPXH4vhBA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] target/riscv: Add properties for Indirect CSR
 Access extension
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Sat, Jul 27, 2024 at 11:33=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc=
.com> wrote:
>
> On Fri, Jul 26, 2024 at 12:42=E2=80=AFAM Alistair Francis <alistair23@gma=
il.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 9:31=E2=80=AFAM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> > >
> > > This adds the properties for sxcsrind. Definitions of new registers a=
nd
> > > implementations will come with future patches.
> > >
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > > ---
> > >  target/riscv/cpu.c     | 2 ++
> > >  target/riscv/cpu_cfg.h | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index a90808a3bace..ebc19090b40d 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -183,12 +183,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> > >      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> > >      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> > >      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf=
),
> > > +    ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_12_0, ext_smcsrind),
> >
> > This is actually part of the unpriv spec, so it's a bit weird that it
> > depends on the priv spec. But that's how it's all set up.
> >
>
> Smcsrind is part of priv spec[1]. Am I missing something ?
>
> https://drive.google.com/file/d/17GeetSnT5wW3xNuAHI95-SI1gPGd5sJ_/view

Ah, I just saw

"This specification has been merged into the Unprivileged Specification" at

https://github.com/riscvarchive/riscv-indirect-csr-access

Alistair

>
> > But shouldn't this be PRIV_VERSION_1_13_0?
> >
>
> Yes. Sorry I forgot about that. smcntrpmf should also be PRIV_VERSION_1_1=
3_0.
> I will send a fix patch along with the v2 for assert fix.
>
> > Alistair

