Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1317CC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 05:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcIgE-0007yN-RL; Tue, 20 Feb 2024 00:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rcIgD-0007yA-UZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:28:33 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rcIgC-0000Qp-Ix
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 00:28:33 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c031c24fbeso4172512b6e.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 21:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708406911; x=1709011711; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pofCApDA92bnAzECVa8Bi5ZCZR8XkvJ2CaFWnPAH+JI=;
 b=af/B8CstTclUS+ZzPPspI+6V8aXWDZAZo8LlP6jQG9BKgc858GP+d3b1qssIrT3VJf
 QtzrEXbOsXuwQqzm9iyVXEkjNLYX7sCtAEKe2B9wSG78tVPYYzfSq0+700rej0sOZ6UQ
 /9mKcPh4FYMoMjSlaxKRei9WIPfrDOHDF7M8a1YU5DjGTDXUdv2d9sGe4XOYkW3AjKh3
 y+4f+qOCu8ujkqwO/SLkbZTL6WJJEwN8nwJpfFb7iPE8sCB1yQTaXe9NokK0XnvXw65N
 Kh43EUhhRnU22O8KtgKZPg7IjVhRR83VjeoYlmCfduLsSf6GoKkG0ekOM7Su4mAfNMjP
 w0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708406911; x=1709011711;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pofCApDA92bnAzECVa8Bi5ZCZR8XkvJ2CaFWnPAH+JI=;
 b=YnuUW5SVkL37q/fbSJ5pSiaUz07c+KWMDQ4RHu5TstOMcoJrDTPp/d05gQgqWYiFdF
 SdurQAxRlnoGCf1thGJElG6rAzBC+34Oxb8P4UCWj9BLCIYUwQqMeQYVZNI24ebCX5KG
 A/MwKPqI5ZYzNj5g1p+ZqLJBUd+rdBl93oiL4PR1HcuxcegfZDwycWVliURtIDcF2sPN
 10vbA/PwFCbmOuCY1GTR5Kgbxt9Q3zjxB0L8VDC6cS7ECjnlB28EJTV9umu7+UeQQ6Yj
 fPC69iQswuO31hjo6pP5eULE0B8ejXkzZumgGOcuIfbR7SNB8e6GpK6SpvXecxeKtrWc
 /ZIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvuix1EjUtI9kpcbdvo8k2MyydO/Vjue6JSBsELF6KM5BbmJXXcafirJEQEpvcmWfmaKoICIInjJg66BsDS5v2oweg9Jc=
X-Gm-Message-State: AOJu0YyT0U0jGVgFkYYQzEGHDib2xiVeU4Fa4ssygsWpph11SB8dFsFK
 +ysl+2vLsDNMILOD1Jubck9tbNdfiE6MEuUI0aSHznnNzGJAL6o/XGLPnPbPd7A=
X-Google-Smtp-Source: AGHT+IGj1uw6Hh8KHUwJUoEmkhVetnyfSwfBvJpCmvnoa3EtRLTCDp3sNPr7HTpSKVx/1M6Jv6qIfQ==
X-Received: by 2002:a05:6808:14d4:b0:3c1:5df1:577d with SMTP id
 f20-20020a05680814d400b003c15df1577dmr4373479oiw.7.1708406910776; 
 Mon, 19 Feb 2024 21:28:30 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12]) by smtp.gmail.com with ESMTPSA id
 x4-20020a05680801c400b003c032d96b6dsm1098158oic.6.2024.02.19.21.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 21:28:30 -0800 (PST)
Date: Tue, 20 Feb 2024 10:58:22 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: X512 <danger_mail@list.ru>, qemu-devel@nongnu.org,
 qemu-riscv <qemu-riscv@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] target/riscv: fix ACPI MCFG table
Message-ID: <ZdQ4dlMovqdrN+kz@sunil-laptop>
References: <180d236d-c8e4-411a-b4d2-632eb82092fa@list.ru>
 <6960207f-eaaa-4cfd-a4e3-3118da697ef7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6960207f-eaaa-4cfd-a4e3-3118da697ef7@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Feb 19, 2024 at 05:43:56PM +0100, Philippe Mathieu-Daudé wrote:
> On 19/2/24 17:09, X512 via wrote:
> > MCFG segments should point to PCI configuration range, not BAR MMIO.
> > 
> 
> Fixes: 55ecd83b36 ("hw/riscv/virt-acpi-build.c: Add IO controllers and
> devices")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> > Signed-off-by: Ilya Chugin <danger_mail@list.ru>
> > ---
> >   hw/riscv/virt-acpi-build.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index fb8baf64f6..fe01b626ea 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -558,8 +558,8 @@ static void virt_acpi_build(RISCVVirtState *s,
> > AcpiBuildTables *tables)
> >       acpi_add_table(table_offsets, tables_blob);
> >       {
> >           AcpiMcfgInfo mcfg = {
> > -           .base = s->memmap[VIRT_PCIE_MMIO].base,
> > -           .size = s->memmap[VIRT_PCIE_MMIO].size,
> > +           .base = s->memmap[VIRT_PCIE_ECAM].base,
> > +           .size = s->memmap[VIRT_PCIE_ECAM].size,
Thanks!.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

> >           };
> >           build_mcfg(tables_blob, tables->linker, &mcfg, s->oem_id,
> >                      s->oem_table_id);
> 

