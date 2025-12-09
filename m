Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6DCD3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSxTf-0005CC-38; Tue, 09 Dec 2025 08:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSxTb-0005Al-Ee
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSxTX-0008Rx-7P
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765285793;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Sw2LOkGPH79oQ74UAAEnc6wUXWXb0orelhe2WhIibw=;
 b=LGw0h352c4oNDB5XmPs2ZxWaZXdz3U4esv9t0qSGZJEO2JXAh9QfhacDDCcFgkcFNhgZ8z
 j+C4FyaDiiW/OIeyLmcl1Y9VNpN3gVvX6pE0K9X1Y3S6rvNGtQXXhrCw0ef6avatqIOlMz
 mUhzUV09/oepjDerLJGJ2BIJec5mTaM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-3z4rkbvNOmC4EaEyhQHBhA-1; Tue,
 09 Dec 2025 08:09:49 -0500
X-MC-Unique: 3z4rkbvNOmC4EaEyhQHBhA-1
X-Mimecast-MFC-AGG-ID: 3z4rkbvNOmC4EaEyhQHBhA_1765285788
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40A3D18011DF; Tue,  9 Dec 2025 13:09:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD8AF1956095; Tue,  9 Dec 2025 13:09:45 +0000 (UTC)
Date: Tue, 9 Dec 2025 13:09:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH-for-10.2] Fix order of function arguments
Message-ID: <aTgflpl0DUMQRTXT@redhat.com>
References: <20251209125049.764095-1-sw@weilnetz.de>
 <96877ee7-21b4-4a33-bbe4-33cd1304c177@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96877ee7-21b4-4a33-bbe4-33cd1304c177@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Tue, Dec 09, 2025 at 02:03:27PM +0100, Philippe Mathieu-Daudé wrote:
> On 9/12/25 13:50, Stefan Weil via wrote:
> > This fixes a compiler error when higher warning levels are enabled:
> > 
> > ../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
> > ../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
> >   1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
> >        |                                                  ^~~~~~~~~~~~~~~
> > ../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element
> > 
> > Avoid also a related int/unsigned mismatch by fixing the type of
> > two local variables.
> > 
> > Signed-off-by: Stefan Weil <sw@weilnetz.de>
> > ---
> >   migration/postcopy-ram.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 3f98dcb6fd..8bef0192aa 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1467,7 +1467,8 @@ retry:
> >   static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
> >   {
> >       PostcopyTmpPage *tmp_page;
> > -    int err, i, channels;
> > +    int err;
> > +    unsigned i, channels;
> >       void *temp_page;
> >       if (migrate_postcopy_preempt()) {
> > @@ -1479,7 +1480,7 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
> >       }
> >       channels = mis->postcopy_channels;
> > -    mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
> > +    mis->postcopy_tmp_pages = g_malloc0_n(channels, sizeof(PostcopyTmpPage));
> 
> I suppose we wanted to use:
> 
>     g_new0(PostcopyTmpPage, channels)
> 
> What is the benefit of g_malloc0_n() over g_new0()?

g_malloc0_n should be used only in scenarios where you do NOT have a type
you can pass to g_new0. For example in the audio code

  cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);

any calls to g_malloc0_n which use sizeof(some-type) in an arg are
code style laws IMHO and should be changed to g_new0.

Or to put it another way.  g_new0 must always be used/preferred except
in the handful of cases where it isn't possible.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


