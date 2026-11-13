Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C6606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FvC8K3Dc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRpYD-0005F2-2f; Fri, 13 Nov 2026 06:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRpY9-0005EG-CF
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRpY5-0006Zw-CD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794569661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/BEVsonILxV5iw1I+Tm4GO4wkElnz67stj/oy9XOM8=;
 b=FvC8K3Dc3aibdTChLzvbaggth0I90CXHe2cB0BJz4oq3iGsPNmjiVEPDfp9DdzSAYuku8Y
 TotmiZLtrRchy7/qOMXuA1ieVYU1gGUQUVsjbxNOE7riS13vBlj4mNJmhQ/1tJzctGpP3F
 nshdwn8QqUbdxMFsBLTjCno/dVQQ6k0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-W3t1WKBRNi63phywrCpRNw-1; Fri,
 13 Nov 2026 06:34:06 -0500
X-MC-Unique: W3t1WKBRNi63phywrCpRNw-1
X-Mimecast-MFC-AGG-ID: W3t1WKBRNi63phywrCpRNw_1794569644
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC7AE1800595; Fri, 13 Nov 2026 11:34:03 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFC2830001B9; Fri, 13 Nov 2026 11:34:00 +0000 (UTC)
Date: Fri, 13 Nov 2026 11:33:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 04/28] hw: mark all remaining virtio object types as
 secure
Message-ID: <avb1pVvH5Ukynj4-@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-5-berrange@redhat.com>
 <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
 <CAMxuvazfhfGSZCiSi+viwJ7f7XDWAZfjmW39n3a7a-qQyw-YSA@mail.gmail.com>
 <au3mwO32b0-PSXKu@redhat.com>
 <CAMxuvayhYcOvH2QPptrKUQGFHoRxQcM1USF5OwuZYR_g2c4zgw@mail.gmail.com>
 <au4Pa4GFA4u-XQ7J@redhat.com> <avYM-3jVbW65NYyk@redhat.com>
 <87ik21asn4.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik21asn4.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:16:15AM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Alex, as the virtio-gpu* maintainer can you give your opinion
> > on the discussion below about virtio-gpu security tagging
> > vs our current security policy for "virtualization use case"
> > to ack/nack the proposal.
> 
> I'm inclined to agree with Marc-Andre here - the 3D GPU attack surface
> is large and for the in-QEMU handling we have a bunch of issues with GPU
> context handling between threads that make it tricky. Compounding that
> ruttabaga is not very well tested at all because its hard to enable
> without non-distro libs (for now).
> 
> Finally virtio-gpu is Odd Fixes so it's not getting the response times
> of other VirtIO stuff in terms of handling security issues.
> 
> We should encourage users to use vhost-user-gpu for 3D stuff because at
> least then the rendering pipeline and processing of guest controlled
> data is easier to sandbox.
> 
> So I'd say:
> 
>   - virtio-gpu for 2d - OK
>   - virtio-gpu for 3d via vhost - OK
>   - virtio-gpu for 3d in QEMU - Not OK

So, IIUC, in terms of what -device help reports, that would mean

Secure:

  name "vhost-user-gpu", bus virtio-bus
  name "vhost-user-gpu-pci", bus PCI
  name "virtio-gpu-device", bus virtio-bus
  name "virtio-gpu-pci", bus PCI, alias "virtio-gpu"

Not secure:

  name "virtio-gpu-gl-device", bus virtio-bus
  name "virtio-gpu-gl-pci", bus PCI, alias "virtio-gpu-gl"
  name "virtio-gpu-rutabaga-device", bus virtio-bus
  name "virtio-gpu-rutabaga-pci", bus PCI, alias "virtio-gpu-rutabaga"

?

>   
> Alex.
> 
> >
> > On Fri, Nov 06, 2026 at 05:33:31PM +0000, Daniel P. Berrangé wrote:
> >> On Fri, Nov 06, 2026 at 06:52:27PM +0400, Marc-André Lureau wrote:
> >> > Hi
> >> > 
> >> > On Fri, Nov 6, 2026 at 6:40 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> > >
> >> > > On Fri, Nov 06, 2026 at 06:35:29PM +0400, Marc-André Lureau wrote:
> >> > > > Hi
> >> > > >
> >> > > > On Fri, Nov 6, 2026 at 3:53 PM Thomas Huth <thuth@redhat.com> wrote:
> >> > > > >
> >> > > > > On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> >> > > > > > These are all intended for use in a virtualization scenario and must
> >> > > > > > provide a security boundary.
> >> > > > > >
> >> > > > > > Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> > > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > > > > > ---
> >> > > > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> > > > >
> >> > > >
> >> > > > I have a second thought about this, I'd like to exclude all
> >> > > > gpu-accelerated paths for now. virgl/mesa/rutabaga expose a very large
> >> > > > attack surface, so I'd like to drop them from the secure boundary
> >> > >
> >> > > Rather than repost, please see my response for patch 2:
> >> > >
> >> > >   https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg01530.html
> >> > >
> >> > > TL;DR: we have already promised anything virtio related is in scope
> >> > > for security handling for a long time, as they are all unambiguously
> >> > > "virtualization use case".
> >> > >
> >> > 
> >> > the value of a secure policy enforcement is low if we know those
> >> > devices are unsecure and don't have the resources to make them secure.
> >> 
> >> It isn't a great situation to be in, but we're already there for any
> >> virtio devices based on our existing policies for bug handling and
> >> security triage. We can't promise we'll get fixes for all CVEs quickly,
> >> but we will at least assign CVEs so that users are aware when there
> >> are known problems.
> >> 
> >> This contrasts to other devices where problems will remain largely
> >> hidden for view, as we treat them as normal bugs and never call our
> >> security concerns when committing changes.
> >> 
> >> With regards,
> >> Daniel
> >> -- 
> >> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> >> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> >> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> >> 
> >> 
> >
> > With regards,
> > Daniel
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


