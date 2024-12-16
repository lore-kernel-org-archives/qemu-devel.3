Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D857E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8V5-0002Db-Ri; Mon, 16 Dec 2024 05:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tN8Uw-0002D7-Pt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tN8Uq-0003ns-Ft
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734345513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfEjOUN1qr5EIEJMPucLNCDqx+hQvwKDNLpOppyBpII=;
 b=fqZmDnL23Y5QRn0Dh9aH709Y3wq39oFrES1Nxl2iQSqt/IdOVxhwSZlQ4b8BmG0DLkfTrq
 m5ZR+BNVbamNH5kcu/L6uT8jdiaZwXEgd4xUyif+9P/gifI1Ha2XVT0ljku/ljK/x5E/UN
 IsBVDA6TyBawmEM+UT1vZGpcOoo56WM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-A3veRcQFOOWTECYIbu-xGA-1; Mon,
 16 Dec 2024 05:38:28 -0500
X-MC-Unique: A3veRcQFOOWTECYIbu-xGA-1
X-Mimecast-MFC-AGG-ID: A3veRcQFOOWTECYIbu-xGA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BBE81956048; Mon, 16 Dec 2024 10:38:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 195EF3000197; Mon, 16 Dec 2024 10:38:24 +0000 (UTC)
Date: Mon, 16 Dec 2024 10:38:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 34/34] next-cube: replace boiler-plate GPL 2.0 or
 later license text with SPDX identifier
Message-ID: <Z2ADHbndSn-vrYsK@redhat.com>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-35-mark.cave-ayland@ilande.co.uk>
 <Z1sdIURVdJL8p6cC@redhat.com>
 <fa8ce465-e539-48ec-abf8-d7296ae42b8a@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa8ce465-e539-48ec-abf8-d7296ae42b8a@ilande.co.uk>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Dec 14, 2024 at 08:38:06PM +0000, Mark Cave-Ayland wrote:
> On 12/12/2024 17:28, Daniel P. Berrangé wrote:
> 
> > On Thu, Dec 12, 2024 at 11:46:20AM +0000, Mark Cave-Ayland wrote:
> > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > ---
> > >   hw/m68k/next-cube.c | 5 +----
> > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> > > index 1e96bb02f8..3c2f3e295c 100644
> > > --- a/hw/m68k/next-cube.c
> > > +++ b/hw/m68k/next-cube.c
> > > @@ -4,10 +4,7 @@
> > >    * Copyright (c) 2011 Bryce Lanham
> > >    * Copyright (c) 2024 Mark Cave-Ayland
> > >    *
> > > - * This code is free software; you can redistribute it and/or modify
> > > - * it under the terms of the GNU General Public License as published
> > > - * by the Free Software Foundation; either version 2 of the License,
> > > - * or (at your option) any later version.
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > >    */
> > 
> > While adding a SPDX-License-Identifier alongside existing header text
> > is acceptable, my view is that we should stay away from removing existing
> > license headers. There are some difficult questions wrt interpretation
> > of the GPL in this area & avoiding opening that can of worms would be
> > nice.
> 
> I remember you mentioned this before, but I wasn't sure if this would be
> mitigated by the fact that the code originated from GSoC? I'm sure I've seen
> at least one recent patch that made a similar change, but if there really
> are legal reasons not to allow changes of this type then I shall drop it
> from the series.

GSoC isn't really important. The challenging problem here is GPL clause 1
which says

  "keep intact all the notices that refer to this License and to the
   absence of any warranty"

there are differing opinions on how strictly to interpret the "keep intact"
language there.

While we could have a debate over this and come to some project opinion
IMHO it is a better use of our time to just not remove existing notices.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


