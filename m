Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEADC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 04:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSrfM-0003gY-FH; Wed, 24 Jan 2024 23:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSrfL-0003gM-2T; Wed, 24 Jan 2024 23:48:39 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rSrfJ-0007fq-3z; Wed, 24 Jan 2024 23:48:38 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d2dfe840f2so2131697241.3; 
 Wed, 24 Jan 2024 20:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706158115; x=1706762915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eG06+ZtlmCm7ejlN6thPQHB616F4x3lro8dDncABOw=;
 b=LasMkbI5rE8JOSFipbLzbWDfIPYYvpimpfBUZpRiou5NanbiD81GR2I2U0S4t+Qykp
 zUqSCsYGkOgetZwNO4tvfwmlyzgzEJ+OoQAoljCmPapSkj6qQxEGLin/6prmF6mwmqXe
 gIXgHHL5xSTIF+wvNJ9ZA+h3kBY/EPtN8ZwWA1GybPneh5Ts7FyiZ+pIndIoVcc85yas
 VntuA+YBQ51fJm6I9P594ADlK9OgSv0Wk38iEkB8ntlELb/U4C7k3O3RkymCxY8vC1PY
 mXqEdXUqMQUMzT7jQK0ft47xfxbJuadlNO6IWWJlSb6BtdSkHxTF7hN+vpLyp6njBezJ
 YZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706158115; x=1706762915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+eG06+ZtlmCm7ejlN6thPQHB616F4x3lro8dDncABOw=;
 b=fkmkDR0ElzQRzJLVX4iineBy5PlhdrRLj1shJgaYIzg7Y/hJJjj3Lq1ihHSzo+QipR
 I+Gr9lxYL5ULAgHSORlA1Prku7wS0/Xd0cc8ORLCTlfdVWbeFouKuX7cg/xgOWtRNPMa
 4sTIysJdDRKjaybkSmv+mbn4SQLmypSPvPUOMaE1MeWIkb4TGD4q0i9EAw8mpeCdKdsA
 wXI04jSIopf6bBywEtIjqnZcH6sOUMVSgXOSJd2WjwiQvPSVhFkVMUyVE4M+0eIgXCVb
 IqZ2sWSLHqt6/G9BTfv6a5Vs7daXdawfiMlHwLkH07coZqYEfqLPXbuvbeZpw3jDwKcy
 vQ1w==
X-Gm-Message-State: AOJu0Yzf3SeIv4VuEv19pw2tHeLVop69JLdDv9AKttCUNWCWCVyYUPdC
 KdgdJP7Xekf0kkrl5CnkFZCMKuXdwF7NViRKrQ7W3D1qO81Xe6irFSH7r3ACOxCKmRTPkNBQYeB
 dbOhe/pkWzJ55uEORL77MUHFHqRQ=
X-Google-Smtp-Source: AGHT+IG/i9EqdckoZ8/npx8R2icKu5Lx61HAxGguDtyQL1YOkah/oLuIahJkHMnDYxVLE05LOWzRsnOFty3ajUNCq+o=
X-Received: by 2002:a05:6122:a03:b0:4b6:b979:a28 with SMTP id
 3-20020a0561220a0300b004b6b9790a28mr273991vkn.17.1706158115654; Wed, 24 Jan
 2024 20:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240123161714.160149-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jan 2024 14:48:09 +1000
Message-ID: <CAKmqyKPoZLr_AOeRhUAVor3m+c66sqqFsvN3AnNpHNmyfmPdRw@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/riscv/kvm: support 'vlenb' and vregs[]
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 2:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This short series implements both 'vlenb' and 'vregs[]' in the KVM
> driver.
>
> The patches were done a couple of months ago but we were missing some
> changes in Linux (support to 'vlenb' in KVM) that got upstreamed
> recently with Linux 6.8.
>
> Patches based on top of Alistair's riscv-to-apply.next that already has
> the 'remove vlen, add vlenb' changes.
>
> Daniel Henrique Barboza (3):
>   target/riscv/kvm: change kvm_reg_id to uint64_t
>   target/riscv/kvm: initialize 'vlenb' via get-reg-list
>   target/riscv/kvm: get/set vector vregs[]

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/kvm/kvm-cpu.c | 144 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 6 deletions(-)
>
> --
> 2.43.0
>
>

