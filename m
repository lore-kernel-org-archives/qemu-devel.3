Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7838AC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 18:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSLzD-0004KZ-GV; Tue, 23 Jan 2024 13:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSLzA-0004Jv-If
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:59:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSLz8-0005Nf-Da
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 13:59:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40eb033c1b0so24323305e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706036336; x=1706641136; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YhpwPIwMBlvL+OsTFRSnSM+bvZBcd/phHKPqJLfjKhc=;
 b=OlZVhsbThrvGftqLReSp9RCs3TY19jr4kTOzOupFtQb6r4rM1Sl5XAYtmnyzIcQMqo
 g4NIowvtzr1CkLkijK96le0zxyCL2hbx7WCZ6EvjJY6EmOXeymSyyGqBcFXktRbwKLD3
 1TQbjSl5r2XBFvs8e50Of9DSb2Ukg8vRJTDCRQOw8FYfUPVEk8hV6xbty0m/iL9y6znk
 vdB9+Yi2JoA+RB6GJ14Rq4/iY9+vrQIQN3LTrA6vtmZT64cC5vP/UMdArENFPKOir6/c
 tvegxcbVaaWyPBdU5g6gmB25JPVC6z0V+rUK1OwEuZxPBjbGwMWiap1c18gATPvJr2Bd
 YxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706036336; x=1706641136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhpwPIwMBlvL+OsTFRSnSM+bvZBcd/phHKPqJLfjKhc=;
 b=HfO9QahbyDOFKI+Ph3inhQsWpL8K42JgIpsmhyTNR+/b377IIM3/9ggi6FI4FT12XV
 pLqYNjrjOCkiX7pL5/24CEso1dB7Y2qARVVJnmdPAfk1is/K0sGGRCFus7MVt+givcfD
 JtjXgJ527Pb3ADEddvOIHtfs8B8nJBct4JN/xF2WQwfRMF1M2DE4n7yzxWJ6lPSdvz9M
 Oq5TUJns6V8BD935XXnBJl61jWKt+7J6NRah1ajM0AX6nSAqwYIEyByZt0bZ8QrKsSfa
 rjSldhXArHfL6inRbkxBpOGTi/1FTeRPo2u+WADpugBhV5FKQ1xZ3CC2etBNOBmZ1by6
 3PFg==
X-Gm-Message-State: AOJu0YwAeHyAjCpHbKTK3qxjVTQKGcPNukCn0s5hzi0c25/3BaciMxDW
 yBEhA1IIzwwi/A3TafDIwNHcaVOgg/IyB5MqPFoTVtVjBKO6FaN1S6vvKbE/uK8=
X-Google-Smtp-Source: AGHT+IH7eghgmAdzVN2+5+XImR18tQVseP+Gn83qv2kqsEP+H9kqhzfmEnNFZEWcVWVUgi+RHKd3/g==
X-Received: by 2002:a05:600c:5029:b0:40d:f9c8:887f with SMTP id
 n41-20020a05600c502900b0040df9c8887fmr430653wmr.51.1706036336582; 
 Tue, 23 Jan 2024 10:58:56 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfee03000000b003368c8d120fsm17027966wrn.7.2024.01.23.10.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 10:58:56 -0800 (PST)
Date: Tue, 23 Jan 2024 19:58:55 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/4] target/riscv: SMBIOS support for RISC-V virt
 machine
Message-ID: <20240123-09e26e57d75c53e4872d158f@orel>
References: <20240123184229.10415-1-heinrich.schuchardt@canonical.com>
 <20240123184229.10415-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123184229.10415-4-heinrich.schuchardt@canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x330.google.com
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

On Tue, Jan 23, 2024 at 07:42:28PM +0100, Heinrich Schuchardt wrote:
> Generate SMBIOS tables for the RISC-V mach-virt.
> Add CONFIG_SMBIOS=y to the RISC-V default config.
> Set the default processor family in the type 4 table.
> 
> The implementation is based on the corresponding ARM and Loongson code.
> 
> With the patch the following firmware tables are provided:
> 
>     etc/smbios/smbios-anchor
>     etc/smbios/smbios-tables
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
> 	remove a superfluous #ifdef
> v3:
> 	use misa_mxl_max to determine bitness
> v2:
> 	set processor family
> ---
>  hw/riscv/Kconfig |  1 +
>  hw/riscv/virt.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

