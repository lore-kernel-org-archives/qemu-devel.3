Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B5DCD6E77
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVCNf-0006bt-NG; Thu, 04 Jun 2026 14:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVCNd-0006bL-DG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 14:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVCNa-0000GD-MR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 14:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780596075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UIVI6hMf2N8ns0bHcNRjy906fNXEP90vpZdn2vWQcfs=;
 b=HEe8AD7C352MRYtXvsQLssZiDJSqSURKhnEcKPfiMr0h1KF2R10TMjz0EuG+U2yqqPcG3V
 xnHldZ/afqmmgO0T1Wvm3hOTtIVAfmk/SnTBJs4l2/iAPWtD9XBWLBiBVL7uz1p15sIxLM
 kT6bxgLnMRrmWw1+Z5YCwQ0S9y4654w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-jIlCKTk_P1O4RgdApangaw-1; Thu, 04 Jun 2026 14:01:13 -0400
X-MC-Unique: jIlCKTk_P1O4RgdApangaw-1
X-Mimecast-MFC-AGG-ID: jIlCKTk_P1O4RgdApangaw_1780596073
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cecb6dee57so41951096d6.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 11:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780596073; x=1781200873; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UIVI6hMf2N8ns0bHcNRjy906fNXEP90vpZdn2vWQcfs=;
 b=XE3i2ZX+AUPZ0MMlIp/SJCcjUXP1GlDB8ojSMeY15uxL+vl3jTaSWgBTdJvcq9uqww
 ebtowAbfSB8ET6UK9ggXc+VzS2ZCkF2Bs2iUJ0UcU9lGZjmKdfck1XunXOMoF4t+UuPl
 tG9tCVmEndBB2IbQ5bSPKm+9RiHfG6bLzOfMjab2NZ6PH0b6WC7gjMv9I4YskxF2wfbz
 N4zppnLlXbMvVuF6q6LlFWkEZneNGDCWwkey5N5xp51//Oqy18BL9HHr+CC8LOxnzHcD
 bld9j49fc9XmEfG3bCEzgLSuv8UnPCjOFcK3T6T0vGDbJmFgLZ9sqdO2YODg0NvlD4Jt
 fbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780596073; x=1781200873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIVI6hMf2N8ns0bHcNRjy906fNXEP90vpZdn2vWQcfs=;
 b=W4pxviRVbM2jCbnY+jdHHe9Jpmqz8dTN7ajV6YDZIQv/MJNbL2Gp/dN7MiTZ6je4pK
 y2XQ6/VOmKw65GkRz3tsiTd+KzLKKIeY9E4bFrixr7a7P2kGOinTt7PHtKuxkxnbpWif
 Cq7nj5grbDgeQ29v4L33ZZ1/ukJ9+TYZ41CFHDKkL98kliDZyd6Ay2wHr/yxIRoXvOdv
 URUMoYZ35sz8eSn5ne0EXMPUzyjwwU8LmBCOh9YB5UmyIJMYxBcxevGbriNopxDpsL6T
 bPZBIrnxMVeqJ7X0l8hfyAiMq3IeZnvfY1mFiWB+Gu4n8VVpkGEiKcp4TkbfvuJjiSv5
 Q/9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ88D5V0Dj7GFwrgEjrPSlmXS8IcJUsU6triPfvdZQ0LdDzCoEbDeXMFjv3BE2dx0JPVSOTpdI9oixUW@nongnu.org
X-Gm-Message-State: AOJu0YwGNNEwNp994SbV2WRWqQW7xjW1zA40c34PGvHe3RvGIQ5z1wsh
 59BWWOzncJtNj+MxX2VtK1Wyy9JWaXv5MGzez59CM6n/rp5MovzzRhqbkZNmH6MO5zVsLmKXWGW
 FzaGqqGfgw10eDLXT8qpQYYdRT095TGM+qbt0dCTYpN5CNgHhmLppX+bp
X-Gm-Gg: Acq92OHmDiLV5VGlBKxxHnweIP4vlo28HMMIpMfAN4hro61JlMsQEn1mOEfjVhbPUYa
 aOSpvxLqVfHzyya3KPLLmt1yRk294M1wv6CMW+p6/ODPDKulED3reKaTDLPDiPHG+1+sSFU2tZB
 hMXCjxl1ZsUQ9XIdw6b0NLOx9l/Ks24FEkMeXlMsz+Uiyta6nuGqPwe/6kIKQyrvI+8exRpA+uj
 Z0cMPMKMp9OpHIaodAyY+EWTMCYYAAib/g8Xv4+V2wTcWjXsfpxgrqRxV8t5PXscp3zj6lhntjr
 7StbCnOyvgm63l7DrbKUWEl1WblG+ZY4EbQgq0dSpMpq7JVuwHwP/QhcUccu1z8wKPeUmFf8u5T
 Vwlj5g1qWNtr1Zi+d5/k18nRutA==
