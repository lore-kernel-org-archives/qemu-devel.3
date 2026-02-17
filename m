Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642F4E68160
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 10:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsI0l-0004AD-6k; Tue, 17 Feb 2026 05:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsI0g-000487-QG
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vsI0e-0003rx-7t
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 05:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771322926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9x+zF7Edixu3LgmHuKQhWBx6FbTVe++aLCiynRuy0k=;
 b=TgpD2PreHo84HJheDiPu9IsEGLyYvdt4Ntxi6Vp7c45Z9Ze8yE2fFugeFAAeS4CuPUumNf
 OIGShmkM7LNSapg4SdmMyA2+7Tctg1S1Pbc9WnpFNcJbod/VN44pavrhZPX8st1CVkT3d3
 lvvr5oLLDjwrCjdJc0xUrL1hO+bwNsg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-5Vla_H4ZMxKjwvsQA8O1Uw-1; Tue,
 17 Feb 2026 05:08:44 -0500
X-MC-Unique: 5Vla_H4ZMxKjwvsQA8O1Uw-1
X-Mimecast-MFC-AGG-ID: 5Vla_H4ZMxKjwvsQA8O1Uw_1771322923
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 456FE195FE25; Tue, 17 Feb 2026 10:08:43 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.181])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3CC03000218; Tue, 17 Feb 2026 10:08:39 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:08:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 0/2] migration: feature removals for 11.0
Message-ID: <aZQ-I0hVsd5M-gTK@redhat.com>
References: <20260115225503.3083355-1-peterx@redhat.com>
 <aZQ0q2r6w3OkSP2f@angien.pipo.sk> <aZQ5HObOS3RGwf-4@redhat.com>
 <aZQ7AWli0Wv4Df2P@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZQ7AWli0Wv4Df2P@angien.pipo.sk>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Tue, Feb 17, 2026 at 10:55:13AM +0100, Peter Krempa wrote:
> On Tue, Feb 17, 2026 at 09:47:08 +0000, Daniel P. Berrangé wrote:
> > On Tue, Feb 17, 2026 at 10:29:38AM +0100, Peter Krempa wrote:
> > > On Thu, Jan 15, 2026 at 17:55:01 -0500, Peter Xu wrote:
> > > > v2:
> > > > - Added R-bs
> > > > - Updated description for removing zero-blocks [Markus]
> > > > - Squashed the "fd: to file" test removal into the 2nd patch
> > > > - I dropped the COLO patch, I have a local patch to remove colo migration
> > > >   completely, but looks like we won't do it..  Let's leave it for later but
> > > >   do the rest first
> > > > 
> > > > This series removes two deprecated features for 11.0.
> > > > 
> > > > Please review, thanks.
> > > > 
> > > > Peter Xu (2):
> > > >   migration: Remove zero-blocks capability
> > > >   migration: Remove fd: support on files
> > > > 
> > > >  docs/about/deprecated.rst             | 20 -------------
> > > 
> > > Note that per the 'MAINTAINERS' file, changes to any deprecations ought
> > > to be CC'd to the libvirt list for visibility.
> > > 
> > > In this case we've forgotten about the deprecation and didn't fix it
> > > before the qemu cahnge was pushed. I'll send out patches soon, but keep
> > > in mind to *always* CC the libvirt list with deprecations.
> > 
> > I'm suprised  to see libvirt broken at all here.
> > 
> > AFAIR, the 'fd:' protocol inadvertantly gained support for targetting
> > plain files, which the deprecation aimed to then revert (remove). The
> > actual removal though seems to have targetted anything which is not a
> > socket, which includes pipes, which libvirt was using.
> 
> Libvirt is using pipes for *most* cases, but not all. There is one code
> path (virsh restore without compression or cache bypass, when residing
> on an actual filesystem (not a root squashed NFS)) which still can pass
> a file FD to the migration code as 'fd:'. In all other cases we do pass
> in a pipe in one way or another (via the compression program,
> virFileWrapper (mandatorily used on equivalents of 'virsh save', or the
> helper process used to access root-squashed NFS). The code is not easy
> to follow because there are numerous layers where the wrapping of the
> file into a pipe can happen, one of which is right next to the migration
> code. I'll soon post patches.

NB if there is any scenario where we passed a plain file to QEMU, that
would be a bug in libvirt. The iohelper was intended to be used in
*all* cases where we had plain files, so that we can ensure poll()
works sanely for QEMU, and that we don't end up with an unkillable
QEMU due to a syscall stuck in kernel on an uninterruptible sleep
on dead storage.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


