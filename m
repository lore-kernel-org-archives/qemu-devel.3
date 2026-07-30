Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEA6C5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpVqx-0007i9-U9; Thu, 30 Jul 2026 14:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wpVqw-0007hz-7C
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 14:51:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1wpVqs-0004yx-Sp
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 14:51:33 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2DA36600C8;
 Thu, 30 Jul 2026 18:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727E81F000E9;
 Thu, 30 Jul 2026 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785437476;
 bh=uL+g8TRymdN2Qu+FrAA+vKroadVYYM5U1shEwR476nI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References;
 b=btgR0Rl3NCK3Kit+FfK+VzoHISmjvjDhfCQRccYYVXMmKq/Gk+hFg2lZl0yD4WYHs
 pkkkn/Yelp4NmSXlTLDLfQkSDrazXYCdwnm63ig0jB1zEUjC+Prk9ldNq0OH2aHNSo
 kQ5/pb14eZB9w8fIgRpB939joihhlZo2d5D1vVUAClU7T3iL7twfc67Q8xpEcXxJ9U
 novMvPNfT7tHMwAMk6tl5v8w/tXQApOB3YWg0MNjsr96OJ62C2+r7Th4kyuFbjPuUh
 FVc3cTA1xmC7O56aV0eA466r/wA0xlwMoj+4g4G6V+MS71lRclE/GfQPMdxCwQ00Lg
 tnckZS1rDsYJQ==
Date: Thu, 30 Jul 2026 11:51:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
cc: Dario Faggioli <dfaggioli@suse.com>, qemu-devel@nongnu.org, 
 philmd@linaro.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org, 
 anthony@xenproject.org, paul@xen.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw/i386/pc: xen: reinstate the "xenfv" machine alias
In-Reply-To: <amt7j5SAZo07O7xB@redhat.com>
Message-ID: <642c70db-8b59-fbc7-92a2-f27bb56c1206@kernel.org>
References: <20260730162238.3308286-1-dfaggioli@suse.com>
 <amt7j5SAZo07O7xB@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-600655182-1785437475=:513563"
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=sstabellini@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-600655182-1785437475=:513563
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Jul 2026, Daniel P. Berrangé wrote:
> On Thu, Jul 30, 2026 at 06:22:38PM +0200, Dario Faggioli wrote:
> > Commit 7d2778dea32a4924a469f1cc5767042c8f5b4eea ("hw/i386/pc:
> > Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines") removed
> > the Xen machine type that was providing the "xenfv" alias. As a
> > consequence, since the tools are apparently relying on such alias,
> > we're getting this, as soon as one tries to start a Xen (HVM) VM:
> > 
> >   qemu-system-i386: unsupported machine type: "xenfv"
> >   Use -machine help to list supported machines
> > 
> > Reinstate the alias and let it point to the only Xen machine we
> > still have.
> > 
> > Fixes: 7d2778dea3 hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
> > Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> > ---
> >  hw/i386/pc_piix.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
--8323329-600655182-1785437475=:513563--

