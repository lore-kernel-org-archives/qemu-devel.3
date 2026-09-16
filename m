Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D606AC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yHF-00036o-Ts; Wed, 16 Sep 2026 18:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3dhqragsKCrMgTfTgZneTmbZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--namangulati.bounces.google.com>)
 id 1x6yHD-00036J-O2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:51 -0400
Received: from mail-qt1-x848.google.com ([2607:f8b0:4864:20::848])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3dhqragsKCrMgTfTgZneTmbZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--namangulati.bounces.google.com>)
 id 1x6yHB-0006zI-5B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:50 -0400
Received: by mail-qt1-x848.google.com with SMTP id
 d75a77b69052e-530d912b923so2449571cf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789598326; x=1790203126; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=doCyEQTeIQHs6Zbuy7ciifWedsJBo8WrM+h2WpBaKII=;
 b=KSweHOd8IdLDrEWd9MfN+HOK3Nfb8dKGPMZvKnR9K9dpLFmXS+aa6ZvYw6js3SAyLq
 yV8bbI/+yRUUizE+b+0/biGvwtaoUImf1MpOOlqRmUPOPBbZgPWlIF7L2/Dq1UwulGcV
 BIPda/TOYHcuYzVsBNQQUgWvNd8YGC5z17cvv9o0Sczmb3oQM83Skx1umIT5HbWIiPeX
 ckcxkVNOcqS3RqHnCFjRJtpdmLTKZMqDqgbiPYQZZ2MxmlYlSzNDU8nloNOg8sixxQh9
 aXeUrICs0xEaIgHcipCk1HG/mieu28HbN5M+Kc7bsqcmOXOEDDkBRC0xyplbxeDHxRR+
 JkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789598326; x=1790203126;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=doCyEQTeIQHs6Zbuy7ciifWedsJBo8WrM+h2WpBaKII=;
 b=gPS4Ju9o8hdZnPSNkJd27eNDd7IXwSOjN1NkH5EJnwtc/02fX4NgFGohuEDInvMyG2
 GDwhoWUV6qXNN8gkhjJJ6zJs4RfppF2b0t73ngEqKRocxcIVHcJOVv6U3vZxUPpOY+Zv
 axnEO/gjWRnIuFowX5JlIqJ0rJoZDc2N47PkkQMQxd7Pi+X54PSnoueiqkujnh4sQb2L
 0nA0YUqPHNt2eSDUruwgMi9Dk1A6C+ZJ/cV/Z45NWJh/r8Jeqq21YM6kxt21l5OzVh5S
 V2G6pSzJtGJVjVPBDLyStpMLkY+sLcxafNnxyMd9qHkpGDp/bAeSdtkFhzUl4qLcP4j0
 Kr4A==
X-Gm-Message-State: AFuF++kE2DE26Ed4rCYC6EmkDkI5LKogEQ5wy3az35qQFvtjqIdTkQLs
 jSev0IfxPlS2O2mwc4F2lM9syT7LbDkCTtd7xUjYfCAjxYBJqmPgPLsnfklTfS+Xlsg/egwzEK1
 lwOmjqHQk4hjnIJMd16Bwp3PNEMFTxpv4lerXitpbZCi1NuzbKASSeEtoUBd/h3gf9hqLyXi7/d
 iu/ciiVzyf+T8wZIJKbAChniasvV/QxEelS8YAjou3zgbrKvcOkKtmJB263kfrIQ==
X-Received: from qtbma1-n2.prod.google.com
 ([2002:a05:622a:8601:20b0:530:ebb1:7580])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:e457:10b0:532:85ae:5929 with SMTP id
 d75a77b69052e-53285ae5b45mr43643141cf.62.1789598326255; 
 Wed, 16 Sep 2026 15:38:46 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:38:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916223843.3995552-1-namangulati@google.com>
Subject: [PATCH v3 0/4] vfio-user: support multiple FDs backing region mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::848;
 envelope-from=3dhqragsKCrMgTfTgZneTmbZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x848.google.com
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
2.55.0.1082.g2b9226bbc0-goog


