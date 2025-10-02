Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8422ECAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4NeI-0002ps-KW; Thu, 02 Oct 2025 14:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1v4NeB-0002p5-RZ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:03:20 -0400
Received: from lichtman.org ([149.28.33.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nir@lichtman.org>) id 1v4Ne5-0003pT-Cf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 14:03:19 -0400
Received: by lichtman.org (Postfix, from userid 1000)
 id CDA9D176F2C; Thu,  2 Oct 2025 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
 t=1759428181; bh=/k0Ue92oACs1Vk04WiJiCwAZwkhafQ+wOuxmjn2pXmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RHV+lfSKZG2a5ZTVAzQ7w9T7+xGnFGcPW+ayrNgdZTRAW9MeyUT6YyCI/DN5cHJh1
 yZGAOm1hGeyAGejmZjIRA0FsAAuqa6c0vgATcHEFHjOk6MngrHQPnN2e5fH0+PoPUB
 XVy0zPKKW4+ueeUGGMqou2N/yOZo86EbfNdEiIpsKe3c2Kef/9RSSQxIw6drhQ67D8
 ULLL+VOBn54P9NMnDZZnEeIcnIpXiZgBBGtEM3O8WQZ+weCMgcS50zCHzusWgHectC
 JvdtdF8nGgZFNgdr4uLLUEln1mtFIwL0+JOpFDMLAFMqsxq54tp+DkCZkNYhqkhxjI
 qPTmZm/dXUqWw==
Date: Thu, 2 Oct 2025 18:03:01 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] docs/system/keys: fix incorrect reset scaling key binding
Message-ID: <20251002180301.GA2059739@lichtman.org>
References: <20250815090025.GA1464436@lichtman.org>
 <e7dcf4c0-e3c5-4a0f-8d23-a7786dac21fd@redhat.com>
 <o4nzr4rw7hfo4nksowiy5nnfjkwfszx4dwcn6mo5oxcu5hilwq@tkfasphulhsc>
 <20250910102351.GA1782682@lichtman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910102351.GA1782682@lichtman.org>
Received-SPF: pass client-ip=149.28.33.109; envelope-from=nir@lichtman.org;
 helo=lichtman.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 10, 2025 at 10:23:52AM +0000, Nir Lichtman wrote:
> On Wed, Sep 10, 2025 at 10:38:43AM +0200, Gerd Hoffmann wrote:
> > On Tue, Sep 09, 2025 at 11:15:54AM +0200, Thomas Huth wrote:
> > > On 15/08/2025 11.00, Nir Lichtman wrote:
> > > > Fix incorrect key binding for resetting the graphical frontends scaling
> > > > 
> > > > Signed-off-by: Nir Lichtman <nir@lichtman.org>
> > > > ---
> > > >   docs/system/keys.rst.inc | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
> > > > index c28ae1a..3b5307b 100644
> > > > --- a/docs/system/keys.rst.inc
> > > > +++ b/docs/system/keys.rst.inc
> > > > @@ -21,7 +21,7 @@ while ``-display sdl,grab-mod=rctrl`` changes it to the right :kbd:`Ctrl` key.
> > > >     * - :kbd:`Ctrl+Alt+-`
> > > >       - Shrink the screen
> > > > -  * - :kbd:`Ctrl+Alt+u`
> > > > +  * - :kbd:`Ctrl+Alt+0`
> > > >       - Restore the screen's un-scaled dimensions
> > > 
> > >  Hi,
> > > 
> > > this unfortunately seems to depend on the graphical front-end: For "-display
> > > gtk", it's ctrl-alt-0 indeed, but for "-display sdl", it's ctrl-alt-u
> > > instead.
> > > 
> > > Should we unify them? If so, which is the better key combination?
> > 
> > Established convention in various apps is '+' for zoom in, '-' for zoom
> > out, and '0' for reset to 100% (each combined with the hotkey
> > modifier(s)).  So when changing hotkeys we should follow that I think,
> > i.e. switch SDL to Ctrl+Alt+0.
> 
> I'll send a patch fixing SDL to use CTRL+ALT+0
> 
> Nir

Hi,

Looks like the SDL patch I sent was merged into main,
reminder regarding this patch which fixes the documentation.

Thanks,
Nir

