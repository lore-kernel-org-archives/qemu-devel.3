Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B895606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gsr51noP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQcS-0002m8-EY; Thu, 29 Oct 2026 09:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMQcN-0002kE-VD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMQcL-00039g-PU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793282193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqhzFk9bJ/UhsykXBcbRXkZwsU+u7qws+jm1mXQcEvk=;
 b=Gsr51noPKa0AVCb9UEarjEEwtsEF7hm43k28Wt+aJ7bgEeBbiDS69oGJQVYerpxWwZPAD3
 JWCajRYvOrQfGPKRKhGHEFiKi8U9bsfXOWkFefONu2eApGpUjKqT/niPbqrUH3rQvMw5zd
 26oNT6fGhWB/IJ4dOkV8Ga/SPfSb4rs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-MskpaEtxPSimX_ilogs5NA-1; Thu,
 29 Oct 2026 09:56:29 -0400
X-MC-Unique: MskpaEtxPSimX_ilogs5NA-1
X-Mimecast-MFC-AGG-ID: MskpaEtxPSimX_ilogs5NA_1793282188
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DF77180216B; Thu, 29 Oct 2026 13:56:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 934371955F0A; Thu, 29 Oct 2026 13:56:27 +0000 (UTC)
Date: Thu, 29 Oct 2026 09:56:26 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] virtio-blk: Represent truncated serial in qdev
 property
Message-ID: <20261029135626.GG1506267@shajnocz.csb>
References: <20261028232400.222535-1-kwolf@redhat.com>
 <20261028232400.222535-5-kwolf@redhat.com>
 <20261029125103.GC1506267@shajnocz.csb>
 <auNHNuU8fPCvL3yu@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNHNuU8fPCvL3yu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 02:16:38PM +0100, Kevin Wolf wrote:
> Am 29.10.2026 um 13:51 hat Stefan Hajnoczi geschrieben:
> > On Thu, Oct 29, 2026 at 12:23:59AM +0100, Kevin Wolf wrote:
> > > If the guest can only see the first 20 characters of the serial, we
> > > shouldn't pretend to have a longer string in the 'serial' qdev property
> > > (which is visible through things like QOM or 'info qtree').
> > > 
> > > Truncate the serial already in the internal state of the device to make
> > > sure we don't mix both versions anywhere.
> > 
> > This is a user-visible change that can break software relying on QEMU's
> > serial string output. For example, imagine QEMU is launched with a
> > serial string that is the UUID 22382676-e635-4dca-a1db-0eaf2e2e192a.
> > Later on, a script fetches the serial from QEMU monitor output and uses
> > it as the volume identifier in a distributed storage system (e.g. to
> > fetch volume statistics for the guest's disk). That script will now
> > break because QEMU no longer retains the full string.
> 
> Do we know of any such management tools, or is the concern just out of an
> abundance of caution?
> 
> It sounds fundamentally wrong to me to use the serial as opposed to the
> qdev id to identify devices.

Based on qemu-devel threads (e.g. tracking IOThread holders) it seems
that people write management tools that query QEMU rather than
maintaining their own state. While I don't know of a specific tool that
uses the serial string, it doesn't seem far-fetched that someone might
rely on this.

I don't think we gain enough from changing the monitor output that it's
worth risking breaking existing users.

> > Let's hold off on this change until the deprecation grace period
> > finishes.
> 
> I can drop the patch for a v2 of this series (or just apply it without
> this patch if no other changes are necessary) as the value of the qdev
> property should be the only real effect at the moment.
> 
> However, with the work that actually enables longer serials, having an
> internal state that doesn't match what the guest sees feels rather error
> prone. So I'd be happy to defer the change of the serial in the internal
> state to the 12.0 cycle, but probably not until after the deprecation
> period.

I would still hold off until it is actually time to enforce the length
limit according to the deprecation policy, but I guess there's an
argument that once users can configure long strings, they should stop
abusing the serial property. In any case, lets defer this patch for
11.2.

Stefan


