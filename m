Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D13E68154
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHfx-0000wM-9H; Tue, 17 Feb 2026 04:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsHft-0000w5-5s
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:47:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsHfr-0004Sn-Dt
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771321638;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ot1nYQivrnJ2ktAzktowOCqVtGxehJKjLAX+OgJr29I=;
 b=QICEnbnom28OuMJD45+E3wkEfzn150ThhI3bikwUC6suNuE95XS+dnmFfwMlw0o4XeanwC
 biUvSdUDcqsjcAKXj6mIpPfjx4zo+vA7acmyhefACLN9smiPfyQmDc+I1CUNPBcXX4tiaT
 Mv4pVHOKuPjW0q2usRj1Iy/24N8gTvI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-nPw1sWGyN5eEYJGw7jhaUA-1; Tue,
 17 Feb 2026 04:47:16 -0500
X-MC-Unique: nPw1sWGyN5eEYJGw7jhaUA-1
X-Mimecast-MFC-AGG-ID: nPw1sWGyN5eEYJGw7jhaUA_1771321635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B868A1954B12; Tue, 17 Feb 2026 09:47:15 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.181])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1451F1800352; Tue, 17 Feb 2026 09:47:11 +0000 (UTC)
Date: Tue, 17 Feb 2026 09:47:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
Message-ID: <aZQ5HObOS3RGwf-4@redhat.com>
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZQ0q2r6w3OkSP2f@angien.pipo.sk>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 17, 2026 at 10:29:38AM +0100, Peter Krempa wrote:
> On Thu, Jan 15, 2026 at 17:55:01 -0500, Peter Xu wrote:
> > v2:
> > - Added R-bs
> > - Updated description for removing zero-blocks [Markus]
> > - Squashed the "fd: to file" test removal into the 2nd patch
> > - I dropped the COLO patch, I have a local patch to remove colo migration
> >   completely, but looks like we won't do it..  Let's leave it for later but
> >   do the rest first
> > 
> > This series removes two deprecated features for 11.0.
> > 
> > Please review, thanks.
> > 
> > Peter Xu (2):
> >   migration: Remove zero-blocks capability
> >   migration: Remove fd: support on files
> > 
> >  docs/about/deprecated.rst             | 20 -------------
> 
> Note that per the 'MAINTAINERS' file, changes to any deprecations ought
> to be CC'd to the libvirt list for visibility.
> 
> In this case we've forgotten about the deprecation and didn't fix it
> before the qemu cahnge was pushed. I'll send out patches soon, but keep
> in mind to *always* CC the libvirt list with deprecations.

I'm suprised  to see libvirt broken at all here.

AFAIR, the 'fd:' protocol inadvertantly gained support for targetting
plain files, which the deprecation aimed to then revert (remove). The
actual removal though seems to have targetted anything which is not a
socket, which includes pipes, which libvirt was using.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


