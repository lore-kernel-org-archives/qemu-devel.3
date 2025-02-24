Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D39C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 04:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmPe1-000478-M8; Sun, 23 Feb 2025 23:00:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPds-00045i-CN; Sun, 23 Feb 2025 23:00:31 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmPdq-0007eI-H1; Sun, 23 Feb 2025 23:00:28 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4b68cb2abacso1229987137.3; 
 Sun, 23 Feb 2025 20:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740369623; x=1740974423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5BDb6t01TYqMU6zdDbCKaNE0kJDQ+C2YCENy/2aJYs=;
 b=Vdkp3Wlg8TxWrwqMMZ8erxojFucamagagYHr9+SaAiCQjw5p+cWjEiQIfkObKqEe7k
 Obac9KMx5nszNKyY1m6eekxjhXeblaZ9L4jLthI9JjXix9AW1evMnabJ/sVZBGRk8HTj
 iCOjxs00hrRNvTfE4lPQGHA3ZfC/RmDzgmZzbF30h+QzUwjOabVa8ikTWtL38M2foj6M
 tSLqSO/MIEUF3LX4s4XbZi9zg3KtCA1WEalaRpsDR4nIu8+ncE8HPaCO7/b9kaUABTsg
 DKPH7XbEANdN1R5RQvuDYay+t3q7/oTYJbolHGBwsazf2l1q6jCjSD307UH33309ZTcH
 Fblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740369623; x=1740974423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5BDb6t01TYqMU6zdDbCKaNE0kJDQ+C2YCENy/2aJYs=;
 b=mGEz9VvM6debqG2Fy8ilR5sVwPQvmS+K0NbVWe+rCCSY3rGoj5GaB3u7lIWjIHApO/
 h2idk77xrKRZXnbX0AJuuNeVEc3/7XM0qVeSQl6hll60sQTYvwPYRLCKnCsI7HbUPI6Y
 UlraJ7JlnQVsQ+qjckAUXXAEl2kVnvO5pno1Y4164QVBmYHD1U5FhgBkSxdPgj418Ctj
 2vRqzqPUOUbHgd0jSnKWhfPr9aSlPrBdlolAOuDEHqw+VqJC64sYqUJLLd6e7uCh3aTB
 ar/pQ0WbOLAew0gTdr3hwSx8ZoUe/PIKhirNefEEkiCwTwSwZ8TnNklistykflJM5AXO
 tFbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJTJcO9+6BYSC5tqKopMHSTiduAPCwBCqdB3zQOWUNzXDnPdkrquTnG3SlxqtObD6VoEPYTHOcyrk@nongnu.org
X-Gm-Message-State: AOJu0Yy+lLcGiFf2PUAyHUkCmi1TGqBHGZzZijpAQW75A6y1h+3G1jJ9
 d7iRiDKGalwKE+ruIS3RMnQ9D6IM9Jgva05gkwgCuyAc1wpfLTzdOVyrEKF6xyFZmY52kpFqqka
 4ZoPbFSmCvM+bGp6hd0H1JzykVtY=
X-Gm-Gg: ASbGncth3fBmBd6btKfi+N8OJsT5Cbl9rDmH9dYFtXKvDWmNQD3Qzx9W0k7pQTchvyH
 QU4gztU98p2WtU5I21X1Ootd/D/7PZFR44aR4jdeUuOSYW63f1fvLFT0Du7SY8yq9si0WYiJLsG
 PD7qKyeuAHk51yDc9uMTUj2jMR17KrlMJ5f9EH
X-Google-Smtp-Source: AGHT+IET2rl/sTxJq7Sscr+3fUn912jFc66OOoW8kTZgDtZN3z+sdf2AGsIuMYwrVtldvvZfJw4BNFHtJMHrVclNX08=
X-Received: by 2002:a05:6102:4bcb:b0:4bb:ecb9:b34f with SMTP id
 ada2fe7eead31-4bfc00de410mr6171776137.14.1740369623635; Sun, 23 Feb 2025
 20:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 13:59:57 +1000
X-Gm-Features: AWEUYZn2iYP4mrVpfyakbmZHkn2AVTjcg0-_0M4Tqo4mraIXi7vxlRoJCOuqlmI
Message-ID: <CAKmqyKPo=9bfC9DQKA0rso-Q5fNiZSXSYkV-0dX6k7UWuQ-_ew@mail.gmail.com>
Subject: Re: [PATCH for-10.0 00/11] riscv: IOMMU HPM support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Thu, Dec 5, 2024 at 11:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This is a re-submission of the original Hardware Performance Monitor
> IOMMU support sent by Tomasz back in July 2023 [1] in the first version
> of the IOMMU emulation. In the second version of that work [2] sent in
> February 2024 I said:
>
> ----
> - I'm not contributing the HPM support that was present in v1. It shaved
>   off 600 lines of code from the series, which is already large enough
>   as is. We'll introduce HPM in later versions or as a follow-up;
> -----
>
> So here I am keeping my end of the deal. The code is basically the same t=
hat
> Tomasz sent in v1 with some tweaks:
>
> - Code was split across several patches for easier review;
> - A separated file was created, riscv-iommu-hpm.c, to host all the HPM
>   related code. The base emulation will use HPM via public helpers. The
>   idea is to avoid clogging riscv-iommu.c;
> - There was a lock in use to read/write the HPM registers in the
>   original posting. Based on the current design of the merged IOMMU
>   support, a lock-less design, I also removed the locks from HPM;
> - Other minor tweaks such as not naming functions using "__name" and so
>   on.
>
> Patch 1 is a header fix required to put the helpers in riscv-iommu-hpm.
> Patches 10 and 11 are new. The original HPM code is split in patches
> 2-9.
>
> Series based on alistair/riscv-to-apply.next.

Looks fine, I didn't check it that closely but any bugs will affect you :P

Do you mind rebasing though?

Alistair

>
> [1] https://lore.kernel.org/qemu-riscv/cover.1689819031.git.tjeznach@rivo=
sinc.com/
> [2] https://lore.kernel.org/qemu-riscv/20240307160319.675044-1-dbarboza@v=
entanamicro.com/
>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> Daniel Henrique Barboza (3):
>   hw/riscv/riscv-iommu.h: add missing headers
>   hw/riscv: add IOMMU HPM trace events
>   docs/specs/riscv-iommu.rst: add HPM support info
>
> Tomasz Jeznach (8):
>   hw/riscv/riscv-iommu-bits.h: HPM bits
>   hw/riscv/riscv-iommu: add riscv-iommu-hpm file
>   hw/riscv/riscv-iommu: add riscv_iommu_hpm_incr_ctr()
>   hw/riscv/riscv-iommu: instantiate hpm_timer
>   hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes
>   hw/riscv/riscv-iommu: add IOHPMCYCLES mmio write
>   hw/riscv/riscv-iommu: add hpm events mmio write
>   hw/riscv/riscv-iommu.c: add RISCV_IOMMU_CAP_HPM cap
>
>  docs/specs/riscv-iommu.rst  |   2 +
>  hw/riscv/meson.build        |   3 +-
>  hw/riscv/riscv-iommu-bits.h |  47 +++++
>  hw/riscv/riscv-iommu-hpm.c  | 381 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h  |  33 ++++
>  hw/riscv/riscv-iommu.c      | 131 +++++++++++--
>  hw/riscv/riscv-iommu.h      |  27 +++
>  hw/riscv/trace-events       |   5 +
>  8 files changed, 612 insertions(+), 17 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-hpm.c
>  create mode 100644 hw/riscv/riscv-iommu-hpm.h
>
> --
> 2.47.1
>
>

