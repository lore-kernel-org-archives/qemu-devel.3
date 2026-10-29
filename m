Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB5C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EhPtDO9b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ29-0002UX-Ew; Thu, 29 Oct 2026 09:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMQ01-0004Ri-20
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMPzz-00074M-Cz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iF2acr2XCPFhiRm2p72BS+PA0dwnIRRtSJss9H5gO6c=;
 b=EhPtDO9bkSrWVHubXUMfejCJ9XJBlrmQCQ46wobUHgRlnyjWW3UdAxnt4s0WoiGYpfl3rp
 oNyzTWVTmQOEdOAsZRs5g6SA+JKcSwkbUVa4szHD2+UzyMWZyJk/Una4Xq+lhlu9ubA/EY
 vprL20I/gr9QE6ktMbW+E/qnyHBoyuQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-_Hy7e_t1OA69AVItNOojVQ-1; Thu,
 29 Oct 2026 09:16:45 -0400
X-MC-Unique: _Hy7e_t1OA69AVItNOojVQ-1
X-Mimecast-MFC-AGG-ID: _Hy7e_t1OA69AVItNOojVQ_1793279804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A238180034E; Thu, 29 Oct 2026 13:16:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.61])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCEB3180029C; Thu, 29 Oct 2026 13:16:41 +0000 (UTC)
Date: Thu, 29 Oct 2026 14:16:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] virtio-blk: Represent truncated serial in qdev
 property
Message-ID: <auNHNuU8fPCvL3yu@redhat.com>
References: <20261028232400.222535-1-kwolf@redhat.com>
 <20261028232400.222535-5-kwolf@redhat.com>
 <20261029125103.GC1506267@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029125103.GC1506267@shajnocz.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 29.10.2026 um 13:51 hat Stefan Hajnoczi geschrieben:
> On Thu, Oct 29, 2026 at 12:23:59AM +0100, Kevin Wolf wrote:
> > If the guest can only see the first 20 characters of the serial, we
> > shouldn't pretend to have a longer string in the 'serial' qdev property
> > (which is visible through things like QOM or 'info qtree').
> > 
> > Truncate the serial already in the internal state of the device to make
> > sure we don't mix both versions anywhere.
> 
> This is a user-visible change that can break software relying on QEMU's
> serial string output. For example, imagine QEMU is launched with a
> serial string that is the UUID 22382676-e635-4dca-a1db-0eaf2e2e192a.
> Later on, a script fetches the serial from QEMU monitor output and uses
> it as the volume identifier in a distributed storage system (e.g. to
> fetch volume statistics for the guest's disk). That script will now
> break because QEMU no longer retains the full string.

Do we know of any such management tools, or is the concern just out of an
abundance of caution?

It sounds fundamentally wrong to me to use the serial as opposed to the
qdev id to identify devices.

> Let's hold off on this change until the deprecation grace period
> finishes.

I can drop the patch for a v2 of this series (or just apply it without
this patch if no other changes are necessary) as the value of the qdev
property should be the only real effect at the moment.

However, with the work that actually enables longer serials, having an
internal state that doesn't match what the guest sees feels rather error
prone. So I'd be happy to defer the change of the serial in the internal
state to the 12.0 cycle, but probably not until after the deprecation
period.

Kevin

> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/block/virtio-blk.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index eeeb405127c..cecd08a2f2e 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1850,9 +1850,15 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
> >      }
> >  
> >      if (conf->serial && strlen(conf->serial) > VIRTIO_BLK_ID_BYTES) {
> > +        char *truncated;
> > +
> >          warn_report("serial is longer than %d characters and will be truncated "
> >                      "for the guest. This configuration is deprecated.",
> >                      VIRTIO_BLK_ID_BYTES);
> > +
> > +        truncated = g_strndup(conf->serial, VIRTIO_BLK_ID_BYTES);
> > +        g_free(conf->serial);
> > +        conf->serial = truncated;
> >      }
> >  
> >      if (!blkconf_apply_backend_options(&conf->conf,
> > -- 
> > 2.56.0
> > 
> 


