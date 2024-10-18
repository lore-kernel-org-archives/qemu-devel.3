Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D7D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 16:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1paV-00035X-2g; Fri, 18 Oct 2024 12:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1paT-00035L-En
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1paR-0004Iu-4g
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 12:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729267941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFb22aFeFZKwSAP3hHjtLSDkSlgY5x2/d6eHUr7Eths=;
 b=BeaZeawHBX7vTubsYuLhxl0iRjuLi6kTDV8ol3gjyJnMGUjVWWKW7GFdH9GzRwB+I1P9Tp
 IiZMPgijdiQ5pUXxdvnGJCe70QnCtXzIo3mJ8s4x73CSrJQRczp9S/HKNe8mPbOKDh/2ry
 zcT4j7FnLuloq0SNDLlR5MwUL+N7kO4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-FZ8KCrhYPMi-MdziMFiR0w-1; Fri,
 18 Oct 2024 12:12:17 -0400
X-MC-Unique: FZ8KCrhYPMi-MdziMFiR0w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A0C71955F42; Fri, 18 Oct 2024 16:12:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4350019560AD; Fri, 18 Oct 2024 16:12:12 +0000 (UTC)
Date: Fri, 18 Oct 2024 17:12:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
Message-ID: <ZxKI2fYaveHJpHGO@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de>
 <ZxEl4zYgHLoLeHCT@redhat.com> <87r08e3d74.fsf@suse.de>
 <ZxIj694WqXwwMRIY@redhat.com>
 <CAFEAcA9eFApeeLBQvFC8zPNo+Ovk5woA5HKzaQ5j3=hd-G4smw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9eFApeeLBQvFC8zPNo+Ovk5woA5HKzaQ5j3=hd-G4smw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 18, 2024 at 04:25:07PM +0100, Peter Maydell wrote:
> On Fri, 18 Oct 2024 at 10:01, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Test reliability is a different thing. If a particular test is
> > flaky, it needs to either be fixed or disabled. Splitting into
> > a fast & slow grouping doesn't address reliability, just hides
> > the problem from view.
> 
> On the subject of 'flaky', here's another low-repeatability
> intermittent with migration-test that I just ran into in
> 'make vm-build-openbsd':
> 
> ▶  97/916 /ppc64/migration/multifd/tcp/plain/cancel
>            OK
> ▶  96/916 /i386/migration/precopy/tcp/tls/x509/allow-anon-client
>            OK
> ▶  97/916 /ppc64/migration/multifd/tcp/plain/zlib -
> ERROR:../src/tests/qtest/migration-helpers.c:322:check_migration_status:
> assertion failed (current_status != "failed"): ("failed" != "failed")
> FAIL
> ▶  97/916
>            ERROR
> ▶  95/916 /aarch64/migration/multifd/tcp/channels/plain/none
>            OK
>  97/916 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test
>            ERROR          134.38s   killed by signal 6 SIGABRT
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.
> **
> ERROR:../src/tests/qtest/migration-helpers.c:322:check_migration_status:
> assertion failed (current_status != "failed"): ("failed" != "failed")
> qemu-system-ppc64: Failed to connect to '127.0.0.1:24109': Address
> already in use

This is interesting, as I suspect it is a sign of a genuine portability
problem, as there are some subtle sockets binding differences between
Linux and *BSDs IIRC.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


