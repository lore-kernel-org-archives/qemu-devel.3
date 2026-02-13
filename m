Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1C7EF48C4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqjcv-000350-Ba; Thu, 12 Feb 2026 22:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1vqjct-00034K-AA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:13:51 -0500
Received: from sg-1-14.ptr.blmpb.com ([118.26.132.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1vqjcm-0006KP-LM
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1770952407;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=SMiPmoWdNPfQCkJf8CLoYEECXDZYUs7HxlJg5dWAf14=;
 b=q9VMtpfS56MXTRTvQ1mZh0FYKbK6Hvoe7KaNQxdJb2UZwO39ns9lAh17kGvgbtXMwpUT6T
 bcZqqkMJtpEWX0/HieQbU0NRD17cQa1/5BTcmQawDNmVd+vnWV7HE9wj/6CibjdfZDuaTP
 2kjpFhAXUYLLdAhhgq3RSAwsxvtf9fIR8YofeQQ/YA3CBsT1sif/+ClZb5GDzrhEVYGzHt
 6Hc8BboMFDjzzMOPLJtir6JUmqCY1rAKdUdFw9BcqLEM+inxi3B9VLAtep7WcvnB1R29Xo
 dC9vZztTPXXUGPEm6QTGpJS7S0ZpHHlahsxEhv0xXpdOm0z7TGbP8PaLejXTpg==
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
X-Lms-Return-Path: <lba+2698e96d6+0447a7+nongnu.org+liujingqi@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2026 11:13:22 +0800
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Mime-Version: 1.0
References: <20260127014227.406653-1-max.chou@sifive.com>
 <20260127014227.406653-2-max.chou@sifive.com>
In-Reply-To: <20260127014227.406653-2-max.chou@sifive.com>
Content-Language: en-US
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>
User-Agent: Mozilla Thunderbird
Message-Id: <ed2189dd-40cb-4e73-9347-38a932e460eb@lanxincomputing.com>
Subject: Re: [PATCH v3 1/9] target/riscv: Add cfg properities for Zvfbfa
 extensions
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([61.173.162.13]) by smtp.feishu.cn with ESMTPS;
 Fri, 13 Feb 2026 11:13:25 +0800
To: "Max Chou" <max.chou@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Received-SPF: pass client-ip=118.26.132.14;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-14.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/27/2026 9:42 AM, Max Chou wrote:
> The Zvfbfa extension adds more complete BF16 vector compute support
> and requires the Zve32f and Zfbfmin extensions.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/cpu.c                | 1 +
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
>   3 files changed, 10 insertions(+)
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fa7079d86e..cf237305c5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>       ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>       ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
> +    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
>       ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
>       ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>       ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 70ec650abf..3696f02ee0 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
>   BOOL_FIELD(ext_zvksc)
>   BOOL_FIELD(ext_zvksg)
>   BOOL_FIELD(ext_zmmul)
> +BOOL_FIELD(ext_zvfbfa)
>   BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 988b2d905f..720ff0c2a3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvfbfa) {
> +        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
> +            error_setg(errp, "Zvfbfa extension requires Zve32f extension "
> +                             "and Zfbfmin extension");
> +            return;
> +        }
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;

