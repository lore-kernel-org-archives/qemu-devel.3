Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E32EC88E65
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64hK-0002iS-DF; Mon, 14 Sep 2026 07:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x64hG-0002iA-6i
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:18:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x64hE-0006gC-10
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789384678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+Ibxe+0eEoJtZ5YeC9lO56hTSJUc3hskCco7sIJr18=;
 b=M1ViH/7QziNSiBKnvg1Ou5hnVe6bpu0CZQ2dCB9L1J373wP+etn7DNXLKKbFF0Tz2NcUNU
 VCErkt/RMvoksmXLtrLOa/ao70EOpLAucoSm9ITqPtY/nzDF/q2XghdHMsT6y3UvbUSXRo
 c0ohjLh3Mio+TTRohn7vkz3B5bDPYj4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-6DmA_GqhMR6_bnL4jmOhEw-1; Mon,
 14 Sep 2026 07:17:54 -0400
X-MC-Unique: 6DmA_GqhMR6_bnL4jmOhEw-1
X-Mimecast-MFC-AGG-ID: 6DmA_GqhMR6_bnL4jmOhEw_1789384673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2990195422F; Mon, 14 Sep 2026 11:17:52 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FEA61800579; Mon, 14 Sep 2026 11:17:50 +0000 (UTC)
Date: Mon, 14 Sep 2026 12:17:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
Message-ID: <aqfX2414cAMCcI18@redhat.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Sep 14, 2026 at 11:41:51AM +0200, Paolo Bonzini wrote:
> Il lun 14 set 2026, 07:54 Pierrick Bouvier <
> pierrick.bouvier@oss.qualcomm.com> ha scritto:
> 
> > On 9/13/26 9:57 PM, Paolo Bonzini wrote:
> > >
> > >
> > > Il ven 11 set 2026, 19:49 Alex Bennée <alex.bennee@linaro.org
> > > <mailto:alex.bennee@linaro.org>> ha scritto:
> > >
> > >     Thanks for pointing this out. I hadn't noticed the issue as I guess
> > we
> > >     don't build firmware in the CI. That said on my current tree:
> > >
> > >       cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
> > >       make
> > >       -Wno-stringop-overflow detected
> > >       -fno-stack-protector detected
> > >       -Wno-array-bounds detected
> > >       -Wno-gnu detected
> > >       -march=z900 detected
> > >       Assembling start.o
> > >       Compiling main.o
> > >       Compiling bootmap.o
> > >       Compiling jump2ipl.o
> > >       Compiling sclp.o
> > >       Compiling menu.o
> > >       Compiling netmain.o
> > >       Compiling virtio.o
> > >       Compiling virtio-net.o
> > >       Compiling virtio-scsi.o
> > >       Compiling virtio-blkdev.o
> > >       Compiling cio.o
> > >       Compiling dasd-ipl.o
> > >       Compiling virtio-ccw.o
> > >       Compiling clp.o
> > >       Compiling pci.o
> > >       Compiling virtio-pci.o
> > >       Compiling secure-ipl.o
> > >       Linking s390-ccw.elf
> > >       Stripping s390-ccw.elf into s390-ccw.img
> > >
> > >     So it seems to be working. How do you usually invoke the build?
> > >
> > >      > Fearing the worst, I started converting to use meson directly
> > (which
> > >      > is probably a noble goal anyway). I still don't have a workable
> > >     image,
> > >      > as inheriting the common meson cc/ld flags exposes a bunch of
> > other
> > >      > problems. Will keep poking, but I'd like to know if there's an
> > >      > easier/better option here?
> > >
> > >     I suspect the easiest way would be to move the rom specific cross
> > >     compiler detection into a configure script within pc-bios. Paolo
> > wdyt?
> > >
> > >
> > > I would prefer to revert this and load the config file from meson
> > instead.
> > >
> > > Paolo
> > >
> >
> > I would be happy to see only the related part reverted if possible, and
> > not all the patch. That said, no strong opinion, just a preference to
> > avoid seeing people start depending on this config file for other
> > things, instead of doing things properly in meson.
> >
> 
> This is documented as a task for configure, so I don't think it's a problem
> not to do it in meson. In fact creating containers is not done by meson
> (it's done by make) so there is no real reason to do it outside configure.

Are you referring to the tests/docker/Makefile.include targets ?

Pierrick's series here directly invokes docker.py from meson instead
of the targets from tests/docker/Makefile.

IMHO it would be nice to replace tests/docker/Makefile.include with
a meson.build too. Yes, that would make it rely on a configured
build tree, but IMHO that's an acceptable tradeoff to get more
stuff into meson natively.

> 
> Having firmware have its own configure script is also bad, since you end up
> having code duplication.
> 
> Overall, I don't see the big issue in reverting this patch.

NB, if this is reverted then we'll need to pull back in the fix I
dropped:

  https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg01624.html

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


