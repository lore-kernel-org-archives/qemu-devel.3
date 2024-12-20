Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB5E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOf1j-00010s-E1; Fri, 20 Dec 2024 10:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOf1d-0000zM-U9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:34:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOf1b-00025w-Nj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734708885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=neVZ7zkHbz4pgFGchp35AQbrwZtOVUVfwpEpSsb/AN4=;
 b=Ydp7yHCCRK+bRsxW0EmksTanFHmqMKVdv8vVYvNtoNApBz0AemfQ5NKsRxFtMq2Ef1fNVk
 2/z9U+T2x7GMxtcGjLAwOdTnqSZMD3SWYCjtOEFrwkgGNQrmD7q5ZR71O1L84Tc3LJAgeG
 cyIcZznuu6hyp/SgRjo8q01O1A5F0tc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-zhO-gcftOtqXjUHi53Ip1g-1; Fri,
 20 Dec 2024 10:34:42 -0500
X-MC-Unique: zhO-gcftOtqXjUHi53Ip1g-1
X-Mimecast-MFC-AGG-ID: zhO-gcftOtqXjUHi53Ip1g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 144DE1955F3B; Fri, 20 Dec 2024 15:34:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9329719560A2; Fri, 20 Dec 2024 15:34:36 +0000 (UTC)
Date: Fri, 20 Dec 2024 15:34:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2WOiKDOOIwEkg15@redhat.com>
References: <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n>
 <875xngvgwe.fsf@suse.de> <Z2NHBQc9ixuvJ3k_@x1n>
 <8734ijvg2q.fsf@suse.de> <Z2Ra7c7svRVbYw1k@x1n>
 <87wmfvtqpz.fsf@suse.de> <Z2WKzdDIyiSCHI9f@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2WKzdDIyiSCHI9f@x1n>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

On Fri, Dec 20, 2024 at 10:18:37AM -0500, Peter Xu wrote:
> On Thu, Dec 19, 2024 at 04:31:04PM -0300, Fabiano Rosas wrote:
> > We shouldn't change stuff that's also used by the rest of the
> > community. People know about QEMU_TEST_FLAKY_TESTS and -m slow. These
> > must continue to work the same.
> 
> I see what I overlook; it's used much more than I thought in qtest and we
> also have a CI for it.. So ok, let's keep at least QEMU_TEST_FLAKY_TESTS.
> 
> But again, I don't think it matters much even if we rename it, it means the
> flaky CI test won't run these two migration tests, but that's not the end
> of the world either, if you see what I meant.  CI relies on the normal
> tests rather than flaky tests to present.
> 
> We should be able to move in / take out FLAKY tests at will, as that's not
> what CI is really relying on.  Here renaming the macro in migration test
> almost means we take both ou.t

Side-note - QEMU_TEST_FLAKY_TESTS is something we should apply
consistently across all types of tests - unit, qtest, functional,
and across all environments - CI and local developer execution.

In recent changes to functional testing, I've set the expectation[1]
that any use of QEMU_TEST_FLAKY_TESTS *must* be accompanied by a
link to the gitlab.com/qemu/qemu-project  issue that describes
the flaky behaviour seen. We've got too many places with flaky
tests where we don't quiet remember what was flaky, so don't
know if we can remove it or not

With regards,
Daniel

[1]https://gitlab.com/qemu-project/qemu/-/blob/master/tests/functional/qemu_test/decorators.py?ref_type=heads#L42

-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


