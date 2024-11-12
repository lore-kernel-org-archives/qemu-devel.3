Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D25D3ABFB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 13:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAqau-0001CT-4f; Tue, 12 Nov 2024 08:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tAqat-0001Br-Dq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:06:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tAqar-0004do-DG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 08:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731416763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DS+3+IqGSO31d+pGe9qq+VJpvH9ks30FfcvSD8WsV/c=;
 b=a+oeZuWfCw+w+pS0fzrpgL5mBkk2ADEKyUFZjCmKDbG3GojsrAxxZSLorPUsU+HOSiNZS1
 +NvYc6hN7nKMucF24nSruLZQQ101iX469udZp0fxBhn0kTTXptd+mrIF3QKWQF+5q4Zkp/
 e6dxyeXJNrxNv64QPvLTyAbc8B46H1c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-muWH9lTKMnWemHPgMOlJFA-1; Tue,
 12 Nov 2024 08:05:59 -0500
X-MC-Unique: muWH9lTKMnWemHPgMOlJFA-1
X-Mimecast-MFC-AGG-ID: muWH9lTKMnWemHPgMOlJFA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50298195609E; Tue, 12 Nov 2024 13:05:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.211])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 726B21955F40; Tue, 12 Nov 2024 13:05:54 +0000 (UTC)
Date: Tue, 12 Nov 2024 13:05:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Dmitry Frolov <frolov@swemel.ru>, lvivier@redhat.com,
 sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: increase timeouts
Message-ID: <ZzNSriLoOEaWDtNW@redhat.com>
References: <20241112120100.176492-2-frolov@swemel.ru> <87ed3gip7n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ed3gip7n.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

On Tue, Nov 12, 2024 at 09:58:04AM -0300, Fabiano Rosas wrote:
> Dmitry Frolov <frolov@swemel.ru> writes:
> 
> > More time for some tests needed when qemu is built with
> > "--enable-asan --enable-ubsan"
> >
> > Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> > ---
> >  tests/qtest/meson.build | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index aa93e98418..ead2207f9c 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -5,7 +5,7 @@ slow_qtests = {
> >    'cdrom-test' : 610,
> >    'device-introspect-test' : 720,
> >    'ide-test' : 120,
> > -  'migration-test' : 480,
> > +  'migration-test' : 600,
> >    'npcm7xx_pwm-test': 300,
> >    'npcm7xx_watchdog_timer-test': 120,
> >    'qmp-cmd-test' : 120,
> > @@ -15,7 +15,7 @@ slow_qtests = {
> >    'pxe-test': 610,
> >    'prom-env-test': 360,
> >    'boot-serial-test': 360,
> > -  'qos-test': 120,
> > +  'qos-test': 240,
> >    'vmgenid-test': 610,
> >  }
> 
> I'm not sure this is the right change to make. In my machine a different
> set of tests times out when using asan. Besides, the timeouts are mostly
> tailored for the CI environment.
> 
> Would it be possible to check whether the build has asan enabled and
> just use a global timeout? I'm afraid tweaking individual tests timeouts
> will hide real slowness issues when not using asan.

meson has a concept of a "timeout multiplier", which defaults to 1.

Enabling build options that are known to make execution slow ought
to be made to increase the timeout multiplier, for global effect.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


