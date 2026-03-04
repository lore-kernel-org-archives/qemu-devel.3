Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30892EF8FEE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnY1-0000Bp-6S; Wed, 04 Mar 2026 09:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxnXz-0000B3-Bv
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxnXx-00051e-L3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772635796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nCfX8/uDriFVzrddpxX+Q097Lur+AGh43yIu0CDAdcs=;
 b=OV/6dRT8WAE1JdFEBeKGkijiG93POp3GEVVrkPqJcG9GZN+qC9AjfrqX7hdUtr1hXE2A2s
 Hz5HAxOc0UZShgAYmBIVIVMgOU383t8ucySqf/5kHBv6q0LYjWPNyqNcsMnLFQjDCLuTgS
 xpctbCFK176cVtrDrZS0B0Fp2LlRnnw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-31Dl-_kwMsOc9Fd9GpqAEg-1; Wed,
 04 Mar 2026 09:49:53 -0500
X-MC-Unique: 31Dl-_kwMsOc9Fd9GpqAEg-1
X-Mimecast-MFC-AGG-ID: 31Dl-_kwMsOc9Fd9GpqAEg_1772635792
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF3719560B7; Wed,  4 Mar 2026 14:49:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C66ED1800673; Wed,  4 Mar 2026 14:49:48 +0000 (UTC)
Date: Wed, 4 Mar 2026 14:49:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 01/15] gitlab: ensure all meson jobs capture
 build/meson-logs by default
Message-ID: <aahGiW04OBmEeEkg@redhat.com>
References: <20260304142120.2635617-1-berrange@redhat.com>
 <20260304142120.2635617-2-berrange@redhat.com>
 <9e25024a-59d8-408d-86fe-41f502effdec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e25024a-59d8-408d-86fe-41f502effdec@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

On Wed, Mar 04, 2026 at 03:45:55PM +0100, Thomas Huth wrote:
> On 04/03/2026 15.21, Daniel P. Berrangé wrote:
> > The build-without-defaults and build-tci jobs do not capture any
> > artifacts, despite running 'make check'. This has proved a repeated
> > bug with CI jobs, so introduce a new '.meson_job_template' rule
> > which always captures 'build/meson-logs'. Jobs can still provide
> > their own 'artifacts:' config which will override this default
> > behaviour.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest-template.yml | 30 ++++++++++++++++++-----------
> >   .gitlab-ci.d/buildtest.yml          |  4 +++-
> >   2 files changed, 22 insertions(+), 12 deletions(-)
> > 
> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> > index d866cb12bb..005058625e 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -1,5 +1,20 @@
> > -.native_build_job_template:
> > +
> > +# Any job running meson should capture meson logs
> > +# by default. Some jobs might override the artifacts
> > +# to capture further files
> > +.meson_job_template:
> >     extends: .base_job_template
> > +  artifacts:
> > +    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
> > +    when: always
> > +    expire_in: 7 days
> > +    paths:
> > +      - build/meson-logs
> > +    reports:
> > +      junit: build/meson-logs/*.junit.xml
> > +
> > +.native_build_job_template:
> > +  extends: .meson_job_template
> >     stage: build
> >     image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
> >     cache:
> > @@ -60,7 +75,7 @@
> >         - build/**/*.c.o.d
> >   .common_test_job_template:
> > -  extends: .base_job_template
> > +  extends: .meson_job_template
> >     stage: test
> >     image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
> >     script:
> > @@ -87,14 +102,7 @@
> >       # Prevent logs from the build job that run earlier
> >       # from being duplicated in the test job artifacts
> >       - rm -f build/meson-logs/*
> > -  artifacts:
> > -    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
> > -    when: always
> > -    expire_in: 7 days
> > -    paths:
> > -      - build/meson-logs
> > -    reports:
> > -      junit: build/meson-logs/*.junit.xml
> > +
> >   .functional_test_job_template:
> >     extends: .common_test_job_template
> > @@ -125,7 +133,7 @@
> >       QEMU_JOB_FUNCTIONAL: 1
> >   .wasm_build_job_template:
> > -  extends: .base_job_template
> > +  extends: .meson_job_template
> >     stage: build
> >     image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
> >     before_script:
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index 6ad3594522..4b20429c7f 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -652,7 +652,9 @@ build-tci:
> >   # Check our reduced build configurations
> >   build-without-defaults:
> > -  extends: .native_build_job_template
> > +  extends:
> > +    - .native_build_job_template
> > +    - .native_build_artifact_template
> 
> Why do we need native_build_artifact_template here?

Sigh, that's a leftover a previous iteration of the patch before I
decided to change the base job template. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


