Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1237606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8lfQ9dU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR4Em-0001Jx-8B; Wed, 11 Nov 2026 04:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xR4El-0001Jj-6M
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 04:03:23 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xR4Ei-00023a-PS
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 04:03:22 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c445c95d553so398988866b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 01:03:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387798; cv=none;
 d=google.com; s=arc-20260327;
 b=EjZ9yHRUd9wtkQmbyNKQ1Eqidvczlqg8+eXhvDEl5zUHmWLIjGIeTsPUdclTO6VJNT
 BlcbdM1F0nXndnET8BGEE+IE4KJ8vJd9nuAnMkU8NxpX9tHzejpRFknY189JhXx8HTtX
 HSS6txi7yWdLhgwFcTytcZR8m+x0aYEgLF21Qa8t5Jw+JSsctt++7TlhKkDKJZwM5pBR
 onrV0LOW1kqxEvHJdAlH8EOhEmq6EkwLvl6kZ/XCNG2OAZ/kkNa7igTPmv2tv6pUBVtA
 7OXr0/BDICEvFYZkE0IQRVcEsGgaOrNkKDgX6KmuUD4VF/AE6qtiKgDjZg+hL7ndwORB
 y1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+icEnhQkuhFJ3d0ULcf/vQ7wkNAsyszYiNyhHEyGByI=;
 fh=aU1efp1Hqslajef9yw/kvM+9GDKW8LvzbV7DMPwJ+U0=;
 b=if3wmK6i0Ksg5AXof1jnUyTv/H4+L2BmeeI4OFlMrYp9vCIf37oXPUAAGmavlD/8sn
 kSzn+f9Vs/2ZVsuzS8HNrFcOSfhrFvZGX34IY72aTkdKqkxzhyt2i0yVkRGxR0Efiv1f
 cnLwgvSt2LPQQ3S/hStxs7ug7+gcTEC3prd3Ylbf8qqjzDUAtyDgXovjGBXiUR4rNW3o
 kuHBx93Hzhx53MxA8x34tKSkCYTriCZYNPvH2MsbMXkO+bta/tU82OVN6a3QM1RqfJOV
 /d4g536mtSIoVC+8daLdRBfrG3u/BUI1mTdiGpQdulQ8OMBjcEJUdOf7KzFxshjgIJ/X
 1PSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794387798; x=1794992598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+icEnhQkuhFJ3d0ULcf/vQ7wkNAsyszYiNyhHEyGByI=;
 b=Q8lfQ9dUgZxyQsJKukIYbAH/qThv/nekMEOIIuytv53F0vytxbvWLuDMiRIL+xD7ft
 YmSsVxcQHj4CIWKugfcz06o4qijOK4CjmNmE6x/BMJm20NKbrKvBaGk/Nx06QFHi7rX8
 sgoHTXgqo+MwKTGlLNmDWlj4WCFJDmNq7VQY0eENAISXc42+2jO5QYKdb5PbP4+t24Hv
 +se7SsyS6qLraRG99EbfI2SpvSQPaQwkYMuCmFt02308s52W44AtqWH/JaXkaZP7FNTv
 ktwD04fOY0YWudWsLqZEo8pFZsNcEBHA+zdtFSk9o+K+EiEwWEqDUo9jegF0w4E4+ox6
 VPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387798; x=1794992598;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+icEnhQkuhFJ3d0ULcf/vQ7wkNAsyszYiNyhHEyGByI=;
 b=RPUxwx2+0cCJIP/OuCHUuBjGqQp+Dz+rfURIDyLx9ldCtYANBP+2LVQl7QaedYuKgG
 ZnfQWHUXwvaG6snB0Xnm0AwEBOcJMwEH9nDcLcmT+qRrjfmv2lYSacWRZ64tlJ9+nDkg
 B9elVimKF01YGRA8ajxKjx2JEFDdfBZnx3GUoxy8D7SEsA1p+PPBEAzgkeVDSn0orS8B
 8fzwfuhFtcVwc8Nkp6yCFcEyMQ8sYA7ojO8IVrSIy5pGGY7298qjL0HepMUYQbMMJfNs
 kQmdY84Rn9GXgbz0ZWHxSn2eL9WS38iM++KAnuN9kwbGbfnyG2husQe8ZLcDisltkgdW
 /fxQ==
X-Gm-Message-State: APuU4Z+vtJmOJqdLOp2RpwEXJKr3/2NN+kwwIbGsGcQvTdKgBSYMjO2G
 QG8tC45Tqsw7A9SofFVpF+Y6YzNyLmBFDIGhgUtaEcmPxeW9O8zB7L5rDyJeU43Pq7RI30KHjuD
 OxC2iv88yIcyat15e1VLmM+RjXOASqneweG8x
