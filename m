Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69719C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MiY-0005SZ-Qf; Fri, 26 Apr 2024 10:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0MiW-0005SF-NA; Fri, 26 Apr 2024 10:38:24 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0MiU-0005je-Ox; Fri, 26 Apr 2024 10:38:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VQwLy3HRmz4xM5;
 Sat, 27 Apr 2024 00:38:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQwLv3kd8z4wb0;
 Sat, 27 Apr 2024 00:38:15 +1000 (AEST)
Message-ID: <d6850e42-acbc-42fc-a27b-87c10736dd95@kaod.org>
Date: Fri, 26 Apr 2024 16:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] ppc/pnv: Update skiboot.lid to support Power11
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-11-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240426110023.733309-11-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=oYEp=L7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/26/24 13:00, Aditya Gupta wrote:
> Skiboot/OPAL patches are in discussion upstream [1], with corresponding
> commits in github repository [2].
> 
> Update skiboot.lid, with binary built from 'upstream_power11' branch
> of skiboot repository with Power11 enablement patches [2].
> 
> ---
> This patch can be skipped for now, if need to wait for patches to be
> merged in open-power/skiboot. 

yes.

> Have updated the skiboot.lid to aid in testing this patch series.

Thanks for doing so.

> ---
> 
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
>   1 file changed, 0 insertions(+), 0 deletions(-)

We avoid sending such big blobs on the mailing list. We usually send a
PR to the sub-system maintainer (Nick). When time comes (support is
merged is skiboot), we will address the skiboot image update in QEMU.

C.


