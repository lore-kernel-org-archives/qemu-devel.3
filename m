Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B45CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEn5-0000V6-Mh; Fri, 09 Oct 2026 13:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LCrJagsKCgMqdpdqjxodwljrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--namangulati.bounces.google.com>)
 id 1xFEn2-0000UH-6j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:53 -0400
Received: from mail-qv1-xf48.google.com ([2607:f8b0:4864:20::f48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LCrJagsKCgMqdpdqjxodwljrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--namangulati.bounces.google.com>)
 id 1xFEn0-0006F5-CG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:51 -0400
Received: by mail-qv1-xf48.google.com with SMTP id
 6a1803df08f44-919879b09b7so2075826d6.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791568429; x=1792173229; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=awmqhE6ssk9Lk7Tf7KVONrpGfiblTmIXxTCh/rWeUuo=;
 b=jwHG8rOIUjv33mSxReLivQI4VjxcrXGwld62slqPNNZj7r4WkG1qEk76GKDkTF+231
 ldlLzsKwzf2Hlq46PLCJrKJOTHUWiQK9TPzg3hq5UnD4MUzor9Jf/+2lmF7115esEa2M
 5Os2IgqwruwDI1Yk0wpD/QK/dGvPhjDb8leEVM2PQ9WNsNYokfbif33t0Sq3f6qwpXmw
 9lmhWOQvzjrOXK/+IvqdZ4ViOIMFfvadPJTGC/RsQD9jUXgW0AzPcXJvcb3aQVS5ZIfk
 aNa22WMrDalv6Mw9UxF02qOLXA8nmq+B39ZE1sZYFEdJSrGUuguhnZMdufU62ByPHl2R
 vs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791568429; x=1792173229;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=awmqhE6ssk9Lk7Tf7KVONrpGfiblTmIXxTCh/rWeUuo=;
 b=vujboeA33v8Sjb9bSIWSGftfJB67LTILDDPZg4QrUw5yCqGfTdbxXlj7IOEi7nIWOR
 9p1GLpUQwX8Y3RMukGApQV5uBW+4dMA+/osrdIt8LdU9XeEmJtiX448V6Ma7hX0dgFnz
 swRyGiWEg2EWkBddzn2EHduDnI+jMnY5hBgnrTxrcLAykVeQPG8Mut/AtIfBfkMhmDix
 /LIc+wtsO+eZajkAk76aG+EZeCl+s96WXTgO8LokNukVaydTK/oeogy8VUmIA6bgELpi
 F8hkXFTW0AKENm+0OzCu4P5mPRhFNYSKtSVjZDaB6IOuF9i6b+IrFku+WuvEVpcfkxtU
 m24A==
X-Gm-Message-State: AFq9FYI1FHkWckSj6mMAsRfOdJXMbwYhZoJLVpeaOtPT2yUAgwqbsjv3
 ozknFja+JiFNQAu01+8sUiza/DdxWvAcR9SLrOdVRIdiax3swm4eXVedVJCc/CWFqZSc0Iauirh
 ASTlxq5k7TDyJuelxe4N98jdFv/a5qAfGfsuRkpLHArcHhDiE6we/xzKg8/hdOenenZov77o4ar
 J7LA3j1Ve6p4OGuLW/CPzzBXG6+OSJ9c2ho+qzZ1KN1H8P7uebDodwVILRFg/jpQ==
X-Received: from qvc20.prod.google.com ([2002:a05:6214:8114:b0:919:96a4:7b33])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:cc2:b0:913:efc3:6ffc with SMTP id
 6a1803df08f44-91b557c5f4cmr43714656d6.22.1791568428114; 
 Fri, 09 Oct 2026 10:53:48 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:53:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009175314.1823347-1-namangulati@google.com>
Subject: [PATCH v4 0/4] vfio-user: support multiple FDs backing region mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f48;
 envelope-from=3LCrJagsKCgMqdpdqjxodwljrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf48.google.com
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

 docs/interop/vfio-user.rst    |  86 +++++++++++++++++++++++++++++++++--
 hw/vfio-user/protocol.h       |  35 ++++++++++++---
 hw/vfio-user/proxy.h          |   2 +
 hw/vfio/vfio-region.h         |   9 +++-
 include/hw/vfio/vfio-device.h |  16 +++++++
 hw/vfio-user/device.c         | 102 +++++++++++++++++++++++++++++++++++++++---
 hw/vfio-user/proxy.c          |  46 +++++++++++++++++--
 hw/vfio/pci.c                 |   2 +
 hw/vfio/region.c              |  51 ++++++++++++++++-----
 9 files changed, 317 insertions(+), 32 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog


