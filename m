Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C075AC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 07:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNRJZ-0000VI-4H; Fri, 06 Jun 2025 03:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNRJO-0000UI-UD
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNRJM-0005tn-EO
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 03:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749194177;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IXPysqSp4eDzQntbia6EjcbqsL0O25zO1EsUgkx84I=;
 b=hlO4LBoj/uSOppncdwpOEJXPU7lVGKHjRcmEpulCS5DycpvYgMSORa9R8YbO+9B9wa5QFc
 Z6/+obXmLXWHGQhqp7BGWU12yWj5LqGh9PCl0+UkQpjLcS++praJFcImqyM5X4dj6OYK8Y
 9WzwEb2EPv06jZNTRAizkoVeGBo1+nw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-OhAmrd4_N-yH8mjk0-vkmQ-1; Fri,
 06 Jun 2025 03:16:11 -0400
X-MC-Unique: OhAmrd4_N-yH8mjk0-vkmQ-1
X-Mimecast-MFC-AGG-ID: OhAmrd4_N-yH8mjk0-vkmQ_1749194170
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9BB618002BE; Fri,  6 Jun 2025 07:16:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E61830002C0; Fri,  6 Jun 2025 07:16:06 +0000 (UTC)
Date: Fri, 6 Jun 2025 08:16:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Message-ID: <aEKVmH8ZxDcGKSeq@redhat.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
 <aEFYnTvaDQ6Kd0o4@redhat.com>
 <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jun 06, 2025 at 06:10:31AM +0000, Kasireddy, Vivek wrote:
> Hi Daniel,
> 
> > Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
> > preferred codec
> > 
> > On Wed, May 28, 2025 at 10:11:13PM -0700, Vivek Kasireddy wrote:
> > > Giving users an option to choose a particular codec will enable
> > > them to make an appropriate decision based on their hardware and
> > > use-case.
> > >
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Cc: Frediano Ziglio <freddy77@gmail.com>
> > > Cc: Dongwon Kim <dongwon.kim@intel.com>
> > > Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> > > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > > ---
> > >  qemu-options.hx |  5 +++++
> > >  ui/spice-core.c | 12 ++++++++++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 7eb8e02b4b..fcddb583c9 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
> > >      "       [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
> > >      "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
> > >      "       [,playback-compression=[on|off]][,seamless-
> > migration=[on|off]]\n"
> > > +    "       [,video-codecs=<encoder>:<codec>\n"
> > >      "       [,gl=[on|off]][,rendernode=<file>]\n"
> > >      "                enable spice\n"
> > >      "                at least one of {port, tls-port} is mandatory\n",
> > > @@ -2369,6 +2370,10 @@ SRST
> > >      ``seamless-migration=[on|off]``
> > >          Enable/disable spice seamless migration. Default is off.
> > >
> > > +    ``video-codecs=<encoder>:<codec>``
> > > +        Provide the preferred codec the Spice server should use.
> > > +        Default would be spice:mjpeg.
> > 
> > This looks like two distinct settings overloaded into one command
> > line parameter, which is a design anti-pattern.
> > 
> > Why can't this be done as separate parameters
> The Spice server API used by Qemu (spice_server_set_video_codecs)
> to set the preferred codec requires the video-codecs string to be in
> encoder:codec format. AFAIK, there is no other option or API to set
> the encoder and codec values separately.

QEMU can accept the separate parameters and format them into the string
format that the spice API requires so our public API is not impacted
by this spice design choice.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


