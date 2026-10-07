Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E4CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMH2-0004Zq-Ae; Wed, 07 Oct 2026 03:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3g43FagsKChI5s4s5yC3sB0y66y3w.u648w4C-vwDw3565y5C.69y@flex--namangulati.bounces.google.com>)
 id 1xEGHw-0002Cm-Rs
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:18:07 -0400
Received: from mail-qk1-x748.google.com ([2607:f8b0:4864:20::748])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3g43FagsKChI5s4s5yC3sB0y66y3w.u648w4C-vwDw3565y5C.69y@flex--namangulati.bounces.google.com>)
 id 1xEGHp-0004zn-2b
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:17:39 -0400
Received: by mail-qk1-x748.google.com with SMTP id
 af79cd13be357-934956beec8so749581885a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791335716; x=1791940516; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e31mEJk7wVkRVPRqxeQrOAFPrcSiTyv/soKsmAttA6o=;
 b=mFeVLgfiEEBl5cJSdkPIx6bMR99ctjihuWE0jjMLUxEm5jr7N1yN6owq5goQ+LsUyS
 m6VJ9+KhLuBoOHBcEXZy2+THnPpzZidWlT4cUs+ttaeGU0QNNlU54AzD2Hkoc0MjQvXq
 dtIU/AYTXxGG6m1g5Pyvwc5LnR9tH7hx1vpSVHCtEBf36X4FlqcPpsV5Vb36/HRlOqoe
 t5P9FakXFYVnB+9U7K0tbOqKO2OosGIhi3ZWkeM1WWr89+x3axo5gwOrlLBXpAy3gRox
 T04/gRTZq5+SezMtK1zZq8udXUUSGHyfCRRBuv54Suwh8qS+xK/DFHpLsfxF1m8GLfiq
 HQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791335716; x=1791940516;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e31mEJk7wVkRVPRqxeQrOAFPrcSiTyv/soKsmAttA6o=;
 b=JdzH1+GbaC/rDvUI1eujcmlUCSInQ/dzawkJXig2wAAtJN8UVO2ZkELvVkmejYKLE2
 /1OIVIDuzLhmhd8avAKJfBOLBilCeFmoRSX9eSLaNI+Ljzodl00LPuCcvYdzEkuxdvzJ
 6thHRnTJMXXzaDyz1ZbKUpRV5aTEP34F9uSLGjOaShmG9/SyqwfQUefQlBsEf43bnqNb
 akYbirZdD36SNyY3AM+qLn33k9wngryPWYGDRdgQWKTB4P63p/Ub581SHbMuhLizoRz/
 mHGOmcZ01UnmYGJWep2c+gViJ5F4bvHUhMZJ1XI75uM090lFEoYiuURCP8exSM3up2Q4
 uoqw==
X-Gm-Message-State: AFuF++lnrEFMvbMQuBUw6ASngip0r+JkC7V344yGHfACgPC3LIriQ/1B
 gWiyhv1fVlMLIw4E+C7hrHGDL8JyBssPGcEbCuunZ9wD3YiD5knHHi6MPLoB6pQ12AMIyqEHqtV
 fa8lR274Il2ldGq/ISPx6Rd9ZrkoqnjG/5E3/F3Q08JUqNGZ37AztMRl1nfMomexYc0ce+OCPbK
 llglA+/CmnnMChb3AVOZdbhNeBV6BSu8FyEzNfPR4NisHh12uOU3/43Dk0L+aUIg==
X-Received: from qtjc4.prod.google.com ([2002:ac8:1104:0:b0:533:86e9:44e4])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f44:0:b0:535:70b5:812 with SMTP id
 d75a77b69052e-535755da404mr9097651cf.74.1791331715062; 
 Tue, 06 Oct 2026 17:08:35 -0700 (PDT)
Date: Wed,  7 Oct 2026 00:08:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261007000833.2445641-1-namangulati@google.com>
Subject: [PATCH v3 RESEND 0/4] vfio-user: support multiple FDs backing region
 mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::748;
 envelope-from=3g43FagsKChI5s4s5yC3sB0y66y3w.u648w4C-vwDw3565y5C.69y@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x748.google.com
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

 docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++--
 hw/vfio-user/protocol.h       | 22 +++++++++
 hw/vfio-user/proxy.h          |  2 +
 hw/vfio/vfio-region.h         |  9 +++-
 include/hw/vfio/vfio-device.h | 16 +++++++
 hw/vfio-user/device.c         | 90 ++++++++++++++++++++++++++++++++---
 hw/vfio-user/proxy.c          | 32 +++++++++++--
 hw/vfio/pci.c                 |  2 +
 hw/vfio/region.c              | 51 ++++++++++++++++----
 9 files changed, 269 insertions(+), 26 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


