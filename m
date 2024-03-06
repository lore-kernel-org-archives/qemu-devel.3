Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB4EC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhhPc-0006uY-PW; Tue, 05 Mar 2024 21:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhhPb-0006uK-9N; Tue, 05 Mar 2024 21:53:43 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhhPZ-0002vI-S0; Tue, 05 Mar 2024 21:53:43 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d5bfdd2366so3467030241.3; 
 Tue, 05 Mar 2024 18:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709693619; x=1710298419; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHi4YE8tq+lgh+dnv2SG687E5JCQxhq83mPPIfidnTY=;
 b=RTRUdTCl+AYVIoPUzVEWblmYx04XfQlGaaL3eN9gnw2vDBpGOm7ev8dRQzFn7NmPKK
 r45Q++B3PvufCPEbok9GCA5qIHvPS5YPWHZe7y2zChHfjHlSYcZBEzMujFtRQ2O9Ejf3
 ENgqDDcQk/7uov977tJVfW15rpkmVnaV9Jy/26a9N4ljdWVOnYhRTfGhDq16LvcxO7uG
 V88nrmZMfbBVxsl+9QeHxLsuISvQpw+tAEdkw5brJsLLWfxTixMSJBIql2fcJZXpgt/t
 iWxaHsSmSH/G8XkDhZ9KX7Qaehf+uidaY6RGUiyCNRVL+bs89e+GEQvddk1dTt1cULgr
 dc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709693619; x=1710298419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHi4YE8tq+lgh+dnv2SG687E5JCQxhq83mPPIfidnTY=;
 b=nOR7SJLdwvmGNRhMxIbdg5cLhtPLzs/N0zmZf+y2rda9KnpjtjwIC0oY9IeOMhS4PW
 Nyn3CdV8MrQTS0uevRQIHKFL9Rm+Md5uFyl7tBCfwzgb8P4A9I4QA6xdG73vCV/+ryeT
 75OXvX76guIE5+IjOU1FrtvbpddQT9lZCBus/n3Sg4ORZ4T2KzOmwAH3a3wwjxokcUTS
 OeK77+Ufp3+acLSGnwHtX1p01CYHGlnFlx641Mjx2I2w3JwYPSsJeyKuX2nF/MbHSEy1
 duDofERmKuvYA086DZXuuxYd7a4Q53COaynmFdabqOrv1afN6EVVltRXBz2T3T9Rc8QQ
 G/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8+Q2PhYfLmsRnp7Uf8JIRTzAeE14SMjLkoTdstQsr90GA1eOhej2RCaTz5wix3nYS1d1kaSP0T1QTuPuuOybHX/do3x0=
X-Gm-Message-State: AOJu0YxmILH/6dWIlXqDWtS+0b3Ju8OIlu954PtUvszoX1mZzYJy4G07
 wYtiH32NOxZEmVBIPXa2wXzZZJv4q/e1HWdqbUOAoL0pbwDqmNUUqZzQxDlfCafdLbj5HfsPeA/
 Ktth+rhEBPOXz1srExP5b6gOqMKs=
X-Google-Smtp-Source: AGHT+IGrwUIqd83X4wlAuInJiOqaShFfcXk8VZFhzNu9vyXnK8raSsTMYOCaaqdHO2MxUlehAU8nf6YqCAF6EfxfXMg=
X-Received: by 2002:ac5:ce9e:0:b0:4c0:254f:75d5 with SMTP id
 30-20020ac5ce9e000000b004c0254f75d5mr3820012vke.10.1709693619462; Tue, 05 Mar
 2024 18:53:39 -0800 (PST)
MIME-Version: 1.0
References: <20240304134732.386590-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240304134732.386590-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 12:53:13 +1000
Message-ID: <CAKmqyKMvbLheLiExSgKQEykc7XAgSLw+TZsoKU=etJmi0nkAMw@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv/kvm: update KVM exts to Linux 6.8
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Mon, Mar 4, 2024 at 11:48=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> Let's update QEMU KVM extension support up to 6.8-rc6 before the 9.0
> freeze.
>
> Patches based on alistair/riscv-to-apply.next.
>
> Daniel Henrique Barboza (2):
>   linux-headers: Update to Linux v6.8-rc6
>   target/riscv/kvm: update KVM exts to Linux 6.8

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  include/standard-headers/drm/drm_fourcc.h     |  10 +-
>  include/standard-headers/linux/ethtool.h      |  41 +++--
>  .../standard-headers/linux/virtio_config.h    |   8 +-
>  include/standard-headers/linux/virtio_pci.h   |  68 +++++++++
>  include/standard-headers/linux/virtio_pmem.h  |   7 +
>  linux-headers/asm-generic/unistd.h            |  15 +-
>  linux-headers/asm-mips/mman.h                 |   2 +-
>  linux-headers/asm-mips/unistd_n32.h           |   5 +
>  linux-headers/asm-mips/unistd_n64.h           |   5 +
>  linux-headers/asm-mips/unistd_o32.h           |   5 +
>  linux-headers/asm-powerpc/unistd_32.h         |   5 +
>  linux-headers/asm-powerpc/unistd_64.h         |   5 +
>  linux-headers/asm-riscv/kvm.h                 |  40 +++++
>  linux-headers/asm-s390/unistd_32.h            |   5 +
>  linux-headers/asm-s390/unistd_64.h            |   5 +
>  linux-headers/asm-x86/kvm.h                   |   3 +
>  linux-headers/asm-x86/unistd_32.h             |   5 +
>  linux-headers/asm-x86/unistd_64.h             |   5 +
>  linux-headers/asm-x86/unistd_x32.h            |   5 +
>  linux-headers/linux/iommufd.h                 |  79 ++++++++++
>  linux-headers/linux/kvm.h                     | 140 +++++++-----------
>  linux-headers/linux/userfaultfd.h             |  29 +++-
>  linux-headers/linux/vfio.h                    |   1 +
>  target/riscv/kvm/kvm-cpu.c                    |  29 ++++
>  24 files changed, 410 insertions(+), 112 deletions(-)
>
> --
> 2.43.2
>
>

