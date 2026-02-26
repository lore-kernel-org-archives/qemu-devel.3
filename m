Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38150FC592F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZM1-0006Fk-OJ; Thu, 26 Feb 2026 06:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvZLw-0006FM-IV
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvZLs-0005SE-Jy
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772104575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8zhsW3B3olPZZMPqApfeXMrprbaC3NE2DEnyEUTeuP8=;
 b=KfRGCRb1AqAims0EEHfQZNf7uc9uStwZgJ5Fhu3xbP2jMbn1RjzOK+rTDOJJZS6NIGYiNC
 kEODF7QH7y3XCpvdCEpqCTyyV5Ulge4dpfM+HsSd6ZxWooLzKHfRc6qBdGs9brVURkmabT
 OggzG4i26uc02OrR2j2cz3ozLIWs/nA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-YwfaSNJNNi2wtQS-Di2y1w-1; Thu,
 26 Feb 2026 06:16:11 -0500
X-MC-Unique: YwfaSNJNNi2wtQS-Di2y1w-1
X-Mimecast-MFC-AGG-ID: YwfaSNJNNi2wtQS-Di2y1w_1772104570
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68CAF1800341; Thu, 26 Feb 2026 11:16:10 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.97])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 929971800465; Thu, 26 Feb 2026 11:16:07 +0000 (UTC)
Date: Thu, 26 Feb 2026 11:16:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@dlhnet.de>
Subject: Re: block/nfs.c and libnfs vs Fedora 43 (was: Re: [PULL v2 00/19]
 Python patches)
Message-ID: <aaArdNcA8Iq9DrBA@redhat.com>
References: <20260224181440.832943-1-jsnow@redhat.com>
 <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-zsPN0Pbg9USt2dWCD9+iONr=bCGDaxomysn3ubqx=gA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 10:44:58AM +0000, Peter Maydell wrote:
> On Tue, 24 Feb 2026 at 18:14, John Snow <jsnow@redhat.com> wrote:
> >
> > The following changes since commit afe653676dc6dfd49f0390239ff90b2f0052c2b8:
> >
> >   Merge tag 'audio-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-02-23 14:03:50 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
> >
> > for you to fetch changes up to 4e55bb4be53bc7a5e3fe1429af12d2e3090049a5:
> >
> >   python: add setuptools and wheel dependencies (2026-02-24 13:11:29 -0500)
> >
> > ----------------------------------------------------------------
> >
> > ----------------------------------------------------------------
> 
> Hi -- it looks like this pullreq may have broken the "coverity" job
> that (run on a separate schedule from main CI) does a QEMU build to
> upload to the coverity scan service:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/13264087007
> 
> It fails during QEMU configure:
> 
> Dependency libnfs found: NO. Found 16.2.0 but need: '<6.0.0' ;
> matched: '>=1.9.3'
> Run-time dependency libnfs found: NO
> ../meson.build:1150:11: ERROR: Dependency lookup for libnfs with
> method 'pkgconfig' failed: Invalid version, need 'libnfs' ['<6.0.0']
> found '16.2.0'.
> 
> I'm guessing this is because:
>  * the coverity job runs on the amd64-fedora-container
>  * we just upgraded our Fedora container to F43
>  * coverity configures with --enable-libnfs

Do we really need to be hardcoding configure options ?

It is a pretty random subset of options, compared to what gets
enabled in the build.

Originally we had the hand-built Dockerfile, but now nearly all
our dockerfiles are auto-generated by lcitool, so we get the full
set of QEMU deps on every distro. 

There is a risk that we break a meson/configure chck somewhere,
but IMHO that's not something our coverity needs to be validating
directly. If that happens and we later fix it, coverity would
pick up any flaws that weere introduced in the window it was
broken.

>  * in meson.build we enforce libnfs < 6.0.0
>  * F43 ships with a newer libnfs
> 
> The "not libnfs v6" restriction was added by thuth in
> commit e2d98f257138 in 2024 because of a big API change in
> libnfs v6. The theory was that this was a temporary hack
> until somebody updated block/nfs.c to handle the new API.
> Over a year later, nobody has touched block/nfs.c...
> 
> I guess for the moment we should fix the Coverity build
> by dropping the --enable-libnfs (and accepting that we
> don't scan block/nfs.c any more). For the longer term:
> 
>  * does anybody want to update block/nfs.c ?
>  * or should we mark it as deprecated and plan to eventually
>    drop it, given that the set of supported distros you can
>    build it on is rapidly shrinking ?

MAINTAINERS file marks it as "maintained" but given the ongoing
brokeness that feels outdated :-(

In Fedora we've been carrying a patch to QEMU to enable libnfs
v6.

  https://src.fedoraproject.org/rpms/qemu/blob/rawhide/f/0002-nfs-Add-support-for-libnfs-v2-api.patch
  https://src.fedoraproject.org/rpms/qemu/blob/rawhide/f/0008-Revert-meson.build-Disallow-libnfs-v6-to-fix-the-bro.patch

I vaguely recall someone saying there was problem with this patch but I
can't remember details. We've had no bug reports AFAIR, but that could
just mean it has few/no users to begin with.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


