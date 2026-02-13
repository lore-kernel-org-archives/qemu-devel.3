Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CD3EEA870
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqgjh-0002z6-DD; Thu, 12 Feb 2026 19:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vqgjf-0002yh-Dw
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:08:39 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1vqgjf-0000qK-06; Thu, 12 Feb 2026 19:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=h3t1Eg6m4CNnE3QdS3RpPjB7Os+umo7BhNuhtNp4C/Y=; b=B776le3Qkm8InDadODmp
 i+857TNuly8qHe18kRoT3mq6g408X2nTeG68JlJcuTeeHdxa4GaitcOS8o6tNBxnUlSaob/tBHuFW
 2+Ry117RxhKyt3PjqvXowQty5H4L9ooypEaXNOZphFWLZrn3s1mVaZPFf6q7PF6VBr7+9oXLsp5ou
 4sSklc4iiIieHF6bwdG62BPcTCNH7g63TF2qWe+4p940LZ3fH/rCC9JYgHFs9FNlVpPa/jpVWG0La
 s90+IaeYSRqXsvRa58On+iTWYiw4+/V3lE5qplDngHyKBfUlsUQEO6tXF8X4NqcPJdhs0VvTp051I
 /s0la4UjhtKQTg==;
Date: Fri, 13 Feb 2026 01:08:33 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] baum: Add copy/paste bindings
Message-ID: <aY5rgfbOQvtc5ECm@end>
References: <20260211204445.4124071-1-samuel.thibault@ens-lyon.org>
 <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKZUz6QDDYj9g2NeyKimOrcXDN-ZYG12CYg2pJn9s4Hjw@mail.gmail.com>
Organization: I am not organized
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

Marc-André Lureau, le jeu. 12 févr. 2026 13:43:01 +0400, a ecrit:
> On Wed, Feb 11, 2026 at 9:46 PM Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> 
> Can you write a summary of how this work,

I have added comments.

> where the protocol is documented.

Braille protocols are essentially never documented publicly. All that is
publicly available. is from the free brltty driver implementation

> Also higher-level doc for changelog would be nice.

I'm not sure what more would be useful: it's mere addition key binding.

> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
> >  chardev/baum.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > +            case BRLAPI_KEY_CMD_CLIP_NEW:
> > +                baum_send_key(baum, BAUM_RSP_TopKeys, BAUM_TL1);
> > +                baum_send_key(baum, BAUM_RSP_RoutingKey, (code & BRLAPI_KEY_CMD_ARG_MASK)+1);
> > +                baum_send_key(baum, BAUM_RSP_RoutingKey, 0);
> > +                baum_send_key(baum, BAUM_RSP_TopKeys, 0);
> > +                break;
> > --
> 
> Those commands date back from brltty 4.4 (June 7, 2012). I suggest we
> add a version check to the brlapi dependency.

That is so old that I didn't even remember that they had changed.

Samuel

