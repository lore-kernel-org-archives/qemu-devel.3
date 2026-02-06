Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF1EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQEE-0002kQ-B1; Fri, 06 Feb 2026 13:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1voQE6-0002G2-Ke
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1voQE4-0001e9-IP
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770401199;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eg8QhCmfUHbNTO3Euz9JexgDwRg0VAKa4+wNzew6To8=;
 b=LGwBft/95GCMqvUv1NQHCpXSXpbNEsVO7wjlxa/ciJWftDo36cp6gVZaxYD+XAD4GmipPc
 H9uFPKdofzDS1xwoSyFRSLzHlo2abdNClLJ7IaPWsCEs+PEVaF1QDTbDOQrHYX0dW3Ma+N
 QxaJdJKFKVRqZTct83LFVvvObReTiDk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549--x-dOippOYW9TmMDPnOJ_A-1; Fri,
 06 Feb 2026 13:06:36 -0500
X-MC-Unique: -x-dOippOYW9TmMDPnOJ_A-1
X-Mimecast-MFC-AGG-ID: -x-dOippOYW9TmMDPnOJ_A_1770401194
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3B58195608F; Fri,  6 Feb 2026 18:06:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.75])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB14D18003F6; Fri,  6 Feb 2026 18:06:29 +0000 (UTC)
Date: Fri, 6 Feb 2026 18:06:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH 01/29] hw/core: Add Remote Port protocol packet definition
Message-ID: <aYYtoTZvHtG_jsC-@redhat.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
 <20260205195824.2610192-2-ruslichenko.r@gmail.com>
 <aYT_4NYQDbCyfS1c@redhat.com>
 <CAN-aV1HdTaJEtLU8uWcatB-9EZkNu=AkB_ZC5CdwMo6zXe9yXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN-aV1HdTaJEtLU8uWcatB-9EZkNu=AkB_ZC5CdwMo6zXe9yXQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Feb 06, 2026 at 06:45:37PM +0100, Ruslan Ruslichenko wrote:
> On Thu, Feb 5, 2026 at 9:39 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Feb 05, 2026 at 08:57:56PM +0100, Ruslan Ruslichenko wrote:
> > > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > >
> > > Introduce packet definition for Remote Port protocol.
> > >
> > > Remote Port is a socket based inter-simulation protocol
> > > designed to connect QEMU to external simulator (such as
> > > SystemC models, RTL simulators, etc) for hardware co-
> > > simulation.
> > >
> > > The protocol supports bidirectional communication for:
> > > - Connection setup, version negotiation (Hello/Cfg packets)
> > > - Memory and MMIO transactions (Read/Write packets)
> > > - Interrupts and GPIO signaling (Interrupt packets)
> > > - Time synchronization (Sync packets)
> > >
> > > The patch introduces header file with packet definition
> > > used by protocol.
> > >
> > > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > > Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
> > > Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > > ---
> > >  include/hw/core/remote-port-proto.h | 305 ++++++++++++++++++++++++++++
> > >  1 file changed, 305 insertions(+)
> > >  create mode 100644 include/hw/core/remote-port-proto.h
> > >
> > > diff --git a/include/hw/core/remote-port-proto.h b/include/hw/core/remote-port-proto.h
> > > new file mode 100644
> > > index 0000000000..cbe1498df0
> > > --- /dev/null
> > > +++ b/include/hw/core/remote-port-proto.h
> > > @@ -0,0 +1,305 @@
> > > +// SPDX-License-Identifier: MIT
> >
> > Preferrably stick this inside the comment block below instead of
> > mixing C and C++ style comments.
> >
> > > +/*
> > > + * QEMU remote port protocol parts.
> > > + *
> > > + * Copyright (c) 2013 Xilinx Inc
> > > + * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > > + *
> > > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > > + * of this software and associated documentation files (the "Software"), to deal
> > > + * in the Software without restriction, including without limitation the rights
> > > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > > + * copies of the Software, and to permit persons to whom the Software is
> > > + * furnished to do so, subject to the following conditions:
> > > + *
> > > + * The above copyright notice and this permission notice shall be included in
> > > + * all copies or substantial portions of the Software.
> > > + *
> > > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > > + * THE SOFTWARE.
> >
> > Including this is OK, since IIUC in this case you're carrying on
> > with someone else's code, and so aren't permitted to remove their
> > license comment.
> >
> > If there are any files later in the series that you wrote yourself
> > from scratch though, they can omit any license comments, only the
> > SPDX is need.
> >
> 
> Understood.
> Basically all headers in the patch series were already present, which
> is the reason I left them.
> 
> >
> > > + */
> > > +#ifndef REMOTE_PORT_PROTO_H__
> > > +#define REMOTE_PORT_PROTO_H__
> > > +
> > > +/*
> > > + * Remote-Port (RP) is an inter-simulator protocol. It assumes a reliable
> > > + * point to point communcation with the remote simulation environment.
> > > + *
> > > + * Setup
> > > + * In the SETUP phase a mandatory HELLO packet is exchanged with optional
> > > + * CFG packets following. HELLO packets are useful to ensure that both
> > > + * sides are speaking the same protocol and using compatible versions.
> > > + *
> > > + * CFG packets are used to negotiate configuration options. At the moment
> > > + * these remain unimplemented.
> > > + *
> > > + * Once the session is up, communication can start through various other
> > > + * commands. The list can be found further down this document.
> > > + * Commands are carried over RP packets. Every RP packet contains a header
> > > + * with length, flags and an ID to track potential responses.
> > > + * The header is followed by a packet specific payload. You'll find the
> > > + * details of the various commands packet layouts here. Some commands can
> > > + * carry data/blobs in their payload.
> > > + */
> > > +
> > > +
> > > +#define RP_VERSION_MAJOR 4
> > > +#define RP_VERSION_MINOR 3
> > > +
> > > +#if defined(_WIN32) && defined(__MINGW32__)
> > > +/* mingw GCC has a bug with packed attributes.  */
> > > +#define PACKED __attribute__ ((gcc_struct, packed))
> > > +#else
> > > +#define PACKED __attribute__ ((packed))
> > > +#endif
> >
> > Is this comment & conditional #define still relevant today ?
> >
> > For the rest of QEMU we just use  QEMU_PACKED whose definition matches
> > the #else clause. Ideally change the patch to use QEMU_PACKED, if not,
> > mention in the commit message why it can't be used.
> >
> 
> I will double check. Might be some old mingw version which is not actual today.

We have CI jobs for mingw on gitlab. If you fork the repo, and push your
branch to your gitlab fork, while setting "QEMU_CI=2", it'll run the
CI jobs. The file docs/devel/testing/ci-jobs.rst.inc has more info.

If it passes with the CI (current mingw in Fedora, and with latest Msys2 on
Windows) then that's sufficient.  We don't try to support older versions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


