Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5115606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F/yoLZPD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMNoJ-0004FR-Hx; Thu, 29 Oct 2026 06:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMNoH-0004Ey-0o
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMNoF-000804-2M
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793271396;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/TObVUdpEQS51CMLsBlkgOOzxelRzlOJyei+dyv4yM=;
 b=F/yoLZPDv480D1HOWJrDS/a4vQB+AyQuUHURP8rZGY/f/sc4pTGjzZlfM/jXnutOVUVBv2
 eWX0K5DUmLdOdGA/xVABq1lxYYnb0HgMUGH355X53a+gFjKwck4sEnCjmYZobXPTayS1ee
 BRRlgWzhEG2NpEXq53ilCLa8CvP9g40=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-F7EVaGa5PJefAuwbiP1JxQ-1; Thu,
 29 Oct 2026 06:56:35 -0400
X-MC-Unique: F7EVaGa5PJefAuwbiP1JxQ-1
X-Mimecast-MFC-AGG-ID: F7EVaGa5PJefAuwbiP1JxQ_1793271394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76C381955EAA
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:56:34 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10A91956088; Thu, 29 Oct 2026 10:56:33 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:56:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 7/8] qemu-options: document -compat insecure-input
 parameter
Message-ID: <auMmXsaXkKTzy4Mj@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-8-berrange@redhat.com>
 <871p99gfrf.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871p99gfrf.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 07:52:36AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This adds documentation for the previously added 'insecure-input'
> > parameter to -compat, which controls policy for insecure
> > configuration requests.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  qemu-options.hx | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 16d9c6c9072..0487e74bb3e 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4696,7 +4696,9 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
> >      "-compat [deprecated-input=accept|reject|crash|warn][,deprecated-output=accept|hide]\n"
> >      "                Policy for handling deprecated management interfaces\n"
> >      "-compat [unstable-input=accept|reject|crash|warn][,unstable-output=accept|hide]\n"
> > -    "                Policy for handling unstable management interfaces\n",
> > +    "                Policy for handling unstable management interfaces\n"
> > +    "-compat [insecure-input=accept|reject|crash|warn]\n"
> > +    "                Policy for handling requests for insecure configuration requests\n",
> >      QEMU_ARCH_ALL)
> >  SRST
> >  ``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``
> > @@ -4734,6 +4736,24 @@ SRST
> >          Suppress unstable command results and events
> >  
> >      Limitation: covers only syntactic aspects of QMP.
> > +
> > +``-compat [insecure-input=<input-policy>]
> > +    Set policy for handling requests for insecure configuration
> > +    requests:
> > +
> > +    ``insecure-input=accept`` (default)
> > +        Accept insecure configurations requests silently
> > +    ``insecure-input=warn``
> > +        Accept insecure configuration requests with warning on stderr
> > +    ``insecure-input=reject``
> > +        Reject insecure configuration requests
> > +    ``insecure-input=crash``
> > +        Crash on insecure configuration requests
> > +
> > +    Limitation: an insecure configuration is one where QEMU has
> > +    not intended to provide a security boundary to protect against
> 
> "Where QEMU has not intended to provide" sounds odd to me.  Mind, I'm
> not a native speaker.  "Where QEMU does not provide".

Yeah, that language choice was me by pessimistic expecting that
QEMU is full of undiscovered flaws. I'll change to what you
suggested.

> > +    malicious usage. Covers only QOM types for devices, machine types
> > +    and accelerators.
> 
> The policy check is in
> 
> * qemu_create_machine(), which covers machine creation.
> 
> * do_configure_accelerator(), which covers accelerator creation.
> 
> * qdev_device_add_from_qdict(), which covers *some* device creation:
> 
>   * device_add and -device always
> 
>   * Half of -audio model=hda: covers the "intel-hda" device, but not the
>     "hda-duplex" device.  See intel_hda_and_codec_init().
> 
>   * The "primary device" created in failover_hide_primary_device() for
>     the virtio-net standby feature.
> 
>   * The "usb-host" device device created in xen-usb.c for some reason.
> 
>   There's plenty of device creation it doesn't cover.  Isn't this
>   problematic?  I certainly expected it to cover *all* device creation!

Yes, eventually, but not yet....

> 
>   Say board code creates a certain onboard device with the usual low
>   level interfaces like qdev_new() and qdev_realize().  Say we mark the
>   onboard device insecure.  The policy check doesn't apply.  We need to
>   manually mark the machine type insecure as well.  Feels awfully prone
>   to human error.
> 
>   Moreover, what if the onboard device is configurable?  Then the
>   machine type may be secure unless you configure this insecure device.
>   Marking the machine type would be too coarse.
> 
>   Could we check policy in qdev_realize() instead?

Yes and no.

To make this a tractable problem I only wanted to add '.secure = true'
annotations for public facing types initially, so needed the check in
the device_add/-device code path only.

This is sufficient to let us tell bug report filers to take their demo
command line and add

  '-compat insecure-input=reject -nodfaults'

as a pre-requisite for a bug being considered a security flaw
egligible for CVE handling.


If we put a check in qdev_realize(), then we need to add annotations
for *all* types, before the -compat insecure-input=....  option is
viable to use. That requires a much bigger effort to mark all types.

In the 12.0 dev cycle, my intention is to

 a) Expand ".secure = true" markers to all parents of leaf node types
    marked secure, and enforce them.
 b) Expand ".secure = true" markers to all built-in devices that are
    indirectly created by a leaf node type marked secure, when
    -nodefaults is present

Once (b) is done, then qdev_realize() will likely be the better place
to put the policy check.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


