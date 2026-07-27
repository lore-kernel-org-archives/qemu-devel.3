Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD16C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrf-0008WA-8H; Mon, 27 Jul 2026 15:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrY-0008Vg-Iq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrW-0000Kn-GT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G//nuxmSO865h0x1JAyl73ncMcHKB0EKw7W4t5Qiie8=;
 b=TZYnbG3Wl5LKOSjDfSKnJefpGH26EFLDtJljHFJwg/Awa2SmJaEsVkMUAyVJmpcoJAFj+b
 DwmYdnIFF3jorthM1AVAG9q14lh2v/UH5g0HUNWVsvk3H6NWitcE9n+9LRaMiS7cm/PA0B
 ITbG6uZ1h7R3eFEpTg2JcfeHHkM7PNU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-vXDNQwObMsSxSEwoQk6pvw-1; Mon, 27 Jul 2026 15:19:39 -0400
X-MC-Unique: vXDNQwObMsSxSEwoQk6pvw-1
X-Mimecast-MFC-AGG-ID: vXDNQwObMsSxSEwoQk6pvw_1785179978
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f83999cceso2655591f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179978; x=1785784778; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G//nuxmSO865h0x1JAyl73ncMcHKB0EKw7W4t5Qiie8=;
 b=QsQFF6YppZOqbc4wWSYNOosqhbyOrpPsT+P+t2lptmwnzMdOqOSIR8e/z1gFXRwgiP
 1AfhSHF4gHnDCmbtLc1EXasObJs/RnL2WkJzFJVpCKbTbytukLxcezuyUCJUdf/tHR/s
 DQLhsIFU/3ws2AsADJEgr9jhrIaJCDwfnkEScZ4FcrgpJcjGqvyLLvnzxyBQBc5pki8g
 +7jZIe2QMie5ET19xYOMpg2rGCvh0avJVqJfxptnPDQtWToJfDrVGKBPqPE5RFtVZ3q+
 2VMufui1s59ORr5vDkpC7Pgq8A74Hu7LQcN+DMeUTB2UioiNiC2Zv93KMljFe9mo+EvU
 helw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179978; x=1785784778;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G//nuxmSO865h0x1JAyl73ncMcHKB0EKw7W4t5Qiie8=;
 b=Bb51/wRukQJCbh5HOANgMqUWjheCiGO0nl4/veDtzEz8hQEx2Qdqrhrj8TbAbe0nbA
 sh2Zqh1Um0vvT7H0LgwxFdEK0xJNRvZI+SssL/gFtmglqJtAXgcu3tSgMSvmDbQBXgbF
 lCXOHqVMIhfZGfgcMQNt0W942RsiwOz+RjNXbQcAEKDAR3PLeqG/YqNBb68w0dRleWjO
 5gJpzYsD+MKe9wJm6Eis3oIxo8JqtylgmTIfMab6KULdXH4h4xGyfhn0BMhmJM+dRZrl
 uK2+X/nvTGH1E2ODTz+JEme7g53kaNhxL7NHfniT6pfCOaB5ewlvh5B+Y9yi7pIZDypT
 XYDg==
X-Gm-Message-State: AOJu0YxaKABu/cQWXDuZQJ7IVO/Q0H+Ag3HweUkPCglQ6eEe6snP5sMX
 jrkAho2vdCdPLR1XVHgzpg2nQdJ60wcYoeZ+EM8aOvNpzmACg2D0CyvUFPazTEfP9cyEjvVOy6Z
 EBNduUn11FUM5aUcbcYl/7UTa9Tyer4vC0Rw5BtmI9sHZstIXyH/lk/WfrJea1mi6yTgMyM+is9
 rh5T0ciuwMn+5HymNEAhnruwDC5oZHKeSpkA==
X-Gm-Gg: AR+sD10xkGUIyMlCf2xE+o9KCJUvXJonCjsV5pJgh5Gryw6iQOOlcppALO/L/GZAK9E
 gSk0VO+i62vdSJy9RkNs2axid2zfSvcnVqN0f79cX+RV/HUplPiYfdt8WmkuxNhgMmGmhRWmKy6
 kGzuGlPJew1Ba2Q5LfvpFl1eq/XBqb+IclxV0IsYItv5qJVadPOxG5Gn8qntbQg3paqRkIwEHIy
 /bZILULvu/I2wZ6xLQp0PyMvYqQ/RVa/uR7ty7S8ctloabltYboueBt/jKbU/5l0t5/lZpV/EGq
 o/61QdMNWaS0+k13TsvgfalbGfOatiNoMG7QMk0DQ/g06MtLVtH52vat8ARQOYbhp9OAZuzGDNk
 NXQUmpKTJRWB57qsmxt5ISA==
