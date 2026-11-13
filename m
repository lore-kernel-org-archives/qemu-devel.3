Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027A606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=SmPXKuCu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRpT7-0007LL-Qx; Fri, 13 Nov 2026 06:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xRpT6-0007Io-E4
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:29:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1xRpT3-00078V-UI
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794569347; bh=1LOYWCEUjRZqOO1xnE4FI2GWglpmD0zcNrFfGIgQELY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SmPXKuCujmOVqZE+FEjzWgZFGvgtdapeQm87fny7v7XvI+cN8IrRQntwWB0RREDky
 Yiq01EdrxNkWmCpSX9ED9JrXSt5fbjnBsJ6S0onSfSi2QEjAypOjKdpA5M2ibO7xzy
 6Txo3+cOiU6S/P5k68i03QDqa1zN8iR+Y8UBqY4SEksbJY2sbkYav3sDSSyHeNB7tF
 B5Gj0GipjBfbPXONtoUs1DayC6HEEJmYLw/J5icQfzfLdkyURD/k47U5hM0a6P+DC6
 i6euSTLG3SuLaVAvWRIPQhQgZ3DkG6Ur2tgb8EKZ5lBDDogzI/lsY3TI1LXOrNbGxO
 Z8pGqgQPAsfyw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8053C1E62F1;
 Fri, 13 Nov 2026 14:29:07 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1ECAE45B0C3;
 Fri, 13 Nov 2026 14:29:07 +0300 (MSK)
Message-ID: <0d92762f-b026-472c-86b6-afb9475bfb37@tls.msk.ru>
Date: Fri, 13 Nov 2026 14:29:06 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/12] hostmem: Support fully shared guest memfd to
 back a VM
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, pankaj.gupta@amd.com,
 xiaoyao.li@intel.com, chao.p.peng@linux.intel.com, david@kernel.org,
 berrange@redhat.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260929235109.1398509-1-michael.roth@amd.com>
 <20260929235109.1398509-11-michael.roth@amd.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260929235109.1398509-11-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/30/26 02:50, Michael Roth wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it fully shared.  If we use guest-memfd, it so far always implies we
> need two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
> 
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, fully shared).
> 
> To use the fully shared guest-memfd, one can add a memfd object with:
> 
>    -object memory-backend-memfd,x-guest-memfd=on,share=on
> 
> Note that share=on is required with fully shared guest_memfd.
> 
> Since guest-memfd is not yet a drop-in replacement for memfd (e.g. lack
> of hugepage support), the option is tagged as experimental for now so
> that it can be made available for early enablement/testing without
> causing any surprises for other users.
> 
> PS: there's a trivial touch-up on fd<0 check, because the stub to create
> guest-memfd may return negative but not -1.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [mdr: add accompanying guest-memfd doc, mark as experimental]
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   backends/hostmem-memfd.c                   | 67 ++++++++++++++++++++--
>   docs/system/confidential-guest-support.rst |  2 +
>   docs/system/guest-memfd.rst                | 60 +++++++++++++++++++
>   docs/system/index.rst                      |  1 +
>   qapi/qom.json                              | 15 ++++-
>   5 files changed, 139 insertions(+), 6 deletions(-)
>   create mode 100644 docs/system/guest-memfd.rst
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 7a7855aaab..666593ff6c 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -18,6 +18,9 @@
>   #include "qapi/error.h"
>   #include "qom/object.h"
>   #include "migration/cpr.h"
> +#include "system/kvm.h"
> +#include <linux/kvm.h>
> +#include "qapi/qapi-visit-common.h"

Starting with this commit, a build of qemu on sparc64 host.  As far as I remember,
linux on sparc64 does not support kvm, so there's no asm/kvm.h which is included
by linux/kvm.h.

Should this include (and subsequent addiions) be #if-guarded by CONFIG_KVM perhaps?
Or maybe this whole file (hostmem-memfd.c) or subsystem (hostmem) should be omitted
if !kvm?

In file included from backends/hostmem-memfd.c:23:
linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
    16 | #include <asm/kvm.h>

Thanks,

/mjt

