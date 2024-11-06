Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE88D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fET-0000LA-Ja; Wed, 06 Nov 2024 07:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fER-0000Kr-LR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8fEP-0006yV-93
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730896431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IO4nlZ6s1n3xt6RwATVUcayq/uzIrzBm8DYn1oeNtWI=;
 b=QSCsa1o2RXIJ4adQmnR2ZSVtjMc8vVgp3sLn2fPnlj1GQ69k3q3q1SWc2jryJIYUffTDMr
 nOV96eL3fWoVKVY85U95YN/k0ZpOrToUXZRDyudsx5pDIKQsfIf5N55j1yOtw/RBTiz9Rr
 W3b3dRUxakiRGinDfsmJj1ALuGi1KG4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-ux7ePtWGM8WQQghVycA1xQ-1; Wed,
 06 Nov 2024 07:33:48 -0500
X-MC-Unique: ux7ePtWGM8WQQghVycA1xQ-1
X-Mimecast-MFC-AGG-ID: ux7ePtWGM8WQQghVycA1xQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B2EE1954B22; Wed,  6 Nov 2024 12:33:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.180])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682A51955F42; Wed,  6 Nov 2024 12:33:43 +0000 (UTC)
Date: Wed, 6 Nov 2024 12:33:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 11/22] tests/qtest/migration: Move common test code
Message-ID: <ZytiJKjygOQyruy6@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-12-farosas@suse.de>
 <ZytNb_nTrePsYabA@redhat.com> <87ttck1rbj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttck1rbj.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 06, 2024 at 09:26:24AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Nov 05, 2024 at 03:08:26PM -0300, Fabiano Rosas wrote:
> >> Put the common test code in a separate file. Leave only individual
> >> test functions and their static helpers in migration-test.c.
> >> 
> >> This moves the shared:
> >> 
> >>  test_postcopy_common
> >>  test_postcopy_recovery_common
> >>  test_precopy_common
> >>  test_file_common
> >>  migrate_precopy_tcp_multifd_start_common
> >>  migrate_start
> >>  migrate_end
> >>  migration_get_env
> >>  migration_env_clean
> >> 
> >> and some of their static helpers to migrate-common.c.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/meson.build                  |    1 +
> >>  tests/qtest/migration-test.c             | 1124 +---------------------
> >>  tests/qtest/migration/bootfile.c         |    2 +-
> >>  tests/qtest/migration/bootfile.h         |    2 +-
> >>  tests/qtest/migration/migration-common.c |  963 ++++++++++++++++++
> >>  tests/qtest/migration/migration-common.h |  214 ++++
> >>  tests/qtest/migration/migration-util.h   |   13 -
> >
> > Looking at these I guess I'd ask the question of what is the rule for
> > deciding whether to put something in -common vs in -util ?
> >
> > Both names sounds like being a general "bag of bits", so it isn't
> > obvious to me what their distinct roles are.
> >
> 
> The idea was to make -util the general bag of bits just like
> migration-helpers is currently.
> 
> -common should be the more "important" migration-specific functions,
> code that we spend more time reading and that are actually responsible
> for the results of the tests. Consider:
> 
> static void test_multifd_file_mapped_ram_fdset_dio(void)
> {
>     ...
>     if (!probe_o_direct_support(tmpfs)) {          <--- just a helper
>         g_test_skip("Filesystem does not support O_DIRECT");
>         return;
>     }
> 
>     test_file_common(&args, true);  <--- actually doing the heavy-lifting
> }
> 
> We could to some renaming and restructuring, but I think the distinction
> is important. We already have it today, what is -common is all stuffed
> into migration-test.c and the rest is in migration-helpers.c.

Ah ok, perhaps "migration/test-framework.{c,h}" is a more descriptive
name for this ?

> 
> >>  7 files changed, 1193 insertions(+), 1126 deletions(-)
> >>  create mode 100644 tests/qtest/migration/migration-common.c
> >>  create mode 100644 tests/qtest/migration/migration-common.h
> >> 
> >
> > With regards,
> > Daniel
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


