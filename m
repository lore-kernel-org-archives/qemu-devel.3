Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B55CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDEK-0002yb-JT; Wed, 13 May 2026 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNDEI-0002xt-No
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNDEG-0006WO-Ul
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778692720;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbTaoKwn99zptftT2LWMiHCyvh7MqPdgGXhTORHFX5Y=;
 b=I/X8sDAF4yKctpNu+f9axAO6QOFyxILrtnyPTJz2/txRVpKkIvPVlIF6a+8FYlY0UPCdCp
 8fz7wxxNGcBEERoYbvISwWqk+UBn1zKtXuQxjqHoMFRUoT+YE9PrZfuOF97JmL6pAlT5Yk
 8YrIsErJ5uQQ7FshPxKirvwpD4IDmgI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-buZbUziaP06rQ6IEiyBjUA-1; Wed,
 13 May 2026 13:18:35 -0400
X-MC-Unique: buZbUziaP06rQ6IEiyBjUA-1
X-Mimecast-MFC-AGG-ID: buZbUziaP06rQ6IEiyBjUA_1778692711
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C3419560A1; Wed, 13 May 2026 17:18:31 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.213])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 080761800576; Wed, 13 May 2026 17:18:26 +0000 (UTC)
Date: Wed, 13 May 2026 18:18:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 15/16] gitlab: add jobs for thorough block tests
Message-ID: <agSyX4WuqV4jHq_M@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
 <20260513120003.226790-16-berrange@redhat.com>
 <7729d729-a0b5-43d4-ba25-1b734faea269@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7729d729-a0b5-43d4-ba25-1b734faea269@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 13, 2026 at 09:00:28AM -0700, Pierrick Bouvier wrote:
> On 5/13/2026 5:00 AM, Daniel P. Berrangé wrote:
> > CI is only exercising the qcow2 'auto' tests currently. As a result we
> > get no exposure of changes which cause regressions in other block format
> > drivers.
> > 
> > This adds new CI jobs for each block format, that will run the target
> > 'make check-block-$FORMAT'. The jobs are separate so that we have the
> > ability to make each format gating or not, depending on their level
> > of reliability.
> > 
> > The 'centos' image is used to run the I/O tests since several tests
> > have an implicit dependency on x86_64-softmmu, and thus break with
> > other architecture targets. The 'centos' build job is the only one
> > that creates the x86_64-softmmu target in CI. Ideally this target
> > portability in I/O tests would be fixed to avoid this limitation.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest.yml | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index 4b1949a3a5..cf0281ecd6 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -174,6 +174,24 @@ build-system-centos:
> >        x86_64-softmmu rx-softmmu sh4-softmmu
> >      MAKE_CHECK_ARGS: check-build
> >  
> > +
> > +# NB: block-XXX jobs use 'centos' since that is the build
> > +# job that provides the x86_64-softmmu.  Some I/O tests
> > +# are currently buggy and blindly assume characteristics
> > +# of x86 (such as PCIe) causing failures with other arches
> > +
> > +block:
> > +  extends: .native_test_job_template
> > +  needs:
> > +    - job: build-system-centos
> > +      artifacts: true
> > +  variables:
> > +    IMAGE: centos9
> > +    MAKE_CHECK_ARGS: "check-block-$FORMAT"
> > +  parallel:
> > +    matrix:
> > +      - FORMAT: [luks, nbd, parallels, qcow2, qed, raw, vdi, vhdx, vmdk, vpc]
> > +
> >  # Previous QEMU release. Used for cross-version migration tests.
> >  build-previous-qemu:
> >    extends: .native_build_job_template
> 
> All good!
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

BTW, the use of "matrix" for defining jobs had a slight impact on
the way the jobs results are presented. You only see an overall
status for the psuedo "block" job and have to click to reveal the
individual job results.  Not a problem, just a surprise if you've
not seen it before. An example is visible here:

https://gitlab.com/berrange/qemu/-/pipelines/2522062147


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


