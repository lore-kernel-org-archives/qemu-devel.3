Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B38D10775F9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ubR-00029x-Kp; Wed, 18 Mar 2026 13:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2ubQ-00029c-4b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:22:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1w2ubO-0001RQ-Qv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wURKBStinIHx13qQ3KUnzIROQt/nFH4JVSzqCmlflM4=; b=QZzdRgBdIb9bhtq
 8TsUiMsUeO8vo4XAP+CcaFWNRtBKpDG2omnT0F1oxQYROOXy5Nnm20HNsOlKgLHY2WtqrvArsphJX
 ZNeYNcr9+VQE56+6itvcZu0rBLgbLfbT4vifeIVmqaJplBwNBTb6X5sdKkRxzZRejdPY2YzuCT/Ru
 TM=;
Date: Wed, 18 Mar 2026 18:26:27 +0100
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/6] hw/hppa: Adjust physical addresses of Astro and Elroy
Message-ID: <abrgPh3u6pnZ9acv@hive.localdomain>
References: <20260317195149.8386-1-deller@kernel.org>
 <20260317195149.8386-3-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317195149.8386-3-deller@kernel.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/03/26, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Adjust the addresses of the Astro and Elroy PCI chips to a
> 44-bit physical address space when running a PA8700 CPU.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/hppa_hardware.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index 0a89c3ed52..006aae63b9 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -61,8 +61,8 @@
>  #define ASTRO_BUS_MODULE        0x0a            /* C3700: 0x0a, others maybe 0 ? */
>  
>  /* ASTRO Memory and I/O regions */
> -#define ASTRO_BASE_HPA            0xfffed00000
> -#define ELROY0_BASE_HPA           0xfffed30000  /* ELROY0_HPA */
> +#define ASTRO_BASE_HPA            0xffffed00000
> +#define ELROY0_BASE_HPA           0xffffed30000  /* ELROY0_HPA */
>  
>  #define ROPES_PER_IOC           8       /* per Ike half or Pluto/Astro */
>  
> -- 
> 2.53.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

