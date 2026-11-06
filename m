Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABEF606A334
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V/2Kl+m/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJPi-0006LN-Ok; Fri, 06 Nov 2026 07:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPJPh-0006Kn-3K
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPJPd-0002oe-HV
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793969480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iv0wgzQdQwW6Zt66pkugM8HFN44VVFjIuPLIVCectAk=;
 b=V/2Kl+m/1Arc6rkxKbY2sviEyy8CPPQecWZZM0yF6zMqwLshETgGCspCoBG5E08vrUhPlD
 f+ZA2sL3MQYKKJJCPaFOGKfgHX5qOBEggYPtl1oDRxqO29649Mtisxr42gZWk/0YbDndrR
 TeIPeVhNNgrBZWQ8fnAk2xJ2t7RV1OY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-r2I5z7qsOWOaWZUHg1aTyg-1; Fri,
 06 Nov 2026 07:51:16 -0500
X-MC-Unique: r2I5z7qsOWOaWZUHg1aTyg-1
X-Mimecast-MFC-AGG-ID: r2I5z7qsOWOaWZUHg1aTyg_1793969475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6A521956051; Fri,  6 Nov 2026 12:51:14 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9D841956087; Fri,  6 Nov 2026 12:51:11 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:51:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 02/28] hw: mark all virtio CCW devices as secure
Message-ID: <au3NPLpvDua_eefG@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-3-berrange@redhat.com>
 <b3820b45-7d26-4b4a-aec7-cfcd5aaf5d96@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3820b45-7d26-4b4a-aec7-cfcd5aaf5d96@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 12:38:09PM +0100, Thomas Huth wrote:
> On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> > These are all intended for use in a virtualization scenario and must
> > provide a security boundary.
> > 
> > Acked-by: Eric Farman <farman@linux.ibm.com>
> > Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> ...
> > diff --git a/hw/s390x/virtio-ccw-9p.c b/hw/s390x/virtio-ccw-9p.c
> > index d8612f7cd13..08d3ee577b4 100644
> > --- a/hw/s390x/virtio-ccw-9p.c
> > +++ b/hw/s390x/virtio-ccw-9p.c
> > @@ -64,6 +64,7 @@ static const TypeInfo virtio_ccw_9p_info = {
> >       .instance_size = sizeof(V9fsCCWState),
> >       .instance_init = virtio_ccw_9p_instance_init,
> >       .class_init    = virtio_ccw_9p_class_init,
> > +    .secure        = true,
> >   };
> I wonder whether we really want to include virtio-9p in the list of secure
> devices ... but in case we reconsider, I guess that can be refined later,
> so:

In terms of what we've documented about "virtualization use case"
being the criteria for security triage, I consider everything
related to virtio- to be already in-scope and not up for debate.
No one reading our current docs would expect anything "virtio" to
fall under the non-virtualization use case.

Now we have this explicit marker though, we can consider being more
fine grained in what we cover though. The question is how / when we
move a device from the "secure" to "not secure" bucket.

That direction should be very rare, because users need to have long
term certainty about what's treated secure. Our machine type
guarantees last for 6 years, 3 years of new VM deployments and
3 years deprecated where they should only be used for incoming
migrations/restores from saved state. Virtualization users / vendors
will expect security coverage for this kind of timeframe.

When we have maintainership problems with certain devices, if they
are marked secure, those are something we need to flag as priority
to various vendors like Red Hat who provide resource/investment
to QEMU. They're shipping this stuff and promising CVE fixes to
their paying customers and that needs to translate to investment
in QEMU upstream, though in the 9p case Red Hat does not actually
ship this particular device.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


