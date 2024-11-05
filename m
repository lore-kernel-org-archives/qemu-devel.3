Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938FCD40D08
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TCr-00021A-Ce; Tue, 05 Nov 2024 18:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TCo-00020J-O4; Tue, 05 Nov 2024 18:43:26 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TCn-0008RC-3H; Tue, 05 Nov 2024 18:43:26 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84fcfe29e09so1956711241.2; 
 Tue, 05 Nov 2024 15:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730850203; x=1731455003; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8yyVV/dfE4RABPqWAkLeU7Bi+D46UsdSwNgyCe9Jy0=;
 b=JPF6Vjqtwif8NCMWoUEhCVOVLbvEMIdfigG+DAp3DfsBYm1jfrWOnGiQLCYZTJy/2j
 HGo8eOZw0JqacGwAfInlLOT9hecB9Ooap7GnySEH/pwLHn6lX3y3X5q1ehvBZj3/fH9M
 14tc1nJMAdYXJkS/r+tavRYQ+XWr2qHzjNNkRBZq3UEDtt4Xi0xTWDgmUYrUGPgV2sb+
 f71l5sSslocjpDTx6kexiJk8Wk5ad4Fy1D9ReIPU6f1DKI5/TgF5lgOYA9NMC3YsWMLV
 Dvx53GzktNNua49ksBuzxH8Pjvz76HAEn1L5oDC7jBokDVJfoYP9Jw3pCAhpR9IhoKt/
 p1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850203; x=1731455003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8yyVV/dfE4RABPqWAkLeU7Bi+D46UsdSwNgyCe9Jy0=;
 b=QSqYHWEChjFG9nvQ0XAx2HTT93Gfp5PG0i5NMITDDssp90/XkDW+bx3kXbNsZPUkOA
 xJt1jwaCVyVTvSAZDj+QsmL12Fa2Y0btqXt1rVZL/Wq53OcPM+Jq0VcJO7C9jsP5V/Sg
 4wORYrdGNEzQmsP8ZsmOdXoXnshlEI1lVe2j+6/bJ39lNBjvy3gN6eN6WG7SRvWXgHfd
 cA2Sz5/18jOKSbHKBOy64n1jwhLNHrYjWNKakl+VZus2e+YcpLKXoXg7RXrcR5eiM1pU
 XKgKXzORSfIu7BwQYTGscPEBS3wkOfxH/kPk3nVEQnia0Hqb7zBF0vkssFeTMO47K7DS
 DXhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA8jDARvzYKeFT4N30FEzqxwzFbtkSNIlVSgRFFQPjHmCITAhkGwwAx+yQVo6Ok36IFiWS5fMK+YXo@nongnu.org
X-Gm-Message-State: AOJu0YzCQLi+77UmyrFJi2rgZlNfh+AhbRiW+vBF9OmkzDqVSq2bLdv/
 g3J/4HcarVBBG0vkwcbj89GclYFyudCY0kUILBqVpNKiL+ha9f5e4SZQzATCzIyR/caGIDpuBZO
 zANmEjNW9hibxBjU+UPA8gc66r8g=
X-Google-Smtp-Source: AGHT+IFGIuDE6axKuYDqcAZbMGqDy+Rc5cyVsW4aa3GL6laNgKwG2vGDAo5mZDkk6Xe3t0ole8FDrQB2bu+Vqkhr+Jo=
X-Received: by 2002:a05:6102:3595:b0:4a4:841f:bb98 with SMTP id
 ada2fe7eead31-4a9543a418bmr20260890137.24.1730850203190; Tue, 05 Nov 2024
 15:43:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1727164986.git.zhouquan@iscas.ac.cn>
 <ada40759a79c0728652ace59579aa843cb7bf53f.1727164986.git.zhouquan@iscas.ac.cn>
In-Reply-To: <ada40759a79c0728652ace59579aa843cb7bf53f.1727164986.git.zhouquan@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 09:42:57 +1000
Message-ID: <CAKmqyKO2G-A-R+1UhL3Y4D-h-2sBziHiHp7xxoFUaymh3g0RRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/kvm: Update kvm exts to Linux v6.11
To: zhouquan@iscas.ac.cn
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Sep 24, 2024 at 10:57=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Add support for a few Zc* extensions, Zimop, Zcmop and Zawrs.
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f6e3156b8d..428aaee552 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -281,7 +281,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zihintntl", ext_zihintntl, KVM_RISCV_ISA_EXT_ZIHINTNTL)=
,
>      KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINT=
PAUSE),
>      KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
> +    KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
> +    KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
>      KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
> +    KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
>      KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
>      KVM_EXT_CFG("zfh", ext_zfh, KVM_RISCV_ISA_EXT_ZFH),
>      KVM_EXT_CFG("zfhmin", ext_zfhmin, KVM_RISCV_ISA_EXT_ZFHMIN),
> @@ -292,6 +295,10 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] =3D {
>      KVM_EXT_CFG("zbkc", ext_zbkc, KVM_RISCV_ISA_EXT_ZBKC),
>      KVM_EXT_CFG("zbkx", ext_zbkx, KVM_RISCV_ISA_EXT_ZBKX),
>      KVM_EXT_CFG("zbs", ext_zbs, KVM_RISCV_ISA_EXT_ZBS),
> +    KVM_EXT_CFG("zca", ext_zca, KVM_RISCV_ISA_EXT_ZCA),
> +    KVM_EXT_CFG("zcb", ext_zcb, KVM_RISCV_ISA_EXT_ZCB),
> +    KVM_EXT_CFG("zcd", ext_zcd, KVM_RISCV_ISA_EXT_ZCD),
> +    KVM_EXT_CFG("zcf", ext_zcf, KVM_RISCV_ISA_EXT_ZCF),
>      KVM_EXT_CFG("zknd", ext_zknd, KVM_RISCV_ISA_EXT_ZKND),
>      KVM_EXT_CFG("zkne", ext_zkne, KVM_RISCV_ISA_EXT_ZKNE),
>      KVM_EXT_CFG("zknh", ext_zknh, KVM_RISCV_ISA_EXT_ZKNH),
> --
> 2.34.1
>
>

