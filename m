Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE06C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNEN-00011I-B3; Fri, 26 Jan 2024 09:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rTNEL-00010u-Uu
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rTNEK-0007Sv-7B
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706279450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nKHD/wFbH3E0xSEigh67bpua9N6LxO15eYolruFuu48=;
 b=P2C82riVwvc/VbSac7u1NWclplmUNKdRqAobxvfYEEpduDWxA9URyPfdZasnPhZP3vJECm
 PIRUsA8AkzkBTjjOGB9j3jxN10pZK0tvQ7kmzBjGVEt/lKupxJkVAhUAZ2ihRfckJ9jYJ8
 3lIdQmInPcXdoXSsPsHSCe1U2M0jya8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-It3YcU1sOWSWrU4YaItpwA-1; Fri,
 26 Jan 2024 09:30:47 -0500
X-MC-Unique: It3YcU1sOWSWrU4YaItpwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC3071C05198;
 Fri, 26 Jan 2024 14:30:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 140212166B32;
 Fri, 26 Jan 2024 14:30:45 +0000 (UTC)
Date: Fri, 26 Jan 2024 14:30:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de,
 armbru@redhat.com
Subject: Re: [PATCH] Make 'uri' optional for migrate QAPI
Message-ID: <ZbPCExBqdWqAwbUh@redhat.com>
References: <20240123064219.40514-1-het.gala@nutanix.com>
 <Za93I-50U745B27C@redhat.com> <ZbBrN-V8goSJxEst@x1n>
 <5fa6f674-a08f-45e7-a89f-028d91c6b8f9@nutanix.com>
 <238e2577-931a-418d-8af3-b1461e7b126c@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <238e2577-931a-418d-8af3-b1461e7b126c@nutanix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 26, 2024 at 07:40:12PM +0530, Het Gala wrote:
> Hi everyone, I was trying to wrap around on how to write a migration test or to mock migration.
> I see there are a couple of migration tests already written, but most of them focuses on just getting the uri and parsing uri to start the migration.
> I have a couple of questions for starters like me who is attempting to write test cases for the first time:
> 
> 1. Do I need to make a whole new test or just edit one of the tests that is using uri, and instead send in 'MigrateChannel' struct and parse the necessary information out of it ?

I think this option is best. We have two code paths - 'uri' and
'MigrateChannel', we we just need coverage of that new path.
So modifying some of the existing test cases to use MigrateChannel
gives us that coverage without harming existing coverage. This is
more time efficient than adding extra tests.

> 2. Do I need to add tests for unix, fd too with the modified syntax ?

I don't think so. When using the legacy 'uri' syntax (which all tests
already do), we convert to MigrateChannel internally, then the rest
of migration uses the MigrateChannel.  IOW, we already have coverage
of unix/fd/etc.

All we're lacking is validation that the very first entrypoint allows
MigrateChannel. We can prove that with a single test that uses
MigrateChannel

> 3. Do I also need to add test to ensure - uri and channels both
> cannot be used simultaneously ? (based on the above patch)

Yes, its a worthwhile sanity check. There are a few intentional
failure tests in migrate-test.c.

> 4. Is there updated document in Qemu to follow latest practices on how to write migration tests?

Not that I know of

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