X-Received: by 2002:a05:6000:2287:b0:47f:95d3:6ff7 with SMTP id
 ffacd0b85a97d-47f9fc92d0amr13043879f8f.14.1785179978402; 
 Mon, 27 Jul 2026 12:19:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2287:b0:47f:95d3:6ff7 with SMTP id
 ffacd0b85a97d-47f9fc92d0amr13043839f8f.14.1785179977824; 
 Mon, 27 Jul 2026 12:19:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm56667211f8f.24.2026.07.27.12.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:37 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 00/30] pci, vhost, virtio, iommu: bugfixes
Message-ID: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

changes from v1:
- added a patch by Stefan
- attribution tag tweaks

The following changes since commit 300438ffbb8d9430cac2fcc15cba6f482b2c0587:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2026-07-24 09:13:49 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 6682ea3391277e732a6d74c5758206ba834e1615:

  virtio: avoid packed vring virtio_queue_empty() infinite loops (CVE-2026-16457) (2026-07-27 15:14:16 -0400)

----------------------------------------------------------------
pci, vhost, virtio, iommu: bugfixes

Fixes all over the place, including a bunch of CVE fixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Clément MATHIEU--DRIF (1):
      intel_iommu: Check address mask before using it in pasid-based iotlb invalidation

GuoHan Zhao (1):
      hw/virtio/vdpa-dev: pass set_config buffer to vhost backend

Haotian Jiang (1):
      hw/cxl: fix OOB access in cxl_doe_cdat_rsp via entry_handle

Laurent Vivier (4):
      hw/virtio: reject zero-length packed indirect descriptor table
      hw/net/virtio-net: Protect from DMA re-entrancy bugs
      hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
      backends/rng: cap request size to avoid oversized allocation

Manos Pitsidianakis (2):
      virtio-snd: check rx buffer descriptor size
      virtio-snd: check for overflow before g_malloc0

Michael S. Tsirkin (17):
      virtio: use masked features with set_features_ex
      virtio-net: fix OOB read in RSC receive path
      virtio-net: fix short frame OOB read in receive_filter()
      libvhost-user: protect against OOB writes in vu_set_inflight_fd
      libvhost-user: protect against OOB vring queue access
      vhost: do not crash on ring map failure
      virtio-scsi: fix SCSIRequest leak on a bad request
      virtio-mmio: fix QUEUE_NUM_MAX
      virtio: fix queue size validation against allocated maximum
      virtio: stop migrating num_default, validate vring.num on load
      virtio: fail early on bad config_len in migration
      vhost-user: assert nregions within limit
      virtio-pmem: wait for flush requests on unrealize
      libvhost-user: validate last_batch_head in vu_check_queue_inflights
      libvhost-user: fix heap overflow in vu_check_queue_inflights
      libvduse: validate vq size
      virtio-iommu: fix OOM due to unbounded call_rcu

Peter Maydell (3):
      hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
      hw/pci-host/q35.c: Factor out creation of SMRAM MRs
      hw/pci-host/q35.c: Avoid early return in mch_write_config()

Stefan Hajnoczi (1):
      virtio: avoid packed vring virtio_queue_empty() infinite loops (CVE-2026-16457)

 include/hw/scsi/scsi.h                    |   1 +
 include/hw/virtio/virtio-bus.h            |   1 +
 include/hw/virtio/virtio-iommu.h          |   1 +
 include/hw/virtio/virtio-mmio.h           |   1 +
 include/hw/virtio/virtio-pmem.h           |   1 +
 include/system/rng.h                      |  14 ++++
 backends/rng.c                            |  21 +++++-
 hw/audio/virtio-snd.c                     |  24 +++++--
 hw/core/machine.c                         |   1 +
 hw/i386/intel_iommu.c                     |   9 +++
 hw/mem/cxl_type3.c                        |   3 +
 hw/net/virtio-net.c                       |  25 ++++++-
 hw/pci-bridge/cxl_upstream.c              |   3 +
 hw/pci-host/q35.c                         | 110 ++++++++++++++++--------------
 hw/scsi/scsi-bus.c                        |   7 ++
 hw/scsi/virtio-scsi.c                     |   2 +
 hw/virtio/vdpa-dev.c                      |   2 +-
 hw/virtio/vhost-user.c                    |   3 +
 hw/virtio/vhost.c                         |   5 +-
 hw/virtio/virtio-iommu.c                  |  29 ++++++++
 hw/virtio/virtio-mmio.c                   |   7 +-
 hw/virtio/virtio-pmem.c                   |  17 ++++-
 hw/virtio/virtio-rng.c                    |   2 +
 hw/virtio/virtio.c                        |  47 +++++++++----
 subprojects/libvduse/libvduse.c           |   5 ++
 subprojects/libvhost-user/libvhost-user.c |  61 ++++++++++++++++-
 26 files changed, 317 insertions(+), 85 deletions(-)


