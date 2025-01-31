Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295E4C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdeoZ-0003gz-HQ; Thu, 30 Jan 2025 19:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeoY-0003gh-6Q; Thu, 30 Jan 2025 19:23:18 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeoW-000125-OM; Thu, 30 Jan 2025 19:23:17 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-85b92397fe2so346841241.3; 
 Thu, 30 Jan 2025 16:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738282995; x=1738887795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/seq3qZu6PmAhkH89mVWsfo59vJy5aVSDHfXY+VyotY=;
 b=FoOdvmZ1pkCXW0FP67WIqDvwaMfZJVAuMRhBCSGk/htCTydMQuasYECkTEgrxRS48q
 ym7fZSSIxDaQS70EL2x7jL/0KQ8oH8r7k51Num9FyeIEqNMIej/sY/S4h4IMzkzODDQR
 X1aJymPmf0XE5KQXgZvLhzcGmNciNEZm+MztdRAciEPF7+FWSpq384u6LYMICiH1Y5YA
 /Vlfbk9FHejbBGx85XZLi16SC1QrYEA4+Mbb3m4059vY3ndCm9bClhEWICIdkkMOUzrY
 q0abjsYb7XQLONRAeOHDKDLx0rrd37oUsJKiDieuSV8niNNQMv9rSE0Ik7+XE0p4zFBM
 P8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282995; x=1738887795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/seq3qZu6PmAhkH89mVWsfo59vJy5aVSDHfXY+VyotY=;
 b=RYLsxlxjVCRY63kmBRdKpInDZ0FNQ+bxkPlRfqyv2QogsczHLv1KzCpCZmidcMSzxA
 AEj8c40m4SMiiF+1fiM91M+Kbin/rM7rAYsZVcMAwqxD1uD2hJq2LI/+diG68W3KS5km
 eCTY0f/+zwJqi2/kgy2jQHgm5Gw4pVt+tZexPCEPDuxs2GQZ6F7VezzEdLmnHEYXcno4
 cXB8prB79kIZ9Lyx5e8wSJv+B3gNstBZYB4UedgAIY1eyRtd5dm4JPekj06b23Uq9loM
 Q/gAoIbl/74aCP7IT0AO5psNkq1KL2ZtPzk+jCl3iL3rFqYl84bJwIkILxmCzZ6pff+6
 +kAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWBoKOr3LIcfIap28rwhfFQRs4Hq+SKcyXf1ObcoX+CpmJyBRPQeeyyhs5axqZlDHW60dHam5L7HAB@nongnu.org
X-Gm-Message-State: AOJu0YzpYyAl521R/PuOaY7Cz3M0rmriwoczzlH8c0B6ZFEyta2Ixttj
 K7s4ZR8/baGPpbb8KAOe3moJjiO1OpO2svpBU6YAQDgdbp0+McHFVrRmNsuL6w2RbUV3/O4+L3Z
 xZNtMtZSHHANb5WlNXbIJcPW5dDc=
X-Gm-Gg: ASbGnctf+cFcAL8EObeVWO5JlCvI2E+U6rm4FJ0IlaGeHs40stjan/Bs79PCtAlP1z3
 BXba/3Zxe/K24EgMZrGgMukjbCpEQixKh8mUwfWvlBgF0I75vn4bwczXeNaOv65CrkEPIl/xReH
 ExA2JrUHzzF+djsqJaeZZxFrb2vy4=
X-Google-Smtp-Source: AGHT+IG29KF7IoFdKT4eBMG05dD3HHGQWoNnVykBAfGyxFTSnty42Mpu0rxx+PTJcKq6CqvB0rCPxB1pAuw4n4Otvok=
X-Received: by 2002:a05:6102:664:b0:4b9:c02b:afc2 with SMTP id
 ada2fe7eead31-4b9c02bb055mr2520762137.3.1738282995183; Thu, 30 Jan 2025
 16:23:15 -0800 (PST)
MIME-Version: 1.0
References: <20250115141730.30858-1-jason.chien@sifive.com>
In-Reply-To: <20250115141730.30858-1-jason.chien@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:22:49 +1000
X-Gm-Features: AWEUYZk9xR3MIQt1BWr5c_SP8ueTDEXA3kn4hXLBwO9fVE3-EO5sXL0dr_6ka3w
Message-ID: <CAKmqyKM3RicLcCvWn7zTd1x=hd543cUD4eCZERGyUtt5Su2K5g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/riscv/riscv-iommu: Remove redundant struct
 members
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Andrew Jones <ajones@ventanamicro.com>
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

On Thu, Jan 16, 2025 at 12:19=E2=80=AFAM Jason Chien <jason.chien@sifive.co=
m> wrote:
>
> Initially, the IOMMU would create a thread, but this thread was removed i=
n
> the merged version. The struct members for thread control should have bee=
n
> removed as well, but they were not removed in commit 0c54acb8243
> ("hw/riscv: add RISC-V IOMMU base emulation").
>
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.h | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 9424989df4..fa8a50fa24 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -58,11 +58,6 @@ struct RISCVIOMMUState {
>      /* interrupt notifier */
>      void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
>
> -    /* IOMMU State Machine */
> -    QemuThread core_proc; /* Background processing thread */
> -    QemuCond core_cond;   /* Background processing wake up signal */
> -    unsigned core_exec;   /* Processing thread execution actions */
> -
>      /* IOMMU target address space */
>      AddressSpace *target_as;
>      MemoryRegion *target_mr;
> --
> 2.43.2
>
>

