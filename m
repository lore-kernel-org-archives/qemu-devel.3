Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F874CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6FT-0007Cx-5R; Wed, 14 Oct 2026 17:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <30-_PagsKClA5s4s5yC3sB0y66y3w.u648w4C-vwDw3565y5C.69y@flex--namangulati.bounces.google.com>)
 id 1xH6FR-00077W-3j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:10:53 -0400
Received: from mail-yw1-x1145.google.com ([2607:f8b0:4864:20::1145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <30-_PagsKClA5s4s5yC3sB0y66y3w.u648w4C-vwDw3565y5C.69y@flex--namangulati.bounces.google.com>)
 id 1xH6FP-0001Da-4l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:10:52 -0400
Received: by mail-yw1-x1145.google.com with SMTP id
 00721157ae682-8b0cd41e7aaso9748817b3.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792012244; x=1792617044; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pWWpz+aRzv/pobj9rfyOULHv/yWqVmaAAIWGjnE9xHo=;
 b=livF3KLEflIHSpBLxM3KxPmMYREhoEM76eG0WOrhnQzhGVVndBhhmXfLHopzYjlY3j
 BwRW8IEMqBHstnaj55mdnpyP5Xa+8SJNXU9wsIre33xFJ/qbeM3wXOYqvswZHcoJmZwF
 Eq2wbUzWZGBfLmg9IqX76T2hMXvQgDC1VieLaw/0H/QC7KF2Kqv7tDDlRLv9njtuDvAD
 ZGpYFGKi24u3nvOyglMyQUY3nrniRlAoLDj+qaxO/rWlC3/hcS0DTjA/vpoEOqYMOwof
 dv/ry5O4nQisai56tpxQ8PA6mBJkQ8i4bUKLUMxFq9snkoO5qFA1oJSWivGvwQ35ey3l
 9hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792012244; x=1792617044;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pWWpz+aRzv/pobj9rfyOULHv/yWqVmaAAIWGjnE9xHo=;
 b=G5tJwU88LWlFGLbSdBBbFlE9/GCe16IqnTBV1C8leU6artX5WYly08RsGDzR3nZi0A
 TZsIeV6cLKwhhx28qOGuI6C4s5xlKOjKaN1dTKi1+9ckHOav2gJjwl41MnRfF+s5jZcq
 mPQlJ/pw5LtIGInRrBEJZUeSmeLuyiDEzm8TqAQthqudMGm2YyGMOlQnWcMSUKpDCGa2
 0WtPOsxbsIISzI1Sp4QVkl3Mi1V0zyqXMZ3g0Z/kdsD6LokHyYPnWAFUNCDwufVB3XBP
 5r3czt44kR1vsrLQg2x7CkyM8MRdy/gcfQyfMXH7Azf49+H0j9Ku6gRsehOAqO8YupHs
 pJjg==
X-Gm-Message-State: AFq9FYI6jgRFyMS9vTGGoRRk9mSERnaChHjElrDH2WusucZwfqONhfuX
 or4yI296XMKlJJdewm+iEyEKotDB4Xou3FrIwBMvkznCuG2eN/ej7z9iFB13XzUit49uSU84C1w
 tf4XiLtmL4bf7+tiKQVUZYLUgSHtyJPtKqQ5BsNezOVyE5pMFxWt0oYXlKFAIrkXGHhnI0lC7QL
 Kmc1SDehJz6K0OO9fYFOXqF/JA8/IK6zFRtwyIa0HAl6nkAtG9HgvCkHYrNYE/Sw==
X-Received: from ywbcn24.prod.google.com ([2002:a05:690c:d18:b0:8ac:3797:b81d])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:a4c5:b0:8b0:d42c:5500 with SMTP id
 00721157ae682-8b0d42c7690mr1779827b3.0.1792012243704; 
 Wed, 14 Oct 2026 14:10:43 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:10:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014211041.1087331-1-namangulati@google.com>
Subject: [PATCH v5 0/4] vfio-user: support multiple FDs backing region mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1145;
 envelope-from=30-_PagsKClA5s4s5yC3sB0y66y3w.u648w4C-vwDw3565y5C.69y@flex--namangulati.bounces.google.com;
 helo=mail-yw1-x1145.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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

 docs/interop/vfio-user.rst    |  86 ++++++++++++++++++++++--
 hw/vfio-user/protocol.h       |  35 ++++++++--
 hw/vfio-user/proxy.h          |   2 +
 hw/vfio/vfio-region.h         |   9 ++-
 include/hw/vfio/vfio-device.h |  16 +++++
 hw/vfio-user/device.c         | 121 ++++++++++++++++++++++++++++++++--
 hw/vfio-user/proxy.c          |  52 +++++++++++++--
 hw/vfio/device.c              |   1 +
 hw/vfio/pci.c                 |   2 +
 hw/vfio/region.c              |  45 ++++++++++---
 10 files changed, 337 insertions(+), 32 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

