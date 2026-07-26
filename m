Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDCAC53219
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PH-0007M2-20; Sun, 26 Jul 2026 17:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PF-0007L9-30
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PD-0004Ca-9G
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6q6L1vt+J1HI82hqZAXABf+DBlJdRAGQcg0cVta11LM=;
 b=YvbaU0nk/Vb6mSQ552noTcllnCfYTvF3c1yytKav2xagpivC7/lB95lliHd/KQ6YmAF2KT
 xB7cN8Kz/DTBa0xCmKzAJcDiPd42WmeX18iFRzPRSeDrTmHvDhMDTojJ1gSgTE0IdEgMbH
 TkJ9Kb43FCw8K2nK4X352jGWEKuffxI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-ebT6HF49ORmNFZC0mlmQBg-1; Sun, 26 Jul 2026 17:29:03 -0400
X-MC-Unique: ebT6HF49ORmNFZC0mlmQBg-1
X-Mimecast-MFC-AGG-ID: ebT6HF49ORmNFZC0mlmQBg_1785101342
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so1235540f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101342; x=1785706142; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6q6L1vt+J1HI82hqZAXABf+DBlJdRAGQcg0cVta11LM=;
 b=P0fE0fh6Q8q2f8WcCs8E+FVtZghKIGDYrsBU344V/jOSHpRAl+5heTfnYa9d1yfGV/
 tMvlv9YnJdZI8+yMWNWscJZejHPGxchpxCraeS4gl76PmKehP7uBf75djQtE7wg66wRG
 +zBg5ZL4sQ5E6RP79UDpbuC45iuUh/qkL7Me1rzlA0yxueR9u3DSTZ4gTOQmjO7ikNR2
 e/94EXDNvMpxJStEqR1w4OngZXRK6rrFK6O8LSQSnHSbEnWn3PT3TVQBikIPaHKJi6eq
 kWapYcx4/8edLE79gZQId6PhtulkGaoXfXrvVZfeF131slOyn2ouC4ZqmH89nKEHBOL2
 Aoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101342; x=1785706142;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6q6L1vt+J1HI82hqZAXABf+DBlJdRAGQcg0cVta11LM=;
 b=ZzMWDtAmVDjUTl1SfcaZstj4NGCOiX+ObDXr3ZkKDHUmSLX4jOiAn0H5Pv5vE1bIVH
 TZ1VVBHU25TzdRJrX6Y2MsDLncXTfE5hE3dGupCEJ0k7kWEfyIJncRTKaR4QQPgLAZsR
 8YaET3wIrhs4qQZrHwenHIrU9NOfb/1kVsFCZaoB4FtcCOwel4BhpZQf2AIxp+8uygSe
 Qz5Nl0YNjy9VdXQ8Nmcl/g3Gt4lWD+fgXXxIFeV/rdpQsej+nFs3Ys7O/SjfiF2qsQYP
 wTKo2l/UcCJF+FohDEp52j7ydO6RwZfa/eF3w2X5dRdKa/gwPCmEzFzMhjt26+q/wqBG
 9RaA==
X-Gm-Message-State: AOJu0YxVnAEaF9/NQaFl9HsPquo2nwBolfxGGXO3pdHwd3449Jy5CSJY
 qL6vfjEBhalnxWv3MDdx9j0XHW1ApxRRC6/2u4L7Si4JjHo2ucSgWcwXX5lLqqE2TPA2XZMwZGQ
 kCiMyeIUBVvhqy162HzTYdQSq7301wOqaMGfyVmh47an7FlOi31q/0FZoYj7u9MxRW889jNrcd0
 yEsG6DlaQ5Iz3KtZ8aeAEjKQET5okDC7DFmw==
X-Gm-Gg: AR+sD11OrqWr0UPByGkkUHNVfa7fnQ5nUiQJbHFmCueTiOCcgZRMjLApM5ULd8+76RJ
 5W88V/b1nJ3/4KtxxK6S3DiWXRrE3KRtc2nJobtSF22r/Ojhx6znsgo+oDuQNzDbeqMMCcbkE3N
 M0/2kkgFF7RJ8/hNmu7eloMOB0RnBE3gnz0ALP8lHEwfWzzGla7reMMezWjOV20Lh1qoAMWOhyH
 z1GqW2hM/z/m/C3gi79QebLxEwJx8lx/X1F2LTcFz2XxqGcgEv3zAdL7IDU6hHMOybcnWrdg4mf
 22D7MSlD75EmjcJt7f3n5k8XxKUwOm0jUWiL+SeTnpsfCARjuMOzs6a+IBikgeXicITpPs5amFF
 RQmcTxVev6q4+l9D47JisTw==
X-Received: by 2002:a05:6000:2908:b0:47f:90d0:11e4 with SMTP id
 ffacd0b85a97d-47f9fc8d09dmr7530351f8f.5.1785101341974; 
 Sun, 26 Jul 2026 14:29:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2908:b0:47f:90d0:11e4 with SMTP id
 ffacd0b85a97d-47f9fc8d09dmr7530340f8f.5.1785101341296; 
 Sun, 26 Jul 2026 14:29:01 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm46623161f8f.24.2026.07.26.14.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:28:59 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:28:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/30] pci, vhost, virtio, iommu: bugfixes
Message-ID: <cover.1785101237.git.mst@redhat.com>
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

The following changes since commit cbd42e2b75b23953a9bdb073c8531518b1bd6163:

  Update version for v11.1.0-rc1 release (2026-07-21 13:18:25 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 13342b9c4104f3bf93c2e52e7de4b383971d7bd6:

  backends/rng: cap request size to avoid oversized allocation (2026-07-26 17:26:41 -0400)

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

Michael S. Tsirkin (18):
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
      vmstate: fix type confusion in vmstate_size() for VMSTATE_VBUFFER_UINT64
      libvduse: validate vq size
      virtio-iommu: fix OOM due to unbounded call_rcu

Peter Maydell (3):
      hw/pci-host/q35.c: Always initialize smram-region even if SMM disabled
      hw/pci-host/q35.c: Factor out creation of SMRAM MRs
      hw/pci-host/q35.c: Avoid early return in mch_write_config()

 include/hw/scsi/scsi.h                    |   1 +
 include/hw/virtio/virtio-bus.h            |   1 +
 include/hw/virtio/virtio-iommu.h          |   1 +
 include/hw/virtio/virtio-mmio.h           |   1 +
 include/hw/virtio/virtio-pmem.h           |   1 +
 include/migration/vmstate.h               |   5 +-
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
 hw/virtio/virtio.c                        |  43 ++++++++----
 migration/vmstate.c                       |  31 ++++++++-
 subprojects/libvduse/libvduse.c           |   5 ++
 subprojects/libvhost-user/libvhost-user.c |  61 ++++++++++++++++-
 28 files changed, 345 insertions(+), 89 deletions(-)


