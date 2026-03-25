Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A477FEA82D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5IdT-0000UU-ED; Wed, 25 Mar 2026 03:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5IdR-0000UG-FN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:26:37 -0400
Received: from mail-dl1-x1243.google.com ([2607:f8b0:4864:20::1243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5IdP-00042m-Pu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 03:26:37 -0400
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1273349c56bso6236122c88.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774423594; x=1775028394; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+b+NcI87RiS7zy39OEWrEyUUCHBcDYsmppdh0xWgHFU=;
 b=YPdPW/hdpYNpJaTmuAkwKVRwp8xNv4ndrH/G/ZeUHr8T/S1PDCk2q8DHnQbtujmY0o
 Xl1yFI36+5azQxNmIv94s5seizSZOKlb5SiEILJbl2qnWOWVBhrANS3EJlP8ono8dQQW
 y1347g1mxLPaSfV1S8uOAxrIOkaX4ihcn3JGwEJ3BXnNbK4KarGdQp2qhfqZ76UN/R4H
 FbGXYlCnQw03wJG1RsJRY9+Yd1iiTGIrcZAFcvtWBe711cTCv991LhlKOF+5tzv2k/AN
 RqTKMCaG+qeqnwQ7rEfcuC4blYaVhe1SCRnQSlN/4lwdHXcUcrHcgJKgYrjMbtKBB27I
 Jcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774423594; x=1775028394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+b+NcI87RiS7zy39OEWrEyUUCHBcDYsmppdh0xWgHFU=;
 b=iZBDvmi8ouprTzwh1aaxylWEpV93W1n60KzefZLKHeKzRRdRH4ESG0o3mwQwceN2Vt
 wOuMPqOvp6E1obxv+JjPPNBoWVAsu3ddBk31+9o+YsMDjKUb6SgEW5fTCFvg5em1QgaL
 mOPkdQFm08fqml+KpCKU89jIk7SE+k1Zru+rPVxCS7WRgTP7kLmBiarYDNAc5Fv5kez2
 miaUCEEvTxI9n6JoDJC4pnPMPJN1Ove49CpMu76G8ngYGu1mlBGQkoDaTkC/ToVtyZNE
 APAdEDwKPiwR3J7+7Ng4C7gsJO+M4UH9C/ERZCuXGusaTy9XxhMx1k2uHbdY2ukrzixg
 QQ9w==
X-Gm-Message-State: AOJu0Yzn3x4qwU69vcSz8sf3ItywP2FTd3S6g3Tw/VC6HZWhzfVTSqDh
 hxLXmYfTL6izMN711zBRa/HEB3xKcYEoRT1a6FsL0FRv824/mhoRHPKS
X-Gm-Gg: ATEYQzzTiI4YwDXbZd+PLfsqXACcy9YhoyszjJOOeRla41sYx5jmEaC76cnBnZwV2B3
 cu4W1OmD8ipnqDGPJ3DgoZfGSxpypYCPc8b3bOPrJEvVUhAkwgbIeYuFqveW/v4au5KHuvO0Unu
 jB/9DXY82VnVJjIZgsPWa6C98yE6imZKsctO+BeDqzRtVp1ryQSEUaLVzQEp/Zhk9BtZElQfGJF
 fUGZUJWPSv9XJ5/1wZYR3CAWMC4nyoejqIWFY1jj4/TYEnwFURxim//FKmWlDYbh0CGkoC2qD5Y
 Cpkholy0J/YBp4S+YjFnunMl4D2El63TnVU18/i5ZDnCuHmIuRQKvnXG3YK6Pzy8cOgm+46YbL5
 C8fhF6tD867d9+v8QDqJEjGl0WYmNdrUeQSmZX0e65jMNqnbGyIWdIhpJJCfUr+FOG6ZYVQrnOr
 DSRVGh8PaR9xAwWoAQ5vYueEhJfZLJMIGDBcfc7YY4PG+K60pOZN3ymQcSmvdzQJsCwoudrRMto
 xoCcVUGZrEx813CGwNBDc5UTfpz/KXBf+Ew5PEKAA==
X-Received: by 2002:a05:7300:7b90:b0:2ba:8018:cc57 with SMTP id
 5a478bee46e88-2c15d3680dcmr1113747eec.11.1774423593958; 
 Wed, 25 Mar 2026 00:26:33 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2cf068sm17069875eec.22.2026.03.25.00.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:26:33 -0700 (PDT)
Date: Wed, 25 Mar 2026 15:26:12 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, 
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v5 1/7] target/riscv: Add big-endian CPU property
Message-ID: <acON-ROjq3yW4eK6@ZEVORN-PC.localdomain>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
 <20260324164007.549397-2-djordje.todorovic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324164007.549397-2-djordje.todorovic@htecgroup.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1243;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1243.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 24, 2026 at 04:40:15PM +0000, Djordje Todorovic wrote:
> Add a "big-endian" boolean property to the RISC-V CPU configuration,
> defaulting to false (little-endian). This property allows machine
> models to configure individual HARTs for big-endian data operation.
> 
> The RISC-V ISA supports big-endian data accesses via the mstatus
> SBE/MBE/UBE bits, while instructions remain always little-endian.
> This property provides the configuration interface; subsequent
> patches will connect it to the CPU state and translation logic.
> 
LGTM.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..4537305dfe 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>  
>  static const Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
>  
>      {.name = "pmu-mask", .info = &prop_pmu_mask},
>      {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 70ec650abf..51436daabf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
>  BOOL_FIELD(ext_xmipscmov)
>  BOOL_FIELD(ext_xmipslsp)
>  
> +BOOL_FIELD(big_endian)
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
>  BOOL_FIELD(debug)
> -- 
> 2.34.1
> 

