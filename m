Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D50D74956
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5xlS-0000ch-RS; Tue, 29 Oct 2024 21:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xlR-0000cV-Uf; Tue, 29 Oct 2024 21:44:49 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t5xlP-0001Zv-IQ; Tue, 29 Oct 2024 21:44:48 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-851e191d541so1784776241.1; 
 Tue, 29 Oct 2024 18:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730252686; x=1730857486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plF+Ii0edVLjr9Heasvqf5kMJDcptv+0rO3JZZRBeIE=;
 b=iyuGooRVQQDwg3Exo12JzsAKpKx3lzemuGCIgbvHn8SGwQgp+cMVYoPpQxSKGoz87J
 rIQ6V64kE8TjQk4IxqwKNmBCrHyyZ2j+4TSEv4t89RPlbqPh0lxsNz8XsunN0LYCovkE
 PKSkUUtUAzDyvsw2znEaSMFkZim4u/h/OOPT7hORlRvp8jRw8XlggiAEO86beqokVeVL
 ibNxXYByfRUH+LQ+pKDyB4IUrn/8M1YS7t6BKCT5w4OyDC9Ku9AZGIVeGTV9gnKkZ189
 ZxE7vsZGLE49jap2Vf/BTx0+Lt6ioMzHIcXbp10fHSFLfVDdGz3XnRSka7+GIYZaGBFP
 lmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730252686; x=1730857486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plF+Ii0edVLjr9Heasvqf5kMJDcptv+0rO3JZZRBeIE=;
 b=bldGMZRPovP+ES3jpbPDjy56ocxfef8lxIRaptYU6bqUoC5oxRLXeniykEfqjQV62c
 ZXGCEaoiqQECZeWNlFjCItfk0BDxYu80J8zaCk7fmLoHUjnc5HBEgAUZlYztQoBzggVO
 oRWrq7rLzlgiNPBOXC9FIxPLxyfqis51HyRnRW/prQnxClltbr5mTpGv3Q72VOoW1KRR
 Dr9ABD7QJ0XA/TtWnx0tHT3S379CHZFEHAYPbASMBBXnq+lCT0cbnfWA9m4u5Z7WI+DI
 O06DS6v9A8guGfN0W+YtjMkj2YRawr+h1gnQGMmXJMf1qrwOuSl3lPrPJ7C4qzKe/NuU
 63wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzGrboElx4jQ9MDZ+eRyIBmvYcFpwmKq33OWJQ1dU8Bh7ReCbNxQnaj8NNGnvuRyPfEMM2KKpXvkjH@nongnu.org
X-Gm-Message-State: AOJu0YyN/zpY2dSv/ju8S9GMyx1tJW5A1NBGsFOxXwRWavpG3km03rGS
 4CUM3zTknR/MrPPxfku6RRKIdPgASHrc1oxlZ703ADwGRq/nCJhJqBo3BOGnKloakZDecNM+NiX
 eznUMFz6uLwv9CAj2vZa9CuQ3noc=
X-Google-Smtp-Source: AGHT+IEBDrWTpNK+F34enXrhYRwI2/IzAGKCN1Stcn8OC+Bigvw1dKiTuGCHJpDmlU1EqvPKR9exUQ0V+EqQ+NeqNYU=
X-Received: by 2002:a05:6102:c4a:b0:4a3:fc62:3ea8 with SMTP id
 ada2fe7eead31-4a8cfb25a75mr12680378137.3.1730252685718; Tue, 29 Oct 2024
 18:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
 <f6d26471-9137-498f-b295-2bd6fad7241f@ventanamicro.com>
In-Reply-To: <f6d26471-9137-498f-b295-2bd6fad7241f@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2024 11:44:19 +1000
Message-ID: <CAKmqyKPLdt3KQqzGSMVov2557MOsEmzP=+g9iR-irw_4YK8-mQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/riscv/kvm: add riscv-aia bool props
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Tue, Oct 29, 2024 at 4:01=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> I had a change of heart w.r.t this work. I still believe that the boolean=
 properties
> are better to deal with since we don't have to deal with string parsing, =
and that we
> should avoid creating new string props in the future.
>
> But as far as the user API goes it doesn't matter that much. Having to do
>
> -accel kvm,riscv-aia=3Demul
>
> or
>
> -accel kvm,riscv-aia-emul=3Don
>
> is basically the same thing. Deprecate properties always creates some for=
m of hassle
> for existing scripts and whatnot and we should avoid it.
>
> String properties aren't that great to report to APIs though, so what we =
can do is to
> create internal bools to track the string value and then use it for QMP.
>
>
> Long story short, I'll re-send this series with only patches 1 and 2. Tha=
nks,

Ah, I should have read this before responding to your other patch.

Sounds good to me. Although I don't have the same dislike of string
properties as you, but I guess I'm also not using APIs :)

Alistair

>
>
> Daniel
>
>
>
> On 9/24/24 9:44 AM, Daniel Henrique Barboza wrote:
> > Hi,
> >
> > Boolean properties are easier to deal with in the protocol side (e.g.
> > QMP) since they don't require string parsing. We should always use them
> > when applicable.
> >
> > This series adds 3 new riscv-aia bool options for the KVM accel driver,
> > each one representing the possible values (emul, hwaccel and auto).
> > We're also deprecating the existing 'riscv-aia' string option.
> >
> > The idea is to use the new properties to enable AIA support in libvirt.
> >
> > Patches based on riscv-to-apply.next.
> >
> > Daniel Henrique Barboza (4):
> >    target/riscv/kvm: set 'aia_mode' to default in error path
> >    target/riscv/kvm: clarify how 'riscv-aia' default works
> >    target/riscv/kvm: add kvm-aia bools props
> >    target/riscv/kvm: deprecate riscv-aia string prop
> >
> >   docs/about/deprecated.rst  |   8 +++
> >   target/riscv/kvm/kvm-cpu.c | 100 +++++++++++++++++++++++++++++++++---=
-
> >   2 files changed, 98 insertions(+), 10 deletions(-)
> >
>

