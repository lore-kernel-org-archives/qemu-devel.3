Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2865CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDibc-0007uE-DK; Tue, 28 Oct 2025 08:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waldi@debian.org>) id 1vDibU-0007mo-Um
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:15:10 -0400
Received: from mail.thinkmo.de ([2a01:4f8:271:3f5c:0:25:1:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waldi@debian.org>) id 1vDibL-000281-LN
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:15:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.thinkmo.de (Postfix) with ESMTP id 4cwq7c3ZHwzyX0;
 Tue, 28 Oct 2025 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received; s=mail202007.waldi.user; t=
 1761653692; bh=owYfPK1kGDHrlSvifWd6dUzrSNikP0EsGQJAzKkQ0ko=; b=G
 h0WQzmV02hDBZB6Cp1YtZZeEgG0iXijcHVa5mk99E9D1snfKd8izRJ49ixo4Hdns
 pLv10E2x5VOh/fDxyPZKA4aSnsYawuXUDxF/jHgUAgm6ljtxcWg+cvw4wGnVZ8WK
 lPXpstkbyiPzRHaOHsoHcR5D3+in7JT8yCZl6gcfta4MfuPKY4y6CaUUgwKEDrtY
 BPaHNuOcKCISYI2UKvdV+5BvTfJzm3KKA0ys1s8SeF0gwlIvpr65VMQXZIQ5dVG3
 UVKIP1nKya90uPlh/rKUF3jS0h6pb1W679hwL4Lhw3eZ6cYoa6vDzeCENgaygYeY
 yo0lKExCvvruNxbxupyDw==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7vttHBFTBFM; Tue, 28 Oct 2025 12:14:52 +0000 (UTC)
Received: from shell.thinkmo.de (shell.thinkmo.de
 [IPv6:2a01:4f8:271:3f5c:0:22:0:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (No client certificate requested)
 by mail.thinkmo.de (Postfix) with ESMTPS id 4cwq7c2dmKzyVH;
 Tue, 28 Oct 2025 12:14:52 +0000 (UTC)
Date: Tue, 28 Oct 2025 13:14:51 +0100
From: Bastian Blank <waldi@debian.org>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] Use correct type for ioctl(FIGETBSZ) emulation
Message-ID: <20251028121451.vkx7ghpg6n46yy2f@shell.thinkmo.de>
Mail-Followup-To: Bastian Blank <waldi@debian.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <s7ingr72rgtvch2poxlwyc25lkxp7hh5c273ubvmz4tdskjttz@7dzfvylkgwsh>
 <94295e11-1127-4eb1-89f1-9fa346cb8d29@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94295e11-1127-4eb1-89f1-9fa346cb8d29@gmx.de>
Received-SPF: none client-ip=2a01:4f8:271:3f5c:0:25:1:1;
 envelope-from=waldi@debian.org; helo=mail.thinkmo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 12:35:35PM +0100, Helge Deller wrote:
> Can you check FIBMAP as well? I think it needs the same patch...

You are right, it does need the same.  However that is now untested from
my side.

Bastian

-- 
We do not colonize.  We conquer.  We rule.  There is no other way for us.
		-- Rojan, "By Any Other Name", stardate 4657.5

