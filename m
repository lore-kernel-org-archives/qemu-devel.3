Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55747CD6E40
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwBc-0003fa-KN; Tue, 26 May 2026 14:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wRwBR-0003ew-9r
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wRwBP-0002WU-LX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKhhpaD+Mmz34oJEuGWdLf9RSM04gslB9HICgAZKyd8=;
 b=aQoEcqPFQP/YuZZbK7C76IC+Gf6v4w9CCo2AYYh8mhsa8+He/JRwM5SQnDxR5+PiE6dgXE
 Kv8GU3Vyo9xZEQjAo8fBTW3/wZp6XEmV/eQAFIBJHbSP/UZje0G4OEGhHr35ikYujb2E40
 HVl41HKs/5G1PVSxYI4fX6SxOOCR6xU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-9LaCbgxePLWFIcCzWgPwtg-1; Tue,
 26 May 2026 14:07:08 -0400
X-MC-Unique: 9LaCbgxePLWFIcCzWgPwtg-1
X-Mimecast-MFC-AGG-ID: 9LaCbgxePLWFIcCzWgPwtg_1779818826
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF8BF195608F; Tue, 26 May 2026 18:07:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.131])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA3781685; Tue, 26 May 2026 18:07:02 +0000 (UTC)
Date: Tue, 26 May 2026 20:07:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [Stable-11.0.1 v2 00/94] Patch Round-up for stable 11.0.1,
 freeze on 2026-05-22 (frozen)
Message-ID: <ahXhRKqcpoVmCAID@redhat.com>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
 <51204e0c-14e1-41db-8eaf-83bc3734567d@proxmox.com>
 <573968a1-4077-48e8-b14b-a8c8074b9e1b@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573968a1-4077-48e8-b14b-a8c8074b9e1b@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 23.05.2026 um 08:49 hat Michael Tokarev geschrieben:
> On 23.05.2026 02:10, Fiona Ebner wrote:
> > Hi Michael,
> > 
> > Am 22.05.26 um 11:35 PM schrieb Michael Tokarev:
> > > Please respond here or CC qemu-stable@nongnu.org on any additional patches
> > > you think should (or shouldn't) be included in the release.
> > 
> > > 92 b8bfb1478d61 Kevin Wolf:
> > >     qcow2: Fix corruption on discard during write with COW
> > > 93 389f5bcc744d Kevin Wolf:
> > >     iotests/046: Test that discard/write_zeroes wait for dependencies
> > 
> > since number 92 can cause an issue [0] that is much easier to run into
> > than the one it solves, but still similarly bad, I think it should only
> > be included together with Thomas' fix [1] on top. I know that one has
> > not been applied to master or reviewed by a maintainer yet, so if
> > including it goes against procedure, maybe it'd be better to leave 92
> > (and 93) out for now or delay the release?
> > 
> > Same for the other stable series. Thank you for the consideration!
> 
> Thank you very much for letting me know.  Yes, it isn't good to include
> "Fix corruption on discard" without the follow-up fix.  So it would be
> very nice to have the follow-up fix applied to the master branch today
> or tomorrow (this is Sat and Sun, maybe not the best timing), or I'll
> have to drop the above mentioned two changes from the stable series.
> Or indeed, releases should be delayed - in a hope the fix can be applied
> on Monday.
> 
> I'll wait for some reaction.  Kevin?

I was out yesterday and most of today, so I could only take a quick look
just now. The patch looks reasonable to me at first sight, I'll try to
have a closer look tomorrow.

Kevin