X-Gm-Gg: AYBFou1hlJzBP+FQsSyKX8c6IokZs2evpWLNFgeJvIAvFjIJ+e777juPof1SkxVvKH+
 s3nmavSn+NYOB60X7CVVDlPz9RZN84loXEhr31JSVRg6yMr85j7zGhuMhh/c5mYIFMTWXrN0/sp
 ofEw3wBgqWDQuX9QMweCpUzISy00xjSZiXqZss6ojBy7TTgakPiQivs2fvBlV3FDd1AyK4vvUvX
 6zHwYDCTGqjzC66rs8mttzmpH2X9nNZK08FiQm8Up+UPaIzCnaNEpSkOHPL3x/fKHhGyykiLXyf
 E6ovVTemvKLbftCsJOprlQDc2z8i5h0Nv5+BdVES8fDUKradpagu9jffd2crnFJtVh8+5YFK2cP
 kSL8U9s2Ra7RMFXDw2TxIwl2Ziz9fBxyB/+mFX1IFwaDS3X9kpleVM8F1qg==
X-Received: by 2002:a17:907:da4:b0:c2e:40a0:7978 with SMTP id
 a640c23a62f3a-c5066a898bdmr133420366b.9.1794387797779; Wed, 11 Nov 2026
 01:03:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028092619.1654474-1-zhangckid@gmail.com>
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 11 Nov 2026 17:02:39 +0800
X-Gm-Features: AclHuK8WHVAVZCEZM3aV_G8bmoHW9GH7KXV438kG3XsQWmA5klWCbws_Y3aHB3E
Message-ID: <CAK3tnvLakd03hvsX_PsNwMCU0hTXSUxGYj+8+yd7E+D6tVVCXQ@mail.gmail.com>
Subject: Re: [PATCH V19 00/14] iothread: Support tracking and querying
 IOThread holder
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Stefan, all,

A gentle ping on v19. Patches 1=E2=80=9313 already have Reviewed-by tags.

Hi Stefan, thanks for reviewing the documentation update in our previous
email discussion. Based on your positive feedback, I'll add your
Reviewed-by to patch 14 in the next revision. Please let me know if
you would prefer otherwise.
https://www.mail-archive.com/qemu-devel@nongnu.org/msg1239091.html

The series now needs a rebase onto current master, which I'll include
in the next revision. Are there any other outstanding concerns before
the series can be queued?

Thanks,
Chen




