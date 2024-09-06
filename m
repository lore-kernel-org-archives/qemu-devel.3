Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A47AC54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRPV-0001bd-8L; Fri, 06 Sep 2024 01:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smRPI-0000XP-L0; Fri, 06 Sep 2024 01:21:19 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smRPF-0000IQ-W4; Fri, 06 Sep 2024 01:21:16 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4fd142a798eso440301e0c.3; 
 Thu, 05 Sep 2024 22:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725600072; x=1726204872; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1BC3Ksc0AHRCzjCKQmIMGvREjxMf310PwjluIaLY8Y=;
 b=YMYQ1S/MF2v11FCrTv0aMzpycuHco+jWmnyxShQNVzMus6yxlV45mT6Z/VqcQJNyQr
 V5hpK02jl0PzhDvO4S3qnRxFkUQ0luc0tTtkKr1OVireRarMxYUMV7eYP1j1VHqKFGji
 nMTKAXoHI4H916AmolVEyF27mwagYcmSkczkoUla1JOwEovMG51c/q5CYlea+7s8RGnR
 RRl+UZQbVS2FPMdaG8BijWxiqXXGzsPyNL9x14mb9X0vEwtVtkiMud7Fi9571jU+ZSTZ
 huoSN1WO7fCCXHt2cZn+/YJ7z5VBxzz1F3fMkqos8nYw+v8GvORg76kUVwjm/p2GX1b1
 bung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725600072; x=1726204872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1BC3Ksc0AHRCzjCKQmIMGvREjxMf310PwjluIaLY8Y=;
 b=AgKr+KMTxoAOrFN1pjTvTd8foHJ57k4ifT9rpF2clvlIk4FaZBOXmw0Naksa2e4PFG
 tsiU9T9yITTb2kfv7/++bw6vVl5f4TrCuFwP1s2FMpQG4howCMi98kVKlOpLMMOSSwxq
 61/GYElRzyOiYPlHbJxTrtfM00+moCpcHWPRXmYowjwesqc9HFrb3WqBrmGE5gLmv4et
 N72DUO4kzK/p+v6f++z7bkpAM6P2M8lpVnLWxFws7GtFpfgqD7aZac1q6hJxoKVYndcO
 rx+kl4LKRTfYvKKgM9N/e0vrSQHEq+vB3ZboqMuVZZSpcX/7hSt9Ds1iCWRNyJAY3aLs
 97Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbIMYQC0MhclvuMpA7aXaj1F9Q3olv9ZdVEe1S/cExHfkymP4OaJtUi/Tp3U458eTmBC/NhOM6/pfL@nongnu.org
X-Gm-Message-State: AOJu0YwGujG6eHdFN2tm138TDk8E9uZmn+NXS8CdszY8uYsTr7etiBCd
 /B8vdnax5lpdennLGy1kWHHMbcrziwhLvKUWSI6csoQncXbg4S6npSntwt0T1U5L8pRs6+3jKSJ
 00EkvMXJnYQfAx9E+Rb0J9dm6MrM=
X-Google-Smtp-Source: AGHT+IEJw5Ltdm7hwJZkVNY96N2J/sXl+NgEmLJ/88EH0EVyzmgDQF8eswFq8Uji07WG8pKGVzKrIinmumuZgXdtJmI=
X-Received: by 2002:a05:6122:36a6:b0:4f2:a974:29e5 with SMTP id
 71dfb90a1353d-50207ebec76mr1873996e0c.1.1725600072456; Thu, 05 Sep 2024
 22:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240826024657.262553-1-alvinga@andestech.com>
In-Reply-To: <20240826024657.262553-1-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 15:20:46 +1000
Message-ID: <CAKmqyKOBqfk1y631dL0jVHtyfmKO1Pwfmg9U5eoGwaCUuAit5g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Mon, Aug 26, 2024 at 12:48=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> According to RISC-V Debug specification, the optional textra32 and textra=
64
> trigger CSRs can be used to configure additional matching conditions for =
the
> triggers.
>
> This series support to write MHVALUE and MHSELECT fields into textra32 an=
d
> textra64 trigger CSRs. Besides, the additional matching condition between
> textra.MHVALUE and mcontext CSR is also implemented.
>
> Changes from v3:
> - Simplify the comparison between mcontext and textra.MHVALUE
>
> Changes from v2:
> - Remove redundant log
>
> Changes from v1:
> - Log that mhselect only supports 0 or 4 for now
> - Simplify writing of tdata3
>
> Alvin Chang (2):
>   target/riscv: Preliminary textra trigger CSR writting support
>   target/riscv: Add textra matching condition for the triggers

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_bits.h |  10 ++++
>  target/riscv/debug.c    | 114 +++++++++++++++++++++++++++++++++++++---
>  target/riscv/debug.h    |   3 ++
>  3 files changed, 120 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
>

