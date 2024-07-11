Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3CDC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 08:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpGq-0008Kn-Jy; Thu, 11 Jul 2024 04:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sRpGo-00085S-Jh
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:35:18 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sRpGl-0003xB-Vg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 04:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=wmc/1hpArw+l14/wJ4xRAxipDGkDMQF8rNiWMXcGRZo=; b=wwiBEtWtX7p2HSJZ+tsd03v3y9
 Di4cu7AJGr1OFEHgLpFACZWwzVCKasb+Dzuegf0L47sgkN09Qg2OskFJgkK2Jhjw5rrmRIKodnOWn
 +cdfs7MLqJgJJGuIZKbEaMrhigTE567qc77SzmgQFd/7Lg/4abVAsgRGxxt3DS9i3iho=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sRpGf-0004MC-Fz; Thu, 11 Jul 2024 08:35:09 +0000
Received: from lfbn-lyo-1-451-148.w2-7.abo.wanadoo.fr ([2.7.43.148] helo=l14)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sRpGf-0002SB-5I; Thu, 11 Jul 2024 08:35:09 +0000
Date: Thu, 11 Jul 2024 10:35:06 +0200
From: Anthony PERARD <anthony@xenproject.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, paul@xen.org, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, stefanha@redhat.com
Subject: Re: [PATCH] MAINTAINERS: add Edgar as Xen maintainer
Message-ID: <Zo+ZOi15fQPUvsW4@l14>
References: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 10, 2024 at 01:28:52PM -0700, Stefano Stabellini wrote:
> Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
> maintainer for years, and has already made key changes to one of the
> most difficult areas of the Xen subsystem (the mapcache).
> 
> Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
> are very happy to welcome him to the team. His knowledge and expertise
> with QEMU internals will be of great help.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6725913c8b..63e11095a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -536,6 +536,7 @@ X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony PERARD <anthony@xenproject.org>
>  M: Paul Durrant <paul@xen.org>
> +M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: */xen*

Acked-by: Anthony PERARD <anthony@xenproject.org>

Welcome!
Cheers,

-- 
Anthony PERARD

