Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC8DC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 06:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWsFO-0008Nm-7c; Mon, 05 Feb 2024 01:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWsFM-0008NX-Kx; Mon, 05 Feb 2024 01:14:24 -0500
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWsFL-0005YR-5T; Mon, 05 Feb 2024 01:14:24 -0500
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4c0375d438eso80437e0c.0; 
 Sun, 04 Feb 2024 22:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707113662; x=1707718462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp1vySsje32PonhFvSsuRtSEy3EEW9A3CThYGSbxoNk=;
 b=mzysSK9rK1nUPbFMglrBQDQTcX/e8R+UbqokvWLvFgp3WUWbjt5m0BizPk69lNfh6F
 bTlpj4QvE7f+vlnyNPveEP6g6BC8CSn20vuG9qt4J8FR5vK5/FiXCI+5FiFnWCcUdOoC
 UR18rFXc4yp2UqNx4QPw6mGEKo74quJ+yKV/lHO6RNWujKZX66B4NrXQHZjuPSa0B6wQ
 ZrixgV1Hz5cMigT9NGwubXc7wwdAnu5468GWm+8A2yHrMAQzfBCqllWsN8yHZ3peV68o
 psvN1D8OXIt/8LvwV+ZDYFBNV6KCCudtEh0gJ/+TnFCNSHJJ5skPDoCNXdU0WitFiGiI
 0W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707113662; x=1707718462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rp1vySsje32PonhFvSsuRtSEy3EEW9A3CThYGSbxoNk=;
 b=EFWYmMtKqGP1ySkGQ7rdgvzsZsV50FF8WLZtX+uZq5yJouQ34bF4sm9AasJIrXkT/d
 3x39o/PW+KEmROh7Stg6bM3hKCzX0cmGtYwl2hkXKiU0D+3Lc4yjBltGqxWgEzzENA93
 x/FgUUZkVNSgZKH23rmZDonyKiLYqmBqn0Qp17qutacPA0pULej02ciSO0j2W+8bFkC3
 lYjKbwS87BLp/RwmEK93TYhng7RTen4M6xz4QdCkwurWf1rk9frVqms1RuSv4GySfbnM
 nTBvlJK9vslpxST45zxCzY2Rn8nwBe4bU8xMtftWnSH9UQJQW+m9Yt8YGVsKS584IQXn
 tFYQ==
X-Gm-Message-State: AOJu0Yws/sjdpT9vgn+yd3X3+MAPwSHqWsOMPGEgU9DrXn5FCpH+NLrJ
 skC+GDyqJL1YJvv68x4tWtZ34l/6Ur+F8cAgb6Z+BdhYEfd2/gTrpQDzb4QZLR9mMrYSUXesJlI
 FarMFGwgwVyDNwx97R1LCexBNFgs=
X-Google-Smtp-Source: AGHT+IHYXM6QbMu/LRf9k899rjIJUpmA40JfROicvcMhQGCZu3ZEU7J/9Sj6pkbtFPxFA8ofxJkG1xsR3s8lfz7bThM=
X-Received: by 2002:a05:6122:c84:b0:4c0:2182:3cdc with SMTP id
 ba4-20020a0561220c8400b004c021823cdcmr2040886vkb.1.1707113661763; Sun, 04 Feb
 2024 22:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 16:13:55 +1000
Message-ID: <CAKmqyKMvtwOm4-16AUoYFywajJpGDSzLNqbfyjVtjD2KbVGo5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] target/riscv: SMBIOS support for RISC-V virt
 machine
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Wed, Jan 24, 2024 at 4:44=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Generate SMBIOS tables for the RISC-V mach-virt.
> Add CONFIG_SMBIOS=3Dy to the RISC-V default config.
>
> With the series the following firmware tables are provided:
>
>     etc/smbios/smbios-anchor
>     etc/smbios/smbios-tables
>
> Add processor-family to the '-smbios type=3D4' command line options.
>
> v4:
>         remove a superfluous #ifdef
> v3:
>         use misa_mxl_max to determine bitness
> v2:
>         set processor family
>
> Heinrich Schuchardt (4):
>   smbios: add processor-family option
>   smbios: function to set default processor family
>   target/riscv: SMBIOS support for RISC-V virt machine
>   qemu-options: enable -smbios option on RISC-V

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/Kconfig             |  1 +
>  hw/riscv/virt.c              | 42 ++++++++++++++++++++++++++++++++++++
>  hw/smbios/smbios.c           | 20 +++++++++++++++--
>  include/hw/firmware/smbios.h |  1 +
>  qemu-options.hx              |  6 +++---
>  5 files changed, 65 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>
>

