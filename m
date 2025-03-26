Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9EDC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNP8-00021m-H4; Wed, 26 Mar 2025 05:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txNOz-0001pM-Fl
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txNOx-0005FO-5a
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742982621;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XC69/PXcasfu2XRbAVQuI7JxdMv3twLdmCgJ9msSHAA=;
 b=ZUt+BLbJBfiXaFDPttEJvUVNoxHpd8ZAMUjHwPXIdcyOlxQ+tzW6a76AXOtMXfc+ydCSE9
 jwh8CqRfleINVlvWqF3uKFbsUW2tFd6Dp6Bm05A3GBOvpwYGk0GEhfgUQJqykQxosUSqXJ
 uZWmqX9qCpBZnFUhGzZVCDJe/pu0dvA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-EfVDJxryOAayF0fvtcuumQ-1; Wed,
 26 Mar 2025 05:50:16 -0400
X-MC-Unique: EfVDJxryOAayF0fvtcuumQ-1
X-Mimecast-MFC-AGG-ID: EfVDJxryOAayF0fvtcuumQ_1742982615
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC82180882E; Wed, 26 Mar 2025 09:50:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D4C5180B487; Wed, 26 Mar 2025 09:50:13 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:50:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 14/15] gitlab-ci: Update QEMU_JOB_AVOCADO and
 QEMU_CI_AVOCADO_TESTING
Message-ID: <Z-PN0tip7DDurAVU@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-15-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325200026.344006-15-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 25, 2025 at 09:00:22PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since we don't run the Avocado jobs in the CI anymore, rename
> these variables to QEMU_JOB_FUNCTIONAL and QEMU_CI_FUNCTIONAL_TESTING.
> 
> Also, there was a mismatch between the documentation and the
> implementation of QEMU_CI_AVOCADO_TESTING: While the documentation
> said that you had to "Set this variable to have the tests using the
> Avocado framework run automatically", you indeed needed to set it
> to make the pipelines appear in your dashboard - but they were never
> run automatically in forks and had to be triggered manually. Let's
> improve this now: No need to hide these pipelines from the users
> by default anymore (the functional tests should be stable enough
> nowadays), and rather allow the users to run the pipelines auto-
> matically with this switch now instead, as was documented.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/devel/testing/ci-jobs.rst.inc  | 19 +++++++++----------
>  .gitlab-ci.d/base.yml               |  8 ++------
>  .gitlab-ci.d/buildtest-template.yml |  2 +-
>  3 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
> index 3756bbe3554..4f4c96dd883 100644
> --- a/docs/devel/testing/ci-jobs.rst.inc
> +++ b/docs/devel/testing/ci-jobs.rst.inc
> @@ -126,10 +126,10 @@ QEMU_JOB_PUBLISH
>  The job is for publishing content after a branch has been
>  merged into the upstream default branch.
>  
> -QEMU_JOB_AVOCADO
> -~~~~~~~~~~~~~~~~
> +QEMU_JOB_FUNCTIONAL
> +~~~~~~~~~~~~~~~~~~~
>  
> -The job runs the Avocado integration test suite
> +The job runs the functional test suite
>  
>  Contributor controlled runtime variables
>  ----------------------------------------
> @@ -149,13 +149,12 @@ the jobs to be manually started from the UI
>  Set this variable to 2 to create the pipelines and run all
>  the jobs immediately, as was the historical behaviour
>  
> -QEMU_CI_AVOCADO_TESTING
> -~~~~~~~~~~~~~~~~~~~~~~~
> -By default, tests using the Avocado framework are not run automatically in
> -the pipelines (because multiple artifacts have to be downloaded, and if
> -these artifacts are not already cached, downloading them make the jobs
> -reach the timeout limit). Set this variable to have the tests using the
> -Avocado framework run automatically.
> +QEMU_CI_FUNCTIONAL_TESTING

Both old and new terms are quite verbose, how about
dropping '_TESTING' suffix ?


With, or without that rename though:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


