Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035D5C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEeBA-0008Se-GS; Tue, 04 Jun 2024 20:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeB8-0008RA-31; Tue, 04 Jun 2024 20:06:58 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEeB6-0004oM-Cr; Tue, 04 Jun 2024 20:06:57 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80ae09dce70so166441241.1; 
 Tue, 04 Jun 2024 17:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717546015; x=1718150815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9zsMbSU8ZghW73psWkJsDDeANBe+TjMsxuf7yQuKw4=;
 b=MrwgQQ2bOO2eEN/I6dasp8E6pCcheOd4BXqECQzsNA5UaiqY6W/HoAIX7xUCUCR9Sr
 LPzCXgcmbdO8pK+l3hwhegIveK6xe9wk/kz0PcldZ2j7+ywWp4h0s1920leELMFmmriu
 6cp9OOIlL8LN18zSU5BGPldYzu8cZCf038TlK8rhMStDZg87RZhyspQ11LIdz3ia3f9a
 oH+IlIiXSO77EoN5xHSdZMofEAUZjHzDt96vwKWJx+a6U7LjarnHwELNkun8lBTFthNe
 /K7TGzcH7DC1QcpefYqRnvhub65v80PiRc75AKZWs0DYuYBj3pLHCAFemsHOabDT9AiA
 KpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717546015; x=1718150815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9zsMbSU8ZghW73psWkJsDDeANBe+TjMsxuf7yQuKw4=;
 b=ZziX44eTl3IR2oT/In1LPvnIMIalyH63J7Mcj0ruR0R3dG+8n+akhY9Amgl5SM1noZ
 8HcI5AjgFcPIjMOeNew3LX9g/YKSS0Rmx5aQxdf33GJ8uSNMCfkJ9Iuc6ayB57wJgOwk
 TjbPx/j7ADtsRtSiJayOy9Almg1YVfXckkmntPNoyv5JYiXyPnMYdIqMu5wUmkjVQSSO
 NZ5qLSAHAyhLw5ZjUW2XMG1Pl3qE5VkqmU6aI9FhAtWal6c2mt4DlMOvRFyjuIf2cAZY
 gupQrGsCyTyHKmzVJPECXpJs50+DCSWJ/R2HOiqu3aeAJ4RiYCC1bOS2Uc/LlCpoNc0e
 RFLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEJWrGY9vp+H4UnYHbpbKpWHy21Pi2JOC3xJ1nKgcngirw8TR6CPtvNmzrO4u0XXFC3FRq3sm1Y7nh5ixa6jEnJVtJzjo=
X-Gm-Message-State: AOJu0Yw9e5RRkobE5YfpI1R6X0RPDsyJb4JD+ISMaHn5ptwp/UmilFSO
 cXbHAut+qEDF8RH+HZN3AIzLQlWW1pS0NDpSX8Pt0wqqr4pdWoG5swlhhwNA6Ccn9h7cO2lQSQz
 nuipTgUVjWn2fTGy6Cbo5qh166Cw=
X-Google-Smtp-Source: AGHT+IGmdzTmAPuGRTRBf8Pm/aJe7ls8ApHkYlFxr59l6zwh2Mzt8+MfH3eIcgqz9s2bmfFW9Y5BYf4577ej6y9y45s=
X-Received: by 2002:a05:6102:50aa:b0:48b:d69a:abf4 with SMTP id
 ada2fe7eead31-48bf237e221mr4477280137.16.1717546014959; Tue, 04 Jun 2024
 17:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240531202759.911601-1-dbarboza@ventanamicro.com>
 <20240531202759.911601-2-dbarboza@ventanamicro.com>
In-Reply-To: <20240531202759.911601-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:06:28 +1000
Message-ID: <CAKmqyKPK42zNL+SznFHcJzR_CBh4GPTmNqPYLovcm7A2ojk_vA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] hw/riscv/virt.c: add address-cells in
 create_fdt_one_aplic()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Sat, Jun 1, 2024 at 6:31=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We need #address-cells properties in all interrupt controllers that are
> referred by an interrupt-map [1]. For the RISC-V machine, both PLIC and
> APLIC controllers must have this property.
>
> PLIC already sets it in create_fdt_socket_plic(). Set the property for
> APLIC in create_fdt_one_aplic().
>
> [1] https://lore.kernel.org/linux-arm-kernel/CAL_JsqJE15D-xXxmELsmuD+JQHZ=
zxGzdXvikChn6KFWqk6NzPw@mail.gmail.com/
>
> Suggested-by: Anup Patel <apatel@ventanamicro.com>
> Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to v=
irt machine")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c         | 2 ++
>  include/hw/riscv/virt.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4fdb660525..1a7e1e73c5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -609,6 +609,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>      aplic_name =3D g_strdup_printf("/soc/aplic@%lx", aplic_addr);
>      qemu_fdt_add_subnode(ms->fdt, aplic_name);
>      qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,ap=
lic");
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
> +                          FDT_APLIC_ADDR_CELLS);
>      qemu_fdt_setprop_cell(ms->fdt, aplic_name,
>                            "#interrupt-cells", FDT_APLIC_INT_CELLS);
>      qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, =
0);
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3db839160f..c0dc41ff9a 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -118,6 +118,7 @@ enum {
>  #define FDT_PLIC_ADDR_CELLS   0
>  #define FDT_PLIC_INT_CELLS    1
>  #define FDT_APLIC_INT_CELLS   2
> +#define FDT_APLIC_ADDR_CELLS  0
>  #define FDT_IMSIC_INT_CELLS   0
>  #define FDT_MAX_INT_CELLS     2
>  #define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + =
\
> --
> 2.45.1
>
>

