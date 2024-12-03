Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CB4E6C60D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMhh-0002da-Cn; Tue, 03 Dec 2024 01:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMhg-0002dO-MH; Tue, 03 Dec 2024 01:48:12 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIMhf-0002Am-2y; Tue, 03 Dec 2024 01:48:12 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4af5ed9c8b4so1143509137.2; 
 Mon, 02 Dec 2024 22:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733208489; x=1733813289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsE41Wm2hcZFOmELsf8nNYdr/O/I+HF0V0VgCgbozrw=;
 b=lzyUa9Bm2xfhS4AAtXMn/kpFMg50xT3wlEWg5nKvke8a4hvNLAQalXhc0s0OXdBCqi
 F0R2P0XYpHIrK9f6FWB4ZQqdqccVClo0BJaqHLVc833poBFsSApfkEtZ8SPJIj/v6i5v
 sDhP5o2p21NpdPv2oK/wQcSRuC5Gm5sS9HBBKoj6l63dyWXdX69CWpPa5QWF2FMAjp9z
 sJ6ZDmmB5UMgH1k0k2oXcMAu8nngkWdmTzX4Lumvti72ZwN0ZXVOz5EZYO/a5ru/MtmM
 WC3OswAXHO6xBkczUN9RvH6kKgH/X+Hnr92XC8dBcEBTKJWg3hS+QVsLCIdZJdPlaDmP
 7xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733208489; x=1733813289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsE41Wm2hcZFOmELsf8nNYdr/O/I+HF0V0VgCgbozrw=;
 b=F+XAXiD89P78StZo8Kw+dnZ4aV1o8Z4Hc3HbAeDvx/f6N2WF7PIsnnOU2FYv4/TPer
 bI221cmkVSe4/kSrqT0Gy/AfE26FL0+kA4YbIuXR16utIH90tSnU3T4jKLQg/YWOMVmT
 IUXp36NrzLkczsYlkbWwaCHTz/bKyqKNgVxI9uiAATrRjn74YIJ4NZ4HZtN3cCQV8ql0
 aPVuBf2Eo/BO5gi8DEldbDtPc5cP3WrH0JJ6I2CSNRvYC+UjFTsCcgXPIX7AFq+HrVkz
 AuX7GvBCdeollwKHniviOXqTdQRHzf5Svn6wQAtW8LAfIs7WU57eFI7mPtIQrb9EJOQ2
 zcwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9AcE5cE348pETW2/T4E2hviPIA6EWra3r6c8o1J82DlotH6gEAGmilymc8on4COdArymuN/gyVTHd@nongnu.org
X-Gm-Message-State: AOJu0Yzh39huL6jhAA6NzC6bjf+vDrr5ilxRwdIWM8N+RReQQncUDqaF
 OkuIUmROx7UbVJIfbEO0XKPvR6vzjlbh3WxMhGh5kQw095rLLsJugJNoObQNTrt1LTh3vRXjI0J
 1bOdpNwzuZwW9yQKXh46c8M25pcI=
X-Gm-Gg: ASbGncskdbUcs/GDo4YMyWBUpcvjmHClxOSRSrL4mgSdK9TmWX8Q4p08ngBxWOW6o9Q
 gK5rc3wWkg6TQhL9oUr7+/4BKIEMvhzdD
X-Google-Smtp-Source: AGHT+IHRY9YGyP/h5+BP+NpOi4Wed6KMaSmwXGg6xcTGLni5jkuzfoSOtL5SBpq4uHfuxWGQxFM/FLqb2ctj+kyRSaw=
X-Received: by 2002:a05:6102:c92:b0:4af:958:97d5 with SMTP id
 ada2fe7eead31-4af9729e406mr1760742137.25.1733208489728; Mon, 02 Dec 2024
 22:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20241120153935.24706-1-jim.shu@sifive.com>
In-Reply-To: <20241120153935.24706-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Dec 2024 15:47:43 +0900
Message-ID: <CAKmqyKOBVuxvKMV7ihZVQRNepnJjxwgrxLdxeCrR6Sam+gnsrA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Support 64-bit address of initrd
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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

On Thu, Nov 21, 2024 at 12:40=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> Support to load DTB after 3GB on RV64 system, so that larger initrd
> doesn't be overlapped to DTB. DTB loading now will check if overlapping
> to kernel/initrd and report this error.
>
> Verify the patch via running 4GB initramfs on the virt machine.
>
>
> Changes for v4:
>
>   - Update the comments of loading DTB in 64-bit CPU
>   - Align image_[low|high]_addr's type with initrd_start (hwaddr)
>   - Fix commit 2 to avoid unnecessary change .h file of board
>
> Changes for v3:
>
>   - Change struct RISCVBootInfo from machine state to local variables.
>
> Changes for v2:
>
>   - Add DTB overlapping checking and struct RISCVBootInfo
>   - Remove the commit to change #address-cell of 'initrd-[start|end]'
>
> Jim Shu (3):
>   hw/riscv: Support to load DTB after 3GB memory on 64-bit system.
>   hw/riscv: Add a new struct RISCVBootInfo
>   hw/riscv: Add the checking if DTB overlaps to kernel or initrd

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/boot.c            | 100 +++++++++++++++++++++++++------------
>  hw/riscv/microchip_pfsoc.c |  13 +++--
>  hw/riscv/opentitan.c       |   4 +-
>  hw/riscv/sifive_e.c        |   4 +-
>  hw/riscv/sifive_u.c        |  14 +++---
>  hw/riscv/spike.c           |  14 +++---
>  hw/riscv/virt.c            |  13 +++--
>  include/hw/riscv/boot.h    |  28 ++++++++---
>  8 files changed, 127 insertions(+), 63 deletions(-)
>
> --
> 2.17.1
>
>

