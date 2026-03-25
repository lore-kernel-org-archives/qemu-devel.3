Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D523109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RVo-0006e0-5N; Wed, 25 Mar 2026 12:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5RVn-0006dj-46
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5RVl-0000aj-Bc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QpOgwADQZHhtklShIDJVwD3+orR5aDiyTPYe/N0lZ4c=;
 b=aotrL4P/dRI/RLJt35dVOVEHCOgKgJ7iP3Hw4tGNfP6G00ykOzhm2UxVXs98Vb0ZXGxdUh
 +auIydFDiWjPSR9nWxeXoUJ0vv8dBBvFeA8A+9A606+MTMM2WNmcmKYiI70W6jw/7EznBw
 Oeakp0qDfSpYYyPnW7QfIH6dcxZdngg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-bqr_6HU4P_ChN3d-qPNqFg-1; Wed,
 25 Mar 2026 12:55:09 -0400
X-MC-Unique: bqr_6HU4P_ChN3d-qPNqFg-1
X-Mimecast-MFC-AGG-ID: bqr_6HU4P_ChN3d-qPNqFg_1774457707
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7313A1800611; Wed, 25 Mar 2026 16:55:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6A21953947; Wed, 25 Mar 2026 16:55:01 +0000 (UTC)
Date: Wed, 25 Mar 2026 16:54:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: Cleaning up contrib/ and tools/
Message-ID: <acQTYmtvU92LwKbB@redhat.com>
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <87tsu4m8w4.fsf@pond.sub.org>
 <CAFEAcA_DEPSoAnEzobryPbqU77QHwqYyxybmdi7KX2wjJqzRhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_DEPSoAnEzobryPbqU77QHwqYyxybmdi7KX2wjJqzRhw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Wed, Mar 25, 2026 at 04:49:57PM +0000, Peter Maydell wrote:
> On Wed, 25 Mar 2026 at 11:44, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > We have a couple of directories in our source tree which have
> > > accumulated things in them that don't really belong there; this is a
> > > proposal to clean up by moving things to more appropriate locations
> > > (as 11.1 work, obviously).
> > >
> > > Firstly, contrib/ has a tendency to be a dumping ground for stuff that
> > > we didn't think hard enough about finding a good home for, and for
> > > things in a weird "not really maintained" state. We should either
> > > (a) care enough about something to give it a correct home and to
> > > maintain it, or (b) not care about it, and kick it out of our tree.
> > >
> > > Secondly, tools/ exists but is very under-used. I think it should be
> > > for the set of standalone tools that we build if you configure
> > > --enable-tools and which we document in docs/tools.  Currently it
> > > contains two things, one of which doesn't match that idea...
> > >
> > > So, starting with tools/:
> >
> > [...]
> >
> > > And for contrib/, easy ones first:
> > >  * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
> > >  * contrib/elf2dmp moves to tools/
> > >  * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
> >
> > Absolutely not.  This is example code, provided in the hope of helping
> > people understand the protocol, and experiment with it.  It is entirely
> > unfit for more serious use, and that's intentional.
> 
> So, example code but we don't think it's a good example ? :-)
> 
> Our system documentation seems to assume you're going to run
> ivshmem-server:
> 
> https://www.qemu.org/docs/master/system/devices/ivshmem.html
> 
> > Perhaps contrib/ is not a good home for example code.  It seems to
> > bother people whose judgement I respect.  Can we find a better home?
> 
> I'm not sure to what extent we should be in the business of
> providing example code. If we are doing that we should label
> it all a bit better...

FWIW, the server does warn the user on startup since Markus commited
a335c6f204eefba8ff935bcee8f31f51d2174119:


+    /*
+     * Do not remove this notice without adding proper error handling!
+     * Start with handling ivshmem_server_send_one_msg() failure.
+     */
+    printf("*** Example code, do not use in production ***\n");


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


