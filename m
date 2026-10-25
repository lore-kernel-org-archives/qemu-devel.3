Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9F606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=t+uaLvGL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKr1g-0003JP-1Z; Sun, 25 Oct 2026 01:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xKr1M-0003IV-Jq; Sun, 25 Oct 2026 01:43:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xKr1J-0003VD-Ll; Sun, 25 Oct 2026 01:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792907024; bh=wt11AU4UZ2s7uWGGXcNO+H/yVETe2lfqBmM4XWIRYqY=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=t+uaLvGLh9w3vxCSw3GGvJ9BYo9KbUPBtVYpJvQPb5oaDxmCFzxaXgyFLO8UPqdt+
 7+vZ/xj9uyOe8G44OhcVZgFcdXyUsNopr2LVxTqPGvjK9jNbTdcCkt+yWodiUJO0dS
 dqUjAW3RNEcQa/N7uI5sro6TQTQmXvAJc1lP/b9s5zlvtBfJaOaQLQ0iz+LsZ9CTic
 TRFx1RgSzEEf/6SrYIJdFLYDGiwkgSjyk2bYA0KQbBuMqIZl5y+VkZ/pAtFBa9Lu8S
 4yRukDqxXVA2R6YLphD8Rf1z1+dSivHKBlRwb2XAQNpg6uDboVb/cCJFUHWkLd45vB
 z1Z3V1hbNHE5Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A5A61E0CBB;
 Sun, 25 Oct 2026 08:43:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1261244ABE9;
 Sun, 25 Oct 2026 08:43:44 +0300 (MSK)
Message-ID: <25d0ce95-e964-496a-a3bf-2c5f9fa1b78a@tls.msk.ru>
Date: Sun, 25 Oct 2026 08:43:44 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/intc/exynos4210_combiner: Fix group register range
 check
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
 <20261019162217.3272337-2-peter.maydell@linaro.org>
Content-Language: en-US, ru-RU
Cc: QEMU Stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261019162217.3272337-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 19:22, Peter Maydell wrote:
> The exynos4210 combiner has registers arranged in sets of 4:
>   offset 0x0: IIESR0 (handles interrupt groups 0..3)
>   offset 0x4: IIECR0
>   offset 0x8: IISTR0
>   offset 0xc: IIMSR0
>   offset 0x10: IIESR1 (handles interrupt groups 4..7)
>   offset 0x14: IIECR1
> 
> and so on for a total of 16 sets of registers, which puts the final
> IIMSR15 at offset 0xfc.  After that come two registers which aren't
> grouped, ICIPSR0 at 0x100 and ICIPSR1 at 0x104.  The entire register
> memory region is thus 0x108 bytes.
> 
> The logic which separates out the "offset is in one of the sets of
> registers" from "offset is one of the ICIPSRn registers" is
> incorrect, and so a write to offset 0x10448100 (which should be
> ICIPSR0) falls through into the code for handling accesses to a set
> of registers, and indexes off the end of the s->group[] array.
> 
> For an input offset of, say, 0x3C, req_quad_base_n is 0x3, because
> this is in the 3rd set of registers.  grp_quad_base_n is then 0xC,
> because this set of registers handles interrupt groups 12..15, and we
> will index s->group[] with grp_quad_base_n through to grp_quad_base_n
> + 3.  IIC_NGRP is the size of the group[] array, and so we need to
> check grp_quad_base_n against it, not req_quad_base_n.
> 
> Fix the bounds check, and add an assertion that the code path
> where we are beyond the register-set range isn't going to
> overrun its array, which we know to be true because of the
> size used for the MemoryRegion.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 8e03cf1eeb1f9e0 ("ARM: exynos4210: IRQ subsystem support.")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4709
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/exynos4210_combiner.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

(This is now commit ab6579bf73b in the master branch).

Hi Peter!

This change has been Cc'ed qemu-stable.  For 10.0.x series,
I'm also picking up a previous commit,

  b6d36a1af79 hw/intc/exynos4210_combiner: Avoid hw_error for guest error

instead of adjusting this change.  Please let me know if I shouldn't :)

Overall, it feels like this a niche device, and it's unlikely anyone
actually cares for the stable series -- actual users of this device
in qemu most likely have their own local builds of qemu anyway.  But
sure thing I might be wrong.

Thanks!

/mjt

