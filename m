Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA5D2D0E4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdDO-0000OX-6Q; Tue, 13 Jan 2026 07:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfdDC-0000K7-Js
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfdDA-0000uD-Do
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768306162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eVR5A1RjRWkEbd7StRLCkXwqSmbJR8p/VK/bXm3k5no=;
 b=DQnjlE9i+jmeKN3UAirR6179SeSkicm3NJIVqFCIzyohlLVBsF0cA5yiXACyGlOgtoAnH4
 DKt5MxeV1i5vq1tPORyLBPwpJ+Qn0Zcu0jVujCsYqjn+DtwD0H8Xb5QXculcZJyyGWW2nU
 16rVxvNdQd4BJLBRdlHgr5kDR1FGA08=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-I9-1vEhxPSeSPxD6Tm9b1w-1; Tue,
 13 Jan 2026 07:09:12 -0500
X-MC-Unique: I9-1vEhxPSeSPxD6Tm9b1w-1
X-Mimecast-MFC-AGG-ID: I9-1vEhxPSeSPxD6Tm9b1w_1768306149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55EA41801369; Tue, 13 Jan 2026 12:09:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57B5619541AA; Tue, 13 Jan 2026 12:08:56 +0000 (UTC)
Date: Tue, 13 Jan 2026 12:08:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/1] Sync kernel-doc.py with Linux upstream
Message-ID: <aWY10BYoJjck3xX8@redhat.com>
References: <cover.1767716928.git.mchehab+huawei@kernel.org>
 <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_TMuZG8VJMs2JZ49Xq+wVxcq_7UGOMF+2FUe0k7AUgwA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 11:44:51AM +0000, Peter Maydell wrote:
> On Tue, 6 Jan 2026 at 16:38, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Hi Peter/John,
> >
> > There were several updates at kernel-doc upstream fixing bugs,
> > doing cleanups and a couple of improvements.
> >
> > Better to keep QEMU in sync with such changes.
> >
> > Worth mentioning that we did some changes on Linux at the
> > kernel-doc.py script itself, to avoid Kernel build to crash
> > with too old Python versions, as there docs build is a
> > separate target, and python >= 3.6 is a new requirement
> > there.
> >
> > On kernel, if python < 3.6, it will simply ignore docs
> > build (emitting a warning).
> >
> > I opted to not backport such changes, but if you prefer
> > doing that, I can do that on a v2.
> > ---
> >
> > For now, I opted to keep kernel-doc libraries at the same
> > directory as before - e.g. at scripts/lib/kdoc. On Linux,
> > we ended moving it to tools/lib/python/kdoc. It could make
> > sense to move it on QEMU too, as it makes a little bit
> > easier to keep things in sync.
> >
> > What do you think?
> 
> Hi; thanks for doing this backport. I checked that the output
> with this patch applied is still the same as with the old
> kernel-doc, and eyeballed the diffs between our kernel-doc
> and the Linux version, to confirm that we have kept our two
> minor QEMU-specific modifications and haven't missed anything
> from Linux's version that we ought to have. So:
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> On your two questions:
> 
> (1) As Dan says, QEMU already enforces a new enough
> Python version, so we don't need to handle 3.6. I think
> the main thing driving a choice to backport or not those
> changes would be simply keeping in sync with Linux's
> version of the script so we don't diverge. We want to
> make future re-syncing of the script as easy as possible.
> 
> (2) Regarding the location of the kernel-doc libraries:
> we seem to have two things here, possibly in tension:
>  - we don't want to gratuitously diverge from Linux
>  - QEMU's directory hierarchy is not the kernel's
> 
> In particular, I'm not sure tools/ is where we would
> naturally put python libraries used during the build
> process. Maybe that would be python/ for us, but I defer
> to John or another Python expert on that.

I tend to see the 'python' directory as being for stuff we formally
maintain as a python API for use by multiple internal consumers.

This is just a bunch of helper files exclusively for use by the kernel-doc
tool, and so the scripts/ directory is a decent fit for it, given that this
dir is for a collection of arbitary supporting tools & scripts.

As precedent, see the tracetool, which keeps all its helpers under
scripts/tracetool too.

TL;DR: I would not want to see a new top level tools/ directory
created, and don't think it fits in python/ either; scripts/ is
a fine home.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


