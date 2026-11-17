Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18F4606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uY9m+gh7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YoT5KJKU;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=uY9m+gh7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YoT5KJKU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPHk-0003VK-2w; Tue, 17 Nov 2026 14:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTPHj-0003V1-6G
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:56:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTPHh-00073h-6P
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:56:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B9C5C22298;
 Tue, 17 Nov 2026 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794945362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lwp1zkbZasS197ZvWE4TF2srj08hvyPYtJE7/ewjO7g=;
 b=uY9m+gh75spAZSmr3oQG90kF8a3/NgYjSn0Usuet9i+m8CYGZPYaTS2EZjh78csvnBLJBn
 DYk6zjNG2OJCvFGqr2f8M7ap93LAz2ELTEiazoob1EkeDT5SgnhpKcwplJ1x/QhDEc+PXQ
 PSpiu50eUnNgktrraamdGJNmFY7hQbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794945362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lwp1zkbZasS197ZvWE4TF2srj08hvyPYtJE7/ewjO7g=;
 b=YoT5KJKULqGwjW5ln5jyCRTqh5+Cymwg7E6J7PQRMhDpeX00aw50NlJbMY7/324HgIEbgb
 akaLAQK2vV8SBdDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794945362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lwp1zkbZasS197ZvWE4TF2srj08hvyPYtJE7/ewjO7g=;
 b=uY9m+gh75spAZSmr3oQG90kF8a3/NgYjSn0Usuet9i+m8CYGZPYaTS2EZjh78csvnBLJBn
 DYk6zjNG2OJCvFGqr2f8M7ap93LAz2ELTEiazoob1EkeDT5SgnhpKcwplJ1x/QhDEc+PXQ
 PSpiu50eUnNgktrraamdGJNmFY7hQbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794945362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lwp1zkbZasS197ZvWE4TF2srj08hvyPYtJE7/ewjO7g=;
 b=YoT5KJKULqGwjW5ln5jyCRTqh5+Cymwg7E6J7PQRMhDpeX00aw50NlJbMY7/324HgIEbgb
 akaLAQK2vV8SBdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D2F213302;
 Tue, 17 Nov 2026 19:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rGbjJVGx/GpnEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 19:56:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth
 <michael.roth@amd.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 08/21] qapi: add 'tldr-dump' command for on-demand data
 recorder output
In-Reply-To: <20261015112044.1999748-9-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-9-berrange@redhat.com>
Date: Tue, 17 Nov 2026 16:55:55 -0300
Message-ID: <87y0arqlkk.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> While the data recorder is designed to dump its contents in
> response to various signals that result in a QEMU crash, it
> is also interesting to explicitly request dump.
>
> This could be simply as an adhoc debugging activity, or could
> be in response to a specific event like a guest OS panic
> notification.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS           |  1 +
>  qapi/meson.build      |  1 +
>  qapi/qapi-schema.json |  1 +
>  qapi/tldr.json        | 28 ++++++++++++++++++++++++++++
>  qemu-options.hx       |  2 ++
>  util/tldr.c           | 32 ++++++++++++++++++++++++++++++++
>  6 files changed, 65 insertions(+)
>  create mode 100644 qapi/tldr.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fa68810c1e..54265d987cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4780,3 +4780,4 @@ F: util/tldr.c
>  F: util/tldr-internal.h
>  F: include/qemu/tldr.h
>  F: tests/unit/test-util-tldr.c
> +F: qapi/tldr.json
> diff --git a/qapi/meson.build b/qapi/meson.build
> index a46269b5a0c..f8aecb61284 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -49,6 +49,7 @@ qapi_all_modules =3D [
>    'run-state',
>    'sockets',
>    'stats',
> +  'tldr',
>    'trace',
>    'transaction',
>    'vfio',
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index b93dd68d94c..b36777970d1 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -76,3 +76,4 @@
>  { 'include': 'cryptodev.json' }
>  { 'include': 'cxl.json' }
>  { 'include': 'uefi.json' }
> +{ 'include': 'tldr.json' }
> diff --git a/qapi/tldr.json b/qapi/tldr.json
> new file mode 100644
> index 00000000000..8e2b7cda324
> --- /dev/null
> +++ b/qapi/tldr.json
> @@ -0,0 +1,28 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=3Dpython
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +##
> +# @QTLDRDumpOptions:
> +#     Options for `tldr-dump`.
> +#
> +# @target: the fully qualified file path to dump
> +#     the data recorder to
> +#
> +# Since: 11.2.0
> +##
> +{ 'struct': 'QTLDRDumpOptions',
> +  'data': { 'target': 'str' } }
> +
> +##
> +# @tldr-dump:
> +#     Dump the data recorder to a file
> +#
> +# Since: 11.2.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "tldr-dump", "arguments": { "target": "/tmp/qemu.t=
xt" } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }

A good case for OOB?

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2f63d86b635..5f96257cef0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6692,6 +6692,8 @@ SRST
>          recorder will be dumped to the stderr stream. If the
>          ``crash-target`` parameter was given, that specifies a fully
>          qualified file path to write the dump to instead of stderr.
> +        The ``tldr-dump`` QMP command can also be used at any time to
> +        save the captured data to an arbitrary file.
>=20=20
>          The ``tldr-config`` object can be added at initial startup
>          or via QMP at runtime. Once created, however, it is not
> diff --git a/util/tldr.c b/util/tldr.c
> index 13e9881bc9b..ea7c26b8e9b 100644
> --- a/util/tldr.c
> +++ b/util/tldr.c
> @@ -12,6 +12,7 @@
>  #include "qom/object.h"
>  #include "qom/object_interfaces.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-commands-tldr.h"
>=20=20
>  struct QTLDRConfig {
>      Object parent;
> @@ -436,3 +437,34 @@ qtldr_crash_dump_signal(siginfo_t *si)
>          close(fd);
>      }
>  }
> +
> +
> +/*
> + * WARNING: Code below this marker provides a QMP handler
> + * WARNING: for use in normal execution. It calls into
> + * WARNING: the common crash report outputting APIs, but
> + * WARNING: this specific method is not restricted to async
> + * WARNING: signal safe POSIX functions.
> + */
> +
> +
> +void
> +qmp_tldr_dump(const char *target, Error **errp)
> +{
> +    int fd;
> +
> +    if (!qatomic_read(&qtldr_active)) {
> +        error_setg(errp, "No 'tldr-config' object has been creted");
> +        return;
> +    }
> +
> +    fd =3D qemu_create(target, O_WRONLY | O_TRUNC, 0600, errp);
> +    if (fd < 0) {
> +        return;
> +    }
> +
> +    qtldr_crash_dump_internal(fd, NULL);
> +
> +    qemu_fdatasync(fd);
> +    close(fd);
> +}

Reviewed-by: Fabiano Rosas <farosas@suse.de>

