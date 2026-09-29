Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53266CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcKN-0003Hu-Hg; Tue, 29 Sep 2026 14:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1xBcKE-0003BB-KU; Tue, 29 Sep 2026 14:13:12 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1xBcKC-0007bs-OT; Tue, 29 Sep 2026 14:13:10 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 0CD00C6030C;
 Tue, 29 Sep 2026 20:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1790705583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6cuTLJ981lTqoOSboKrJQviLkJB2AGmXyIKcgt+6+4=;
 b=i6lr8Zb/b64Gq/IrnDXpXXOaihO3KNeP4p2Bq9/wGP3UGBiwo6S1NOBZumxGRxZl6Z31j8
 Ny3Jb+wM4zPPjfx3ndcXXaevXQ+HdfW/LwF7sgmrMuFi9//OaBtaBU2ebXJ+vmdVRhKPMc
 cM/6l1pYWJLcExqq/I3HnrsPlhKiXYIXmFSffdMCuoISL50AnpDUwW18Nqa8xZeplgJu/q
 uQE4viRz1EaMaOgytk1h9uxwMvbW65D3kuCyyIg/wZmqeN/4zR+QT2d1mogZgHUmhCbqDk
 EwN7Tp764bsKJ8NI2yLskr5xBqPWAkHzzUDHIoLTQydfnBhy3l4xXcRT760Tug==
Date: Tue, 29 Sep 2026 20:13:02 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Jonathan Gilbert <logic@deltaq.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: correct register index in test
 for mux update
Message-ID: <arv_rhMRpl_wk7tO@michell-laptop.localdomain>
References: <20260925100726.1546566-1-logic@deltaq.org>
 <507fb835-61a8-4e66-80f4-1ae6f07a5bf1@oss.qualcomm.com>
 <52c613fd-41ca-45c0-9d74-faccb58c11cc@oss.qualcomm.com>
 <30fa3419-f6a6-402b-a1e0-b009196e9197@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30fa3419-f6a6-402b-a1e0-b009196e9197@oss.qualcomm.com>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 09:28 Sun 27 Sep     , Philippe Mathieu-Daudé wrote:
> On 26/9/26 11:42, Philippe Mathieu-DaudÃ© wrote:
> > On 26/9/26 11:30, Philippe Mathieu-DaudÃ© wrote:
> > > Cc'ing Luc
> > > 
> > > On 25/9/26 12:07, Jonathan Gilbert wrote:
> > > > After each register write handled by cprman_write, function update_mux
> > > > checks each of the clocks to see whether the supplied register index
> > > > applies to it, calling clock_mux_update if so. Each clock has two
> > > > registers, so it needs to check the base cm_offset for CM_CTL and then
> > > > the next slot for CM_DIV. But, it was checking for cm_offset plus 4, as
> > > > though it were a byte offset when it's a logical index.
> > > > 
> > 
> > Fixes: 7281362484a ("hw/misc/bcm2835_cprman: clock mux skeleton
> > implementation")
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > 
> > > > Signed-off-by: Jonathan Gilbert <logic@deltaq.org>
> > > > ---
> > > >   hw/misc/bcm2835_cprman.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Trivial fix so patch queued, thanks.

Thanks for the fix.
A bit late:

Reviewed-by: Luc Michel <luc@lmichel.fr>

