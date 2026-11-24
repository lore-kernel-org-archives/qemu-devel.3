Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A387606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 06:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HCKxjQl4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjjS-0003qB-8U; Tue, 24 Nov 2026 01:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xVjjQ-0003pu-Gc
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:10:20 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xVjjO-00083T-D9
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 01:10:20 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6ba1e22ff4dso4723699a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:10:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795500616; cv=none;
 d=google.com; s=arc-20260327;
 b=dxeByXjilqZgRlC1GFOZUEtHnqRHctpqJzt2Xo2XklfgliziCVS9o1yvXeYeyCp/Wv
 Yd/QFNVbPkRyPUHVxVeGu6llW5OcC7Un2ft8/Na/8eZiJ1kXj6LOtE34NpzYoxwqA7vN
 wbPKFdxoCLd1KxVrIW5pTQdrUyhBQX9WJOWEmjdvxw23xLr56JLvTNyiuMOgpXOZerts
 499MVl37dWKl2gcMHqrnwmJr7VavPJNjJwQgtr1LWIvx89/AcNelRa48cAwpXQQfxSlx
 EeaLr6vjlSK92Xpsz1bHtNzQayifIwR2vj4Fe0zoHaV/PIXOhXv1qNqOBXCRhYUKfUlx
 4yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kPXm0RgO/d3vLtZSDrKvQTAGdfZ5Y9SR93W6Tsz9glg=;
 fh=aU1efp1Hqslajef9yw/kvM+9GDKW8LvzbV7DMPwJ+U0=;
 b=LibJhobxkRx/jwOI/k7ooYtf1cV/KltVN5Otk9WnVPgiAe1P2v9NAVGioqBsP0vVgy
 NDr7jMa0QhtgHymyr1BdSSMnmcETNsubFr4xmZgMAfqoofyF9MnCGMSUDaTWxSPAf/jh
 EVBIhKgHpIQu35LOCXG3iqzeNsW25TFB3RZgIgjsflVVarutS18TA1aCrQOOLTwhnAGE
 vQIMTxL3+cxKew1lDlcZavHeylLmHaqj9Qvb6wqpqLxkSzujIOdXte1K3BVw9iTFInnJ
 QNK7D/4aL0O414aFYvWdG115+7tJ1aBt3S9RKkiJdZRb6nTsXRu7h0hFLDcHjO1+q3xo
 wz8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795500616; x=1796105416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPXm0RgO/d3vLtZSDrKvQTAGdfZ5Y9SR93W6Tsz9glg=;
 b=HCKxjQl49yBV3jRtXuCSDJtFFd5yQRz3R25PxN6QgFLZZplvdQkj43vqp0LqeWJA1/
 uTjE3XaciGjAniDKHYSUkOqs47dS55iy+QcTJN/aeHSJMaGxzYQo7yal6xJ/RDrO4MIt
 W+Ri+L7yT/zr38dkWniFDESmpPZKnCN6BlUF5OH1nZ8NlUdbI7oyRHHWs7lyOSCiKo66
 J6si5JtCs5Hcxl4nUy2W30IPfPU04yh22u/OJp7bamx7b7uWbLCx2ZciSHp0PqFtWLmp
 C3mvIcCR1pVGU2b+rr1K36kWscngieGM7jnvL6nb2cCnJO1SPixANTY+xBBH4OgguENv
 C7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795500616; x=1796105416;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPXm0RgO/d3vLtZSDrKvQTAGdfZ5Y9SR93W6Tsz9glg=;
 b=n2LIFlFRcHEuwW7n+j/NsJjngHVG7xzLCOq/M/YuS2XrVj8VqxS8Yh7gToaaSybeVK
 KEOQwHDZ5RsgQsCc3Myk4BKGu5MDRAFvYbUwlVQW+2hxxEknq78JagMUTSzL5GFSx+aa
 jFyJPaZ9wnhocxh5gJ//j4MotTCxhKP5p9gURHjK+VuRn27IuASRm2WBA2Tag9ZUVNN3
 VxJSG1JeNyWfqtDfbVVWYkF69Eb8oHHOjvQa7zNEut3wEJ5v5gnatihR0O+7QKz2w5Lu
 rrfJ5bSIuWR7MnwkEWZLtLne54qWYhnwpSZWp70FQo6DxSYuvaReA9Jxut327tIAxesS
 oLsw==
X-Gm-Message-State: APuU4Z9NHG3dbgrp0aAeG3We4xhwVnAPrCFVGiiF4tr8UvQHWxGmcJl+
 RXkupOrSpVSF5QrVru4ivigvnF21LL3+QKagoOfJWljclnAJNemIJznH+uZPPPa2aHtHpDCLS2j
 pG7HincvUOOxp8IIqgri9O++mkxWvJoxnMH9Q978=
X-Gm-Gg: AZFdTZcBdLJoVuT7gQ97M+II05KB24jNiryj5LZoo5fmIWUkyH6eSpTHYyel7fmfKSI
 aUT4DsP4S+9auD7G1L6TxE+iBGCirIDJANR+k/8QPEEBV0h4D/iqeIKVbpl1uB9srAhY2ZSJ48P
 8yy2+9eW/B6geamqZBPQmYkh7M0z9iDpKhBA7xpXubBG/l4o3moXd3cOUNe/BL44TQ6zKIRSJWj
 bwXjbu3XaWFQXOV+/tcDq6QFbcXipMBfH17/Hm1amGgxnIZY/EmytCpj7VCVHRB7GYfbL8DQiGP
 kaScPpJQQDYFUgYPqnMoB0m13ug0d5QK9BlvL3LsMNGZAv1pwi25dfq+PtUBcfG/gfIPiHBTLlY
 jmk1NOq6AL4X+/JeL8wPplTlnEca0uzF3BQxfng==
X-Received: by 2002:a05:6402:51d2:b0:6ba:4a8b:96ca with SMTP id
 4fb4d7f45d1cf-6ba4a8b9b95mr7600498a12.8.1795500615863; Mon, 23 Nov 2026
 22:10:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113092605.942292-1-zhangckid@gmail.com>
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 24 Nov 2026 14:09:37 +0800
X-Gm-Features: Aa3M54qXzldpWwa_SaY7e73KeGTzMpkrb-gDgFRvOyfvFX2QK4iFJwEj6JOSWL8
Message-ID: <CAK3tnv+rQ+fKF1UPGj7+RLt81PyULojVT6TG3pjbma3Fffr1dw@mail.gmail.com>
Subject: Re: [PATCH V20 00/14] iothread: Support tracking and querying
 IOThread holder
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52e.google.com
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

Hi Stefan and Markus,

A gentle ping on v20. All 14 patches have Reviewed-by tags, and I
checked that the series still applies cleanly to master (2bfbe39d0f).

Thanks
Chen


On Fri, Nov 13, 2026 at 5:26=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wr=
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ### V20 -> V19 Changelog
>   - Rebased onto upstream v11.2.0-rc0 (29760efaf96b).
>   - Add the RB in the patch 14/14.
>   - Adapted patches 1 and 5 to the updated QOM property registration
>     context, and resolved patch 9's conflicts with vfio-user region
>     FD cleanup. No functional changes to the series.
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

