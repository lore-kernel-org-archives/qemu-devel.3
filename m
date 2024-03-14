Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAC8C54E60
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqnZ-0004bG-QS; Thu, 14 Mar 2024 15:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkqnU-0004aj-Dv
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:31:24 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rkqnS-0006lK-FP
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:31:24 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-568107a9ff2so1649691a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710444681; x=1711049481; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QDm82kgs1koLHv7e0mRvTna5FDZBVGQ7ihe6nZd6rnU=;
 b=lmIEOhleEHsBLJ1PCgz2kzMhiDcGFWOC4qB78FeEqK/7/yJB5S8M3Mn9BSmUztn+PX
 iqpYIrCw1B5AbHn8woRCvB0x6fdzf89jSuwG+mCI8xPCbpsfsRUVd/6M64G02NuMXQtD
 BHcEGhwIeGW8KC9K0dASXTI3KjwQ9jqQLIGLKNGm1oaNvc+6VGA+kq6dQ3Cwfqhse9kI
 /q+SL2hjNk+XJkD9duSr7Jh3+uVawBw2gpsnN33XuaVY5HPe06BOaI16+uy7FCGcfRX8
 U9uhzDZ58NoxtsxuNEYAm+Ld5ml6IB3yHoAGH7WAGyXJ4YYo9Byl+kkSIe7EzJ7IIjLB
 IFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710444681; x=1711049481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QDm82kgs1koLHv7e0mRvTna5FDZBVGQ7ihe6nZd6rnU=;
 b=qD4GLIuG2Q6LbljNelSiCyOXyb+eBBAOqIbyh6Ef3S9YcsyiG/f37bLYZdlFQ64lA8
 C37KVLR90i5jKgNvKNi81ZgLO1OYTeGCVHmBxBvq0UJyiAkxtPN5EnNBYkcs17NVIS7M
 cgdPFHvavKbTTR7NAk8/GkBaWYHOYku2m90A65jUcZ38JF1uaXIb22KIqmuiNkmNnIZ+
 c0Ay/fr0Hi98YBS2Cv1qfrsvQU7iiGSajjJSH/EoBbO3LWSvO7dGAXTrHpOks2ru6iMx
 xdo8HflFtuHXCPO9FVoEqs81XnIcxZyWjr3RuGyv6Cjr8G0FB1jp6IlIMlWpECt3Bmqm
 tJyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqheoFg573iWJ6t8PN94rkVC5h/tOrmUSshS0m5cyOlqCiaMItikABH/SyTRubr3qb7PBWufjj4bE7SGeGJcmHEFCHFJ0=
X-Gm-Message-State: AOJu0YxrSDECOI49qY/fhwkTyQin4y9ZHShpk4dQuDijCIDHufnxSubN
 oPkEA92agzTuqQUundHPtmNyDVJJ5Vvu+4l0Wlx9YAyZEVDrWkqWTNVS5xXVVps=
X-Google-Smtp-Source: AGHT+IHXLdyXC1PGfy+QsiimxFWYb89gJA+FbJu/zqP6bc6APuLolHG1a8IxnFQGG6LlrbM6clgIZA==
X-Received: by 2002:a17:907:c783:b0:a46:42d4:fbd4 with SMTP id
 tz3-20020a170907c78300b00a4642d4fbd4mr2190025ejc.35.1710444680885; 
 Thu, 14 Mar 2024 12:31:20 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 h26-20020a17090619da00b00a4668200ba1sm961495ejd.207.2024.03.14.12.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 12:31:20 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:31:19 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 4/4] target/riscv: Enable sdtrig for Ventana's Veyron
 CPUs
Message-ID: <20240314-5963b4d688b6252d33f5b0b9@orel>
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
 <20240314185957.36940-5-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314185957.36940-5-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 15, 2024 at 12:29:57AM +0530, Himanshu Chauhan wrote:
> Ventana's Veyron CPUs support sdtrig ISA extension. By default, enable
> the sdtrig extension and disable the debug property for these CPUs.

You still have the 'and disable the debug property' here...

> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4231f36c1b..c9dda73748 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -569,6 +569,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
>      cpu->cfg.cbom_blocksize = 64;
>      cpu->cfg.cboz_blocksize = 64;
>      cpu->cfg.ext_zicboz = true;
> +    cpu->cfg.ext_sdtrig = true;
>      cpu->cfg.ext_smaia = true;
>      cpu->cfg.ext_ssaia = true;
>      cpu->cfg.ext_sscofpmf = true;
> -- 
> 2.34.1
> 

