Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46944CAC5B5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 21:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1t6j-0007Ev-68; Thu, 25 Sep 2025 17:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1t6h-0007EJ-3g
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1t6X-0003nV-56
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 17:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758834129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dAKBKg/5QHsUvtQ86t/zeFsv1YpgjfsRLA16ekZkz4Q=;
 b=D0F3vOxCWHrh3PPEP00pvRE7cXW3UVfoaB5UeqX2m8O8cueJ94vST+qCnNcEXUz94Efquv
 RuYAn+MqGkf7uGRdAwBF6dWoThyIK6nz+StFz6BFmV6qBDJV5a88w1NC7CtjvAHOmUwubT
 BPXCdcXzojokS9qqaB+t8ScxEQVkmeY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-vC2vzdLyO-y6gcpO_1imZw-1; Thu, 25 Sep 2025 17:02:07 -0400
X-MC-Unique: vC2vzdLyO-y6gcpO_1imZw-1
X-Mimecast-MFC-AGG-ID: vC2vzdLyO-y6gcpO_1imZw_1758834126
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e2c11b94cso8033315e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 14:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758834126; x=1759438926;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dAKBKg/5QHsUvtQ86t/zeFsv1YpgjfsRLA16ekZkz4Q=;
 b=DaFf3Io0ibR0EhKo39v/fLQkfCi2xZhUHuHtKp7ORF+1IFHO7FE3tF3y5Rzz5maq/G
 XbbbHMA+qXFGIB1SsME2qAphicqs5xEhwagMvPYy1xbn0ZHkstp4UTWo3PTauPEeqbfz
 yNsIY97SerkxjaHBtvNaTdBVUrIJ/de1gqK981RB6ItdC3rXCP5LBGxa8Vl4S4bxpvIp
 MNcgNNqhei1tPOFiIJim/N3vACFjg4800tQLKB5PKBM/kjKYUTtrQmzHooCMnUsRAG8Z
 0gGZuvldfRb9dDVS4VSUK5NgA6+OcjPlH2le/ORhBEtPBId1MAUGY2zcTpYhdnnkUq8G
 MKtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFE/EQTkalmMwFydhhJ8gAJemVWm3Lnc9yAEdb2e/CnD2LzoeNZmQ2jZBVMcPn6PmiRjHwgEgOXVPS@nongnu.org
X-Gm-Message-State: AOJu0YxwL9iE+NOaOzfoG7s2fLya7BD/j8JFXH0adFs7P7Vlf5g/RC/H
 S1/1xsfWmDG3caRlErt6NqbB9fC+dqeq2Qa+nmUDGgxha9Bcj68AgnzUydqAZfkCDkV/KN5gzMl
 t6AVtz69Z6a+q6pePbEsmy3GwhDxhN5KTIklV8Eh5LAgDlxCvLJ2Za49f
X-Gm-Gg: ASbGnctxkMnpaeCEh6HjAeR9wHLcA+e9jbdsDdxcypTB8lbrkUZ7J2gM2EsdEzRbGnU
 aXmStpO6Wii4dgkRCUFfjYcUEP2z8KyLjKqIEY2i6IUacxTigTkLYS+mPdmIdcR8CRnu3LB2RQr
 iuJrDXLeNHb4VrlxSSGeCf12O5gNAZVo3COx9Y1LiM0pVRg/v9dprzRULMC0UFgk0lk9d0ScUUK
 I4qDIDZkzLJXjT9lHj4eW+ADHCJlQEOWAtlBSDlWXCeY5FRkMiH0qRifpZCSIDXz88bVsYJJR4/
 j3aA5bKc9iHDTUVbgubVFKUqavXXjrlIslZjJf6yrRsEEYV8vkOIpbPg0xqsXlSSVt/GNshC7pC
 xOHo=
X-Received: by 2002:a05:600c:154c:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-46e32aee352mr56424785e9.30.1758834126122; 
 Thu, 25 Sep 2025 14:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB00wpyz4NL3PPOpD6ueb1uxnEmQZg5cYl+WmLqRUGowDQ/30GoZ8/oRYXSmvMAqJrVC2I3Q==
