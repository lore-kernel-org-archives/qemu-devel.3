Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CEBC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 22:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtxZ0-00038T-4x; Mon, 08 Apr 2024 18:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rtxYy-00037a-IG
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 18:34:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rtxYw-0008Eo-LZ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 18:34:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e220e40998so31242655ad.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1712615639; x=1713220439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hajyPimY4X17iNMgcO8caBbe9T/dEKp/CSm9o6I0OlA=;
 b=fYlhB4uoCH7kZn/deJXrfjJ3pMXzeFYYuJBPy+dMH+N+dAGiGK6OxoGV6keEH/avfN
 fl450cPPuQOfBBAAIWXiS7gu4JEAuhNz2xiIL1MfcSO0RN3vCEimK18bhZ5DS68JHnY6
 QH90benK2dOmwn4onhFD4i0146P+d03ybFuJ3MHZ6MELXxUAsi/VS10KnuDEbjoijiFa
 VJXN9l+6q6LkROWGHUgApdM5XNTvs/F8+W7PDuI/p+dkN08w7f//OoK106JEDFvDjORz
 nMNQWqpMmD/RGjopnyDisIS8YIcYCt3uBLpdTneCcMIAnj14s5J/mnJfm8mMW/CUgThT
 n48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712615639; x=1713220439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hajyPimY4X17iNMgcO8caBbe9T/dEKp/CSm9o6I0OlA=;
 b=iwZj4hL7hqpMgRiYpngZcUEE+Ajn28E8SJnP51mpyCMia0A6D4LcBDUq0RAL0EHvyp
 dcRWJkaH5PAbKVSC92b1H7gTb4ftMCnT9XUMbeLjIzCc6YNnCv7GTk67qEw2O0i0tJBo
 RMZlssLnB1Sun73CvjW2XSrkIxuirdmabkre49TAeM1IJX3q28baDhGw3r0PTGTwv5Ug
 XsUtDmJZZ+g9Mag20i9icw1+3s6G+O/xS91V9JVLqKrffrfXI0XJPsHu8OO1Wlw7oXXk
 qpLt2rkmZBnex/n2VLSYP8w64oxM/6GHP8pzZCGq5/5aSYnzB92ihKt3sz1hYDV7UsTe
 2vkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4k8unLVO1BEvTS5qYmllcaLhdQc1Ux//4Br5P5+JM0QHR1EfPlCRPv70HZ8B8NrFCYTS0KEYusJprl+4GtUGFDqDjt4M=
X-Gm-Message-State: AOJu0YwRr9iRO0JI/y/jhBzONqq9YJQLJX1jnqbFlQ2GPK4ZaIzRweg/
 XZMPqDSPCNX1mMveu2hgTfZ+JMA9TUaS206ZeWw3vbiXWR3Wwr1JlnttsNi/pEs=
X-Google-Smtp-Source: AGHT+IGJbdvhXPKqGNnGtvoaN9DGLTLAoLP8FXHGKaEXP3vaGCn2lVqdsI23ep53egDqIyz+p5ColQ==
X-Received: by 2002:a17:902:ce89:b0:1e4:25e8:c2f1 with SMTP id
 f9-20020a170902ce8900b001e425e8c2f1mr4982798plg.29.1712615639486; 
 Mon, 08 Apr 2024 15:33:59 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a170902e88b00b001e3e0968f8asm5073595plg.248.2024.04.08.15.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 15:33:59 -0700 (PDT)
Message-ID: <eb3ec708-b4f7-431a-bef0-b09a458f422b@ventanamicro.com>
Date: Mon, 8 Apr 2024 19:33:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/riscv_aplic: APLICs should add child earlier than
 realize
Content-Language: en-US
To: "yang.zhang" <gaoshanliukou@163.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com,
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 anup@brainfault.org
Cc: "yang.zhang" <yang.zhang@hexintek.com>
References: <20240407034652.25739-1-gaoshanliukou@163.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240407034652.25739-1-gaoshanliukou@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 4/7/24 00:46, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
> 
> Since only root APLICs can have hw IRQ lines, aplic->parent should
> be initialized first.

I think it's worth mentioning that, if we don't do that, there won't be
an aplic->parent assigned during riscv_aplic_realize() and we won't create
the adequate IRQ lines.

> 
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> ---

Please add:

Fixes: e8f79343cf ("hw/intc: Add RISC-V AIA APLIC device emulation")


And:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>




>   hw/intc/riscv_aplic.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index fc5df0d598..32edd6d07b 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -1000,16 +1000,16 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
>       qdev_prop_set_bit(dev, "msimode", msimode);
>       qdev_prop_set_bit(dev, "mmode", mmode);
>   
> +    if (parent) {
> +        riscv_aplic_add_child(parent, dev);
> +    }
> +
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>   
>       if (!is_kvm_aia(msimode)) {
>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>       }
>   
> -    if (parent) {
> -        riscv_aplic_add_child(parent, dev);
> -    }
> -
>       if (!msimode) {
>           for (i = 0; i < num_harts; i++) {
>               CPUState *cpu = cpu_by_arch_id(hartid_base + i);

