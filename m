Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB571C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 10:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWeF-0006bs-DQ; Mon, 26 Aug 2024 06:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1siWeD-0006at-N0
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 06:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1siWeC-0002BG-7G
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 06:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724666906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r3tRrq2SAP870ylPxKYD6FqgVcg+euXApnt4b0jM/9g=;
 b=EQo/8ek580zjD2H09jjyEGxOSPNAdfCFXC5Q0TmaVwFiRKuxTx6empS9blvBVFMsH48LzN
 1bP1Bkx6/bwlApUHVnN5kct1njlUmgLYi2KPsTnMKWN7BllcEej/O1snolBjPEpMB33P0h
 0kadzmS6+fyUWUUMHgeDhncNNgLJ8p0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-ve82VjBbOFuAuK1eg0tGOA-1; Mon, 26 Aug 2024 06:08:24 -0400
X-MC-Unique: ve82VjBbOFuAuK1eg0tGOA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3719ee7c72eso2505375f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 03:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724666903; x=1725271703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r3tRrq2SAP870ylPxKYD6FqgVcg+euXApnt4b0jM/9g=;
 b=mhRTwMsbessZmwljxseNCVaJ1vGW+dx/oDfnNHkd5srv72dztYrotzyBcAnIx6AbdK
 C3tMT2QBsRndnL/e2zzMd+0pqk5Jxm8C1F2BDXbIr7kcxb87u/NcmKNyKebsV2K3zXL1
 yITwXKCqRTvN1FMfcZAuPDS5RVpmk1avzs6nX+JBAm9WyG6+snbGHNB/QtftdtTtYU5m
 /C8m3aLgZ7l4NedQScRc+WIjV6jeEG7kS6AExnwphgUCNAXgOGrn/b8y9tA3Y+V7IVDk
 CuqdFsaMD31ISJ6jD3F1VQCxamwX7wxhiE3Vw3TBn1ILbqa7QlZ7t6TuQNVWr8Gly7ru
 35Uw==
X-Gm-Message-State: AOJu0YzV3fSR40wyptsYCJM/B7r0JcKhi9lW8sJVzi34Mrt6oxGeeQ8Z
 Mm539c3Vncc3H3movWr91JiRiDxP0ZZAAVLDVQSw7kJGl/vDytYL5cyQiHZQF+D346B8Vm3CnQR
 mCl+Gdg02C6LjC1yymi+mEwaVcJI0TfVAW8Yr0zKpvh0cyCdZd8cYo8GzpRgy
X-Received: by 2002:adf:f7d2:0:b0:368:77f9:fb34 with SMTP id
 ffacd0b85a97d-37311857bf9mr5441652f8f.15.1724666903300; 
 Mon, 26 Aug 2024 03:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9p1UmBJIDqohznYCq4mCaADnzUxD2GX+PtzdxTJfaYyD1xRwRjFrPJfxZ4CmkTWqoW8jYdA==
X-Received: by 2002:adf:f7d2:0:b0:368:77f9:fb34 with SMTP id
 ffacd0b85a97d-37311857bf9mr5441635f8f.15.1724666902839; 
 Mon, 26 Aug 2024 03:08:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730815c0f0sm10392219f8f.51.2024.08.26.03.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 03:08:22 -0700 (PDT)
Message-ID: <8bacf253-216b-4354-88ba-30a9e8f88110@redhat.com>
Date: Mon, 26 Aug 2024 12:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ppc/pnv: Fix LPC POWER8 register sanity check
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806131318.275109-1-npiggin@gmail.com>
 <20240806131318.275109-3-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240806131318.275109-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> POWER8 does not have the ISA IRQ -> SERIRQ routing system of later
> CPUs, instead all ISA IRQs are sent to the CPU via a single PSI
> interrupt. There is a sanity check in the POWER8 case to ensure the
> routing bits have not been set, because that would indicate a
> programming error.
> 
> Those bits were incorrectly specified because of ppc bit numbering
> fun. Coverity detected this as an always-zero expression.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Resolves: Coverity CID 1558829 (partially)
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/pnv_lpc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index 80b79dfbbc..8c203d2059 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -427,8 +427,8 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
>       int irq;
>   
>       if (!lpc->psi_has_serirq) {
> -        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
> -            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
> +        if ((lpc->opb_irq_route0 & PPC_BITMASK32(8, 13)) ||
> +            (lpc->opb_irq_route1 & PPC_BITMASK32(4, 31))) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                   "OPB: setting serirq routing on POWER8 system, ignoring.\n");
>           }


