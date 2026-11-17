Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9A606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DPaAZ/xm;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OqKZ2WU4;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=DPaAZ/xm;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OqKZ2WU4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPEt-0002aJ-AI; Tue, 17 Nov 2026 14:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTPEl-0002ZW-Uc
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:53:05 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTPEi-0003uq-93
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:53:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F8F51F7DB;
 Tue, 17 Nov 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794945178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QhkYaMlgpQysyfGDFEkZpbSHSP76uGgUoSC/0p1rHE=;
 b=DPaAZ/xm/vOaCqp75vpn5d6SRrwVXyu+3BMcn6CtLnE8v7uCPoc34MA6K35MXASdRslude
 CZtgTVSLOmaKo4IIp7G5Z+5HJJisBEulZhK4/e+H7kjM3m2JHRKc62uK8NYnd9zZZWsCVY
 4r9J1LKc90mp0lTk7qv6ask6qeWLFig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794945178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QhkYaMlgpQysyfGDFEkZpbSHSP76uGgUoSC/0p1rHE=;
 b=OqKZ2WU4XNtxBmVflVFs8rqqx04cjZ1rFJDad4SW4ypImc8bzZ68iYopBFj3sXWCDPVQSl
 Bu6dO7xyenpGjbDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DPaAZ/xm";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OqKZ2WU4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794945178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QhkYaMlgpQysyfGDFEkZpbSHSP76uGgUoSC/0p1rHE=;
 b=DPaAZ/xm/vOaCqp75vpn5d6SRrwVXyu+3BMcn6CtLnE8v7uCPoc34MA6K35MXASdRslude
 CZtgTVSLOmaKo4IIp7G5Z+5HJJisBEulZhK4/e+H7kjM3m2JHRKc62uK8NYnd9zZZWsCVY
 4r9J1LKc90mp0lTk7qv6ask6qeWLFig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794945178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QhkYaMlgpQysyfGDFEkZpbSHSP76uGgUoSC/0p1rHE=;
 b=OqKZ2WU4XNtxBmVflVFs8rqqx04cjZ1rFJDad4SW4ypImc8bzZ68iYopBFj3sXWCDPVQSl
 Bu6dO7xyenpGjbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D1C213302;
 Tue, 17 Nov 2026 19:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k2M3OZiw/GpnDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 19:52:57 +0000
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
Subject: Re: [PATCH 07/21] util: introduce 'tldr', a system data recorder
 for crash handling
In-Reply-To: <20261015112044.1999748-8-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-8-berrange@redhat.com>
Date: Tue, 17 Nov 2026 16:52:54 -0300
Message-ID: <871p8js0a1.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,yandex-team.ru:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: 1F8F51F7DB
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Introduce a new subsystem "tldr" aka "thrifty live data recorder"
> that will be able to continuously collect certain information at
> runtime and dump that in a crash report when QEMU exits abnormally.
> As a second use case, it will support manual triggering on interesting
> events such as guest OS panic.
>

Could we bind this to the existing panic and watchdog actions? Why wait
for management layer permission just to spit some logs?

> Initially the framework does nothing except print the signal
> information. Later commits will introduce broader data collection.
> This relies on the dummy siginfo_t struct for portability to Windows.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  MAINTAINERS                 |   8 +
>  include/qemu/tldr.h         |  24 ++
>  qapi/qom.json               |  15 ++
>  qemu-options.hx             |  14 ++
>  tests/unit/meson.build      |   1 +
>  tests/unit/test-util-tldr.c | 105 +++++++++
>  util/meson.build            |   1 +
>  util/tldr-internal.h        |  21 ++
>  util/tldr.c                 | 438 ++++++++++++++++++++++++++++++++++++
>  9 files changed, 627 insertions(+)
>  create mode 100644 include/qemu/tldr.h
>  create mode 100644 tests/unit/test-util-tldr.c
>  create mode 100644 util/tldr-internal.h
>  create mode 100644 util/tldr.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b5aafe43b1..4fa68810c1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4772,3 +4772,11 @@ Machine development tool
>  M: Maksim Davydov <davydov-max@yandex-team.ru>
>  S: Supported
>  F: scripts/compare-machine-types.py
> +
> +Data Recorder
> +M: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> +S: Maintained
> +F: util/tldr.c
> +F: util/tldr-internal.h
> +F: include/qemu/tldr.h
> +F: tests/unit/test-util-tldr.c
> diff --git a/include/qemu/tldr.h b/include/qemu/tldr.h
> new file mode 100644
> index 00000000000..67152b136b3
> --- /dev/null
> +++ b/include/qemu/tldr.h
> @@ -0,0 +1,24 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * TL;DR: Thrifty Live Data Recorder
> + *
> + * Copyright (C) 2026 Red Hat Inc.
> + */
> +
> +#ifndef QEMU_TLDR_H__
> +#define QEMU_TLDR_H__
> +
> +/**
> + * qtldr_crash_dump_signal:
> + * @si: signal information
> + *
> + * Print a crash dump in response to a signal.
> + *
> + * The crash will be printed to the configured crash
> + * file, if set. If opening the crash file fails, or
> + * no path is configured, STDERR will be used.
> + */
> +void qtldr_crash_dump_signal(siginfo_t *si);

