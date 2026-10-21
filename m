Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B946606ABC1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jLSYlZLx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJVZW-0006yE-Nf; Wed, 21 Oct 2026 08:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xJVZO-0006wb-Mg
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1xJVZL-0000P2-OH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 08:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792586242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEZS9317Rf8NGDAYGIGnFyfgjBka1YsLELSu7mEt0QM=;
 b=jLSYlZLxpZNizfeSfhV0WZbzYsQ3DLc3UP2juEsOZnIBSb3vtsDKg8C5japwg9vPy5ueNM
 mSwm//Lhilon4UuqmBhsBWq3zUHJ15bIDTFkGTpzB1bbHE8zOsQDyTcW9xw3ux3ipjeYUe
 q6PFPNC01v9sHdi0FK8lFqlBicAKaIs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-pNi8JNfGOpeDgU3Uqpb6Rw-1; Wed,
 21 Oct 2026 12:37:11 +0000
X-MC-Unique: pNi8JNfGOpeDgU3Uqpb6Rw-1
X-Mimecast-MFC-AGG-ID: pNi8JNfGOpeDgU3Uqpb6Rw_1792586230
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C91C18007FA; Wed, 21 Oct 2026 12:37:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D35630000E7; Wed, 21 Oct 2026 12:37:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Faria <afaria@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] include: Add virtio-blk request flag FUA definitions
In-Reply-To: <atiukShvcKuVOuMj@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20261021062257.735757-1-afaria@redhat.com>
 <20261021062257.735757-2-afaria@redhat.com> <87v76v32ni.fsf@redhat.com>
 <atiukShvcKuVOuMj@redhat.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Wed, 21 Oct 2026 14:37:07 +0200
Message-ID: <87pkx32psc.fsf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21 2026, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 21.10.2026 um 09:59 hat Cornelia Huck geschrieben:
>> On Wed, Oct 21 2026, Alberto Faria <afaria@redhat.com> wrote:
>> 
>> > Signed-off-by: Alberto Faria <afaria@redhat.com>
>> > ---
>> >  include/standard-headers/linux/virtio_blk.h | 13 +++++++++++--
>> >  1 file changed, 11 insertions(+), 2 deletions(-)
>> 
>> Maybe explicitly mark as *placeholder*, so it doesn't get merged
>> accidentally?
>
> What is the proper (or at least common) way to do this? Do we really
> have to wait for Linux to merge the guest driver side of virtio device
> changes before we can add the emulation in QEMU?

If we have some changes in the synced-from-Linux headers, we really need
to do a proper header sync to get them (or the next sync might remove
the changes again...) So yes, this unfortunately needs to wait for a
kernel with the changes (can be -rc)...

***

The other question (not really related to this patch set, maybe
warranting a separate discussion): Should we move the host <-> guest
interface definition to a third place that both Linux and QEMU (and any
other piece of software) can sync from? Source-of-truth is the virtio
spec, so in a perfect world QEMU should not have to wait for a Linux
kernel with the definitions to be released once it has been enshrined
there. Grabbing everything from Linux is something that did get the job
done and avoided duplicating code, but maybe it's time to revisit this.
(We obviously should keep syncing headers for actual kernel <->
userspace interfaces.)


