Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0C7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlSd-0005ny-O4; Tue, 16 Jul 2024 12:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTlSW-0005KY-6s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTlSS-0003wM-QF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721148919;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RopYr7yi/z3GdeENqtiGj0imSU52iJDDPNaCrpzk7b4=;
 b=LwunfCDJayyilgWRVMAiB5ZnKqEWsAT5bpA7rcMYhkjZeqTIFwcUpwjH7BbJfB0uzMqQF5
 vO9bxTr2vIgVQPLkdgoOUVDGny7Y5LGcJp2pArp5QGPxIK4fgdkxYp7MyjU/nYISJXs9Ej
 d6+mxKTtL+GlwRczV94FaDoWSJta//4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-BvVv6h9CPfKrgJ_D5QMUIg-1; Tue,
 16 Jul 2024 12:55:18 -0400
X-MC-Unique: BvVv6h9CPfKrgJ_D5QMUIg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0641955D48; Tue, 16 Jul 2024 16:55:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 215FA1955F6B; Tue, 16 Jul 2024 16:55:12 +0000 (UTC)
Date: Tue, 16 Jul 2024 17:55:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 04/11] tests/functional: Add python-based tests to the
 meson build system
Message-ID: <Zpal7fNcmV8A47BO@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <20240716112614.1755692-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716112614.1755692-5-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 16, 2024 at 01:26:07PM +0200, Thomas Huth wrote:
> Integrate the new python-based test framework with the meson build
> system. Since these tests now require the pycotap module, make
> sure that it gets installed in the venv.
> 
> The changes to the meson.build files are partly based on an earlier
> patch by Ani Sinha (but heavily modified by Thomas Huth e.g. to use
> pycotap for running the tests instead).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pythondeps.toml              |  3 +-
>  tests/Makefile.include       | 18 ++++++++-
>  tests/functional/meson.build | 75 ++++++++++++++++++++++++++++++++++++
>  tests/meson.build            |  1 +
>  4 files changed, 95 insertions(+), 2 deletions(-)
>  create mode 100644 tests/functional/meson.build

Strictly speaking this patch probably ought to be #2, otherwise we
have a bisection window where we've converted some tests but not
run them.

> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index f6e590fdd8..c018b4d74a 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -26,9 +26,10 @@ meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
>  sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }
>  sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
>  
> -[avocado]
> +[tests]
>  # Note that qemu.git/python/ is always implicitly installed.
>  # Prefer an LTS version when updating the accepted versions of
>  # avocado-framework, for example right now the limit is 92.x.
>  avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
>  pycdlib = { accepted = ">=1.11.0" }
> +pycotap = { accepted = ">=1.1.0" }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d39d5dd6a4..2bdf607977 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -9,6 +9,8 @@ check-help:
>  	@echo "Individual test suites:"
>  	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
>  	@echo " $(MAKE) check-qtest            Run qtest tests"
> +	@echo " $(MAKE) check-functional       Run python-based functional tests"
> +	@echo " $(MAKE) check-functional-TARG  Run functional tests for a given target"

We could increase whitespace by 2 to fit TARGET, or shorten all
cases to TGT ?

>  	@echo " $(MAKE) check-unit             Run qobject tests"
>  	@echo " $(MAKE) check-qapi-schema      Run QAPI schema tests"
>  	@echo " $(MAKE) check-block            Run block tests"
> @@ -111,7 +113,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>  

The above is a minor non-functional point though so

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


