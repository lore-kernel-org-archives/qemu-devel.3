Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE5606A333
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yx+Es522
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMas-0002Po-8j; Tue, 17 Nov 2026 12:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTMah-0002EL-Af
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTMae-0006Vz-Ev
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QZge9sBmImQcyj4+1A6/s/1jKPxn7X3lgBJGbEpTLxA=;
 b=Yx+Es522bjkt1NyazYAM+StEz0q96Q1Mg4z1hhKzUr34OK6ZHByXIRtHWo6LRkBMlod0Cj
 m41dsMZVDWbN1Aodpt77xR7DruAQ0GqGE080aHOzOKJah4H9BGM4AfAUURp8JT4T8o6rfl
 jIRdvMxYhXqB0kw2rHjOScVNw7nUz4A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-aTbItQJ9PzSoSKdXJNNsoQ-1; Tue,
 17 Nov 2026 12:03:21 -0500
X-MC-Unique: aTbItQJ9PzSoSKdXJNNsoQ-1
X-Mimecast-MFC-AGG-ID: aTbItQJ9PzSoSKdXJNNsoQ_1794935000
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E21418002FD; Tue, 17 Nov 2026 17:03:20 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A771E18011D4; Tue, 17 Nov 2026 17:03:18 +0000 (UTC)
Date: Tue, 17 Nov 2026 17:03:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] tests/docker/dockerfiles/release: use full registry name
 for image
Message-ID: <avyI084uxF7pMh0-@redhat.com>
References: <20261116232311.2761545-1-pierrick.bouvier@oss.qualcomm.com>
 <avwNg95uYe_vgWH5@redhat.com>
 <00c0e48d-4186-44de-a078-a69586201211@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00c0e48d-4186-44de-a078-a69586201211@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 09:01:26AM -0800, Pierrick Bouvier wrote:
> On 11/17/2026 12:17 AM, Daniel P. Berrangé wrote:
> > On Mon, Nov 16, 2026 at 04:23:11PM -0700, Pierrick Bouvier wrote:
> >> By default, podman does not have docker.io preconfigured as default
> >> registry, so building fails.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  tests/docker/dockerfiles/release.docker | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
> >> index ca6babde01e..a606eb5ee79 100644
> >> --- a/tests/docker/dockerfiles/release.docker
> >> +++ b/tests/docker/dockerfiles/release.docker
> >> @@ -1,6 +1,6 @@
> >>  ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
> >>  
> >> -FROM ubuntu:$UBUNTU_VERSION AS build
> >> +FROM docker.io/ubuntu:$UBUNTU_VERSION AS build
> > 
> > How about docker.io/library/ubuntu  to match our ubuntu2404.docker ?
> >
> 
> Sounds good to me, it's the same image behind the hoods and it's more
> consistent.

With that changed, consider it to have

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


