Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1071CC021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 01:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNKw-0001EE-R2; Sun, 23 Feb 2025 20:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNKk-0001DB-5t; Sun, 23 Feb 2025 20:32:34 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNKg-0001Gq-F4; Sun, 23 Feb 2025 20:32:32 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4be5033a2cbso1675494137.1; 
 Sun, 23 Feb 2025 17:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740360738; x=1740965538; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkXNZnP4aqKo+z7UK+t378iD+iFjoz2b7Q6gX2Rkfkg=;
 b=aEU9pTfM66cwu/wNmMXiTpHymlqlMnM9Yucasi7OOinRaawUVGXuReXrf921JYq3ya
 Vco1RqT1oq6HlBQsnjgXjPxHgWKaINl32gH+DUI9XisS/O+hZIAnfJJpskEWfWFApeDt
 PXGLghIERn5ncE1X8N89XwdW/fPIVfyIKmuHyVZa6t+qj8WOJHKCrTV0oyRlzPbUGfLS
 UHEOWBonXSWM6DCwjlW/i5UGzxm+CjROqoyeJenxK+thjM4cIN/dkmbV/yENVlOYAOoS
 VcOB606UgQmPn/cbWN8JSlpV7sF4Wv0PHBoeUXYvNns+VpASmfxqlr3Ib65T0FeBi+tV
 m86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740360739; x=1740965539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkXNZnP4aqKo+z7UK+t378iD+iFjoz2b7Q6gX2Rkfkg=;
 b=P90wBiG3J0tKK2qiIcc+qPbtg1lfI+hruyJBCV3xfPPArwCuDV4NCcmL+bVkrCESWY
 HZ8ORYB6l/XBI5ItTW7ysJFALjtcLJ1r2geD5ljGFRes6YcktDySLwb9deUQroJWG4W8
 ZPi6ltZZX8FpNfmsGH+HYnh2+mBqj4zcKcaVQ5VCS5DcdxHR1oVe4K5a0CTPkcsewuGx
 gxffc4cdkmkYEOcKp9/oQUj79Y8C4uJO0VHn8CBaqzS3tDKxJaJ0kg1nrFt6MAYv14+g
 PixZj+xqNNg6xmcqQrp742kfkQOCueqnwlf/3WaJuMDVvQXS2PustMz9MrYdk3fdGWAq
 K/Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV/QdE3kVA7/XcdsqgCn6L/VpkKnh0nsN/bk72u0fscB9gzdbZnhSZzzb/MKCTebhMep8TFKiHcQdt@nongnu.org
X-Gm-Message-State: AOJu0YyRnvju/Ceu1FcsILsFvL6X2tjpllLbATaP0eGl0EvQD7yCek/H
 2YRw31TvdrZIU+I/WBhREx7WahOS2x4kf7XJhkybcFlM8O3TQueJeACIXkgOa5ZoSuR9ItmnuC4
 jG6B8qxfK3i/HZWy7DFdXFlIFflI=
X-Gm-Gg: ASbGncttba0nixM/kAxmbDSwqcZVRsJStXIQTNMNVnTxYDPWPlS7GloLHzgpO5huLO/
 jiesdSGwBNvqTGWEWufQUrEelvtRmDkrxU03sstbRWQSJizeo1hwqHMaRd2Z1Kz5Sle3AmdADCQ
 GSUZY5q5hqUtJYgvaIsndNyDTa0o/RlTuIGdmm
X-Google-Smtp-Source: AGHT+IH9pOOrMMo/+QwJ2prDnKVaBHSA/ctZsaIlk/WyhMfwn3/Z87zoAde/E/1PfqX/ehS5DGo5d/zr/qiLjK0yzRA=
X-Received: by 2002:a05:6102:c04:b0:4bd:3519:44be with SMTP id
 ada2fe7eead31-4bfc0105e4dmr5679396137.15.1740360738656; Sun, 23 Feb 2025
 17:32:18 -0800 (PST)
MIME-Version: 1.0
References: <20250221141834.626722-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250221141834.626722-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 11:31:52 +1000
X-Gm-Features: AWEUYZmQSWtVjIyNwkL83zu88wnSEZfVJ5o80JZhEfLg4G4rw_B641y_JgtaWuc
Message-ID: <CAKmqyKPaCJq87mAdOscatcWq=8zKAdy35TY8+WLDMoV=1_=eaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] target/riscv/kvm: update to Linux 6.14-rc3
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Sat, Feb 22, 2025 at 12:19=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this version all changes were made in patch 2. In the first posting I
> forgot to update how riscv,isa was going to be calculated when
> ext_ziccrse is set by KVM.
>
> A change was made in isa_edata_arr[] to use ext_ziccrse, instead of
> 'has_priv_1_11', and TCG code were changed to set ext_ziccrse
> accordingly.
>
> No other changes made. Patches based on alistair/riscv-to-apply.next.
>
> Changes from v1:
> - patch 2:
>   - use 'ext_ziccrse' instead of 'has_priv_1_11' in isa_edata_arr[]
> - v1 link: https://lore.kernel.org/qemu-riscv/20250218163854.425607-1-dba=
rboza@ventanamicro.com/
>
> Daniel Henrique Barboza (3):
>   linux-headers: Update to Linux v6.14-rc3
>   target/riscv/cpu.c: create flag for ziccrse
>   target/riscv/kvm: add extensions after 6.14-rc3 update

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  include/standard-headers/linux/ethtool.h      |  4 +
>  include/standard-headers/linux/fuse.h         | 76 ++++++++++++++++++-
>  .../linux/input-event-codes.h                 |  1 +
>  include/standard-headers/linux/pci_regs.h     | 16 ++--
>  include/standard-headers/linux/virtio_pci.h   | 14 ++++
>  linux-headers/asm-arm64/kvm.h                 |  3 -
>  linux-headers/asm-loongarch/kvm_para.h        |  1 +
>  linux-headers/asm-riscv/kvm.h                 |  7 +-
>  linux-headers/asm-x86/kvm.h                   |  1 +
>  linux-headers/linux/iommufd.h                 | 35 ++++++---
>  linux-headers/linux/kvm.h                     |  8 +-
>  linux-headers/linux/stddef.h                  | 13 +++-
>  linux-headers/linux/vduse.h                   |  2 +-
>  target/riscv/cpu.c                            |  3 +-
>  target/riscv/cpu_cfg.h                        |  3 +
>  target/riscv/kvm/kvm-cpu.c                    |  3 +
>  target/riscv/tcg/tcg-cpu.c                    |  2 +
>  17 files changed, 156 insertions(+), 36 deletions(-)
>
> --
> 2.48.1
>
>

