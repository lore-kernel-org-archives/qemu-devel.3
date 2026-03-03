Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0EBE67A98
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 08:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxLTh-0003vN-Df; Tue, 03 Mar 2026 03:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxLTZ-0003uQ-2L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 03:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxLTS-0006kd-QZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 03:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772527883;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=45pb2lGq3/zJgULfbaudic4jHJWjZoefSbuY2Bm/NQo=;
 b=i9Z1MZTTCAtjKs9u6kPhC9X6DFOfiTI9/simncLUddky9tE81ls2OsjcZGNulrD1Bch2GU
 dCC/CIXwNTwJpb8ZoUETm2ZxwSzf8q49JQze71R6KeQXnOWhavtQaViksXQPmzBaQ4UTIe
 pVUjE0kCAPZdKUjDA2ywviMK/RExhsQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-AQpqqwQPPNmPwdUi752L7g-1; Tue,
 03 Mar 2026 03:51:20 -0500
X-MC-Unique: AQpqqwQPPNmPwdUi752L7g-1
X-Mimecast-MFC-AGG-ID: AQpqqwQPPNmPwdUi752L7g_1772527879
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A5511800630; Tue,  3 Mar 2026 08:51:19 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.185])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14D8F1956053; Tue,  3 Mar 2026 08:51:16 +0000 (UTC)
Date: Tue, 3 Mar 2026 08:51:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>
Subject: Re: [PATCH] bsd-user: Switch to SPDX-License-Expression
Message-ID: <aaahAbpycKhDzfbL@redhat.com>
References: <20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 09:46:06PM -0700, Warner Losh wrote:
> Switch all the files over to using SPDX. This also corrects various
> small errors in the form of the copyright messages. It adds copyright to
> those files that lack it. There's no functional change.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
> Since I'll be upstreaming more files from bsd-user, and since qemu now
> requires SPDX and prohibits boilerplate, this will make it easier. I've
> converted all the relevant bits in bsd-user upstream.

Note, QEMU / checkpatch.pl only requires SDPX on *newly* authored files.
Existing code files, or new files whose content is copied from an
existing file (either inside or outside QEMU git) are exempt from this
and in fact required to be left without SPDX.

The reasoning is that there is some uncertainty about the legality of
removing license header text from existing files due to the GPL clause
1 which says

  "keep intact all the notices that refer to this License and
   to the absence of any warranty;"

I interpret that to mean we can not remove license header text from
files unless the person doing the removal is the exclusive copyright
holder, or has got recorded permission from all copyright holders
that apply to each file changed.

It is confusing for people because Linux removed all their GPL header
text in favour of SPDX, but never provided any clear explanation of
why they considered that to be acceptable from the GPL compliance POV.

