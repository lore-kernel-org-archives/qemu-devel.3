Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FF606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=atKf9G5Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHpL-0005CD-Bp; Mon, 26 Oct 2026 06:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLHpJ-0005Bs-AA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLHpH-0002HZ-Hb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793010070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kj38U3+aHGfXwuccz3N/+yG/lmzCVRS8MKf8T8tHuUg=;
 b=atKf9G5Zfe9+9IAV7NIzDA4dcEJzxtxqnaob6fzlziwTiDqvWi7KbyT+0OHeBH9Pi/WGRk
 /f6s0j61aW6yTjTLKhSA4h/sW8Ghsh3G+Y18u/HO3KiQMPaNt72wS4wWtx+549CkJqMbjU
 l4moSSTKmpa46VIg3UVgpb7DiSNNm90=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-m16k6J5hNiqIeCDhQ0aRbA-1; Mon,
 26 Oct 2026 06:21:08 -0400
X-MC-Unique: m16k6J5hNiqIeCDhQ0aRbA-1
X-Mimecast-MFC-AGG-ID: m16k6J5hNiqIeCDhQ0aRbA_1793010067
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A613618005B8; Mon, 26 Oct 2026 10:21:07 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 773CA1803A4D; Mon, 26 Oct 2026 10:21:06 +0000 (UTC)
Date: Mon, 26 Oct 2026 10:21:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: Add a target to run all tests in thorough mode
Message-ID: <at8pj6S3tBVoRdkf@redhat.com>
References: <20261026093034.516604-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261026093034.516604-1-thuth@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 10:30:34AM +0100, Thomas Huth wrote:
> "make check SPEED=thorough" is a little bit clunky to type and many
> people are not aware of this nice possibility to run almost all test
> in parallel this way. So add a "check-thorough" target that makes this
> way of running the tests a little bit more accessible.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 9f82552ab54..d9d2b7ef13b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -4,6 +4,7 @@
>  check-help:
>  	@echo "Regression testing targets:"
>  	@echo " $(MAKE) check                         Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
> +	@echo " $(MAKE) check-thorough                Download assets and run almost all non-flaky tests"
>  	@echo " $(MAKE) bench                         Run speed tests"
>  	@echo
>  	@echo "Individual test suites:"
> @@ -46,10 +47,13 @@ FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$
>  $(FUNCTIONAL_TARGETS):
>  	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
>  
> -.PHONY: check-functional
> -check-functional:
> +.PHONY: check-functional-precache
> +check-functional-precache:
>  	@$(NINJA) precache-functional
>  	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
> +
> +.PHONY: check-functional
> +check-functional: check-functional-precache
>  	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
>  
>  .PHONY: check-func check-func-quick
> @@ -57,9 +61,12 @@ check-func check-func-quick:
>  
>  # Consolidated targets
>  
> -.PHONY: check check-clean
> +.PHONY: check check-thorough check-clean
>  check:
>  
> +check-thorough: check-functional-precache
> +	$(MAKE) check SPEED=thorough QEMU_TEST_NO_DOWNLOAD=1

I'm not understanding why this commit has the refactoring present
too ? Wasn't it enough to do

 +check-thorough:
 +	$(MAKE) check SPEED=thorough

the precaching download would just do the right thing already


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


