Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BDAE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9cU-0004he-Jz; Thu, 05 Dec 2024 06:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJ9cR-0004gn-IN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:02:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJ9cP-0004Qn-Lb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733396519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8adr/iyeAQFSsFAOIvJLAH4Xy7EOQqN+mPaOlAMqwjI=;
 b=KxPQGyE1y4xGjurztAUMA8D//aAA2MW9U5zhYvu0AHkU3Tq1206Hj+/At3b4sc2Nduuh4k
 8NTw8tuoR2a1siuAszEEYWY14lqbG7onbuijvAw4JhpdKlFQ/8mlXJZ8wpa/X1zAybzV7G
 XEvcRUJDGZ8QqxSssU+yQow5I7xCgbI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-caND1oDRNIiVcKssVpQCoA-1; Thu,
 05 Dec 2024 06:01:57 -0500
X-MC-Unique: caND1oDRNIiVcKssVpQCoA-1
X-Mimecast-MFC-AGG-ID: caND1oDRNIiVcKssVpQCoA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FB8719560A7; Thu,  5 Dec 2024 11:01:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23FD319560AD; Thu,  5 Dec 2024 11:01:52 +0000 (UTC)
Date: Thu, 5 Dec 2024 11:01:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/7] gitlab: purge build files from cirrus CI jobs
Message-ID: <Z1GIHXE7xzxNWncf@redhat.com>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-5-berrange@redhat.com>
 <a41bb572-6bf1-4972-8223-22677a21b864@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a41bb572-6bf1-4972-8223-22677a21b864@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 05, 2024 at 11:55:00AM +0100, Thomas Huth wrote:
> On 04/12/2024 20.48, Daniel P. Berrangé wrote:
> > Uploading artifacts in Cirrus CI requires sufficient disk space to
> > create a tarball of the artifact files. IOW, whatever size the
> > artifacts are, double that. This results in space pressure on the
> > FreeBSD jobs due to limited disk size. Purging the .o files from
> > the meson build directory reclaims significant space.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   .gitlab-ci.d/cirrus/build.yml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
> > index 9983ab0690..d26a2a788c 100644
> > --- a/.gitlab-ci.d/cirrus/build.yml
> > +++ b/.gitlab-ci.d/cirrus/build.yml
> > @@ -37,6 +37,7 @@ build_task:
> >         do
> >           $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=1 ;
> >         done
> > +    - find . -not -path 'meson-logs/*' -delete
> 
> I'm not sure, but this might cause trouble if you run the Cirrus-CI job with
> terminal access for testing the binaries manually after the build succeeded?
> Maybe it would be better to just kill the .o files and leave the rest
> around?

Hmm, awkward, yes. I'll try and finese this a bit to just .o files and
see how it works out.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


