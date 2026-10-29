Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AD606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/ljyJxs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQg3-0004Dv-Hs; Thu, 29 Oct 2026 10:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMQg1-0004DU-Kj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMQfz-0003oK-CJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793282418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sc9KNBy3vrfP49X3u6HkvxLCRuEAwmuBxyAVNdRVoi4=;
 b=R/ljyJxsFN4wtf5qUU49zrrkj1vx/5zt+ApAC5x2wahDtCk04+wN/+EK/MS56cXowtz6Tg
 Vu7/zxAu1lImZN3jHXpbxGMfds6wuesN2wPp0hNHp3niTQJBqK3Cwzl7YPAdukGCaMAs8O
 t0ConhsMKetnCRQ3F8RQxWK2upH9NHE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-_GAh1KttPn6Ia6QW3MfmgA-1; Thu,
 29 Oct 2026 10:00:16 -0400
X-MC-Unique: _GAh1KttPn6Ia6QW3MfmgA-1
X-Mimecast-MFC-AGG-ID: _GAh1KttPn6Ia6QW3MfmgA_1793282415
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 173D419541A0; Thu, 29 Oct 2026 14:00:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B3B21955F10; Thu, 29 Oct 2026 14:00:14 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:00:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] virtio-blk-test: Test truncated serial
Message-ID: <20261029140013.GH1506267@shajnocz.csb>
References: <20261028232400.222535-1-kwolf@redhat.com>
 <20261028232400.222535-6-kwolf@redhat.com>
 <20261029124249.GB1506267@shajnocz.csb>
 <auNH-taj7VUUbvfP@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNH-taj7VUUbvfP@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 29, 2026 at 02:19:54PM +0100, Kevin Wolf wrote:
> Am 29.10.2026 um 13:42 hat Stefan Hajnoczi geschrieben:
> > On Thu, Oct 29, 2026 at 12:24:00AM +0100, Kevin Wolf wrote:
> > > Only 20 bytes are written to the passed buffer and the returned string
> > > doesn't have a NUL terminator.
> > > 
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  tests/qtest/virtio-blk-test.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
> > > index 14fadcb4009..99d785d9e1a 100644
> > > --- a/tests/qtest/virtio-blk-test.c
> > > +++ b/tests/qtest/virtio-blk-test.c
> > > @@ -835,6 +835,25 @@ static void get_id_serial_short(void *obj, void *data, QGuestAllocator *t_alloc)
> > >      qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
> > >  }
> > >  
> > > +static void get_id_serial_short_trunc(void *obj, void *data,
> > > +                                      QGuestAllocator *t_alloc)
> > > +{
> > > +    QVirtioBlk *blk_if = obj;
> > > +    QVirtioDevice *dev = blk_if->vdev;
> > > +    QVirtQueue *vq;
> > > +    uint8_t status;
> > > +    /* Everything after the 20 character maximum is untouched, no '\0' */
> > > +    const char expected[25] = "01234567890123456789\xa5\xa5\xa5\xa5\xa5";
> > 
> > get_id_request() also uses the 0xa5 byte pattern. How about using a
> > different pattern like 0x5a here to distinguish the two?
> 
> This string is used to verify that the 0xa5 pattern set by
> get_id_request() is still unchanged after the request, so the whole
> point is that it is the same.

Ah, I see now. How about passing in a pattern_byte argument into
get_id_request() so that the connection is explicit?

Stefan


