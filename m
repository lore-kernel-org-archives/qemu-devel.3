Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D40C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 11:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCGqW-0004NQ-HM; Tue, 06 May 2025 07:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCGqU-0004Mm-GR
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uCGqS-0004Kp-Kf
 for qemu-devel@nongnu.org; Tue, 06 May 2025 07:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746532339;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGorE/Lc25O4uPQjqYd0fMOPR3UffQCgpg5+o28CSjY=;
 b=BXjxJhGc5No15tTnbAVthkERj6V/OHYDQnAm5ztD0gPgY6UWnTVj0qECNNP48CJ9xIvGQ5
 /u8/4kQPR8GheFCmedV/X2drmuyYpt32mmCETbmyxbOBwGvnT9EI9nhkfWAWAd73Ne7r9W
 o0qf8KDnRfw451hxmKEqL3wt20RBgkY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-2dV2SBktOZS0GgFt29rcww-1; Tue,
 06 May 2025 07:52:16 -0400
X-MC-Unique: 2dV2SBktOZS0GgFt29rcww-1
X-Mimecast-MFC-AGG-ID: 2dV2SBktOZS0GgFt29rcww_1746532335
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1AA91955DE2; Tue,  6 May 2025 11:52:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28D9E180036E; Tue,  6 May 2025 11:52:12 +0000 (UTC)
Date: Tue, 6 May 2025 12:52:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
Message-ID: <aBn36Qx8zd7cM1SW@redhat.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <aBnOyhMawDaY9yyR@intel.com>
 <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
 <aBnVtNgdjQ9DlugK@intel.com> <aBnbC4-hov9gY3MF@redhat.com>
 <CABgObfbzWDnntjLcshsBPfdEdbx-6iqxd6FxUDbQa--VOqan=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbzWDnntjLcshsBPfdEdbx-6iqxd6FxUDbQa--VOqan=A@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 12:54:38PM +0200, Paolo Bonzini wrote:
> On Tue, May 6, 2025 at 11:49 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > [...] If Rust is missing or old, "enable
> > > > all devices written in Rust" will fail compilation (e.g. Kconfig would
> > > > fail for ARM/x86 targets due to unsatisfiable CONFIG_PL011);
> > > > "enable Rust" will simply pick the C version of the PL011 and HPET devices.
> >
> > I don't really like this because it perpetuates a state where we have
> > parallel implementations of devices that have to be kept in sync.
> 
> Me neither (see for example the Meson transition which avoided
> parallel implementations at all costs).
> 
> On the other hand, this series shows that it's hard to have a baseline
> version earlier than 1.83.  The bindings got pretty far while
> supporting older versions, and the few hacks needed were nice testbeds
> for the build system and the procedural macro infrastructure, but the
> improvements that const_refs_to_static provides for reflection are
> just too big.

Admittedly I'm not actively working on the QEMU Rust code, but to
me to feels the opposite - we've shown it is possible to write useful
Rust code with the older version baseline. It may not be the ideal
way we want the code to look, but that's a tradeoff we can make.

I very much worry that at any point in time there is *always* going
to be something in a newer Rust that is very attractive to use, so
we end up on a slippery slope where we're always going to be chasing
the latest version to get a better way.

We've had the same situation with Meson where we initially set a
temporary newer baseline to get some critical features we could
not do without, and now have ended up in a situation where we
are continually pushing newer & newer versions, because there is
always something attractive in the new release.

> Now, it's certainly not the only possibility:
> 
> 1) If someone contributes devices that are written in Rust then we
> could just drop the PL011 and/or HPET sample device. That's a pity but
> they would survive in git history and could be resurrected later.

IMHO for Rust in QEMU we should be targetting both new features
and existing feature ports - excluding existing feature ports
would be tieing one of our hands behind our back limiting the
potential benefits we can see.

> 2) Using RUSTC_BOOTSTRAP[1] allows enabling unstable features even in
> versions older than 1.83. Disadvantage: build system changes that will
> be obsolete soon(ish), plus the relevant compiler code obviously
> wasn't as tested as after stabilization. I'd prefer to avoid that, but
> hey---Linux does it.
> 
> 3) Affected distros could use RUSTC_BOOTSTRAP themselves if they want,
> while upstream QEMU would only support rustup toolchains for Debian
> bookworm and Ubuntu up to 24.10. This only requires
> tests/lcitool/refresh changes, the disadvantage is that the project
> would renege on the general promise that we make on platform support.

Yes, this increasing defeats the benefit of defining our distro
target. We wanted to set a clear baseline that we could unambiguously
target, to give clarity to both users & contributors on when we could/
would impose new version requirements. 

We've made exceptions for python, and then meson, and now Rust. We can
rationalize it is as "users only need to do x, y & z to get newer stuff",
but as we make more & more exceptions, this is a game of death by a 1000
cuts.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


