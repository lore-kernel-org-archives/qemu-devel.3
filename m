Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE4606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RRYSrKQ4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJVLR-0004nX-QJ; Wed, 21 Oct 2026 08:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xJVLM-0004md-7k
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xJVLK-0007cM-Sd
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792585374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=votn0xs9lDoKFD5AKUhtMGZQxwYpeb+wNdTqQjrS82E=;
 b=RRYSrKQ4+YScIDkMgYCQtLtXPrW6TcRJaaJ52L8P11JAQupT1Ssu0lZgAiYpSdcAF9wgi4
 GTkYFSBfUt9X/6kPA6k7hGhGBiW34kUDjNDmibWde5vqgiK7SJp4X5I5cvFoYjKKkzsRYt
 vQnK7x6oQrqT8nMR3yyhxhflIFTfkbY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-gp2RLFr2MfSxd2kOHCZCzQ-1; Wed,
 21 Oct 2026 08:22:49 -0400
X-MC-Unique: gp2RLFr2MfSxd2kOHCZCzQ-1
X-Mimecast-MFC-AGG-ID: gp2RLFr2MfSxd2kOHCZCzQ_1792585368
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EEEA1955EAB; Wed, 21 Oct 2026 12:22:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.135])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E967418; Wed, 21 Oct 2026 12:22:44 +0000 (UTC)
Date: Wed, 21 Oct 2026 14:22:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alberto Faria <afaria@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] include: Add virtio-blk request flag FUA definitions
Message-ID: <atiukShvcKuVOuMj@redhat.com>
References: <20261021062257.735757-1-afaria@redhat.com>
 <20261021062257.735757-2-afaria@redhat.com>
 <87v76v32ni.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v76v32ni.fsf@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 21.10.2026 um 09:59 hat Cornelia Huck geschrieben:
> On Wed, Oct 21 2026, Alberto Faria <afaria@redhat.com> wrote:
> 
> > Signed-off-by: Alberto Faria <afaria@redhat.com>
> > ---
> >  include/standard-headers/linux/virtio_blk.h | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Maybe explicitly mark as *placeholder*, so it doesn't get merged
> accidentally?

What is the proper (or at least common) way to do this? Do we really
have to wait for Linux to merge the guest driver side of virtio device
changes before we can add the emulation in QEMU?

Kevin


