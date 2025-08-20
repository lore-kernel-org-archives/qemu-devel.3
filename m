Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E77CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 10:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uog4X-0004bk-Tb; Wed, 20 Aug 2025 06:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uog4V-0004bP-So
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uog4T-0001VI-HH
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755685770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFwObwF/ifw/1WMhnnpRKGXc8jOMy2+kkigz2vvivvA=;
 b=OuKfB1VNya18KWIicc9Ol3zrgp1GenUpdOvyuwTt1PjlGgXqD1BIJuLX971gTuoPp4O74J
 NAczz+APq3NE2o1dcCeQIR/QTjIFAu8//+hXgaTDAyCfmxKTgcOUmbZYZVbTTiORD55vro
 pOeeg/zIqA0QUKko7d5jKmLyNn/TuPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-CSq3MBCzOYywwJR43-e_Cg-1; Wed,
 20 Aug 2025 06:29:27 -0400
X-MC-Unique: CSq3MBCzOYywwJR43-e_Cg-1
X-Mimecast-MFC-AGG-ID: CSq3MBCzOYywwJR43-e_Cg_1755685766
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 760621956079; Wed, 20 Aug 2025 10:29:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 697311955F24; Wed, 20 Aug 2025 10:29:21 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:29:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/12] util: set the name for the 'main' thread
Message-ID: <aKWjfRn7S-Z7fKFj@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-5-berrange@redhat.com>
 <aKUGKNu0I8MXvsta@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKUGKNu0I8MXvsta@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 11:18:00PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > The default main thread name is undefined, so use a constructor to
> > explicitly set it to 'main'. This constructor is marked to run early
> > as the thread name is intended to be used in error reporting / logs
> > which may be triggered very early in QEMU execution.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/qemu-thread-posix.c | 12 ++++++++++++
> >  util/qemu-thread-win32.c |  6 ++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> > index 7c985b5d38..121d7ed69b 100644
> > --- a/util/qemu-thread-posix.c
> > +++ b/util/qemu-thread-posix.c
> > @@ -22,6 +22,18 @@
> >  #include <pthread_np.h>
> >  #endif
> >  
> > +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> > +qemu_thread_init(void)
> > +{
> > +# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> > +    pthread_setname_np(pthread_self(), "main");
> > +# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> > +    pthread_setname_np("main");
> > +# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> > +    pthread_set_name_np(pthread_self(), "main");
> > +# endif
> 
> Should this three way ifdef not be broken out somewhere;
> it's already in qemu_thread_start() (and it looks like qjack_thread_creator
> should use it)

Oh dear, I missed that jack-audio wasn't using our thread creation
wrapper :-(  Yes, we could split this into a helper function.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


