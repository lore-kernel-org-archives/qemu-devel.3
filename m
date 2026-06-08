Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D887CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfh5-0006UH-7f; Mon, 08 Jun 2026 15:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWfgp-0006Tb-UT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWfgo-0004K8-2X
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780947071;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=V4NpCmzkUclCX2yafZ6mrXfdNq19pmEWLmKmFI7EiCg=;
 b=Zp3PnsMWYMu+HlkHWIsH6qUDu2GeLO2Zz4UjQJTF08B4UuDNI845TmNv8BU7IzWaDlK39S
 pXPhsKiM3fBhWq3vmPcsYuOwjqlame4YdGYMZrtXI0np0l48n2mEVzisKc7ZR44bDSI0J4
 lCT6G+G/idGfq1V8KWYt7Ez6f6MeYYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-V5vXGpoXMyaNCqIiM_eMzg-1; Mon,
 08 Jun 2026 15:31:06 -0400
X-MC-Unique: V5vXGpoXMyaNCqIiM_eMzg-1
X-Mimecast-MFC-AGG-ID: V5vXGpoXMyaNCqIiM_eMzg_1780947065
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D59AB1831358; Mon,  8 Jun 2026 19:31:04 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48E4D30094DA; Mon,  8 Jun 2026 19:31:03 +0000 (UTC)
Date: Mon, 8 Jun 2026 20:30:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: artifact download for qtest
Message-ID: <aicYc6GGapIJTKdi@redhat.com>
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
 <87v7bs6e2p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7bs6e2p.fsf@suse.de>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 08, 2026 at 04:13:02PM -0300, Fabiano Rosas wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 30/05/2026 16.56, Ani Sinha wrote:
> >> Hi,
> >> 
> >> I am trying to write a qtest for which I need an IGVM file. I have the
> >> file, about 54 MiB in size.
> >
> > 54 MiB is quite big, I agree that we likely don't want to check that into 
> > the main repository, especially if it is for a test only...
> > (BTW, what's its compressed size?)
> >
> >> Instead of committing this IGVM binary
> >> file with the test, I wanted to check if I can put it somewhere, say
> >> in a gitlab repo and then make the test download it. This would be
> >> similar to asset downloads for functional tests. No this test cannot
> >> be a python functional test.  I am wondering if anyone has faced this
> >> situation before and what the best way to solve this problem is.
> >
> > I'm not maintaining the qtests anymore, but I assume that there is no 
> > interest in duplicating all the asset downloading logic there.
> >
> 
> It would be nice if we could extract the existing code into a little
> asset library that could be invoked from the other test frameworks.

IMHO that isn't really practical, all the asset handling is in python.
It'd be mad to re-implement that in C and then call it from python,
and the C isn't really going to call the current python either....

> > What's the exact reason why you cannot do it as a functional test instead? 
> > You could maybe also start the qemu binary there with "-accel qtest -qtest 
> > ..." to fake a qtest environment - a little bit cumbersome, but certainly 
> > doable, I think.

..if we didn't have the historical baggage already, then I'd that
qtests should conceptually just be a subset of the functional
tests. Writing them in python would be nicer than doing them in C.

The qtest service is integrated in QEMU, what's missing is

 * the client side to talk the qtest protocol
 * the various bus specific helper APIs

I don't know how hard it would be to bootstrap the client side in
python, but the general qtest protocol is 2000 lines of C, so
probably more like 500 lines of python to replace it, plus whatever
helpers you might want on top. Probably not terribly much work to
get something useful kickstarted.

NB, I am *not* sugggesting re-writing the actual existing tests,
just make it possible to write new qtests in python.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


