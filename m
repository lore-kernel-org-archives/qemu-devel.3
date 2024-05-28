Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1E8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBr49-00032f-Uv; Tue, 28 May 2024 03:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBr3w-0002xw-1t; Tue, 28 May 2024 03:16:00 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBr3g-0007IP-3g; Tue, 28 May 2024 03:15:59 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VpP1N23CSz4x2d;
 Tue, 28 May 2024 17:15:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpP1K06KJz4x1T;
 Tue, 28 May 2024 17:15:32 +1000 (AEST)
Message-ID: <968da156-8621-4509-a0b2-726411e71b5e@kaod.org>
Date: Tue, 28 May 2024 09:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] ppc/pnv: Update skiboot.lid to support Power11
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-12-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240528070515.117160-12-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=HxTW=M7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 5/28/24 09:05, Aditya Gupta wrote:
> Skiboot/OPAL patches are in discussion upstream [1], with corresponding
> commits in github repository [2].
> 
> Update skiboot.lid, with binary built from 'upstream_power11' branch
> of skiboot repository with Power11 enablement patches [2].
> 
> ---
> This patch can be skipped for now, if need to wait for patches to be
> merged in open-power/skiboot. Have updated the skiboot.lid to aid in
> testing this patch series.

When is the merge in skiboot planned ? QEMU 9.1 freeze is in ~2 months.
> [1]:https://lists.ozlabs.org/pipermail/skiboot/2024-April/018963.html
> [2]:https://github.com/maheshsal/skiboot.
> 
> Cc: Cédric Le Goater<clg@kaod.org>
> Cc: Joel Stanley<joel@jms.id.au>
> Cc: Mahesh J Salgaonkar<mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan<maddy@linux.ibm.com>
> Cc: Nicholas Piggin<npiggin@gmail.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   pc-bios/skiboot.lid | Bin 2527328 -> 2527328 bytes

Please don't resend. This is big !

Thanks,

C.





