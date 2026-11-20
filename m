Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA132606B9BA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VnKi+Uwd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTBd-0004zq-E9; Fri, 20 Nov 2026 13:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUTBG-0004x7-7Y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xUTBC-0001OD-2Y
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795198663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pobr5oGTLUxesTFYB+vCngWLbYhBFyWJ0Xnp3WxGugA=;
 b=VnKi+Uwdsf4bTk1cqI5yskE9q/evfM2z9QwuDunMKRI3jiVZh+IwZ+cLIa15vH4YVLre4k
 Wzq9zfH2IVP7y6vk98XEyForGB3PfiyTE5xNXzBJVmA5P127/PjEXonAYN9sfS2SmTlAq+
 XwF7b/nKCSk2Ci853ZKvddbITG2UKcw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-ulSNVeF1P46wWs7MBs4RFg-1; Fri,
 20 Nov 2026 18:17:39 +0000
X-MC-Unique: ulSNVeF1P46wWs7MBs4RFg-1
X-Mimecast-MFC-AGG-ID: ulSNVeF1P46wWs7MBs4RFg_1795198658
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ADC21955F19; Fri, 20 Nov 2026 18:17:37 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 177A31801976; Fri, 20 Nov 2026 18:17:34 +0000 (UTC)
Date: Fri, 20 Nov 2026 12:17:32 -0600
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PULL for-11.2 0/3] NBD patches through 2026-11-19
Message-ID: <awCOZiNf_0DDzecQ@redhat.com>
References: <20261119202330.3853797-5-eblake@redhat.com>
 <4ceec3cf-6903-4cd9-84e3-6522ffc67a1a@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ceec3cf-6903-4cd9-84e3-6522ffc67a1a@tls.msk.ru>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 11:52:25AM +0300, Michael Tokarev wrote:
> On 11/19/26 23:23, Eric Blake wrote:
> 
> > NBD patches for 2026-11-19
> > 
> > - Eric Blake: CVE-2026-126657: heap leak on client to malicious NBD server
> > 
> > ----------------------------------------------------------------
> > Eric Blake (3):
> >        nbd: Refactor structured payload interpretation
> >        nbd: Pass back offset/length for all structured read replies
> >        nbd/client: Don't leak uninitialized memory on malicious server
> > 
> >   block/nbd.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
> >   1 file changed, 73 insertions(+), 14 deletions(-)
> > 
> 
> Hi Eric!
> 
> This patchset contains a single patch which is marked for-stable, the
> last one.  The first two are not marked as-such.
...

> I'm picking up all 3.  Please let me know if I should not  :)

All three should be backported to stable; the third depends on the
first two being in place. My fault for not applying the tag
consistently, and thanks for double-checking!

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


