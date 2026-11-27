Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC140606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fZoZ2Dcx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwW1-0008E3-In; Fri, 27 Nov 2026 09:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWwVz-0008AQ-Mm
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWwVu-0000NZ-5J
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795788080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HZSloplVOxEAjXyfxGKI2Uu3SdlxLun68u0A1UmfxXE=;
 b=fZoZ2Dcxgbm8I+EyK53LGjWk/XCEYsCujbxAukgii3dBF/gq7aBsQKD/LrkSq/VTrZEuD9
 wH1Ilrkndqox0YQYc0/IWLHo1HVjivotRhFQhv2/WGHmRmZbc2hYTjb9JPMTShlBkD9Low
 HZXcsFe13dCA9EVBxMRic7bJm3185nQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-OEgcc9nINv6jpCqam-s4hQ-1; Fri,
 27 Nov 2026 14:01:18 +0000
X-MC-Unique: OEgcc9nINv6jpCqam-s4hQ-1
X-Mimecast-MFC-AGG-ID: OEgcc9nINv6jpCqam-s4hQ_1795788077
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0A8195606C; Fri, 27 Nov 2026 14:01:17 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13097428; Fri, 27 Nov 2026 14:01:15 +0000 (UTC)
Date: Fri, 27 Nov 2026 14:01:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration-test: Support running a real kernel
Message-ID: <awmNKb0WevtA0L_L@redhat.com>
References: <20261126214704.3108327-1-farosas@suse.de>
 <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 08:45:04AM -0500, Peter Xu wrote:
> On Thu, Nov 26, 2026 at 06:46:59PM -0300, Fabiano Rosas wrote:
> > There's a class of migration performance bugs that are very specific
> > to the internals of QEMU and most likely require work on our side, but
> > are currently invisible to our testing because migration-test runs a
> > simple guest workload (not even that, really). The more important ones
> > are BQL contention issues that result in vcpu starvation.
> > 
> > My plan is to incrementally add some pieces to migration-test to
> > reduce that testing gap.
> > 
> > The first piece is adding support for running a kernel + initrd inside
> > the guest which gives us an easy way to start exercising migration of
> > a more loaded guest that can already cause VM exits.
> > 
> > This series adds support for -kernel and -initrd arguments to
> > migration-test and runs the same set of tests we currently have, but
> > with the kernel instead of the custom loop. By default it uses the
> > initrd from tests/migration-stress/ which runs a read-write loop over
> > all memory and has customizable vcpu and memory size.
> 
> The whole thing sounds useful, I'll read into details after I flush more of
> the older patches.. which will take some time (it also depends on if next
> week I got some more urgent task "injected"..).
> 
> One high level question: this will grow qtest closer to what the functional
> test is doing.  Have you thought of the relationship between the two, after
> we move qtest more over there?  I assumed not, based on what you mentioned
> in the rest part of cover letter that you planned to have it only for dev
> debug purpose.  But still, we'll start to ask the question to ourselves at
> some point, IIUC.  So I ask first. :)

In terms of the boundary between functional tests and qtests, I
think the guidance is in the names.

If it is a "qtest" test then it should be primarily making use
of QTest to interrogate the QEMU internalprocess state.

If it is a "functional"  test, then it is interested in running
real kernels & real accelerators and validating the behaviour of
QEMU via its external mgmt interfaces.

By this definition, IMHO, the migration-test would be a functional
test, if it were created from scratch to.

It only uses libqtest.h APIs for the purpose of sending QMP
commands, not examining internal device state. Essentially it is a
historical accident that it is written as a qtest instead of a
functional test, as that was the best choice at the time.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


