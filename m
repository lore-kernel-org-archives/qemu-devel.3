Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063E1606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LhBbIjKW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSCk-0005Bq-9h; Thu, 29 Oct 2026 11:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMSCh-0005AK-Af
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMSCe-0005Qb-Fr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 11:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793288287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPgP2B7ChqNNdH4RALIG4Kk4g6+5to21M4dfqkmiD/g=;
 b=LhBbIjKWCBAfJMa8L3fv8TFsarspFIy4mPurNw8OpenKwTDKAz6pvhsJvEQzWAC0ep4ZS0
 iGCdr6n3zvfebGqKmpGXeyS8WdF3ssPxIx7EXff8r68IYte/sR63J5ipMfjtrW73m02GAj
 HoNxwZ1D0UCG+BQSHqNECiUCnx2NwjA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-UaFXHziCMd6JcVLOfHokOg-1; Thu,
 29 Oct 2026 11:38:03 -0400
X-MC-Unique: UaFXHziCMd6JcVLOfHokOg-1
X-Mimecast-MFC-AGG-ID: UaFXHziCMd6JcVLOfHokOg_1793288282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE9C7195F156; Thu, 29 Oct 2026 15:38:01 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2EA11955F08; Thu, 29 Oct 2026 15:37:58 +0000 (UTC)
Date: Thu, 29 Oct 2026 15:37:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 08/21] qapi: add 'tldr-dump' command for on-demand data
 recorder output
Message-ID: <auNoU5fM0z2yBHGY@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-9-berrange@redhat.com>
 <87a4nwgazp.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a4nwgazp.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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

On Thu, Oct 29, 2026 at 09:35:38AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > While the data recorder is designed to dump its contents in
> > response to various signals that result in a QEMU crash, it
> > is also interesting to explicitly request dump.
> >
> > This could be simply as an adhoc debugging activity, or could
> > be in response to a specific event like a guest OS panic
> > notification.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  MAINTAINERS           |  1 +
> >  qapi/meson.build      |  1 +
> >  qapi/qapi-schema.json |  1 +
> >  qapi/tldr.json        | 28 ++++++++++++++++++++++++++++
> >  qemu-options.hx       |  2 ++
> >  util/tldr.c           | 32 ++++++++++++++++++++++++++++++++
> >  6 files changed, 65 insertions(+)
> >  create mode 100644 qapi/tldr.json
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4fa68810c1e..54265d987cb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4780,3 +4780,4 @@ F: util/tldr.c
> >  F: util/tldr-internal.h
> >  F: include/qemu/tldr.h
> >  F: tests/unit/test-util-tldr.c
> > +F: qapi/tldr.json
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index a46269b5a0c..f8aecb61284 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -49,6 +49,7 @@ qapi_all_modules = [
> >    'run-state',
> >    'sockets',
> >    'stats',
> > +  'tldr',
> >    'trace',
> >    'transaction',
> >    'vfio',
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index b93dd68d94c..b36777970d1 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -76,3 +76,4 @@
> >  { 'include': 'cryptodev.json' }
> >  { 'include': 'cxl.json' }
> >  { 'include': 'uefi.json' }
> > +{ 'include': 'tldr.json' }
> > diff --git a/qapi/tldr.json b/qapi/tldr.json
> > new file mode 100644
> > index 00000000000..8e2b7cda324
> > --- /dev/null
> > +++ b/qapi/tldr.json
> > @@ -0,0 +1,28 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +##
> > +# @QTLDRDumpOptions:
> > +#     Options for `tldr-dump`.
> > +#
> > +# @target: the fully qualified file path to dump
> > +#     the data recorder to
> 
> We're not dumping the data recorder, we're dumping recorded data.

Yes.

> 
> > +#
> > +# Since: 11.2.0
> > +##
> > +{ 'struct': 'QTLDRDumpOptions',
> > +  'data': { 'target': 'str' } }
> > +
> > +##
> > +# @tldr-dump:
> > +#     Dump the data recorder to a file
> > +#
> > +# Since: 11.2.0
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "tldr-dump", "arguments": { "target": "/tmp/qemu.txt" } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }
> 
> Why do you use a separate type for the arguments?

Original iterations of this patch were passing
around more complex data, so this struct type
is redundant now.

> > diff --git a/util/tldr.c b/util/tldr.c
> > index 13e9881bc9b..ea7c26b8e9b 100644
> > --- a/util/tldr.c
> > +++ b/util/tldr.c
> > @@ -12,6 +12,7 @@
> >  #include "qom/object.h"
> >  #include "qom/object_interfaces.h"
> >  #include "qapi/error.h"
> > +#include "qapi/qapi-commands-tldr.h"
> >  
> >  struct QTLDRConfig {
> >      Object parent;
> > @@ -436,3 +437,34 @@ qtldr_crash_dump_signal(siginfo_t *si)
> >          close(fd);
> >      }
> >  }
> > +
> > +
> > +/*
> > + * WARNING: Code below this marker provides a QMP handler
> > + * WARNING: for use in normal execution. It calls into
> > + * WARNING: the common crash report outputting APIs, but
> > + * WARNING: this specific method is not restricted to async
> > + * WARNING: signal safe POSIX functions.
> > + */
> 
> Why is this a WARNING WARNING WARNING?  Looks scary, then isn't.
> 
> Put it elsewhere, so the comment isn't needed?

Hmm, yes, we could split the file into separate pieces for
different contexts.

> 
> > +
> > +
> > +void
> > +qmp_tldr_dump(const char *target, Error **errp)
> > +{
> > +    int fd;
> > +
> > +    if (!qatomic_read(&qtldr_active)) {
> > +        error_setg(errp, "No 'tldr-config' object has been creted");
> > +        return;
> > +    }
> > +
> > +    fd = qemu_create(target, O_WRONLY | O_TRUNC, 0600, errp);
> > +    if (fd < 0) {
> > +        return;
> > +    }
> > +
> > +    qtldr_crash_dump_internal(fd, NULL);
> > +
> > +    qemu_fdatasync(fd);
> > +    close(fd);
> > +}
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


