Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E986DC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texmL-0001sL-Be; Mon, 03 Feb 2025 09:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1texmF-0001cq-M8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1texmD-0003Xm-AO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738594215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRdVTiz2dg/Lm02eYt2/LxZKD8DauGBX6v2e41VDF4o=;
 b=Ky4/YOJFqYejw9vuhxgnKcHHQg3Hg11CMIfsRNZkR2C3wcTh/ufQae0LFMxiWuepjYGDBR
 6zUFUaSf7e+Ql9sbavflovySdklXOx6sgOh67/tpwmQpIVKxCXTlsRb7H1f20/5ZSXtwux
 SJoJnVcHEB/+Hp1af3JuCtrMgQPYtNs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-s-B3xsWRP3K4OiVP8404KA-1; Mon,
 03 Feb 2025 09:50:11 -0500
X-MC-Unique: s-B3xsWRP3K4OiVP8404KA-1
X-Mimecast-MFC-AGG-ID: s-B3xsWRP3K4OiVP8404KA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADFD818009B7; Mon,  3 Feb 2025 14:50:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A655E180035E; Mon,  3 Feb 2025 14:50:03 +0000 (UTC)
Date: Mon, 3 Feb 2025 14:50:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Jared Mauch <jared+home@puck.nether.net>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 0/7] hw/arm/raspi4b: Add models with 4GB and 8GB of DRAM
Message-ID: <Z6DXmN-ROswsaDAi@redhat.com>
References: <20250201091528.1177-1-philmd@linaro.org>
 <90d87f0e-56a3-8966-614c-364f3e726d61@eik.bme.hu>
 <CAFEAcA_mBXO20NhYRHJCgkB0h8uYQQhBMdwVW376R4u-qh51nA@mail.gmail.com>
 <87ed0fayoy.fsf@draig.linaro.org> <Z6DTsdf35ApQ0qLU@redhat.com>
 <CAFEAcA8Qigt1EBVgz1D4hon0x4ukLZbZ-jS_KB+ZBH0yi+QCXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8Qigt1EBVgz1D4hon0x4ukLZbZ-jS_KB+ZBH0yi+QCXw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 03, 2025 at 02:45:06PM +0000, Peter Maydell wrote:
> On Mon, 3 Feb 2025 at 14:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 02:29:49PM +0000, Alex Bennée wrote:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > >
> > > > On Sat, 1 Feb 2025 at 12:57, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > > >>
> > > >> On Sat, 1 Feb 2025, Philippe Mathieu-Daudé wrote:
> > > >> > - Deprecate the 'raspi4b' machine name, renaming it as
> > > >> >  'raspi4b-1g' on 32-bit hosts, 'raspi4b-2g' otherwise.
> > > >> > - Add the 'raspi4b-4g' and 'raspi4b-8g' machines, with
> > > >> >  respectively 4GB and 8GB of DRAM.
> > > >>
> > > >> IMHO (meaning you can ignore it, just my opinion) if the only difference
> > > >> is the memory size -machine raspi4b -memory 4g would be better user
> > > >> experience than having a lot of different machines.
> > > >
> > > > Yes, I think I agree. We have a way for users to specify
> > > > how much memory they want, and I think it makes more sense
> > > > to use that than to have lots of different machine types.
> > >
> > > I guess for the Pi we should validate the -memory supplied is on of the
> > > supported grid of devices rather than an arbitrary value?
> >
> > If the user wants to create a rpi4 with 6 GB RAM why should we stop
> > them ? It is their choice if they want to precisely replicate RAM
> > size from a physical model, or use something different when virtualized.
> 
> The board revision code (reported to the guest via the emulated
> firmware interface) only supports reporting 256MB, 512MB,
> 1GB, 2GB, 4GB or 8GB:
> 
> https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#new-style-revision-codes

I think it would be valid to report the revision code for the memory
size that doesn't exceed what QEMU has configured. eg if configured
with 6 GB, then report code for 4 GB. 

> For Arm embedded boards we mostly tend to "restrict the user
> to what you can actually do", except for older boards where
> we tended not to write any kind of sanity checking on CPU
> type, memory size, etc.

If we're going to strictly limit memory size that's accepted I wonder
how we could information users/mgmt apps about what's permitted ?

Expressing valid combinations of configs across different args gets
pretty complicated quickly :-(


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


