Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8790C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicgD-0007v3-9D; Mon, 26 Aug 2024 12:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sicgB-0007uW-P3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sicgA-00034g-8V
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724690093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rx+QvevCQc86wb0Y0HyQUut+wnMWs/NEiWwHBaEP52g=;
 b=cdD9pYlfw4itvGGlUC99vmL+h3PnaaHYp32RwqSDTXlIw+234N8djnplwW+tBU4MPS/tue
 Z3XIvDHUbs/jBGjtK9cqI6Yg2LJrtbsMShxfSK6YbEF2lrHSFs2TYuxS92iMtRCzYSLjgR
 nHAOV0CLqnzJuZxR7roobZqmK9YmGow=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-GGNeq4IbPVKm1I7uBrPPTg-1; Mon, 26 Aug 2024 12:34:50 -0400
X-MC-Unique: GGNeq4IbPVKm1I7uBrPPTg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bf6bdb14baso54273156d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724690087; x=1725294887;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rx+QvevCQc86wb0Y0HyQUut+wnMWs/NEiWwHBaEP52g=;
 b=R6cOi9m6/ozHz1dst6c+quRZqV9vY1zrbaQySsRYHg8+FbAM7COpZOT23Zd3NAc3Mb
 a3U+rFHTsJWMcT+j5W+RtGDyO5WjwaTRDXydrBC5Lph7+fYZ5rRjANJ/7IzARJ+EMVEk
 Nd3SNsZnUBLT5pnEoe+UM2AyKmx+ihrR//TRBU1zPGmm0gOXKKiUcJhl6GuV6LwdT2Rg
 EtZ/zZGn8Qy9p46p8ZJo7N0gY/Ek8UfyDLEPCgqS6fcUnl6H2rkkNlGb/06Tt2iFC5ri
 5G75okupZ8+kTJqhP/4c4+GfrQuN/Z2wPU8//ge/jOl3b5FV53cgN5FRrz6qlfTui5oy
 1GZQ==
X-Gm-Message-State: AOJu0Yw2WixQfOOaK60UfI+n2jCRhC/ZMLIKh0vz2Bb15tEO75FRwZeL
 yuJjDZDW/REz4q3VBRHurFC3FP6LkjefJ9JYx70ZTgEsOZvCczXnuLcUGqOm2FySpMo8z3kCsFH
 DhHrSjxmyScxx4ORBv1rVKHpTLmsWNP7ZwAWs1iY2iA67IMP3nKVx
X-Received: by 2002:a05:6214:5691:b0:6c1:54f2:1dde with SMTP id
 6a1803df08f44-6c16deb3968mr115424716d6.46.1724690087403; 
 Mon, 26 Aug 2024 09:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF61VJ/+HdphIsJjcmn8+cVeol7QKHBJfRBBF+AM7AK1ggrskVua7/eeImlf2wY1Gav9L3fgQ==
X-Received: by 2002:a05:6214:5691:b0:6c1:54f2:1dde with SMTP id
 6a1803df08f44-6c16deb3968mr115424426d6.46.1724690086991; 
 Mon, 26 Aug 2024 09:34:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d21710sm48068266d6.11.2024.08.26.09.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:34:46 -0700 (PDT)
Message-ID: <9eef76cf-3e89-4d67-85b8-e32b5c2a4686@redhat.com>
Date: Mon, 26 Aug 2024 18:34:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] ppc/pnv: Fix LPC serirq routing calculation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806131318.275109-1-npiggin@gmail.com>
 <20240806131318.275109-2-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240806131318.275109-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/6/24 15:13, Nicholas Piggin wrote:
> The serirq routing table is split over two registers, the calculation
> for the high irqs in the second register did not subtract the irq
> offset. This was spotted by Coverity as a shift-by-negative. Fix this
> and change the open-coded shifting and masking to use extract32()
> function so it's less error-prone.
> 
> This went unnoticed because irqs >= 14 are not used in a standard
> QEMU/OPAL boot, changing the first QEMU serial-isa irq to 14 to test
> does demonstrate serial irqs aren't received, and that this change
> fixes that.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Resolves: Coverity CID 1558829 (partially)
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   target/ppc/cpu.h |  1 +
>   hw/ppc/pnv_lpc.c | 10 ++++++++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 321ed2da75..bd32a1a5f8 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -40,6 +40,7 @@
>   
>   #define PPC_BIT_NR(bit)         (63 - (bit))
>   #define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT32_NR(bit)       (31 - (bit))
>   #define PPC_BIT32(bit)          (0x80000000 >> (bit))
>   #define PPC_BIT8(bit)           (0x80 >> (bit))
>   #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index f8aad955b5..80b79dfbbc 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -435,13 +435,19 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
>           return;
>       }
>   
> +    /*
> +     * Each of the ISA irqs is routed to one of the 4 SERIRQ irqs with 2
> +     * bits, split across 2 OPB registers.
> +     */
>       for (irq = 0; irq <= 13; irq++) {
> -        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
> +        int serirq = extract32(lpc->opb_irq_route1,
> +                                    PPC_BIT32_NR(5 + irq * 2), 2);
>           lpc->irq_to_serirq_route[irq] = serirq;
>       }
>   
>       for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
> -        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
> +        int serirq = extract32(lpc->opb_irq_route0,
> +                               PPC_BIT32_NR(9 + (irq - 14) * 2), 2);
>           lpc->irq_to_serirq_route[irq] = serirq;
>       }
>   }


