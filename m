Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AE9C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnx1b-0003mG-P1; Fri, 28 Feb 2025 04:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnx1T-0003kr-Qj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnx1P-0006rQ-Km
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740736265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWxh5CDNOodxI7bBIyc167ogFwP8R+dZZQuc8tUXzQs=;
 b=IYEO5ecmJXTjfisuzfYJZSAsQBqNM8MRSFilPQFpAKCj9A2wGiVZqSsu7BR9VVwP55T3jQ
 woe9i/KBEY/GVwlGHPsB1iIVIEg9r+viSiQJJru1FPAssYfKoUJcYgBhfVcyTg7P/Az9HB
 rAI90KMnpW9QUmvJZdEH2RA8j+8JSVg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-tl6TZSvWMoWy1CK-x2IKcA-1; Fri,
 28 Feb 2025 04:51:00 -0500
X-MC-Unique: tl6TZSvWMoWy1CK-x2IKcA-1
X-Mimecast-MFC-AGG-ID: tl6TZSvWMoWy1CK-x2IKcA_1740736259
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED97D1801A10; Fri, 28 Feb 2025 09:50:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5AEB1800359; Fri, 28 Feb 2025 09:50:56 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:50:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] tests/functional: skip test if QEMU_TEST_QEMU_BINARY
 is not set
Message-ID: <Z8GG_dcCqo8_X4RR@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-2-berrange@redhat.com>
 <a90b4f1f-8581-4647-9145-e52fc14ac604@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a90b4f1f-8581-4647-9145-e52fc14ac604@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06, 2025 at 10:01:45AM +0100, Thomas Huth wrote:
> On 05/02/2025 16.59, Daniel P. Berrangé wrote:
> > If QEMU_TEST_QEMU_BINARY is not set we currently assert in the setUp
> > function, resulting in a big traceback:
> > 
> >      TAP version 13
> >      Traceback (most recent call last):
> >        File "/var/home/berrange/src/virt/qemu/tests/functional/qemu_test/testcase.py", line 280, in setUp
> >          super().setUp('qemu-system-')
> >          ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^
> >        File "/var/home/berrange/src/virt/qemu/tests/functional/qemu_test/testcase.py", line 196, in setUp
> >          self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
> >          ~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >      AssertionError: unexpectedly None : QEMU_TEST_QEMU_BINARY must be set
> > 
> >      not ok 1 test_ppc_405.Ppc405Machine.test_ppc_ref405ep
> >      1..1
> > 
> > For every other test pre-requisite that's missing we will mark the test
> > as skipped. This does the same for missing QEMU_TEST_QEMU_BINARY, such
> > that we get
> > 
> >      TAP version 13
> >      ok 1 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      ok 2 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_noapic_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      ok 3 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      ok 4 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      ok 5 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector_noapic # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      ok 6 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_novector_nomsi # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      ok 7 test_x86_64_kvm_xen.KVMXenGuest.test_kvm_xen_guest_vapic # SKIP QEMU_TEST_QEMU_BINARY env variable is not set
> >      1..7
> 
> Not sure whether this is the right approach, since a missing
> QEMU_TEST_QEMU_BINARY is a real error, and if we just skip, then the problem
> might go unnoticed if the user does not look closely.
> 
> But to ease the situation: We could maybe add some auto-detection logic that
> tries to guess the right qemu-system-$TARGET by looking at the file name of
> the test and/or the test function name? We already encode the target
> architecture in most of these... WDYT?

When the user provides a binary, a single binary applies to all tests,
so tests that don't match the binary get skipped. I think it would be
a bit wierd to auto-select a different binary per test.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


