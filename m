Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49EDCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPcQ6-0006E6-HN; Wed, 20 May 2026 04:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPcPx-0006Cn-Re
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPcPv-0005Mr-FM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 04:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779266198;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJS8jOsbVVSlM2g66dml8EQpmiVb/KHAoaVAa6gTrCU=;
 b=ew6Np4HK9jP4/twS+wX8fT3bHu3sPm9fLR4owiZgHxf1rYoTr4ict4w5g1JbqqmSgGnuF6
 4SgJO5qIYuZT4T+i48O7s3KIZqThMFooYdNOUfaFF0EJww5z58bafuDN9q8/SSzjABEXSN
 5rapN1aeySyBASf82wCgSijBNrCwQO4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-YHxKpuH4OxyM5Ixh1dXICw-1; Wed,
 20 May 2026 04:36:35 -0400
X-MC-Unique: YHxKpuH4OxyM5Ixh1dXICw-1
X-Mimecast-MFC-AGG-ID: YHxKpuH4OxyM5Ixh1dXICw_1779266194
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05506195605E; Wed, 20 May 2026 08:36:34 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.211])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9FB218004A3; Wed, 20 May 2026 08:36:30 +0000 (UTC)
Date: Wed, 20 May 2026 09:36:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PULL 00/28] Misc patchesfor python, iotests, qom, crypto & io
Message-ID: <ag1yi9pz6RRdby93@redhat.com>
References: <20260519125153.1015315-1-berrange@redhat.com>
 <CAJSP0QXQgmWB9bH_Bc2jYDk_=v0oF55crwQD-qV--8u_Uc8iUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXQgmWB9bH_Bc2jYDk_=v0oF55crwQD-qV--8u_Uc8iUg@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, May 19, 2026 at 01:19:27PM -0400, Stefan Hajnoczi wrote:
> On Tue, May 19, 2026 at 8:52 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The following changes since commit ac6721b88df944ade0048822b2b74210f543d656:
> >
> >   Merge tag 'vhost-user-rtc-pr-1' of https://gitlab.com/epilys/qemu into staging (2026-05-16 17:37:33 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
> >
> > for you to fetch changes up to d92ae44c28906a219e4c8e4ee8929e5fcfb2d32c:
> >
> >   qom: drop user_creatable_add_type method (2026-05-18 18:23:34 +0100)
> >
> > ----------------------------------------------------------------
> > Misc patches for python, iotests, qom, crypto & io
> >
> >  * Bump python-qemu-qmp to 0.6.0
> >  * Fix client side anoymous TLS credentials
> >  * Fix return value semantics for qio_channel_flush
> >  * Add ID validation of internal QOM constructor
> >  * Fix ability to create internal QOM objects
> >    without a parent
> >  * Merge user creatable object constructor into
> >    main QOM file
> >  * Print reason for skipping I/O tests
> >  * Remove redundant meson suits for I/O tests
> >  * Add I/O tests in meson for NBD and LUKS
> >  * Expose make targets for all block driver I/O tests
> >  * Run I/O tests for 10 block drivers in GitLab CI
> >  * Fix sudo check for LUKS I/O test
> >  * Mark I/O test 185 as flaky
> >  * Ensure stable sorting for mtest2make output
> >
> > ----------------------------------------------------------------
> 
> The following vfio_user_client tests are failed:
> https://gitlab.com/qemu-project/qemu/-/jobs/14442956771
> https://gitlab.com/qemu-project/qemu/-/jobs/14442956762
> https://gitlab.com/qemu-project/qemu/-/jobs/14442956764
> 
> Please take a look. The tests passed when I dropped your pull request
> from the staging tree, but I'm not sure what caused the failures.

The cause is that the vfio-user code did not use a well formed
ID when creating an iothread from its internal code, and the
internal QOM APIs failed to validate a wellformed ID until a
patch in this series.

The (trivial) fix for this pull is this patch:

  https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04931.html

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


