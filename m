Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D014606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IgkJGkG8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOufg-0003Ih-0B; Thu, 05 Nov 2026 05:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOufY-0003Dv-Sk
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOufW-0004Bx-0m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1fwVrtjvaxfXU5AlzEDWjaQPjvPmXz5eZ/43pHyUB8=;
 b=IgkJGkG8Qsl+tTXFGpw1/ti6sjzbMVQviU+YXeKRdPqWnK5HqdcXy0CG4fytMLAihOmy+V
 T8JA/pWKX0ebWVleIJkXlgkTqD+ptvWbhhRAfqFzY9Mgoir06ITi2wqPOpT1/q38SXDKsu
 s45fCYl85F7X6kqicjB4tnbipfKYkfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-m6MSzPgcO3G3R6BmbMXwTA-1; Thu,
 05 Nov 2026 05:26:00 -0500
X-MC-Unique: m6MSzPgcO3G3R6BmbMXwTA-1
X-Mimecast-MFC-AGG-ID: m6MSzPgcO3G3R6BmbMXwTA_1793874359
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E4CC1801319; Thu,  5 Nov 2026 10:25:59 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A875195608B; Thu,  5 Nov 2026 10:25:58 +0000 (UTC)
Date: Thu, 5 Nov 2026 10:25:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs/devel/testing: iotests check script should be run
 via 'run'
Message-ID: <auxZs5Rc6mVKjaC8@redhat.com>
References: <20261103110805.2010679-1-peter.maydell@linaro.org>
 <87o6c685ph.fsf@draig.linaro.org> <auxNqQU1SePuiQuq@redhat.com>
 <CAFEAcA-PXjPiCqE1qUkt4QFHwTYpATMAm-C-a641kdOMaPgcEQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-PXjPiCqE1qUkt4QFHwTYpATMAm-C-a641kdOMaPgcEQ@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 10:20:07AM +0000, Peter Maydell wrote:
> On Thu, 5 Nov 2026 at 09:34, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Nov 03, 2026 at 12:22:50PM +0000, Alex Bennée wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >
> > > > The iotests section of the testing documentation suggests directly
> > > > running the "./check" script.  However if you do this then the
> > > > script complains:
> > > >
> > > > WARNING: iotests is being run from outside of the configure-time python virtual environment
> > > > [...]
> > > > Please use the meson run script:
> > > >         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
> > > >
> > > > Update the documentation to match this.
> > > >
> > > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > > ---
> > > >  docs/devel/testing/main.rst | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> > > > index b0ca37fe2ba..e26b8af0c79 100644
> > > > --- a/docs/devel/testing/main.rst
> > > > +++ b/docs/devel/testing/main.rst
> > > > @@ -272,8 +272,12 @@ scripts.  The testing success criteria is golden output comparison, and the
> > > >  test files are named with numbers.
> > > >
> > > >  To run iotests, make sure QEMU is built successfully, then switch to the
> > > > -``tests/qemu-iotests`` directory under the build directory, and run ``./check``
> > > > -with desired arguments from there.
> > > > +``tests/qemu-iotests`` directory under the build directory, and run
> > > > +the ``check`` script via the ``run`` wrapper which sets up the environment:
> > > > +
> > > > +.. code::
> > > > +
> > > > +   ../../run ./check [args]
> > > >
> > >
> > > This is possibly a personal preference thing but is there actually a
> > > reason for cwd to be tests/qemu-iotests or should we frame it as:
> > >
> > >   $BLD/run tests/qemu-iotests/check
> > >
> > > which is how the functional tests are listed?
> >
> > For the sake of docs it is probably a good idea to be run consistent
> > and illustrate use of 'run' from the root of the build  dir ie
> >
> >   ./run tests/qemu-iotests/check
> 
> Agreed if it works for all cases. Does it? I assumed the existing docs
> were saying that it should be run from the qemu-iotests subdirectory
> for a reason.

I don't think there is a hard constraint on CWD for the iotests, as
I've often run from the root of the build dir and not seen failures.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


