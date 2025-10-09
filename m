Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F782CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRy-0001he-Om; Thu, 09 Oct 2025 03:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6lRw-0001a8-DJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6lRm-0004XR-Bj
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996338;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VD1r46vuc9kC8IfPD4CefpCuBck8ZhRo9cwZ+lPIvQQ=;
 b=Q8MWLCq9N3luIyYUM074MvGHG/IE7ey0Mpb6JKaJchfbwVQ9GJKPE4jMjSyHK/ey6pEJ7P
 R/qQdEuJ3PE9BqwbrcH/gIeiSlcCNWcb0Yz2Y11yvRARMtK0lYzO2Xqr6nky3PyimxEk1S
 huv9b9Ttn+GN3nnl0gbq+CsuGTMx/0A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-5BloWSK0PUW0qIUko8y0Cg-1; Thu,
 09 Oct 2025 03:52:13 -0400
X-MC-Unique: 5BloWSK0PUW0qIUko8y0Cg-1
X-Mimecast-MFC-AGG-ID: 5BloWSK0PUW0qIUko8y0Cg_1759996332
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B40C5180034A; Thu,  9 Oct 2025 07:52:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32506180035E; Thu,  9 Oct 2025 07:52:07 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:52:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
Message-ID: <aOdpofyFVoYVQc3D@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
 <20251008175811.GB181748@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008175811.GB181748@fedora>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Wed, Oct 08, 2025 at 01:58:11PM -0400, Stefan Hajnoczi wrote:
> On Wed, Oct 08, 2025 at 08:35:41AM +0200, Paolo Bonzini wrote:
> > Sort imports automatically, to keep the coding style more uniform.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  python/tests/tracetool-isort.sh      | 4 ++++
> >  scripts/tracetool.py                 | 5 ++---
> >  scripts/tracetool/backend/dtrace.py  | 1 -
> >  scripts/tracetool/backend/ftrace.py  | 3 +--
> >  scripts/tracetool/backend/log.py     | 3 +--
> >  scripts/tracetool/backend/simple.py  | 1 -
> >  scripts/tracetool/backend/syslog.py  | 3 +--
> >  scripts/tracetool/backend/ust.py     | 1 -
> >  scripts/tracetool/format/d.py        | 2 +-
> >  scripts/tracetool/format/log_stap.py | 1 -
> >  scripts/tracetool/format/stap.py     | 1 -
> >  11 files changed, 10 insertions(+), 15 deletions(-)
> >  create mode 100755 python/tests/tracetool-isort.sh
> > 
> > diff --git a/python/tests/tracetool-isort.sh b/python/tests/tracetool-isort.sh
> > new file mode 100755
> > index 00000000000..b23f3d48448
> > --- /dev/null
> > +++ b/python/tests/tracetool-isort.sh
> > @@ -0,0 +1,4 @@
> > +#!/bin/sh -e
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +python3 -m isort --sp . -c ../scripts/tracetool/
> 
> I wonder why python/tests/isort.sh doesn't already cover this with its
> `python3 -m isort -c scripts/` line?
> 
> Also, why the --settings-path (--sp) option that python/tests/isort.sh
> doesn't use?
> 
> It would be great to have just 1 script that runs isort on all Python
> code in QEMU.

IMHO all of the shell scripts should really just go away. They
live in their own world outside the rest of our meson test setup
which means developers rarely even know they exist, let alone run
them on submissions.

I've proposed removing them in favour of meson rules earlier
this year:

  https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg04920.html

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


