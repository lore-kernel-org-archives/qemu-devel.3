Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83346D3CCAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggSg-0005UM-5Z; Fri, 16 Jan 2026 04:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggSe-0005T7-2u
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggSb-0008DV-TA
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768556978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KY2bnb7BNZZspLp9QE5AvaoIP7gTMQ/VGDElsSOC5dE=;
 b=OsS/7E7MSvhdZ6dCVPQdZgu7rs1EmBerMKDpmK/ObrNb5cx6Kh/u3YGJx6FpNZSHOA5ufw
 1MMHcaM//xEqzxqQYGPcNpZO1t37zL7Im5FEGwgYMZ/6jjeBsLMczBAyoVQ88uulghZMyg
 QVDvJnnw/9uhLG0hElbwBylhPBzStlQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-kMHkrMTKOTeMqNACIMYLwA-1; Fri,
 16 Jan 2026 04:49:35 -0500
X-MC-Unique: kMHkrMTKOTeMqNACIMYLwA-1
X-Mimecast-MFC-AGG-ID: kMHkrMTKOTeMqNACIMYLwA_1768556974
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF0FC195423A; Fri, 16 Jan 2026 09:49:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C8511955F6E; Fri, 16 Jan 2026 09:49:31 +0000 (UTC)
Date: Fri, 16 Jan 2026 09:49:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 14/14] gitlab: add jobs for thorough block tests
Message-ID: <aWoJqDykhCTyZHgZ@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
 <20260115164756.799402-15-berrange@redhat.com>
 <8a659ac3-e113-49c1-b83b-fd86690e3dbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a659ac3-e113-49c1-b83b-fd86690e3dbd@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 16, 2026 at 08:53:53AM +0100, Thomas Huth wrote:
> On 15/01/2026 17.47, Daniel P. Berrangé wrote:
> > CI is only exercising the qcow2 'auto' tests currently. As a result we
> > get no exposure of changes which cause regressions in other block format
> > drivers.
> > 
> > This adds new CI jobs for each block format, that will run the target
> > 'make check-block-$FORMAT'. The jobs are separate so that we have the
> > ability to make each format gating or not, depending on their level
> > of reliability.
> > 
> > There is currently an undiagnosed failure of job 185 with the qcow2 when
> > run in CI that is marked to be skipped, reported at:
> > 
> >    https://gitlab.com/qemu-project/qemu/-/issues/3270
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/buildtest.yml | 92 ++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 92 insertions(+)
> > 
> > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> > index dfe954fe3c..91b398bd63 100644
> > --- a/.gitlab-ci.d/buildtest.yml
> > +++ b/.gitlab-ci.d/buildtest.yml
> > @@ -176,6 +176,98 @@ build-system-centos:
> >         x86_64-softmmu rx-softmmu sh4-softmmu
> >       MAKE_CHECK_ARGS: check-build
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> One more though: I think we could then also remove the iotests from the
> "build-tcg-disabled" job since they should now be covered by this new job...
> WDYT?

Oh, I never noticed we had randomly stuffed a bunch of extra
iotests into that job ! That is redundant *provided* we can
indeed go forward with the new block-raw & block-qcow2 jobs
being gating jobs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


