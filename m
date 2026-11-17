Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983C606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jG3xpfKF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnOe0d6Z;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jG3xpfKF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZnOe0d6Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPo2-0007mE-BU; Tue, 17 Nov 2026 15:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTPo0-0007le-H5
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:29:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTPnw-0000ij-RA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:29:26 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 011EC1F803;
 Tue, 17 Nov 2026 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794947363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y8KG6bCScanUzQ7sDjojShALbqw8E7b7C5aZSXBJKs=;
 b=jG3xpfKFnQB8l9eIqpAH+ztcOHjRPmj1wfo3iABABrTvGjFpDYnOCJJxqQ25NZJROEXXEv
 7DvB42epQYwUXyaKkFSBrI3S4r0Ir2UOtsupEnbF36nkret9otUhtichAQw4bOx4CiPzOL
 totY90jXSm4C/+xvSRPgida4ApunTnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794947363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y8KG6bCScanUzQ7sDjojShALbqw8E7b7C5aZSXBJKs=;
 b=ZnOe0d6ZkECGSzfDSH6/IJP0vxHHCRxR+IU6ncWmsfMUofDKYz2eLHOu4Av1OjFXk8GzlZ
 Q1xQXIwVm+lDS0Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jG3xpfKF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZnOe0d6Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794947363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y8KG6bCScanUzQ7sDjojShALbqw8E7b7C5aZSXBJKs=;
 b=jG3xpfKFnQB8l9eIqpAH+ztcOHjRPmj1wfo3iABABrTvGjFpDYnOCJJxqQ25NZJROEXXEv
 7DvB42epQYwUXyaKkFSBrI3S4r0Ir2UOtsupEnbF36nkret9otUhtichAQw4bOx4CiPzOL
 totY90jXSm4C/+xvSRPgida4ApunTnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794947363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Y8KG6bCScanUzQ7sDjojShALbqw8E7b7C5aZSXBJKs=;
 b=ZnOe0d6ZkECGSzfDSH6/IJP0vxHHCRxR+IU6ncWmsfMUofDKYz2eLHOu4Av1OjFXk8GzlZ
 Q1xQXIwVm+lDS0Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B07113302;
 Tue, 17 Nov 2026 20:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rhGQASK5/GoDNQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 20:29:22 +0000
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
Subject: Re: [PATCH 14/21] util: introduce capture of textual messages in
 data recorder
In-Reply-To: <20261015112044.1999748-15-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-15-berrange@redhat.com>
Date: Tue, 17 Nov 2026 17:29:19 -0300
Message-ID: <87v75vqk0w.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 011EC1F803
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Score: -13.51
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

