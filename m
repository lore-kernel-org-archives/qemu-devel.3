Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACF5CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 08:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwGMB-0006Vq-Po; Wed, 10 Sep 2025 04:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uwGM7-0006PO-Ff
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uwGLx-0000qC-QK
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757493529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=44Kuf1Qp//sWlQLf7sSb6W6inao8YvX2reWSjVbvvJw=;
 b=GG9RNDAtBhgDTJQhbK2mKgSCxIbAzu8+2dxfJUd8sIEZL9ORcf/sij5ko2+cA3z2Etrayy
 21/QqYsVWFBUkGR50BYe0NaCfVXaqN3QS4ix1l84Ho3L0J4zRdj4qvAA5fHqQs2IUHWHJ8
 dy9E1xe9sCSCGZnQ2dZjQPTXttV1CT0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-Coe7VGCUN9OOTIq3ByRWDQ-1; Wed,
 10 Sep 2025 04:38:47 -0400
X-MC-Unique: Coe7VGCUN9OOTIq3ByRWDQ-1
X-Mimecast-MFC-AGG-ID: Coe7VGCUN9OOTIq3ByRWDQ_1757493526
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A4819560AE; Wed, 10 Sep 2025 08:38:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D047A300018D; Wed, 10 Sep 2025 08:38:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8E6BB18000A7; Wed, 10 Sep 2025 10:38:43 +0200 (CEST)
Date: Wed, 10 Sep 2025 10:38:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nir Lichtman <nir@lichtman.org>, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] docs/system/keys: fix incorrect reset scaling key binding
Message-ID: <o4nzr4rw7hfo4nksowiy5nnfjkwfszx4dwcn6mo5oxcu5hilwq@tkfasphulhsc>
References: <20250815090025.GA1464436@lichtman.org>
 <e7dcf4c0-e3c5-4a0f-8d23-a7786dac21fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7dcf4c0-e3c5-4a0f-8d23-a7786dac21fd@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 09, 2025 at 11:15:54AM +0200, Thomas Huth wrote:
> On 15/08/2025 11.00, Nir Lichtman wrote:
> > Fix incorrect key binding for resetting the graphical frontends scaling
> > 
> > Signed-off-by: Nir Lichtman <nir@lichtman.org>
> > ---
> >   docs/system/keys.rst.inc | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
> > index c28ae1a..3b5307b 100644
> > --- a/docs/system/keys.rst.inc
> > +++ b/docs/system/keys.rst.inc
> > @@ -21,7 +21,7 @@ while ``-display sdl,grab-mod=rctrl`` changes it to the right :kbd:`Ctrl` key.
> >     * - :kbd:`Ctrl+Alt+-`
> >       - Shrink the screen
> > -  * - :kbd:`Ctrl+Alt+u`
> > +  * - :kbd:`Ctrl+Alt+0`
> >       - Restore the screen's un-scaled dimensions
> 
>  Hi,
> 
> this unfortunately seems to depend on the graphical front-end: For "-display
> gtk", it's ctrl-alt-0 indeed, but for "-display sdl", it's ctrl-alt-u
> instead.
> 
> Should we unify them? If so, which is the better key combination?

Established convention in various apps is '+' for zoom in, '-' for zoom
out, and '0' for reset to 100% (each combined with the hotkey
modifier(s)).  So when changing hotkeys we should follow that I think,
i.e. switch SDL to Ctrl+Alt+0.

my two cents,
  Gerd


