Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098B606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rE1ozvE3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKNur-0006ee-RP; Fri, 23 Oct 2026 18:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CuLbagsKCpsI5H5IBPG5ODBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--namangulati.bounces.google.com>)
 id 1xKNup-0006du-Ih
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:11 -0400
Received: from mail-qv1-xf45.google.com ([2607:f8b0:4864:20::f45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CuLbagsKCpsI5H5IBPG5ODBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--namangulati.bounces.google.com>)
 id 1xKNun-0002la-G0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:11 -0400
Received: by mail-qv1-xf45.google.com with SMTP id
 6a1803df08f44-91bb074ed1aso8705386d6.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792795147; x=1793399947; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aPbJIiyQ8iYJSdlb5aw/R5QyKL06b9uWeLnS5uo9zqE=;
 b=rE1ozvE3/5bBzgR7xrJep4zN25wEdsw3S0/0qFvFr9yVgk/DfCwd+qSXoLCc7y4w0S
 kXm11DBr0C29DH91mg723vpGrds5zf6saq6ZhXF1XVT9aPquHInc6rA+FZ0NP/JauOQK
 EJnRSBP7z3W0xA3dXIHfDLePNA3zmquZ5MwSEga5lJLNW8NOoTILzGB8yZ+bY4HobAKY
 VGwWxelH7zSXOaw1/lYtwsEkYY14zVzFFSJI4Po0jWw4qhKK0+Km12kR8cMwPKT5BBes
 ox/4lR3LAWUFz/u45nL1Z1+u8R+6cMvGX1JUAeLYMqm7T7PaHHZunMIF0sV5zTTz+vRW
 k0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792795147; x=1793399947;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aPbJIiyQ8iYJSdlb5aw/R5QyKL06b9uWeLnS5uo9zqE=;
 b=EE/wlALhMO9k/wKFvE5Tas0s+4dDAwgfpz8pLR1m2ByF6QdX5YUoP9RNPeJVOwXRei
 M81jUDxBOh0G7wtfaJLEV6XooQ62LGi5PFm2SbdQshq3Uq1OgjlqJMay5v6AjG247XQa
 MJasy3wztZhc6KgbT+QnVVRjsVQ2EILQtdV4AAasS1WZu+mcl6cqZlHUrG9sjzU2IgDm
 NE8srfM0lhhPVIPwQsRsZiYL74Pn8w9sdy110iGqn2hpPQPYMMpbsegeEY+j3S9AlU1H
 VXUzrziRYZeiH4DGiZOqFg/HgZAHosvyxeabHsVRVIK9yDcOvGVcPObZUNQs/UbLzm49
 S9wA==
X-Gm-Message-State: AFq9FYJd1vzvGib7DCj2eL0tklGONMnXPuUWlc60A+E2jdeaMnrQFwPZ
 iKxf4tnVC1uZc7KyJN1kMogv7u52+0Zb/MdpWLF7zBB2Ikd9l/s2Lh5/FwKPjFbUKekG7N8iL1f
 rQ/vtrKKgcUHKXFvHvVblwPLZbLSFZf++23Qlcnc9b0+SII14Nat38Iyu93q5pWu46pTbedYgNt
 euumeDn1ItBqPdOzxuK3FBVBMtr+SiE9Rt97E+lc548+mBCJKs5V6JomExnJknnA==
X-Received: from qvrw10.prod.google.com ([2002:a0c:ef8a:0:b0:91c:13ab:f39d])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4119:b0:917:aad8:7e56 with SMTP id
 6a1803df08f44-91c48e536c0mr7980656d6.35.1792795146537; 
 Fri, 23 Oct 2026 15:39:06 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:38:58 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023223902.1275539-1-namangulati@google.com>
Subject: [PATCH v6 0/4] vfio-user: support multiple FDs backing region mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f45;
 envelope-from=3CuLbagsKCpsI5H5IBPG5ODBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf45.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series extends the vfio-user protocol specification to allow
servers to pass multiple file descriptors for different sparse memory
areas to be mmap'ed within a single device region.

This extension is intended for exposing paravirtualized PCI devices via
a vfio-user server that may have multiple unique sub-regions in a BAR
backed by some mmap'able buffers sourced from distinct file descriptors.

This change introduces a new capability:
  VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS

Unlike VFIO_REGION_INFO_CAP_SPARSE_MMAP (which maps all sparse areas
from a single open file descriptor), this new capability defines an
array of sparse mmap areas where each area contains an index into the
array of file descriptors.

When all sparse areas share a single file descriptor, servers may
continue to emit VFIO_REGION_INFO_CAP_SPARSE_MMAP and send exactly one
file descriptor in SCM_RIGHTS for backwards compatibility with older
clients.

The extensions in this series also lays the groundwork to make use of
the in-development series [1] extending vfio-pci to return distinct
dmabuf FDs for discrete regions of a device's BAR. A vfio-user server
may choose to return dmabuf FDs for various regions of a device's BAR to
map a vfio passthrough device into the guest, in order to retain control
of the device and be able to revoke mappings passed to the VM.

libvfio-user server side changes WIP on github [2].


[1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org
[2] https://github.com/NamanGulati/libvfio-user/tree/multi-region-fd

---
Changes from v5:
  - Renamed vfio_default_setup_sparse_mmaps() to
    vfio_region_setup_sparse_mmaps(). (Cedric)
  - Verified msgp->index == info->index in vfio_user_get_region_info()
    before copying the reply into info. (Cedric)
  - Documented the 0x8000 capability ID namespace in relation to kernel
    VFIO in hw/vfio-user/protocol.h. (John)
  - Link to v5: https://lore.kernel.org/qemu-devel/20261014211041.1087331-1-namangulati@google.com

Changes from v4:
  - Set .setup_sparse_mmaps = vfio_default_setup_sparse_mmaps in
    vfio_device_io_ops_ioctl. (Cedric)
  - Return -EINVAL in vfio_user_device_io_get_region_info() when
    VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS is present without received
    FDs. (Cedric)
  - Dropped redundant VFIO_USER_MAX_REGIONS bounds checks in
    vfio_user_device_io_get_region_info() and
    vfio_user_device_io_setup_sparse_mmaps(). (Thanos)
  - Validated sparse_fds->nr_areas against info->argsz and switched to
    g_try_new0() for region->mmaps. (Thanos)
  - Included area info in invalid area error message and added comments
    for recv_fds resets in hw/vfio-user/proxy.c. (Thanos)
  - Link to v4: https://lore.kernel.org/qemu-devel/20261009175314.1823347-1-namangulati@google.com

Changes from v3:
  - Added "sparse_mmap_fds" capability to VFIO_USER_VERSION so servers
    know whether the client supports
    VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS. (Thanos)
  - Changed VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS capability ID to 0x8001. (Thanos)
  - Clarified and enforced that VFIO_REGION_INFO_CAP_SPARSE_MMAP and
    VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS are mutually exclusive per region,
    number of FDs in SCM_RIGHTS must not exceed nr_areas, zero-sized areas
    are not permitted, offset + size must not exceed the region size, and
    areas must not overlap. (Thanos)
  - Link to v3: https://lore.kernel.org/qemu-devel/20261007000833.2445641-1-namangulati@google.com

Changes from v2:
  - As suggested by Cedric: kept core VFIO changes minimal by only
    extending VFIOMMmap to hold each mmap subregion's fd & fd_offset.
  - Moved multi-FD management and capability parsing into hw/vfio-user,
    and using VFIOUserProxy to hold region multi-fds.
  - Resend: rebased to head.
  - Link to v2: https://lore.kernel.org/qemu-devel/20260826050039.2068138-1-namangulati@google.com

Changes from RFC:
  - Refactored the get_region_info callback to keep vbasedev constant
    and take in a VFIORegionFDs* out parameter to store the received fds.
  - Link to RFC: https://lore.kernel.org/qemu-devel/20260811233930.401797-1-namangulati@google.com
---

Naman Gulati (4):
  vfio-user: add multi-fd region mmap capability
  vfio: add 'fd' and 'fd_offset' to VFIOMmap
  vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
  vfio-user: support multiple FDs for sparse mmap regions

 docs/interop/vfio-user.rst    |  86 +++++++++++++++++++++--
 hw/vfio-user/protocol.h       |  39 +++++++++--
 hw/vfio-user/proxy.h          |   2 +
 hw/vfio/vfio-region.h         |   9 ++-
 include/hw/vfio/vfio-device.h |  16 +++++
 hw/vfio-user/device.c         | 126 ++++++++++++++++++++++++++++++++--
 hw/vfio-user/proxy.c          |  52 ++++++++++++--
 hw/vfio/device.c              |   1 +
 hw/vfio/pci.c                 |   2 +
 hw/vfio/region.c              |  45 +++++++++---
 10 files changed, 346 insertions(+), 32 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog


