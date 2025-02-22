Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B88C021B2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2025 22:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlxkW-0005gY-7S; Sat, 22 Feb 2025 17:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jared@puck.nether.net>)
 id 1tlxVu-0003D6-NY; Sat, 22 Feb 2025 16:58:22 -0500
Received: from puck.nether.net ([2602:fe55:5::5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jared@puck.nether.net>)
 id 1tlxVs-0001hv-VT; Sat, 22 Feb 2025 16:58:22 -0500
Received: by puck.nether.net (Postfix, from userid 1001)
 id 9F59D5400DF; Sat, 22 Feb 2025 21:57:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 puck.nether.net 9F59D5400DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puck.nether.net;
 s=default; t=1740261453;
 bh=+vH81h2+gcP1e4jqnnnOikYQLL4SWMws0tQgd5wZBQU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=deMe6SogxScbIBtYG0nvccbTeBw+aOgdY8fgSNzGIBjAhy+rsIHudQj96gqX0vT/U
 61zuj0f7HCjq+FcpRtKPtGmXFD5SMFwvQVxK+WQxZuQnAb1yCxu+/AvbThsMIITjHw
 LT6BaKRc5rhkHFXxEJugjlvOz2I+yCro+LzzIzst+t5g9Dz73ou3SMwZByMTBtrgC0
 cbmgUx1WHdoTRNJYjamm1LzkBKZtWc1NFs07LoWrsPoKILgXGQnMz309i5LoFpBvFY
 IFffxAmEK1PJBdTty4BhH6o1Glu9DXaHz/CkD3V7fplOShqJeCmT0YtYM26KkXYn8R
 KZA6D0ZSU8hLQ==
Date: Sat, 22 Feb 2025 21:57:33 +0000
From: Jared Mauch <jared@puck.nether.net>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
Message-ID: <Z7pITScHfXSk-Liy@puck.nether.net>
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <1ec3cd49-7fe8-9c80-212d-68939580b8ce@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ec3cd49-7fe8-9c80-212d-68939580b8ce@eik.bme.hu>
Received-SPF: pass client-ip=2602:fe55:5::5;
 envelope-from=jared@puck.nether.net; helo=puck.nether.net
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 22 Feb 2025 17:13:26 -0500
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 04, 2025 at 10:58:39AM +0100, BALATON Zoltan wrote:
> On Tue, 4 Feb 2025, Philippe Mathieu-Daudé wrote:
> > On 4/2/25 10:22, Peter Maydell wrote:
> > > On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daudé
> > > <philmd@linaro.org> wrote:
> > > > 
> > > > All previous raspi machines can be created using the
> > > > generic machine. Deprecate the old names to maintain
> > > > a single one. Update the tests.
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > 
> > > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > > index 4a3c302962a..c9a11a52f78 100644
> > > > --- a/docs/about/deprecated.rst
> > > > +++ b/docs/about/deprecated.rst
> > > > @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze
> > > > ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
> > > >   Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added
> > > > for little endian
> > > >   CPUs. Big endian support is not tested.
> > > > 
> > > > +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``,
> > > > ``raspi3b`` and ``raspi4b`` machines (since 10.0)
> > > > +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > > > +
> > > > +The Raspberry Pi machines have been unified under the generic
> > > > ``raspi`` machine,
> > > > +which takes the model as argument.
> > > > +
> > > > +    - `raspi0`` is now an alias for ``raspi,model=Zero``
> > > > +    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
> > > > +    - `raspi2b`` is now an alias for ``raspi,model=2B``
> > > > +    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
> > > > +    - `raspi3b`` is now an alias for ``raspi,model=3B``
> > > > +    - `raspi4b`` is now an alias for ``raspi,model=4B``
> > > 
> > > This is not how we typically handle "we have a bunch
> > > of different devboards in one family". What's wrong with the
> > > existing set of machine names?
> > 
> > Zoltan and you don't want to add more machine names, then you
> > don't want a generic machine. This is very confusing.
> 
> I said either rastpi4b,revision=1.4 or -machine raspi4b -memory 4g would be
> better IMHO. Peter perefers -memory which is also fine with me. I just don't
> think adding more machine names where only RAM size is different would be
> better than using -memory for that as usual.

	I'm the annoying root cause of this as I had filed this:
https://gitlab.com/qemu-project/qemu/-/issues/2797#note_2326724893

Which was really a question around providing more memory options, I'm
happy seeing a lot of thought has gone into my simple question/request,
but it's unclear reading this thread where things concluded.

	Is there a chance these are in a branch that one could build
against to get consensus on some of this style vs substance stuff?  I
get it that it's tricky and do generally think that one could restrict
armhf vs arm64 to having 64-bit support in the (hypervisor) OS.

	I was wanting to tweak some disk images before imaging a bunch
of nvme for use and saw using kvm/qemu as a straightforward path to
doing that on my laptop (x86_64) before firing up a bunch of compute
modules etc.

	- Jared
[i'm not subscribed to the qemu-dev list, so I expect mailman will
hold/bounce me]

-- 
Jared Mauch  | pgp key available via finger from jared@puck.nether.net
clue++;      | http://puck.nether.net/~jared/  My statements are only mine.

