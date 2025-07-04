Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428D9C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 00:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXTyL-0004ma-OW; Thu, 03 Jul 2025 20:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTyK-0004m3-7B; Thu, 03 Jul 2025 20:08:08 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTyI-0007pP-5d; Thu, 03 Jul 2025 20:08:07 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-87ec5e1cd4aso131208241.0; 
 Thu, 03 Jul 2025 17:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751587681; x=1752192481; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRrZDtDuqg+6AEVQQwP9regHkFvm9kFx3ub83TZ9ziE=;
 b=iW5z/qxNtDlIbUUD8huLSYtSEWp/F6eMCwHVYjp2NnsrzRjzDuVRjh79gv7n2DqV01
 6x2XXSVinXmi7d8sF+X2JhnXjMkhCd77UGUgtEMu1qm3LpjgV64PDM/ZYFijC+iwtBXD
 Qmtif1QBN8CoV/It96+XFbFiMOIAXU939yx0h6aiNdi/ODX83x2gUpZmKppsFjxa5UFy
 nJL5amcHZzr3mwH0myAoyPny//jnNe9B8fw2+6mcp5LFVRuN9Z7OK7ixfeV5u5KCVruN
 HBbpz/hEx3bLSZThmKzLjrAPRFOWqPZXyEGKSdmpVwx5r7KPvRfuQWSSIeh20NETuEdv
 fFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751587681; x=1752192481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRrZDtDuqg+6AEVQQwP9regHkFvm9kFx3ub83TZ9ziE=;
 b=C2VPpu9k/RNWUBiK1WJm+pbMvPxEghrn45wJS7MeGV+o/hzAZqFET2IzCP/1WukkRS
 FmjMbUPYDW0pN2HAcApKYkvSk51dpI84iQixYgrx7f+MAF3JH3yLfKeYoN10kk+qxt4W
 rRmY/u/jvrA+L8zZkpk+5kELuQbP9uXNI+8VgQxJpmX/bT0GjcBABblqa5tn8IAPX0JH
 gVvxYXUu6J3juD8mQz1tBB80U3NmzcKo7ytNfgkR+Rr+d3uGZbEObTYHbo41AQVTZ/OZ
 9EUcFXYenSkI9CMk8rn/sdkWN/iwD7xh/yeXcDm84WaKehdsFwLqdyV0l30l6CgOokYA
 5rmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTd0u9iUsH1LSPT0gdsMoLo5NiY9GCbc4SBdRJgnr8PhGhB2FN0bXKsGsVAKD5HXnsnMWpSOpNxQdY@nongnu.org
X-Gm-Message-State: AOJu0YxqwTgx9DGdqa2sE00Lx0MHrXqcePWvCADOzvUN+rAFErXC7tO1
 BHfKXsUhNTxRuXo4MihQeXtn5BfwuL1YB0VEFuL1MAtr1x62b2huJXIrHj71VvkqVTxXDbbcY0V
 iRYyZO7mSrbH54a6tM04fox+thtZNdm37kQ==
X-Gm-Gg: ASbGncuXaIjhPyhZKt8Mm50ur7fwfhdO3xiJuu4Yv8a6NbGIQkiusarYFFFvuHiaQ2g
 eEmf1OogpGyUsi2WmdntzrAEs9D7eTLVHPu6GbgDszDoqajIuADtt6CIea+BuzTRpJaP8yfamYb
 Nd5T/fKHcqzP/JJcg7pWB/FWR3aOcPZqQQawZEhFpOnq2jsBT25IB6EpAEXFNmeiGpwdPBVFCwW
 w==
X-Google-Smtp-Source: AGHT+IFv1/F6rLDyMezu8tjP/xzXwS/ctJv75tsWr1k/w2l9iApRRPDLfjOs1YrMu6EgWVl3UN7ar0FMOX7TuQmrF0U=
X-Received: by 2002:a05:6122:4685:b0:531:1d21:dbd5 with SMTP id
 71dfb90a1353d-5347e5f9f58mr41919e0c.5.1751587680933; Thu, 03 Jul 2025
 17:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250703182157.281320-1-charmitro@posteo.net>
In-Reply-To: <20250703182157.281320-1-charmitro@posteo.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 10:07:34 +1000
X-Gm-Features: Ac12FXwauSi7I2uXLE0jYOv6952-H0QssGVn5_9TEsMaXlc68oTvjYORzLZtyMQ
Message-ID: <CAKmqyKMqs0J6_Ss=0veUukBGZb6nyvePBrwP2o-SC9acKZJxFQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/riscv: Fix MEPC/SEPC bit masking
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Fri, Jul 4, 2025 at 4:24=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> This patch series fixes incorrect behavior in MEPC/SEPC CSRs where the
> lower bits were not properly masked according to the RISC-V specification=
.
>
> The issue was discovered when vectored mode bits from STVEC were
> written to MEPC and not properly cleared, causing incorrect behavior
> on MRET.
>
> Charalampos Mitrodimas (2):
>   target/riscv: Fix MEPC/SEPC bit masking for IALIGN
>   tests/tcg/riscv64: Add test for MEPC bit masking

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/csr.c                        |  8 +--
>  target/riscv/internals.h                  | 11 ++++
>  target/riscv/op_helper.c                  |  4 +-
>  tests/tcg/riscv64/Makefile.softmmu-target |  4 ++
>  tests/tcg/riscv64/test-mepc-masking.S     | 73 +++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 6 deletions(-)
>  create mode 100644 tests/tcg/riscv64/test-mepc-masking.S
>
> --
> 2.47.2
>
>

