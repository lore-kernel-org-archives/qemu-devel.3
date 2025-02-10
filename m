Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CABC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJxS-0007eT-5U; Sun, 09 Feb 2025 21:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thJxG-0007d1-Eu; Sun, 09 Feb 2025 21:55:26 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thJxE-0001PG-U6; Sun, 09 Feb 2025 21:55:26 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-866eb01bde9so2495771241.0; 
 Sun, 09 Feb 2025 18:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739156123; x=1739760923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEPlvcFJyyyPg9V3qUeq2H44oh55V3PP51Q9CSm/qo4=;
 b=Mkp1uDquC21BuqzNnqEEzvT9MNLe5X6MKOU+/Lq8gseHQ7Wlqs+j7C3EzzwwkExnhx
 uFcposOx7b6rjLcj7fvSjnm4BVlq1nldwLkhhMTNsusqygmVgZawWHE7ZHQV9+fvzunP
 xsM6HXjeqyo5pyYTpaw1c59CXQMZiQPmSVrRX19gPdD32OSi8PGwv/1BwYY8ESfx7gPc
 AUT7KJncR7vPK77+O14iXgKzC6mg4CdnN+niX0r7mTKhZI2w/9iPzG0wLOS3zP7bmKUu
 KgRwVhUBYu2IU11JsUFphePyOUpTCz6ioWMcSkkD1SDAefudwI+Qwq8rz6/Lg7vTUqEL
 rHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739156123; x=1739760923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEPlvcFJyyyPg9V3qUeq2H44oh55V3PP51Q9CSm/qo4=;
 b=W8eexFMWDi4TgvroAa3JyUnP0ayd7MmcP6yqQp4R8zn5JkDQpzgKzVjqAXLLbH7xAR
 Bm8blsWhbY5ndaqNMe+rah4w/lKOSz1tU99IopxvkUq8AWHeqn+2LskMAPpktV8pBL5r
 4LchBaTVYKoLOAQkbXOXd9dOUw1tr6DW6ZVLabt4QQtjvwCN6jXZaCiK7d3LyyUumqD0
 9ymLWwkaBo3pihGptOyYEduUv53mUfIgjhpZVrXYlts8nzhDtwyN928LVNSRLPjdNeL5
 jGKMHjAmzaST3qVUoqz0/s/SgCRTcn8hDUy2pvDVxN2ei8pYpIKL2N5iqM6o7XYPMvJA
 KO9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMM2eBA8Ti9fkC904y06tfYZX3pIsZQpEdxY2KDEhUW/T93dmp5YyDf59LmtQPPzVppgQ0L3bjCukO@nongnu.org
X-Gm-Message-State: AOJu0YwT8Bh0+gB6fWdI8zsmy3C5s1rL7pNXCsdMlKgPaNx7J5mhBdz0
 828QlIbJ8FxB1UmcYFMEtkw3xG+0ehz87L8/TqJOfGGy40uMDG/Blix6epycwwaejF7tmWg+8bj
 RvKfeddJehSO9KtDYjuEsPcp62Jk=
X-Gm-Gg: ASbGnctq6ACQM7EUkKyH9kx8WS8gorxDGU3xAalCPu1MiLIxY4oqJa9idMDimOztKSD
 B9dePE2u1OViUi/GjbOH9HkAQXvRcjKmxalvYX6RtvoEl03pEIbP/Vn8T2zK3do8kizadosloiS
 CaK8dfH7nT1a42mJiabQ64R2HKmg==
X-Google-Smtp-Source: AGHT+IG+/yfWkHUGNF8Sdqv2ptBO6gc9KuzGQW5AtK0rDdwOL8mz0mJIAbTbDLEVuJLFeyUtgrV+jqFJlLfqByW4WCg=
X-Received: by 2002:a05:6102:4414:b0:4af:e61d:e22f with SMTP id
 ada2fe7eead31-4ba85f90424mr9409532137.24.1739156123321; Sun, 09 Feb 2025
 18:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
In-Reply-To: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 12:54:57 +1000
X-Gm-Features: AWEUYZmIwcflzyh5bQuiuhXRX6VBW_PlqTJKgVIbNLN_ImC-HxOnRV_AjDx9pMg
Message-ID: <CAKmqyKMuNS6kAytheSAwDXo1MEOvadi-0nXMOR9BRN_hKRnYEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Minor mhpmevent related fixes
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
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

On Thu, Feb 6, 2025 at 7:59=E2=80=AFPM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> Here are two small fixes around mhpmevent encoding and reset value.
> The first patch is picked from the platform specific event encoding
> series[1].
>
> [1] https://lore.kernel.org/qemu-devel/20241009-pmu_event_machine-v1-0-dc=
bd7a60e3ba@rivosinc.com/
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v2:
> - Replace GENMASK_ULL with MAKE_64BIT_MASK
> - Applied RB/AB tags.
> - Link to v1: https://lore.kernel.org/r/20250115-pmu_minor_fixes-v1-0-c32=
388defb02@rivosinc.com
>
> ---
> Atish Patra (2):
>       target/riscv: Fix the hpmevent mask
>       target/riscv: Mask out upper sscofpmf bits during validation
>
>  target/riscv/cpu_bits.h | 5 ++---
>  target/riscv/pmu.c      | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> ---
> base-commit: 3f26a7a370c11c7dff68dabcccc19c4e0de901e4
> change-id: 20250115-pmu_minor_fixes-7a2b8e3658e4
> --
> Regards,
> Atish patra
>
>