Will the terms get confusing? There's the existing core dump, the crash,
the other crash, and now the crash dump, the crash file, the
crash-target, etc.

Also, does the use case of dumping on guest panic allow the virtual
machine to continue running? If so, then we definitely need to drop the
"crash" mentions all over.

Perhaps qtldr_dump_on_signal for this one.

> +
> +#endif /* QEMU_TLDR_H__ */
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 49f222796ab..1c9031fba9a 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1233,6 +1233,19 @@
>    'data': { '*pretty': 'bool',
>              '*close-action': 'MonitorQMPCloseAction' } }
>=20=20
> +##
> +# @QTLDRConfigProperties:
> +#     Configuration for data recorder
> +#
> +# @crash-target: fully qualified path to perserve data recorder

preserve

Also,
s/crash-target/dump-target/ ?=20

> +#                contents on QEMU crash

Slightly ambiguous, maybe one of:

s/on/about/
s/on/upon/

> +#
> +# Since: 11.2.0
> +##
> +{ 'struct': 'QTLDRConfigProperties',
> +  'data': { '*crash-target': 'str' }
> +}
> +
>  ##
>  # @ObjectType:
>  #
> @@ -1302,6 +1315,7 @@
>      's390-pv-guest',
>      'tdx-guest',
>      'throttle-group',
> +    'tldr-config',
>      'tls-creds-anon',
>      'tls-creds-psk',
>      'tls-creds-x509',
> @@ -1379,6 +1393,7 @@
>        'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
> +      'tldr-config':                'QTLDRConfigProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',
>        'tls-creds-psk':              'TlsCredsPskProperties',
>        'tls-creds-x509':             'TlsCredsX509Properties',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2f6863180b0..2f63d86b635 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6682,6 +6682,20 @@ SRST
>          ::
>=20=20
>              (qemu) qom-set /objects/iothread1 poll-max-ns 100000
> +
> +
> +    ``-object tldr-config,id=3Did,crash-target=3Dpath``
> +        Creating the ``tldr-config`` object enables the thrifty live data
> +        recorder, which continuously captures important information about
> +        the operation of the QEMU process. When a SIGSEGV, SIGBUS,
> +        SIGILL, SIGFPE or SIGABRT are seen the contents of the data
> +        recorder will be dumped to the stderr stream. If the
> +        ``crash-target`` parameter was given, that specifies a fully
> +        qualified file path to write the dump to instead of stderr.
> +
> +        The ``tldr-config`` object can be added at initial startup
> +        or via QMP at runtime. Once created, however, it is not
> +        permitted to disable it.
>  ERST
>=20=20
>=20=20
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index d17435c1877..aa02895e767 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -136,6 +136,7 @@ if have_system
>      'test-qmp-cmds': [testqapi],
>      'test-xbzrle': [migration],
>      'test-util-sockets': ['socket-helpers.c'],
> +    'test-util-tldr': [],
>      'test-base64': [],
>      'test-bufferiszero': [],
>      'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machi=
ne-smp.c'],
> diff --git a/tests/unit/test-util-tldr.c b/tests/unit/test-util-tldr.c
> new file mode 100644
> index 00000000000..4384e10cc18
> --- /dev/null
> +++ b/tests/unit/test-util-tldr.c
> @@ -0,0 +1,105 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Tests for util/tldr.c
> + *
> + * Copyright 2026 Red Hat, Inc.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "util/tldr-internal.h"
> +
> +typedef struct {
> +    bool siginfo;
> +    const char *data;
> +} QTLDRTestData;
> +
> +#define TEST_SIGINFO_NULL \
> +    QTLDR_DUMP_TRIGGER_PREFIX "manual\n"
> +
> +#define TEST_SIGINFO_SEGV \
> +    QTLDR_DUMP_TRIGGER_PREFIX "\n" \
> +    "  - Signal: SIGSEGV (11)\n" \
> +    "  - Code: Address not mapped (1)\n" \
> +    "  - Address: 0x87539319\n"
> +
> +
> +static void
> +test_tldr_one(QTLDRTestData *data)
> +{
> +    g_autofree char *tmpname =3D NULL;
> +    int tmpfd;
> +    char buf[1024];
> +    ssize_t dumplen;
> +
> +    tmpfd =3D g_file_open_tmp("test-util-tldr-XXXXXX",
> +                            &tmpname, NULL);
> +    unlink(tmpname);
> +
> +    if (data->siginfo) {
> +        siginfo_t si =3D {};
> +        si.si_signo =3D 11; /*
> +                           * SIGSEGV on Linux, but don't use constant
> +                           * since expected output string hardcodes 11
> +                           */
> +        si.si_code =3D 1;
> +        si.si_addr =3D (void *)0x87539319;
> +        qtldr_crash_dump_internal(tmpfd, &si);
> +    } else {
> +        qtldr_crash_dump_internal(tmpfd, NULL);
> +    }
> +
> +    lseek(tmpfd, 0, SEEK_SET);
> +
> +    dumplen =3D read(tmpfd, buf, sizeof(buf));
> +
> +    assert(dumplen > 0);
> +    buf[dumplen] =3D '\0';
> +
> +    close(tmpfd);
> +
> +    g_assert_cmpstr(buf, =3D=3D, data->data);
> +}
> +
> +
> +static void
> +test_tldr_minimal_default(void)
> +{
> +    QTLDRTestData data =3D {
> +        .siginfo =3D false,
> +        .data =3D
> +            QTLDR_DUMP_LEADER
> +            TEST_SIGINFO_NULL
> +            QTLDR_DUMP_TRAILER
> +    };
> +
> +    test_tldr_one(&data);
> +}
> +
> +
> +static void
> +test_tldr_minimal_siginfo(void)
> +{
> +    QTLDRTestData data =3D {
> +        .siginfo =3D true,
> +        .data =3D
> +            QTLDR_DUMP_LEADER
> +            TEST_SIGINFO_SEGV
> +            QTLDR_DUMP_TRAILER
> +    };
> +
> +    test_tldr_one(&data);
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    g_test_add_func("/util/tldr/minimal/default",
> +                    test_tldr_minimal_default);
> +    g_test_add_func("/util/tldr/minimal/siginfo",
> +                    test_tldr_minimal_siginfo);
> +
> +    return g_test_run();
> +}
> diff --git a/util/meson.build b/util/meson.build
> index fa174c07a57..00c2350c87e 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -66,6 +66,7 @@ util_ss.add(files('int128.c'))
>  util_ss.add(files('memalign.c'))
>  util_ss.add(files('interval-tree.c'))
>  util_ss.add(files('lockcnt.c'))
> +util_ss.add(files('tldr.c'))
>=20=20
>  if have_system
>    util_ss.add(files('crc-ccitt.c'))
> diff --git a/util/tldr-internal.h b/util/tldr-internal.h
> new file mode 100644
> index 00000000000..193d8425eee
> --- /dev/null
> +++ b/util/tldr-internal.h
> @@ -0,0 +1,21 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * TL;DR: Thrifty Live Data Recorder
> + *
> + * Copyright (C) 2026 Red Hat Inc.
> + */
> +
> +#ifndef QEMU_TLDR_INTERNAL_H__
> +#define QEMU_TLDR_INTERNAL_H__
> +
> +#include "qemu/tldr.h"
> +
> +#define QTLDR_DUMP_LEADER "\n=F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8 QEMU D=
ata Recorder Start =F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8\n"
> +#define QTLDR_DUMP_TRAILER "\n=F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8 QEMU =
Data Recorder End =F0=9F=9A=A8=F0=9F=9A=A8=F0=9F=9A=A8\n\n"
> +#define QTLDR_DUMP_TRIGGER_PREFIX "\n=F0=9F=94=8D Trigger:"
> +#define QTLDR_DUMP_OPEN_ERROR "=F0=9F=94=A5 Unable to dump to '"

These markers got me thinking whether regular QEMU logs can interleave
with tldr when directed to stderr. This is a new situation for libvirt.


