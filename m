Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1464AC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 02:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEJih-0002Mc-GT; Mon, 03 Jun 2024 22:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJif-0002M2-OY; Mon, 03 Jun 2024 22:16:13 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEJia-0006cl-6A; Mon, 03 Jun 2024 22:16:13 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80aca73c536so190039241.2; 
 Mon, 03 Jun 2024 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717467367; x=1718072167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVySxBZOuEzMBTtH8x3eH/6YCkfLGhjrRpdkzckfXlo=;
 b=hXR5RcokMRT6/L/X4bYXGO+fl7w3+3qOX6I1mfcC7J+tuGIDTFpNkN92m1ffmn9nPp
 P3E3xYAQ6blPCo8LMA9LWYrkMv6XGuC4T9ldt8cKdN0fdySWKMawabNia8uL/295mT3b
 CELmNLL0h0w6ozYJLm6ujJoZZVEJCaLIuOt9tg2apeBUuwLwRxqlZYpNSGcMw5pjt/MS
 WCTVL5jMtGeZGG1vrKObvIO5NLa+89LrhuwaMSlTj1Uq/pAz0gXZzSN8JEtvXtcJZtxf
 Mi8Gm3U7aflX0nVKP19teaDz9eglaZzhpKtZX4DjBnw3FZKFCpZhh3GBcD0tlLdKVp4S
 tGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717467367; x=1718072167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVySxBZOuEzMBTtH8x3eH/6YCkfLGhjrRpdkzckfXlo=;
 b=CFoxqy50Xn/2f3bQQqV6xVJppc91AwPzAgk3E7cq7P40GvL48KSz39VuGW7CU4ENKg
 2dDrkIC9P1DEjRDOOYHYd0mx8Vk9NVT7KWh0/IvJVSI12dqILzKqY1GBcu672YgWWNhp
 fEMOPID++28LbxM3tK7U365hKvqBx9d5BteJ2flL8OLyLFHy+i6ZzijwunjIDgGOhU3Z
 I7XmUM5/gVekXvCnIvZciWVFCzy3nHAYZ/AGi63cxkuSsVDoE7uOn8Dz2+C1WKUR4cC8
 vTGDKwac8gK44mWeUuH369xvIES0HsftVRQHCJ5AsldAM9FwjOJTH6410lvv27lS+0rG
 gChQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Hs8ZcwNCEcWW3AjuskGP8HbIRd1Z2Itght++nynGJHTJ5vlSj8svSGNJIh7hazCTpGkvt65dlp7RthgIeJ7b/auJjTE=
X-Gm-Message-State: AOJu0YzuySOeIJl8NPrEvziKOn6usKdxtANotslY1uNz5GZhWJsT2hxK
 oVGEELsIQBo1+AYuz9PtZIK5nrFcSwvYeqPXv3+v09Vqy0NM+OZcOTkDd7AXFvwHOysKki1yEHj
 VRXf/PPmLaNYGHig+XesfNHrTzkQ=
X-Google-Smtp-Source: AGHT+IEUHfgiJ0/goY65ukSrJc8meR0Sg2SlIC/S0vpFx1gXJF0yx3t9UnwrrI6tBoWtFm6EhMV1Zylpdt9mjOhtEKk=
X-Received: by 2002:a05:6102:2920:b0:48b:da28:97ee with SMTP id
 ada2fe7eead31-48bda28bac3mr5364503137.17.1717467366608; Mon, 03 Jun 2024
 19:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240520125157.311503-1-rkanwal@rivosinc.com>
In-Reply-To: <20240520125157.311503-1-rkanwal@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 12:15:40 +1000
Message-ID: <CAKmqyKNWUXfg6q_Ku8dGDwpu2DTgkAmHr8JcZFtTCzfp+J2P_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/riscv: Minor fixes and improvements for
 Virtual IRQs
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com
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

On Mon, May 20, 2024 at 10:52=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
>
> This series contains few miscellaneous fixes related to Virtual IRQs
> and related code. The first patch changes CSR mask widths to 64bit
> as AIA introduces half CSRs in case of 32bit systems.
>
> Second patch fixes guest and core local IRQ overlap. Qemu creates
> a single IRQ range which is shared between core local interrupts
> and guests in riscv_cpu_init(). Even though, in the current state
> there is no device generating interrupts in the 13:63 range, and
> virtual IRQ logic in Qemu also doesn't go through riscv_cpu_set_irq()
> path, it's better to keep local and guest range separate to avoid
> confusion and any future issues.
>
> Patches can be found here on github [0] and v1 of the series
> can be found here [1].
>
> Patches are based on alistair/riscv-to-apply.next.
>
> [0] https://github.com/rajnesh-kanwal/qemu/tree/dev/rkanwal/irq_fixes_v2
> [1] https://lore.kernel.org/all/20240513114602.72098-1-rkanwal@rivosinc.c=
om/
>
> Changes from v1->v2:
> 1. Check patch fixes.
> 2. Removed commit title split from Fixes tags.
>
> Rajnesh Kanwal (2):
>   target/riscv: Extend virtual irq csrs masks to be 64 bit wide.
>   target/riscv: Move Guest irqs out of the core local irqs range.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_bits.h |  3 ++-
>  target/riscv/csr.c      | 23 +++++++++++++++--------
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> --
> 2.34.1
>
>

