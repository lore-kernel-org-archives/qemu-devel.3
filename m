Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F323D7830F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4vz-0003qA-Q7; Mon, 02 Dec 2024 06:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4vw-0003pp-HR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tI4vu-0000IN-Ps
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733140181;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdgAgslGyks6aZM9DuuUhrKubIDwZZx9fObxjzge60M=;
 b=ZzgzJya156+sBAi78mVDYgHHrBYkHiJFVTfAr9BUGxWWn28PQKNd78i6vXuiQmVchLuTZf
 f/8rIt5OIyIZwZaQaYfj2T/gf+HCDwMKpJoVtc/ojkuYRt9t6qAl9l5pAcZ//8KPJPgO7w
 BZ7Vi8cbmKW74hZTCpwhjFyP5B8F9g8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-1gV9C9StPgupLHR4FIp1ww-1; Mon,
 02 Dec 2024 06:49:34 -0500
X-MC-Unique: 1gV9C9StPgupLHR4FIp1ww-1
X-Mimecast-MFC-AGG-ID: 1gV9C9StPgupLHR4FIp1ww
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B665A1955E70; Mon,  2 Dec 2024 11:49:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DED9195605A; Mon,  2 Dec 2024 11:49:32 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:49:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 06/22] tests/functional: introduce some helpful decorators
Message-ID: <Z02eyKY2rTeSZ6sB@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-7-berrange@redhat.com>
 <3cc78a57-98c0-4dec-89f3-3b277603ae78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cc78a57-98c0-4dec-89f3-3b277603ae78@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 02, 2024 at 09:27:34AM +0100, Thomas Huth wrote:
> On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> > Reduce repeated boilerplate with some helper decorators:
> > 
> >   @skipIfNotPlatform("x86_64", "aarch64")
> > 
> >    => Skip unless the build host platform matches
> > 
> >   @skipIfMissingCommands("mkisofs", "losetup")
> > 
> >    => Skips unless all listed commands are found in $PATH
> > 
> >   @skipIfMissingImports("numpy", "cv2")
> > 
> >    => Skips unless all listed modules can be imported
> > 
> >   @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")
> > 
> >    => Skips unless env var requests flaky tests with the
> >       reason documented in the referenced gitlab bug
> > 
> >   @skipBigData
> > 
> >    => Skips unless env var permits tests creating big data files
> > 
> >   @skipUntrustedTest
> > 
> >    => Skips unless env var permits tests which are potentially
> >       dangerous to the host


> > +'''
> > +Decorator to skip execution of tests which need large
> > +data storage on the host, unless the
> > +$QEMU_TEST_ALLOW_LARGE_STORAGE env var is set
> 
> Maybe we should also provide some direction what is meant with large
> storage. I've seen some tests that are skipped since they create a disk file
> with 128 MiB. And others are always executed though they create a disk file
> with 512 MiB or even more. What would be a good recommendation here?
> (My gut feeling is maybe ~ 1 GiB? Or better less?)

We're quite limited on disk space in the FreeBSD CI runner, so if we
take account of fact that tests can run in parallel, we definitely want
to err on the smaller side, while maximising coverage available by
default. 128 MB is too small, too many tests would get excluded. I
guess 512MB - 1GB is probably the rough range we should give guidance
for.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


