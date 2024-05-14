Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F49C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lfd-0005LY-2R; Tue, 14 May 2024 02:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lfa-0005Ki-Bv; Tue, 14 May 2024 02:29:50 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lfY-0004hJ-Ps; Tue, 14 May 2024 02:29:50 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47f2f9f2ac8so1949765137.2; 
 Mon, 13 May 2024 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715668187; x=1716272987; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRWTjSX8q/8ry4JuhiBEh7ENYW15WvPLy8od6AOg3M4=;
 b=lPXpMDNfrECJmwhlSDWfyEp7K7ot1n5fDK/ifmnJCaCNSWDr86RLI2nEmQmwZbCJf7
 5HP0VbUQe0WFguQzT+QS+8sf5V9nExQrOaLBD1jqM2XLkGcttETFeghUKxa0MtJvnwwC
 S2cVdn8TrIgEgBjOJwgubhNk7HggqbXpSo8gG2humiou8qx9BxVGyJBF+io5nu/hh8G/
 RWYlgY4llbPi5/l4X24jMHC6Byj7Kg+45fzhQpRgShilUq9cs4X0PjMd40zyCC+PEttf
 Rq2Ty1VPlP4xipla1alVQw+LGONTig3lk+onBHTsOPbvrStJDG25/ywwZIvfrTeYV5Lb
 KBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715668187; x=1716272987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRWTjSX8q/8ry4JuhiBEh7ENYW15WvPLy8od6AOg3M4=;
 b=t4v3vfYOZdV47agh6ZgKHa0Q+yDU6mY6FEkJ4WmuhmSC8MXcuUVg6NnVbP/C1/p2qy
 Z28lCQGLcafhT7CaYbg7pFHLN1v042YpNkv1WBtcIFU+0xHwm7QQCMS5YSLAKrCaSFcZ
 mPMAfBM+ybMLwl16lfYvq4RV9PxzC0opegU/Ne1UgRuFd7XtdxEpz4Dcrn/zB+PdTWDk
 bx5T87Lm8bRtkiFBDDnYXwR5ALs4XaTS90m9wnWOk7l4EbgzTITMWGod1P4JPKYsQCo0
 F/4XqI/YNDOBQwyh4j6Abj7O6CLE5cKNOW5PD9L/xJK0vIjZr6sjDDiYDsAU3/BsELs/
 N9PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2Zhkqf5F7DxPryK1QnY5zWlSMq9TJSroHbuN9zvnXdvAd/jVgY4YC/pX72J5ZzGapmYycejvV4kdqPtWGzoS1WpgP5r8=
X-Gm-Message-State: AOJu0YznR7RTxTBbTRKTYLoprrjmK9xK679u2DUFoxwuaP+P0zPu14d1
 s+cn6OKABBTwBDM4y8b0YPUtKQItQvO4QWTLqMZ+yn7ooe9ZfKq2KbX7A3SqhlPEiBpryjQyIWg
 YJfa+czLMys2NtqlAGxpjs+jKTQY=
X-Google-Smtp-Source: AGHT+IFnVT9gyewnXmAE3a2SeEKjreEnkW/B2esUsBC2qBzeZUS7+TiTs8YLaeEmv54hYLCptesvzss2iMuWKug9Tsc=
X-Received: by 2002:a05:6102:2ac1:b0:47b:d787:9ca6 with SMTP id
 ada2fe7eead31-48077de307emr12236431137.18.1715668186827; Mon, 13 May 2024
 23:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
In-Reply-To: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 16:29:20 +1000
Message-ID: <CAKmqyKN9W+xY-gBZD=6T-iOzrX0MAMcTE4Zd74hmgTtP8hnObQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Assorted fixes for PMU
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Tue, Apr 30, 2024 at 5:29=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> This series contains few miscallenous fixes related to hpmcounters
> and related code. The first patch fixes an issue with cycle/instret
> counters overcouting while the remaining two are more for specification
> compliance.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Atish Patra (3):
>       target/riscv: Save counter values during countinhibit update
>       target/riscv: Enforce WARL behavior for scounteren/hcounteren
>       target/riscv: Fix the predicate functions for mhpmeventhX CSRs

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h     |   1 -
>  target/riscv/csr.c     | 111 ++++++++++++++++++++++++++++++-------------=
------
>  target/riscv/machine.c |   1 -
>  3 files changed, 68 insertions(+), 45 deletions(-)
> ---
> base-commit: 1642f979a71a5667a05070be2df82f48bd43ad7a
> change-id: 20240428-countinhibit_fix-c6a1c11f4375
> --
> Regards,
> Atish patra
>
>