X-Received: by 2002:a05:600c:154c:b0:45d:f88f:9304 with SMTP id
 5b1f17b1804b1-46e32aee352mr56424485e9.30.1758834125688; 
 Thu, 25 Sep 2025 14:02:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e32b4d71csm26105415e9.0.2025.09.25.14.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 14:02:05 -0700 (PDT)
Message-ID: <9bfc50c6-1bb2-4e94-bf8b-98ae2a33540f@redhat.com>
Date: Thu, 25 Sep 2025 23:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] ppc/pnv: Add PnvChipClass handler to get
 reference to interrupt controller
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Mike Kowal <kowal@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-4-adityag@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250925173049.891406-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/25/25 19:30, Aditya Gupta wrote:
> Existing code in XIVE2 assumes the chip to be a Power10 Chip.
> Instead add a handler to get reference to the interrupt controller (XIVE)
> for a given Power Chip.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c       |  4 ++--
>   hw/ppc/pnv.c              | 12 ++++++++++++
>   include/hw/ppc/pnv_chip.h |  1 +
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index e019cad5c14c..0663baab544c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -110,8 +110,8 @@ static PnvXive2 *pnv_xive2_get_remote(uint32_t vsd_type, hwaddr fwd_addr)
>       int i;
>   
>       for (i = 0; i < pnv->num_chips; i++) {
> -        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
> -        PnvXive2 *xive = &chip10->xive;
> +        PnvChipClass *k = PNV_CHIP_GET_CLASS(pnv->chips[i]);
> +        PnvXive2 *xive = PNV_XIVE2(k->intc_get(pnv->chips[i]));
>   
>           /*
>            * Is this the XIVE matching the forwarded VSD address is for this
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 423954ba7e0c..a4fdf59207fa 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1486,6 +1486,16 @@ static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>       xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), buf);
>   }
>   
> +static void *pnv_chip_power10_intc_get(PnvChip *chip)
> +{
> +    return &PNV10_CHIP(chip)->xive;
> +}
> +
> +static void *pnv_chip_power11_intc_get(PnvChip *chip)
> +{
> +    return &PNV11_CHIP(chip)->xive;
> +}
> +
>   /*
>    * Allowed core identifiers on a POWER8 Processor Chip :
>    *
> @@ -2680,6 +2690,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, const void *data)
>       k->intc_reset = pnv_chip_power10_intc_reset;
>       k->intc_destroy = pnv_chip_power10_intc_destroy;
>       k->intc_print_info = pnv_chip_power10_intc_print_info;
> +    k->intc_get = pnv_chip_power10_intc_get;
>       k->isa_create = pnv_chip_power10_isa_create;
>       k->dt_populate = pnv_chip_power10_dt_populate;
>       k->pic_print_info = pnv_chip_power10_pic_print_info;
> @@ -2709,6 +2720,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
>       k->chip_cfam_id = 0x220da04980000000ull; /* P11 DD2.0 (with NX) */
>       k->cores_mask = POWER11_CORE_MASK;
>       k->get_pir_tir = pnv_get_pir_tir_p10;
> +    k->intc_get = pnv_chip_power11_intc_get;
>       k->isa_create = pnv_chip_power11_isa_create;
>       k->dt_populate = pnv_chip_power11_dt_populate;
>       k->pic_print_info = pnv_chip_power11_pic_print_info;
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 6bd930f8b439..a5b8c49680d3 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -170,6 +170,7 @@ struct PnvChipClass {
>       void (*intc_reset)(PnvChip *chip, PowerPCCPU *cpu);
>       void (*intc_destroy)(PnvChip *chip, PowerPCCPU *cpu);
>       void (*intc_print_info)(PnvChip *chip, PowerPCCPU *cpu, GString *buf);
> +    void* (*intc_get)(PnvChip *chip);
>       ISABus *(*isa_create)(PnvChip *chip, Error **errp);
>       void (*dt_populate)(PnvChip *chip, void *fdt);
>       void (*pic_print_info)(PnvChip *chip, GString *buf);