X-Received: by 2002:a05:620a:a191:10b0:915:29cd:3082 with SMTP id
 af79cd13be357-9159ae6a5d3mr498456785a.8.1780596071738; 
 Thu, 04 Jun 2026 11:01:11 -0700 (PDT)
X-Received: by 2002:a05:620a:a191:10b0:915:29cd:3082 with SMTP id
 af79cd13be357-9159ae6a5d3mr498432685a.8.1780596069558; 
 Thu, 04 Jun 2026 11:01:09 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a381febsm627556585a.23.2026.06.04.11.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 11:01:08 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:01:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiG9Yn5My8LoTraZ@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com> <87o6hr7brx.fsf@suse.de>
 <aiBrp1UJZjmC1aI1@redhat.com> <aiB2nA5bmtBRWras@x1.local>
 <21a05595-0266-4755-8a99-29a85b9da2db@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21a05595-0266-4755-8a99-29a85b9da2db@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 04, 2026 at 01:00:10AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 03.06.26 21:46, Peter Xu wrote:
> > > My general feeling wrt changes to the current command line is that
> > > any suggestion should be desgined with a nod towards a future scenario
> > > where QEMU is 100% configured with QMP. ie the full command line is
> > > 
> > >     qemu-system-x86_64 -qmp <address>
> > > 
> 
> [..]
> 
> > 
> > Requirements like this (allow migration parameters to be accessible during
> > early stage of QEMU) is going towards the other direction of the that idea.
> > That means even if we put all configs (caps/params) into QMP command
> > migrate[-incoming], libvirt will still need to manage these global setup
> > and making sure when invoking migrate[-incoming] QMP commands they match
> > with the globals.  Say, if one start QEMU with -incomingconfig:local=on
> > but then invoke "migrate-incoming,local=off" it's illegal.
> 
> Right.. And this show, that moving "local" from migrate-set-parameters to
> commandline is not a clear solution for the whole problem.
> 
> We don't need cmdline argument. We need two things:
> 
> 1. "local" must be set before initializing tap-device.
> 
> It not actually requires it being a cmdline parameter. Calling
> migrate-set-parameters before netdev_add is also OK.

Ohh is it ok?  I thought it was not OK so we look at this.

Say, this is what I see on init TAP device when without hotplug:

qemu_create_late_backends() -> net_init_clients()

Such happens before migration object initialization.

> 
> So, moving to cmdline solves this [1] point, but may be too restrictive.
> 
> 
> 2. "local" must not be changed after initializing tap-device.
> 
> And this one is not guaranteed anyway, with cmdline or with QMP.
> 
> ---
> 
> 
> So, in my series, if drop "incoming-fds" and rely on "local" instead, we
> actually want "local" be immutable after first read in tap initialization
> code.
> 
> Maybe, just implement this feature? So, in code it will look like:
> 
> set_migration_parameters(...) {
> 
> ...
> 
> if "local" value is changing and "local" is immutable:
>    fail

We can't do that, can we?

Imagine we need to further migrate this VM to another host, where we need
to turn "local" off after this incoming migration.. we can forbid only
during incoming phase and re-enable the mutability, but it seems too much.

My understanding is such protection is fine but not strongly necessary.
IMHO we rely on a lot of things that admin needs to do right.  I hope this
isn't a major issue to offload that to admin to say the admin should always
do the right things.

We have a bunch of similar issues in QEMU IIUC, e.g. we have known issue
that some -device needs to be ordered in some way otherwise it'll stop
working.  We then need admin (or in this case libvirt) do the right thing
too.

> 
> ...
> 
> }
> 
> 
> tap_initializaion(...) {
> 
> ...
> 
> local = migrate_get_local_and_make_it_immutable(err_text="you can not change 'local' parameter value after TAP device initialization");
> 
> ...
> 
> 
> }
> 
> ---
> 
> For user it should provide simple error messages
> 
>    "you can not change 'local' parameter value after TAP device initialization".
> 
> if user tries to change local when it's not allowed.
> 
> 
> -- 
> Best regards,
> Vladimir
> 

-- 
Peter Xu


