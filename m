Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C15CA600A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEZO1-0002jI-W2; Wed, 07 Oct 2026 17:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEZNu-0002in-8q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEZNr-0001D7-Nl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791409266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hJs5vYKSF96fcUJ3A3dVsbRRCGLnif7+uGiACS3kyo=;
 b=iZRd2v8NNDanf1pHx2rb8WEzF7Ce1HFe+BlHsWJpOmI0cllJs3d4C9E63z/MjkBE+IE9Z7
 RablvmJKmp0JarOMM2r1SzRuDyTYe2ikf3iNC2uGWCqV68BF+6Mcgw2Qo51RBtFlHjZR7p
 7Oukirz4fR2ZfVF2C8hXQzFv72KZeGc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-xWxj5j7FMZmftawToi_VhQ-1; Wed,
 7 Oct 2026 21:41:02 +0000
X-MC-Unique: xWxj5j7FMZmftawToi_VhQ-1
X-Mimecast-MFC-AGG-ID: xWxj5j7FMZmftawToi_VhQ_1791409261
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 076141800652; Wed,  7 Oct 2026 21:41:01 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8650841B; Wed,  7 Oct 2026 21:40:59 +0000 (UTC)
Date: Wed, 7 Oct 2026 16:40:56 -0500
From: Eric Blake <eblake@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v4 0/5] iotests fixes
Message-ID: <asa8Tr8zCTTcFKnN@redhat.com>
References: <20260925194409.716498-1-farman@linux.ibm.com>
 <arbrou8C1yKLZtVe@redhat.com>
 <93bc1b59-5a95-4733-8c6f-7fb38d815b8f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93bc1b59-5a95-4733-8c6f-7fb38d815b8f@linux.ibm.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 07, 2026 at 01:34:43PM -0400, Eric Farman wrote:
> 
> 
> On 9/25/26 5:46 PM, Eric Blake wrote:
> > On Fri, Sep 25, 2026 at 09:44:04PM +0200, Eric Farman wrote:
> > > Hi Kevin, Hanna,
> > > 
> > > Here is a new version of iotests fixes from our s390x systems.
> > > They aren't related, just came up walking through the failures.
> > > 
> > > I saw you asked Eric Blake about the nbd-in-qcow2-chain patch.
> > > I left it as-is, but I am fine with skipping it if that's easier.
> > > 
> > > I added a new patch at the end of this series, which skips the last remaining
> > > failure I can create out-of-the-box on s390. I had hoped that I could get
> > > that one to work, but it doesn't appear to be trivial.
> > 
> > Series:
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > 
> 
> Thanks, Eric!
> 
> @Kevin, @Hanna... Any concerns with this series?

At this point, I plan on queuing this in my next NBD pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


