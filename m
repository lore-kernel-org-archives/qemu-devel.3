Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC05C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 23:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAH3f-00018S-Qm; Wed, 30 Apr 2025 19:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAH3b-00017G-CN
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:41:39 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAH3Z-0003h6-MU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 19:41:39 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-877d7fa49e0so274501241.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746056496; x=1746661296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nIo+B+FB7JUgd3BdCGZVRcayO+o9ImyQz+XIjMdkFA=;
 b=eGFx9AXuzNWNzcw1nuFUN1GFRXbHlGQxdJ8OpdooCimbdVsIXAC4fi0m1yUdiN4VqK
 /0BKOQIklXb6nqph914pNXw/BMj2cteo3olwO78+iHFG5GHC+Z5W/dtrwCbEzL5+FePb
 vcRA7B0LgkLwsNlaNRPM0Iff7RRhfv5q5dD7s5Xx98lLL0HLmloVd+a02dpDxjiJfES+
 aI9Gdu/MbSlO4n/WN/OfFxeEybBfYff1+FkgAhvbpHhe6FDQqm5dzOL4kY9IixbDlFyI
 MmXe0x/7S1okjvMUmLD/jnXquwEzGkNHxlY/a1H0H6GN8Z8GIh6kp/0hLKtg8dESu4Hp
 O1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746056496; x=1746661296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nIo+B+FB7JUgd3BdCGZVRcayO+o9ImyQz+XIjMdkFA=;
 b=ciqhKO/TQ911OpM19848s79vWmIawJo6tvGKs/NRc3e32jdyHyUImjozOGcJdAeTG6
 v06a8nZl6NhIj5TlcLJNIvdjqLNkeaM8loQ9zkTPYQjpAU7dwueQMWK+evKmwZ2/G61B
 i1bzCt9MaMKG1JVG4g/5qJEhfzBQRShTvEMoRWNlRJyrL+nLH+R2V4cVkVerPj7F325S
 Y+qEFxjOm9Yy/I0aftoTQ9JZcXMWsgBuSIEDmIRf+PeFi+bjalQUl4ObCNy27lST5XMK
 M5qwoADehuYfvFaMeRZM5D7OBLV8Vis8KpVkN6gl1eMtNFxWhsIJRU5JkIAJiQ9E2QUu
 nsXw==
X-Gm-Message-State: AOJu0Yx9mDamqSxvIvnTWwWlJ4qwlvumUH59K1TgGe9atWb/azL4uQT3
 2TrSJzJ/ByocP84EAAh9KUwAbCH8+3hsrfnP7eBswGFOL2+E2muXw0vDsJvgIpGDxqmZW676xMl
 1s6H2qVHdhVt8YmzHqGCYZ87BE40=
X-Gm-Gg: ASbGncssOa3O0n9lb1JlMCnTupc3I5vG/wZmcRAxuL77pQgDSM66v/35gdCKBZjTEQN
 mEjKTsl39gCP/f7p6iImCIujAMcXDgKJjKGuhbUHNnPSyM4rcX8DPfMajf9lo4jWFBOxc90aTTy
 YYBITLL9td9mL2vVS1uCYcPG7fPtE7AnK6z3skRg1ru0lc5hdlZRgs
X-Google-Smtp-Source: AGHT+IGm6HdDPePiO3RYADMFo7wGqwLhgMwz83wlTL/+X9pT7q+2lGpqNI6Q3L6u+eYUVTHEIu/OvRHx0+jgLfBfja8=
X-Received: by 2002:a05:6102:2c17:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4dae926fad9mr218767137.19.1746056496067; Wed, 30 Apr 2025
 16:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 09:41:09 +1000
X-Gm-Features: ATxdqUF005LrIvTFFHDqVj-D8te9RyyRbFg6DbvsXDxYvUl1uR-ePAL9LLi0Lgg
Message-ID: <CAKmqyKPBpOckC6-7TB2pdMLjjeCRyV4JDXeufcEEdpkvmocV6g@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] target/riscv/kvm: CSR related fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Tue, Apr 29, 2025 at 10:46=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This version has a fix on patch 8 where I did use an extra variable and
> happened to set the wrong mask too.
>
> We'll let the compiler cast the uint32_t from an uint64_t reg. A cast
> was added for extra clarity when reading the code, although some picky
> toolchains might require an explicit cast in this case too.
>
> No other changes made.
>
> Patches missing acks/reviews: patch 8.
>
> Changes from v4:
> - patch 8:
>   - remove the 'reg32' variable and add an uint32_t cast when passing
>     the uint64_t var 'reg' to kvm_cpu_csr_set_u32()
> - v4 link: https://lore.kernel.org/qemu-riscv/20250428192323.84992-1-dbar=
boza@ventanamicro.com/
>
> Daniel Henrique Barboza (9):
>   target/riscv/kvm: minor fixes/tweaks
>   target/riscv/kvm: fix leak in kvm_riscv_init_multiext_cfg()
>   target/riscv/kvm: turn u32/u64 reg functions into macros
>   target/riscv/kvm: turn kvm_riscv_reg_id_ulong() into a macro
>   target/riscv/kvm: add kvm_csr_cfgs[]
>   target/riscv/kvm: do not read unavailable CSRs
>   target/riscv/kvm: add senvcfg CSR
>   target/riscv/kvm: read/write KVM regs via env size
>   target/riscv/kvm: add scounteren CSR

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h         |   1 +
>  target/riscv/kvm/kvm-cpu.c | 333 +++++++++++++++++++++++--------------
>  2 files changed, 212 insertions(+), 122 deletions(-)
>
> --
> 2.49.0
>
>

