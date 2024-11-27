Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9BED6ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGHK1-00010V-EB; Wed, 27 Nov 2024 07:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tGHJx-0000zz-1Z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:39:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tGHJv-00015H-6Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732711141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=r55YFBMjYEILKPfaX+UhnHRG/h7OD13Idez7EcDYr4U=;
 b=iTnH31RXd3pspxB6OuNeDxQbIOoUDPGpEFTc5jUuO71OceLGj+SO6373eAZSiUKw3oEb9X
 L7SRLOPRqkksdIVmkxmXy4SNseQcd88g+KJd88GF42ZFgTL0F3cH1Hj6dFsMto0H2YU8Oz
 CKXo/QBjmM3bGBj7edEwlkDvCYMQasg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-uclPm8j6O_iIu6mAsvpbew-1; Wed,
 27 Nov 2024 07:38:59 -0500
X-MC-Unique: uclPm8j6O_iIu6mAsvpbew-1
X-Mimecast-MFC-AGG-ID: uclPm8j6O_iIu6mAsvpbew
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE0E11955D55; Wed, 27 Nov 2024 12:38:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C16300019E; Wed, 27 Nov 2024 12:38:55 +0000 (UTC)
Date: Wed, 27 Nov 2024 12:38:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: Rust in QEMU roadmap
Message-ID: <Z0cS2y0Pk7eEdD1H@redhat.com>
References: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc40943e-dec1-4890-a1d9-579350ce296f@pbonzini.local>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Tue, Nov 26, 2024 at 06:46:45PM +0100, Paolo Bonzini wrote:
> Feature parity for pl011 device
> '''''''''''''''''''''''''''''''
> 
> Some recent pl011 commits are missing in the Rust version.  Philippe
> volunteered to port them to teach himself Rust.
> 
> Philippe also has a series to implement flow control and better use
> of the PL011 FIFO (IIUC).  Porting this to Rust would be hard right
> now, so its Rust implementation blocked on having chardev bindings.
> 
> Also missing is logging and tracing, but this part should not be a
> blocker for defaulting to --enable-rust.

I think it is OK to miss tracing as an exceptional one-off.

It is highly undesirable though for us to convert more than a
couple of devices (which currently use tracing) without having
tracing working. I consider tracing a critical feature for
supportability of QEMU.

IOW, I'm OK with lack of tracing not being a block for defaulting
to --enable-rust, provided it is accepted as being a high priority
item. Possibly call it a blocker for accepting conversions of
anything beyond pl011 & hpet, that currently has trace points.


> Tracing/logging
> '''''''''''''''
> 
> Tracepoints and logging are not supported yet, and no one has started working
> on it.
> 
> For tracing, it's not clear to me how much C code can be reused and how
> much Rust code can be automatically generated.  This would be a valid
> Outreachy or Summer of Code project, as it has a limited need for unsafe
> code and a well-defined scope.

As mentioned above, IMHO this needs to be treated as a high priority
item. While it would make a good Outreachy/GSoC project, I don't think
we should take that path, as it comes with no guarantee of a successful
timely delivery.

> A pure-Rust implementation would be interesting, but note that the usage
> of printf-style %-based field formatting is pervasive in the tracing
> subsystem.

Note that it is not unbounded printf style formatting. We are actually
pretty restricted in what we can use because our format strings are
required to be compatible with systemtap's formatter which is very
limited compared to C printf().

We've currently got an adhoc check to block use of '%m', but we could
easily make this a much stricter check on '%' and thus make it practical
to auto-convert our printf() style format strings to a format that rust
can use natively.

> Summary:
> 
> * Simple, low priority.

IMHO high priority. I don't want to enable Rust in Fedora/RHEL if
it going to degrade our ability to use tracing to debug production
deployments

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


