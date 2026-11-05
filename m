Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B937606A333
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UmDpsZ6j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOtR0-0002zU-LR; Thu, 05 Nov 2026 04:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOtQy-0002y5-1n
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOtQu-0004oD-DS
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 04:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793869612;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZVyx5wNOa2eUZzjeJIhg6AlJ3uCQjxanyLH7qCAl2OY=;
 b=UmDpsZ6jbJxnq4qNT3mJmDKYdFH2A+8xn1lvyJqeMJDbG7Gmf4w4qMNywthaPIaWpYMWzC
 RAIHcWM7SeEcS1Y84SI3SfM4SSVYf6n65BoaADOlYA1o3AiCwT9p2ohzN3y9fNtzFQLw8A
 NoVelheGSVEUZ1Cw/gCmRY8xb1h3/rQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-4uyHwZHrN-a9qx8Zm9BsCw-1; Thu,
 05 Nov 2026 04:06:48 -0500
X-MC-Unique: 4uyHwZHrN-a9qx8Zm9BsCw-1
X-Mimecast-MFC-AGG-ID: 4uyHwZHrN-a9qx8Zm9BsCw_1793869607
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 807C518005AD
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2026 09:06:47 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C4261956087; Thu,  5 Nov 2026 09:06:46 +0000 (UTC)
Date: Thu, 5 Nov 2026 09:06:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: input-keymap sizes
Message-ID: <auxF28W4dhEoqxWZ@redhat.com>
References: <CAFn=p-Z=RGEO-sTgRR549LkQbdfjR-zfnb8GASV8XnQf4TrwAw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-Z=RGEO-sTgRR549LkQbdfjR-zfnb8GASV8XnQf4TrwAw@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 05:16:03PM -0500, John Snow wrote:
> Heya!
> 
> I've been looking into producing minimal QEMU configurations for
> sandboxing, and as part of that, I've been auditing "what exactly
> takes up room in our QEMU binary?"
> 
> One of the things that came up was that input-keymap.c burns over 250
> KiB of .rodata all by itself; all of the keymaps we generate for QEMU
> are included statically in one big blob and are linked with every last
> build.
> 
> There's a few things we could do about this;
> 
> (1) We can split out each keymap into its own object file, which
> allows us to link only the keymaps we need for the features we have
> enabled. Dan Berrange wrote a quite POC for this and the results look
> good at a glance. We need new linker flags to automatically prune
> unused keymaps from the build, or enhanced meson-fu to
> deterministically exclude them. Either way, it's likely a worthwhile
> pursuit. In a microvm-only build configuration I've been testing with,
> this immediately dropped us from 250KiB to 180KiB.
> 
> (2) The x11 keymap used by ui/input-barrier.c and ui/gtk.c - all by
> itself - consumes 128KIB for its keymap. This is because although the
> x11_to_linux keymap has fewer than 512 total entries, it allocates
> this in a const array with 64K entries in it so it can span keycodes
> 0x00 to 0xff and 0xff00 to 0xffff.
> 
> It's the second one I am concerned about.

But can the first one solve the second one ?  In your sandbox use
case, presumably you don't need the GTK graphical frontend, and
so if GTK is dropped from the minimal build config there's no need
to link in the X11 keymap and thus (1) fixes the problem.

>                                            At first I thought that I
> might be able to write a "condensed" table that uses 0 - 255 and then
> remaps 65,280 - 65,535 onto 256-511 and then take (index & 0x1ff) on
> lookup table input, but I realize that the entire unmodified table is
> passed off to gd_get_keymap() in ui/gtk.c where I can't inject those
> index transformations.

Bear in mind all these keymaps tables are auto-generated by a tool
that is used by many applications

> Does anyone have any suggestions on how to help shave the x11_to_linux
> keymap down to a more reasonable size? I doubt we need 128KB when 1KB
> could theoretically hold everything we need.

That's binary size, but presumably not all those pages are mapped.
We won't access every index in the table so many pages won't get
faulted in to RAM.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


