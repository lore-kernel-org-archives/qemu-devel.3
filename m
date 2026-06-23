Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09376CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0xI-0002vY-FC; Tue, 23 Jun 2026 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc0xG-0002v4-Ja
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wc0xD-0003Dt-El
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782220453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MicaTRtfXpQLNYkC9KOFowZ1Oy+G+nrjeim7F+1m3EQ=;
 b=iiEkbMa7NWaPMeqOKTlnSjeoXO4M9zsnevjINh+3f2N0m7eFJPA0aAhB/dv3Q9F9+obGPh
 xDe0lwTDbBIaj8fsvg1pr97ypAv2yKHqSII5zvLMj/MFxbXGbmlTd5wg3V+8w08RPd08yV
 fx2/fJmLVIwIIzIP0NJg0dn8FuxG8Zk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-sXGu_ejjPGOsYEqUrthKgA-1; Tue,
 23 Jun 2026 09:14:09 -0400
X-MC-Unique: sXGu_ejjPGOsYEqUrthKgA-1
X-Mimecast-MFC-AGG-ID: sXGu_ejjPGOsYEqUrthKgA_1782220448
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1851C1955E74; Tue, 23 Jun 2026 13:14:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9C4819560A1; Tue, 23 Jun 2026 13:14:06 +0000 (UTC)
Date: Tue, 23 Jun 2026 14:14:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] gitlab: disable macOS jobs in forks
Message-ID: <ajqGm13E8eaRY81j@redhat.com>
References: <20260610091700.2772973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610091700.2772973-1-berrange@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Hi Alex,

Could you pick this one up for your CI queue ?

On Wed, Jun 10, 2026 at 10:17:00AM +0100, Daniel P. Berrangé wrote:
> The GitLab macOS runners are only available in Premium and Ultimate
> tier projects. This permits their use in QEMU upstream via the OSS
> Program membership perk, but this does not extend to forks of QEMU.
> The macOS jobs thus need to be disabled in forks, otherwise all
> pipelines will immediately report a failure due to inability to
> access a runner.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/base.yml              | 5 +++++
>  .gitlab-ci.d/macos.yml             | 2 ++
>  docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 72eadc8073..714d2ed8a6 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -52,6 +52,11 @@ variables:
>      - if: '$CI_PIPELINE_SOURCE == "schedule"'
>        when: never
>  
> +    # macOS jobs can't run in forks until gitlab opens up runner availability
> +    # to all tiers https://gitlab.com/groups/gitlab-org/-/work_items/8267
> +    - if: '$QEMU_JOB_MACOS == "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
> +      when: never
> +
>      # Publishing jobs should only run on the default branch in upstream
>      - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
>        when: never
> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
> index 8366b4ad56..84ad2492ca 100644
> --- a/.gitlab-ci.d/macos.yml
> +++ b/.gitlab-ci.d/macos.yml
> @@ -36,6 +36,7 @@ aarch64-macos-15-build:
>    extends: .macos_job_template
>    image: macos-15-xcode-16
>    variables:
> +    QEMU_JOB_MACOS: 1
>      NAME: macos-15
>      PATH_EXTRA: /opt/homebrew/gettext/bin
>      PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
> @@ -52,6 +53,7 @@ aarch64-macos-26-build:
>    extends: .macos_job_template
>    image: macos-26-xcode-26
>    variables:
> +    QEMU_JOB_MACOS: 1
>      NAME: macos-26
>      DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
>      PATH_EXTRA: /opt/homebrew/gettext/bin
> diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
> index d5b081978a..d747a7ad13 100644
> --- a/docs/devel/testing/ci-jobs.rst.inc
> +++ b/docs/devel/testing/ci-jobs.rst.inc
> @@ -125,6 +125,13 @@ QEMU_JOB_FUNCTIONAL
>  
>  The job runs the functional test suite
>  
> +QEMU_JOB_MACOS
> +~~~~~~~~~~~~~~
> +
> +The job requires access to the macOS shared runners, which are
> +only available to Premium/Ultimate tiers. This includes OSS project
> +members, but not forks.
> +
>  Contributor controlled runtime variables
>  ----------------------------------------
>  
> -- 
> 2.54.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