On Wed, Oct 28, 2026 at 5:26=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> ### Motivation
> Currently, the relationship between IOThreads and the resources using the=
m is
> opaque. From a management perspective, it is difficult to determine which
> devices or block exports are currently associated with a specific IOThrea=
d
> via QMP or HMP.
>
> This series introduces a "holder" tracking mechanism based on QOM paths o=
r
> block exports to significantly improve IOThread observability.
> In high-performance virtualization environments, users often pre-allocate
> a set of IOThreads to serve as a persistent thread pool. During device
> hotplug/unplug cycles, while IOThread objects remain persistent,
> their attachment state changes dynamically.
>
> By tracking these "holders," administrators can use `query-iothreads` to
> monitor the real-time load distribution of the thread pool and identify w=
hich
> specific devices (e.g., virtio-blk, BlockExport) are attached to which th=
read.
>
> ### Technical Overview
> * Holder tracking
>
>   Add a QAPI holder list to each IOThread.  A holder identifies either
>   a QOM object by its canonical path or a block export by its unique
>   BlockExportOptions ID.
>
> * Explicit reference lifecycle
>
>   Add iothread_ref_and_get_aio_context() and the matching
>   iothread_unref_and_put_aio_context().  Acquiring an AioContext register=
s a
>   holder and keeps the IOThread alive until the matching put.
>
>   Legacy callers without a matching lifecycle use the explicitly named
>   iothread_unsafe_get_aio_context().  The ambiguous legacy
>   iothread_get_aio_context() is removed after all production callers
>   are migrated.
>
> * Subsystem integration
>
>   Track holders for block exports, monitors, virtio-blk, virtio-scsi,
>   virtio queue mappings, virtio balloon thread pinning, COLO compare,
>   vfio-user proxy, and xen-block.
>
> * Introspection
>
>   Extend IOThreadInfo with a holders array returned by
>   query-iothreads.  Display the same information with info iothreads.
>
>
> ### V19 -> V18 Changelog
>   - Added new patch in the last:
>     docs/devel: document holder-aware IOThread AioContext APIs
>   - Rebased on upstream code.
>   - Added IOThread prepare_delete() to reject deletion while holders
>     remain, preventing NULL IOThread lookups during virtqueue mapping
>     cleanup.
>
> ### V18 -> V17 Changelog
>   - Saved the COLO object's QOM path for finalization and guarded
>     holder cleanup against incomplete initialization.
>   - Used the owning PCI device's QOM path for vfio-user holders
>     and saved it for disconnect().
>   - Simplified the monitor QOM path field name and clarified
>     PATCH 12's commit message.
>   - Rebased on upstream and collected Reviewed-by tags.
>
> ### V17 -> V16 Changelog
>   - Rebase code to resolve code conflicts for patch 8:
>     "virtio-balloon: Update tracking iothread users with holder".
>     This issue caused by latest merged patch "fdc3f9a83d".
>
> ### V16 -> V15 Changelog
>   - Unified per-monitor IOThread checks and accesses through
>     mon->iothread after initialization.
>   - Simplified PATCH 13's commit message and clarified why blockdev
>     cannot use the holder-aware get/put APIs.
>   - Dropped the v15 Patch 1 in this series, It will be taken away
>     independently by trivial-patches tree.
>
> ### V15 -> V14 Changelog
>   - Moved monitor IOThread cleanup from unparent() to monitor_finalize(),
>     pairing complete() with instance finalization.
>   - Squashed V14 PATCH 04 and PATCH 14 into PATCH 13 and clarified the
>     blockdev lifetime assumption. Since the additional changes are minima=
l,
>     PATCH 13 retains Stefan's Reviewed-by from V14 PATCH 04.
>   - Rebased and adapted info iothreads to the MonitorHMP interface.
>
> ### V14 -> V13 Changelog
>   - Renamed patch 3 and clarified that it introduces holder-tracking
>     infrastructure, with users converted in subsequent patches.
>   - Documented that monitor holders are not visible to management
>     applications, while retaining the tracking for a consistent holder
>     and IOThread reference lifecycle.
>   - Rebased on the latest upstream.
>
>
> Zhang Chen (14):
>   iothread: introduce holder tracking
>   iothread: add holder-aware AioContext accessors
>   block/export: track IOThread references
>   monitor: track IOThread users with QOM paths
>   virtio-vq-mapping: track iothread-vq-mapping references using device
>     path
>   virtio: track IOThread references for thread pinning
>   net/colo: track IOThread references using path-based holder
>   virtio-balloon: Update tracking iothread users with holder
>   vfio-user/proxy: Update tracking iothread users with device QOM paths
>   xen-block: Update tracking iothread users with holder name
>   monitor/hmp: display IOThread holders
>   iothread: make legacy AioContext getter explicitly unsafe
>   tests/unit/iothread: update AioContext ref/put helpers
>   docs/devel: document holder-aware IOThread AioContext APIs
>
>  block/export/export.c                   |  62 +++++++++++---
>  blockdev.c                              |   9 ++-
>  docs/devel/multiple-iothreads.rst       |  19 +++--
>  hw/block/dataplane/xen-block.c          |  19 ++++-
>  hw/block/virtio-blk.c                   |  21 +++--
>  hw/scsi/virtio-scsi-dataplane.c         |  22 +++--
>  hw/vfio-user/pci.c                      |   2 +-
>  hw/vfio-user/proxy.c                    |  20 ++++-
>  hw/vfio-user/proxy.h                    |   4 +-
>  hw/virtio/iothread-vq-mapping.c         |  20 +++--
>  hw/virtio/virtio-balloon.c              |  21 +++--
>  include/block/export.h                  |   5 ++
>  include/hw/virtio/iothread-vq-mapping.h |   6 +-
>  include/hw/virtio/virtio-balloon.h      |   1 +
>  include/system/iothread.h               |  38 ++++++++-
>  iothread.c                              | 102 +++++++++++++++++++++++-
>  monitor/hmp-cmds.c                      |  20 +++++
>  monitor/monitor-internal.h              |   7 +-
>  monitor/monitor.c                       |  36 ++++++---
>  monitor/qmp.c                           |  14 ++--
>  net/colo-compare.c                      |  36 ++++++---
>  qapi/misc.json                          |  94 +++++++++++++++++++---
>  tests/unit/iothread.c                   |  18 +++--
>  tests/unit/iothread.h                   |   7 +-
>  tests/unit/test-aio-multithread.c       |   5 +-
>  tests/unit/test-bdrv-drain.c            |  18 +++--
>  tests/unit/test-block-iothread.c        |  21 +++--
>  27 files changed, 535 insertions(+), 112 deletions(-)
>
> --
> 2.53.0
>

