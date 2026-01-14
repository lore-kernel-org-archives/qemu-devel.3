Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB1D29FE2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfyO7-0004Vc-JG; Wed, 14 Jan 2026 05:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfyNy-0004Tf-Jv
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfyNw-0005Ue-Rp
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768387556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGgazBclU1FJ94Ekyumze9BOnXLSbqO9sFh+Kb3uRJk=;
 b=hygZbsr6pOZ6TbiGpJ+BKqHG0A4Jz0Q3r0a/WE2yuRWe9k2E0Vg32n+bF9AjgfRS7Ld8Ny
 KvvefBHobEHeiQGC/182v74ThOqhz13ELwTDICJP63mc8zHrgXPvzCUGE7ICEuBfxnXsGI
 ySjxFzDOSncscV4z2H59+4jJTSlRaIM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-F1XlrkszPci96AlJSLt_4A-1; Wed,
 14 Jan 2026 05:45:52 -0500
X-MC-Unique: F1XlrkszPci96AlJSLt_4A-1
X-Mimecast-MFC-AGG-ID: F1XlrkszPci96AlJSLt_4A_1768387551
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7751956095; Wed, 14 Jan 2026 10:45:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3B9A1800240; Wed, 14 Jan 2026 10:45:47 +0000 (UTC)
Date: Wed, 14 Jan 2026 10:45:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 09/13] tests: add nbd and luks to the I/O test suites
Message-ID: <aWdz15Zz9HaQhUQc@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-10-berrange@redhat.com>
 <7840ab4d-9991-4018-9546-6a221ab70307@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7840ab4d-9991-4018-9546-6a221ab70307@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Tue, Jan 13, 2026 at 01:52:45PM +0100, Thomas Huth wrote:
> On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> > This introduces new suites for running I/O tests on NBD and LUKS
> > drivers, giving new make targets
> > 
> >   * make check-block-luks
> >   * make check-block-nbd
> > 
> > as well as adding their tests to 'make check-block SPEED=thorough'
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   docs/devel/testing/main.rst    | 4 ++--
> >   tests/qemu-iotests/meson.build | 4 +++-
> >   2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> > index ec29cf7708..910ec11ab4 100644
> > --- a/docs/devel/testing/main.rst
> > +++ b/docs/devel/testing/main.rst
> > @@ -235,8 +235,8 @@ formats. The most comprehensive test plan can be run by defining
> >   ``SPEED=thorough``, which enables all available tests for every format.
> >   This set of formats currently enabled for make integration are
> 
> Should we change the wording now to "formats/protocols" since "luks" is
> rather a protocol than a format?

Actually 'luks' is a format, but 'nbd' is a protocol.

> 
> > -``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``, ``vhdx``,
> > -``vmdk``, and ``vpc``.
> > +``luks``, ``nbd``, ``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``,
> > +``vhdx``, ``vmdk``, and ``vpc``.
> >   Each of formats also has its own dedicated make target, named
> >   ``make check-block-$FORMAT`` which will run all available tests for
> > diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> > index 66b09d6b97..744d0b6e88 100644
> > --- a/tests/qemu-iotests/meson.build
> > +++ b/tests/qemu-iotests/meson.build
> > @@ -15,12 +15,14 @@ qemu_iotests_env = {'PYTHON': python.full_path()}
> >   qemu_iotests_formats = {
> 
> And change it to "qemu_iotests_blockdrivers" (or just "blockdrivers") now?

Yes, I'll do this renaming in docs/makefiles/meson in a separate commit,
using 'driver' as a generic term to cover either protocols or formats.

> 
> >     'qcow2': 'quick',
> >     'raw': 'slow',
> > +  'luks': 'thorough',
> > +  'nbd': 'thorough',
> >     'parallels': 'thorough',
> >     'qed': 'thorough',
> >     'vdi': 'thorough',
> >     'vhdx': 'thorough',
> >     'vmdk': 'thorough',
> > -  'vpc': 'thorough'
> > +  'vpc': 'thorough',
> >   }
> >   foreach k, v : emulators
> 
>  Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


