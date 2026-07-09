Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A1EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 20:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whvTG-0004SX-Ll; Thu, 09 Jul 2026 16:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whvTC-0004S8-0T; Thu, 09 Jul 2026 16:35:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whvT9-0005Qk-RF; Thu, 09 Jul 2026 16:35:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F56A596748;
 Thu, 09 Jul 2026 22:35:35 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BsFlNXldQYne; Thu,  9 Jul 2026 22:35:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB67F59673B; Thu, 09 Jul 2026 22:35:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9ABD596746;
 Thu, 09 Jul 2026 22:35:32 +0200 (CEST)
Date: Thu, 9 Jul 2026 22:35:32 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 0/3] hw/display/sm501: Fix various error-checks
In-Reply-To: <20260707150933.1410507-1-peter.maydell@linaro.org>
Message-ID: <dd2048ff-9521-7f3d-313d-be2b2ff9c278@eik.bme.hu>
References: <20260707150933.1410507-1-peter.maydell@linaro.org>
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

On Tue, 7 Jul 2026, Peter Maydell wrote:
> This set of patches fixes three bugs discovered recently in the sm501
> device. They're all of the form "guest can misprogram registers in a
> way that defeats the bounds-checks on the 2D graphics ops".
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>  hw/display/sm501: Catch bad coordinates for RTL operations
>  hw/display/sm501: Avoid overflow problems in bounds check calculations
>  hw/display/sm501: Don't allow guest to set ram size larger than it is
>
> hw/display/sm501.c | 64 +++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 55 insertions(+), 9 deletions(-)

Thank you for fixing these.

Series:
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

I think patch 2 should have:
"Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3584" instead 
of work_items/3920.

Regards,
BALATON Zoltan

