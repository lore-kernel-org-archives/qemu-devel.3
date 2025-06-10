Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7032FC61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxyn-0004YC-00; Tue, 10 Jun 2025 08:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOxyX-0004WZ-BY
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOxyQ-0006hT-P6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749558056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkxDJbZjtfgq9m7mpei5ypbjkrV8ex9vU5KtowQT33E=;
 b=I6quaN5nIbt1LeyAg7s4WK9MXeqWQjUYIZKmzqozSbKyNtq2fre+zwOvDWP8laLRn7IDUl
 Fe4hMwEiccDu0ErbHzlTWfOmHAYEtGgT1lM1imFecFGmHKmVs9LwXqEcstNysyit8a7HXj
 fsbG+iJttKrfXLiJzm1Q0YuV4AawB5I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-pOmaZ6LHMnmvK5a_dSK3rQ-1; Tue,
 10 Jun 2025 08:20:53 -0400
X-MC-Unique: pOmaZ6LHMnmvK5a_dSK3rQ-1
X-Mimecast-MFC-AGG-ID: pOmaZ6LHMnmvK5a_dSK3rQ_1749558052
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 892B519560A2; Tue, 10 Jun 2025 12:20:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 908BE19560A3; Tue, 10 Jun 2025 12:20:48 +0000 (UTC)
Date: Tue, 10 Jun 2025 13:20:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Message-ID: <aEgjHdDScyiuF4ID@redhat.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
 <aEFYnTvaDQ6Kd0o4@redhat.com>
 <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <aEKVmH8ZxDcGKSeq@redhat.com>
 <CAMxuvaz1wJw-qMDDPwj_BOGPL0zdgBsi647B6+AG+OdOOomhDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaz1wJw-qMDDPwj_BOGPL0zdgBsi647B6+AG+OdOOomhDQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Tue, Jun 10, 2025 at 03:30:24PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jun 6, 2025 at 11:16 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Jun 06, 2025 at 06:10:31AM +0000, Kasireddy, Vivek wrote:
> > > Hi Daniel,
> > >
> > > > Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to
> > provide a
> > > > preferred codec
> > > >
> > > > On Wed, May 28, 2025 at 10:11:13PM -0700, Vivek Kasireddy wrote:
> > > > > Giving users an option to choose a particular codec will enable
> > > > > them to make an appropriate decision based on their hardware and
> > > > > use-case.
> > > > >
> > > > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > > > Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > > > Cc: Frediano Ziglio <freddy77@gmail.com>
> > > > > Cc: Dongwon Kim <dongwon.kim@intel.com>
> > > > > Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> > > > > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > > > > ---
> > > > >  qemu-options.hx |  5 +++++
> > > > >  ui/spice-core.c | 12 ++++++++++++
> > > > >  2 files changed, 17 insertions(+)
> > > > >
> > > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > > index 7eb8e02b4b..fcddb583c9 100644
> > > > > --- a/qemu-options.hx
> > > > > +++ b/qemu-options.hx
> > > > > @@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
> > > > >      "
> >  [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
> > > > >      "
> >  [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
> > > > >      "       [,playback-compression=[on|off]][,seamless-
> > > > migration=[on|off]]\n"
> > > > > +    "       [,video-codecs=<encoder>:<codec>\n"
> > > > >      "       [,gl=[on|off]][,rendernode=<file>]\n"
> > > > >      "                enable spice\n"
> > > > >      "                at least one of {port, tls-port} is
> > mandatory\n",
> > > > > @@ -2369,6 +2370,10 @@ SRST
> > > > >      ``seamless-migration=[on|off]``
> > > > >          Enable/disable spice seamless migration. Default is off.
> > > > >
> > > > > +    ``video-codecs=<encoder>:<codec>``
> > > > > +        Provide the preferred codec the Spice server should use.
> > > > > +        Default would be spice:mjpeg.
> > > >
> > > > This looks like two distinct settings overloaded into one command
> > > > line parameter, which is a design anti-pattern.
> > > >
> > > > Why can't this be done as separate parameters
> > > The Spice server API used by Qemu (spice_server_set_video_codecs)
> > > to set the preferred codec requires the video-codecs string to be in
> > > encoder:codec format. AFAIK, there is no other option or API to set
> > > the encoder and codec values separately.
> >
> > QEMU can accept the separate parameters and format them into the string
> > format that the spice API requires so our public API is not impacted
> > by this spice design choice.
> >
> >
> Apparently you cannot mix and match freely, it has a rather fixed set of
> actually working values.
> 
> See here and related code:
> https://gitlab.freedesktop.org/spice/spice/-/blob/master/server/reds.cpp?ref_type=heads#L3468

That's just showing the built-in defaults - the parsing code is
not enforcing any constraints. The impl though cleary only allows
'mjpeg' with 'spice':

  https://gitlab.freedesktop.org/spice/spice/-/blob/master/server/mjpeg-encoder.c#L1371

> Tbh, I don't think the encoder matters much, and I don't know why it was
> decided to associate it with video codec names.

AFAICT the only way in which the encoder matters is to distinguish the
built-in "mjpeg" impl from the gstreamer "mjpeg" coder.

> Maybe the spice API should provide a simpler form: accept only codec names.
> 
> In the meantime, qemu should perhaps add the "working" encoder prefixes
> (spice: for mjpeg, gstreamer: for others)  itself and not expose any extra
> option to the user?

Ths question is whether we need to be able to request the gstreamer
'mjpeg' impl ?

If we do, and we also assume that 'spice' will never gain any more codec
impls as built-ins, we could do

  builtin, mjpeg, vp8, vp9, h264

where 'builtin' is the standard mjpeg encoder ?

Alternatively we could just go with

  mjpeg, vp8, vp9, h264

and in the unlikely event we need to be able to skip the built-in mjpeg,
we could add  a boolean 'prefer-gstreamer=on|off'

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


