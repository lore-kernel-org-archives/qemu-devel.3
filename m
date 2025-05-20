Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF85C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMHp-0006dz-Uv; Tue, 20 May 2025 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uHMHg-0006dC-2h
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:41:28 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uHMHZ-0006G3-Pz
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:41:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso9897951a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1747744879; x=1748349679; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C5/Lmygrmg6XoOb5JC0J9Qx4nki1DsHe28Maa24ur/M=;
 b=BizEpz48WP3khNDSgjaDkw864/QRihMEjKLanfjmz/k5gQgc3a4R7bxGqn0Zsy1L+y
 +/IUr95xlNo2tc4+adyBZAnk++W83AHk6m68VjYOlFP8lKni9H/uKE80ViG8JSoiLU3l
 E6SKseTzJMSfF4EOVD9EindaGPwYUhkKy4pdtnjNIq7aqq9vpaDJT2BKfj1quUJmf8CP
 sp+r+HEicGuXbikl2RfPeHwZZ40l6+FXnt0+Y6S1vT2HKUECgMe0mJ3vCHGvhttpAP+5
 0SXSmjOoPU+7DF7Zn4jO0ZW2eT8ThtR+YLbQM/J234KcNey72RzyXFE3TqkLhaDNo8+I
 rfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744879; x=1748349679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5/Lmygrmg6XoOb5JC0J9Qx4nki1DsHe28Maa24ur/M=;
 b=mnhjoynuhxeHCXtfRjbZuFtFUdh3+4lqOvWevxVfi5uWIs4b2aF0JCgnHpXaAXFCFe
 6GYZMv9s1HeVENWug/qIpGIsqgb+rteLb1xtHGmXGLkDKDbxiG5Gluswigj7yVpE9Zdn
 JKDWLez8UG99MFVYoV4pNPv35KgmCXXNavpspfDmJYa+Nb0aYLkdoFmfEoiEyrWF8S6Z
 PwPKz4t0lxc5lmNqeO9BEYxLc3wIAgznygrvM7zA62ylGOOAIwvyzTt0uNNaLp8xSw2k
 G+KD0Lo0PnpDrGTZNMPWYhs+KJinDtPviwD8PS2+sz9dr2KSdWNjTp7VDwC9VdtoLvil
 1PZA==
X-Gm-Message-State: AOJu0Yx0pgafLv749nL7g8WjAENmB4hY6LVI0qDruv3IQpyzOqM6hpxa
 ZolomANRuDKoy85pFh6kKRfw3T44A+1xJDj3zz2Phpn4tFzWdz+2nlwBT64Jt6dJY8RuT88MVr9
 1r+9oleENZ26xEFcQOk+dicAEki2uRLrlxHO5kzS/
X-Gm-Gg: ASbGncsGzqVid31szHUsEXQLAGcRVCV5cvrnNJ4Zq2iX8P/UglbH2q+gxaAyLqWoIlh
 ezncI/RXmSCjcLKdKoeEf7n07cSOQb7zbVLYBsgT8V/Z70uG8TbPh4aKwWwbpgSElCqLwywJ2SW
 G03P5AbQ+NbjWjEc7QlTPU02I9cFTPvJaeT5P//ftZacg=
X-Google-Smtp-Source: AGHT+IFqw60HRcMrcOKB0+OUHSySk/PPT5tPZeLjOrxBFo99AH3KwESLvNe3SVr7cRA/tdHJF09TSKpn8m8Dw+7ZoAw=
X-Received: by 2002:a05:6402:4410:b0:5f4:c5eb:50c9 with SMTP id
 4fb4d7f45d1cf-60119cc8f77mr13905530a12.21.1747744878652; Tue, 20 May 2025
 05:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-5-chigot@adacore.com>
 <CAFEAcA8qA-ZyWihgSkw3Ubnz-WyXMB3m_MT9facnktqbXAM7MA@mail.gmail.com>
In-Reply-To: <CAFEAcA8qA-ZyWihgSkw3Ubnz-WyXMB3m_MT9facnktqbXAM7MA@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 20 May 2025 14:41:07 +0200
X-Gm-Features: AX0GCFtNX5fMX53zM9rw2kMDpyjIHgK0FqtVBTsMbycd8J1AkIw6lw9nPS87Sh8
Message-ID: <CAJ307Eiqdaki-v1JNY2t4idbxbDiBWcDTRJeBp8A6+nGYE+M7g@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/arm/xlnx-zynqmp: adapt cluster-id based on the
 boot cpu
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 19, 2025 at 5:38=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 13 May 2025 at 15:15, Cl=C3=A9ment Chigot <chigot@adacore.com> wr=
ote:
> >
> > When gdb is being connected to QEmu, it will be attached to the first
>
> (QEMU is all-caps, by the way)
>
> > CPU cluster. However, the ZynqMP board has two clusters, those being of
> > two different architectures.
> > Therefore, when gdb is connecting to the ZynqMP, it receives the target
> > descriptor of the first CPU cluster. Up to now, it was always the APU
> > cluster, which is AARCH64.
> >
> > When booting on a RPU, gdb will still connect to the APU. If gdb is
> > supporting only ARM32, it will receive the APU target descriptor,
> > resulting in:
> >   | (gdb) target remote :1234
> >   | warning: while parsing target description (at line 1): Target
> >   | description specified unknown architecture "aarch64"
> >
> > Adjust the cluster-id based on the boot cpu will resolve the above
> > issue; allowing a pure ARM32 toolchain to debug programs running on
> > RPUs.
>
> I'm not really enthusiastic about renumbering the clusters
> like this. I think you should be able to get gdb to connect
> to the second cluster via the multiple-inferior support:
>
> https://www.qemu.org/docs/master/system/gdb.html#debugging-multicore-mach=
ines

Sadly, that doesn't work. `attach 2` requires the connection to be
already established. But it's being aborted as soon as gdb can't
decode the XML provided.
  | $ arm-elf-gdb helloworld
  | (gdb) target extended-remote localhost:1234
  | Remote debugging using localhost:1234
  | warning: while parsing target description (at line 1): Target
description specified unknown architecture "aarch64"
  | warning: Could not load XML target description; ignoring
  | Remote 'g' packet reply is too long (expected 168 bytes, got 268 bytes)=
: ...
  | (gdb) add-inferior
  | [New inferior 2]
  | Added inferior 2
  | (gdb) inferior 2
  | [Switching to inferior 2 [<null>] (<noexec>)]
  | (gdb) attach 2
  | Don't know how to attach.  Try "help target".
  | (gdb) info connection
  | No connections.

FTR, I tried to find a way to adjust gdbstub.c to retrieve the
boot-cpu or have a different "first cpu" according to an option. But
this was far more complex than just that patch.
That being said, I understand that this solution is far from perfect
and I'm fine keeping it as a local patch if you think it would bring
more pain overall. There is a simple workaround/solution: have a gdb
understanding both aarch64 and arm32 when debugging ZynqMP programs
(something we cannot do that on our side for various reasons
though...).

Cl=C3=A9ment

> thanks
> -- PMM

