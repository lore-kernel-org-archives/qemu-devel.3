Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9CDC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfGXR-0005Yt-IT; Tue, 04 Feb 2025 05:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfGXQ-0005YV-Aa
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfGXO-0001Lw-HS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738666332;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GlSCs3CxU85WJ5JTuwL2PiTF6MIOBHntqrOayzb2jw=;
 b=Muhu+mIHPSx+98sSf5y5DxvP6DVOvVnrCgV81ho/13L9VY40w73qhXLckw3M2zVzY79Vji
 nd7mCefO+6VzZVTA7uJ0OYcXx+N62xLJk0y7WKTNKjTXb5sWGXnjsMoeZ0gEakqNbpgoHU
 gKp48uGjSvKc6OiLaprLP6bPoDev+30=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-TmxiyW06NlGpR9t9lPfZgA-1; Tue,
 04 Feb 2025 05:52:11 -0500
X-MC-Unique: TmxiyW06NlGpR9t9lPfZgA-1
X-Mimecast-MFC-AGG-ID: TmxiyW06NlGpR9t9lPfZgA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E35D1800269; Tue,  4 Feb 2025 10:52:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3749318008C8; Tue,  4 Feb 2025 10:52:02 +0000 (UTC)
Date: Tue, 4 Feb 2025 10:51:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
Message-ID: <Z6HxT6cHJTUNwRbB@redhat.com>
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <Z6HklNsu0Mzgh7bC@redhat.com>
 <18ebe0c3-7ae6-4ba4-92f1-452a613d2c8d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18ebe0c3-7ae6-4ba4-92f1-452a613d2c8d@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 04, 2025 at 11:48:10AM +0100, Philippe Mathieu-Daudé wrote:
> On 4/2/25 10:57, Daniel P. Berrangé wrote:
> > On Tue, Feb 04, 2025 at 10:51:04AM +0100, Philippe Mathieu-Daudé wrote:
> > > On 4/2/25 10:22, Peter Maydell wrote:
> > > > On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > > > 
> > > > > All previous raspi machines can be created using the
> > > > > generic machine. Deprecate the old names to maintain
> > > > > a single one. Update the tests.
> > > > > 
> > > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > 
> > > > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > > > index 4a3c302962a..c9a11a52f78 100644
> > > > > --- a/docs/about/deprecated.rst
> > > > > +++ b/docs/about/deprecated.rst
> > > > > @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
> > > > >    Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
> > > > >    CPUs. Big endian support is not tested.
> > > > > 
> > > > > +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and ``raspi4b`` machines (since 10.0)
> > > > > +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > > > > +
> > > > > +The Raspberry Pi machines have been unified under the generic ``raspi`` machine,
> > > > > +which takes the model as argument.
> > > > > +
> > > > > +    - `raspi0`` is now an alias for ``raspi,model=Zero``
> > > > > +    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
> > > > > +    - `raspi2b`` is now an alias for ``raspi,model=2B``
> > > > > +    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
> > > > > +    - `raspi3b`` is now an alias for ``raspi,model=3B``
> > > > > +    - `raspi4b`` is now an alias for ``raspi,model=4B``
> > > > 
> > > > This is not how we typically handle "we have a bunch
> > > > of different devboards in one family". What's wrong with the
> > > > existing set of machine names?
> > > 
> > > Zoltan and you don't want to add more machine names, then you
> > > don't want a generic machine. This is very confusing.
> > 
> > IMHO we can have distinct machines for each model, but
> > *NOT* have further machines for each RAM size within a
> > model.
> 
> Got it. Unfortunately I spent more than my hobbyist time credit
> doing this, so if I find the motivation to revisit, it'll be later.
> 
> Still, having machine memory size depending on the host config was
> a bad design choice IMHO, as we test different setup depending on
> the host being used, so not really a "reproducible" setup.

Yeah that one is a bit ugly. IMHO it would be valid to just leave
it defaulted to 2GB and ensure we get a nice error message on
32-bit hosts, letting users override RAM size if they desire. Or
its just another reason to kill 32-bit hosts

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


