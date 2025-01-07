Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D5E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyUR-00087N-Nk; Mon, 06 Jan 2025 20:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyUQ-000871-62; Mon, 06 Jan 2025 20:34:38 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyUL-0002nk-Mr; Mon, 06 Jan 2025 20:34:37 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51619b06a1cso8567108e0c.3; 
 Mon, 06 Jan 2025 17:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736213672; x=1736818472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5F9T0/M5IZ+8PggwiHBrAs2U8HawuXsbZtQhTo8JeCw=;
 b=Qlw2tR3jMw2MdQ3xseYmtUchb87IzO68b6A1UtaUHznTcsA+fUl8bVPQSrI+pSgyjq
 S0UtKCnKh02vU1ZBbNvuUZyTFrJT30TSc36SVGMuA/M/lVrs+GS7RLRzLhLlTFSiZjnJ
 SnJL4s98XfZhQP3vIrD23e3EGUtphS+8soWLYBf0JZuaGDv7fAGizZ1nZDnR9OjB5F+7
 2VtNQV34God+jd1UtSFNm/G+X3aUeDzQJha2k3BVK7INk0FiYcQoUYLcK2qkI+tvX7Vp
 vyoYi6lbWT6iwCGZvCiz/9Tpyt1s/0GChCTyo1XuVQkSSzJoiekl1ahOCqv4A7Fdg9U3
 lsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736213672; x=1736818472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5F9T0/M5IZ+8PggwiHBrAs2U8HawuXsbZtQhTo8JeCw=;
 b=Y+Z63+YWAYgPkIVrHbh55+FXb32/xfYNSmQuGiJIR7fEea68eiLFJP2vfjbk7TUaT9
 BefOHkj+hFUMaeQAy84/B46cl22B8PBEjZx/Nj6p4VaM0S0+7AAKee+JK3gQqqD0wggD
 d+p9tMSvEtpojavnoKW6Kxs8R/X+PTnvIxfnXzMlPJR6DZMl7quFUn+p+kPuqJFufr4f
 UIEUbsE3mSJTKtobVMsSCjNboErrPA0xFiUelygWeIyGR6MxuILHRIVvVLaVEPUVwDBV
 PoY+Bj3IrHYENBrlWs3SJHyjrslWaQzsDdHC0acZqq1TfWV9+wOEfbkcxDuwDzTnV+3Y
 SJ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYjbFDy1/5W7z/juUi1/CCpSs90kgo010g0qa1qaEUxP1MV13xnCys/eI/uOcnhpVyDxgzlLLgtdR5@nongnu.org
X-Gm-Message-State: AOJu0Yxvt9Aa6UbbdMMn4la61IJQgghseoEc1DOrgEVicQLK4CRH9H2/
 1W86Oh/zCRfge36HBzJ/jRDRPXC/h/pPIoa1f2o+hj/u4B0V7B4MR6wXuCzM17VGvSTd4ULv5PN
 dMkFssNispGN36cyaTy3Y0xt+ZeM=
X-Gm-Gg: ASbGncsdLrIQnAcyULNFTSrN+0K/vP/KctUcRuGCrVFzCKY9rbPQdnlLmmfVH8NlQgl
 /uoCGIL9tIppTTenk1JWhJurqvyIHTvX8TkmMsNA=
X-Google-Smtp-Source: AGHT+IFy3ay9EYBLH+EYyzs1eV951KMLuWtH3OaBcOlIKeDIPOm+Dx63sArOfUjSs2q9PFKzWtLio7oe3fp9SM9FDBk=
X-Received: by 2002:a05:6122:2519:b0:516:1106:4c1a with SMTP id
 71dfb90a1353d-51b75d6b15emr36334108e0c.12.1736213672226; Mon, 06 Jan 2025
 17:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20250106173734.412353-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250106173734.412353-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jan 2025 11:34:06 +1000
X-Gm-Features: AbW1kvYYvTSuSJDgDdSX1whLFQSZu_Ncg2spRts6Gl9EwdgfrjBzZy7_uVHxf_U
Message-ID: <CAKmqyKNJb4ndiXEWY8hZ7fGah=NjY8bTE72pUrahtU4EJS-ycw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/riscv: add traces for exceptions
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

On Tue, Jan 7, 2025 at 3:38=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This new version is a re-sent of v1, rebased on top of
> alistair/riscv-to-apply.next, with acks/r-bs added.
>
> No other changes made.
>
> Changes from v1:
> - rebased on top of alistair/riscv-to-apply.next
> - v1 link: https://lore.kernel.org/qemu-riscv/20241219174657.1988767-1-db=
arboza@ventanamicro.com/
>
> Daniel Henrique Barboza (2):
>   target/riscv: use RISCVException enum in exception helpers
>   target/riscv: add trace in riscv_raise_exception()

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h        | 3 ++-
>  target/riscv/op_helper.c  | 9 ++++++++-
>  target/riscv/trace-events | 3 +++
>  target/riscv/translate.c  | 2 +-
>  4 files changed, 14 insertions(+), 3 deletions(-)
>
> --
> 2.47.1
>
>

