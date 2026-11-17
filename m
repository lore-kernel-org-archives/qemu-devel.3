Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CD606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WrosteCD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJQb-0000Mm-W0; Tue, 17 Nov 2026 08:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTJPe-0007xA-7E
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xTJPb-0003Hy-Vm
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AORRodTm00l/C/6YgNLJASP5xSzrNbTIhf5Q6Y/Sd9E=;
 b=WrosteCDjAWQ5W6BuWHcETOqto+HMcFmn4pEFG414UA5MBv6pi7BE14Hk6YhE4rR9yCRyT
 DUDVHVmYs6cKfL8mWZVx2stvqMQTPGXCli3+1cmBkP45Z5A9lhCDBDd7rKJeajjbJ42NIX
 h57uxVKboAlxiB2yKhNLhEcWTQ0xJdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-PsGMqEr_NFWd_16zdWZM5w-1; Tue,
 17 Nov 2026 08:39:45 -0500
X-MC-Unique: PsGMqEr_NFWd_16zdWZM5w-1
X-Mimecast-MFC-AGG-ID: PsGMqEr_NFWd_16zdWZM5w_1794922782
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682F01955F6E; Tue, 17 Nov 2026 13:39:41 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A639428; Tue, 17 Nov 2026 13:39:35 +0000 (UTC)
Date: Tue, 17 Nov 2026 13:39:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 1/7] debug/mem: add utility to name anonymous memory
 mappings
Message-ID: <avxZFbMNjEmnY2yK@redhat.com>
References: <20261116165002.30939-1-jsnow@redhat.com>
 <20261116165002.30939-2-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116165002.30939-2-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, Nov 16, 2026 at 11:49:56AM -0500, John Snow wrote:
> Add support to name mmap'd memory regions using
> PR_SET_VMA_ANON_NAME. On unsupported platforms, these QEMU utility
> functions are no-ops.
> 
> This is useful primarily for debugging and profiling QEMU; being able
> to see and correlate each VMA segment with a specific use within QEMU.
> 
> Support for PR_SET_VMA_ANON_NAME was added in Linux 5.17, and requires
> CONFIG_ANON_VMA_NAME=y to be set in the kernel configuration. Fedora
> (and RHEL) do not enable this feature by default. See also
> https://man7.org/linux/man-pages/man2/pr_set_vma.2const.html
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/mmap-vma.h | 18 +++++++++++
>  util/mmap-vma.c         | 71 +++++++++++++++++++++++++++++++++++++++++
>  util/meson.build        |  1 +
>  3 files changed, 90 insertions(+)
>  create mode 100644 include/qemu/mmap-vma.h
>  create mode 100644 util/mmap-vma.c
> 
> diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
> new file mode 100644
> index 00000000000..763ea5a5cab
> --- /dev/null
> +++ b/include/qemu/mmap-vma.h
> @@ -0,0 +1,18 @@
> +/*
> + * Utility for naming VMA allocations in linux
> + *
> + * Copyright (c) Red Hat, Inc 2026
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef __QEMU_MMAP_VMA_H
> +#define __QEMU_MMAP_VMA_H
> +
> +#include <stddef.h>
> +#include "osdep.h"
> +
> +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> +    G_GNUC_PRINTF(3, 4);
> +
> +#endif
> diff --git a/util/mmap-vma.c b/util/mmap-vma.c
> new file mode 100644
> index 00000000000..7a50965d496
> --- /dev/null
> +++ b/util/mmap-vma.c
> @@ -0,0 +1,71 @@
> +/*
> + * Utility for naming VMA allocations in linux
> + *
> + * Copyright (c) Red Hat, Inc 2026
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#include "qemu/mmap-vma.h"
> +#include "qemu/osdep.h"
> +
> +#include <errno.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +
> +#if defined(__linux__)
> +#include <sys/prctl.h>
> +#endif
> +
> +#define VMA_PREFIX " qemu: "
> +#define VMA_MAXLEN 80
> +
> +/*
> + * Give a human-readable name to a previously mmap'd memory segment.
> + * This feature is only available on Linux >= 5.17, and only when the
> + * kernel was configured with CONFIG_ANON_VMA_NAME=y.
> + *
> + * For systems without this option, prctl() will return -1 and set
> + * errno to EINVAL, and can be safely ignored.
> + *
> + * For systems with this option, these human-readable names will be
> + * visible in /proc/$pid/[s]maps, pmap output, etc.
> + */
> +G_GNUC_PRINTF(3, 0)
> +static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)

As the comment says above, we can't assume the kernel will have
the feature enabled.

It is harmless if we try to set the VMA name and it fails
though. We merely loose a bit of debug info. Thus I'd
suggest we make the function return type 'void', so that
it is clear that we do NOT expect callers to check for
errors.

> +{
> +    int rc = 0;
> +
> +#if defined(PR_SET_VMA_ANON_NAME)
> +    char strbuf[VMA_MAXLEN];
> +
> +    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
> +    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
> +    rc = vsnprintf(strbuf + sizeof(VMA_PREFIX),
> +                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
> +    if (rc < 0) {
> +        return -errno;
> +    } else if (rc >= (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
> +        sprintf(strbuf + sizeof(strbuf) - 4, "...");
> +    }
> +
> +    rc = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
> +    if (rc) {
> +        return -errno;
> +    }
> +#endif
> +
> +    return rc;
> +}
> +
> +G_GNUC_PRINTF(3, 4)
> +int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
> +{
> +    int rc;
> +    va_list args;
> +
> +    va_start(args, fmt);
> +    rc = qemu_vname_vma(ptr, sz, fmt, args);
> +    va_end(args);
> +
> +    return rc;
> +}
> diff --git a/util/meson.build b/util/meson.build
> index fa174c07a57..861ee228d5b 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -1,5 +1,6 @@
>  util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
>  util_ss.add(files('thread-context.c'), numa)
> +util_ss.add(files('mmap-vma.c'))
>  if host_os != 'windows'
>    util_ss.add(files('aio-posix.c'))
>    util_ss.add(files('fdmon-poll.c'))
> -- 
> 2.56.1
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


