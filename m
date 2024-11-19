Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE321D60D0D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDELI-0003q3-4E; Mon, 18 Nov 2024 21:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDELF-0003pS-Nt; Mon, 18 Nov 2024 21:51:49 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDELC-0005SX-3o; Mon, 18 Nov 2024 21:51:48 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5101c527611so1045457e0c.3; 
 Mon, 18 Nov 2024 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731984705; x=1732589505; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddOXdDx9inenclHMyOuL0Wops5UwGieHX5ScsH4CMg8=;
 b=OBH0ecHGQzoz2IOcqBEsILf+hyYmEU76qwsZqwUDSFGuKdkCgwutghXD3OgXCjGjJh
 c/scDR0eUcGisdDF5QgMLRYMgja/d5ALebkDpprSHxxfqn6973Ak/yqnXEQmBAt1CVSz
 Z7Rl5LYbAtP2XD1D9J1eExV4o+YJmFTQSUlUO6iAOIXDyajORfUPAqwJGJf/g/LVkPkg
 KaCCKJd9v4O1eb39WX7w2E00W8wJlGqmIZ1/UssHEzvaVD9koAqF9PR+dKIjGFadnf/P
 TO13MmNKq5+lnBUIxkLk5/MxNCKioYfeaJghkHI2mYAw0USUlm8gh5UC6ge5pOFDH2+O
 AaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731984705; x=1732589505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddOXdDx9inenclHMyOuL0Wops5UwGieHX5ScsH4CMg8=;
 b=AIEVJ44Z6hqyoX+9FUZCu7xC3cTuiiOKyl/Wxn/qfl1WtnDTCTvFpTc7nrTKIoJx/8
 JofkYESHxP2I0GgQbWdtbrOH7sbp/2lhytOTCNGbEySi4y1tFD8FDsy6SP73Z8fM1kjM
 +oBYN4+ffxEfqK5aUjMVkialKlPmvx5P4VWJfL1vt8KO2WwmeHprrtYJSCULOYxLOlFa
 g14rtVdLQSD+WF5qWBpjtyc8WYlIg2zlO1u9LelbGxGTNVJAyCS3Ukmcbbv65CMaxc23
 kaJaWhA0Q3dg0MM4B9Qc7FNqElyBGWNiXPrV1Abe7DvYrRadmqixB4NUIyHjeAXYtA1E
 KnlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiDvLciI/vM3uh8up/yd9ALjrnH6VhFQfX0qm8NqD1BAm8h47L/ZP5gZ4BQHlbrjjA17Kl5Qh4qdC6@nongnu.org
X-Gm-Message-State: AOJu0YzU6ixC/CUknLqZPF3E9NMFz0/8PZJuaHOGnVoMMDO1EPy+hTV8
 gf5hJewPIzGOuX4VMEBj9D1+Fa6fZHegpglPHw+VThw8/7zyY/8R1dQHxZBWRjr0Zik3n1TafAq
 1IQs3PAeI9DDMrkBkb6uiryoL0v4=
X-Google-Smtp-Source: AGHT+IECqON7z4KJ5mZaKi9Ah6Cdzj4BsLqHBhV0yrXj+yx8BvoHSRcHoc/Zx1plsHGJ30Qvjq5LuzsVKRln02591KM=
X-Received: by 2002:a05:6122:789:b0:50c:4707:df0 with SMTP id
 71dfb90a1353d-51477ebdddbmr13412974e0c.5.1731984704712; Mon, 18 Nov 2024
 18:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20241106133407.604587-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241106133407.604587-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 12:51:18 +1000
Message-ID: <CAKmqyKM91hSKE5idy_1FHY9_wHgF_VEgM738j_TVpXA+V8p_iQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 0/7] hw/riscv: riscv-iommu-sys device
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Wed, Nov 6, 2024 at 11:38=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> Now that we have merged the base IOMMU support we can re-introduce
> the riscv-iommu-sys platform device that was taken away from the initial
> posting.
>
> Aside from adding support for the device in the 'virt' machine we're
> also adding MSI support for it, something that we weren't doing before.
> The Linux driver is then free to choose either MSI or WSI to use the
> device.
>
> Patches based on master.
>
> Daniel Henrique Barboza (5):
>   hw/riscv/riscv-iommu.c: add riscv_iommu_instance_init()
>   hw/riscv/riscv-iommu: parametrize CAP.IGS
>   hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support
>   hw/riscv/riscv-iommu: implement reset protocol
>   docs/specs: add riscv-iommu-sys information
>
> Sunil V L (1):
>   hw/riscv/virt: Add IOMMU as platform device if the option is set
>
> Tomasz Jeznach (1):
>   hw/riscv: add riscv-iommu-sys platform device

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  docs/specs/riscv-iommu.rst  |  30 ++++-
>  docs/system/riscv/virt.rst  |  10 ++
>  hw/riscv/meson.build        |   2 +-
>  hw/riscv/riscv-iommu-bits.h |   6 +
>  hw/riscv/riscv-iommu-pci.c  |  21 +++
>  hw/riscv/riscv-iommu-sys.c  | 256 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu.c      | 114 +++++++++++-----
>  hw/riscv/riscv-iommu.h      |   5 +
>  hw/riscv/trace-events       |   4 +
>  hw/riscv/virt.c             | 108 ++++++++++++++-
>  include/hw/riscv/iommu.h    |  10 +-
>  include/hw/riscv/virt.h     |   6 +-
>  12 files changed, 530 insertions(+), 42 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-sys.c
>
> --
> 2.45.2
>
>

