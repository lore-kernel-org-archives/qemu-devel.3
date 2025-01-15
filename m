Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E241C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 08:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXysY-0002cr-Pf; Wed, 15 Jan 2025 03:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXysX-0002cY-LN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:35:57 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tXysV-0006yH-VW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 03:35:57 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso1286516a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 00:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736930154; x=1737534954; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TreVLPX39i3omu5vjJeeIMcakpfb0MHnSRnZLHsqbvg=;
 b=F2A3QcgsktTLEjrGq9lRZqJhhigOnDVuXZGNWVcIVsWUoqa9GL0WXX0BM/l0gFMwEX
 Q9k9/0wE1QIdAeJvBqGcLarXqk8f+NJpLXyHcL5aNpTSXOMs0x4z/04GxYA2B8SsLunz
 j9gPpUvOWYNLt0U1QJLbtMor8BpnYNEi1Ljstj/gwi3umzMZfXt2dvlKO84nZu7F+Ltf
 VjGcEJQ34EklyQSt/FzwtkhtFegPxoDSYk+xHphV7lscUlj5B/MxgjgpYD1iYD8bt7I8
 A2TrfLB3BK0YsoqDXjtGZlorePDb2pwaeH+MlpB4MfGQWE+PK9H2iILcG4pLyO18/i8O
 ameQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736930154; x=1737534954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TreVLPX39i3omu5vjJeeIMcakpfb0MHnSRnZLHsqbvg=;
 b=eHR2gbtgogMIYem7fotsCkzZHEiKrGcd1rMQ5CjPSkAWMUvkDNWn/VVdiY2wpvGMwy
 tIjOboePh1GeACc78BWKds80AFnsuMRa5e0p/yuOF0s8VlK2OE6xSLvnGbGT0Wx2NYCn
 gVR3F+DUKv88ayHNPNoDinI7D50DSkdf0UN40EbYUJ90OyIg8wLAt2B4ndwgZRtFgx58
 hWlWd2GSYqP//EVgsp5+y8Dn3vyfa8JbePrOJHvBx/Dyy5gFXx0of64IcekQssCaF5Cj
 R3dzr8BhTg0/dNQ/H3BlW1FHIuIryBnFpHJQscqX5tEmZitT0BRA4V41zeyMdrlN1oDD
 txoA==
X-Gm-Message-State: AOJu0YxrqqXwuaVr6EsJc8B2RDIM0z6h6u55kBDUsfWtWIuVWM1d/vnB
 YihDZmDlXe8FHzexL41TsvaJnomy8AZ4ks0gi4g0KcNvzO0/1LjZtyWB1IAZPxA=
X-Gm-Gg: ASbGncv/IQUSA6kJwgewA12gduxHBGCghi0iofyQhat+2B4Y2iSem7HOyLPhNzfld9X
 A0vKT+ZhQBX+BXuHxgPkkglNneDC+Hj5EVYXeaU+WkOQTpoJEFCSAFuHqh8iDyeIYv32oKMCntg
 8DQ6CC+/palfaumawymYvp603Mk/2W6ZDb5vgs8whNMkAZwgqf6zuQaPMwm+DNdRVHEdNS1UM+N
 AXtgZGhb1YD5C738DuJx93nhiqTkfCCo9duan+iTtt0EqlNFed0rdymiLnp3YnCOf+iVYtMrH7u
 ZYGJWFZGHRH4fI+Il/fdIzzn++RVhoqLd/u1P76jWw==
X-Google-Smtp-Source: AGHT+IEt8fKAqg1c2xyXXBe/YuVYo4gTktKGjfERKr88fLYNT4237/2wQSAJaz4b1ElzVdaT+fGY3Q==
X-Received: by 2002:a05:6402:350a:b0:5d0:e7a0:154a with SMTP id
 4fb4d7f45d1cf-5da0c2c2872mr1711507a12.8.1736930154183; 
 Wed, 15 Jan 2025 00:35:54 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046dd55sm6929034a12.54.2025.01.15.00.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 00:35:53 -0800 (PST)
Date: Wed, 15 Jan 2025 09:35:52 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v2 1/4] target/riscv: add ssu64xl
Message-ID: <20250115-21c4025b79092052825694bf@orel>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114190001.1650942-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jan 14, 2025 at 03:59:58PM -0300, Daniel Henrique Barboza wrote:
> ssu64xl is defined in RVA22 as:
> 
> "sstatus.UXL must be capable of holding the value 2 (i.e., UXLEN=64 must
> be supported)."
> 
> This is always true in TCG and it's mandatory for RVA23, so claim
> support for it.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c                |   1 +
>  tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 398 bytes
>  2 files changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2..b187ef2e4b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -213,6 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
> index 695022d56c4ac16607d4c622955ad339fbbfe997..b14ec15e553200760a63aad65586913d31ea2edc 100644
> GIT binary patch
> delta 48
> zcmZo;?qlW(@^B96V`N}pOqj@Jz^cQ@$e^;(o|BQSxYW#~B4@H2qXkC_BLhPoBLf2f
> D`wIz-
> 
> delta 41
> wcmeBUZe!*O@^B7mV`N}poG_8gfK`Q&kwIpoJtyPj07f&87)Az$G)4vn0JA^`U;qFB
> 
> -- 
> 2.47.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

