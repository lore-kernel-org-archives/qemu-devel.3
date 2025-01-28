Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02554C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchsl-0008AF-J9; Tue, 28 Jan 2025 04:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tchsj-00089N-Jd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tchsh-0003g7-EZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 04:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738056456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFXGczmCI1uIYY0pZ8yX7AdD/+GTcX3EoYpVnV837Yw=;
 b=Hxn7E3f3yvq5gIZftIWU2RvCVUSQJL/QvEJll08E9CQMkMxDUYXKSahofh9K+d4r8D05Zd
 s+twfCbgirgnNze13hsETU148HbV5pj0ZTbRopXIxSPZOB7e5Z9i+KJEviA+VkOdeD0VE6
 UZLiILn00FthlP7cFrL81CfU2dpPDcw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-JqKx6VZzM7WbYDHoEqi2mw-1; Tue,
 28 Jan 2025 04:27:32 -0500
X-MC-Unique: JqKx6VZzM7WbYDHoEqi2mw-1
X-Mimecast-MFC-AGG-ID: JqKx6VZzM7WbYDHoEqi2mw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB4441801F1A; Tue, 28 Jan 2025 09:27:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 044531956056; Tue, 28 Jan 2025 09:27:25 +0000 (UTC)
Date: Tue, 28 Jan 2025 09:27:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org,
 stefanha@redhat.com, pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk, Liviu Ionescu <ilg@livius.net>
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
Message-ID: <Z5ii-ueFt5-5Brxz@redhat.com>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 28, 2025 at 10:17:33AM +0100, Philippe Mathieu-Daudé wrote:
> On 28/1/25 10:02, Alex Bennée wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > 
> > > On 28/01/2025 01.42, Richard Henderson wrote:
> > > > Time for our biennial attempt to kill ancient hosts.
> > > > I've been re-working the tcg code generator a bit over the holidays.
> > > > One place that screams for a bit of cleanup is with 64-bit guest
> > > > addresses on 32-bit hosts.  Of course the best "cleanup" is to not
> > > > have to handle such silliness at all.
> > > > Two years after Thomas' last attempt,
> > > >     https://lore.kernel.org/qemu-devel/20230130114428.1297295-1-thuth@redhat.com/
> > > > which resulted only in deprecation of i686 host for system
> > > > emulation.
> > > > By itself, this just isn't enough for large-scale cleanups.
> > > > I'll note that we've separately deprecated mips32, set to expire
> > > > with the end of Debian bookworm, set to enter LTS in June 2026.
> > > > I'll note that there is *already* no Debian support for ppc32,
> > > > and that I am currently unable to cross-compile that host at all.
> > > 
> > > IIRC the biggest pushback that I got two years ago was with regards to
> > > 32-bit arm: The recommended version of Raspberry Pi OS is still
> > > 32-bit:
> > > 
> > >   https://lore.kernel.org/qemu-devel/F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/
> > > 
> > > And looking at https://www.raspberrypi.com/software/operating-systems/
> > > this still seems to be the case...
> > > 
> > > So I guess the main question is now: Would it be ok to kill support
> > > for 32-bit Raspberry Pi OS nowadays?
> > 
> > I would argue yes for a few reasons.
> > 
> >    - you can't buy 32 bit only Pi's AFAICT, even the Pi Zero 2W can work
> >      with a 64 bit OS.
> > 
> >    - It's not like the versions shipping in bullseye and bookworm will
> >      stop working.
> > 
> >    - Even if we deprecate now there will likely be one more Debian
> >      release cycle that gets 32 bit host support.
> > 
> > > > Showing my hand a bit, I am willing to limit deprecation to
> > > > 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
> > > > unconditional support for TCG_TYPE_I64 would remove a *lot* of
> > > > 32-bit fallback code.
> > 
> > I support going the whole hog. I would be curious what use cases still
> > exist for an up to date 32-on-32 QEMU based emulation?
> 
> Current maintainers don't have spare time to support the 32-on-32
> emulation. If there is interest in the community for such niche,
> someone needs to step forward, willing to maintain it.

I'm not sure that's the case here.

32-on-32 is already effectively unmaintained, so we're not suffering
in terms of keeping the 32-on-32 code reliable.

We're suffering from the complexity that 32-on-32 code places on the
rest of the XX-on-64 code that we do care about.

IOW if someone volunteered to maintain 32-on-32 that's not actually
solving the complexity problem, just perpetuating it.

The current maintainers only interested in XX-on-64 will still suffer
ongoing burden from the code complexity caused by 32-on-32 merely
existing.

So again lets be clear...

Either we...

 * ...want to kill 32-on-32 code to reduce the complexity on the
   main XX-on-64 codebase regardless of interest in 32-on-32

Or

 * ...want to kill 32-on-32 code because it is buggy due to lack
   of maintainers, but would welcome someone to step forward to
   maintain it

It sounded like we were wanting the former, not the latter.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


