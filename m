Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F6BC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 18:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3gyk-0002xY-Fl; Sun, 05 May 2024 14:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s3gyi-0002xG-Ji
 for qemu-devel@nongnu.org; Sun, 05 May 2024 14:52:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s3gyg-0006w0-DG
 for qemu-devel@nongnu.org; Sun, 05 May 2024 14:52:52 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A5A44E6031;
 Sun, 05 May 2024 20:52:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Y5gDt24dzGgd; Sun,  5 May 2024 20:52:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9E5104E601D; Sun, 05 May 2024 20:52:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C73B746E3B;
 Sun, 05 May 2024 20:52:45 +0200 (CEST)
Date: Sun, 5 May 2024 20:52:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
cc: peter.maydell@linaro.org, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 6/7] target/ppc: Remove unused struct 'mmu_ctx_hash32'
In-Reply-To: <20240505171444.333302-7-dave@treblig.org>
Message-ID: <c9c5eebe-7f72-ddf4-5192-d504ac964396@eik.bme.hu>
References: <20240505171444.333302-1-dave@treblig.org>
 <20240505171444.333302-7-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 5 May 2024, Dr. David Alan Gilbert wrote:
> I think it's use was removed by
> Commit 5883d8b296 ("mmu-hash*: Don't use full ppc_hash{32,
> 64}_translate() path for get_phys_page_debug()")
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> target/ppc/mmu-hash32.c | 6 ------
> 1 file changed, 6 deletions(-)
>
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 3976416840..746321329c 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -36,12 +36,6 @@
> #  define LOG_BATS(...) do { } while (0)
> #endif
>
> -struct mmu_ctx_hash32 {
> -    hwaddr raddr;      /* Real address              */
> -    int prot;                      /* Protection bits           */
> -    int key;                       /* Access key                */
> -};
> -
> static int ppc_hash32_pp_prot(int key, int pp, int nx)
> {
>     int prot;
>

