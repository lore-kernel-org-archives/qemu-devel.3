Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB449C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz5kv-0002il-Va; Wed, 26 Aug 2026 01:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3AHOOagsKCnsmZlZmftkZshfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--namangulati.bounces.google.com>)
 id 1wz5ks-0002iR-CU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:00:54 -0400
Received: from mail-qk1-x745.google.com ([2607:f8b0:4864:20::745])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3AHOOagsKCnsmZlZmftkZshfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--namangulati.bounces.google.com>)
 id 1wz5kq-0003sQ-70
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:00:53 -0400
Received: by mail-qk1-x745.google.com with SMTP id
 af79cd13be357-9368f2b7b2bso47883985a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787720449; x=1788325249; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cPdfWkd6h8SdV+xFgEdslPjA8NpsPpYd8894YjdAjH8=;
 b=U++meF/mRf0ERyfVYTQlAodeghfjLRs0eJZyeAhiPt0FHrse/MnEfZ9rLa7WNLnm9p
 ZCNGfEcQ4hOGZ3/eEruLer2+AhwzoV6GlcDplnS1Y/cW/JQ1W8oH4PZ9bEvE2rKJa5Ei
 +1qyO8q6zG5QXeJOx8Ymjn4U9HnGQJK3yksSB6AZ5fDcQe6VAX5Vcc/XhaQmmdJJ0NCe
 EKJeNL1BDaJZ6Y3ai7vNVUZLhC5Uq1FkKzi4x0CzgtvCkFg/vkLsEU08Fwh7Lr4/oO4E
 kSgK1a9YRDLQ8dKKoqFHudkJ5RfUA+ZmyILyQcMSLKgYEXyPOFVh7+jadxcz5H+AARa8
 VgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787720449; x=1788325249;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cPdfWkd6h8SdV+xFgEdslPjA8NpsPpYd8894YjdAjH8=;
 b=JMEkPbo+Jh7SFfj46o4e9M07XvlUZhydY7BXrLLOtZcdEgBuyox4o5w64xz3liH8X0
 7zHal1Jj6rJPwoVtCgo2686BQmuCvC5T0sTVMrvcT2ftd2CBFEtHgG7GlhGWLaazrV9X
 14dYpSgovJ94bc8UUOuUlfapllPliKUmcMDc7NupZSPBDJ8rdoOkUXRxIg7yqictG54C
 xhBqIO73Mm2XqFSaGlagEnI39HvxnsQZfsVfsBXBunnuHbvQuIcgAvw3+mUUofMYpdKm
 DLgiYsY+YfnlprPhKjpLfODs1XpccnK97084jt8xvLiIklAR0yTmJM+WAQ6T9Js6oFY/
 NQsA==
X-Gm-Message-State: AFuF++kIn6zvXdM86YPTJhgU7w5isPNhq/iXhzYysztFmwtIb4vMy2AN
 Dv/39XnmH8mawcbZy/0VL5Yr+m9IJF7lfTdt/nv7Fj1/bYu1/xt2qXK7U6B/c5lvInlo4U2wu7S
 Ol9xvfCam01Ety4m4Q/CCuiNkyRfvuFw8BUKR1YfqLeintsblX2Q1R5ya2VWdYj8sLoIQexEJru
 Xoc867eTzEqptzF+7q4E7e2YlEM58jbe8IrVzpWntrMpuvHM4wFs8BiK+emzPnRQ==
X-Received: from qkbt3.prod.google.com ([2002:a05:620a:1283:b0:936:2e65:7241])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:561b:b0:92e:54b3:3f86 with SMTP id
 af79cd13be357-937803e0fedmr292811985a.29.1787720448778; 
 Tue, 25 Aug 2026 22:00:48 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:00:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826050039.2068138-1-namangulati@google.com>
Subject: [PATCH v2 0/3] vfio-user: support multiple FDs backing region mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::745;
 envelope-from=3AHOOagsKCnsmZlZmftkZshfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x745.google.com
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
Changes from RFC:
  - Refactored the get_region_info callback to keep vbasedev constant
    and take in a VFIORegionFDs* out parameter to store the received fds.
  - Link to RFC: https://lore.kernel.org/qemu-devel/20260811233930.401797-1-namangulati@google.com
---

Naman Gulati (3):
  vfio-user: add multi-fd region mmap capability
  vfio: mmap sparse regions backed by multiple FDs
  vfio-user: implement client support for multi-fd region mmap

 docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++++++++++--
 hw/vfio-user/device.c         | 66 ++++++++++++++++++++++++++++++--
 hw/vfio-user/protocol.h       | 20 ++++++++++
 hw/vfio/device.c              | 49 ++++++++++++++----------
 hw/vfio/region.c              | 41 ++++++++++++++++----
 hw/vfio/vfio-region.h         |  8 ++++
 include/hw/vfio/vfio-device.h | 32 ++++++++++++++--
 7 files changed, 249 insertions(+), 38 deletions(-)

-- 
2.55.0.860.g4b6b3295ed-goog


