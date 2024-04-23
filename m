Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74050C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9H5-0006I9-4M; Tue, 23 Apr 2024 02:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rz9H1-0006Gp-OJ; Tue, 23 Apr 2024 02:04:59 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rz9H0-0006eX-3o; Tue, 23 Apr 2024 02:04:59 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4dac112e142so1543929e0c.1; 
 Mon, 22 Apr 2024 23:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713852296; x=1714457096; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzNLZv4GXpHsLODlul+fM8UateOwerdI9bTqnW6mn5o=;
 b=LgeqJzPE1o0qKAI8W/kNOy+5qnewksi/JpCKCqIl4qPkmTEuHShR/1c5i1eGNajthY
 GQOizSsscGgC+vlmykbzEEaeeJdPQbeqcioavu1+T0W2knchfoODPNaVNvYGViiDA6SU
 XjWLdInvpTgl37OsUi4lHv6Jfyisw2ldJn1jakoW5Ql7i9xFZVqEamz7VQpHSPF0jtyZ
 aX7mKOtzGauD5COfD/l31SYG3YKMSSOyXSgjnG4kVQKqobb5KZGZvsmXwbfX1tRpiX5T
 aGcZjfFizGYd817rF6b4GPOPlXkodKI6AfSz1s8xH6T34lsfq0i+N5XJA/3xEkTsIVgg
 3Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713852296; x=1714457096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzNLZv4GXpHsLODlul+fM8UateOwerdI9bTqnW6mn5o=;
 b=GLdlJNI7xVXNn2Ci6bHdm+8LcXbidUMFcLD3hK5eB/WL4FdWch02KqQRxS59Lylpkr
 HVtEdN2VkPd1uzBCFgQKHp5h6KuLHb+uKplr6n6Ujslprs4kpMxVhUMtx1rPgaLz97H+
 PgnFYpZqG48G12CUME7jtyaKsulaAzpPADFH6m6xC54hHk3KDW80HGRKV2aPhFtqMsBZ
 9izMhTV7/TI/ZdOH77lfwws4KxPITVIy67EcvFggVciIzvYtfjUljrIdDpMgtmzrtDJQ
 uF0s6ckA1jLJD89vziKBuWwhgn/s85vnGg8/v1eZVM9yU/liyFr8tTozTl66ei4ty5OT
 uYSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhSCHuj21EbsbuhN0BQrJMjkk194xUBLay8MuqyvmQFSfGrmfYuIrI3BFaN5DgHx64YwhmM6Br3vBk7A+56g1Fy4ZXq80=
X-Gm-Message-State: AOJu0YzGIZZvSxjBL9ni8QQDoIzSR8Fn6uG+7h9zi19bglKCjtQ/JM1H
 ZaUZvztHaQXgHdtO0+DC28tPdk5g7/8L8xb04QNK9ndTu9810esjsZUAKXqhmsXEL58PlnXZnyJ
 5dWwrX64l8ufJdZ+J7THlEOLC7oI=
X-Google-Smtp-Source: AGHT+IH3IUGPAV4yReCKQxfyNroNCSD+X9LwrrkgussOskvOm0BRwLcYd7yrz948GVDxW2RN88a4PvSTtP0gG5JyuiA=
X-Received: by 2002:a05:6122:3115:b0:4d4:ef9:719d with SMTP id
 cg21-20020a056122311500b004d40ef9719dmr14284415vkb.5.1713852296182; Mon, 22
 Apr 2024 23:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240409014445.278-1-gaoshanliukou@163.com>
In-Reply-To: <20240409014445.278-1-gaoshanliukou@163.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Apr 2024 16:04:29 +1000
Message-ID: <CAKmqyKM-0P+qbLZ0AB_NUOQEW5ypE8u=40ggi_=smtJjh8pYkg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/riscv_aplic: APLICs should add child earlier than
 realize
To: "yang.zhang" <gaoshanliukou@163.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 "yang.zhang" <yang.zhang@hexintek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Tue, Apr 9, 2024 at 11:46=E2=80=AFAM yang.zhang <gaoshanliukou@163.com> =
wrote:
>
> From: "yang.zhang" <yang.zhang@hexintek.com>
>
> Since only root APLICs can have hw IRQ lines, aplic->parent should
> be initialized first.
>
> Fixes: e8f79343cf ("hw/intc: Add RISC-V AIA APLIC device emulation")
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/intc/riscv_aplic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index fc5df0d598..32edd6d07b 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -1000,16 +1000,16 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwad=
dr size,
>      qdev_prop_set_bit(dev, "msimode", msimode);
>      qdev_prop_set_bit(dev, "mmode", mmode);
>
> +    if (parent) {
> +        riscv_aplic_add_child(parent, dev);
> +    }
> +
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>
>      if (!is_kvm_aia(msimode)) {
>          sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>      }
>
> -    if (parent) {
> -        riscv_aplic_add_child(parent, dev);
> -    }
> -
>      if (!msimode) {
>          for (i =3D 0; i < num_harts; i++) {
>              CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
> --
> 2.25.1
>
>

