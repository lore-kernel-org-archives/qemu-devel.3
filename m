Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EFCCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBux5-0007KS-Bp; Thu, 23 Oct 2025 09:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1vBuwY-0007A8-UJ; Thu, 23 Oct 2025 09:01:39 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1vBuwV-0004yK-OE; Thu, 23 Oct 2025 09:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=mcZQh+kreTywuj0nxQatcCOfo+AYejtqCbV1FXs6+0A=; b=PhbHKESiP4JtKxgv3ZYfUS0MQ6
 MCB2P8pXipw6t2pTEovt7Lr5ebDNGE1ggscH5gg/cm6u8BEwdMkn1h8ksCSuk8hjOqShoqU68RS3h
 /UJWQvNrF/Nzj/be0F6kbIj9CEfBJc/xay9QGcWd8CP8MMcRzqYED25hE1UgoHgNiPxY=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1vBuwD-00FsTM-2Y;
 Thu, 23 Oct 2025 13:01:05 +0000
Received: from [2a01:cb15:80df:da00:94d0:641e:16e6:ca4b] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1vBuwD-00BXxQ-1N;
 Thu, 23 Oct 2025 13:01:05 +0000
Date: Thu, 23 Oct 2025 15:01:03 +0200
From: Anthony PERARD <anthony@xenproject.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/xen: Avoid non-inclusive language in params.h
Message-ID: <aPonD3KTbOMxyIlD@l14>
References: <20251013111152.25807-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013111152.25807-1-thuth@redhat.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 13, 2025 at 01:11:52PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Copy the latest version of Xen's params.h to the QEMU repository:
> 
> https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=0291089f6ea81690f37035a124d54c51fa7ba097#patch8
> 
> With this patch, we get rid of a non-inclusive word in the comment
> there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 
Anthony PERARD