> ---
>  bsd-user/aarch64/signal.c               | 15 ++-------------
>  bsd-user/aarch64/target_arch.h          | 16 ++--------------
>  bsd-user/aarch64/target_arch_cpu.c      | 15 ++-------------
>  bsd-user/aarch64/target_arch_cpu.h      | 18 +++---------------
>  bsd-user/aarch64/target_arch_elf.h      | 14 +-------------
>  bsd-user/aarch64/target_arch_reg.h      | 19 +++----------------
>  bsd-user/aarch64/target_arch_signal.h   | 16 ++--------------
>  bsd-user/aarch64/target_arch_sigtramp.h | 16 ++--------------
>  bsd-user/aarch64/target_arch_sysarch.h  | 16 ++--------------
>  bsd-user/aarch64/target_arch_thread.h   | 16 ++--------------
>  bsd-user/aarch64/target_arch_vmparam.h  | 16 ++--------------
>  bsd-user/aarch64/target_syscall.h       | 16 ++--------------
>  bsd-user/arm/signal.c                   | 18 +++---------------
>  bsd-user/arm/target_arch.h              | 16 ++--------------
>  bsd-user/arm/target_arch_cpu.c          | 18 +++---------------
>  bsd-user/arm/target_arch_cpu.h          | 18 +++---------------
>  bsd-user/arm/target_arch_elf.h          | 18 +++---------------
>  bsd-user/arm/target_arch_reg.h          | 18 +++---------------
>  bsd-user/arm/target_arch_signal.h       | 18 +++---------------
>  bsd-user/arm/target_arch_sigtramp.h     | 18 +++---------------
>  bsd-user/arm/target_arch_sysarch.h      | 18 +++---------------
>  bsd-user/arm/target_arch_thread.h       | 18 +++---------------
>  bsd-user/arm/target_arch_vmparam.h      | 18 +++---------------
>  bsd-user/arm/target_syscall.h           | 18 +++---------------
>  bsd-user/bsd-file.h                     | 18 +++---------------
>  bsd-user/bsd-mem.c                      | 17 +++--------------
>  bsd-user/bsd-mem.h                      | 17 +++--------------
>  bsd-user/bsd-proc.c                     | 17 +++--------------
>  bsd-user/bsd-proc.h                     | 17 +++--------------
>  bsd-user/bsdload.c                      | 17 +++--------------
>  bsd-user/elfload.c                      | 17 +++--------------
>  bsd-user/freebsd/os-misc.h              | 18 +++---------------
>  bsd-user/freebsd/os-proc.c              | 17 +++--------------
>  bsd-user/freebsd/os-proc.h              | 18 +++---------------
>  bsd-user/freebsd/os-stat.c              | 17 +++--------------
>  bsd-user/freebsd/os-stat.h              | 18 +++---------------
>  bsd-user/freebsd/os-strace.h            | 19 +++----------------
>  bsd-user/freebsd/target_os_elf.h        | 18 +++---------------
>  bsd-user/freebsd/target_os_siginfo.h    | 18 +++---------------
>  bsd-user/freebsd/target_os_stack.h      | 18 +++---------------
>  bsd-user/freebsd/target_os_thread.h     | 18 +++---------------
>  bsd-user/freebsd/target_os_user.h       | 18 +++---------------
>  bsd-user/freebsd/target_os_vmparam.h    | 18 +++---------------
>  bsd-user/i386/signal.c                  | 17 +++--------------
>  bsd-user/i386/target_arch.h             | 16 ++--------------
>  bsd-user/i386/target_arch_cpu.c         | 17 +++--------------
>  bsd-user/i386/target_arch_cpu.h         | 17 +++--------------
>  bsd-user/i386/target_arch_elf.h         | 18 +++---------------
>  bsd-user/i386/target_arch_reg.h         | 19 +++----------------
>  bsd-user/i386/target_arch_signal.h      | 16 +++-------------
>  bsd-user/i386/target_arch_sigtramp.h    | 16 ++--------------
>  bsd-user/i386/target_arch_sysarch.h     | 18 +++---------------
>  bsd-user/i386/target_arch_thread.h      | 18 +++---------------
>  bsd-user/i386/target_arch_vmparam.h     | 18 +++---------------
>  bsd-user/i386/target_syscall.h          | 16 +++-------------
>  bsd-user/main.c                         | 20 ++++----------------
>  bsd-user/mmap.c                         | 17 +++--------------
>  bsd-user/qemu-bsd.h                     | 18 +++---------------
>  bsd-user/qemu.h                         | 15 +++------------
>  bsd-user/signal.c                       | 19 ++++---------------
>  bsd-user/strace.c                       | 16 +++-------------
>  bsd-user/syscall_defs.h                 | 18 +++---------------
>  bsd-user/x86_64/signal.c                | 16 +++-------------
>  bsd-user/x86_64/target_arch.h           | 16 ++--------------
>  bsd-user/x86_64/target_arch_cpu.c       | 17 +++--------------
>  bsd-user/x86_64/target_arch_cpu.h       | 17 +++--------------
>  bsd-user/x86_64/target_arch_elf.h       | 18 +++---------------
>  bsd-user/x86_64/target_arch_reg.h       | 19 +++----------------
>  bsd-user/x86_64/target_arch_signal.h    | 17 +++--------------
>  bsd-user/x86_64/target_arch_sigtramp.h  | 17 ++---------------
>  bsd-user/x86_64/target_arch_sysarch.h   | 17 +++--------------
>  bsd-user/x86_64/target_arch_thread.h    | 18 +++---------------
>  bsd-user/x86_64/target_arch_vmparam.h   | 18 +++---------------
>  bsd-user/x86_64/target_syscall.h        | 16 +++-------------
>  74 files changed, 208 insertions(+), 1069 deletions(-)
> 
> diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> index 6bc73a798f..ad19e5144e 100644
> --- a/bsd-user/aarch64/signal.c
> +++ b/bsd-user/aarch64/signal.c
> @@ -1,20 +1,9 @@
>  /*
>   * ARM AArch64 specific signal definitions for bsd-user
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  
> diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_arch.h
> index 4815a56ae3..7861233889 100644
> --- a/bsd-user/aarch64/target_arch.h
> +++ b/bsd-user/aarch64/target_arch.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 specific prototypes for bsd-user
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_H
>  #define TARGET_ARCH_H
>  
> diff --git a/bsd-user/aarch64/target_arch_cpu.c b/bsd-user/aarch64/target_arch_cpu.c
> index b2fa59efaf..6e9519e1b0 100644
> --- a/bsd-user/aarch64/target_arch_cpu.c
> +++ b/bsd-user/aarch64/target_arch_cpu.c
> @@ -1,20 +1,9 @@
>  /*
>   * ARM AArch64 specific CPU for bsd-user
>   *
> - * Copyright (c) 2015 Stacey Son
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  #include "target_arch.h"
> diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
> index 15df84fda2..09d942b040 100644
> --- a/bsd-user/aarch64/target_arch_cpu.h
> +++ b/bsd-user/aarch64/target_arch_cpu.h
> @@ -1,22 +1,10 @@
>  /*
> - *  ARM AArch64 cpu init and loop
> + * ARM AArch64 cpu init and loop
>   *
> - * Copyright (c) 2015 Stacey Son
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_CPU_H
>  #define TARGET_ARCH_CPU_H
>  
> diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
> index cec254f88b..5ea5232a57 100644
> --- a/bsd-user/aarch64/target_arch_elf.h
> +++ b/bsd-user/aarch64/target_arch_elf.h
> @@ -3,20 +3,8 @@
>   *
>   * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>  
> diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
> index b53302e7f7..9cca3c0ea0 100644
> --- a/bsd-user/aarch64/target_arch_reg.h
> +++ b/bsd-user/aarch64/target_arch_reg.h
> @@ -1,23 +1,10 @@
>  /*
> - *  FreeBSD arm64 register structures
> + * FreeBSD arm64 register structures
>   *
> - *  Copyright (c) 2015 Stacey Son
> - *  All rights reserved.
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_REG_H
>  #define TARGET_ARCH_REG_H
>  
> diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
> index b72ba7aa50..6085217546 100644
> --- a/bsd-user/aarch64/target_arch_signal.h
> +++ b/bsd-user/aarch64/target_arch_signal.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 specific signal definitions for bsd-user
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGNAL_H
>  #define TARGET_ARCH_SIGNAL_H
>  
> diff --git a/bsd-user/aarch64/target_arch_sigtramp.h b/bsd-user/aarch64/target_arch_sigtramp.h
> index 8cdd33b621..38a447fc25 100644
> --- a/bsd-user/aarch64/target_arch_sigtramp.h
> +++ b/bsd-user/aarch64/target_arch_sigtramp.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 sigcode for bsd-user
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGTRAMP_H
>  #define TARGET_ARCH_SIGTRAMP_H
>  
> diff --git a/bsd-user/aarch64/target_arch_sysarch.h b/bsd-user/aarch64/target_arch_sysarch.h
> index b003015daf..5569c996cb 100644
> --- a/bsd-user/aarch64/target_arch_sysarch.h
> +++ b/bsd-user/aarch64/target_arch_sysarch.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 sysarch() system call emulation for bsd-user.
>   *
> - * Copyright (c) 2015 <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SYSARCH_H
>  #define TARGET_ARCH_SYSARCH_H
>  
> diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
> index 4c911e605a..06676980c9 100644
> --- a/bsd-user/aarch64/target_arch_thread.h
> +++ b/bsd-user/aarch64/target_arch_thread.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 thread support for bsd-user.
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_THREAD_H
>  #define TARGET_ARCH_THREAD_H
>  
> diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64/target_arch_vmparam.h
> index 0c35491970..ea32f5b56d 100644
> --- a/bsd-user/aarch64/target_arch_vmparam.h
> +++ b/bsd-user/aarch64/target_arch_vmparam.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 VM parameters definitions for bsd-user.
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_VMPARAM_H
>  #define TARGET_ARCH_VMPARAM_H
>  
> diff --git a/bsd-user/aarch64/target_syscall.h b/bsd-user/aarch64/target_syscall.h
> index 08ae913c42..a574edc429 100644
> --- a/bsd-user/aarch64/target_syscall.h
> +++ b/bsd-user/aarch64/target_syscall.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM AArch64 specific CPU for bsd-user
>   *
> - * Copyright (c) 2015 Stacey D. Son <sson at Freebsd>
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef BSD_USER_AARCH64_TARGET_SYSCALL_H
>  #define BSD_USER_AARCH64_TARGET_SYSCALL_H
>  
> diff --git a/bsd-user/arm/signal.c b/bsd-user/arm/signal.c
> index 9734407543..35cedeba06 100644
> --- a/bsd-user/arm/signal.c
> +++ b/bsd-user/arm/signal.c
> @@ -1,22 +1,10 @@
>  /*
> - *  arm signal functions
> + * arm signal functions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #include "qemu/osdep.h"
>  #include "qemu.h"
>  
> diff --git a/bsd-user/arm/target_arch.h b/bsd-user/arm/target_arch.h
> index d80cb85c64..e0add162e8 100644
> --- a/bsd-user/arm/target_arch.h
> +++ b/bsd-user/arm/target_arch.h
> @@ -1,22 +1,10 @@
>  /*
>   * ARM 32-bit specific prototypes for bsd-user
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_H
>  #define TARGET_ARCH_H
>  
> diff --git a/bsd-user/arm/target_arch_cpu.c b/bsd-user/arm/target_arch_cpu.c
> index fe38ae2210..6a4f5cec0e 100644
> --- a/bsd-user/arm/target_arch_cpu.c
> +++ b/bsd-user/arm/target_arch_cpu.c
> @@ -1,22 +1,10 @@
>  /*
> - *  arm cpu related code
> + * arm cpu related code
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #include "qemu/osdep.h"
>  #include "target_arch.h"
>  
> diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
> index 9a952ef0ff..faef3ea17a 100644
> --- a/bsd-user/arm/target_arch_cpu.h
> +++ b/bsd-user/arm/target_arch_cpu.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm cpu init and loop
> + * arm cpu init and loop
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_CPU_H
>  #define TARGET_ARCH_CPU_H
>  
> diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch_elf.h
> index b54bf5fbc6..fd13bc87f4 100644
> --- a/bsd-user/arm/target_arch_elf.h
> +++ b/bsd-user/arm/target_arch_elf.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm ELF definitions
> + * arm ELF definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>  
> diff --git a/bsd-user/arm/target_arch_reg.h b/bsd-user/arm/target_arch_reg.h
> index 070fa24da1..9d23dda27d 100644
> --- a/bsd-user/arm/target_arch_reg.h
> +++ b/bsd-user/arm/target_arch_reg.h
> @@ -1,22 +1,10 @@
>  /*
> - *  FreeBSD arm register structures
> + * FreeBSD arm register structures
>   *
> - *  Copyright (c) 2015 Stacey Son
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_REG_H
>  #define TARGET_ARCH_REG_H
>  
> diff --git a/bsd-user/arm/target_arch_signal.h b/bsd-user/arm/target_arch_signal.h
> index 10f96b8bfc..dfaefa25d1 100644
> --- a/bsd-user/arm/target_arch_signal.h
> +++ b/bsd-user/arm/target_arch_signal.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm signal definitions
> + * arm signal definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGNAL_H
>  #define TARGET_ARCH_SIGNAL_H
>  
> diff --git a/bsd-user/arm/target_arch_sigtramp.h b/bsd-user/arm/target_arch_sigtramp.h
> index 06198045ed..8a2d34aafc 100644
> --- a/bsd-user/arm/target_arch_sigtramp.h
> +++ b/bsd-user/arm/target_arch_sigtramp.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm sysarch() system call emulation
> + * arm sysarch() system call emulation
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGTRAMP_H
>  #define TARGET_ARCH_SIGTRAMP_H
>  
> diff --git a/bsd-user/arm/target_arch_sysarch.h b/bsd-user/arm/target_arch_sysarch.h
> index 5cb7864197..5f7c421e11 100644
> --- a/bsd-user/arm/target_arch_sysarch.h
> +++ b/bsd-user/arm/target_arch_sysarch.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm sysarch() system call emulation
> + * arm sysarch() system call emulation
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SYSARCH_H
>  #define TARGET_ARCH_SYSARCH_H
>  
> diff --git a/bsd-user/arm/target_arch_thread.h b/bsd-user/arm/target_arch_thread.h
> index fd257f313d..d22619a845 100644
> --- a/bsd-user/arm/target_arch_thread.h
> +++ b/bsd-user/arm/target_arch_thread.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm thread support
> + * arm thread support
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_THREAD_H
>  #define TARGET_ARCH_THREAD_H
>  
> diff --git a/bsd-user/arm/target_arch_vmparam.h b/bsd-user/arm/target_arch_vmparam.h
> index 3fb69aff51..c973fcf7d5 100644
> --- a/bsd-user/arm/target_arch_vmparam.h
> +++ b/bsd-user/arm/target_arch_vmparam.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm VM parameters definitions
> + * arm VM parameters definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_VMPARAM_H
>  #define TARGET_ARCH_VMPARAM_H
>  
> diff --git a/bsd-user/arm/target_syscall.h b/bsd-user/arm/target_syscall.h
> index 5804a53541..deab3baebf 100644
> --- a/bsd-user/arm/target_syscall.h
> +++ b/bsd-user/arm/target_syscall.h
> @@ -1,22 +1,10 @@
>  /*
> - *  arm cpu system call stubs
> + * arm cpu system call stubs
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef ARM_TARGET_SYSCALL_H
>  #define ARM_TARGET_SYSCALL_H
>  
> diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
> index 6fa2c30b4d..dca1518cb1 100644
> --- a/bsd-user/bsd-file.h
> +++ b/bsd-user/bsd-file.h
> @@ -1,22 +1,10 @@
>  /*
> - *  file related system call shims and definitions
> + * file related system call shims and definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef BSD_FILE_H
>  #define BSD_FILE_H
>  
> diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> index 2ab1334b70..8c6c4081f7 100644
> --- a/bsd-user/bsd-mem.c
> +++ b/bsd-user/bsd-mem.c
> @@ -1,20 +1,9 @@
>  /*
> - *  memory management system conversion routines
> + * memory management system conversion routines
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  #include "qemu.h"
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index a118e57260..8c0b0b6919 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -1,20 +1,9 @@
>  /*
> - *  memory management system call shims and definitions
> + * memory management system call shims and definitions
>   *
> - *  Copyright (c) 2013-15 Stacey D. Son
> + * Copyright (c) 2013-2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  /*
> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> index 8dcac9608d..7fb46046c7 100644
> --- a/bsd-user/bsd-proc.c
> +++ b/bsd-user/bsd-proc.c
> @@ -1,20 +1,9 @@
>  /*
> - *  BSD process related system call helpers
> + * BSD process related system call helpers
>   *
> - *  Copyright (c) 2013-14 Stacey D. Son
> + * Copyright (c) 2013-2014 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  
> diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> index 8b1c2deea3..b1d4446ff1 100644
> --- a/bsd-user/bsd-proc.h
> +++ b/bsd-user/bsd-proc.h
> @@ -1,20 +1,9 @@
>  /*
> - *  process related system call shims and definitions
> + * process related system call shims and definitions
>   *
> - *  Copyright (c) 2013-2014 Stacey D. Son
> + * Copyright (c) 2013-2014 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #ifndef BSD_PROC_H_
> diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
> index 5b3c061a45..b3c9f0265b 100644
> --- a/bsd-user/bsdload.c
> +++ b/bsd-user/bsdload.c
> @@ -1,22 +1,11 @@
>  /*
> - *  Load BSD executables.
> + * Load BSD executables.
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #include "qemu/osdep.h"
> -
>  #include "qemu.h"
>  
>  /* ??? This should really be somewhere else.  */
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 3bca0cc9ed..ddac272424 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -1,20 +1,9 @@
>  /*
> - *  ELF loading code
> + * ELF loading code
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
> index 71145764a4..d9979b2a8b 100644
> --- a/bsd-user/freebsd/os-misc.h
> +++ b/bsd-user/freebsd/os-misc.h
> @@ -1,22 +1,10 @@
>  /*
> - *  miscellaneous FreeBSD system call shims
> + * miscellaneous FreeBSD system call shims
>   *
> - *  Copyright (c) 2013-14 Stacey D. Son
> + * Copyright (c) 2013-2014 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef OS_MISC_H
>  #define OS_MISC_H
>  
> diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> index bf993f1b66..0309036178 100644
> --- a/bsd-user/freebsd/os-proc.c
> +++ b/bsd-user/freebsd/os-proc.c
> @@ -1,20 +1,9 @@
>  /*
> - *  FreeBSD process related emulation code
> + * FreeBSD process related emulation code
>   *
> - *  Copyright (c) 2013-15 Stacey D. Son
> + * Copyright (c) 2013-2014 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index cc53215138..72ccf23e17 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -1,22 +1,10 @@
>  /*
> - *  process related system call shims and definitions
> + * process related system call shims and definitions
>   *
> - *  Copyright (c) 2013-14 Stacey D. Son
> + * Copyright (c) 2013-2014 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef BSD_USER_FREEBSD_OS_PROC_H
>  #define BSD_USER_FREEBSD_OS_PROC_H
>  
> diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
> index f0f9e609c3..10870430fe 100644
> --- a/bsd-user/freebsd/os-stat.c
> +++ b/bsd-user/freebsd/os-stat.c
> @@ -1,20 +1,9 @@
>  /*
> - *  FreeBSD stat related conversion routines
> + * FreeBSD stat related conversion routines
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  
> diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
> index 3bdc66aa98..ea95aa6344 100644
> --- a/bsd-user/freebsd/os-stat.h
> +++ b/bsd-user/freebsd/os-stat.h
> @@ -1,22 +1,10 @@
>  /*
> - *  stat related system call shims and definitions
> + * stat related system call shims and definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef BSD_USER_FREEBSD_OS_STAT_H
>  #define BSD_USER_FREEBSD_OS_STAT_H
>  
> diff --git a/bsd-user/freebsd/os-strace.h b/bsd-user/freebsd/os-strace.h
> index a222f093b5..ad48e99db1 100644
> --- a/bsd-user/freebsd/os-strace.h
> +++ b/bsd-user/freebsd/os-strace.h
> @@ -1,25 +1,12 @@
>  /*
> - *  FreeBSD dependent strace print functions
> + * FreeBSD dependent strace print functions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #include "target_arch_sysarch.h"    /* architecture dependent functions */
>  
> -
>  static inline void do_os_print_sysarch(const struct syscallname *name,
>          abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4,
>          abi_long arg5, abi_long arg6)
> diff --git a/bsd-user/freebsd/target_os_elf.h b/bsd-user/freebsd/target_os_elf.h
> index 01124979f7..c67e5a0f8e 100644
> --- a/bsd-user/freebsd/target_os_elf.h
> +++ b/bsd-user/freebsd/target_os_elf.h
> @@ -1,22 +1,10 @@
>  /*
> - *  freebsd ELF definitions
> + * FreeBSD ELF definitions
>   *
> - *  Copyright (c) 2013-15 Stacey D. Son
> + * Copyright (c) 2013-2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_OS_ELF_H
>  #define TARGET_OS_ELF_H
>  
> diff --git a/bsd-user/freebsd/target_os_siginfo.h b/bsd-user/freebsd/target_os_siginfo.h
> index 6c282d8502..e7cf76b9bd 100644
> --- a/bsd-user/freebsd/target_os_siginfo.h
> +++ b/bsd-user/freebsd/target_os_siginfo.h
> @@ -1,22 +1,10 @@
>  /*
> - *  FreeBSD siginfo related definitions
> + * FreeBSD siginfo related definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_OS_SIGINFO_H
>  #define TARGET_OS_SIGINFO_H
>  
> diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/target_os_stack.h
> index ac0ef22cd7..262f33d839 100644
> --- a/bsd-user/freebsd/target_os_stack.h
> +++ b/bsd-user/freebsd/target_os_stack.h
> @@ -1,22 +1,10 @@
>  /*
> - *  FreeBSD setup_initial_stack() implementation.
> + * FreeBSD setup_initial_stack() implementation.
>   *
> - *  Copyright (c) 2013-14 Stacey D. Son
> + * Copyright (c) 2013-2014 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_OS_STACK_H
>  #define TARGET_OS_STACK_H
>  
> diff --git a/bsd-user/freebsd/target_os_thread.h b/bsd-user/freebsd/target_os_thread.h
> index 1b32cebd26..ff88679e40 100644
> --- a/bsd-user/freebsd/target_os_thread.h
> +++ b/bsd-user/freebsd/target_os_thread.h
> @@ -1,22 +1,10 @@
>  /*
> - *  FreeBSD thread dependent code and definitions
> + * FreeBSD thread dependent code and definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_OS_THREAD_H
>  #define TARGET_OS_THREAD_H
>  
> diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
> index 1ca7b5ab17..9703b9a61a 100644
> --- a/bsd-user/freebsd/target_os_user.h
> +++ b/bsd-user/freebsd/target_os_user.h
> @@ -1,22 +1,10 @@
>  /*
> - *  sys/user.h definitions
> + * sys/user.h definitions
>   *
> - *  Copyright (c) 2015 Stacey D. Son (sson at FreeBSD)
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_OS_USER_H
>  #define TARGET_OS_USER_H
>  
> diff --git a/bsd-user/freebsd/target_os_vmparam.h b/bsd-user/freebsd/target_os_vmparam.h
> index 8457dd3913..9feec5296d 100644
> --- a/bsd-user/freebsd/target_os_vmparam.h
> +++ b/bsd-user/freebsd/target_os_vmparam.h
> @@ -1,22 +1,10 @@
>  /*
> - *  FreeBSD VM parameters definitions
> + * FreeBSD VM parameters definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_OS_VMPARAM_H
>  #define TARGET_OS_VMPARAM_H
>  
> diff --git a/bsd-user/i386/signal.c b/bsd-user/i386/signal.c
> index a3131047b8..742032090d 100644
> --- a/bsd-user/i386/signal.c
> +++ b/bsd-user/i386/signal.c
> @@ -1,20 +1,9 @@
>  /*
> - *  i386 dependent signal definitions
> + * i386 dependent signal definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/i386/target_arch.h b/bsd-user/i386/target_arch.h
> index 9595e60f09..74c8e7fb47 100644
> --- a/bsd-user/i386/target_arch.h
> +++ b/bsd-user/i386/target_arch.h
> @@ -1,22 +1,10 @@
>  /*
>   * Intel x86 specific prototypes for bsd-user
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_H
>  #define TARGET_ARCH_H
>  
> diff --git a/bsd-user/i386/target_arch_cpu.c b/bsd-user/i386/target_arch_cpu.c
> index 2a3af2ddef..fa8ad4b385 100644
> --- a/bsd-user/i386/target_arch_cpu.c
> +++ b/bsd-user/i386/target_arch_cpu.c
> @@ -1,20 +1,9 @@
>  /*
> - *  i386 cpu related code
> + * i386 cpu related code
>   *
> - * Copyright (c) 2013 Stacey Son <sson@FreeBSD.org>
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
> index f147d5b6f8..c6e8bfd8ca 100644
> --- a/bsd-user/i386/target_arch_cpu.h
> +++ b/bsd-user/i386/target_arch_cpu.h
> @@ -1,21 +1,10 @@
>  /*
> - *  i386 cpu init and loop
> + * i386 cpu init and loop
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_CPU_H
>  #define TARGET_ARCH_CPU_H
>  
> diff --git a/bsd-user/i386/target_arch_elf.h b/bsd-user/i386/target_arch_elf.h
> index 4ac27b02e7..99cff66a22 100644
> --- a/bsd-user/i386/target_arch_elf.h
> +++ b/bsd-user/i386/target_arch_elf.h
> @@ -1,22 +1,10 @@
>  /*
> - *  i386 ELF definitions
> + * i386 ELF definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>  
> diff --git a/bsd-user/i386/target_arch_reg.h b/bsd-user/i386/target_arch_reg.h
> index 8123109697..cebf2fd5cc 100644
> --- a/bsd-user/i386/target_arch_reg.h
> +++ b/bsd-user/i386/target_arch_reg.h
> @@ -1,23 +1,10 @@
>  /*
> - *  FreeBSD i386 register structures
> + * FreeBSD i386 register structures
>   *
> - *  Copyright (c) 2015 Stacey Son
> - *  All rights reserved.
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_REG_H
>  #define TARGET_ARCH_REG_H
>  
> diff --git a/bsd-user/i386/target_arch_signal.h b/bsd-user/i386/target_arch_signal.h
> index 2c14153ab6..070ba4357a 100644
> --- a/bsd-user/i386/target_arch_signal.h
> +++ b/bsd-user/i386/target_arch_signal.h
> @@ -1,19 +1,9 @@
>  /*
> - *  i386 dependent signal definitions
> + * i386 dependent signal definitions
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #ifndef TARGET_ARCH_SIGNAL_H
>  #define TARGET_ARCH_SIGNAL_H
> diff --git a/bsd-user/i386/target_arch_sigtramp.h b/bsd-user/i386/target_arch_sigtramp.h
> index ef94cc864f..ace243b6f5 100644
> --- a/bsd-user/i386/target_arch_sigtramp.h
> +++ b/bsd-user/i386/target_arch_sigtramp.h
> @@ -1,22 +1,10 @@
>  /*
>   * Intel i386  sigcode for bsd-user
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGTRAMP_H
>  #define TARGET_ARCH_SIGTRAMP_H
>  
> diff --git a/bsd-user/i386/target_arch_sysarch.h b/bsd-user/i386/target_arch_sysarch.h
> index db8fee6380..7b128dfab1 100644
> --- a/bsd-user/i386/target_arch_sysarch.h
> +++ b/bsd-user/i386/target_arch_sysarch.h
> @@ -1,22 +1,10 @@
>  /*
> - *  i386 sysarch system call emulation
> + * i386 sysarch system call emulation
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SYSARCH_H
>  #define TARGET_ARCH_SYSARCH_H
>  
> diff --git a/bsd-user/i386/target_arch_thread.h b/bsd-user/i386/target_arch_thread.h
> index cee2148d94..8ef4f6b648 100644
> --- a/bsd-user/i386/target_arch_thread.h
> +++ b/bsd-user/i386/target_arch_thread.h
> @@ -1,22 +1,10 @@
>  /*
> - *  i386 thread support
> + * i386 thread support
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_THREAD_H
>  #define TARGET_ARCH_THREAD_H
>  
> diff --git a/bsd-user/i386/target_arch_vmparam.h b/bsd-user/i386/target_arch_vmparam.h
> index 79db420e59..cdf6ab0a49 100644
> --- a/bsd-user/i386/target_arch_vmparam.h
> +++ b/bsd-user/i386/target_arch_vmparam.h
> @@ -1,22 +1,10 @@
>  /*
> - *  i386 VM parameters definitions
> + * i386 VM parameters definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_VMPARAM_H
>  #define TARGET_ARCH_VMPARAM_H
>  
> diff --git a/bsd-user/i386/target_syscall.h b/bsd-user/i386/target_syscall.h
> index 940c687a52..a52851f635 100644
> --- a/bsd-user/i386/target_syscall.h
> +++ b/bsd-user/i386/target_syscall.h
> @@ -1,19 +1,9 @@
>  /*
> - *  i386 system call definitions
> + * i386 system call definitions
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #ifndef TARGET_SYSCALL_H
>  #define TARGET_SYSCALL_H
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 73aae8c327..84351e1631 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -1,23 +1,11 @@
>  /*
> - *  qemu bsd user main
> + * qemu bsd user main
>   *
> - *  Copyright (c) 2003-2008 Fabrice Bellard
> - *  Copyright (c) 2013-14 Stacey Son
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + * Copyright (c) 2013-14 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #include "qemu/osdep.h"
>  #include <sys/resource.h>
>  #include <sys/sysctl.h>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index 24ba1728eb..fb685e84aa 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -1,20 +1,9 @@
>  /*
> - *  mmap support for qemu
> + * mmap support for qemu
>   *
> - *  Copyright (c) 2003 - 2008 Fabrice Bellard
> + * Copyright (c) 2003 - 2008 Fabrice Bellard
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  #include "exec/mmap-lock.h"
> diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> index 56affcd31d..64d4fbe3a9 100644
> --- a/bsd-user/qemu-bsd.h
> +++ b/bsd-user/qemu-bsd.h
> @@ -1,22 +1,10 @@
>  /*
> - *  BSD conversion extern declarations
> + * BSD conversion extern declarations
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef QEMU_BSD_H
>  #define QEMU_BSD_H
>  
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 93388e7c34..c4ff1fb0eb 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -1,18 +1,9 @@
>  /*
> - *  qemu bsd user mode definition
> + * qemu bsd user mode definition
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #ifndef QEMU_H
>  #define QEMU_H
> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index dadcc037dc..832ffef7c5 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -1,21 +1,10 @@
>  /*
> - *  Emulation of BSD signals
> + * Emulation of BSD signals
>   *
> - *  Copyright (c) 2003 - 2008 Fabrice Bellard
> - *  Copyright (c) 2013 Stacey Son
> + * Copyright (c) 2003 - 2008 Fabrice Bellard
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/strace.c b/bsd-user/strace.c
> index 6dc01d3be7..a015bfddba 100644
> --- a/bsd-user/strace.c
> +++ b/bsd-user/strace.c
> @@ -1,19 +1,9 @@
>  /*
> - *  System call tracing and debugging
> + * System call tracing and debugging
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index cc4b484f3a..a2ded2fac1 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -1,22 +1,10 @@
>  /*
> - *  System call related declarations
> + * System call related declarations
>   *
> - *  Copyright (c) 2013-15 Stacey D. Son (sson at FreeBSD)
> + * Copyright (c) 2013-2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef SYSCALL_DEFS_H
>  #define SYSCALL_DEFS_H
>  
> diff --git a/bsd-user/x86_64/signal.c b/bsd-user/x86_64/signal.c
> index 46cb865180..823d7217ad 100644
> --- a/bsd-user/x86_64/signal.c
> +++ b/bsd-user/x86_64/signal.c
> @@ -1,19 +1,9 @@
>  /*
> - *  x86_64 signal definitions
> + * x86_64 signal definitions
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/x86_64/target_arch.h b/bsd-user/x86_64/target_arch.h
> index 09bd974889..177e6b442a 100644
> --- a/bsd-user/x86_64/target_arch.h
> +++ b/bsd-user/x86_64/target_arch.h
> @@ -1,22 +1,10 @@
>  /*
>   * Intel x86_64 specific prototypes for bsd-user
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_H
>  #define TARGET_ARCH_H
>  
> diff --git a/bsd-user/x86_64/target_arch_cpu.c b/bsd-user/x86_64/target_arch_cpu.c
> index 1d32f18907..aeeb1235c9 100644
> --- a/bsd-user/x86_64/target_arch_cpu.c
> +++ b/bsd-user/x86_64/target_arch_cpu.c
> @@ -1,20 +1,9 @@
>  /*
> - *  x86_64 cpu related code
> + * x86_64 cpu related code
>   *
> - * Copyright (c) 2013 Stacey Son <sson@FreeBSD.org>
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
>  #include "qemu/osdep.h"
> diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
> index 1fa71d87f1..f12a8ab49e 100644
> --- a/bsd-user/x86_64/target_arch_cpu.h
> +++ b/bsd-user/x86_64/target_arch_cpu.h
> @@ -1,21 +1,10 @@
>  /*
> - *  x86_64 cpu init and loop
> + * x86_64 cpu init and loop
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_CPU_H
>  #define TARGET_ARCH_CPU_H
>  
> diff --git a/bsd-user/x86_64/target_arch_elf.h b/bsd-user/x86_64/target_arch_elf.h
> index e51c2faf08..020533904e 100644
> --- a/bsd-user/x86_64/target_arch_elf.h
> +++ b/bsd-user/x86_64/target_arch_elf.h
> @@ -1,22 +1,10 @@
>  /*
> - *  x86_64 ELF definitions
> + * x86_64 ELF definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>  
> diff --git a/bsd-user/x86_64/target_arch_reg.h b/bsd-user/x86_64/target_arch_reg.h
> index 7a766de918..c0c766ac1a 100644
> --- a/bsd-user/x86_64/target_arch_reg.h
> +++ b/bsd-user/x86_64/target_arch_reg.h
> @@ -1,23 +1,10 @@
>  /*
> - *  FreeBSD amd64 register structures
> + * FreeBSD amd64 register structures
>   *
> - *  Copyright (c) 2015 Stacey Son
> - *  All rights reserved.
> + * Copyright (c) 2015 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_REG_H
>  #define TARGET_ARCH_REG_H
>  
> diff --git a/bsd-user/x86_64/target_arch_signal.h b/bsd-user/x86_64/target_arch_signal.h
> index f833ee66ce..2b63048f8b 100644
> --- a/bsd-user/x86_64/target_arch_signal.h
> +++ b/bsd-user/x86_64/target_arch_signal.h
> @@ -1,21 +1,10 @@
>  /*
> - *  x86_64 signal definitions
> + * x86_64 signal definitions
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGNAL_H
>  #define TARGET_ARCH_SIGNAL_H
>  
> diff --git a/bsd-user/x86_64/target_arch_sigtramp.h b/bsd-user/x86_64/target_arch_sigtramp.h
> index 01da614098..cab22fb7e8 100644
> --- a/bsd-user/x86_64/target_arch_sigtramp.h
> +++ b/bsd-user/x86_64/target_arch_sigtramp.h
> @@ -1,29 +1,16 @@
>  /*
>   * Intel x86_64  sigcode for bsd-user
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SIGTRAMP_H
>  #define TARGET_ARCH_SIGTRAMP_H
>  
>  static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
>          unsigned sys_sigreturn)
>  {
> -
>      return 0;
>  }
>  #endif /* TARGET_ARCH_SIGTRAMP_H */
> diff --git a/bsd-user/x86_64/target_arch_sysarch.h b/bsd-user/x86_64/target_arch_sysarch.h
> index 152cb8bcb8..3a6f74161f 100644
> --- a/bsd-user/x86_64/target_arch_sysarch.h
> +++ b/bsd-user/x86_64/target_arch_sysarch.h
> @@ -1,21 +1,10 @@
>  /*
> - *  x86_64 sysarch() syscall emulation
> + * x86_64 sysarch() syscall emulation
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_SYSARCH_H
>  #define TARGET_ARCH_SYSARCH_H
>  
> diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/target_arch_thread.h
> index 7739bb2154..176c347037 100644
> --- a/bsd-user/x86_64/target_arch_thread.h
> +++ b/bsd-user/x86_64/target_arch_thread.h
> @@ -1,22 +1,10 @@
>  /*
> - *  x86_64 thread support
> + * x86_64 thread support
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_THREAD_H
>  #define TARGET_ARCH_THREAD_H
>  
> diff --git a/bsd-user/x86_64/target_arch_vmparam.h b/bsd-user/x86_64/target_arch_vmparam.h
> index 6797623a6b..8919c5e6e5 100644
> --- a/bsd-user/x86_64/target_arch_vmparam.h
> +++ b/bsd-user/x86_64/target_arch_vmparam.h
> @@ -1,22 +1,10 @@
>  /*
> - *  Intel x86_64 VM parameters definitions
> + * Intel x86_64 VM parameters definitions
>   *
> - *  Copyright (c) 2013 Stacey D. Son
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> -
>  #ifndef TARGET_ARCH_VMPARAM_H
>  #define TARGET_ARCH_VMPARAM_H
>  
> diff --git a/bsd-user/x86_64/target_syscall.h b/bsd-user/x86_64/target_syscall.h
> index a8e6274b76..5adced9bde 100644
> --- a/bsd-user/x86_64/target_syscall.h
> +++ b/bsd-user/x86_64/target_syscall.h
> @@ -1,19 +1,9 @@
>  /*
> - *  x86_64 system call definitions
> + * x86_64 system call definitions
>   *
> + * Copyright (c) 2013 Stacey D. Son
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #ifndef TARGET_SYSCALL_H
>  #define TARGET_SYSCALL_H
> 
> ---
> base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
> change-id: 20260302-bsd-user-copyright-3a46d2307150
> 
> Best regards,
> -- 
> Warner Losh <imp@bsdimp.com>
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


