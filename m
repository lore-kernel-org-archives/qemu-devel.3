Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189EED185CC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdneQ-0005ig-7s; Thu, 08 Jan 2026 05:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdneO-0005d5-83
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdneL-0006wz-Rb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767869632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CfPftgw3Q+8eTMwFXc2clAAbcNS49rqxgbg8VwT4Ac=;
 b=jCRmbYZSqTqyMAuHsdHXSSY+mBH5OSzNDJgJNeLpmFuHwTvAeJFILNj35W6wyiVAJa0o2a
 LvVADwUPOhVTgUYzXiXOqrwViGymj+xoMdBlPqgsTJ4AbTdLrCYFjvRe9LyZhEbK7oTrGI
 HAQaYausZft7Vbw3bnENQoqfXSm8C2Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-f1tYI80MNlSxCMK99AghQQ-1; Thu,
 08 Jan 2026 05:53:49 -0500
X-MC-Unique: f1tYI80MNlSxCMK99AghQQ-1
X-Mimecast-MFC-AGG-ID: f1tYI80MNlSxCMK99AghQQ_1767869628
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C04971956053; Thu,  8 Jan 2026 10:53:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A641956048; Thu,  8 Jan 2026 10:53:44 +0000 (UTC)
Date: Thu, 8 Jan 2026 10:53:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 2/2] dump/win_dump: Use stubs on non-Windows hosts like
 POSIX
Message-ID: <aV-Ms5PQDCiIA86v@redhat.com>
References: <20260107180519.50820-1-philmd@linaro.org>
 <20260107180519.50820-3-philmd@linaro.org>
 <aV902eZnijhEnONE@redhat.com>
 <0438ddd7-6061-4b7b-a995-0ec32f250f95@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0438ddd7-6061-4b7b-a995-0ec32f250f95@linaro.org>
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

On Thu, Jan 08, 2026 at 11:51:00AM +0100, Philippe Mathieu-Daudé wrote:
> On 8/1/26 10:11, Daniel P. Berrangé wrote:
> > On Wed, Jan 07, 2026 at 07:05:19PM +0100, Philippe Mathieu-Daudé wrote:
> > > Rather than compiling the same content for all targets (unused
> > > most of the time, i.e. qemu-system-avr ...), build it once per
> > > POSIX hosts. Check Windows host (less likely) before x86 host.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >   dump/win_dump-stubs.c | 21 +++++++++++++++++++++
> > >   dump/win_dump.c       | 12 ++++++++----
> > >   dump/meson.build      |  6 +++++-
> > >   3 files changed, 34 insertions(+), 5 deletions(-)
> > >   create mode 100644 dump/win_dump-stubs.c
> > 
> > snip
> > 
> > > diff --git a/dump/meson.build b/dump/meson.build
> > > index 4277ce9328a..0aaf3f65d9c 100644
> > > --- a/dump/meson.build
> > > +++ b/dump/meson.build
> > > @@ -1,2 +1,6 @@
> > >   system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
> > > -specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
> > > +if host_os == 'windows'
> > > +  system_ss.add(files('win_dump.c'))
> > > +else
> > > +  system_ss.add(files('win_dump-stubs.c'))
> > > +endif
> > 
> > This is very wrong.
> > 
> > The win_dump.c  file has no association with Windows hosts. It is about
> > creating crash dumps of Windows *guests* in the Windows dump format. The
> > current conditional which builds it on TARGET_X86_64 is correct.
> 
> Great to know this is a *guest* feature and not a *host* one.
> 
> Something else is currently wrong, because this file is built with
> qemu-system-avr on macOS.

Why is that a problem ? The entire file content is surrounded with

  #if defined(TARGET_X86_64)
  ...the impl...
  #else
  ...stubs...
  #endif

soo qemu-system-avr will be building the stubs which is fine. macOS
is not a factor, since QEMU is fine to emulate Windows guests on
macOS hosts and thus Win dump is in scope for macOS

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


