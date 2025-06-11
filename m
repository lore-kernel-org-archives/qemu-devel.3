Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB17FC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 08:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPH5f-00073U-I8; Wed, 11 Jun 2025 04:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPH5d-00070M-0x
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPH5a-0004rS-Hn
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749631541;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CCvSwDazl0yZNflEfMBMdisXrcmFHujU47NPjIfN5Pk=;
 b=LWDVawV5hdcMu3ymzi1FSlam2w/F5duRGCxRkY+OEySC2/AqZkFfZqeBGHxlOtmrwJ7dfz
 74/fAoA6lit/EgS+ruMejYcsS8V5EnRV0D+zX/R7Q1xDNJMnGvTicIHmQgKz8M7Sg9kEWE
 Bi7wYfCB2pLwK0KkydEz8CocUCya9Zk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-Tf1HfSliMRGEKK3quNuCFA-1; Wed,
 11 Jun 2025 04:45:38 -0400
X-MC-Unique: Tf1HfSliMRGEKK3quNuCFA-1
X-Mimecast-MFC-AGG-ID: Tf1HfSliMRGEKK3quNuCFA_1749631537
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E1E81800286; Wed, 11 Jun 2025 08:45:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.140])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 545F21956087; Wed, 11 Jun 2025 08:45:30 +0000 (UTC)
Date: Wed, 11 Jun 2025 09:45:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 4/5] configure: Add dtc option
Message-ID: <aElCJnmjrB-X9M-n@redhat.com>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-5-shentey@gmail.com>
 <cdfc561e-23a9-607a-d9a8-70e07e73e0fd@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdfc561e-23a9-607a-d9a8-70e07e73e0fd@eik.bme.hu>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 11, 2025 at 02:37:08AM +0200, BALATON Zoltan wrote:
> On Tue, 10 Jun 2025, Bernhard Beschow wrote:
> > The next patch will make dtc mandatory for boards with a bundled DTB, causing
> > these boards to be omitted when dtc is missing. Allow packagers to force the
> > build of those boards by providing an option.
> 
> I don't like this. This might result in some machines missing from some
> distros if they don't notice this and forget to update their packages and
> these are machines I care about.

"Someone might not notice & screw up" is pretty much an argument for
not doing anything at all. We publish release notes to alert distros
to these kind of changes which is a reasonable effort on our part.
Distros need to play their part by reading them and adapting to the
changes. They can also compare the available options with new and
old QEMU to identify any new build features they need to handle when
updating.

>                                  Also what guarantees that we don't get bugs
> by compiling the device tree with different dtc versions which might
> generate different binaries? The binaries we have now are known to work and
> don't take much space so keeping them for convenience might be simpler. If
> it worked so far why change it now?

Ultimately the DTC project has responsibility to not cause regressions
in new releases they issue, as is the case for any 3rd party dep that
we rely on.

We have CI jobs that can run on different distros. If we have coverage
of the boards in functional test suite that provides a way to validate the
operation with differing DTC versions as a sanity check.

Distributing pre-built binaries in source release tarballs is a long
standing issue with QEMU's releases. If we can eliminate the pre-bbuilt
DTB and only ship the source that is a good thing IMHO.

> If this was using dtc from the submodule when not using system libfdt then
> at least it would not result in dropped machines and we had a known working
> dtc to compile with. Why isn't that used when we already have it for libfdt?

Are there any platforms that we target which still lack dtc ? The
submodule was there to plug gaps in distro support long ago, but
if every distro has dtc available the submodule is redundant.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


