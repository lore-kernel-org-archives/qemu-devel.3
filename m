Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9911BC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visns-0001Z0-HK; Thu, 22 Jan 2026 06:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1visnr-0001Y8-7f
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1visnp-0005G9-Ai
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769081080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NgMyyWJCfzd8YQ/Mm3GEt0/9k5YoUbFP0YSsx5ZSgg=;
 b=YhcbbhoIpwdx4XRU+px7IIXmetoA4Kq4t/BdqGS7CAmikjVxiQD83SCgWE2/YWfVLJaI15
 JLDGLJyYKoG5Wq+tewo+n4/mwqNXQmqXgwbapQe1Qhe/aBl+enGYzJPsvtP5JS92LRCbvw
 NbeNp/1C/Djq2mVtXryxsEXAFDShYdE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-7nFwJM6DOSO-uDud0z3tKQ-1; Thu,
 22 Jan 2026 06:24:36 -0500
X-MC-Unique: 7nFwJM6DOSO-uDud0z3tKQ-1
X-Mimecast-MFC-AGG-ID: 7nFwJM6DOSO-uDud0z3tKQ_1769081075
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AAC218003FC; Thu, 22 Jan 2026 11:24:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 648C31800109; Thu, 22 Jan 2026 11:24:27 +0000 (UTC)
Date: Thu, 22 Jan 2026 11:24:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aXII6EfQ3D4fkWLg@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <130b8f26-2369-48f5-bbd6-e27210707b9f@redhat.com>
 <aXIAmeEWMFjQM84o@redhat.com>
 <995d4aaf-bbff-42be-9114-1f04bb51e37c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <995d4aaf-bbff-42be-9114-1f04bb51e37c@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 22, 2026 at 12:05:14PM +0100, Thomas Huth wrote:
> On 22/01/2026 11.48, Daniel P. Berrangé wrote:
> > On Thu, Jan 22, 2026 at 11:43:35AM +0100, Thomas Huth wrote:
> > > On 22/01/2026 11.14, Daniel P. Berrangé wrote:
> > > > On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
> > > > > Hi Marc-André,
> > > > > I haven't seen discussion about the project ideas you posted, so I'll
> > > > > try to kick it off here for the mkosi idea here.
> > > > > 
> > > > > Thomas: Would you like to co-mentor the following project with
> > > > > Marc-André? Also, do you have any concerns about the project idea from
> > > > > the maintainer perspective?
> > > 
> > > I'm fine with co-mentoring the project, but could you do me a favour and add
> > > some wording about AI tools to
> > > https://wiki.qemu.org/Google_Summer_of_Code_2026 to set the expectations
> > > right? Since we don't allow AI generated code in QEMU, I'd appreciate if we
> > > could state this in a prominent place here to avoid that some people think
> > > they could get some quick money here by using AI tools, just to finally
> > > discover that AI generated code is not allowed in the QEMU project. Thanks!
> > > 
> > > > IMHO, our baseline for functional testing images ought to be
> > > > a Linux Kconfig recipe used to build a dedicate kernel, plus
> > > > a busybox build for the target.
> > > 
> > > Not sure if we want to add kernel compilation time to the functional tests
> > > (even if it's only done once during the initial build)...? That could easily
> > > sum up to a couple of hours for a fresh checkout of QEMU...
> > 
> > That's absolutely *NOT* what I was suggesting.
> > 
> > We should have a 'qemu-test-images.git' repository that maintains all
> > the recipes, with CI jobs to build and publish them (along with corresponding
> > source). Those prebuilt images would be consumed by QEMU functional tests.
> > This would be quicker than what we have today, as the images downloaded by
> > functional tests could be an order of magnitude smaller, and boot more
> > quickly too.
> 
> Ah, sorry for getting that wrong!
> 
> Ok, so this sounds basically just like a gitlab-CI wrapper around what
> buildroot.org already provides. ... not sure whether that's challenging
> enough for a GSoC project?

Given the number of machines we have, it is certainly time consuming
enough to figure out the build for each one, and integrate it with
the functional test. Not massively mentally challenging, but that's
not a bad thing for GSoC.

> Also, adding this as a separate repository will easily burn your gitlab-CI
> minutes if you don't have a dedicated runner for this, so developing this
> feature might be no fun at all...

I'd expect most of the work would be on a local machine to construct and
test images for all the different machines and validate them in functional
tests. The integration into GitLab CI is a small-ish part which could be
validated with just a couple of images, so you'd only burn major CI credits
towards the end when needing to do a full run across all images.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