> Introduce a circular buffer concept to the data recorder that can be
> used to capture text based messages from subsystems. Support for
> multiple distinct "buckets" is provided, one per type of information
> to be captured. This ensures that data from subsystems which is
> captured at a high rate, does not prematurely wrap the buffer and
> overwrite (still relevant) messages from a subsystem that records
> at a low rate.
>
> Each bucket has a max capacity of 64 KB by default (though it is
> configurable), but grows on demand. IOW the bucket capacity puts
> an upper limit on memory usage, actual usage will be zero until
> data is recorded. Every captured message will be prefixed by a
> timestamp and suffixed by a newline, if one is not already present
> at the end of the message.
>
> While writing into the bufers is synchronized with mutex locks,
> when dumping from a signal handler the buffers are accessed
> without any locking to avoid deadlocks. Atomic loads/stores are
> used in certain places so the signal handler can dump data with
> acceptable accuracy even when racing with other threads still
> writing new messages.
>
> When the circular buffer wraps, old messages will be overwritten
> without attention to message boundaries. IOW, when later dumping
> the data recorder, the first printed message is likely to have
> its leading text and timestamp missing. This is considered an
> acceptable tradeoff to avoid tracking message boundaries which
> greatly adds complexity and is hard todo safely without locks
> when dumping.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/tldr.h         |  52 +++++++
>  qapi/qom.json               |   5 +-
>  qapi/tldr.json              |  34 +++++
>  qemu-options.hx             |   8 +
>  tests/unit/test-util-tldr.c | 272 ++++++++++++++++++++++++++++++++++
>  util/tldr-internal.h        |  31 ++++
>  util/tldr.c                 | 282 +++++++++++++++++++++++++++++++++++-
>  7 files changed, 682 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/tldr.h b/include/qemu/tldr.h
> index 67152b136b3..5766acecb64 100644
> --- a/include/qemu/tldr.h
> +++ b/include/qemu/tldr.h
> @@ -9,6 +9,58 @@
>  #ifndef QEMU_TLDR_H__
>  #define QEMU_TLDR_H__
>=20=20
> +#include "qapi/qapi-types-tldr.h"
> +
> +extern unsigned int qtldr_msg_enabled_mask;
> +
> +/**
> + * qtldr_msg_enabled:
> + * @bucket: bucket to check status for
> + *
> + * Returns: true if @bucket is enabled for recording
> + */
> +#define qtldr_msg_enabled(bucket) \
> +    (qtldr_msg_enabled_mask & (1 << bucket))
> +
> +/**
> + * qtldr_msg_record:
> + * @bucket: bucket to record into
> + * @msg: the message text to record
> + *
> + * Records @msg into @bucket, potentially overwriting
> + * old messages if the capacity is at its maximum
> + */
> +void qtldr_msg_record(QTLDRMsgBucketType bucket,
> +                      const char *msg);
> +
> +/**
> + * qtldr_msg_record_printf:
> + * @bucket: bucket to record into
> + * @fmt: the message format string to record
> + * @...: the arguments for @fmt
> + *
> + * Formats @fmt as a printf string and records the
> + * result into @bucket, potentially overwriting
> + * old messages if the capacity is at its maximum
> + */
> +void qtldr_msg_record_printf(QTLDRMsgBucketType bucket,
> +                             const char *fmt, ...)
> +    G_GNUC_PRINTF(2, 3);
> +
> +/**
> + * qtldr_msg_record_vprintf:
> + * @bucket: bucket to record into
> + * @fmt: the message format string to record
> + * @ap: the arguments for @fmt
> + *
> + * Formats @fmt as a printf string and records the
> + * result into @bucket, potentially overwriting
> + * old messages if the capacity is at its maximum
> + */
> +void qtldr_msg_record_vprintf(QTLDRMsgBucketType bucket,
> +                              const char *fmt, va_list ap)
> +    G_GNUC_PRINTF(2, 0);
> +
>  /**
>   * qtldr_crash_dump_signal:
>   * @si: signal information
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 1c9031fba9a..f1c37bce6c2 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -8,6 +8,7 @@
>  { 'include': 'block-core.json' }
>  { 'include': 'common.json' }
>  { 'include': 'crypto.json' }
> +{ 'include': 'tldr.json' }
>=20=20
>  ##
>  # ***********************
> @@ -1239,11 +1240,13 @@
>  #
>  # @crash-target: fully qualified path to perserve data recorder
>  #                contents on QEMU crash
> +# @messages: custom configuration for message buckets
>  #
>  # Since: 11.2.0
>  ##
>  { 'struct': 'QTLDRConfigProperties',
> -  'data': { '*crash-target': 'str' }
> +  'data': { '*crash-target': 'str',
> +            '*messages': ['QTLDRMsgBucketConfig'] }
>  }
>=20=20
>  ##
> diff --git a/qapi/tldr.json b/qapi/tldr.json
> index 8e2b7cda324..987d36b91f8 100644
> --- a/qapi/tldr.json
> +++ b/qapi/tldr.json
> @@ -26,3 +26,37 @@
>  #     <- { "return": {} }
>  ##
>  { 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }
> +
> +##
> +# @QTLDRMsgBucketType:
> +#     List of message bucket types
> +#
> +# @error: error messages and warnings
> +# @command: QMP commands which change state and error responses
> +# @event: QMP events reflecting state changes
> +# @log: log messages from any subsystems

Hm, all of these are generic and shared between subsystems, I'm not sure
how the "high rate vs. low rate" property is to be kept if some code
just runs fast over all of these classes of messages.

> +#
> +# Since: 11.2.0
> +##
> +{ 'enum': 'QTLDRMsgBucketType',
> +  'data': ['error', 'command', 'event', 'log' ] }
> +
> +
> +##
> +# @QTLDRMsgBucketConfig:
> +#     Configuration for message buckets
> +#
> +# @type: the message bucket to enable
> +# @capacity: override the default bucket size, in bytes (64kb)

kB

> +#
> +# Each bucket allocates memory on demand, so capacity merely
> +# puts an upper limit on the memory usage in a bucket.  The
> +# capacity must be larger than the per-message size limit,
> +# which is 2048 bytes.
> +#
> +# Since: 11.2.0
> +##
> +{ 'struct': 'QTLDRMsgBucketConfig',
> +  'data': { 'type': 'QTLDRMsgBucketType',
> +            '*capacity': 'size' }
> +}
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5f96257cef0..da9d1e2b7bd 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6685,6 +6685,8 @@ SRST
>=20=20
>=20=20
>      ``-object tldr-config,id=3Did,crash-target=3Dpath``
> +        \
> +    ``-object "{'qom-type':'tldr-config','id':'tldr','crash-target':'foo=
','messages':[{'type':'BUCKET','capacity':BYTES}]}"``

So it's not possible to add new message buckets later on because the
singleton tldr-config is already created?

>          Creating the ``tldr-config`` object enables the thrifty live data
>          recorder, which continuously captures important information about
>          the operation of the QEMU process. When a SIGSEGV, SIGBUS,
> @@ -6695,6 +6697,12 @@ SRST
>          The ``tldr-dump`` QMP command can also be used at any time to
>          save the captured data to an arbitrary file.
>=20=20
> +        The data recorder will capture upto 64kb of data by default in

up to 64 KiB

> +        each bucket, but when using the JSON syntax for ``-object``, this
> +        can be tailored with the ``messages`` parameter. ``BUCKET`` takes
> +        one of ``error``, ``command``, ``event``, or ``log`` and the
> +        capacity value is in bytes.
> +
>          The ``tldr-config`` object can be added at initial startup
>          or via QMP at runtime. Once created, however, it is not
>          permitted to disable it.

