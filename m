Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30157D1712B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2y6q-0005Z9-72; Mon, 21 Oct 2024 15:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t2y6c-0005Xp-Q7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:30:29 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t2y6b-0008Sl-7H
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:30:18 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db908c9c83so3049152a12.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1729539015; x=1730143815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wtFFM01MtMk7bKwjAfnzZ86kCwFKc7QNS/KueXIyn24=;
 b=fkkVMHDoBNxk9zi/y3l8mySsqSLoYvJhxodKYCsvfP54pN7z3AIuB+Ov8jHZD+7OUa
 pj/4LQlybPT3PWOkCsvgonPG4PjwrKXAK0UJ+iN5SkbACLHe3ub2SXJmqZTGdDo48RPN
 6ctcm2r4hSzN8U2futOSmfhCYCfXWINExIbnHfENreXJ+3vH0a5mX3fThFJye1J/fTxX
 iPy45H07Z3waeFLBIdFPevJlXC/GNFTo7czs9GH40EJN4jD7Gz9vO9aHKfNBl9qKAOeh
 eW39BhaRh7BrKsJka392Hi8G+Wegz9JDBbHJmfClFQ10rKPhqUBT+CKumslHbXHSyFDz
 ZM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729539015; x=1730143815;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wtFFM01MtMk7bKwjAfnzZ86kCwFKc7QNS/KueXIyn24=;
 b=kjrmX/wcUYr16p7iGvaKVWhbNyxc2SUDRTsh/Ivi5iPr0SPSEddgZRo4GBwmx0my54
 z95bjDaBsJEl84cWfiU2LkIg4uaMjTWfIEYpI1UPAP5SjSh2/ChV1mEVwHsaXfPzfSRD
 PLPtwsu4yG8YokF3sc9jCTIv1WjU/TCarRYjEXT3EHJOI4tjI67Tj8e+EqQIvobz5+/b
 xzRKgwMu8bFTcwDAhDtWUHnGAgJjDErat8qj9MBD9BToUTlMqypk1kqUc5aAjAeeQabG
 E1920oCDp0hIvWdZUHcaaLeKwJBvqQYz2QYpJenQ5GFvL+y7YgDsS52KkzYsycGGcBGw
 pJEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUctciwXtVIxVMbYtZnQy4mcbMcbAeeR61EZGlRtP5xcRo3gFDdfd+c447HrapVDAiyiVVtPb/ZynFa@nongnu.org
X-Gm-Message-State: AOJu0YxlcRZYVR3gnE95jJodfFw3+q+l8Ko4IlHuJxfGZcl98lneC/PO
 t1p2gasI4hKxwjKytaX7VYS+ZWIAyt67C7AMYVrG8K4Sy1jS/V0r0JjrKHCnkQQ=
X-Google-Smtp-Source: AGHT+IEkUNzzlVgHu0mQ344HQHz8Mu++7c6xwW5NhPYSujGQN9oo8xcijGXWZtTRdoo9Fv9gsy2bpg==
X-Received: by 2002:a05:6a20:ba29:b0:1d9:6a6b:f7a4 with SMTP id
 adf61e73a8af0-1d96a6bf9a2mr1425189637.49.1729539015484; 
 Mon, 21 Oct 2024 12:30:15 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:242b:63dc:6000:cdfb:8dda?
 ([2804:7f0:bcc0:242b:63dc:6000:cdfb:8dda])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeaafd36esm3542130a12.6.2024.10.21.12.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 12:30:15 -0700 (PDT)
Message-ID: <25ae806f-38de-425f-8590-1c605d93197d@ventanamicro.com>
Date: Mon, 21 Oct 2024 16:30:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv: Support different address-cells for initrd
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Conor Dooley <conor@kernel.org>
References: <20241021040942.400-1-jim.shu@sifive.com>
 <20241021040942.400-3-jim.shu@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241021040942.400-3-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
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



On 10/21/24 1:09 AM, Jim Shu wrote:
> The cells of 'initrd-start/end' should follow the '#address-cell'.
> QEMU API could support 1 and 2 cells.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   hw/riscv/boot.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index ad45bd7a6a..76b099c696 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -182,6 +182,7 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
>       void *fdt = machine->fdt;
>       hwaddr start, end;
>       ssize_t size;
> +    uint32_t acells;
>   
>       g_assert(filename != NULL);
>   
> @@ -209,9 +210,18 @@ static void riscv_load_initrd(MachineState *machine, uint64_t kernel_entry)
>   
>       /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
>       if (fdt) {
> +        acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
> +                                       NULL, NULL);
> +        if (acells == 0) {
> +            error_report("dtb file invalid (#address-cells 0)");
> +            exit(1);
> +        }
> +
>           end = start + size;
> -        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-start", start);
> -        qemu_fdt_setprop_u64(fdt, "/chosen", "linux,initrd-end", end);
> +        qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-start",
> +                                     acells, start);
> +        qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initrd-end",
> +                                     acells, end);
>       }

Is this a legal format for linux,initrd-start and linux,initrd-end?

This link:

https://www.kernel.org/doc/Documentation/devicetree/bindings/chosen.txt

Defines both attributes as:

"These properties hold the physical start and end address of an initrd that's
loaded by the bootloader."

So I'm not sure if this format you're using here is valid.


Conor, care to weight in? Thanks,

Daniel

>   }
>   

