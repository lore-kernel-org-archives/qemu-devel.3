Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B1E9E31E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqC1v-0003VK-Oe; Wed, 11 Feb 2026 10:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC1p-0003PQ-GO
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC1n-0004YT-IR
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823277;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=q/7rJjfcGh/xulqNVPMzQw8Ef5/+G49lzdATCUzdDrM=;
 b=h2HqlytFWSTayamLQmsKMnNkdWh0iFTXgUifQI8FaUbTwG+85Ua5oTrJTSsVoa1+B+8tYt
 KHx5CMiwC/VN8HkSej3bVaixTr6Nfd6OcHCOxnptC93vk/JKeIzvotW5OEMzfTDsxGgUqc
 HR6/OTTH/nqEkYwaKDZOfDwMPYAOty8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-o9sn6cgdNzKsXu70nmx97g-1; Wed,
 11 Feb 2026 10:21:13 -0500
X-MC-Unique: o9sn6cgdNzKsXu70nmx97g-1
X-Mimecast-MFC-AGG-ID: o9sn6cgdNzKsXu70nmx97g_1770823272
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1D8A18003F5; Wed, 11 Feb 2026 15:21:12 +0000 (UTC)
Received: from redhat.com (unknown [10.45.227.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 221A219560A3; Wed, 11 Feb 2026 15:21:10 +0000 (UTC)
Date: Wed, 11 Feb 2026 15:21:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 0/1] Tracing patches
Message-ID: <aYyeY8Vu1W5gnCNw@redhat.com>
References: <20260210201454.177202-1-stefanha@redhat.com>
 <CAFEAcA_jXEr1E+CP7C=Q0tkDQYkhkc3ccXRykYzgN7jw2spr5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_jXEr1E+CP7C=Q0tkDQYkhkc3ccXRykYzgN7jw2spr5Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 11, 2026 at 03:12:18PM +0000, Peter Maydell wrote:
> On Tue, 10 Feb 2026 at 20:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:
> >
> >   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> >
> > for you to fetch changes up to 80c15bcc5eb6d30abf90b2fd120cdf01f6ed2082:
> >
> >   tracetool-test: add QEMU_TEST_KEEP_SCRATCH=1 support (2026-02-10 14:47:14 -0500)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > ----------------------------------------------------------------
> >
> > Stefan Hajnoczi (1):
> >   tracetool-test: add QEMU_TEST_KEEP_SCRATCH=1 support
> >
> >  tests/tracetool/tracetool-test.py | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> This change seems to use some Python construct not supported
> by all our platforms. CI job failures due to the tracetool tests
> failing:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/13074647460
> https://gitlab.com/qemu-project/qemu/-/jobs/13074647473
> 
> Traceback (most recent call last):
>   File "/builds/qemu-project/qemu/tests/tracetool/tracetool-test.py",
> line 121, in <module>
>     with tempfile.TemporaryDirectory(prefix=sys.argv[4],
> TypeError: __init__() got an unexpected keyword argument 'delete'

Yep, that's too new to rely on:

  https://docs.python.org/3/library/tempfile.html#tempfile.TemporaryDirectory

  Changed in version 3.12: Added the delete parameter.


since this is just a debugging aid, perhaps only set the 'delete' param
when we know python is new enough, and don't bother trying to make
QEMU_TEST_KEEP_SCRATCH=1 work on older python

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


