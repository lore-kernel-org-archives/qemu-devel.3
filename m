Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE0606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GWt+FOjo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4PZ-0006Kv-Dq; Wed, 11 Nov 2026 04:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR4PX-0006Kc-TC
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 04:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR4PW-00017D-7S
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 04:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794388469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ahqrD+ownXJ+Qp8rHxyptRcWWr1lQ9i9H+ka/mL//fU=;
 b=GWt+FOjoo/J+LpkBvMXz4iUZsN/vnZJiCxXdbkJ/QWoNOVELymGgeulkPpDOstXuNl55Qp
 vrAGZ1i6QhbonuClJd4qCknMLnLnTewMjIAGO9IVzOjUZrP3JEQlVkEqsYDy6CFV3Zx722
 blEpQScE0nxFquiPS0C4zZiISwJxOG0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-F9u-EZyFNL-N5T08wN__Yg-1; Wed,
 11 Nov 2026 04:14:25 -0500
X-MC-Unique: F9u-EZyFNL-N5T08wN__Yg-1
X-Mimecast-MFC-AGG-ID: F9u-EZyFNL-N5T08wN__Yg_1794388464
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CB951800370; Wed, 11 Nov 2026 09:14:24 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 358E61956087; Wed, 11 Nov 2026 09:14:23 +0000 (UTC)
Date: Wed, 11 Nov 2026 09:14:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v2 for-11.2] docs/devel/testing: iotests check script
 should be run via 'run'
Message-ID: <avQx7OOfuoez9Fs6@redhat.com>
References: <20261106170158.3858169-1-peter.maydell@linaro.org>
 <au4uyq1cntUoa7oO@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <au4uyq1cntUoa7oO@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 06, 2026 at 01:55:39PM -0600, Eric Blake wrote:
> On Fri, Nov 06, 2026 at 05:01:57PM +0000, Peter Maydell wrote:
> > The iotests section of the testing documentation suggests directly
> > running the "./check" script.  However if you do this then the
> > script complains:
> > 
> > WARNING: iotests is being run from outside of the configure-time python virtual environment
> > [...]
> > Please use the meson run script:
> >         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
> 
> Huh. I did a git checkout, mkdir build, cd build && ../configure, then:
> 
> $ build/run tests/qemu-iotests/check 5
> 
> WARNING: iotests is being run from outside of the configure-time python virtual environment
> 
> current python: /home/eblake/qemu/build/pyvenv/bin/python3
> pyvenv python:  /home/pyvenv/bin/python3
> ...

Beyond that warning, the 'check' script has bad heuristics for
finding the build directory, looking for 'cwd' in this particular
case which is wrong. I've sent a path that addresses this which
does the job in my testing at least.

> but running directly from the configured directory:
> 
> $ cd build
> $ ./run tets/qemu-iotests/check 5
> 
> does what this patch recommends.
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


