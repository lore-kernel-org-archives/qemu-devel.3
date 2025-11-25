Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEE3D0E6FA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNuzS-00058Y-B3; Tue, 25 Nov 2025 10:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNuzC-000501-5g
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:29:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNuz7-0005xW-0B
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:29:43 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779b49d724so6924755e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764084563; x=1764689363; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCMoh7VIW0MM6oFdeXAtj3YjlYVBka+8QZKsEOMUF6Y=;
 b=Aql4suuNBVgXIpSAk7wFBJipkv+kKAmT14ZPxfXvHNtSsvcy1ygRy59vWu9ZtltK5u
 99Q97xtfamxzB8W9TELwq84xYjSKQYoCmOwSKPs/7CF/3DE6kAEa5mc/i3dhz6SRAA6X
 IzFtEuv445Hekfpni8J8C6UCiwtaIYE6PgOWRdrbroiPZV0q7Mw69DMkc6TM7DNUbzYT
 BHW0KtiEAGWfASvAwZ5Mv1iRX8/LJqKV7OGji/goWT4ai/fXmp75CKMF2aFQm/ujehj0
 vfcxXLml5pmPDGaEDk+7/dXLuXtatrdBA2mi6SGSvmYhXg37BgQ848/Bpnv0l75wI9Tq
 50+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764084563; x=1764689363;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LCMoh7VIW0MM6oFdeXAtj3YjlYVBka+8QZKsEOMUF6Y=;
 b=EfiGlcuz62FvWVLChNByCFAo5yi0NW/b0iZ8xO5bzvsT9rQneMD7PNyN+dcd2K/gfJ
 hWl3IhmnrKnlrnBkZ8tjmJGUVOPP84YJ9fdTuL4x8iDPmYRfmm6mBvBz7Kl4cFNwkPV0
 iK2ipJm+Ob68gwWNqOYNsxe30K9fRMHh23GGkisg00XAoZOrIYhQzcj7RJdTpifLkNOB
 FyQjhClVGyYM/jZlMHkOdfdHTZYk34srr98mpMZM9gAJprxRJoEz7bF8FqVw1VlhRlmU
 jbnWymyo+Y/bSPOuIi5QEBcwFGLQe/1O/H5yE1fWCahIa0GLQHW/bJDz8DBRxhHJS+8o
 /4Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2v1/pd4CQX2pDiXMyia1TncEBiXSuHsKDESO2XS7bXbwoCUZd+J96ohfhfXfMYnDbIeNAUYVnNv62@nongnu.org
X-Gm-Message-State: AOJu0Yx69r0b8hFrgi5+HKbuhl5Z3BvS3wi0AWL92K9DqkTbOUnbHwIH
 e4VTgYzjVDe0d97Fsn69sLif0vazwvLjrVrx3+8+wsHMOlvCNl0h05EFUg9Eqv/0zXc=
X-Gm-Gg: ASbGncspDOAqsqexlADSAjdaLUZupEV/AFoOVcFQQtrWKisJAwyo22HTpp/t/1N9xam
 B8CLAbCT7n8vB6usx9l2ra9O4F6yJtIWyuPvTSiO1cdjfr2mzsicoObuo4wvTDOKbGbGP65oya4
 J02Vd+/9DDfOSzy+sJgWbTZPiM0LPeFPLlg0ICTk2zSGWVntMinLXlQDig6t/6x75nLZ1PPeTEN
 ULZMFlKVDB8sSO4BfcTyx/SwmdE7sXr36S0d47+1WoByoKvY5zYFmVnXOT0on2XLCZAOdBaFeLu
 WwjzLwz4cUn6nzKI5K/qMMMnkDHTYIMr5xni0KjjuTzhJlg2ITFejWxmJGhZ+EaGIdmxsvUIWZE
 EYocIHB5Qc1PliU/gG+y6QwqWZtstM/q8Ai6I5y1TbzqRLcDmB/v9Mhs2+UF2jNp9hHIvlguZI/
 o=
X-Google-Smtp-Source: AGHT+IEM3WNnuqoyKDeCOdA5RaCjKNZonjFcpj+01afBj7We5gA7Iu4SgpEZ3WF/Spg5kNzTDJ8zuQ==
X-Received: by 2002:a05:600c:4443:b0:471:1387:377e with SMTP id
 5b1f17b1804b1-477c01ddc08mr91911775e9.6.1764084563243; 
 Tue, 25 Nov 2025 07:29:23 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7f3635bsm35386798f8f.17.2025.11.25.07.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 07:29:22 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Nov 2025 16:28:48 +0100
Message-Id: <DEHVRWD5YJVI.22DHBNVSQ0UHP@ventanamicro.com>
Subject: Re: [PATCH v2 4/6] target/riscv: Fix pointer masking for
 virtual-machine load/store insns
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, "Alistair Francis"
 <alistair.francis@wdc.com>, "Weiwei Li" <liwei1518@gmail.com>, "Daniel
 Henrique Barboza" <dbarboza@ventanamicro.com>, "Liu Zhiwei"
 <zhiwei_liu@linux.alibaba.com>, "open list:RISC-V TCG CPUs"
 <qemu-riscv@nongnu.org>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: <frank.chang@sifive.com>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251121050413.3718427-1-frank.chang@sifive.com>
 <20251121050413.3718427-5-frank.chang@sifive.com>
In-Reply-To: <20251121050413.3718427-5-frank.chang@sifive.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-21T13:04:11+08:00, <frank.chang@sifive.com>:
> From: Frank Chang <frank.chang@sifive.com>
>
> The effective privilege of explicit memory accesses made by
> virtual-machine load/store instructions (HLV.* and HSV.*) is controlled
> by hstatus.SPVP. mstatus.MPRV does not affect these virtual-machine
> load/store instructions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> @@ -261,16 +261,25 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>  RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
>  {
>  #ifndef CONFIG_USER_ONLY
> -    int priv_mode =3D cpu_address_mode(env);
> +    int priv_mode;
> =20
> -    if (priv_mode =3D=3D PRV_U) {
> -        return get_field(env->hstatus, HSTATUS_HUPMM);
> -    } else {
> -        if (get_field(env->hstatus, HSTATUS_SPVP)) {
> -            return get_field(env->henvcfg, HENVCFG_PMM);
> -        } else {
> -            return get_field(env->senvcfg, SENVCFG_PMM);
> -        }
> +    if (get_field(env->mstatus, MSTATUS_MXR) ||
> +        !riscv_cpu_cfg(env)->ext_ssnpm) {
> +        return PMM_FIELD_DISABLED;
> +    }

The condition also needs to consider vsstatus.MXR.

Looks good otherwise, thanks.

