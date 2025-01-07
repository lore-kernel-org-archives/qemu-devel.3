Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB01E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4ge-00063H-1a; Tue, 07 Jan 2025 03:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tV4gT-0005nz-E4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tV4gR-0004xH-BU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736237486;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKjZj8wgvdvJUl535Hq8Ejv09YTkfjgI19B10LJ+thk=;
 b=JzSagXqjX3q9if+PEMzLl/HG4TS5QGw4vwCFugqY6EQw0LLP6bqrHthoLDRpfy2p//ryup
 ncUIfwIxmaXpJH7IlahQPj/hwUmhwoVRTpxo18OT4wWgjjgcTEJdnfGxRkgEAYNHfLirO9
 q7r3XbLXhi3zHxC7ZiRjaHBl+zbSid8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-8L7MKuzqOLm3hAcznl55IQ-1; Tue,
 07 Jan 2025 03:11:22 -0500
X-MC-Unique: 8L7MKuzqOLm3hAcznl55IQ-1
X-Mimecast-MFC-AGG-ID: 8L7MKuzqOLm3hAcznl55IQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50E3619560BA; Tue,  7 Jan 2025 08:11:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C27F195605F; Tue,  7 Jan 2025 08:11:14 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:11:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v11 2/2] tpm: add backend for mssim
Message-ID: <Z3zhkEZ0NSM7Rlvp@redhat.com>
References: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
 <20241212170528.30364-3-James.Bottomley@HansenPartnership.com>
 <Z2RaYsLkazgciofM@redhat.com>
 <f83258defb96927b2656c2834108f9603bdd0e9a.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f83258defb96927b2656c2834108f9603bdd0e9a.camel@HansenPartnership.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 06, 2025 at 06:11:09PM -0800, James Bottomley wrote:
> On Thu, 2024-12-19 at 17:39 +0000, Daniel P. Berrangé wrote:
> > On Thu, Dec 12, 2024 at 12:05:28PM -0500, James Bottomley wrote:
> > > The Microsoft Simulator (mssim) is the reference emulation platform
> > > for the TCG TPM 2.0 specification.
> > > 
> > > https://github.com/Microsoft/ms-tpm-20-ref.git
> > > 
> > > It exports a fairly simple network socket based protocol on two
> > > sockets, one for command (default 2321) and one for control
> > > (default
> > > 2322).  This patch adds a simple backend that can speak the mssim
> > > protocol over the network.  It also allows the two sockets to be
> > > specified on the command line.  The benefits are twofold: firstly
> > > it
> > > gives us a backend that actually speaks a standard TPM emulation
> > > protocol instead of the linux specific TPM driver format of the
> > > current emulated TPM backend and secondly, using the microsoft
> > > protocol, the end point of the emulator can be anywhere on the
> > > network, facilitating the cloud use case where a central TPM
> > > service
> > > can be used over a control network.
> > > 
> > > The implementation does basic control commands like power off/on,
> > > but
> > > doesn't implement cancellation or startup.  The former because
> > > cancellation is pretty much useless on a fast operating TPM
> > > emulator
> > > and the latter because this emulator is designed to be used with
> > > OVMF
> > > which itself does TPM startup and I wanted to validate that.
> > > 
> > > To run this, simply download an emulator based on the MS
> > > specification
> > > (package ibmswtpm2 on openSUSE) and run it, then add these two
> > > lines
> > > to the qemu command and it will use the emulator.
> > > 
> > >     -tpmdev mssim,id=tpm0 \
> > >     -device tpm-crb,tpmdev=tpm0 \
> > > 
> > > to use a remote emulator replace the first line with
> > > 
> > >     -tpmdev
> > > "{'type':'mssim','id':'tpm0','command':{'type':inet,'host':'remote'
> > > ,'port':'2321'}}"
> > > 
> > > tpm-tis also works as the backend.
> > > 
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > 
> > > ---
> > > 
> > > v2: convert to SocketAddr json and use
> > > qio_channel_socket_connect_sync()
> > > v3: gate control power off by migration state keep control socket
> > > disconnected
> > >     to test outside influence and add docs.
> > > v7: TPMmssim -> TPMMssim; doc and json fixes
> > >     Make command socket open each time (makes OS debugging easier)
> > > v11: add startup method to make sure TPM is reset on reboot
> > > ---
> > >  MAINTAINERS              |   6 +
> > >  backends/tpm/Kconfig     |   5 +
> > >  backends/tpm/meson.build |   1 +
> > >  backends/tpm/tpm_mssim.c | 335
> > > +++++++++++++++++++++++++++++++++++++++
> > >  backends/tpm/tpm_mssim.h |  44 +++++
> > >  docs/specs/tpm.rst       |  39 +++++
> > >  qapi/tpm.json            |  31 +++-
> > >  system/tpm-hmp-cmds.c    |   9 ++
> > >  8 files changed, 466 insertions(+), 4 deletions(-)
> > >  create mode 100644 backends/tpm/tpm_mssim.c
> > >  create mode 100644 backends/tpm/tpm_mssim.h
> > > 
> > 
> > 
> > > diff --git a/backends/tpm/tpm_mssim.c b/backends/tpm/tpm_mssim.c
> > > new file mode 100644
> > > index 0000000000..8f105fc924
> > > --- /dev/null
> > > +++ b/backends/tpm/tpm_mssim.c
> > > @@ -0,0 +1,335 @@
> > > +/*
> > > + * Emulator TPM driver which connects over the mssim protocol
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * Copyright (c) 2022
> > 
> > Copyright by whom ? I presume yourself, but I wouldn't normally
> > assume the 'Author' line applies to the Copyright line.
> 
> I'll fix up this one (and all the others below) but:
> 
> [...]
> > > diff --git a/backends/tpm/tpm_mssim.h b/backends/tpm/tpm_mssim.h
> > > new file mode 100644
> > > index 0000000000..397474e4f6
> > > --- /dev/null
> > > +++ b/backends/tpm/tpm_mssim.h
> > > @@ -0,0 +1,44 @@
> > > +/*
> > > + * SPDX-License-Identifier: BSD-2-Clause
> > > + *
> > > + * The code below is copied from the Microsoft/TCG Reference
> > > implementation
> > > + *
> > > + *  https://github.com/Microsoft/ms-tpm-20-ref.git
> > > + *
> > > + * In file TPMCmd/Simulator/include/TpmTcpProtocol.h
> > > + */
> > 
> > That file has a volumous copyright header that I would expect to be
> > preserved here.
> 
> Actually, the file itself has no copyright header at all (seems to be
> standard practice for all header files in the repository). Did you want
> me to paste the copyright lines from the LICENSE file; i.e.

Oh, my local checkout was out of date. A commit in Oct last year purged
all the copyright headers that the files previously had:

  https://github.com/microsoft/ms-tpm-20-ref/blob/482aaafc0523bb94de203c4975f72f0230becec4/TPMCmd/Simulator/include/TpmTcpProtocol.h

> Copyright 2010-2022 Microsoft Corporation
> Copyright 2022-2024 Trusted Computing Group and its contributors

Yes, I think adding those, would be sufficient.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


