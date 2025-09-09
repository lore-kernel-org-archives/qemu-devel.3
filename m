Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079C8CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvsPT-0001aE-1N; Tue, 09 Sep 2025 03:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvsPN-0001ZV-JL
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvsPF-00080W-JO
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757401480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TrwfGYzjGJI2AK3S457RqJ8AszdG43B482ek2jpZAg=;
 b=BLVkchFH+1woDjnvnhLgjn0tvNueWveEELfhqDwFwh/RLLSVBo9N/SJ34jJcB7V2s/0P97
 qAP9JcVqyVpqxmN4NAgttTfcLZbZShhoyrL83XEtAP7nDdcOY8ibk8C/wPWWbRNqaRw3By
 uH7rZTa5ZPdLhyT2o0cUZotRomGBynM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-BcQxbDpePO2PoU3OmOyuBQ-1; Tue,
 09 Sep 2025 03:04:36 -0400
X-MC-Unique: BcQxbDpePO2PoU3OmOyuBQ-1
X-Mimecast-MFC-AGG-ID: BcQxbDpePO2PoU3OmOyuBQ_1757401475
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36B15180048E; Tue,  9 Sep 2025 07:04:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EE531800446; Tue,  9 Sep 2025 07:04:33 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:04:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 4/4] gitlab: prevent duplicated meson log artifacts in
 test jobs
Message-ID: <aL_QzBYYd4HB0T3Q@redhat.com>
References: <20250908190901.3571859-1-berrange@redhat.com>
 <20250908190901.3571859-5-berrange@redhat.com>
 <87v7ls7i8t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7ls7i8t.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 10:21:38PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The build jobs will populate build/meson-logs/ with various files
> > that are added as artifacts.
> >
> > The test jobs preserve the state of the build jobs, so we must
> > delete any pre-existing logs to prevent confusion from duplicate
> > artifacts.
> 
> Will this cause us to rebuild needlessly?

These files aren't involved in any rebuild / stale checks &
the test pipeline I ran show no difference in what was done.

> 
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest-template.yml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> > index 308490a35a..d866cb12bb 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -83,6 +83,10 @@
> >  
> >  .native_test_job_template:
> >    extends: .common_test_job_template
> > +  before_script:
> > +    # Prevent logs from the build job that run earlier
> > +    # from being duplicated in the test job artifacts
> > +    - rm -f build/meson-logs/*
> >    artifacts:
> >      name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
> >      when: always
> > @@ -111,6 +115,9 @@
> >    before_script:
> >      - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
> >      - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
> > +    # Prevent logs from the build job that run earlier
> > +    # from being duplicated in the test job artifacts
> > +    - rm -f build/meson-logs/*
> >    after_script:
> >      - cd build
> >      - du -chs ${CI_PROJECT_DIR}/*-cache
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


