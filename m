Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAA7C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 04:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rceTG-0000ry-9A; Tue, 20 Feb 2024 23:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rceTF-0000rf-Bz; Tue, 20 Feb 2024 23:44:37 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rceTA-0007gV-J7; Tue, 20 Feb 2024 23:44:37 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d6a85586e3so2967719241.2; 
 Tue, 20 Feb 2024 20:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708490670; x=1709095470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AY79pxPh2M8w1kVQFWlBbW5cle6+ce12hFyLSsQm63c=;
 b=FjeYPACjwSXtxUOlFRfwWlCBV8KbCYIz2OG2VrQojtSIuhXuhZ3wvo365JHVPx7yKL
 dVDLpbfRjEvLLdnb10XzqusI6aSH9VlwHNQhqCdzRO7metmqMelUp4V66ObzfnAhIoDs
 Z2jTdmWAf4PwHK/LB+7jkJ1g/cRhB9YJ4ftFDdqtQtYAAqF3ppYAxvNxkdHW0oTp16Xj
 eY4Ep/7YAwvEcSsshOcQ/CkSsEdzHsnPXYoUHk3gGMPXiHLRLqMm/CNai2AUIjbCMZt4
 /KelIRkxALTwm7xeCl8EwkRwZMRBdOcVDUk/EiLaBQW9hhfvZPNALIrjvpPup4bRYHDQ
 31OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708490670; x=1709095470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AY79pxPh2M8w1kVQFWlBbW5cle6+ce12hFyLSsQm63c=;
 b=tSZ/soaN9tGROun4Zt9wk/Wzjg0SawL0Ig9BlzGKncyzIeMTppNTXweF8EFP+C+TlM
 E0SShcljkkcJgI8zitikgfbQLktKnTcqkf02HVgOd6hT0zyKhD98cAzLKQYnlhPOUeJY
 O7RKyuOqc5ZONnF1eKGPbRamwxnFN0RUx0CPH/LDOkuRVPh+Br8aa9lpSpOgWdsjxq/U
 q2sqZL0JWW8RPFDToWumAY6Yrs+isd2cSCTYwmbosFZtqWdkUySMcJmDkm8JLh4snsmr
 F9vBC8dONJirHddl1g2N3WmFSPZZMWFnjlGsxXfz1Tilf5IFCGN/VKzBYxTE9zwyhZ7Y
 xK9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX75lG9oX02TzyK2kW4OAnHYvs3oa6/LlAixkDx2OMdyK3v92Awz2ZDpotuO3oomX702IS9rB3b1Ti0vZucIx18dyzwjgVZ8/Chq8fD4ll30ImfSEeAWqMmWjRRuw==
X-Gm-Message-State: AOJu0YyMHAHt5JcxvkP/6WyWglDiODbtw6ytiPmZRMRbih5zORzrMeGR
 s5spXZL4gUxzUshr78YDMKznR3kYcFy0OO9B7iSzRbYYa+8YTOmy1hUw3R0leQilHXaWaTZzzqG
 rx73M5hb18soIRyQXx+i9sZVHeCc=
X-Google-Smtp-Source: AGHT+IEJOBXUlfSHru2KmkERejyDmYXVuEKfgTPc/CD6AokE2UydPs39P0thgr4DJ+PIu6ku97/dPKz1tyE7MugmGqU=
X-Received: by 2002:a1f:4fc5:0:b0:4c0:1918:27de with SMTP id
 d188-20020a1f4fc5000000b004c0191827demr12505959vkb.16.1708490670236; Tue, 20
 Feb 2024 20:44:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <c391076e9958561b3294ba922e69e38d36b8a9b5.1708419115.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <c391076e9958561b3294ba922e69e38d36b8a9b5.1708419115.git.manos.pitsidianakis@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Feb 2024 14:44:04 +1000
Message-ID: <CAKmqyKMXe8Q39DRyjBnC8O5E0uwQA0L-XeMmH6702Ff0i0Nz0g@mail.gmail.com>
Subject: Re: [PATCH v1 13/21] hw/riscv/virt.h: correct typos
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 6:55=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/virt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index f89790fd58..3db839160f 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -144,13 +144,13 @@ uint32_t imsic_num_bits(uint32_t count);
>  #define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT=
)
>  #if VIRT_IMSIC_GROUP_MAX_SIZE < \
>      IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
> -#error "Can't accomodate single IMSIC group in address space"
> +#error "Can't accommodate single IMSIC group in address space"
>  #endif
>
>  #define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
>                                          VIRT_IMSIC_GROUP_MAX_SIZE)
>  #if 0x4000000 < VIRT_IMSIC_MAX_SIZE
> -#error "Can't accomodate all IMSIC groups in address space"
> +#error "Can't accommodate all IMSIC groups in address space"
>  #endif
>
>  #endif
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>

